Config = {}

Config.PlateText = 'LEGACY' -- 🚔 rented car number 🚔

Config.MaxNoJob = 1 -- 🚜 maximum number of cars for rent without work 🚜
Config.MaxJob = 3 -- 🛸 maximum number of cars that can be rented while having a job 🛸

Config.DistanseSpawn = 50.0 -- 🗺 the distance at which the car will spawn 🗺
Config.DistanseLock = 5.0 -- 🔒 the distance at which the car will be closed 🔒

Config.CarLock = true -- 🔐 If "true" the rented car can be closed and opened 🔐

Config.VehiclePositions = {            
   -- Example: 🛵 Free car rental 🛵
	{x = -1010.71, y = -2696.58, z = 13.00, h = 81.69, model = 'bmx', price = false, job = 'none'},
	{x = -1010.06, y = -2694.96, z = 13.00, h = 84.48, model = 'bmx', price = false, job = 'none'},
	{x = -1009.44, y = -2693.55, z = 13.00, h = 76.99, model = 'bmx', price = false, job = 'none'},
	{x = -1008.89, y = -2692.15, z = 13.00, h = 80.65, model = 'tribike', price = false, job = 'none'},
	{x = -1007.13, y = -2688.77, z = 13.00, h = 79.70, model = 'tribike', price = false, job = 'none'},
	{x = -1005.89, y = -2687.23, z = 13.00, h = 81.82, model = 'tribike', price = false, job = 'none'},
	{x = -1004.96, y = -2685.47, z = 13.00, h = 84.86, model = 'tribike', price = false, job = 'none'},
	{x = -1004.33, y = -2684.0, z = 13.00, h = 76.25, model = 'tribike2', price = false, job = 'none'},
	{x = -1003.42, y = -2682.40, z = 13.00, h = 73.50, model = 'tribike3', price = false, job = 'none'},
	
	{x = -1020.50, y = -2690.93, z = 13.00, h = 223.85, model = 'bmx', price = false, job = 'none'},
	{x = -1019.57, y = -2689.42, z = 13.00, h = 225.41, model = 'bmx', price = false, job = 'none'},
	{x = -1018.65, y = -2687.41, z = 13.00, h = 225.44, model = 'bmx', price = false, job = 'none'},
	{x = -1017.69, y = -2685.72, z = 13.00, h = 222.39, model = 'tribike', price = false, job = 'none'},
	{x = -1016.08, y = -2682.52, z = 13.00, h = 227.78, model = 'tribike', price = false, job = 'none'},
	{x = -1015.16, y = -2681.00, z = 13.00, h = 222.00, model = 'tribike', price = false, job = 'none'},
	{x = -1014.21, y = -2679.60, z = 13.00, h = 226.37, model = 'tribike', price = false, job = 'none'},
	{x = -1013.51, y = -2678.31, z = 13.00, h = 231.22, model = 'tribike2', price = false, job = 'none'},
	{x = -1012.58, y = -2677.08, z = 13.00, h = 226.39, model = 'tribike3', price = false, job = 'none'},
	

}	

 --/ ☢️ Information ☢️ /--
-- x, y, z, h -> vehicle coordinates
-- model -> Car model
-- price -> Price per minute car rental (if "false" then rent is free)
-- job -> The name of the fraction only she can rent a transport(If "none" then everyone can rent a transpo)

--/ 🤕 Not a bug but a feature 🤕 /--
-- When a player gets in a car that he has not rented for others,
-- he disappears, if this is removed, the player will endlessly fall
-- under the map for others, although for himself everything will be in order.

--/ 😁 There are no bugs 😁 /-- 
-- Sometimes the rented car stops opening and closing, as I understand what
-- the problem will be fixed (but this is not accurate)