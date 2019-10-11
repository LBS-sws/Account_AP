-- MySQL dump 10.13  Distrib 5.7.27, for Linux (x86_64)
--
-- Host: localhost    Database: workflow
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
-- Table structure for table `wf_action`
--

DROP TABLE IF EXISTS `wf_action`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `wf_action` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `proc_ver_id` int(10) unsigned NOT NULL,
  `code` varchar(15) NOT NULL,
  `name` varchar(255) NOT NULL,
  `lcd` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `lud` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=124 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `wf_action_task`
--

DROP TABLE IF EXISTS `wf_action_task`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `wf_action_task` (
  `action_id` int(10) unsigned NOT NULL,
  `task_id` int(10) unsigned NOT NULL,
  `seq_no` int(10) unsigned NOT NULL,
  `lcd` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `lud` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `wf_process`
--

DROP TABLE IF EXISTS `wf_process`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `wf_process` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `code` varchar(15) NOT NULL,
  `name` varchar(255) NOT NULL,
  `lcd` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `lud` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `wf_process_version`
--

DROP TABLE IF EXISTS `wf_process_version`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `wf_process_version` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `process_id` int(10) unsigned NOT NULL,
  `start_dt` datetime NOT NULL,
  `end_dt` datetime NOT NULL,
  `lcd` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `lud` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `wf_request`
--

DROP TABLE IF EXISTS `wf_request`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `wf_request` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `proc_ver_id` int(10) unsigned NOT NULL,
  `current_state` int(10) unsigned NOT NULL,
  `doc_id` int(10) unsigned NOT NULL,
  `lcd` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `lud` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_request_01` (`proc_ver_id`,`doc_id`)
) ENGINE=InnoDB AUTO_INCREMENT=340 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `wf_request_data`
--

DROP TABLE IF EXISTS `wf_request_data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `wf_request_data` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `request_id` int(10) unsigned NOT NULL,
  `data_name` varchar(100) NOT NULL,
  `data_value` varchar(5000) DEFAULT NULL,
  `lcd` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `lud` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `request` (`request_id`,`data_name`)
) ENGINE=InnoDB AUTO_INCREMENT=1873 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `wf_request_resp_user`
--

