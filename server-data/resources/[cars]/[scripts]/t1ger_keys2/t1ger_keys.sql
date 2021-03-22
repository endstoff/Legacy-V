ALTER TABLE `owned_vehicles`
ADD `gotKey` int(11) NOT NULL DEFAULT 0, 
ADD `alarm` int(11) NOT NULL DEFAULT 0;


INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
('rolpaper', 'Zigarettenpapier', 5, 0, 1),
('goldwatch', 'Gold Uhr', 5, 0, 1),
('sandwich', 'Sandwich', 5, 0, 1),
('repairkit', 'Reparaturkit', 5, 0, 1),
('donut', 'Donut', 5, 0, 1),
('coke1g', 'Gasflasche', 5, 0, 1);