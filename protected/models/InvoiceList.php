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
		$sql1 = "select a.*  from acc_invoice a where a.city in ($city) 
			";
		$sql2 = "select count(a.id) from acc_invoice a where a.city in ($city) 
			";
		$clause = "";
        if (!empty($this->searchField) && (!empty($this->searchValue) || $this->isAdvancedSearch())) {
            if ($this->isAdvancedSearch()) {
                $clause = $this->buildSQLCriteria();
            } else {
                $svalue = str_replace("'","\'",$this->searchValue);
                $columns = $this->searchColumns();
                $clause .= General::getSqlConditionClause($columns[$this->searchField],$svalue);
            }
        }
        $clause .= $this->getDateRangeCondition('a.dates');

		$order = "";
		if (!empty($this->orderField)) {
			switch ($this->searchField) {
				case 'number':
					$order .= " order by a.dates ";
					break;
				case 'dates':
					$order .= " order by a.dates ";
					break;
				case 'customer_account':
					$order .= " order by a.customer_account ";
					break;
				case 'invoice_company':
					$order .= " order by a.invoice_company ";
					break;
			if ($this->orderType=='D') $order .= "desc ";
		}else{
		    $order ="order by a.dates desc";
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

    public function searchColumns() {
        $search = array(
            'dates'=>"date_format(a.dates,'%Y/%m/%d')",
            'customer_account'=>"a.customer_account",
            'invoice_company'=>"a.invoice_company",

        );
        //if (!Yii::app()->user->isSingleCity()) $search['city_name'] = 'b.name';
        return $search;
    }

	public function retrieveExportData()
	{
		$suffix = Yii::app()->params['envSuffix'];
		$city = Yii::app()->user->city_allow();
		$sql1 = "
			SELECT a.*, b.name as city_name, c.product_code, c.description, c.quantity, c.unit_price, c.amount,
			e.name as generated_by			
			FROM acc_invoice_type c 
			LEFT JOIN acc_invoice a ON a.id = c.invoice_id
            LEFT JOIN security$suffix.sec_city b ON a.city = b.code
			LEFT JOIN hr$suffix.hr_binding d ON a.lcu = d.user_id
			LEFT JOIN hr$suffix.hr_employee e ON e.id = d.employee_id
            where a.city in ($city) 
		";
		$clause = "";
        if (!empty($this->searchField) && (!empty($this->searchValue) || $this->isAdvancedSearch())) {
            if ($this->isAdvancedSearch()) {
                $clause = $this->buildSQLCriteria();
            } else {
                $svalue = str_replace("'","\'",$this->searchValue);
                $columns = $this->searchColumns();
                $clause .= General::getSqlConditionClause($columns[$this->searchField],$svalue);
            }
        }
        $clause .= $this->getDateRangeCondition('a.dates');

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
				//$record["generated_by"]=self::getNames($record['lcu']);//生成账单人员
                $timestrap=strtotime($record['dates']);
                $number=date('ym',$timestrap);
                $number=($number*10000000)+$row['id'];
				$this->attr[] = array(
					'number'=>$number,
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
