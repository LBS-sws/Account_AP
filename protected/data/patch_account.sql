ALTER TABLE acc_account_code ADD COLUMN city char(5) AFTER rpt_cat;
UPDATE acc_account_code SET city='MY';
ALTER TABLE acc_account_code DROP PRIMARY KEY, ADD PRIMARY KEY (city, code);

ALTER TABLE acc_account_item ADD COLUMN city char(5) AFTER acct_code;
UPDATE acc_account_item SET city='MY';
ALTER TABLE acc_account_item DROP PRIMARY KEY, ADD PRIMARY KEY (city, code);

ALTER TABLE acc_account_type ADD COLUMN city char(5) AFTER rpt_cat;
UPDATE acc_account_type SET city='MY';
CREATE INDEX idx_account_type_1 ON acc_account_type(city);

ALTER TABLE acc_trans_type ADD COLUMN city char(5) AFTER counter_type;
UPDATE acc_trans_type SET city='MY';
ALTER TABLE acc_trans_type DROP PRIMARY KEY, ADD PRIMARY KEY (city, trans_type_code);

DROP FUNCTION AccountBalance;
DELIMITER ;;
CREATE FUNCTION `AccountBalance`(p_acct_id int unsigned, p_city char(5), p_fm_dt datetime, p_to_dt datetime) RETURNS decimal(11,2)
BEGIN
DECLARE balance decimal(11,2);
SET balance = (
SELECT sum(case b.trans_cat
when 'IN' then (if(b.adj_type='N',a.amount,-1*a.amount))
when 'OUT' then (if(b.adj_type='N',-1*a.amount,a.amount))
end)
FROM acc_trans a, acc_trans_type b
WHERE a.acct_id = p_acct_id and a.trans_type_code = b.trans_type_code
and a.trans_dt >= p_fm_dt and a.trans_dt <= p_to_dt
and a.status <> 'V' and a.city = p_city and a.city=b.city
);
RETURN balance;
END ;;
DELIMITER ;

DROP FUNCTION AccountBalanceByLCD;
DELIMITER ;;
CREATE FUNCTION `AccountBalanceByLCD`(p_acct_id int unsigned, p_city char(5), p_fm_dt datetime, p_to_dt datetime) RETURNS decimal(11,2)
BEGIN
DECLARE balance decimal(11,2);
SET balance = (
SELECT sum(case b.trans_cat
when 'IN' then (if(b.adj_type='N',a.amount,-1*a.amount))
when 'OUT' then (if(b.adj_type='N',-1*a.amount,a.amount))
end)
FROM acc_trans a, acc_trans_type b
WHERE a.acct_id = p_acct_id and a.trans_type_code = b.trans_type_code
and a.lcd >= p_fm_dt and a.lcd <= p_to_dt
and a.status <> 'V' and a.city = p_city and a.city=b.city
);
RETURN balance;
END ;;
DELIMITER ;

DROP FUNCTION AccountTransAmount;
DELIMITER ;;
CREATE FUNCTION `AccountTransAmount`(p_cat char(5), p_acct_id int unsigned, p_city char(5), p_fm_dt datetime, p_to_dt datetime) RETURNS decimal(11,2)
BEGIN
DECLARE balance decimal(11,2);
SET balance = (
SELECT sum(if(b.adj_type='N',a.amount,-1*a.amount))
FROM acc_trans a, acc_trans_type b
WHERE a.acct_id = p_acct_id and a.trans_type_code = b.trans_type_code
and a.trans_dt >= p_fm_dt and a.trans_dt <= p_to_dt
and a.status <> 'V' and a.city = p_city and a.city=b.city
and b.trans_cat = p_cat
);
RETURN balance;
END ;;
DELIMITER ;

DROP FUNCTION TransAmountByLCD;
DELIMITER ;;
CREATE FUNCTION `TransAmountByLCD`(p_cat char(5), p_acct_id int unsigned, p_city char(5), p_fm_dt datetime, p_to_dt datetime) RETURNS decimal(11,2)
BEGIN
DECLARE balance decimal(11,2);
SET balance = (
SELECT sum(if(b.adj_type='N',a.amount,-1*a.amount))
FROM acc_trans a, acc_trans_type b
WHERE a.acct_id = p_acct_id and a.trans_type_code = b.trans_type_code
and a.lcd >= p_fm_dt and a.lcd <= p_to_dt
and a.status <> 'V' and a.city = p_city and a.city=b.city
and b.trans_cat = p_cat
);
RETURN balance;
END ;;
DELIMITER ;

DROP FUNCTION TransAmountByLCDWoIntTrf;
DELIMITER ;;
CREATE FUNCTION `TransAmountByLCDWoIntTrf`(p_cat char(5), p_acct_id int unsigned, p_city char(5), p_fm_dt datetime, p_to_dt datetime) RETURNS decimal(11,2)
BEGIN
DECLARE balance decimal(11,2);
SET balance = (
SELECT sum(if(b.adj_type='N',a.amount,-1*a.amount))
FROM acc_trans a inner join acc_trans_type b on a.trans_type_code = b.trans_type_code and a.city=b.city
left outer join acc_trans_info c on a.id = c.trans_id and c.field_id = 'payer_type'
left outer join acc_trans_info d on a.id = d.trans_id and d.field_id = 'item_code'
left outer join acc_account_item e on d.field_value = e.code
left outer join acc_account_code f on f.code = e.acct_code
WHERE a.acct_id = p_acct_id 
and a.lcd >= p_fm_dt and a.lcd <= p_to_dt
and a.status <> 'V' and a.city = p_city
and b.trans_cat = p_cat
and (c.field_value <> 'A' or c.field_value is null)
and a.trans_type_code <> 'OPEN'
and (f.rpt_cat like '%RECRPT%' or b.trans_cat<>'IN')
);
RETURN balance;
END ;;
DELIMITER ;
