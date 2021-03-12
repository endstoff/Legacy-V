
CREATE TABLE `nutzfahrzeuge_categories` (
	`name` varchar(60) NOT NULL,
	`label` varchar(60) NOT NULL,

	PRIMARY KEY (`name`)
);

INSERT INTO `nutzfahrzeuge_categories` (name, label) VALUES
	('vans','Vans'),
	('trucks','Trucks'),
	('trailers', 'Hänger')
;

CREATE TABLE `nutzfahrzeuge` (
	`name` varchar(60) NOT NULL,
	`model` varchar(60) NOT NULL,
	`price` int(11) NOT NULL,
	`category` varchar(60) DEFAULT NULL,

	PRIMARY KEY (`model`)
);

INSERT INTO `nutzfahrzeuge` (name, model, price, category) VALUES
	('Bobcat', 'bobcatxl', 100000, 'vans'),
	('Burrito', 'burrito', 30000, 'vans'),
	('Camper', 'camper', 50000, 'vans'),
	('Gang Burrito', 'gburrito', 80000, 'vans'),
	('Gang Burrito 2', 'gburrito2', 80000, 'vans'),
	('Journey', 'journey', 10000, 'vans'),

	('Benson', 'benson', 350000, 'trucks'),
	('Pounder', 'pounder', 500000, 'trucks'),
	('Hauler', 'hauler', 625000, 'trailers')
;