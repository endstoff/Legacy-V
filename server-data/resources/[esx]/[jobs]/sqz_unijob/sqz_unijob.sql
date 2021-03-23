INSERT INTO `jobs` (name, label) VALUES
('yakuza', 'Yakuza')
;

INSERT INTO `job_grades` (job_name, grade, name, label, salary, skin_male, skin_female) VALUES
	('yakuza',0,'officer','Shingiin',0,'{}','{}'),
	('yakuza',1,'sergeant','Komon',0,'{}','{}'),
	('yakuza',2,'lieutenant','Wakagashira',0,'{}','{}'),
	('yakuza',3,'boss','Oyabun',0,'{}','{}')
;

INSERT INTO `addon_account` (name, label, shared) VALUES
	('yakuza', 'Yakuza', 1)
;
