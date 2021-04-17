INSERT INTO `addon_account` (name, label, shared) VALUES
	('society_acls', 'ACLS', 1)
;

INSERT INTO `addon_inventory` (name, label, shared) VALUES
	('society_acls', 'ACLS', 1)
;

INSERT INTO `jobs` (name, label) VALUES
	('acls', 'acls'),
	('offacls', 'ACLS Außerdienst')
;

INSERT INTO `job_grades` (job_name, grade, name, label, salary, skin_male, skin_female) VALUES
	('acls',0,'recrue','Azubi',300,'{}','{}'),
	('acls',1,'novice','Geselle',700,'{}','{}'),
	('acls',2,'experimente','Meister',1000,'{}','{}'),
	('acls',3,'chief',"Werkstattleiter",1500,'{}','{}'),
	('acls',4,'boss','CEO',2000,'{}','{}'),

	('offacls',0,'recrue','Azubi',150,'{}','{}'),
	('offacls',1,'novice','Geselle',350,'{}','{}'),
	('offacls',2,'experimente','Meister',500,'{}','{}'),
	('offacls',3,'chief','Werkstattleiter',750,'{}','{}'),
	('offacls',4,'boss','CEO',1000,'{}','{}')
;
