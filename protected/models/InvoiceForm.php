<?php

/**
 * UserForm class.
 * UserForm is the data structure for keeping
 * user form data. It is used by the 'user' action of 'SiteController'.
 */
class InvoiceForm extends CFormModel
{
	/* User Fields */
	public $id;
	public $number;////账单编号
	public $dates;//账单日期
	public $payment_term;//付款方式
	public $customer_po_no;//客户订单编号
	public $customer_account;//客户编号
	public $salesperson;//销售
	public $sales_order_no;//客户订货订单编号
	public $sales_order_date;//送货日期
	public $ship_via;//运输方式
	public $invoice_company;//服务公司
	public $invoice_address;//服务地址
	public $invoice_tel;//服务电话
    public $delivery_company;//发票公司
    public $delivery_address;//发票地址
    public $delivery_tel;//联系电话
	public $disc=0.07;//税率
    public $sub_total;//小计
    public $gst;//税
    public $total_amount;//合计
    public $city;//
    public $generated_by;//生成账单人员
    public $type=array();//详细记录
    public $product_code;
    public $description;
    public $quantity;
    public $unit_price;
    public $amount;


	/**
	 * Declares customized attribute labels.
	 * If not declared here, an attribute would have a label that is
	 * the same as its name with the first letter in upper case.
	 */
	public function attributeLabels()
	{
		return array(
			'id'=>Yii::t('invoice','Record ID'),
			'number'=>Yii::t('invoice','Number'),
			'dates'=>Yii::t('invoice','Date'),
			'payment_term'=>Yii::t('invoice','Payment Term'),
			'customer_po_no'=>Yii::t('invoice','Customer Po No'),
			'customer_account'=>Yii::t('invoice','Customer Account'),
			'salesperson'=>Yii::t('invoice','Salesperson'),
			'sales_order_no'=>Yii::t('invoice','Sales Order No'),
			'sales_order_date'=>Yii::t('invoice','Sales Order Date'),
			'ship_via'=>Yii::t('invoice','Ship Via'),
			'invoice_company'=>Yii::t('invoice','Invoice Company'),
			'invoice_address'=>Yii::t('invoice','Invoice Address'),
			'invoice_tel'=>Yii::t('invoice','Invoice Tel'),
            'delivery_company'=>Yii::t('invoice','Delivery Company'),
            'delivery_address'=>Yii::t('invoice','Delivery Address'),
            'delivery_tel'=>Yii::t('invoice','Delivery Tel'),
			'disc'=>Yii::t('invoice','Disc'),
            'sub_total'=>Yii::t('invoice','Sub Total'),
            'gst'=>Yii::t('invoice','Gst'),
            'total_amount'=>Yii::t('invoice','Total Amount'),
            'city'=>Yii::t('invoice','City'),
            'generated_by'=>Yii::t('invoice','Generated By'),
		);
	}

