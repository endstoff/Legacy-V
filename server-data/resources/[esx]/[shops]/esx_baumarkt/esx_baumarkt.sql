CREATE TABLE `baumarkt` (
	`id` int NOT NULL AUTO_INCREMENT,
	`store` varchar(100) NOT NULL,
	`item` varchar(100) NOT NULL,
	`price` int NOT NULL,

	PRIMARY KEY (`id`)
);

INSERT INTO `baumarkt` (store, item, price) VALUES
	('baumarkt','fixkit',500)
;
