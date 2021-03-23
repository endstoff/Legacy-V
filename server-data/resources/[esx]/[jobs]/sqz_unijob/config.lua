Config                            = {}
Config.DrawDistance               = 5.0 -- Distance in GTA units you will see the markers
Config.DrawTextDistance			  = 2.0 -- Distance in GTA units from which you will see the DrawTex3D (if is enabled)
--JobConfig
Config.Jobs						  = {} 
Config.MaxInService               = -1
Config.Locale                     = 'de'
Config.UseAnimations			  = true -- Enables/Diasbles animations for fixing vehicle, writing bills and etc. ...
Config.UseMythic_Progressbar	  = false -- Enables/Diasbles opening Mythic progress bar while doing an animation
Config.NeedItemCuffs			  = false -- Enables/Diasbles requirement of handcuffs as item
Config.UseLegacyFuel			  = true -- If true, your vehicle after taking it from garage will have 100% fuel (requires LegacyFuel script)
Config.ShowImpoundNotification	  = true -- Choose, if you want to play an animation while impounding a vehicle
Config.ImpoundAnimationWaitTime	  = 10 * 1000 -- Time, how long the animation for impounding a vehicle will be
Config.EnableLicenses			  = true
Config.MenuAlign 				  = 'top-left' -- Position of ESX Menu
Config.CuffItemName				  = 'cuffs' -- The item name in database you need to have in your inventory to bee able to cuff somebody
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

--Animation names
Config.HandsUPAnimationDictionary = 'mp_arresting'
Config.HandsUPAnimationName = 'idle'

-- Custom events (edit in case you use any custom events)
Config.customEvents = {
    ['esx_billing:sendBill'] = 'esx_billing:sendBill', -- You can change the event if you for example use anticheats/you have editted event like esx_billing:sendSuperSecretEventSquizerBill
    ['esx_society:openBossMenu'] = 'esx_society:openBossMenu',
	['esx:setJob'] = 'esx:setJob',
	['esx_ambulancejob:revive'] = 'esx_ambulancejob:revive',
	['mythic_progressbar:client:progress'] = 'mythic_progbar:client:progress',
	['esx_eden_clotheshop:getPlayerDressing'] = 'cui_wardrobe:getOutfitInSlot'
}

