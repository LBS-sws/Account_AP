<?php
$this->pageTitle=Yii::app()->name . ' - Invoice';
?>

<?php $form=$this->beginWidget('TbActiveForm', array(
'id'=>'invoice-list',
'enableClientValidation'=>true,
'clientOptions'=>array('validateOnSubmit'=>true,),
'layout'=>TbHtml::FORM_LAYOUT_INLINE,
)); ?>

<section class="content-header">
	<h1>
		<strong><?php echo Yii::t('app','Generate Invoice'); ?></strong>
	</h1>
<!--
	<ol class="breadcrumb">
		<li><a href="#"><i class="fa fa-dashboard"></i> Home</a></li>
		<li><a href="#">Layout</a></li>
		<li class="active">Top Navigation</li>
	</ol>
-->
</section>

<section class="content">
	<div class="box"><div class="box-body">
	<div class="btn-group" role="group">
		<?php 
			if (Yii::app()->user->validRWFunction('XI01'))
				echo TbHtml::button('<span class="fa fa-file-o"></span> '.Yii::t('misc','New Record'), array(
                        'name'=>'btnAdd','id'=>'btnAdd','data-toggle'=>'modal','data-target'=>'#addrecdialog',
				)); 
			 echo TbHtml::button('dummyButton', array('style'=>'display:none','disabled'=>true,'submit'=>'#',));
		?>
        <?php echo TbHtml::button('<span class="fa fa-download"></span> '.Yii::t('misc','Down'), array(
            'submit'=>Yii::app()->createUrl('invoice/down')));
        ?>
        <?php  if(Yii::app()->user->validFunction('CN12')){
            echo TbHtml::button('<span class="fa fa-remove"></span> '.Yii::t('misc','Delete'), array(
                    'name'=>'btnDelete','id'=>'btnDelete','data-toggle'=>'modal','data-target'=>'#removedialog',)
            );
        }
        ?>
	</div>
	<div class="btn-group pull-right" role="group">
		<?php
			echo TbHtml::button('<span class="fa fa-file-o"></span> '.Yii::t('invoice','Export'), array(
				'id'=>'btnExportData',
				'submit'=>Yii::app()->createUrl('invoice/export'),
			));
		?>
	</div>
	</div></div>
	<?php 
		$search = array(
						'number',
						'dates',
						'customer_account',
						'invoice_company',

					);
		if (!Yii::app()->user->isSingleCity()) $search[] = 'city_name';
		$this->widget('ext.layout.ListPageWidget', array(
			'title'=>Yii::t('app','Invoice List'),
			'model'=>$model,
				'viewhdr'=>'//invoice/_listhdr',
				'viewdtl'=>'//invoice/_listdtl',
				'gridsize'=>'24',
				'height'=>'600',
            'advancedSearch'=>true,
            'hasDateButton'=>true,
		));
	?>
</section>
<?php $this->renderPartial('//site/removedialog'); ?>
<?php
	echo $form->hiddenField($model,'pageNum');
	echo $form->hiddenField($model,'totalRow');
	echo $form->hiddenField($model,'orderField');
	echo $form->hiddenField($model,'orderType');
?>
<?php $this->endWidget(); ?>
<?php $this->renderPartial('//invoice/_type'); ?>
<?php
	$js = Script::genTableRowClick();
	Yii::app()->clientScript->registerScript('rowClick',$js,CClientScript::POS_READY);
$js = "
$('.che').on('click', function(e){
e.stopPropagation();
});

$('body').on('click','#all',function() {
	var val = $(this).prop('checked');
	$('input[type=checkbox][name*=\"InvoiceList[attr][]\"]').prop('checked',val);
});
";
Yii::app()->clientScript->registerScript('selectAll',$js,CClientScript::POS_READY);
$js = Script::genDeleteData(Yii::app()->createUrl('invoice/alldelete'));
Yii::app()->clientScript->registerScript('deleteRecord',$js,CClientScript::POS_READY);
?>



