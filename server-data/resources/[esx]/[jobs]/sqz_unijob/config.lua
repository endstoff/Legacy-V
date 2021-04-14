Config                            = {}
Config.DrawDistance               = 5.0 -- Distance in GTA units you will see the markers
Config.DrawTextDistance			  = 2.0 -- Distance in GTA units from which you will see the DrawTex3D (if is enabled)
--JobConfig
Config.Jobs						  = {} 
Config.MaxInService               = -1
Config.Locale                     = 'de'
Config.UseAnimations			  = true -- Enables/Diasbles animations for fixing vehicle, writing bills and etc. ...
Config.UseMythic_Progressbar	  = false -- Enables/Diasbles opening Mythic progress bar while doing an animation
Config.NeedItemCuffs			  = true -- Enables/Diasbles requirement of handcuffs as item
Config.UseLegacyFuel			  = false -- If true, your vehicle after taking it from garage will have 100% fuel (requires LegacyFuel script)
Config.ShowImpoundNotification	  = true -- Choose, if you want to play an animation while impounding a vehicle
Config.ImpoundAnimationWaitTime	  = 10 * 1000 -- Time, how long the animation for impounding a vehicle will be
Config.EnableLicenses			  = true
Config.MenuAlign 				  = 'top-left' -- Position of ESX Menu
Config.CuffItemName				  = 'ziptie' -- The item name in database you need to have in your inventory to bee able to cuff somebody
Config.GetClientESXEvent  		  = 'esx:getSharedObject' -- Client get ESX event name
Config.FontId					  = 4 -- Config Text Font Id, which is used in DrawText3Ds, you can change it, but must be a number

--Armories part
Config.UseCustomOpenMenuInventory = false -- Change to true if you want to use custom function in client/edit.lua to open the deposit stock menu, leave it false if you want to use esx_menu inventory
Config.UseCustomOpenMenuWeapons = false -- Change to true if you want to use custom function in client/edit.lua to open the deposit weapons menu, leave it false if you want to use esx_menu inventory
Config.UseCustomGetItemsMenu = false -- Change to true if you want to use custom function in client/edit.lua to open the get items menu, leave it false if you want to use esx_menu inventory
Config.UseCustomGetWeaponsMenu = false -- Change to true if you want to use custom function in client/edit.lua to open the get weapons menu, leave it false if you want to use esx_menu inventory

-- Custom markers
Config.UseCustomMarkers = false -- If using custom markers editable in client/edit.lua
Config.CustomMarkerDistance = 2.0 -- Distance in GTA units you need to be close to the marker to be drawn

-- Garages
Config.UseCustomGarageEvents = false -- Enable this if you do not want to use the default, sqz_unijob menu and you want to use your custom, check edit.lua for this

-- Custom events (edit in case you use any custom events)
Config.customEvents = {
    ['esx_billing:sendBill'] = 'esx_billing:sendBill', -- You can change the event if you for example use anticheats/you have editted event like esx_billing:sendSuperSecretEventSquizerBill
    ['esx_society:openBossMenu'] = 'esx_society:openBossMenu',
	['esx:setJob'] = 'esx:setJob',
	['esx_ambulancejob:revive'] = 'esx_ambulancejob:revive',
	['mythic_progressbar:client:progress'] = 'mythic_progbar:client:progress',
	['esx_eden_clotheshop:getPlayerDressing'] = 'esx_eden_clotheshop:getPlayerDressing',
	['esx_eden_clotheshop:getPlayerOutfit'] = 'esx_eden_clotheshop:getPlayerOutfit'
}

Config.AlloweAccountsToDeposit = { -- The account name which is allowed to be deposit to the vault
	["bank"] = false, -- Just remove any of these if you do not want to use them
	["black_money"] = false
}

Config.Blips = {
	bmeister = {
		BlipCoords = vector3(-1570.9909667969, -574.87689208984, 108.52294921875), -- Coords for the blip
		Sprite = 106, -- Blips sprite (icon on the map)
		Display = 4, -- Display
		Scale = 0.8, -- Size of the blip
		Colour = 0, -- Color of the blip
		Name = 'Bürgermeister Büro' -- Name of the blip
	} --Lower you can add other blips, again as much as you want :-)
}

