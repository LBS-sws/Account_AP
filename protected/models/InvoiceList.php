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

	public function retrieveExportData()
	{
		$suffix = Yii::app()->params['envSuffix'];
		$city = Yii::app()->user->city_allow();
		$sql1 = "
			SELECT a.*, b.name as city_name, c.product_code, c.description, c.quantity, c.unit_price, c.amount 
			FROM acc_invoice_type c 
			LEFT JOIN acc_invoice a ON a.id = c.invoice_id
            LEFT JOIN security$suffix.sec_city b ON a.city = b.code
            where a.city in ($city) 
		";
		$clause = "";
		if (!empty($this->searchField) && !empty($this->searchValue)) {
			$svalue = str_replace("'","\'",$this->searchValue);
			switch ($this->searchField) {
				case 'dates':
					$clause .= General::getSqlConditionClause('a.dates',$svalue);
					break;
				case 'customer_account':
					$clause .= General::getSqlConditionClause('a.customer_account',$svalue);
					break;
				case 'invoice_company':
					$clause .= General::getSqlConditionClause('a.invoice_company',$svalue);
					break;
			}
		}

	    $order ="order by a.dates desc, c.id";

		$sql = $sql1.$clause.$order;
		$records = Yii::app()->db->createCommand($sql)->queryAll();
		$list = array();
		$this->attr = array();
		if (count($records) > 0) {
			foreach ($records as $k=>$record) {
				$record["sub_total"]=is_numeric($record['amount'])?floatval($record['amount']):0;//小计
				$disc=is_numeric($record['disc'])?floatval($record['disc']):0;//税率
				$record["disc"]=($disc*100)."%";//税率
				$record["gst"]=$disc*$record["sub_total"];//税
				$record["total_amount"]=$record["gst"]+$record["sub_total"];//合计
				$this->attr[] = array(
					'number'=>$record['number'],
					'dates'=>date('Y/m/d',strtotime($record['dates'])),
					'payment_term'=>$record['payment_term'],
					'customer_po_no'=>$record['customer_po_no'],
					'customer_account'=>$record['customer_account'],
					'salesperson'=>$record['salesperson'],
					'sales_order_no'=>$record['sales_order_no'],
					'sales_order_date'=>date('Y/m/d',strtotime($record['sales_order_date'])),
					'ship_via'=>$record['ship_via'],
					'invoice_company'=>$record['invoice_company'],
					'invoice_address'=>$record['invoice_address'],
					'invoice_tel'=>$record['invoice_tel'],
					'delivery_company'=>$record['delivery_company'],
					'delivery_address'=>$record['delivery_address'],
					'delivery_tel'=>$record['delivery_tel'],
					'generated_by'=>$record['generated_by'],
					'city_name'=>$record['city_name'],
					
					'product_code'=>$record['product_code'],
					'description'=>$record['description'],
					'quantity'=>$record['quantity'],
					'unit_price'=>$record['unit_price'],
					'amount'=>$record['amount'],
					
					'disc'=>$record['disc'],//税率
					'sub_total'=>$record['sub_total'],//小计
					'gst'=>$record['gst'],//税
					'total_amount'=>$record['total_amount'],//合计
				);
			}
		}
		$session = Yii::app()->session;
		$session['criteria_xi01'] = $this->getCriteria();
		return true;
	}

}
