INSERT INTO `addon_account` (name, label, shared) VALUES
	('society_bcustoms', 'Bloods Customs', 1)
;

INSERT INTO `addon_inventory` (name, label, shared) VALUES
	('society_bcustoms', 'Bloods Customs', 1)
;

INSERT INTO `jobs` (name, label) VALUES
	('bcustoms', 'Bloods Customs'),
	('offbcustoms', 'Bloods Customs Außerdienst')
;

INSERT INTO `job_grades` (job_name, grade, name, label, salary, skin_male, skin_female) VALUES
	('bcustoms',0,'recrue','Azubi',3600,'{}','{}'),
	('bcustoms',1,'novice','Tuner',6000,'{}','{}'),
	('bcustoms',2,'experimente','Tuner Meister',7800,'{}','{}'),
	('bcustoms',3,'chief',"Werkstattleiter",9000,'{}','{}'),
	('bcustoms',4,'boss','CEO',13500,'{}','{}'),

	('offbcustoms',0,'recrue','Azubi',3600,'{}','{}'),
	('offbcustoms',1,'novice','Tuner',6000,'{}','{}'),
	('offbcustoms',2,'experimente','Tuner Meister',7800,'{}','{}'),
	('offbcustoms',3,'chief','Werkstattleiter',9000,'{}','{}'),
	('offbcustoms',4,'boss','CEO',13500,'{}','{}')
;
