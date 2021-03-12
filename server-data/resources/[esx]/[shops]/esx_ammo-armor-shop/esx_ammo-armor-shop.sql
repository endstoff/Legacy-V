CREATE TABLE `ammo-armor` (
	`id` int NOT NULL AUTO_INCREMENT,
	`store` varchar(100) NOT NULL,
	`item` varchar(100) NOT NULL,
	`price` int NOT NULL,

	PRIMARY KEY (`id`)
);

INSERT INTO `ammo-armor` (store, item, price) VALUES
	('ammo-armor', 't_ammoclip', 2500),
	('ammo-armor', 't1_armour', 5000),
	('ammo-armor', 't2_armour', 7500),
	('ammo-armor', 't3_armour', 10000),
	('ammo-armor', 't4_armour', 15000)
;