DROP TABLE IF EXISTS `wf_request_resp_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `wf_request_resp_user` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `request_id` int(10) unsigned NOT NULL,
  `log_id` int(10) unsigned NOT NULL,
  `current_state` int(10) unsigned NOT NULL,
  `username` varchar(30) NOT NULL,
  `status` char(1) NOT NULL DEFAULT 'P',
  `action_id` int(10) unsigned DEFAULT '0',
  `remarks` varchar(5000) DEFAULT NULL,
  `lcd` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `lud` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_request_resp_user_01` (`request_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2500 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `wf_request_transit_log`
--

DROP TABLE IF EXISTS `wf_request_transit_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `wf_request_transit_log` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `request_id` int(10) unsigned NOT NULL,
  `old_state` int(10) unsigned NOT NULL,
  `new_state` int(10) unsigned NOT NULL,
  `lcd` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `lud` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_req_txn_log_1` (`request_id`,`old_state`),
  KEY `idx_req_txn_log_2` (`request_id`,`new_state`)
) ENGINE=InnoDB AUTO_INCREMENT=2622 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `wf_state`
--

DROP TABLE IF EXISTS `wf_state`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `wf_state` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `proc_ver_id` int(10) unsigned NOT NULL,
  `code` char(2) NOT NULL,
  `name` varchar(255) NOT NULL,
  `lcd` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `lud` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=128 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `wf_task`
--

DROP TABLE IF EXISTS `wf_task`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `wf_task` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `proc_ver_id` int(10) unsigned NOT NULL,
  `name` varchar(255) NOT NULL,
  `function_call` varchar(255) NOT NULL,
  `param` varchar(1000) DEFAULT NULL,
  `lcd` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `lud` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=149 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `wf_transition`
--

DROP TABLE IF EXISTS `wf_transition`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `wf_transition` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `proc_ver_id` int(10) unsigned NOT NULL,
  `current_state` int(10) unsigned NOT NULL,
  `next_state` int(10) unsigned NOT NULL,
  `lcd` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `lud` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=89 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping routines for database 'workflow'
--
/*!50003 DROP FUNCTION IF EXISTS `ActionPerson` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `ActionPerson`(p_proc_code varchar(15), p_doc_id int unsigned, p_req_dt datetime, p_code char(2)) RETURNS varchar(30) CHARSET utf8
BEGIN
DECLARE action_user varchar(30);
SET action_user = (
SELECT e.username
FROM wf_request a, wf_process b, wf_process_version c, wf_state d, wf_request_resp_user e
WHERE a.proc_ver_id = c.id
and b.id = c.process_id
and e.current_state = d.id
and d.code = p_code 
and b.code = p_proc_code
and c.start_dt <= p_req_dt
and c.end_dt >= p_req_dt
and a.doc_id = p_doc_id
and a.id = e.request_id
and e.status = 'C'
order by e.id desc 
LIMIT 1
);
RETURN action_user;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `RequestStatus` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `RequestStatus`(p_proc_code varchar(15), p_doc_id int unsigned, p_req_dt datetime) RETURNS char(2) CHARSET utf8
BEGIN
DECLARE status char(2);
SET status = (
SELECT d.code
FROM wf_request a, wf_process b, wf_process_version c, wf_state d 
WHERE a.proc_ver_id = c.id
and b.id = c.process_id
and a.current_state = d.id
and b.code = p_proc_code
and c.start_dt <= p_req_dt
and c.end_dt >= p_req_dt
and a.doc_id = p_doc_id
LIMIT 1
);
RETURN status;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `RequestStatusDate` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `RequestStatusDate`(p_proc_code varchar(15), p_doc_id int unsigned, p_req_dt datetime, p_code char(2)) RETURNS datetime
BEGIN
DECLARE status_dt datetime;
SET status_dt = (
SELECT e.lcd
FROM wf_request a, wf_process b, wf_process_version c, wf_state d, wf_request_transit_log e
WHERE a.proc_ver_id = c.id
and b.id = c.process_id
and e.new_state = d.id
and d.code = p_code 
and b.code = p_proc_code
and c.start_dt <= p_req_dt
and c.end_dt >= p_req_dt
and a.doc_id = p_doc_id
and a.id = e.request_id
order by e.id desc 
LIMIT 1
);
RETURN status_dt;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `RequestStatusDesc` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `RequestStatusDesc`(p_proc_code varchar(15), p_doc_id int unsigned, p_req_dt datetime) RETURNS char(255) CHARSET utf8
BEGIN
DECLARE status_desc char(255);

SET status_desc = (
SELECT IF(d.code<>'ED',d.name,CONCAT(f.name,' (',d.name,')')) as status_desc
FROM wf_request a, wf_process b, wf_process_version c, wf_state d, wf_request_transit_log e, wf_state f 
WHERE a.proc_ver_id = c.id
and b.id = c.process_id
and a.current_state = d.id
and b.code = p_proc_code
and c.start_dt <= p_req_dt
and c.end_dt >= p_req_dt
and a.doc_id = p_doc_id
and a.id = e.request_id
and a.current_state = e.new_state
and e.old_state = f.id
order by e.id desc 
LIMIT 1
);
RETURN status_desc;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `RequestStatusEx` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `RequestStatusEx`(p_proc_code varchar(15), p_doc_id int unsigned, p_req_dt datetime) RETURNS char(2) CHARSET utf8
BEGIN
DECLARE status char(2);

SET status = (
SELECT IF(d.code<>'ED',d.code,f.code) as status
FROM wf_request a, wf_process b, wf_process_version c, wf_state d, wf_request_transit_log e, wf_state f 
WHERE a.proc_ver_id = c.id
and b.id = c.process_id
and a.current_state = d.id
and b.code = p_proc_code
and c.start_dt <= p_req_dt
and c.end_dt >= p_req_dt
and a.doc_id = p_doc_id
and a.id = e.request_id
and a.current_state = e.new_state
and e.old_state = f.id
order by e.id desc 
LIMIT 1
);
RETURN status;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `addAction` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `addAction`(p_ver_id int unsigned, p_code varchar(15), p_name varchar(255))
BEGIN
  INSERT INTO wf_action(proc_ver_id, code, name)
  VALUES (p_ver_id, p_code, p_name);

  SELECT * FROM wf_action WHERE id = LAST_INSERT_ID();
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `addActionTask` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `addActionTask`(p_ver_id int unsigned, p_action varchar(15), p_seq int unsigned, p_task varchar(255))
BEGIN
  DECLARE p_action_id int unsigned;
  DECLARE p_task_id int unsigned;

  SET p_action_id = (SELECT id FROM wf_action WHERE proc_ver_id=p_ver_id AND code=p_action);
  SET p_task_id = (SELECT id FROM wf_task WHERE proc_ver_id=p_ver_id AND name=p_task);

  IF EXISTS(SELECT action_id FROM wf_action_task WHERE action_id=p_action_id AND seq_no=p_seq) THEN
    UPDATE wf_action_task SET task_id = p_task_id WHERE action_id=p_action_id AND seq_no=p_seq;
  ELSE
    INSERT INTO wf_action_task(action_id, seq_no, task_id)
    VALUES (p_action_id, p_seq, p_task_id);
  END IF;

  SELECT * FROM wf_action_task WHERE action_id=p_action_id AND seq_no=p_seq;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `addState` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `addState`(p_ver_id int unsigned, p_code varchar(15), p_name varchar(255))
BEGIN
  INSERT INTO wf_state(proc_ver_id, code, name)
  VALUES (p_ver_id, p_code, p_name);

  SELECT * FROM wf_state WHERE id = LAST_INSERT_ID();
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `addTask` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `addTask`(p_ver_id int unsigned, p_name varchar(255), p_function varchar(255), p_param varchar(1000))
BEGIN
  INSERT INTO wf_task(proc_ver_id, name, function_call, param)
  VALUES (p_ver_id, p_name, p_function, p_param);

  SELECT * FROM wf_task WHERE id = LAST_INSERT_ID();
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `addTransition` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `addTransition`(p_ver_id int unsigned, p_from_state varchar(15), p_to_state varchar(15))
BEGIN
  DECLARE from_state_id int unsigned;
  DECLARE to_state_id int unsigned;

  SET from_state_id = (SELECT id FROM wf_state WHERE proc_ver_id=p_ver_id AND code=p_from_state);
  SET to_state_id = (SELECT id FROM wf_state WHERE proc_ver_id=p_ver_id AND code=p_to_state);

  IF NOT EXISTS(SELECT id FROM wf_transition WHERE proc_ver_id=p_ver_id AND current_state=from_state_id AND next_state=to_state_id) THEN
    INSERT INTO wf_transition(proc_ver_id, current_state, next_state)
    VALUES (p_ver_id, from_state_id, to_state_id);
  END IF;

  SELECT * FROM wf_transition WHERE id = LAST_INSERT_ID();
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `CopyWorkflow` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `CopyWorkflow`(p_from_ver_id int unsigned, p_to_ver_id int unsigned)
BEGIN
  DELETE FROM wf_action_task WHERE action_id IN (
    SELECT id FROM wf_action WHERE proc_ver_id = p_to_ver_id
  );
  
  DELETE FROM wf_action WHERE proc_ver_id = p_to_ver_id;
  
  DELETE FROM wf_state WHERE proc_ver_id = p_to_ver_id;
  
  DELETE FROM wf_task WHERE proc_ver_id = p_to_ver_id;
  
  DELETE FROM wf_transition WHERE proc_ver_id = p_to_ver_id;
  
  INSERT INTO wf_action(proc_ver_id, code, name)
    SELECT p_to_ver_id, code, name
FROM wf_action
WHERE proc_ver_id = p_from_ver_id;
  
  INSERT INTO wf_state(proc_ver_id, code, name)
    SELECT p_to_ver_id, code, name
FROM wf_state
WHERE proc_ver_id = p_from_ver_id;

  INSERT INTO wf_task(proc_ver_id, name, function_call, param)
    SELECT p_to_ver_id, name, function_call, param
FROM wf_task
WHERE proc_ver_id = p_from_ver_id;
  
  INSERT INTO wf_transition(proc_ver_id, current_state, next_state)
    SELECT p_to_ver_id, d.id, e.id
FROM wf_transition a, wf_state b, wf_state c, wf_state d, wf_state e
WHERE a.proc_ver_id = p_from_ver_id 
AND a.current_state = b.id 
AND a.next_state = c.id
AND b.code = d.code AND d.proc_ver_id = p_to_ver_id
AND c.code = e.code AND e.proc_ver_id = p_to_ver_id
;
  
  INSERT INTO wf_action_task(action_id, task_id, seq_no)
    SELECT c.id, e.id, a.seq_no
FROM wf_action_task a, wf_action b, wf_action c, wf_task d, wf_task e
WHERE a.action_id IN (SELECT x.id FROM wf_action x WHERE x.proc_ver_id = p_from_ver_id)
AND a.action_id = b.id 
AND b.code = c.code AND c.proc_ver_id = p_to_ver_id
AND a.task_id = d.id
AND d.name = e.name AND e.proc_ver_id = p_to_ver_id
AND d.function_call = e.function_call AND d.param = e.param
    ;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `ShowActionTask` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `ShowActionTask`(p_ver_id int unsigned)
BEGIN
  SELECT b.code, b.name, a.seq_no, c.name, c.function_call, c.param
  FROM wf_action_task a, wf_action b, wf_task c
  WHERE a.action_id = b.id AND b.proc_ver_id = p_ver_id
  AND a.task_id = c.id AND c.proc_ver_id = p_ver_id
  ORDER BY b.code, a.seq_no
  ;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `ShowTransition` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `ShowTransition`(p_ver_id int unsigned)
BEGIN
  SELECT a.proc_ver_id, b.code, b.name, c.code, c.name
  FROM wf_transition a, wf_state b, wf_state c
  WHERE a.proc_ver_id = p_ver_id
  AND a.current_state = b.id 
  AND a.next_state = c.id
  ORDER BY a.current_state, a.next_state
  ;
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

-- Dump completed on 2019-10-08 11:42:59
