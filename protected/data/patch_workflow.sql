DROP TABLE IF EXISTS `wf_process_city`;
CREATE TABLE `wf_process_city` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `city` char(5) NOT NULL,
  `code` varchar(15) NOT NULL,
  `process_code` varchar(15) NOT NULL,
  `start_dt` datetime NOT NULL,
  `end_dt` datetime NOT NULL,
  `lcd` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `lud` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO wf_process_city(city, code, process_code, start_dt, end_dt) VALUES
('~DEF~','PAYMENT','PAYMENT','2018-01-01','2099-12-31');

DROP FUNCTION IF EXISTS `ActionPerson`;
DELIMITER ;;
CREATE FUNCTION `ActionPerson`(p_city char(5), p_proc_code varchar(15), p_doc_id int unsigned, p_req_dt datetime, p_code char(2)) RETURNS varchar(30) CHARSET utf8
BEGIN
DECLARE action_user varchar(30);
SET action_user = (
SELECT e.username
FROM wf_request a, wf_process b, wf_process_version c, wf_state d, wf_request_resp_user e, wf_process_city f
WHERE a.proc_ver_id = c.id
and b.id = c.process_id
and e.current_state = d.id
and d.code = p_code 
and b.code = f.process_code
and c.start_dt <= p_req_dt
and c.end_dt >= p_req_dt
and a.doc_id = p_doc_id
and a.id = e.request_id
and e.status = 'C'
and f.start_dt <= p_req_dt
and f.end_dt >= p_req_dt
and (f.city = p_city or f.city='~DEF~')
and f.code = p_proc_code
order by f.city, e.id desc 
LIMIT 1
);
RETURN action_user;
END ;;
DELIMITER ;

DROP FUNCTION IF EXISTS `RequestStatus`;
DELIMITER ;;
CREATE FUNCTION `RequestStatus`(p_city char(5), p_proc_code varchar(15), p_doc_id int unsigned, p_req_dt datetime) RETURNS char(2) CHARSET utf8
BEGIN
DECLARE status char(2);
SET status = (
SELECT d.code
FROM wf_request a, wf_process b, wf_process_version c, wf_state d, wf_process_city e 
WHERE a.proc_ver_id = c.id
and b.id = c.process_id
and a.current_state = d.id
and b.code = e.process_code
and c.start_dt <= p_req_dt
and c.end_dt >= p_req_dt
and a.doc_id = p_doc_id
and e.start_dt <= p_req_dt
and e.end_dt >= p_req_dt
and (e.city = p_city or e.city='~DEF~')
and e.code = p_proc_code
order by e.city 
LIMIT 1
);
RETURN status;
END ;;

DROP FUNCTION IF EXISTS `RequestStatusDate`;
DELIMITER ;;
CREATE FUNCTION `RequestStatusDate`(p_city char(5), p_proc_code varchar(15), p_doc_id int unsigned, p_req_dt datetime, p_code char(2)) RETURNS datetime
BEGIN
DECLARE status_dt datetime;
SET status_dt = (
SELECT e.lcd
FROM wf_request a, wf_process b, wf_process_version c, wf_state d, wf_request_transit_log e, wf_process_city f
WHERE a.proc_ver_id = c.id
and b.id = c.process_id
and e.new_state = d.id
and d.code = p_code 
and b.code = f.process_code
and c.start_dt <= p_req_dt
and c.end_dt >= p_req_dt
and a.doc_id = p_doc_id
and a.id = e.request_id
and f.start_dt <= p_req_dt
and f.end_dt >= p_req_dt
and (f.city = p_city or f.city='~DEF~')
and f.code = p_proc_code
order by f.city, e.id desc 
LIMIT 1
);
RETURN status_dt;
END ;;

DROP FUNCTION IF EXISTS `RequestStatusDesc`;
DELIMITER ;;
CREATE FUNCTION `RequestStatusDesc`(p_city char(5), p_proc_code varchar(15), p_doc_id int unsigned, p_req_dt datetime) RETURNS char(255) CHARSET utf8
BEGIN
DECLARE status_desc char(255);

SET status_desc = (
SELECT IF(d.code<>'ED',d.name,CONCAT(f.name,' (',d.name,')')) as status_desc
FROM wf_request a, wf_process b, wf_process_version c, wf_state d, wf_request_transit_log e, wf_state f, wf_process_city g 
WHERE a.proc_ver_id = c.id
and b.id = c.process_id
and a.current_state = d.id
and b.code = g.process_code
and c.start_dt <= p_req_dt
and c.end_dt >= p_req_dt
and a.doc_id = p_doc_id
and a.id = e.request_id
and a.current_state = e.new_state
and e.old_state = f.id
and g.start_dt <= p_req_dt
and g.end_dt >= p_req_dt
and (g.city = p_city or g.city='~DEF~')
and g.code = p_proc_code
order by g.city, e.id desc 
LIMIT 1
);
RETURN status_desc;
END ;;
DELIMITER ;

DROP FUNCTION IF EXISTS `RequestStatusEx`;
DELIMITER ;;
CREATE FUNCTION `RequestStatusEx`(p_city char(5), p_proc_code varchar(15), p_doc_id int unsigned, p_req_dt datetime) RETURNS char(2) CHARSET utf8
BEGIN
DECLARE status char(2);

SET status = (
SELECT IF(d.code<>'ED',d.code,f.code) as status
FROM wf_request a, wf_process b, wf_process_version c, wf_state d, wf_request_transit_log e, wf_state f, wf_process_city g 
WHERE a.proc_ver_id = c.id
and b.id = c.process_id
and a.current_state = d.id
and b.code = g.process_code
and c.start_dt <= p_req_dt
and c.end_dt >= p_req_dt
and a.doc_id = p_doc_id
and a.id = e.request_id
and a.current_state = e.new_state
and e.old_state = f.id
and g.start_dt <= p_req_dt
and g.end_dt >= p_req_dt
and (g.city = p_city or g.city='~DEF~')
and g.code = p_proc_code
order by g.city, e.id desc 
LIMIT 1
);
RETURN status;
END ;;
DELIMITER ;
