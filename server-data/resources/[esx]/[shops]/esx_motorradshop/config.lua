Config                            = {}
Config.DrawDistance               = 100.0
Config.MarkerColor                = { r = 120, g = 120, b = 240 }
Config.EnablePlayerManagement     = false -- enables the actual car dealer job. You'll need esx_addonaccount, esx_billing and esx_society
Config.EnableOwnedVehicles        = true
Config.EnableSocietyOwnedVehicles = false -- use with EnablePlayerManagement disabled, or else it wont have any effects
Config.ResellPercentage           = 50

Config.Locale                     = 'de'
-- Polo © License | Discord : https://discord.gg/htfpJZN
Config.LicenseEnable = false -- require people to own drivers license when buying vehicles? Only applies if EnablePlayerManagement is disabled. Requires esx_license

-- looks like this: 'LLL NNN'
-- The maximum plate length is 8 chars (including spaces & symbols), don't go past it!
Config.PlateLetters  = 3
Config.PlateNumbers  = 3
Config.PlateUseSpace = true
-- Polo © License | Discord : https://discord.gg/htfpJZN
Config.Zones = {

	ShopEntering = {
		Pos   = { x = 268.41116333008, y = -1155.5703125, z = 29.288702011108 },
		Size  = { x = 1.5, y = 1.5, z = 1.0 },
		Type  = 22
	},

	ShopInside = {
		Pos     = { x = 301.23321533203, y = -1180.8621826172, z = 29.390182495117 },
		Size    = { x = 1.5, y = 1.5, z = 1.0 },
		Heading = 142.0,
		Type    = -1
	},

	ShopOutside = {
		Pos     = { x = 259.28842163086, y = -1149.6372070312, z = 29.291700363159 },
		Size    = { x = 1.5, y = 1.5, z = 1.0 },
		Heading = 330.0,
		Type    = -1
	},

	BossActions = {
		Pos   = { x = -32.065, y = -1114.277, z = 25.422 },
		Size  = { x = 1.5, y = 1.5, z = 1.0 },
		Type  = -1
	},

	--GiveBackVehicle = {
	--	Pos   = { x = -18.227, y = -1078.558, z = 25.675 },
	--	Size  = { x = 3.0, y = 3.0, z = 1.0 },
	--	Type  = (Config.EnablePlayerManagement and 1 or -1)
	--},

	ResellVehicle = {
		Pos   = { x = 262.37936401367, y = -1149.5219726562, z = 29.291690826416 },
		Size  = { x = 3.0, y = 3.0, z = 1.0 },
		Type  = 22
	}

}