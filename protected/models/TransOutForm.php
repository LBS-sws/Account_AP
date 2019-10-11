<?php

class TransOutForm extends CFormModel
{
	public $id;
	public $trans_dt;
	public $trans_type_code;
	public $acct_id;
	public $trans_desc;
	public $amount;
	public $status;
	public $status_desc;
	public $posted;
	public $city;
	
	public $payer_type = 'O';
	public $payer_id;
	public $payer_name;
	public $cheque_no;
	public $invoice_no;
	public $acct_code;
	public $acct_code_desc;
	public $item_code;
	public $citem_desc;
	public $int_fee;
	public $reason;
	public $req_ref_no;
	
	private $dyn_fields = array(
							'payer_type',
							'payer_id',
							'payer_name',
							'acct_code',
							'item_code',
							'cheque_no',
							'invoice_no',
							'int_fee',
							'reason',
							'req_ref_no',
						);
	
	public $no_of_attm = array(
							'trans'=>0
						);
	public $docType = 'TRANS';
	public $docMasterId = 0;
	public $files;
	public $removeFileId = 0;

	public function init() {
		$this->trans_dt = date('Y/m/d');
		$this->trans_type_code = '';
		$this->acct_id = 0; //$this->getDefaultAccountValue('CASH');
		$this->city = Yii::app()->user->city();
		parent::init();
	}
	
	public function attributeLabels()
	{
		return array(
			'trans_dt'=>Yii::t('trans','Trans. Date'),
			'trans_type_code'=>Yii::t('trans','Trans. Type'),
			'acct_id'=>Yii::t('trans','Account'),
			'payer_name'=>Yii::t('trans','Payee'),
			'trans_desc'=>Yii::t('trans','Remarks'),
			'amount'=>Yii::t('trans','Amount'),
			'city_name'=>Yii::t('misc','City'),
			'cheque_no'=>Yii::t('trans','Cheque No.'),
			'invoice_no'=>Yii::t('trans','China Invoice No.'),
			'acct_code'=>Yii::t('trans','Account Code'),
			'item_code'=>Yii::t('trans','Charge Item'),
			'citem_desc'=>Yii::t('trans','Charge Item'),
			'status_desc'=>Yii::t('trans','Status'),
			'int_fee'=>Yii::t('trans','Integrated Fee'),
			'reason'=>Yii::t('trans','Reason'),
			'req_ref_no'=>Yii::t('trans','Request Ref. No.'),
			'city'=>Yii::t('trans','City'),
		);
	}

