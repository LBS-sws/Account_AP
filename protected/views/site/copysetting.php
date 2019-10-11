<?php
/* @var $this SiteController */
/* @var $model LoginForm */
/* @var $form CActiveForm  */

$this->pageTitle=Yii::app()->name . ' - Copy Setting';
?>

<section class="content">
<div class="login-box">
	<div class="login-box-body">
		<div class="row">
			<h2 class="page-heading text-center"><?php echo Yii::t('app','Copy Setting'); ?></h2>
		</div>

		<?php $form=$this->beginWidget('TbActiveForm', array(
			'id'=>'copysetting-form',
			'enableClientValidation'=>true,
			'clientOptions'=>array(
			'validateOnSubmit'=>true,
			'layout'=>TbHtml::FORM_LAYOUT_HORIZONTAL,
			),
		)); ?>

		<div class="row">
			<div class="form-group">
				<?php echo $form->label($model,'city',array('class'=>"col-sm-3 control-label")); ?>
				<div class="col-sm-5">
					<?php 
						$x = Yii::app()->user->city();
						$list = General::getCityListWithNoDescendant();
						foreach ($list as $key=>$value) {
							if ($key==$x) {
								unset($list[$key]);
								break;
							}
						}
						echo $form->dropDownList($model, 'city', $list); 
					?>
				</div>
			</div>
		</div>
		<div class="row">&nbsp;</div>
		<div class="row">
			<div class="col-xs-4 pull-right">
				<?php 
					echo TbHtml::button(Yii::t('dialog','OK'), array(
						'name'=>'btnCopyData','id'=>'btnCopy','data-toggle'=>'modal','data-target'=>'#confirmdialog',)
					);
					echo TbHtml::button('dummyButton', array('style'=>'display:none','disabled'=>true,'submit'=>'#',));
				?>
			</div>
		</div>

		<?php $this->endWidget(); ?>
	</div><!-- form -->
</div>
</section>

<?php
	$content = "<p>".Yii::t('dialog','Are you sure to copy?')."</p>";
	$this->widget('bootstrap.widgets.TbModal', array(
					'id'=>'confirmdialog',
					'header'=>Yii::t('app','Copy Setting'),
					'content'=>$content,
					'footer'=>array(
						TbHtml::button(Yii::t('dialog','OK'), array('id'=>'btnCopyData','data-dismiss'=>'modal','color'=>TbHtml::BUTTON_COLOR_PRIMARY)),
						TbHtml::button(Yii::t('dialog','Cancel'), array('data-dismiss'=>'modal','color'=>TbHtml::BUTTON_COLOR_PRIMARY)),
					),
					'show'=>false,
				));

	$link = Yii::app()->createUrl('site/copysetting');
	$js = <<<EOF
$('#btnCopyData').on('click',function() {
	$('#confirmdialog').modal('hide');
	copydata();
});

function copydata() {
	var elm=$('#btnCopy');
	jQuery.yii.submitForm(elm,'$link',{});
}
EOF;
Yii::app()->clientScript->registerScript('copySetting',$js,CClientScript::POS_READY);

?>