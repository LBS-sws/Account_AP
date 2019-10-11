<?php

class CopysettingForm extends CFormModel
{
	public $city;

	/**
	 * Declares the validation rules.
	 * The rules state that username and password are required,
	 * and password needs to be authenticated.
	 */
	public function rules()
	{
		return array(
			// username and password are required
			array('city', 'required'),
		);
	}

	/**
	 * Declares attribute labels.
	 */
	public function attributeLabels()
	{
		return array(
			'city'=>Yii::t('trans','City'),
		);
	}
	
	public function copy() {
		$connection = Yii::app()->db;
		$transaction=$connection->beginTransaction();
		try {
			$this->copyAccountType($connection);
			$this->copyTransType($connection);
			$this->copyAccountCode($connection);
			$this->copyAccountItem($connection);

			$transaction->commit();
		}
		catch(Exception $e) {
			$transaction->rollback();
			throw new CHttpException(404,'Cannot update.'.$e->getMessage());
		}
	}	
	
	protected function copyAccountType(&$connection) {
		$uid = Yii::app()->user->id;
		$cityto = Yii::app()->user->city();

		$sql = "insert into acc_account_type(acct_type_desc, rpt_cat, city, lcu, luu)
				select acct_type_desc, rpt_cat, :cityto, :uid, :uid from acc_account_type
				where city = :cityfrom
			";
		$command=$connection->createCommand($sql);
		if (strpos($sql,':cityfrom')!==false)
			$command->bindParam(':cityfrom',$this->city,PDO::PARAM_STR);
		if (strpos($sql,':cityto')!==false)
			$command->bindParam(':cityto',$cityto,PDO::PARAM_STR);
		if (strpos($sql,':uid')!==false)
			$command->bindParam(':uid',$uid,PDO::PARAM_STR);
		$command->execute();
		
		return true;
	}

	protected function copyTransType(&$connection) {
		$uid = Yii::app()->user->id;
		$cityto = Yii::app()->user->city();

		$sql = "insert into acc_trans_type(trans_type_code, trans_type_desc, adj_type, trans_cat, counter_type, city, lcu, luu)
				select a.trans_type_code, a.trans_type_desc, a.adj_type, a.trans_cat, a.counter_type, :cityto, :uid, :uid 
				from acc_trans_type a
				where a.city = :cityfrom
				on duplicate key update 
					trans_type_desc = a.trans_type_desc, 
					adj_type = a.adj_type,
					trans_cat = a.trans_cat,
					counter_type = a.counter_type,
					luu = :uid
			";
		$command=$connection->createCommand($sql);
		if (strpos($sql,':cityfrom')!==false)
			$command->bindParam(':cityfrom',$this->city,PDO::PARAM_STR);
		if (strpos($sql,':cityto')!==false)
			$command->bindParam(':cityto',$cityto,PDO::PARAM_STR);
		if (strpos($sql,':uid')!==false)
			$command->bindParam(':uid',$uid,PDO::PARAM_STR);
		$command->execute();
		
		return true;
	}
	
	protected function copyAccountCode(&$connection) {
		$uid = Yii::app()->user->id;
		$cityto = Yii::app()->user->city();

		$sql = "insert into acc_account_code(code, name, rpt_cat, city, lcu, luu)
				select a.code, a.name, a.rpt_cat, :cityto, :uid, :uid 
				from acc_account_code a
				where a.city = :cityfrom
				on duplicate key update 
					name = a.name, 
					rpt_cat = a.rpt_cat,
					luu = :uid
			";
		$command=$connection->createCommand($sql);
		if (strpos($sql,':cityfrom')!==false)
			$command->bindParam(':cityfrom',$this->city,PDO::PARAM_STR);
		if (strpos($sql,':cityto')!==false)
			$command->bindParam(':cityto',$cityto,PDO::PARAM_STR);
		if (strpos($sql,':uid')!==false)
			$command->bindParam(':uid',$uid,PDO::PARAM_STR);
		$command->execute();
		
		return true;
	}

	protected function copyAccountItem(&$connection) {
		$uid = Yii::app()->user->id;
		$cityto = Yii::app()->user->city();

		$sql = "insert into acc_account_item(code, name, item_type, acct_code, city, lcu, luu)
				select a.code, a.name, a.item_type, a.acct_code, :cityto, :uid, :uid 
				from acc_account_item a
				where a.city = :cityfrom
				on duplicate key update 
					name = a.name, 
					item_type = a.item_type,
					acct_code = a.acct_code,
					luu = :uid
			";
		$command=$connection->createCommand($sql);
		if (strpos($sql,':cityfrom')!==false)
			$command->bindParam(':cityfrom',$this->city,PDO::PARAM_STR);
		if (strpos($sql,':cityto')!==false)
			$command->bindParam(':cityto',$cityto,PDO::PARAM_STR);
		if (strpos($sql,':uid')!==false)
			$command->bindParam(':uid',$uid,PDO::PARAM_STR);
		$command->execute();
		
		return true;
	}
}
