
CREATE TABLE IF NOT EXISTS `farm_owner` (
  `id` int(11) NOT NULL,
  `owner` varchar(60) DEFAULT NULL,
  `farm` varchar(255) DEFAULT NULL,
  `type` varchar(50) DEFAULT NULL,
  `upgraded` int(11) NOT NULL,
  `vehicle` varchar(11) DEFAULT NULL,
  `store` int(11) NOT NULL,
  `finish` int(11) NOT NULL,
  `lastlogin` bigint(20) DEFAULT NULL,
  `trusted` varchar(1000) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


ALTER TABLE `users`ADD COLUMN `last_farm` VARCHAR(255);