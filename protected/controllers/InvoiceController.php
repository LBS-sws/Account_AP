<?php

class InvoiceController extends Controller
{
	public $function_id='XI01';

	public function filters()
	{
		return array(
			'enforceRegisteredStation',
			'enforceSessionExpiration', 
			'enforceNoConcurrentLogin',
			'accessControl', // perform access control for CRUD operations
			'postOnly + delete', // we only allow deletion via POST request
		);
	}

	/**
	 * Specifies the access control rules.
	 * This method is used by the 'accessControl' filter.
	 * @return array access control rules
	 */
	public function accessRules()
	{
		return array(
/*		
			array('allow', // allow authenticated user to perform 'create' and 'update' actions
				'actions'=>array('index','new','edit','delete','save'),
				'users'=>array('@'),
			),
*/
			array('allow', 
				'actions'=>array('new','edit','delete','save','add','down','AllDelete','PreviewPDF'),
				'expression'=>array('InvoiceController','allowReadWrite'),
			),
			array('allow', 
				'actions'=>array('index','view','export','test','reset'),
				'expression'=>array('InvoiceController','allowReadOnly'),
			),
			array('deny',  // deny all users
				'users'=>array('*'),
			),
		);
	}

	public function actionIndex($pageNum=0) 
	{
		$model = new InvoiceList;
		if (isset($_POST['InvoiceList'])) {
			$model->attributes = $_POST['InvoiceList'];
		} else {
			$session = Yii::app()->session;
			if (isset($session['criteria_xi01']) && !empty($session['criteria_xi01'])) {
				$criteria = $session['criteria_xi01'];
				$model->setCriteria($criteria);
			}
		}
		$model->determinePageNum($pageNum);
		$model->retrieveDataByPage($model->pageNum);
		$this->render('index',array('model'=>$model));
	}

    public function actionAdd(){
        if (isset($_GET)) {
            $model = new InvoiceForm;
            $model->newData($_GET);
            Dialog::message(Yii::t('dialog','Information'), Yii::t('dialog','Save Done'));
            $this->redirect(Yii::app()->createUrl('invoice/index'));
        }
    }

	public function actionSave()
	{
		if (isset($_POST['InvoiceForm'])) {
			$model = new InvoiceForm($_POST['InvoiceForm']['scenario']);
			$model->attributes = $_POST['InvoiceForm'];
			if ($model->validate()) {
				$model->saveData();
				$model->scenario = 'edit';
				Dialog::message(Yii::t('dialog','Information'), Yii::t('dialog','Save Done'));
				$this->redirect(Yii::app()->createUrl('invoice/edit',array('index'=>$model->id)));
			} else {
				$message = CHtml::errorSummary($model);
				Dialog::message(Yii::t('dialog','Validation Message'), $message);
				$this->render('form',array('model'=>$model,));
			}
		}
	}

	public function actionView($index)
	{
		$model = new InvoiceForm('view');
		if (!$model->retrieveData($index)) {
			throw new CHttpException(404,'The requested page does not exist.');
		} else {
			$this->render('form',array('model'=>$model,));
		}
	}
	
	public function actionNew()
	{
		$model = new InvoiceForm('new');
		$this->render('form',array('model'=>$model,));
	}
	
	public function actionEdit($index)
	{
		$model = new InvoiceForm('edit');
		if (!$model->retrieveData($index)) {
			throw new CHttpException(404,'The requested page does not exist.');
		} else {
			$this->render('form',array('model'=>$model,));
		}
	}
	
	public function actionDelete()
	{
		$model = new InvoiceForm('delete');
		if (isset($_POST['InvoiceForm'])) {
			$model->attributes = $_POST['InvoiceForm'];
			$model->saveData();
			Dialog::message(Yii::t('dialog','Information'), Yii::t('dialog','Record Deleted'));
		}
		$this->redirect(Yii::app()->createUrl('invoice/index'));
	}

	public function actionAllDelete()
    {
        $model = new InvoiceForm;
        if(isset($_POST['InvoiceList']['attr'])){
            foreach ($_POST['InvoiceList']['attr'] as $a){
                $model->deleteData($a);
            }
            $this->redirect(Yii::app()->createUrl('invoice/index'));
        }else{
            Dialog::message(Yii::t('dialog','Warning'), Yii::t('dialog','No Record Found'));
            $this->redirect(Yii::app()->createUrl('invoice/index'));
        }

    }

    public function actionDown()
    {
        $model = new InvoiceForm;
        if(isset($_POST['InvoiceList']['attr'])){
            foreach ($_POST['InvoiceList']['attr'] as $a){
                $model->retrieveData($a);
                $address[]=$model->allDowns($model);
            }
        //    print_r($address);exit();
            $model->zip($address);
        }else{
            Dialog::message(Yii::t('dialog','Warning'), Yii::t('dialog','No Record Found'));
            $this->redirect(Yii::app()->createUrl('invoice/index'));
        }
    }

    public function actionPreviewPDF($index)
    {
        $model = new InvoiceForm;
        $model->retrieveData($index);
        $model->allDowns($model,"I");
        Yii::app()->end();
    }

//測試同步的數據
    public function actionTest($city="",$start="",$end="")
    {
        $city = empty($city)?Yii::app()->user->city():$city;
        $start = empty($start)?date("Y/m/01"):$start;
        $end = empty($end)?date("Y/m/d"):$end;
        echo "start:<br/>";
        echo "city:{$city}   start:{$start}   end:{$end}";
        echo "<br/><br/>";
        $model=new Invoice;
        $arr=$model->getData($city,$start,$end);
		var_dump($arr);
        Yii::app()->end();
    }

//重置舊數據的發票編號
    public function actionReset()
    {
        echo "start:<br/>";
        InvoiceForm::resetOldData();
        echo "end:<br/>";
        Yii::app()->end();
    }
	
	
	public function actionExport() {
		set_time_limit(0);
		$model = new InvoiceList;
		if (isset($_POST['InvoiceList'])) {
			$model->attributes = $_POST['InvoiceList'];
		} else {
			$session = Yii::app()->session;
			if (isset($session['criteria_xi01']) && !empty($session['criteria_xi01'])) {
				$criteria = $session['criteria_xi01'];
				$model->setCriteria($criteria);
			}
		}
        $model->retrieveExportData();
		$objData = new RptInvoiceList;
		$objData->data = $model->attr;
		$objExport = new Export;
		$objExport->dataModel = $objData;
		
		$filename = 'invoice.xlsx';
		$objExport->exportExcel($filename);
	}

	public static function allowReadWrite() {
		return Yii::app()->user->validRWFunction('XI01');
	}
	
	public static function allowReadOnly() {
		return Yii::app()->user->validFunction('XI01');
	}
}
