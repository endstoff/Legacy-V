CREATE TABLE `apotheke` (
	`id` int NOT NULL AUTO_INCREMENT,
	`store` varchar(100) NOT NULL,
	`item` varchar(100) NOT NULL,
	`price` int NOT NULL,

	PRIMARY KEY (`id`)
);

INSERT INTO `apotheke` (store, item, price) VALUES
	('apotheke','painkillers', 120),
	('apotheke', 'packing_bandage', 150)
;
