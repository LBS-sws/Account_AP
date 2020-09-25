<tr class='clickable-row' data-href='<?php echo $this->getLink('XI01', 'invoice/edit', 'invoice/view', array('index'=>$this->record['id']));?>'>
    <td class="che"> <input value="<?php echo $this->record['id']; ?>"  type="checkbox" name="InvoiceList[attr][]" ></td>
	<td><?php echo $this->record['number']; ?></td>
	<td><?php echo $this->record['dates']; ?></td>
	<td><?php echo $this->record['customer_account']; ?></td>
	<td><?php echo $this->record['invoice_company']; ?></td>

</tr>
