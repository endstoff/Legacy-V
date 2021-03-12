CREATE TABLE `handyladen` (
	`id` int NOT NULL AUTO_INCREMENT,
	`store` varchar(100) NOT NULL,
	`item` varchar(100) NOT NULL,
	`price` int NOT NULL,

	PRIMARY KEY (`id`)
);

INSERT INTO `handyladen` (store, item, price) VALUES
	('handyladen','phone',80),
	('handyladen', 'radio', 40)
;
