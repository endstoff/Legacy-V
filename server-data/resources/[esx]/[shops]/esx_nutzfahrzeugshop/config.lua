Config                            = {}
Config.DrawDistance               = 20.0
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
		Pos   = { x = -200.02447509766, y = 6234.22265625, z = 31.502841949463 }, 
		Size  = { x = 1.0, y = 1.0, z = 1.0 },
		Type  = 20
	},

	ShopInside = {
		Pos     = { x = -213.95617675781, y = 6200.3198242188, z = 31.490154266357 }, 
		Size    = { x = 1.5, y = 1.5, z = 1.0 },
		Heading = 225.0,
		Type    = -1
	},

	ShopOutside = {
		Pos     = { x = -232.62121582031, y = 6189.2495117188, z = 31.489635467529 }, 
		Size    = { x = 1.5, y = 1.5, z = 1.0 },
		Heading = 134.0,
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
		Pos   = { x = -44.630, y = -1080.738, z = 0.683 },
		Size  = { x = 1.0, y = 1.0, z = 1.0 },
		Type  = 1
	}

}