	/**
	 * Declares the validation rules.
	 */
	public function rules()
	{
		return array(
			array('id,number,type,dates,payment_term,customer_po_no,customer_account,salesperson,sales_order_no,sales_order_date,
			ship_via,invoice_company,invoice_address,invoice_tel,delivery_company,delivery_address,delivery_tel,
			disc,sub_total,gst,total_amount,city,generated_by,','safe'),
			array('','required'),
			//array('code','validateCode'),
//			array('code','safe','on'=>'edit'),

		);
	}

	public function retrieveData($index)
	{
        $suffix = Yii::app()->params['envSuffix'];
		$city = Yii::app()->user->city_allow();
		$sql = "select * from acc_invoice where id=$index and city in ($city)";
		$rows = Yii::app()->db->createCommand($sql)->queryAll();
		if (count($rows) > 0)
		{
			foreach ($rows as $row)
			{
			    $sql1="select * from acc_invoice_type where invoice_id='".$row['id']."'";
                $type = Yii::app()->db->createCommand($sql1)->queryAll();
//                $sql2="select * from swoper$suffix.swo_company where code='".$row['customer_account']."'";
//                $delivery = Yii::app()->db->createCommand($sql2)->queryRow();
                $dates = General::toMyDate($row['dates']);
                $timestrap=strtotime($dates);
                $number=date('ym',$timestrap);
                $number=($number*10000000)+$row['id'];
                $this->type = $type;
                $this->id = $row['id'];
				$this->number = $number;
                $this->dates = General::toDate($row['dates']);
				$this->payment_term = $row['payment_term'];
				$this->customer_po_no = $row['customer_po_no'];
				$this->customer_account =$row['customer_account'];
				$this->salesperson = $row['salesperson'];
				$this->sales_order_no = $row['sales_order_no'];
				$this->sales_order_date = General::toDate($row['sales_order_date']);
				$this->ship_via = $row['ship_via'];
				$this->invoice_company = $row['invoice_company'];
				$this->invoice_address = $row['invoice_address'];
				$this->invoice_tel = $row['invoice_tel'];
                $this->delivery_company = $row['delivery_company'];
                $this->delivery_address = $row['delivery_address'];
                $this->delivery_tel = $row['delivery_tel'];
				$row['disc']=strtotime($row['dates'])>=strtotime("2023/01/01")?0.08:$row['disc'];//2023年01月01日稅率改為8%
                $disc=$row['disc']*100;
				$this->disc = $disc."%";
                $arr=array_sum(array_map(create_function('$val', 'return $val["amount"];'), $type));
				$this->sub_total = sprintf("%.2f",$arr);
				$this->gst = sprintf("%.2f",($arr*$row['disc']));
                $total_amount=($arr*$row['disc'])+$arr;
				$this->total_amount = round($total_amount,2);//sprintf("%.2f",$total_amount)
				$this->city = $row['city'];
				$this->generated_by = $this->getNames($row['lcu']);
				break;
			}
		}
		return true;
	}

	public function newData($date){
        $this->city = Yii::app()->user->city();
//        $this->city='SG';
        $start=$date['start'];
        $end=$date['end'];
        $model=new Invoice;
        $arr=$model->getData($this->city,$start,$end);
//        print_r('<pre>');
//        print_r($arr);exit();
        if(isset($arr['data'])){
            $connection = Yii::app()->db;
            $transaction=$connection->beginTransaction();
            try {
                $this->saveU($connection,$arr);
                $transaction->commit();
            }
            catch(Exception $e) {
                $transaction->rollback();
                throw new CHttpException(404,'Cannot update.'.$e->getMessage());
            }
        }

    }

    /**
     * @param $connection
     * @param $arr
     */
    public function saveU(&$connection, $arr){
	    foreach ($arr['data'] as $a){
			$this->disc=strtotime($a['invoice_dt'])>=strtotime("2023/01/01")?0.08:0.07;//2023年01月01日稅率改為8%
            
			$invoice_dt = General::toMyDate($a['invoice_dt']);
            $sql_s="select id from acc_invoice where dates='".$invoice_dt."' and customer_account='".$a['customer_code']."'";
            if(strstr($a['invoice_no'],"INV")!==false){ //INV服務不需要合併
                $sql_s.=" and invoice_no = '{$a['invoice_no']}'";
            }else{ //其它服務因為合併所以invoice_no不能確定是不是唯一值
                $sql_s.=" and invoice_no not like '%INV%'";
            }
//	        $sql_s="select id from acc_invoice where dates='".$invoice_dt."' and customer_account='".$a['customer_code']."' and invoice_no='".$a['invoice_no']."'";
            $records = Yii::app()->db->createCommand($sql_s)->queryAll();
            if(empty($records)){ //這個if是判斷數據庫是否已經錄入過該賬單了
                $sql="insert into acc_invoice (
                    dates,payment_term,customer_account,salesperson,sales_order_date,invoice_company,invoice_address,invoice_tel,lcu,luu,city,disc,delivery_company,delivery_address,delivery_tel,invoice_no
                  ) value (
                   :dates,:payment_term,:customer_account,:salesperson,:sales_order_date,:invoice_company,:invoice_address,:invoice_tel,:lcu,:luu,:city,:disc,:delivery_company,:delivery_address,:delivery_tel,:invoice_no
                  )";

//        $sql="insert into acc_invoice (dates,payment_term,customer_po_no,customer_account,salesperson,sales_order_no,sales_order_date,ship_via,invoice_company,invoice_address,invoice_tel,delivery_company,delivery_address,delivery_tel,description,quantity,unit_price,disc,amount,sub_total,gst,total_amount,generated_by,lcu,luu) value ()";
                $uid = Yii::app()->user->id;
                $command=$connection->createCommand($sql);
                if (strpos($sql,':dates')!==false)
                    $invoice_dt = General::toMyDate($a['invoice_dt']);
                $command->bindParam(':dates',$invoice_dt,PDO::PARAM_STR);
                if (strpos($sql,':payment_term')!==false)
                    $command->bindParam(':payment_term',$a['payment_term'],PDO::PARAM_STR);
                if (strpos($sql,':customer_account')!==false)
                    $command->bindParam(':customer_account',$a['customer_code'],PDO::PARAM_STR);
                if (strpos($sql,':salesperson')!==false)
                    $command->bindParam(':salesperson',$a['sales_name'],PDO::PARAM_STR);
                if (strpos($sql,':sales_order_date')!==false)
                    $invoice_dt = General::toMyDate($a['invoice_dt']);
                $command->bindParam(':sales_order_date',$invoice_dt,PDO::PARAM_STR);
                if (strpos($sql,':invoice_company')!==false)
                    $command->bindParam(':invoice_company',$a['invoice_to_name'],PDO::PARAM_STR);
                if (strpos($sql,':invoice_address')!==false)
                    $command->bindParam(':invoice_address',$a['invoice_to_addr'],PDO::PARAM_STR);
                if (strpos($sql,':invoice_tel')!==false)
                    $command->bindParam(':invoice_tel',$a['invoice_to_tel'],PDO::PARAM_STR);
                if (strpos($sql,':delivery_company')!==false)
                    $command->bindParam(':delivery_company',$a['name_zh'],PDO::PARAM_STR);
                  if (strpos($sql,':invoice_no')!==false)
                      $command->bindParam(':invoice_no',$a['invoice_no'],PDO::PARAM_STR);
                if (strpos($sql,':delivery_address')!==false)
                    $command->bindParam(':delivery_address',$a['addr'],PDO::PARAM_STR);
                if (strpos($sql,':delivery_tel')!==false)
                    $command->bindParam(':delivery_tel',$a['tel'],PDO::PARAM_STR);
                if (strpos($sql,':city')!==false)
                    $command->bindParam(':city', $this->city,PDO::PARAM_STR);
                if (strpos($sql,':disc')!==false)
                    $command->bindParam(':disc', $this->disc,PDO::PARAM_STR);
                if (strpos($sql,':lcu')!==false)
                    $command->bindParam(':lcu',$uid,PDO::PARAM_STR);
                if (strpos($sql,':luu')!==false)
                    $command->bindParam(':luu',$uid,PDO::PARAM_STR);
                $command->execute();
                $id = Yii::app()->db->getLastInsertID();
                if(!empty($id)){
                    foreach ($a['line'] as $line){
                        $sql="insert into acc_invoice_type (
                            invoice_id,product_code,description,quantity,unit_price,amount
                          ) value (
                           :invoice_id,:product_code,:description,:quantity,:unit_price,:amount
                          )";
                        $command=$connection->createCommand($sql);
                        if (strpos($sql,':invoice_id')!==false)
                            $command->bindParam(':invoice_id',$id,PDO::PARAM_STR);
                        if (strpos($sql,':product_code')!==false)
                            $command->bindParam(':product_code',$line['product_code'],PDO::PARAM_STR);
                        if (strpos($sql,':description')!==false)
                            $command->bindParam(':description',$line['product_name'],PDO::PARAM_STR);
                        if (strpos($sql,':quantity')!==false)
                            $command->bindParam(':quantity',$line['qty'],PDO::PARAM_STR);
                        if (strpos($sql,':unit_price')!==false)
                            $command->bindParam(':unit_price',$line['unit_price'],PDO::PARAM_STR);
                        if (strpos($sql,':amount')!==false)
                            if($line['is_service']=='Y'){
                                $amount=$line['invoice_amt'];
                            }else{
                                $amount=$line['unit_price']*$line['qty'];
                            }
                            $command->bindParam(':amount',$amount,PDO::PARAM_STR);
                        $command->execute();
                        if(isset($line['unit_price2'])&&$line['unit_price2']!=0){
                            $sql1="insert into acc_invoice_type (
                            invoice_id,product_code,description,quantity,unit_price,amount
                          ) value (
                           :invoice_id,:product_code,:description,:quantity,:unit_price,:amount
                          )";
                            $command=$connection->createCommand($sql1);
                            if (strpos($sql,':invoice_id')!==false)
                                $command->bindParam(':invoice_id',$id,PDO::PARAM_STR);
                            if (strpos($sql,':product_code')!==false)
                                $command->bindParam(':product_code',$line['product_code2'],PDO::PARAM_STR);
                            if (strpos($sql,':description')!==false)
                                $command->bindParam(':description',$line['product_name2'],PDO::PARAM_STR);
                            if (strpos($sql,':quantity')!==false)
                                $command->bindParam(':quantity',$line['qty2'],PDO::PARAM_STR);
                            if (strpos($sql,':unit_price')!==false)
                                $command->bindParam(':unit_price',$line['unit_price2'],PDO::PARAM_STR);
                            if (strpos($sql,':amount')!==false)
                                $amount=$line['unit_price2']*$line['qty2'];
                            $command->bindParam(':amount',$amount,PDO::PARAM_STR);
                            $command->execute();
                        }
                        if(isset($line['unit_price3'])&&$line['unit_price3']!=0){
                            $sql1="insert into acc_invoice_type (
                            invoice_id,product_code,description,quantity,unit_price,amount
                          ) value (
                           :invoice_id,:product_code,:description,:quantity,:unit_price,:amount
                          )";
                            $command=$connection->createCommand($sql1);
                            if (strpos($sql,':invoice_id')!==false)
                                $command->bindParam(':invoice_id',$id,PDO::PARAM_STR);
                            if (strpos($sql,':product_code')!==false)
                                $command->bindParam(':product_code',$line['product_code3'],PDO::PARAM_STR);
                            if (strpos($sql,':description')!==false)
                                $command->bindParam(':description',$line['product_name3'],PDO::PARAM_STR);
                            if (strpos($sql,':quantity')!==false)
                                $command->bindParam(':quantity',$line['qty3'],PDO::PARAM_STR);
                            if (strpos($sql,':unit_price')!==false)
                                $command->bindParam(':unit_price',$line['unit_price3'],PDO::PARAM_STR);
                            if (strpos($sql,':amount')!==false)
                                $amount=$line['unit_price3']*$line['qty3'];
                            $command->bindParam(':amount',$amount,PDO::PARAM_STR);
                            $command->execute();
                        }
                        if(isset($line['unit_price4'])&&$line['unit_price4']!=0){
                            $sql1="insert into acc_invoice_type (
                            invoice_id,product_code,description,quantity,unit_price,amount
                          ) value (
                           :invoice_id,:product_code,:description,:quantity,:unit_price,:amount
                          )";
                            $command=$connection->createCommand($sql1);
                            if (strpos($sql,':invoice_id')!==false)
                                $command->bindParam(':invoice_id',$id,PDO::PARAM_STR);
                            if (strpos($sql,':product_code')!==false)
                                $command->bindParam(':product_code',$line['product_code4'],PDO::PARAM_STR);
                            if (strpos($sql,':description')!==false)
                                $command->bindParam(':description',$line['product_name4'],PDO::PARAM_STR);
                            if (strpos($sql,':quantity')!==false)
                                $command->bindParam(':quantity',$line['qty4'],PDO::PARAM_STR);
                            if (strpos($sql,':unit_price')!==false)
                                $command->bindParam(':unit_price',$line['unit_price4'],PDO::PARAM_STR);
                            if (strpos($sql,':amount')!==false)
                                $amount=$line['unit_price4']*$line['qty4'];
                            $command->bindParam(':amount',$amount,PDO::PARAM_STR);
                            $command->execute();
                        }
                        if(isset($line['unit_price5'])&&$line['unit_price5']!=0){
                            $sql1="insert into acc_invoice_type (
                            invoice_id,product_code,description,quantity,unit_price,amount
                          ) value (
                           :invoice_id,:product_code,:description,:quantity,:unit_price,:amount
                          )";
                            $command=$connection->createCommand($sql1);
                            if (strpos($sql,':invoice_id')!==false)
                                $command->bindParam(':invoice_id',$id,PDO::PARAM_STR);
                            if (strpos($sql,':product_code')!==false)
                                $command->bindParam(':product_code',$line['product_code5'],PDO::PARAM_STR);
                            if (strpos($sql,':description')!==false)
                                $command->bindParam(':description',$line['product_name5'],PDO::PARAM_STR);
                            if (strpos($sql,':quantity')!==false)
                                $command->bindParam(':quantity',$line['qty5'],PDO::PARAM_STR);
                            if (strpos($sql,':unit_price')!==false)
                                $command->bindParam(':unit_price',$line['unit_price5'],PDO::PARAM_STR);
                            if (strpos($sql,':amount')!==false)
                                $amount=$line['unit_price5']*$line['qty5'];
                            $command->bindParam(':amount',$amount,PDO::PARAM_STR);
                            $command->execute();
                        }
                        if(isset($line['unit_price6'])&&$line['unit_price6']!=0){
                            $sql1="insert into acc_invoice_type (
                            invoice_id,product_code,description,quantity,unit_price,amount
                          ) value (
                           :invoice_id,:product_code,:description,:quantity,:unit_price,:amount
                          )";
                            $command=$connection->createCommand($sql1);
                            if (strpos($sql,':invoice_id')!==false)
                                $command->bindParam(':invoice_id',$id,PDO::PARAM_STR);
                            if (strpos($sql,':product_code')!==false)
                                $command->bindParam(':product_code',$line['product_code6'],PDO::PARAM_STR);
                            if (strpos($sql,':description')!==false)
                                $command->bindParam(':description',$line['product_name6'],PDO::PARAM_STR);
                            if (strpos($sql,':quantity')!==false)
                                $command->bindParam(':quantity',$line['qty6'],PDO::PARAM_STR);
                            if (strpos($sql,':unit_price')!==false)
                                $command->bindParam(':unit_price',$line['unit_price6'],PDO::PARAM_STR);
                            if (strpos($sql,':amount')!==false)
                                $amount=$line['unit_price6']*$line['qty6'];
                            $command->bindParam(':amount',$amount,PDO::PARAM_STR);
                            $command->execute();
                        }
                    }
                }
            }
        }
    }
	
	public function saveData()
	{

		$connection = Yii::app()->db;
		$transaction=$connection->beginTransaction();
		try {
			$this->saveInvoice($connection);
			$transaction->commit();
		}
		catch(Exception $e) {
			$transaction->rollback();
			throw new CHttpException(404,'Cannot update.'.$e->getMessage());
		}
	}

	protected function saveInvoice(&$connection)
	{
		$sql = '';
		switch ($this->scenario) {
			case 'delete':
				$sql = "delete from acc_invoice where id = :id and city = :city";
				break;
			case 'edit':
				$sql = "update acc_invoice set
                            payment_term=:payment_term,
                            customer_po_no=:customer_po_no,
                            sales_order_no=:sales_order_no,
                            sales_order_date=:sales_order_date,
                            ship_via=:ship_via,
                            salesperson=:salesperson,                      
                            invoice_company=:invoice_company,
                            invoice_address=:invoice_address,
                            invoice_tel=:invoice_tel,
                           delivery_company=:delivery_company,
                            delivery_address=:delivery_address,
                            delivery_tel=:delivery_tel,
                            sub_total=:sub_total,
                            gst=:gst,
                            total_amount=:total_amount,                                                                                                               
                            luu=:luu
						where id = :id and city = :city
						";
				break;
		}

		$city = Yii::app()->user->city();
		$uid = Yii::app()->user->id;
		$command=$connection->createCommand($sql);
		if (strpos($sql,':payment_term')!==false)
			$command->bindParam(':payment_term',$this->payment_term,PDO::PARAM_STR);
		if (strpos($sql,':customer_po_no')!==false)
			$command->bindParam(':customer_po_no',$this->customer_po_no,PDO::PARAM_STR);
		//print_r($this->sales_order_no);exit();
        if (strpos($sql,':sales_order_no')!==false)
			$command->bindParam(':sales_order_no',$this->sales_order_no,PDO::PARAM_STR);
		if (strpos($sql,':sales_order_date')!==false) {
			$sales_order_date = General::toMyDate($this->sales_order_date);
			$command->bindParam(':sales_order_date',$sales_order_date,PDO::PARAM_STR);
		}
		if (strpos($sql,':ship_via')!==false)
			$command->bindParam(':ship_via',$this->ship_via,PDO::PARAM_STR);
		if (strpos($sql,':salesperson')!==false)
			$command->bindParam(':salesperson',$this->salesperson,PDO::PARAM_STR);
		if (strpos($sql,':invoice_company')!==false)
			$command->bindParam(':invoice_company',$this->invoice_company,PDO::PARAM_STR);
		if (strpos($sql,':invoice_address')!==false)
			$command->bindParam(':invoice_address',$this->invoice_address,PDO::PARAM_STR);
		if (strpos($sql,':invoice_tel')!==false)
			$command->bindParam(':invoice_tel',$this->invoice_tel,PDO::PARAM_STR);
        if (strpos($sql,':delivery_company')!==false)
            $command->bindParam(':delivery_company',$this->delivery_company,PDO::PARAM_STR);
        if (strpos($sql,':delivery_address')!==false)
            $command->bindParam(':delivery_address',$this->delivery_address,PDO::PARAM_STR);
        if (strpos($sql,':delivery_tel')!==false)
            $command->bindParam(':delivery_tel',$this->delivery_tel,PDO::PARAM_STR);
//		if (strpos($sql,':disc')!==false)
//			$command->bindParam(':disc',$this->disc,PDO::PARAM_STR);
        if (strpos($sql,':sub_total')!==false)
            $command->bindParam(':sub_total',$this->sub_total,PDO::PARAM_STR);
        if (strpos($sql,':gst')!==false)
            $command->bindParam(':gst',$this->gst,PDO::PARAM_STR);
        if (strpos($sql,':total_amount')!==false)
            $command->bindParam(':total_amount',$this->total_amount,PDO::PARAM_STR);
		if (strpos($sql,':luu')!==false)
			$command->bindParam(':luu',$uid,PDO::PARAM_STR);
        if (strpos($sql,':city')!==false)
            $command->bindParam(':city',$city,PDO::PARAM_STR);
        if (strpos($sql,':id')!==false)
            $command->bindParam(':id',$this->id,PDO::PARAM_INT);
		$command->execute();
		foreach ($this['type'] as $arr){
            switch ($this->scenario) {
                case 'delete':
                    $sql1 = "delete from acc_invoice_type where id = :id ";
                    break;
                case 'edit':
                    $sql1 = "update acc_invoice_type set
                            description=:description,
                            quantity=:quantity,
                            unit_price=:unit_price,
                            amount=:amount                  
						where id = :id 
						";
                    break;
            }
            $command=$connection->createCommand($sql1);
            if (strpos($sql1,':description')!==false)
                $command->bindParam(':description',$arr['description'],PDO::PARAM_STR);
            if (strpos($sql1,':quantity')!==false)
                $command->bindParam(':quantity',$arr['quantity'],PDO::PARAM_STR);
            if (strpos($sql1,':unit_price')!==false)
                $command->bindParam(':unit_price',$arr['unit_price'],PDO::PARAM_STR);
            if (strpos($sql1,':amount')!==false)
                $command->bindParam(':amount',$arr['amount'],PDO::PARAM_STR);
            if (strpos($sql1,':id')!==false)
                $command->bindParam(':id',$arr['id'],PDO::PARAM_INT);
            $command->execute();
            //print_r('<pre>');print_r($this);exit();
        }

		return true;
	}


    public function isReadOnly() {
//		return ($this->scenario=='view'||$this->status=='V'||$this->posted||!empty($this->req_ref_no)||!empty($this->t3_doc_no));
        return ($this->scenario!='new');
    }

    public function getNames($id)
    {
        $suffix = Yii::app()->params['envSuffix'];
        $sql = "select name from hr$suffix.hr_employee where id=(SELECT employee_id from hr$suffix.hr_binding WHERE user_id='".$id."')";
        $row = Yii::app()->db->createCommand($sql)->queryScalar();
        return  $row;
    }

    public function deleteData($a){
        $sql = "delete from acc_invoice where id = '$a'";
        Yii::app()->db->createCommand($sql)->execute();
        $sql1 = "delete from acc_invoice_type where invoice_id = '$a'";
        Yii::app()->db->createCommand($sql1)->execute();
    }

    public function allDowns($model,$type="F"){
        $pdf = new MyPDF2('P', 'mm', 'A4', true, 'UTF-8', false);
        $pdf->SetTitle($model->invoice_company);
        $pdf->setHeaderFont(Array(PDF_FONT_NAME_MAIN, '', PDF_FONT_SIZE_MAIN));
        $pdf->setFooterFont(Array(PDF_FONT_NAME_DATA, '', PDF_FONT_SIZE_DATA));
        $pdf->SetDefaultMonospacedFont(PDF_FONT_MONOSPACED);
        $pdf->SetFont('stsongstdlight', '', 10);
        $t_margin= $pdf->getHeaderHeight()+7;
        $r_margin=5;
        $l_margin=5;
        $pdf->SetMargins($l_margin, $t_margin, $r_margin);
        $h_margin=15;
        $pdf->SetHeaderMargin($h_margin);
        $f_margin=5;
        $pdf->SetFooterMargin($f_margin);
        $b_margin=5;
        $pdf->SetAutoPageBreak(TRUE, $b_margin);
        $pdf->AddPage();
        $tbl=<<<EOD
            <table style="width: 570px;">
                <tr>
                    <td colspan="10" width="180px;">LBS SERVICES (SINGAPORE) PTE LTD</td><td width="100px;"></td><td width="100px;"></td><td width="20px;"></td><td width="30px;"></td><td width="140px;" rowspan="4" ><img  src="images/biao.png" ></td>
                </tr>
                <tr>
                    <td colspan="12" width="200px;">61 Ubi Ave 1#06-09 UB Point Singapore 408941</td><td></td><td></td>
                </tr>
                <tr>
                    <td colspan="10" width="180px;">Tel (65) 6513 3289, (65) 6513 3668</td><td> </td><td></td><td></td><td></td>
                </tr>
                <tr>
                    <td colspan="10" width="180px;">www.lbshygiene.com.sg</td><td colspan="3" rowspan="3" width="220px"><span style="font-size: 30px;text-align: center;line-height: 40px;">Tax Invoice</span></td><td></td><td></td>
                </tr>
                <tr>
                    <td colspan="10" width="180px;">UEN REG. NO.:201621680G</td><td></td><td></td>
                </tr>
                <tr>
                    <td colspan="10" width="180px;" >GST  REG. NO.:201621680G</td><td></td><td></td>
                </tr>
            </table>
         
            <table  style="width: 570px;line-height: 20px;">
                 <tr><td colspan="13" rowspan="4" width="320px;" height="100px"  border="1" cellspacing="0" cellpadding="0">Invoice To:<br/> $model->invoice_company<br/> $model->invoice_address<br/> $model->invoice_tel</td><td width="20px;"> </td><td height="25px;" width="100px;">Number:</td><td  width="130px;">$model->number</td></tr>
                 <tr><td width="20px;"> </td><td height="25px;">Date:</td><td>$model->dates</td></tr> 
                 <tr><td width="20px;"> </td><td height="25px;">Payment Term:</td><td>$model->payment_term</td></tr>
                 <tr><td width="20px;"> </td><td height="25px;">Customer PO NO:</td><td>$model->customer_po_no</td></tr>
                 <tr><td colspan="13" rowspan="5" width="320px;" height="100px"  border="1" cellspacing="0" cellpadding="0">Deliver To: <br/> $model->delivery_company<br/> $model->delivery_address<br/> $model->delivery_tel</td><td width="20px;"> </td><td height="20px;">Customer Account:</td><td>$model->customer_account</td></tr>
                 <tr><td width="20px;"> </td><td height="20px;">Salesperson:</td><td>$model->salesperson</td></tr>
                 <tr><td width="20px;"> </td><td height="20px;">Sales Order No:</td><td>$model->sales_order_no</td></tr>
                 <tr><td width="20px;"> </td><td height="20px;">Sales Order Date:</td><td>$model->sales_order_date</td></tr>
                 <tr><td width="20px;"> </td><td height="20px;">Ship Via:</td><td>$model->ship_via</td></tr>
            </table>           
             <table  cellspacing="0" cellpadding="0" style="width: 570px;line-height: 20px;text-align: center;">
                  <tr ><td></td></tr>
                  <tr ><td width="30px;" border="1">No</td><td width="70px;" border="1">Product Code</td><td width="290px;" border="1">Stock Code/Description</td><td width="55px;" border="1">Quantity</td><td width="55px;" border="1">Unit Price</td><td width="70px;" border="1">Amount</td></tr>   
EOD;
        $model['product_code']='';
        $model['description']='';
        $model['quantity']='';
        $model['unit_price']='';
        $model['amount']='';
        $a='';
        foreach ($model->type as $value){
            $model['product_code'].=$value['product_code']."<br/>";
            $model['description'].=$value['description']."<br/>";
            $model['quantity'].=$value['quantity']."<br/>";
            $model['unit_price'].=$value['unit_price']."<br/>";
            $model['amount'].=$value['amount']."<br/>";
            $disc=$model['disc'];
            if(empty($value['description'])){
                $disc='';
            }
            $a.=$disc."<br/>";
        }
        $tbl.=<<<EOD
        <tr ><td  rowspan="9" height="260px;" border="1"></td><td rowspan="9" height="260px;" border="1">$model->product_code</td><td rowspan="9" height="260px;" border="1">$model->description</td><td rowspan="9" height="260px;" border="1">$model->quantity</td><td rowspan="9" height="260px;" border="1">$model->unit_price</td><td rowspan="9" height="260px;" border="1">$model->amount</td></tr>   
EOD;

        //$logo_path =  dirname(__FILE__).'/../../images/footer.png';
        $tbl.=<<<EOD
             </table>
             <table  cellspacing="0" cellpadding="0" style="width: 700px;line-height: 20px;">
                  <tr><td  width="300px;"> Kindly issue cheque payable to <b>LBS SERVICES (SINGAPORE) PTE LTD</b></td><td  width="101px;"></td><td width="99px;" align="right">Sub-Total($):</td><td width="70px;" rowspan="3" border="1" style="text-align: center">$model->sub_total<br/>$model->gst<br/>$model->total_amount</td></tr>
                  <tr><td></td><td></td><td align="right">GST:</td></tr>
                  <tr><td border="1">  Generated by:$model->generated_by</td><td></td><td align="right">Total Amount($):</td></tr>
             </table>
<table cellspacing="0" cellpadding="0" style="line-height: 20px;text-align: center;">
    <tr><td width="110px;"></td><td width="110px;"></td><td  width="150px;"></td><td width="200px;" rowspan="2" border="1"><b>LBS SERVICES (SINGAPORE) PTE LTD</b><br/>***This is computer generated invoice,<br/>no signature is required.***</td></tr>
    <tr><td></td><td></td><td></td></tr>
    <tr><td align="left">Customer's Copy</td><td></td><td></td><td>     Authorised Signature  &nbsp; &nbsp; &nbsp; &nbsp;<b>End</b></td></tr>
    <tr><td colspan="4" height="20px">&nbsp;</td></tr>
    <tr><td colspan="3">&nbsp;</td><td style="text-align: right;"><img width="86px" height="40px" src="images/biao2.png" /></td></tr>
</table>
EOD;




        $pdf->writeHTML($tbl, true, false, false, false, '');
        ob_clean();
        $date=str_replace('/','-',$model->dates);
        $name=str_replace('/',' ',$model->invoice_company);
        $invoiceNo = str_replace('/',' ',$model->number);
        $address="/".$name."_".$invoiceNo.'.pdf';
//        $tem_dir = $_SERVER['SystemRoot'].'/temp';
//        $address=$tem_dir.$date."-".$model->invoice_company.'.pdf';
        $outstring =$pdf->Output(sys_get_temp_dir().$address, $type);
        return $address;
    }




    public function zip($files){
//        $files = array('image.jpeg','text.txt','music.wav');
        $zipname = sys_get_temp_dir().'/'.'zipped_file.zip';
        $zip = new ZipArchive;
        $zip->open($zipname, ZipArchive::CREATE);
        foreach ($files as $file) {
//            $ch = curl_init();
//            curl_setopt($ch, CURLOPT_POST, 0);
//            curl_setopt($ch, CURLOPT_URL, $file);
//            curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
//            $fileContent = curl_exec($ch);
//            curl_close($ch);
            $result = basename($file);
            $zip->addFile(sys_get_temp_dir().$file,$result);
        }
        $zip->close();

///Then download the zipped file.
        header('Content-Type: application/zip');
        header('Content-disposition: attachment; filename='.$zipname);
        header('Content-Length: '.filesize($zipname));
        readfile($zipname);
        unlink($zipname);
        foreach ($files as $a){
            unlink($a);
        }
    }
}
