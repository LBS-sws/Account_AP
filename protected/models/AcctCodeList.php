<?php

class AcctCodeList extends CListPageModel
{
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
	
	public function retrieveDataByPage($pageNum=1)
	{
//		$city = Yii::app()->user->city_allow();
		$city = Yii::app()->user->city();
		$sql1 = "select a.* 
				from acc_account_code a 
				where a.city = '$city' 
			";
		$sql2 = "select count(a.code)
				from acc_account_code a 
				where a.city = '$city'  
			";
		$clause = "";
		if (!empty($this->searchField) && !empty($this->searchValue)) {
			$svalue = str_replace("'","\'",$this->searchValue);
			switch ($this->searchField) {
				case 'code':
					$clause .= General::getSqlConditionClause('a.code',$svalue);
					break;
				case 'name':
					$clause .= General::getSqlConditionClause('a.name',$svalue);
					break;
				case 'type':
					$clause .= General::getSqlConditionClause('a.rpt_cat',$svalue);
					break;
			}
		}
		
		$order = "";
		if (!empty($this->orderField)) {
			switch ($this->orderField) {
				case 'rtp_cat': $orderf = 'a.rpt_cat'; break;
				default: $orderf = $this->orderField; break;
			}
			$order .= " order by ".$orderf." ";
			if ($this->orderType=='D') $order .= "desc ";
		}

		$sql = $sql2.$clause;
		$this->totalRow = Yii::app()->db->createCommand($sql)->queryScalar();
		
		$sql = $sql1.$clause.$order;
		$sql = $this->sqlWithPageCriteria($sql, $this->pageNum);
		$records = Yii::app()->db->createCommand($sql)->queryAll();
		
		$list = array();
		$this->attr = array();
		if (count($records) > 0) {
			foreach ($records as $k=>$record) {
				$this->attr[] = array(
					'code'=>$record['code'],
					'name'=>$record['name'],
					'rpt_cat'=>$record['rpt_cat'],
					'city'=>$record['city'],
				);
			}
		}
		$session = Yii::app()->session;
		$session['criteria_xc10'] = $this->getCriteria();
		return true;
	}

}
