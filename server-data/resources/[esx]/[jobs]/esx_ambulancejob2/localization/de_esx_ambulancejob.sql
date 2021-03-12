USE `es_extended`;

INSERT INTO `addon_account` (name, label, shared) VALUES
	('society_ambulance', 'Notdienst', 1)
;

INSERT INTO `addon_inventory` (name, label, shared) VALUES
	('society_ambulance', 'Ambulance', 1)
;

INSERT INTO `datastore` (name, label, shared) VALUES
	('society_ambulance', 'Ambulance', 1)
;

INSERT INTO `job_grades` (job_name, grade, name, label, salary, skin_male, skin_female) VALUES
	('ambulance',0,'rettungshelfer','Rettungshelfer',12000,'{}', '{}'),
	('ambulance',1,'rettungssani','Rettungssanitäter',14000,'{}', '{}'),
	('ambulance',3,'notfallsani','Notfallsanitäter',16000,'{}', '{}'),
	('ambulance',4,'arzt','Arzt',18000,'{}', '{}'),
	('ambulance',5,'notundfacharzt','Not- und Facharzt',20000,'{}', '{}'),
	('ambulance',6,'oberarzt','Oberarzt',22000,'{}', '{}'),
	('ambulance',7,'boss','Chefarzt',24000,'{}', '{}'),

	('offambulance',0,'rettungshelfer','Rettungshelfer',6000,'{}', '{}'),
	('offambulance',1,'rettungssani','Rettungssanitäter',7000,'{}', '{}'),
	('offambulance',3,'notfallsani','Notfallsanitäter',8000,'{}', '{}'),
	('offambulance',4,'arzt','Arzt',9000,'{}', '{}'),
	('offambulance',5,'notundfacharzt','Not- und Facharzt',10000,'{}', '{}'),
	('offambulance',6,'oberarzt','Oberarzt',11000,'{}', '{}'),
	('offambulance',7,'boss','Chefarzt',12000,'{}', '{}')
;

INSERT INTO `jobs` (name, label) VALUES
	('ambulance','Notdienst'),
	('offambulance', 'Außerdienst - Notdienst')
;

INSERT INTO `items` (name, label, weight) VALUES
	('bandage','Bandage', 2),
	('medikit','Medikit', 2)
;

ALTER TABLE `users`
	ADD `is_dead` TINYINT(1) NULL DEFAULT '0'
;
