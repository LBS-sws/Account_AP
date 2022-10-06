<?php
class RptInvoiceList extends CReport {
	public $show_report_title = false;

	protected function fields() {
		$arr = array(
            'number'=>array('label'=>Yii::t('invoice','Number'),'width'=>20,'align'=>'L'),
            'dates'=>array('label'=>Yii::t('invoice','Date'),'width'=>15,'align'=>'C'),
            'customer_account'=>array('label'=>Yii::t('invoice','Customer Account'),'width'=>20,'align'=>'L'),
            'payment_term'=>array('label'=>Yii::t('invoice','Payment Term'),'width'=>15,'align'=>'L'),
            'customer_po_no'=>array('label'=>Yii::t('invoice','Customer Po No'),'width'=>15,'align'=>'L'),
            'sales_order_no'=>array('label'=>Yii::t('invoice','Sales Order No'),'width'=>15,'align'=>'L'),
            'sales_order_date'=>array('label'=>Yii::t('invoice','Sales Order Date'),'width'=>15,'align'=>'C'),
            'ship_via'=>array('label'=>Yii::t('invoice','Ship Via'),'width'=>15,'align'=>'L'),
            'salesperson'=>array('label'=>Yii::t('invoice','Salesperson'),'width'=>20,'align'=>'L'),
			'invoice_company'=>array('label'=>Yii::t('invoice','Invoice Company'),'width'=>30,'align'=>'L'),
            'invoice_address'=>array('label'=>Yii::t('invoice','Invoice Address'),'width'=>40,'align'=>'L'),
            'invoice_tel'=>array('label'=>Yii::t('invoice','Invoice Tel'),'width'=>20,'align'=>'L'),
			'delivery_company'=>array('label'=>Yii::t('invoice','Delivery Company'),'width'=>30,'align'=>'L'),
            'delivery_address'=>array('label'=>Yii::t('invoice','Delivery Address'),'width'=>40,'align'=>'L'),
            'delivery_tel'=>array('label'=>Yii::t('invoice','Delivery Tel'),'width'=>20,'align'=>'L'),
			
            'product_code'=>array('label'=>Yii::t('invoice','Product Code'),'width'=>15,'align'=>'L'),
            'description'=>array('label'=>Yii::t('invoice','Description'),'width'=>15,'align'=>'L'),
            'quantity'=>array('label'=>Yii::t('invoice','Quantity'),'width'=>10,'align'=>'R'),
            'unit_price'=>array('label'=>Yii::t('invoice','Unit Price'),'width'=>10,'align'=>'R'),
            'amount'=>array('label'=>Yii::t('invoice','Amount'),'width'=>10,'align'=>'R'),
			
            'disc'=>array('label'=>Yii::t('invoice','Disc'),'width'=>10,'align'=>'R'),
            'sub_total'=>array('label'=>Yii::t('invoice','Sub Total'),'width'=>10,'align'=>'R'),
            'gst'=>array('label'=>Yii::t('invoice','Gst'),'width'=>10,'align'=>'L'),
            'total_amount'=>array('label'=>Yii::t('invoice','Total Amount'),'width'=>10,'align'=>'L'),
            'generated_by'=>array('label'=>Yii::t('invoice','Generated By'),'width'=>20,'align'=>'L'),
		);
		var_dump($arr);die();
		return $arr;
	}

	public function genReport() {
		$tmp = array();
		$last_no = '';
		foreach ($this->data as $row) {
			$tmp[] = $row;
		}
		$this->data = $tmp;
		return $this->exportExcel();
	}
}
?>
