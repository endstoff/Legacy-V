
CREATE TABLE IF NOT EXISTS `phone_banking` (
  `identifier` varchar(255) NOT NULL,
  `cardnumber` varchar(255) NOT NULL,
  `expiredate` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`identifier`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS `phone_banking_transactions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `cardnumber` varchar(50) NOT NULL,
  `cardname` varchar(50) DEFAULT NULL,
  `targetnumber` varchar(50) NOT NULL,
  `targetname` varchar(50) NOT NULL,
  `date` varchar(50) NOT NULL,
  `amount` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=54 DEFAULT CHARSET=utf8mb4;
