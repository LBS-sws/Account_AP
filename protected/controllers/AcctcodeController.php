<?php

class AcctcodeController extends Controller 
{
	public $function_id='XC10';

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
			array('allow', 
				'actions'=>array('new','edit','delete','save'),
				'expression'=>array('AcctcodeController','allowReadWrite'),
			),
			array('allow', 
				'actions'=>array('index','view'),
				'expression'=>array('AcctcodeController','allowReadOnly'),
			),
			array('deny',  // deny all users
				'users'=>array('*'),
			),
		);
	}

	public function actionIndex($pageNum=0) 
	{
		$model = new AcctCodeList;
		if (isset($_POST['AcctCodeList'])) {
			$model->attributes = $_POST['AcctCodeList'];
		} else {
			$session = Yii::app()->session;
			if (isset($session['criteria_xc10']) && !empty($session['criteria_xc10'])) {
				$criteria = $session['criteria_xc10'];
				$model->setCriteria($criteria);
			}
		}
		$model->determinePageNum($pageNum);
		$model->retrieveDataByPage($model->pageNum);
		$this->render('index',array('model'=>$model));
	}


	public function actionSave()
	{
		if (isset($_POST['AcctCodeForm'])) {
			$model = new AcctCodeForm($_POST['AcctCodeForm']['scenario']);
			$model->attributes = $_POST['AcctCodeForm'];
			if ($model->validate()) {
				$model->saveData();
//				$model->scenario = 'edit';
				Dialog::message(Yii::t('dialog','Information'), Yii::t('dialog','Save Done'));
				$this->redirect(Yii::app()->createUrl('acctcode/edit',array('index'=>$model->code)));
			} else {
				$message = CHtml::errorSummary($model);
				Dialog::message(Yii::t('dialog','Validation Message'), $message);
				$this->render('form',array('model'=>$model,));
			}
		}
	}

	public function actionView($index,$city)
	{
		$model = new AcctCodeForm('view');
		if (!$model->retrieveData($index,$city)) {
			throw new CHttpException(404,'The requested page does not exist.');
		} else {
			$this->render('form',array('model'=>$model,));
		}
	}
	
	public function actionNew()
	{
		$model = new AcctCodeForm('new');
		$this->render('form',array('model'=>$model,));
	}
	
	public function actionEdit($index)
	{
		$model = new AcctCodeForm('edit');
		if (!$model->retrieveData($index, Yii::app()->user->city())) {
			throw new CHttpException(404,'The requested page does not exist.');
		} else {
			$this->render('form',array('model'=>$model,));
		}
	}
	
	public function actionDelete()
	{
		$model = new AcctCodeForm('delete');
		if (isset($_POST['AcctCodeForm'])) {
			$model->attributes = $_POST['AcctCodeForm'];
//			if ($model->isOccupied($model->id)) {
//				Dialog::message(Yii::t('dialog','Warning'), Yii::t('dialog','This record is already in use'));
//				$this->redirect(Yii::app()->createUrl('acctitem/edit',array('index'=>$model->id)));
//			} else {
				$model->saveData();
				Dialog::message(Yii::t('dialog','Information'), Yii::t('dialog','Record Deleted'));
				$this->redirect(Yii::app()->createUrl('acctcode/index'));
//			}
		}
	}
	
	/**
	 * Performs the AJAX validation.
	 * @param CModel the model to be validated
	 */
	protected function performAjaxValidation($model)
	{
		if(isset($_POST['ajax']) && $_POST['ajax']==='code-form')
		{
			echo CActiveForm::validate($model);
			Yii::app()->end();
		}
	}
	
	public static function allowReadWrite() {
		return Yii::app()->user->validRWFunction('XC10');
	}
	
	public static function allowReadOnly() {
		return Yii::app()->user->validFunction('XC10');
	}
}
