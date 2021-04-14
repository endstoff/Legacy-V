-------------------------------------
------- Created by T1GER#9080 -------
------------------------------------- 

Config = {}

Config.LockDoorKey 	= 303			-- key to lock/unlock cars (DEFAULT: [U])
Config.OpenCarMenu 	= 82			-- key to open car menu (DEFAULT: [,])

-- Locksmith Settings:
Config.RegisterKeyPrice 	= 250		
Config.KeyPayBankMoney		= true	-- set to false to pay with cash instead of bank moeny

-- Dependencies:
Config.t1ger_carinsurance 	= false	-- set to false if you don't own t1ger_carinsurance script

-- Alarm Settings:
Config.AllowAlarmsIfGotKey = true	-- set to false, if players should be able to buy alarms to their vehicles without owning a key for it.
Config.AlarmPayBankMoney = true		-- set to false, if players should pay for alarms with cash instead of bank money
Config.RemoveAlarmPercentPrice = 10	-- set percent of carprice in cost to remove alarm	(min 0 and max 100)
Config.AlarmOnePercentPrice = 25		-- set percent of carprice in cost to buy Alarm I (min 0 and max 100)
Config.AlarmTwoPercentPrice = 50		-- set percent of carprice in cost to buy Alarm II (min 0 and max 100)

-- Stealing NPC Cars Settings:
Config.HandsUpTime = 6					-- set the time NPC stands with their hands up
Config.PedGivesKeyChance = 85			-- set the chance of NPC giving keys upon threatening
Config.AlertTime = {min = 10, max = 30}	-- set min and max seconds, from car is successfully robbed, to police receive call from NPC

-- Police Settings:
Config.AllowedJobs = {"police", "ambulance"}

-- Alert Blip
Config.AlertBlipShow = true			-- enable or disable blip on map on police notify
Config.AlertBlipTime = 20			-- miliseconds that blip is active on map (this value is multiplied with 4 in the script)
Config.AlertBlipRadius = 50.0		-- set radius of the police notify blip
Config.AlertBlipAlpha = 250			-- set alpha of the blip
Config.AlertBlipColor = 3			-- set blip color

-- Locksmith Shop:
Config.Locksmith = {{
	Pos = {170.18,-1799.42,29.32},
	Key = 38,
	Marker = {
		Enable = true,
		DrawDist = 10.0,
		Type = 27,
		Scale = {x = 1.0, y = 1.0, z = 1.0},
		Color = {r = 240, g = 52, b = 52, a = 100},
	},
	Blip = {
		Enable 	= true,
		Pos 	= {170.18,-1799.42,29.32},
		Sprite 	= 134,
		Color 	= 1,
		Name 	= "Schlosser",
		Scale 	= 1.0,
		Display = 4,
	}
}}


-- Alarm Shop
Config.AlarmShop = {{
	Pos = {-194.48,-834.61,30.74},
	Key = 38,
	Marker = {
		Enable = true,
		DrawDist = 10.0,
		Type = 27,
		Scale = {x = 1.0, y = 1.0, z = 1.0},
		Color = {r = 240, g = 52, b = 52, a = 100},
	},
	Blip = {
		Enable 	= true,
		Pos 	= {-194.48,-834.61,30.74},
		Sprite 	= 459,
		Color 	= 3,
		Name 	= "Alarm Shop",
		Scale 	= 0.7,
		Display = 4,
	}
}}

