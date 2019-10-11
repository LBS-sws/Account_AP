<?php

class AcctCodeForm extends CFormModel
{
	/* User Fields */
	public $code;
	public $name;
	public $rpt_cat;

	/**
	 * Declares customized attribute labels.
	 * If not declared here, an attribute would have a label that is
	 * the same as its name with the first letter in upper case.
	 */
	public function attributeLabels()
	{
		return array(
			'code'=>Yii::t('code','Code'),
			'name'=>Yii::t('code','Description'),
			'rpt_cat'=>Yii::t('code','Type'),
		);
	}

	/**
	 * Declares the validation rules.
	 */
	public function rules()
	{
		return array(
			array('code, name','required'),
			array('rpt_cat','safe'),
//			array('code','unique','allowEmpty'=>false,
//					'attributeName'=>'code',
//					'caseSensitive'=>false,
//					'className'=>'AcctItem',
//					'on'=>'new'
//				),

		);
	}

	public function retrieveData($index, $city)
	{
		$sql = "select * from acc_account_code where code='$index' and city='$city'";
		$row = Yii::app()->db->createCommand($sql)->queryRow();
		if ($row!==false) {
			$this->code = $row['code'];
			$this->name = $row['name'];
			$this->rpt_cat = $row['rpt_cat'];
		}
		return true;
	}
	
	public function saveData()
	{
		$connection = Yii::app()->db;
		$transaction=$connection->beginTransaction();
		try {
			$this->saveAcctCode($connection);
			$transaction->commit();
		}
		catch(Exception $e) {
			$transaction->rollback();
			throw new CHttpException(404,'Cannot update.');
		}
	}

	protected function saveAcctCode(&$connection)
	{
		$sql = '';
		switch ($this->scenario) {
			case 'delete':
				$sql = "delete from acc_account_code where code = :code and city = :city";
				break;
			case 'new':
				$sql = "insert into acc_account_code(
						code, name, rpt_cat, city, luu, lcu) values (
						:code, :name, :rpt_cat, :city, :luu, :lcu)";
				break;
			case 'edit':
				$sql = "update acc_account_code set 
					name = :name, 
					rpt_cat = :rpt_cat,
					luu = :luu
					where code = :code and city = :city";
				break;
		}

		$uid = Yii::app()->user->id;
		$city = Yii::app()->user->city();

		$command=$connection->createCommand($sql);
		if (strpos($sql,':code')!==false)
			$command->bindParam(':code',$this->code,PDO::PARAM_STR);
		if (strpos($sql,':name')!==false)
			$command->bindParam(':name',$this->name,PDO::PARAM_STR);
		if (strpos($sql,':rpt_cat')!==false)
			$command->bindParam(':rpt_cat',$this->rpt_cat,PDO::PARAM_STR);
		if (strpos($sql,':city')!==false)
			$command->bindParam(':city',$city,PDO::PARAM_STR);
		if (strpos($sql,':luu')!==false)
			$command->bindParam(':luu',$uid,PDO::PARAM_STR);
		if (strpos($sql,':lcu')!==false)
			$command->bindParam(':lcu',$uid,PDO::PARAM_STR);
		$command->execute();

		return true;
	}

	public function isReadOnly() {
		return ($this->scenario=='view');
	}
}