	public function rules()
	{
		return array(
			array('trans_type_code, trans_dt, acct_id, payer_name, payer_type, amount','required'),
			array('id, trans_desc, payer_id, cheque_no, invoice_no, status,acct_code,item_code, citem_desc
					no_of_attm, docType, files, removeFileId, status_desc, city, int_fee, reason, req_ref_no
				','safe'), 
		);
	}

	public function validateTransDate($attribute, $params) {
		$id = $this->acct_id;
		$sql = "select trans_dt from acc_trans where acct_id=$id and trans_type_code='OPEN' and status='A'";
		$row = Yii::app()->db->createCommand($sql)->queryRow();
		if ($row!==false) {
			$dt0 = General::toDate($row['trans_dt']);
			$dt1 = General::toDate($this->$attribute);
			if ($dt0 > $dt1) $this->addError($attribute, Yii::t('transin','Invalid transaction date (eariler than openning balance date)'));
		}
	}

	public function retrieveData($index)
	{
		$suffix = Yii::app()->params['envSuffix'];
		$sql = "select a.*, b.trans_id ,
				docman$suffix.countdoc('trans',id) as transcountdoc
				from acc_trans a left outer join acc_trans_audit_dtl b on a.id=b.trans_id 
				where a.id=$index";
		$rows = Yii::app()->db->createCommand($sql)->queryAll();
		if (count($rows) > 0)
		{
			foreach ($rows as $row)
			{
				$this->id = $row['id'];
				$this->trans_dt = General::toDate($row['trans_dt']);
				$this->trans_type_code = $row['trans_type_code'];
				$this->acct_id = $row['acct_id'];
				$this->trans_desc = $row['trans_desc'];
				$this->amount = $row['amount'];
				$this->status = $row['status'];
				$this->status_desc = General::getTransStatusDesc($row['status']);
				$this->posted = (!empty($row['trans_id']));
				$this->city = $row['city'];
				$this->no_of_attm['trans'] = $row['transcountdoc'];
				break;
			}
		}
		
		$sql = "select * from acc_trans_info where trans_id=$index";
		$rows = Yii::app()->db->createCommand($sql)->queryAll();
		if (count($rows) > 0) {
			foreach ($rows as $row) {
				$dynfldid = $row['field_id'];
				if (in_array($dynfldid,$this->dyn_fields)) {
					$this->$dynfldid = $row['field_value'];
				}
			}
		}

		$acctcodelist = General::getAcctCodeList($this->city);
		$acctitemlist = General::getAcctItemList($this->city);
		if (isset($acctcodelist[$this->acct_code])) $this->acct_code_desc = $acctcodelist[$this->acct_code];
		if (isset($acctitemlist[$this->item_code])) $this->citem_desc = $acctitemlist[$this->item_code];

		return true;
	}
	
	public function saveData()
	{
		$connection = Yii::app()->db;
		$transaction=$connection->beginTransaction();
		try {
			$this->saveTrans($connection);
			$this->saveInfo($connection);
			$transaction->commit();
		}
		catch(Exception $e) {
			$transaction->rollback();
			throw new CHttpException(404,'Cannot update.'.$e->getMessage());
		}
	}

	protected function saveAccount(&$connection)
	{
		$sql = '';
		switch ($this->scenario) {
			case 'delete':
				$sql = "update acc_account set 
					acct_type_id = :acct_type_id, 
					acct_no = :acct_no,
					acct_name = :acct_name,
					bank_name = :bank_name, 
					remarks = :remarks,
					luu = :luu
					where id = :id and city=:city";
				break;
			case 'new':
				$sql = "insert into acc_account(
						acct_type_id, acct_no, acct_name, bank_name, remarks, city, luu, lcu) values (
						:acct_type_id, :acct_no, :acct_name, :bank_name, :remarks, :city, :luu, :lcu)";
				break;
			case 'edit':
				$sql = "update acc_account set 
					acct_type_id = :acct_type_id, 
					acct_no = :acct_no,
					acct_name = :acct_name,
					bank_name = :bank_name, 
					remarks = :remarks,
					luu = :luu
					where id = :id and city=:city";
				break;
		}

		$city = $this->city;	//Yii::app()->user->city();
		$uid = Yii::app()->user->id;

		$command=$connection->createCommand($sql);
		if (strpos($sql,':id')!==false)
			$command->bindParam(':id',$this->id,PDO::PARAM_INT);
		if (strpos($sql,':acct_type_id')!==false)
			$command->bindParam(':acct_type_id',$this->acct_type_id,PDO::PARAM_INT);
		if (strpos($sql,':acct_no')!==false)
			$command->bindParam(':acct_no',$this->acct_no,PDO::PARAM_STR);
		if (strpos($sql,':acct_name')!==false)
			$command->bindParam(':acct_name',$this->acct_name,PDO::PARAM_STR);
		if (strpos($sql,':bank_name')!==false)
			$command->bindParam(':bank_name',$this->bank_name,PDO::PARAM_STR);
		if (strpos($sql,':remarks')!==false)
			$command->bindParam(':remarks',$this->remarks,PDO::PARAM_STR);
		if (strpos($sql,':city')!==false)
			$command->bindParam(':city',$city,PDO::PARAM_STR);
		if (strpos($sql,':luu')!==false)
			$command->bindParam(':luu',$uid,PDO::PARAM_STR);
		if (strpos($sql,':lcu')!==false)
			$command->bindParam(':lcu',$uid,PDO::PARAM_STR);
		$command->execute();

		return true;
	}

	protected function saveTrans(&$connection) {
		$sql = '';
		switch ($this->scenario) {
			case 'delete':
				$sql = "update acc_trans set 
						status = 'V', 
						luu = :luu
						where id = :id and city = :city 
					";
				break;
			case 'new':
				$sql = "insert into acc_trans(
						trans_dt, trans_type_code, acct_id,	trans_desc, amount,	status, city, luu, lcu) values (
						:trans_dt, :trans_type_code, :acct_id, :trans_desc, :amount, 'A', :city, :luu, :lcu)";
				break;
			case 'edit':
				$sql = "update acc_trans set 
						amount = :amount, 
						trans_dt = :trans_dt,
						trans_type_code = :trans_type_code,
						acct_id = :acct_id,
						trans_desc = :trans_desc,
						luu = :luu
						where id = :id and city = :city
					";
				break;
		}

		$city = $this->city;	//Yii::app()->user->city();
		$uid = Yii::app()->user->id;

