<tr class='clickable-row' data-href='<?php echo $this->getLink('XC10', 'acctcode/edit', 'acctcode/view', array('index'=>$this->record['code'],'city'=>$this->record['city']));?>'>
	<td><?php echo $this->drawEditButton('XC10', 'acctcode/edit', 'acctcode/view', array('index'=>$this->record['code'],'city'=>$this->record['city'])); ?></td>
	<td><?php echo $this->record['code']; ?></td>
	<td><?php echo $this->record['name']; ?></td>
	<td><?php echo $this->record['rpt_cat']; ?></td>
</tr>