Config.Jobs.bmeister = { -- This is name of job you have in your database, change to setjob name whatever you want to
	Webhook = 'https://discord.com/api/webhooks/814214959323152404/tHXOPUGhcNLGKoDHGXWoO-qR8jFrQt-nTvnMZQg0RjzAjdnn7VBWaZ7dKwIPuzFrKffn', -- Name of the webhook if lower is UseWebhook true
	UseWebhook = true, -- If a webhook should be used
	SocietyPayments = false, -- If society payments enabled, you will get pay and pay from your society
	PercentToSociety = 90, -- The percent of money that the society will get (the remaining money will be added to player pocket)
	NeededLockPickItem = true, -- If a player needs item for lockpinging a vehicle (if this is set to false, none of the two bellow are affected)
	LockPickItemName = 'lockpick', -- The name of the item needed to lockpick a vehicle
	RemoveLockPickAfterUse = true, -- If the lockpick should be removed after use

	Zones = {
		armory = {
			Pos = {x = -147.3152923584, y = -638.02844238281, z = 168.82049560547}, -- Postion of the marker 
			Size = {x = 0.7, y = 0.7, z = 0.7}, -- Size of the marke
			Color = {r = 255, g = 255, b = 255}, -- The color of the marker
			Direction = {x = 0.0, y = 0.0, z = 0.0}, -- The direction of the marker (I am not sure how it works, check FiveM documentation) https://runtime.fivem.net/doc/natives/?_0x28477EC23D892089
			Rotation = {x = 0.0, y = 0.0, z = 0.0},-- The rotation of the marker (I am not sure how it works, check FiveM documentation) https://runtime.fivem.net/doc/natives/?_0x28477EC23D892089
			BouncingMarker = false, -- If the marker should go UP and Down
			RotatingMarker = true, -- If the marker should rotate
			Marker = 22, -- Type of the marker
			Type = 'Armory',
			Draw3DText = true, -- If the 3DText will be drawn on the marker
			MotionText = _U('armory_open'), -- The text which will be shown in the DrawText3D
			BuyWeapon = true, -- This allows you to buy weapons in this Armory (if you have multiple armories and you do not want to have buy weapon in all of them, simply cahnge it to false
			BuyWeaponGrade = 0, -- This is the least grade you must have to be allowed to buy weapons ( grade 0, 1, 2, 3, 4, 5, ... is now able to buy weapons)
			GetWeaponGrade = 0, -- This is the least grade you must have to be able to withdraw weapons from the armory (at some servers I have see that somebody was stealing thing from armories :D ( grade 0, 1, 2, 3, 4, 5, ... is now able to witdraw weapons) (Everybody can deposit weapons)
			GetStockGrade = 0, -- This is the least grade you must have to be able to withdraw things from the armory (at some servers I have see that somebody was stealing thing from armories :D ( grade 0, 1, 2, 3, 4, 5, ... is now able to witdraw weapons) (Everybody can deposit weapons)
			BuyItems = false,
			ShopItems = {
				shared = { -- Each job grade will see these items	
					{item = 'bread', price = 3, label = 'Bread'},
					{item = 'water', price = 2, label = 'Water'},
				},
				boss = { -- Only boss will see these items		
					{item = 'phone', price = 150, label = 'Phone'},
				},
			},
		},	

	-- Cloakroom = {},

	-- Crafting = {},

	-- Selling = {},

	BossActions = {
			Pos = {x = -129.11080932617, y = -638.60284423828, z = 168.82051086426}, -- This is the place where you open BossMenu (only grade with name boss is allowed (depends on your esx_society edits)
			Size = {x = 0.7, y = 0.7, z = 0.7},
			Color = {r = 255, g = 255, b = 255},
			Direction = {x = 0.0, y = 0.0, z = 0.0},
			Rotation = {x = 0.0, y = 0.0, z = 0.0},
			BouncingMarker = false,
			RotatingMarker = true,
			Marker = 22,
			Type = 'BossActions',
			Draw3DText = true,
			MotionText = _U('bossmenu_open'),
	},
	Vehicles = {
			Pos = {x = -1542.6558837891, y = -575.69738769531, z = 25.707807540894}, -- This is the spawnpoint where you see menu with vehicles which you can spawn
			Size = {x = 0.7, y = 0.7, z = 0.7},
			Color = {r = 255, g = 255, b = 255},
			Direction = {x = 0.0, y = 0.0, z = 0.0},
			Rotation = {x = 0.0, y = 0.0, z = 0.0},
			BouncingMarker = false,
			RotatingMarker = true,
			Marker = 36,
			MotionText = _U('vehicles_open'),
			Type = 'Vehicles',
			Draw3DText = true,
			SpawnPoints = { -- Here you configure spawnpoints, where the vehicle will be spawned (Chcecks if the spawnpoint is clear), you can add as much as you want
					{coords = vector3(-1543.6083984375, -583.17895507812, 25.707921981812), heading = 31.58, radius = 3.0},
					{coords = vector3(-1546.3911132812, -584.81561279297, 25.707921981812), heading = 31.58, radius = 3.0}
				}
		},	
	VehicleDeletePoint = { -- here you add vehicle deleter points. It can delete helicopters, car, bikes, boats...
			Pos = {x = -1537.7482910156, y = -577.177734375, z = 24.70782661438}, 
			Size = {x = 3.5, y = 3.5, z = 1.0},
			Color = {r = 255, g = 0, b = 0},
			Direction = {x = 0.0, y = 0.0, z = 0.0},
			Rotation = {x = 0.0, y = 0.0, z = 0.0},
			BouncingMarker = false,
			RotatingMarker = true,
			Marker = 1,
			Type = 'VehicleDeleter',
			MotionText = _U('vehicles_open_park'),	
		},	
	},		
	-- HeliSpawn = {},

	-- CollectPoints = {},

	-- DefaultClothes = {},

	-- End of zones and start of authorized vehicles
	AuthorizedVehicles = { -- Vehicles which be shown in the menu for the defined job
		shared = { -- These vehicles will have in garage every job rank
			{
				model = 'cognoscenti', -- Vehicle spawn model
				label = 'Cognoscenti', -- Vehicle menu label
				props = {plate = 'State01', modXenon = true} -- Here you can add all vehicle mods you want, documentation can be found here: https://esx-framework.github.io/es_extended/client/functions/game/setvehicleproperties/#valid-table-content

			},
			{
				model = 'alpinab7', -- Vehicle spawn model
				label = 'BMWAlpinab7', -- Vehicle menu label
				props = {plate = 'State02', modXenon = true} -- Here you can add all vehicle mods you want, documentation can be found here: https://esx-framework.github.io/es_extended/client/functions/game/setvehicleproperties/#valid-table-content

			},
		},
		boss = {}
	},
	-- End of Authorized vehicles and start of Allowed Actions
	AllowedActions = {
		Billing = true, -- Adds "Billing" to the interaction menu, the society is society_*player_job_name* (players job is police -> society is society_police)
		HasBodyActions = true, -- Adds Body Action such as Cuffing, Dragging, Taking out of vehicle, Putting in vehicle ...
		HasMechanicActions = false, -- This allows vehicle interaction in F6 menu
		CanRevive = false, -- This adds revive possibility to F6 menu
		CanWash = false, -- This manages if the boss can wash dirty money in BossMenu
		Deposit = true, -- If the boss will be able to deposit
		Grades = true, -- If the boss will have access to grades menu
		Withdraw = true, -- If the boss will have access to withdraw
		Employees = true, -- If the boss will have access to the employyess menu
		CustomMenuElement = false, -- Possibility to add custom element to F6 Menu, the function is defined in client/edit.lua
		CanUnlock = false, -- if there should be a LockPick vehicle option in the F6 menu (affected only, if HasMechanicActions is set to false)
	},
	-- End of Authorized actions and start of authorized Weapons for the job
	AuthorizedWeapons = { -- There you configure weapons that can a job have
		shared = { -- These weapon can be bought by all the players in the job
			{weapon = 'WEAPON_NIGHTSTICK', price = 0},
			{weapon = 'WEAPON_STUNGUN', price = 1700},
			{weapon = 'WEAPON_FLASHLIGHT', price = 80}
		},
		boss = { -- This weapon can be bought only of the boss of the current job
			
		}
	},
	-- End of authorized Weapons and Start of authorized AirCrafts
	-- AuthorizedAirCrafts = {},
}

Config.Jobs.midnight = { -- This is name of job you have in your database
	Webhook = 'https://discord.com/api/webhooks/814214959323152404/tHXOPUGhcNLGKoDHGXWoO-qR8jFrQt-nTvnMZQg0RjzAjdnn7VBWaZ7dKwIPuzFrKffn', -- Name of the webhook if lower is UseWebhook true
	UseWebhook = true, -- If a webhook should be used
	SocietyPayments = false, -- If society payments enabled, you will get pay and pay from your society
	PercentToSociety = 90, -- The percent of money that the society will get (the remaining money will be added to player pocket)
	NeededLockPickItem = true, -- If a player needs item for lockpinging a vehicle (if this is set to false, none of the two bellow are affected)
	LockPickItemName = 'lockpick', -- The name of the item needed to lockpick a vehicle
	RemoveLockPickAfterUse = true, -- If the lockpick should be removed after use

	Zones = {
		armory = {
			Pos = {x = 934.78979492188, y = -1460.7720947266, z = 33.612937927246},
			Size = {x = 0.7, y = 0.7, z = 0.7},
			Color = {r = 255, g = 255, b = 255},
			Direction = {x = 0.0, y = 0.0, z = 0.0},
			Rotation = {x = 0.0, y = 0.0, z = 0.0},
			BouncingMarker = false,
			RotatingMarker = true,
			Marker = 22,
			Type = 'Armory',
			Draw3DText = true,
			MotionText = _U('armory_open'),
			BuyWeapon = false, -- This allows you to buy weapons in this Armory (if you have multiple armories and you do not want to have buy weapon in all of them, simply cahnge it to false
			BuyWeaponGrade = 0, -- This is the least grade you must have to be allowed to buy weapons ( grade 0, 1, 2, 3, 4, 5, ... is now able to buy weapons)
			GetWeaponGrade = 0, -- This is the least grade you must have to be able to withdraw weapons from the armory (at some servers I have see that somebody was stealing thing from armories :D ( grade 0, 1, 2, 3, 4, 5, ... is now able to witdraw weapons) (Everybody can deposit weapons)
			GetStockGrade = 0, -- This is the least grade you must have to be able to withdraw things from the armory (at some servers I have see that somebody was stealing thing from armories :D ( grade 0, 1, 2, 3, 4, 5, ... is now able to witdraw weapons) (Everybody can deposit weapons)
		},	

	--Cloakroom = {},

	BossActions = {
			Pos = {x = 943.92736816406, y = -1463.7520751953, z = 30.401245117188}, -- This is the place where you open BossMenu (only grade with name boss is allowed (depends on your esx_society edits)
			Size = {x = 0.7, y = 0.7, z = 0.7},
			Color = {r = 255, g = 255, b = 255},
			Direction = {x = 0.0, y = 0.0, z = 0.0},
			Rotation = {x = 0.0, y = 0.0, z = 0.0},
			BouncingMarker = false,
			RotatingMarker = true,
			Marker = 22,
			Type = 'BossActions',
			Draw3DText = true,
			MotionText = _U('bossmenu_open'),
	},
	--Crafting = {}, -- If you do not want to use the Crafting menu, you can disable it like it is here, otherwise use it as above

	--Selling = {}, -- If you do not want to use the Selling menu, you can disable it like it is here, otherwise use it as above

	-- Vehicles = {},	
	
	VehicleDeletePoint = { -- here you add vehicle deleter points. It can delete helicopters, car, bikes, boats...
			Pos = {x = 0.0, y = 0.0, z = 0.0},
			Size = {x = 3.5, y = 3.5, z = 1.0},
			Color = {r = 255, g = 0, b = 0},
			Direction = {x = 0.0, y = 0.0, z = 0.0},
			Rotation = {x = 0.0, y = 0.0, z = 0.0},
			BouncingMarker = false,
			RotatingMarker = true,
			Marker = 1,
			Type = 'VehicleDeleter',
			Draw3DText = true,
			MotionText = _U('vehicles_open_park'),	
		},
	},			

	-- HeliSpawn = {},

	-- CollectPoints = {}, -- If you do not want to use Collect Points, set it like this

	--[[Clothes = {
		["Work Outfit"] = {
			JobGrades = 'all', -- You can set it to all to make it available to all the job grades
			--JobGrades = {},

			male = {
				tshirt_1 = 58,  tshirt_2 = 0,
				torso_1 = 55,   torso_2 = 0,
				decals_1 = 8,   decals_2 = 2,
				arms = 41,
				pants_1 = 25,   pants_2 = 0,
				shoes_1 = 25,   shoes_2 = 0,
				helmet_1 = -1,  helmet_2 = 0,
				chain_1 = 0,    chain_2 = 0,
				ears_1 = 2,     ears_2 = 0
			},
			female = {
				tshirt_1 = 35,  tshirt_2 = 0,
				torso_1 = 48,   torso_2 = 0,
				decals_1 = 7,   decals_2 = 2,
				arms = 44,
				pants_1 = 34,   pants_2 = 0,
				shoes_1 = 27,   shoes_2 = 0,
				helmet_1 = -1,  helmet_2 = 0,
				chain_1 = 0,    chain_2 = 0,
				ears_1 = 2,     ears_2 = 0
			}

		}
	},]]
	-- Or eventualy set it like that, comment it and keep it away

	-- End of zones and start of authorized vehicles
	--AuthorizedVehicles = {},

	-- End of Authorized vehicles and start of Allowed Actions
	AllowedActions = {
		Billing = false, -- Adds "Billing" to the interaction menu, the society is society_*player_job_name* (players job is police -> society is society_police)
		HasBodyActions = true, -- Adds Body Action such as Cuffing, Dragging, Taking out of vehicle, Putting in vehicle ...
		HasMechanicActions = false, -- This allows vehicle interaction in F6 menu
		CanRevive = false, -- This adds revive possibility to F6 menu
		CanWash = false, -- This manages if the boss can wash dirty money in BossMenu
		Deposit = true, -- If the boss will be able to deposit
		Grades = true, -- If the boss will have access to grades menu
		Withdraw = true, -- If the boss will have access to withdraw
		Employees = true, -- If the boss will have access to the employyess menu
		CustomMenuElement = false, -- If there should be a custom element in the Actions menu
		CanUnlock = false, -- if there should be a LockPick vehicle option in the F6 menu (affected only, if HasMechanicActions is set to false)
	},
	-- End of Authorized actions and start of authorized Weapons for the job
	AuthorizedWeapons = { -- There you configure weapons that can a job have
		{weapon = 'WEAPON_APPISTOL', components = {0, 0, 1000, 4000, nil}, price = 10000},
		{weapon = 'WEAPON_NIGHTSTICK', price = 0},
		{weapon = 'WEAPON_STUNGUN', price = 1500},
		{weapon = 'WEAPON_FLASHLIGHT', price = 80}		
	},
	-- End of authorized Weapons and Start of authorized AirCrafts
	--AuthorizedAirCrafts = {},
}

Config.Jobs.blackwater = { -- This is name of job you have in your database
	Webhook = 'https://discord.com/api/webhooks/814214959323152404/tHXOPUGhcNLGKoDHGXWoO-qR8jFrQt-nTvnMZQg0RjzAjdnn7VBWaZ7dKwIPuzFrKffn', -- Name of the webhook if lower is UseWebhook true
	UseWebhook = true, -- If a webhook should be used
	SocietyPayments = false, -- If society payments enabled, you will get pay and pay from your society
	PercentToSociety = 90, -- The percent of money that the society will get (the remaining money will be added to player pocket)
	NeededLockPickItem = true, -- If a player needs item for lockpinging a vehicle (if this is set to false, none of the two bellow are affected)
	LockPickItemName = 'lockpick', -- The name of the item needed to lockpick a vehicle
	RemoveLockPickAfterUse = true, -- If the lockpick should be removed after use

	Zones = {
		armory = {
			Pos = {x = 1394.8665771484, y = 1152.6690673828, z = 114.39182281494},
			Size = {x = 0.7, y = 0.7, z = 0.7},
			Color = {r = 255, g = 255, b = 255},
			Direction = {x = 0.0, y = 0.0, z = 0.0},
			Rotation = {x = 0.0, y = 0.0, z = 0.0},
			BouncingMarker = false,
			RotatingMarker = true,
			Marker = 22,
			Type = 'Armory',
			Draw3DText = true,
			MotionText = _U('armory_open'),
			BuyWeapon = false, -- This allows you to buy weapons in this Armory (if you have multiple armories and you do not want to have buy weapon in all of them, simply cahnge it to false
			BuyWeaponGrade = 0, -- This is the least grade you must have to be allowed to buy weapons ( grade 0, 1, 2, 3, 4, 5, ... is now able to buy weapons)
			GetWeaponGrade = 0, -- This is the least grade you must have to be able to withdraw weapons from the armory (at some servers I have see that somebody was stealing thing from armories :D ( grade 0, 1, 2, 3, 4, 5, ... is now able to witdraw weapons) (Everybody can deposit weapons)
			GetStockGrade = 0, -- This is the least grade you must have to be able to withdraw things from the armory (at some servers I have see that somebody was stealing thing from armories :D ( grade 0, 1, 2, 3, 4, 5, ... is now able to witdraw weapons) (Everybody can deposit weapons)
		},	

	--Cloakroom = {},

	BossActions = {
			Pos = {x = 1395.4466552734, y = 1141.7427978516, z = 114.6402053833}, -- This is the place where you open BossMenu (only grade with name boss is allowed (depends on your esx_society edits)
			Size = {x = 0.7, y = 0.7, z = 0.7},
			Color = {r = 255, g = 255, b = 255},
			Direction = {x = 0.0, y = 0.0, z = 0.0},
			Rotation = {x = 0.0, y = 0.0, z = 0.0},
			BouncingMarker = false,
			RotatingMarker = true,
			Marker = 22,
			Type = 'BossActions',
			Draw3DText = true,
			MotionText = _U('bossmenu_open'),
	},
	--Crafting = {}, -- If you do not want to use the Crafting menu, you can disable it like it is here, otherwise use it as above

	--Selling = {}, -- If you do not want to use the Selling menu, you can disable it like it is here, otherwise use it as above

	-- Vehicles = {},	
	
	VehicleDeletePoint = { -- here you add vehicle deleter points. It can delete helicopters, car, bikes, boats...
			Pos = {x = 0.0, y = 0.0, z = 0.0},
			Size = {x = 3.5, y = 3.5, z = 1.0},
			Color = {r = 255, g = 0, b = 0},
			Direction = {x = 0.0, y = 0.0, z = 0.0},
			Rotation = {x = 0.0, y = 0.0, z = 0.0},
			BouncingMarker = false,
			RotatingMarker = true,
			Marker = 1,
			Type = 'VehicleDeleter',
			Draw3DText = true,
			MotionText = _U('vehicles_open_park'),	
		},
	},			

	-- HeliSpawn = {},

	-- CollectPoints = {}, -- If you do not want to use Collect Points, set it like this

	--[[Clothes = {
		["Work Outfit"] = {
			JobGrades = 'all', -- You can set it to all to make it available to all the job grades
			--JobGrades = {},

			male = {
				tshirt_1 = 58,  tshirt_2 = 0,
				torso_1 = 55,   torso_2 = 0,
				decals_1 = 8,   decals_2 = 2,
				arms = 41,
				pants_1 = 25,   pants_2 = 0,
				shoes_1 = 25,   shoes_2 = 0,
				helmet_1 = -1,  helmet_2 = 0,
				chain_1 = 0,    chain_2 = 0,
				ears_1 = 2,     ears_2 = 0
			},
			female = {
				tshirt_1 = 35,  tshirt_2 = 0,
				torso_1 = 48,   torso_2 = 0,
				decals_1 = 7,   decals_2 = 2,
				arms = 44,
				pants_1 = 34,   pants_2 = 0,
				shoes_1 = 27,   shoes_2 = 0,
				helmet_1 = -1,  helmet_2 = 0,
				chain_1 = 0,    chain_2 = 0,
				ears_1 = 2,     ears_2 = 0
			}

		}
	},]]
	-- Or eventualy set it like that, comment it and keep it away

	-- End of zones and start of authorized vehicles
	--AuthorizedVehicles = {},

	-- End of Authorized vehicles and start of Allowed Actions
	AllowedActions = {
		Billing = false, -- Adds "Billing" to the interaction menu, the society is society_*player_job_name* (players job is police -> society is society_police)
		HasBodyActions = true, -- Adds Body Action such as Cuffing, Dragging, Taking out of vehicle, Putting in vehicle ...
		HasMechanicActions = false, -- This allows vehicle interaction in F6 menu
		CanRevive = false, -- This adds revive possibility to F6 menu
		CanWash = false, -- This manages if the boss can wash dirty money in BossMenu
		Deposit = true, -- If the boss will be able to deposit
		Grades = true, -- If the boss will have access to grades menu
		Withdraw = true, -- If the boss will have access to withdraw
		Employees = true, -- If the boss will have access to the employyess menu
		CustomMenuElement = false, -- If there should be a custom element in the Actions menu
		CanUnlock = false, -- if there should be a LockPick vehicle option in the F6 menu (affected only, if HasMechanicActions is set to false)
	},
	-- End of Authorized actions and start of authorized Weapons for the job
	AuthorizedWeapons = { -- There you configure weapons that can a job have
		{weapon = 'WEAPON_APPISTOL', components = {0, 0, 1000, 4000, nil}, price = 10000},
		{weapon = 'WEAPON_NIGHTSTICK', price = 0},
		{weapon = 'WEAPON_STUNGUN', price = 1500},
		{weapon = 'WEAPON_FLASHLIGHT', price = 80}		
	},
	-- End of authorized Weapons and Start of authorized AirCrafts
	--AuthorizedAirCrafts = {},
}