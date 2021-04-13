
CREATE TABLE IF NOT EXISTS `cardealer` (
  `id` tinyint(4) NOT NULL DEFAULT 0,
  `label` varchar(50) DEFAULT NULL,
  `model` char(50) DEFAULT NULL,
  `manufacturer` varchar(50) DEFAULT NULL,
  `price` int(11) NOT NULL DEFAULT 0,
  `storage` smallint(6) DEFAULT 0,
  `bigstorage` smallint(6) DEFAULT 0,
  `ps` smallint(6) DEFAULT 0,
  `maxSpeed` smallint(6) DEFAULT 0,
  `speedUp` float DEFAULT 0,
  `modification` smallint(6) DEFAULT 0,
  `tankcapacity` smallint(6) DEFAULT 0,
  `orderd` smallint(6) DEFAULT 0,
  `ordertotal` smallint(6) DEFAULT 0,
  `lastorder` bigint(20) DEFAULT NULL,
  `producetotal` smallint(6) DEFAULT 0,
  `produced` smallint(6) DEFAULT 0,
  `time` smallint(6) DEFAULT 0,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


DELETE FROM `cardealer`;
INSERT INTO `cardealer` (`id`, `label`, `model`, `manufacturer`, `price`, `storage`, `bigstorage`, `ps`, `maxSpeed`, `speedUp`, `modification`, `tankcapacity`, `orderd`, `ordertotal`, `lastorder`, `producetotal`, `produced`, `time`) VALUES
	(14, 'Reaper', 'reaper', 'Pegassi', 465700, 1, 2, 360, 320, 2.9, 6, 60, 0, 0, 1615219775, 0, 0, 140),
	(15, 'Penetrator', 'penetrator', 'Ocelot', 478200, 1, 2, 360, 300, 2.8, 6, 60, 0, 0, 1615219805, 0, 0, 140),
	(16, 'Entity XF', 'entityxf', 'Overflod', 432400, 1, 2, 350, 122, 2.5, 6, 60, 0, 0, 1604260527, 0, 0, 140),
	(17, 'Entity XXR', 'entity2', 'Overflod', 432400, 1, 2, 410, 310, 2.6, 9, 65, 0, 0, 1615219808, 0, 0, 140),
	(18, 'ETR1', 'sheava', 'Emperor', 400000, 1, 2, 356, 298, 2.8, 12, 60, 0, 0, 1615219810, 0, 0, 140),
	(19, 'FMJ', 'fmj', 'Vapid', 378000, 1, 2, 343, 278, 2.4, 12, 60, 0, 0, 1604260527, 0, 0, 140),
	(20, 'GP1', 'gp1', 'Progen', 423700, 1, 2, 387, 256, 2.2, 12, 60, 0, 0, 1604260527, 0, 0, 140),
	(21, 'Infernus', 'infernus', 'Pegassi', 353700, 1, 2, 398, 287, 2.9, 12, 60, 0, 0, 1615219814, 0, 0, 140),
	(22, 'Itali GTB Custom', 'italigtb2', 'Progen', 453600, 1, 2, 412, 301, 2.7, 10, 60, 0, 0, 1604260527, 0, 0, 140),
	(23, 'Nero', 'nero', 'Truffade', 400000, 1, 2, 434, 300, 2.6, 10, 60, 0, 0, 1604260527, 0, 0, 140);


INSERT INTO `addon_account` (name, label, shared) VALUES
	('society_cardealer','Cardealer',1)
;

INSERT INTO `addon_inventory` (name, label, shared) VALUES
	('society_cardealer','Cardealer',1)
;

INSERT INTO `jobs` (name, label) VALUES
	('cardealer','Cardealer')
;

INSERT INTO `job_grades` (job_name, grade, name, label, salary, skin_male, skin_female) VALUES
	('cardealer',0,'recruit','Recrue',10,'{}','{}'),
	('cardealer',1,'novice','Novice',25,'{}','{}'),
	('cardealer',2,'experienced','Experimente',40,'{}','{}'),
	('cardealer',3,'boss','Patron',0,'{}','{}')
;
