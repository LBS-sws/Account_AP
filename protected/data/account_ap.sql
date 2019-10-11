-- MySQL dump 10.13  Distrib 5.7.27, for Linux (x86_64)
--
-- Host: localhost    Database: account
-- ------------------------------------------------------
-- Server version	5.7.27

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `acc_account`
--

DROP TABLE IF EXISTS `acc_account`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `acc_account` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `acct_type_id` int(10) unsigned NOT NULL,
  `acct_no` varchar(255) DEFAULT NULL,
  `acct_name` varchar(255) DEFAULT NULL,
  `bank_name` varchar(255) DEFAULT NULL,
  `coa` varchar(30) DEFAULT NULL,
  `remarks` varchar(1000) DEFAULT NULL,
  `city` char(5) NOT NULL,
  `lcu` varchar(30) DEFAULT NULL,
  `luu` varchar(30) DEFAULT NULL,
  `lcd` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `lud` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=94 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `acc_account_code`
--

DROP TABLE IF EXISTS `acc_account_code`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `acc_account_code` (
  `code` varchar(20) NOT NULL,
  `name` varchar(255) NOT NULL,
  `rpt_cat` varchar(30) DEFAULT NULL,
  `lcu` varchar(30) DEFAULT NULL,
  `luu` varchar(30) DEFAULT NULL,
  `lcd` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `lud` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `acc_account_item`
--

DROP TABLE IF EXISTS `acc_account_item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `acc_account_item` (
  `code` varchar(20) NOT NULL,
  `name` varchar(255) NOT NULL,
  `item_type` char(2) NOT NULL DEFAULT 'BI',
  `acct_code` varchar(20) NOT NULL,
  `lcu` varchar(30) DEFAULT NULL,
  `luu` varchar(30) DEFAULT NULL,
  `lcd` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `lud` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `acc_account_type`
--

DROP TABLE IF EXISTS `acc_account_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `acc_account_type` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `acct_type_desc` varchar(255) NOT NULL,
  `rpt_cat` char(5) DEFAULT NULL,
  `lcu` varchar(30) DEFAULT NULL,
  `luu` varchar(30) DEFAULT NULL,
  `lcd` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `lud` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `acc_approver`
--

DROP TABLE IF EXISTS `acc_approver`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `acc_approver` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `city` char(5) NOT NULL,
  `approver_type` varchar(20) NOT NULL,
  `username` varchar(30) DEFAULT NULL,
  `lcu` varchar(30) DEFAULT NULL,
  `luu` varchar(30) DEFAULT NULL,
  `lcd` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `lud` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `approver` (`city`,`approver_type`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `acc_balance_adj`
--

DROP TABLE IF EXISTS `acc_balance_adj`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `acc_balance_adj` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `audit_year` smallint(6) NOT NULL,
  `audit_month` tinyint(4) NOT NULL,
  `acct_id` int(10) unsigned NOT NULL,
  `adj_type` char(5) NOT NULL,
  `amount` decimal(11,2) DEFAULT '0.00',
  `remarks` varchar(2000) DEFAULT NULL,
  `city` char(5) NOT NULL,
  `lcu` varchar(30) DEFAULT NULL,
  `luu` varchar(30) DEFAULT NULL,
  `lcd` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `lud` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `acc_delegation`
--

DROP TABLE IF EXISTS `acc_delegation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `acc_delegation` (
  `username` varchar(30) NOT NULL,
  `delegated` varchar(30) NOT NULL,
  `lcu` varchar(30) DEFAULT NULL,
  `luu` varchar(30) DEFAULT NULL,
  `lcd` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `lud` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  UNIQUE KEY `username` (`username`,`delegated`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `acc_email_exclude`
--

DROP TABLE IF EXISTS `acc_email_exclude`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `acc_email_exclude` (
  `username` varchar(30) NOT NULL,
  `exclude_list` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `acc_import_queue`
--

DROP TABLE IF EXISTS `acc_import_queue`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `acc_import_queue` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `import_type` varchar(20) NOT NULL,
  `req_dt` datetime DEFAULT NULL,
  `fin_dt` datetime DEFAULT NULL,
  `username` varchar(30) NOT NULL,
  `status` char(1) NOT NULL,
  `class_name` varchar(250) NOT NULL,
  `ts` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `file_type` varchar(15) DEFAULT NULL,
  `file_content` longblob,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `acc_import_queue_param`
--

DROP TABLE IF EXISTS `acc_import_queue_param`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `acc_import_queue_param` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `queue_id` int(10) unsigned NOT NULL,
  `param_field` varchar(50) NOT NULL,
  `param_value` varchar(5000) DEFAULT NULL,
  `param_text` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `ts` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `acc_notify_option`
--

DROP TABLE IF EXISTS `acc_notify_option`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `acc_notify_option` (
  `username` varchar(30) NOT NULL,
  `status` char(1) DEFAULT 'N',
  `lcu` varchar(30) DEFAULT NULL,
  `luu` varchar(30) DEFAULT NULL,
  `lcd` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `lud` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `acc_queue`
--

DROP TABLE IF EXISTS `acc_queue`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `acc_queue` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `rpt_desc` varchar(250) NOT NULL,
  `req_dt` datetime DEFAULT NULL,
  `fin_dt` datetime DEFAULT NULL,
  `username` varchar(30) NOT NULL,
  `status` char(1) NOT NULL,
  `rpt_type` varchar(10) NOT NULL,
  `ts` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `rpt_content` longblob,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1347 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `acc_queue_param`
--

DROP TABLE IF EXISTS `acc_queue_param`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `acc_queue_param` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `queue_id` int(10) unsigned NOT NULL,
  `param_field` varchar(50) NOT NULL,
  `param_value` varchar(500) DEFAULT NULL,
  `ts` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7550 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `acc_request`
--

DROP TABLE IF EXISTS `acc_request`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `acc_request` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `req_dt` datetime NOT NULL,
  `req_user` varchar(30) NOT NULL,
  `payee_type` char(10) NOT NULL,
  `payee_id` int(10) unsigned NOT NULL,
  `payee_name` varchar(255) DEFAULT NULL,
  `trans_type_code` char(10) NOT NULL,
  `item_desc` varchar(1000) DEFAULT NULL,
  `amount` decimal(11,2) DEFAULT '0.00',
  `city` char(5) NOT NULL,
  `status` char(1) NOT NULL DEFAULT 'Y',
  `lcu` varchar(30) DEFAULT NULL,
  `luu` varchar(30) DEFAULT NULL,
  `lcd` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `lud` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idex_request_1` (`city`,`req_user`,`req_dt`,`payee_name`),
  KEY `idx_request_2` (`trans_type_code`)
) ENGINE=InnoDB AUTO_INCREMENT=336 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `acc_request_info`
--

DROP TABLE IF EXISTS `acc_request_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `acc_request_info` (
  `req_id` int(10) unsigned NOT NULL,
  `field_id` varchar(30) NOT NULL,
  `field_value` varchar(2000) DEFAULT NULL,
  `lcu` varchar(30) DEFAULT NULL,
  `luu` varchar(30) DEFAULT NULL,
  `lcd` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `lud` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  UNIQUE KEY `request` (`req_id`,`field_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `acc_t3_audit_dtl`
--

DROP TABLE IF EXISTS `acc_t3_audit_dtl`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `acc_t3_audit_dtl` (
  `hdr_id` int(10) unsigned NOT NULL,
  `acct_id` int(10) unsigned NOT NULL,
  `bal_month_end` decimal(11,2) DEFAULT '0.00',
  `bal_t3` decimal(11,2) DEFAULT '0.00',
  `lcu` varchar(30) DEFAULT NULL,
  `luu` varchar(30) DEFAULT NULL,
  `lcd` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `lud` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  UNIQUE KEY `audit_dtl` (`hdr_id`,`acct_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `acc_t3_audit_hdr`
--

DROP TABLE IF EXISTS `acc_t3_audit_hdr`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `acc_t3_audit_hdr` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `audit_year` smallint(6) NOT NULL,
  `audit_month` tinyint(4) NOT NULL,
  `req_user` varchar(30) DEFAULT NULL,
  `req_dt` datetime DEFAULT NULL,
  `audit_user` varchar(30) DEFAULT NULL,
  `audit_dt` datetime DEFAULT NULL,
  `remarks` varchar(2000) DEFAULT NULL,
  `bal_diff` char(1) NOT NULL DEFAULT 'N',
  `city` char(5) NOT NULL,
  `lcu` varchar(30) DEFAULT NULL,
  `luu` varchar(30) DEFAULT NULL,
  `lcd` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `lud` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `acc_trans`
--

DROP TABLE IF EXISTS `acc_trans`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `acc_trans` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `trans_dt` datetime NOT NULL,
  `trans_type_code` char(10) NOT NULL,
  `acct_id` int(10) unsigned NOT NULL,
  `trans_desc` varchar(1000) DEFAULT NULL,
  `amount` decimal(11,2) DEFAULT '0.00',
  `status` char(1) NOT NULL DEFAULT 'A',
  `city` char(5) NOT NULL,
  `lcu` varchar(30) DEFAULT NULL,
  `luu` varchar(30) DEFAULT NULL,
  `lcd` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `lud` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_acc_trans_1` (`city`,`trans_type_code`,`trans_dt`)
) ENGINE=InnoDB AUTO_INCREMENT=1560 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `acc_trans_audit_dtl`
--

DROP TABLE IF EXISTS `acc_trans_audit_dtl`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `acc_trans_audit_dtl` (
  `hdr_id` int(10) unsigned NOT NULL,
  `trans_id` int(10) unsigned NOT NULL,
  `lcu` varchar(30) DEFAULT NULL,
  `luu` varchar(30) DEFAULT NULL,
  `lcd` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `lud` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  UNIQUE KEY `audit_dtl` (`hdr_id`,`trans_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `acc_trans_audit_hdr`
--

DROP TABLE IF EXISTS `acc_trans_audit_hdr`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `acc_trans_audit_hdr` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `audit_dt` datetime NOT NULL,
  `acct_id` int(10) unsigned NOT NULL,
  `balance` decimal(11,2) DEFAULT '0.00',
  `req_user` varchar(30) DEFAULT NULL,
  `audit_user` varchar(30) DEFAULT NULL,
  `city` char(5) NOT NULL,
  `lcu` varchar(30) DEFAULT NULL,
  `luu` varchar(30) DEFAULT NULL,
  `lcd` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `lud` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `acc_trans_info`
--

DROP TABLE IF EXISTS `acc_trans_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `acc_trans_info` (
  `trans_id` int(10) unsigned NOT NULL,
  `field_id` varchar(30) NOT NULL,
  `field_value` varchar(2000) DEFAULT NULL,
  `lcu` varchar(30) DEFAULT NULL,
  `luu` varchar(30) DEFAULT NULL,
  `lcd` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `lud` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  UNIQUE KEY `trans` (`trans_id`,`field_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `acc_trans_t3`
--

DROP TABLE IF EXISTS `acc_trans_t3`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `acc_trans_t3` (
  `t3_doc_no` varchar(255) NOT NULL,
  `trans_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`t3_doc_no`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `acc_trans_type`
--

DROP TABLE IF EXISTS `acc_trans_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `acc_trans_type` (
  `trans_type_code` varchar(10) NOT NULL,
  `trans_type_desc` varchar(255) NOT NULL,
  `adj_type` char(1) NOT NULL DEFAULT 'N',
  `trans_cat` char(5) NOT NULL,
  `counter_type` varchar(10) DEFAULT NULL,
  `lcu` varchar(30) DEFAULT NULL,
  `luu` varchar(30) DEFAULT NULL,
  `lcd` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `lud` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`trans_type_code`),
  KEY `idx_trans_type_1` (`trans_cat`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `acc_trans_type_def`
--

DROP TABLE IF EXISTS `acc_trans_type_def`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `acc_trans_type_def` (
  `trans_type_code` varchar(10) NOT NULL,
  `city` char(5) NOT NULL,
  `acct_id` int(10) unsigned DEFAULT NULL,
  `lcu` varchar(30) DEFAULT NULL,
  `luu` varchar(30) DEFAULT NULL,
  `lcd` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `lud` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  UNIQUE KEY `trans` (`trans_type_code`,`city`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping routines for database 'account'
--
/*!50003 DROP FUNCTION IF EXISTS `AccountBalance` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `AccountBalance`(p_acct_id int unsigned, p_city char(5), p_fm_dt datetime, p_to_dt datetime) RETURNS decimal(11,2)
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
and a.status <> 'V' and a.city = p_city
);
RETURN balance;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `AccountBalanceByLCD` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `AccountBalanceByLCD`(p_acct_id int unsigned, p_city char(5), p_fm_dt datetime, p_to_dt datetime) RETURNS decimal(11,2)
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
and a.status <> 'V' and a.city = p_city
);
RETURN balance;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `AccountTransAmount` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `AccountTransAmount`(p_cat char(5), p_acct_id int unsigned, p_city char(5), p_fm_dt datetime, p_to_dt datetime) RETURNS decimal(11,2)
BEGIN
DECLARE balance decimal(11,2);
SET balance = (
SELECT sum(if(b.adj_type='N',a.amount,-1*a.amount))
FROM acc_trans a, acc_trans_type b
WHERE a.acct_id = p_acct_id and a.trans_type_code = b.trans_type_code
and a.trans_dt >= p_fm_dt and a.trans_dt <= p_to_dt
and a.status <> 'V' and a.city = p_city
and b.trans_cat = p_cat
);
RETURN balance;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `TransAmountByLCD` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `TransAmountByLCD`(p_cat char(5), p_acct_id int unsigned, p_city char(5), p_fm_dt datetime, p_to_dt datetime) RETURNS decimal(11,2)
BEGIN
DECLARE balance decimal(11,2);
SET balance = (
SELECT sum(if(b.adj_type='N',a.amount,-1*a.amount))
FROM acc_trans a, acc_trans_type b
WHERE a.acct_id = p_acct_id and a.trans_type_code = b.trans_type_code
and a.lcd >= p_fm_dt and a.lcd <= p_to_dt
and a.status <> 'V' and a.city = p_city
and b.trans_cat = p_cat
);
RETURN balance;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `TransAmountByLCDWoIntTrf` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `TransAmountByLCDWoIntTrf`(p_cat char(5), p_acct_id int unsigned, p_city char(5), p_fm_dt datetime, p_to_dt datetime) RETURNS decimal(11,2)
BEGIN
DECLARE balance decimal(11,2);
SET balance = (
SELECT sum(if(b.adj_type='N',a.amount,-1*a.amount))
FROM acc_trans a inner join acc_trans_type b on a.trans_type_code = b.trans_type_code
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
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2019-10-08 11:42:40
