<tr>
	<th>  <input name="Fruit"  type="checkbox"  id="all"></th>

	<th>
		<?php echo TbHtml::link($this->getLabelName('number').$this->drawOrderArrow('number'),'#',$this->createOrderLink('invoice-list','number'))
			;
		?>
	</th>

	<th>
		<?php echo TbHtml::link($this->getLabelName('dates').$this->drawOrderArrow('dates'),'#',$this->createOrderLink('invoice-list','dates'))
			;
		?>
	</th>
	<th>
		<?php echo TbHtml::link($this->getLabelName('customer_account').$this->drawOrderArrow('customer_account'),'#',$this->createOrderLink('invoice-list','customer_account'))
			;
		?>
	</th>
	<th>
		<?php echo TbHtml::link($this->getLabelName('invoice_company').$this->drawOrderArrow('invoice_company'),'#',$this->createOrderLink('invoice-list','invoice_company'))
			;
		?>
	</th>

</tr>