		$command=$connection->createCommand($sql);
		if (strpos($sql,':id')!==false)
			$command->bindParam(':id',$this->id,PDO::PARAM_INT);
		if (strpos($sql,':trans_dt')!==false) {
			$tdate = General::toMyDate($this->trans_dt);
			$command->bindParam(':trans_dt',$tdate,PDO::PARAM_STR);
		}
		if (strpos($sql,':trans_type_code')!==false)
			$command->bindParam(':trans_type_code',$this->trans_type_code,PDO::PARAM_STR);
		if (strpos($sql,':acct_id')!==false)
			$command->bindParam(':acct_id',$this->acct_id,PDO::PARAM_INT);
		if (strpos($sql,':trans_desc')!==false)
			$command->bindParam(':trans_desc',$this->trans_desc,PDO::PARAM_STR);
		if (strpos($sql,':amount')!==false) {
			$amt = General::toMyNumber($this->amount);
			$command->bindParam(':amount',$amt,PDO::PARAM_STR);
		}
		if (strpos($sql,':city')!==false)
			$command->bindParam(':city',$city,PDO::PARAM_STR);
		if (strpos($sql,':luu')!==false)
			$command->bindParam(':luu',$uid,PDO::PARAM_STR);
		if (strpos($sql,':lcu')!==false)
			$command->bindParam(':lcu',$uid,PDO::PARAM_STR);
		$command->execute();

		if ($this->scenario=='new')
			$this->id = Yii::app()->db->getLastInsertID();
		return true;
	}

	protected function saveInfo(&$connection) {
		$sql = '';
		switch ($this->scenario) {
			case 'new':
				$sql = "replace into acc_trans_info(
						trans_id, field_id, field_value, luu, lcu) values (
						:id, :field_id, :field_value, :luu, :lcu)";
				break;
			case 'edit' || 'delete':
				$sql = "insert into acc_trans_info(
						trans_id, field_id, field_value, luu, lcu) values (
						:id, :field_id, :field_value, :luu, :lcu)
						on duplicate key update
						field_value = :field_value, luu = :luu
					";
				break;
		}

		$city = $this->city;	//Yii::app()->user->city();
		$uid = Yii::app()->user->id;

		if ($this->scenario=='delete') {
			$command=$connection->createCommand($sql);
			if (strpos($sql,':id')!==false)
				$command->bindParam(':id',$this->id,PDO::PARAM_INT);
			if (strpos($sql,':field_id')!==false) {
				$field_id = 'reason';
				$command->bindParam(':field_id',$field_id,PDO::PARAM_STR);
			}
			if (strpos($sql,':field_value')!==false) {
				$value = $this->reason;
				$command->bindParam(':field_value',$value,PDO::PARAM_STR);
			}
			if (strpos($sql,':lcu')!==false)
				$command->bindParam(':lcu',$uid,PDO::PARAM_STR);
			if (strpos($sql,':luu')!==false)
				$command->bindParam(':luu',$uid,PDO::PARAM_STR);
			$command->execute();
		} else {
			foreach ($this->dyn_fields as $dynfldid) {
				if (isset($this->$dynfldid)) {
					$command=$connection->createCommand($sql);
					if (strpos($sql,':id')!==false)
						$command->bindParam(':id',$this->id,PDO::PARAM_INT);
					if (strpos($sql,':field_id')!==false)
						$command->bindParam(':field_id',$dynfldid,PDO::PARAM_STR);
					if (strpos($sql,':field_value')!==false) {
						$value = $this->$dynfldid;
						$command->bindParam(':field_value',$value,PDO::PARAM_STR);
					}
					if (strpos($sql,':lcu')!==false)
						$command->bindParam(':lcu',$uid,PDO::PARAM_STR);
					if (strpos($sql,':luu')!==false)
						$command->bindParam(':luu',$uid,PDO::PARAM_STR);
					$command->execute();
				}
			}
		}

		return true;
	}
	
	protected function getDefaultAccountValue($type) {
		$rtn = '';
		$sql = "select a.id from acc_account a, acc_account_type b 
				where a.acct_type_id=b.id and b.rpt_cat='$type'
			";
		$row = Yii::app()->db->createCommand($sql)->queryRow();
		if ($row !== false) {
			$rtn = $row['id'];
		}
		return $rtn;
	}
		
	public function voidRight() {
		return Yii::app()->user->validFunction('CN05');
	}

	public function isReadOnly() {
		return true;
	}
}
