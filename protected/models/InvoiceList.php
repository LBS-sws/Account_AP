<?php

class InvoiceList extends CListPageModel
{
	/**
	 * Declares customized attribute labels.
	 * If not declared here, an attribute would have a labe l that is
	 * the same as its name with the first letter in upper case.
	 */
	public function attributeLabels()
	{
		return array(	
			'number'=>Yii::t('invoice','Number'),
			'dates'=>Yii::t('invoice','Date'),
			'customer_account'=>Yii::t('invoice','Customer Account'),
			'invoice_company'=>Yii::t('invoice','Invoice Company'),

		);
	}
	
	public function retrieveDataByPage($pageNum=1)
	{
		$suffix = Yii::app()->params['envSuffix'];
		$city = Yii::app()->user->city_allow();
		$sql1 = "select *  from acc_invoice where city in ($city) 
			";
		$sql2 = "select count(id) from acc_invoice where city in ($city) 
			";
		$clause = "";
		if (!empty($this->searchField) && !empty($this->searchValue)) {
			$svalue = str_replace("'","\'",$this->searchValue);
			switch ($this->searchField) {
				case 'dates':
					$clause .= General::getSqlConditionClause('dates',$svalue);
					break;
				case 'customer_account':
					$clause .= General::getSqlConditionClause('customer_account',$svalue);
					break;
				case 'invoice_company':
					$clause .= General::getSqlConditionClause('invoice_company',$svalue);
					break;
			}
		}

		$order = "";
		if (!empty($this->orderField)) {
			$order .= " order by ".$this->orderField." ";
			if ($this->orderType=='D') $order .= "desc ";
		}else{
		    $order ="order by dates desc";
        }
		$sql = $sql2.$clause;
		$this->totalRow = Yii::app()->db->createCommand($sql)->queryScalar();
		$sql = $sql1.$clause.$order;

		$sql = $this->sqlWithPageCriteria($sql, $this->pageNum);
		$records = Yii::app()->db->createCommand($sql)->queryAll();
//		print_r($sql);
		$list = array();
		$this->attr = array();
		if (count($records) > 0) {
			foreach ($records as $k=>$record) {
                $dates = General::toMyDate($record['dates']);
                $timestrap=strtotime($dates);
                $number=date('ym',$timestrap);
                $number=($number*10000000)+$record['id'];
				$this->attr[] = array(
					'id'=>$record['id'],
					'number'=>$number,
					'dates'=>$dates,
					'customer_account'=>$record['customer_account'],
					'invoice_company'=>$record['invoice_company'],
				);
			}
		}
		$session = Yii::app()->session;
		$session['criteria_xi01'] = $this->getCriteria();
		return true;
	}

}