-- Add Police/EMS Vehicles or other whitelisted vehicles and set job permissions
Config.WhitelistCars = {
--	LSPD

    [1] = {model = GetHashKey('pdrafter'), job = {"police"}},
	[2] = {model = GetHashKey('dw_beachp'), job = {"police"}},
	[3] = {model = GetHashKey('dw_lspd1'), job = {"police"}},
	[4] = {model = GetHashKey('dw_lspd2'), job = {"police"}},
	[5] = {model = GetHashKey('dw_lspd3'), job = {"police"}},
	[6] = {model = GetHashKey('dw_lspd4'), job = {"police"}},
	[7] = {model = GetHashKey('dw_lspdb'), job = {"police"}},
	[8] = {model = GetHashKey('dw_police42'), job = {"police"}},
	[9] = {model = GetHashKey('dw_policeold'), job = {"police"}},
	[10] = {model = GetHashKey('dw_policeslick'), job = {"police"}},
	[11] = {model = GetHashKey('dw_polmerit2'), job = {"police"}},
	[12] = {model = GetHashKey('dw_polriot'), job = {"police"}},
	[13] = {model = GetHashKey('dw_polspeedo'), job = {"police"}},
	[14] = {model = GetHashKey('dw_pscout'), job = {"police"}},

-- LSMD

	[15] = {model = GetHashKey('emsnspeedo'), job = {"ambulance"}},
	[16] = {model = GetHashKey('dw_ambulance'), job = {"ambulance"}},
	[17] = {model = GetHashKey('dw_ambulance2'), job = {"ambulance"}},
	[18] = {model = GetHashKey('dw_emscar2'), job = {"ambulance"}},
	[19] = {model = GetHashKey('dw_emssuv'), job = {"ambulance"}},
	[20] = {model = GetHashKey('dw_emsvan'), job = {"ambulance"}},
	[21] = {model = GetHashKey('ambulance'), job = {"ambulance"}},

-- ACLS
	[22] = {model = GetHashKey('flatbed'), job = {"acls"}},
	[23] = {model = GetHashKey('towtruck'), job = {"acls"}},
	[24] = {model = GetHashKey('towtruck2'), job = {"acls"}},
	[25] = {model = GetHashKey('faggio'), job = {"acls"}},

-- BMEISTER
	[25] = {model = GetHashKey('cognoscenti'), job = {"bmeister"}},
	[26] = {model = GetHashKey('alpinab7'), job = {"bmeister"}},
	[27] = {model = GetHashKey('taxi'), job = {"bmeister"}},

}

-- Settings for Lockpicking:
Config.LockpickItem = {{
	ItemName			= "lockpick",			-- Item name in database for usable item
	ItemLabel			= "Dietrich",			-- Item name that is displayed in notifications etc
	ProgressBarText		= "Aufbrechen",		-- Progress bar text
	LockpickTime 		= 15,					-- Lockpicking time in seconds
	ChanceOne 			= 90,					-- Lockpicking success chance in percent (no alarm)
	ChanceTwo 			= 30,					-- Lockpicking success chance in percent (Alarm I)
	ChanceThree 		= 10,					-- Lockpicking success chance in percent (Alarm II)
	EnableAlarmSound 	= true,					-- Enable/Disable car clarm upon lockpicking 
	CarAlarmTime 		= 40,					-- Set duration of car alarm upon lockpicking, in seconds.
	PoliceAlert			= true,					-- Enable/Disable police alert upon lockpicking
	AnimDict			= "anim@amb@clubhouse@tutorial@bkr_tut_ig3@",
	AnimName			= "machinic_loop_mechandplayer",
}}

-- Settings for Hotwiring:
Config.HotwireFeature = {{
	ProgressBarText		= "KURZSCHLIEßEN",			-- Progress bar text
	HotwireTime 		= 10,					-- Lockpicking time in seconds
	AnimDict			= "veh@handler@base",
	AnimName			= "hotwire",
}}
Config.HotwireChance = 90

-- Settings for Search:
Config.SearchCar = {{
	ProgressBarText		= "SEARCHING",			-- Progress bar text
	HotwireTime 		= 10,					-- Lockpicking time in seconds
	AnimDict			= "veh@handler@base",
	AnimName			= "hotwire"
}}

-- Search Rewards:
Config.SearchItems = {
	[1] = {item = "rolpaper", name = "Rolling Paper", min = 1, max = 4, chance = 67},
	[2] = {item = "goldwatch", name = "Gold Watch", min = 1, max = 3, chance = 20},
	[3] = {item = "sandwich", name = "Sandwich", min = 1, max = 4, chance = 54},
	[4] = {item = "repairkit", name = "Repair Kit", min = 1, max = 3, chance = 85},
	[5] = {item = "donut", name = "Donut", min = 2, max = 7, chance = 54},
	[6] = {item = "cocaine_packaged", name = "Coke", min = 1, max = 3, chance = 94}
}

Config.ExtraCash = {chance = 50, min = 100, max = 750, type = 'cash' --[[set to 'dirty' if u want dirty cash]]}