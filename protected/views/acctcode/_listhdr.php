<tr>
	<th></th>
	<th>
		<?php echo TbHtml::link($this->getLabelName('code').$this->drawOrderArrow('code'),'#',$this->createOrderLink('code-list','code'))
			;
		?>
	</th>
	<th>
		<?php echo TbHtml::link($this->getLabelName('name').$this->drawOrderArrow('name'),'#',$this->createOrderLink('code-list','name'))
			;
		?>
	</th>
	<th>
		<?php echo TbHtml::link($this->getLabelName('rpt_cat').$this->drawOrderArrow('rpt_cat'),'#',$this->createOrderLink('code-list','rpt_cat'))
			;
		?>
	</th>
</tr>
