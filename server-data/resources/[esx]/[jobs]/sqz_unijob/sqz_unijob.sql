INSERT INTO `jobs` (name, label) VALUES
	('fib', 'FIB'),
  ('sandy_mechanic', 'Sandy Mechanic')
;

INSERT INTO `job_grades` (job_name, grade, name, label, salary, skin_male, skin_female) VALUES
	('fib',0,'recruit','Recrue',20,'{}','{}'),
	('fib',1,'officer','Officier',40,'{}','{}'),
	('fib',2,'sergeant','Sergent',60,'{}','{}'),
	('fib',3,'lieutenant','Lieutenant',85,'{}','{}'),
	('fib',4,'boss','Commandant',100,'{}','{}'),

  ('sandy_mechanic',0,'recruit','Recrue',20,'{}','{}'),
	('sandy_mechanic',1,'novice','Novice',40,'{}','{}'),
	('sandy_mechanic',2,'experienced','Experienced worker',60,'{}','{}'),
	('sandy_mechanic',3,'professional','Professional worker',85,'{}','{}'),
	('sandy_mechanic',4,'boss','Boss',100,'{}','{}')
;

INSERT INTO `addon_account` (name, label, shared) VALUES
	('sandy_mechanic', 'Sandy Mechanic', 1),
	('fib', 'FIB', 1)
;

CREATE TABLE IF NOT EXISTS `sqz_unijob_inventory` (
  `vault` longtext,
  `item` varchar(50) DEFAULT NULL,
  `count` longtext,
  `label` longtext,
  `type` longtext,
  `item_id` longtext
) COMMENT='sqz_unijob_inventory';

CREATE TABLE `sqz_unijob_log` (
  `Steam` longtext,
  `OOCname` longtext,
  `Target` longtext,
  `Time` longtext,
  `Type` longtext
) COMMENT='sqz_unijob_log';

INSERT INTO `items` (`name`, `label`, `weight`) VALUES
	('cuffs', 'Hand Cuffs', 1)
;