INSERT INTO `addon_account` (name, label, shared) VALUES
	('society_bennys', 'Bennys', 1)
;

INSERT INTO `addon_inventory` (name, label, shared) VALUES
	('society_bennys', 'Bennys', 1)
;

INSERT INTO `datastore` (name, label, shared) VALUES
	('society_bennys', 'Bennys', 1)
;

INSERT INTO `jobs` (name, label) VALUES
	('bennys', 'Bennys'),
	('offbennys', 'Bennys Ausserdienst')
;

INSERT INTO `job_grades` (job_name, grade, name, label, salary, skin_male, skin_female) VALUES
	('bennys',0,'recrue','Azubi',3600,'{}','{}'),
	('bennys',1,'novice','Tuner',6000,'{}','{}'),
	('bennys',2,'experimente','Tuner Meister',7800,'{}','{}'),
	('bennys',3,'chief','Werkstattleiter',9000,'{}','{}'),
	('bennys',4,'boss','CEO',13500,'{}','{}'),

	('offbennys',0,'recrue','Azubi',3600,'{}','{}'),
	('offbennys',1,'novice','Tuner',6000,'{}','{}'),
	('offbennys',2,'experimente','Tuner Meister',7800,'{}','{}'),
	('offbennys',3,'chief','Werkstattleiter',9000,'{}','{}'),
	('offbennys',4,'boss','CEO',13500,'{}','{}')
;

INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
('gazbottle', 'Gasflasche', 5, 0, 1),
('fixtool', 'Reparaturteile', 5, 0, 1),
('carotool', 'Karosserieteile', 5, 0, 1),
('blowpipe', 'Bunsenbrenner', 5, 0, 1),
('fixkit', 'Reparatur-Kit', 5, 0, 1),
('carokit', 'Bodykit', 5, 0, 1)
;