Config.AlloweAccountsToDeposit = { -- The account name which is allowed to be deposit to the vault
	["bank"] = true, -- Just remove any of these if you do not want to use them
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



Config.Jobs.bmeister = { -- This is name of job you have in your database
Webhook = 'https://discord.com/api/webhooks/814214959323152404/tHXOPUGhcNLGKoDHGXWoO-qR8jFrQt-nTvnMZQg0RjzAjdnn7VBWaZ7dKwIPuzFrKffn', -- Name of the webhook if lower is UseWebhook true
UseWebhook = true,
	Zones = {
		armory = {
			Pos = {x = -1576.1978759766, y = -582.77996826172, z = 108.52294921875}, 
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
			BuyWeapon = true, -- This allows you to buy weapons in this Armory (if you have multiple armories and you do not want to have buy weapon in all of them, simply cahnge it to false
			BuyWeaponGrade = 0, -- This is the least grade you must have to be allowed to buy weapons ( grade 0, 1, 2, 3, 4, 5, ... is now able to buy weapons)
			GetWeaponGrade = 0, -- This is the least grade you must have to be able to withdraw weapons from the armory (at some servers I have see that somebody was stealing thing from armories :D ( grade 0, 1, 2, 3, 4, 5, ... is now able to witdraw weapons) (Everybody can deposit weapons)
			GetStockGrade = 0, -- This is the least grade you must have to be able to withdraw things from the armory (at some servers I have see that somebody was stealing thing from armories :D ( grade 0, 1, 2, 3, 4, 5, ... is now able to witdraw weapons) (Everybody can deposit weapons)
		},	  	
	Cloakroom = {
			Pos = {x = 0.0, y = 0.0, z = 0.0}, -- This is the place where you can change your saved clothes (you have to buy then in clotheshop) 
			Size = {x = 0.0, y = 0.0, z = 0.0},
			Color = {r = 255, g = 255, b = 255},
			Direction = {x = 0.0, y = 0.0, z = 0.0},
			Rotation = {x = 0.0, y = 0.0, z = 0.0},
			BouncingMarker = false,
			RotatingMarker = true,
			Marker = -1,
			Type = 'Cloakroom',
			Draw3DText = true,
			MotionText = _U('cloakroom_open'),
		},
	BossActions = {
			Pos = {x = -1555.884765625, y = -575.26123046875, z = 108.52714538574}, -- This is the place where you open BossMenu (only grade with name boss is allowed (depends on your esx_society edits)
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
			Draw3DText = true,
			MotionText = _U('vehicles_open_park'),	
		},			
	--HeliSpawn = {},
	},

	CollectPoints = {}, -- If you do not want to use Collect Points, set it like this

	-- End of zones and start of authorized vehicles
	AuthorizedVehicles = { -- Vehicles which be shown in the menu for the defined job
		shared = { -- These vehicles will have in garage every job rank
			{
				model = 'cognoscenti', -- Vehicle spawn model
				label = 'Cognoscenti', -- Vehicle menu label
				props = {plate = '1234567', modXenon = true} -- Here you can add all vehicle mods you want, documentation can be found here: https://esx-framework.github.io/es_extended/client/functions/game/setvehicleproperties/#valid-table-content

			},
		},
		boss = { -- These vehicles + Shared Vehicles will have Boss rank
	
		}
	},
	-- End of Authorized vehicles and start of Allowed Actions
	AllowedActions = {
		Billing = true, -- Adds "Billing" to the interaction menu, the society is society_*player_job_name* (players job is police -> society is society_police)
		HasBodyActions = false, -- Adds Body Action such as Cuffing, Dragging, Taking out of vehicle, Putting in vehicle ...
		HasMechanicActions = false, -- This allows vehicle interaction in F6 menu
		CanRevive = false, -- This adds revive possibility to F6 menu
		CanWash = false, -- This manages if the boss can wash dirty money in BossMenu
		CustomMenuElement = false,
	},
	-- End of Authorized actions and start of authorized Weapons for the job
	AuthorizedWeapons = { -- There you configure weapons that can a job have
	--	{weapon = 'WEAPON_APPISTOL', components = {0, 0, 1000, 4000, nil}, price = 10000},
		{weapon = 'WEAPON_NIGHTSTICK', price = 0},
		{weapon = 'WEAPON_STUNGUN', price = 1500},
		{weapon = 'WEAPON_FLASHLIGHT', price = 80}		
	},
	-- End of authorized Weapons and Start of authorized AirCrafts
	AuthorizedAirCrafts = {
		shared = { -- These vehicles will have in garage every job rank
		}, -- These are empty, so you need to define for each rank or simply add vehicles to shared
		boss = { -- These vehicles + Shared Vehicles will have Boss rank
			{
				model = 'polmav',
				label = 'Police maverick',
				props = {plate = 'SQZ1', modXenon = true} -- Here you can add all vehicle mods you want, documentation can be found here: https://esx-framework.github.io/es_extended/client/functions/game/setvehicleproperties/#valid-table-content
			}
		}
	},
}

Config.Jobs.yakuza = { -- This is name of job you have in your database
Webhook = 'https://discord.com/api/webhooks/814214959323152404/tHXOPUGhcNLGKoDHGXWoO-qR8jFrQt-nTvnMZQg0RjzAjdnn7VBWaZ7dKwIPuzFrKffn', -- Name of the webhook if lower is UseWebhook true
UseWebhook = true,
	Zones = {
		armory = {
			Pos = {x = -1516.7703857422, y = 851.45111083984, z = 181.59471130371},  
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
			Pos = {x = -1520.3865966797, y = 848.99780273438, z = 181.59471130371}, -- This is the place where you open BossMenu (only grade with name boss is allowed (depends on your esx_society edits)
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

	Vehicles = {
			Pos = {x = 0, y = 0, z = 0}, -- This is the spawnpoint where you see menu with vehicles which you can spawn
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
			Pos = {x = 0, y = 0, z = 0}, 
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
	--HeliSpawn = {},
	},

	CollectPoints = {}, -- If you do not want to use Collect Points, set it like this

	-- End of zones and start of authorized vehicles
	--AuthorizedVehicles = {},
	-- End of Authorized vehicles and start of Allowed Actions
	AllowedActions = {
		Billing = false, -- Adds "Billing" to the interaction menu, the society is society_*player_job_name* (players job is police -> society is society_police)
		HasBodyActions = true, -- Adds Body Action such as Cuffing, Dragging, Taking out of vehicle, Putting in vehicle ...
		HasMechanicActions = false, -- This allows vehicle interaction in F6 menu
		CanRevive = false, -- This adds revive possibility to F6 menu
		CanWash = false, -- This manages if the boss can wash dirty money in BossMenu
		CustomMenuElement = false,
	},
	-- End of Authorized actions and start of authorized Weapons for the job
	--AuthorizedWeapons = {},
	-- End of authorized Weapons and Start of authorized AirCrafts
	--AuthorizedAirCrafts = {},
}