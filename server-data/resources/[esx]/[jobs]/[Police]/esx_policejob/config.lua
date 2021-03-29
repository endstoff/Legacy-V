Config                            = {}

Config.DrawDistance               = 10.0 -- How close do you need to be for the markers to be drawn (in GTA units).
Config.MarkerType                 = {Cloakrooms = 20, Armories = 21, BossActions = 22, Vehicles = 36, Helicopters = 34}
Config.MarkerSize                 = {x = 1.0, y = 1.0, z = 1.0}
Config.MarkerColor                = {r = 255, g = 255, b = 255}

Config.EnablePlayerManagement     = true -- Enable if you want society managing.
Config.EnableArmoryManagement     = true
Config.EnableESXIdentity          = true -- Enable if you're using esx_identity.
Config.EnableLicenses             = true -- Enable if you're using esx_license.

Config.EnableHandcuffTimer        = false -- Enable handcuff timer? will unrestrain player after the time ends.
Config.HandcuffTimer              = 10 * 60000 -- 10 minutes.

Config.EnableJobBlip              = false -- Enable blips for cops on duty, requires esx_society.
Config.EnableCustomPeds           = false -- Enable custom peds in cloak room? See Config.CustomPeds below to customize peds.

Config.EnableESXService           = false -- Enable esx service?
Config.MaxInService               = -1 -- How much people can be in service at once?

Config.Locale                     = 'de'

Config.PoliceStations = {

	LSPD = {

		Blip = {
			Coords  = vector3(438.78338623047, -981.86383056641, 30.689502716064),
			Sprite  = 60,
			Display = 4,
			Scale   = 0.8,
			Colour  = 29
		},

		Cloakrooms = {
			vector3(461.89666748047, -998.8759765625, 30.689510345459)
		},

		Armories = {
			vector3(482.53634643555, -995.26550292969, 30.689628601074)
		},

		Vehicles = {
			{
				Spawner = vector3(460.97637939453, -983.98937988281, 25.699848175049),
				InsideShop = vector3(435.91171264648, -975.70593261719, 25.699802398682),
				SpawnPoints = {
					{coords = vector3(436.77261352539,-986.08813476562,25.699811935425), heading = 90.9, radius = 4.0},
					{coords = vector3(437.19348144531, -988.80676269531, 25.699798583984), heading = 90.0, radius = 4.0},
					{coords = vector3(437.37026977539, -991.4130859375, 25.699798583984), heading = 90.0, radius = 4.0},
					{coords = vector3(437.38397216797, -994.12536621094, 25.699798583984), heading = 90.0, radius = 4.0},
					{coords = vector3(437.11370849609, -996.84497070312,25.699794769287), heading = 90.0, radius = 4.0}
				}
			},

			{
				Spawner = vector3(473.3, -1018.8, 0),
				InsideShop = vector3(228.5, -993.5, -99.0),
				SpawnPoints = {
					{coords = vector3(475.9, -1021.6, 28.0), heading = 276.1, radius = 6.0},
					{coords = vector3(484.1, -1023.1, 27.5), heading = 302.5, radius = 6.0}
				}
			}
		},

		Helicopters = {
			{
				Spawner = vector3(461.1, -981.5, 0),
				InsideShop = vector3(477.0, -1106.4, 43.0),
				SpawnPoints = {
					{coords = vector3(449.5, -981.2, 43.6), heading = 92.6, radius = 10.0}
				}
			}
		},

		BossActions = {
			vector3(448.4, -973.2, 0)
		}

	},

	SandyShores = {

		Blip = {
			Coords  = vector3(1855.59, 3685.75, 34.2),
			Sprite  = 60,
			Display = 4,
			Scale   = 0.8,
			Colour  = 29
		},

		Cloakrooms = {
			vector3(1861.3421630859, 3689.1345214844, 34.276844024658)
		},

		Armories = {
			vector3(1849.7271728516, 3694.7143554688, 34.276870727539)
		},

		Vehicles = {
			{
				Spawner = vector3(1858.38, 3683.42, 33.7),
				InsideShop = vector3(1874.28, 3683.42, 33.0),
				SpawnPoints = {
					{coords = vector3(1866.0, 3682.12, 33.1), heading = 198.86, radius = 6.0},
					{coords = vector3(1861.0, 3682.12, 33.1), heading = 90.0, radius = 6.0},
					{coords = vector3(1856.0, 3682.12, 33.1), heading = 90.0, radius = 6.0}
				}
			}
		},

		Helicopters = {},

		BossActions = {
			vector3(1843.9271240234, 3689.7392578125, 34.276870727539)
		}

	}
}

Config.AuthorizedWeapons = {
	cadet = {
		{weapon = 'WEAPON_STUNGUN', price = 500},
		{weapon = 'WEAPON_FLASHLIGHT', price = 80},
		{weapon = 'WEAPON_NIGHTSTICK', price = 130},
		{weapon = 'WEAPON_PETROLCAN', price = 150},
		{weapon = 'WEAPON_FLARE', price = 350},
		{weapon = 'WEAPON_FIREEXTINGUISHER', price = 0}
	},

	officer = {
		{weapon = 'WEAPON_STUNGUN', price = 500},
		{weapon = 'WEAPON_PISTOL_MK2', price = 1000},
		{weapon = 'WEAPON_FLASHLIGHT', price = 80},
		{weapon = 'WEAPON_NIGHTSTICK', price = 130},
		{weapon = 'WEAPON_PETROLCAN', price = 150},
		{weapon = 'WEAPON_FLARE', price = 350},
		{weapon = 'WEAPON_FIREEXTINGUISHER', price = 0}
	},

	detective = {
		{weapon = 'WEAPON_STUNGUN', price = 500},
		{weapon = 'WEAPON_PISTOL_MK2', price = 1000},
		{weapon = 'WEAPON_SMG', price = 2500},
		{weapon = 'WEAPON_FLASHLIGHT', price = 80},
		{weapon = 'WEAPON_NIGHTSTICK', price = 130},
		{weapon = 'WEAPON_PETROLCAN', price = 150},
		{weapon = 'WEAPON_FLARE', price = 350},
		{weapon = 'WEAPON_FIREEXTINGUISHER', price = 0}
	},

	sergeant = {
		{weapon = 'WEAPON_STUNGUN', price = 500},
		{weapon = 'WEAPON_PISTOL_MK2', price = 1000},
		{weapon = 'WEAPON_SMG', price = 2500},
		{weapon = 'WEAPON_PUMPSHOTGUN', price = 3500},
		{weapon = 'WEAPON_FLASHLIGHT', price = 80},
		{weapon = 'WEAPON_NIGHTSTICK', price = 130},
		{weapon = 'WEAPON_PETROLCAN', price = 150},
		{weapon = 'WEAPON_FLARE', price = 350},
		{weapon = 'WEAPON_FIREEXTINGUISHER', price = 0}
	},

	sergeant = {
		{weapon = 'WEAPON_STUNGUN', price = 500},
		{weapon = 'WEAPON_PISTOL_MK2', price = 1000},
		{weapon = 'WEAPON_SMG', price = 2500},
		{weapon = 'WEAPON_PUMPSHOTGUN', price = 3500},
		{weapon = 'WEAPON_FLASHLIGHT', price = 80},
		{weapon = 'WEAPON_NIGHTSTICK', price = 130},
		{weapon = 'WEAPON_PETROLCAN', price = 150},
		{weapon = 'WEAPON_FLARE', price = 350},
		{weapon = 'WEAPON_FIREEXTINGUISHER', price = 0}
	},

	lieutenant = {
		{weapon = 'WEAPON_STUNGUN', price = 500},
		{weapon = 'WEAPON_PISTOL_MK2', price = 1000},
		{weapon = 'WEAPON_SMG', price = 2500},
		{weapon = 'WEAPON_PUMPSHOTGUN', price = 3500},
		{weapon = 'WEAPON_FLASHLIGHT', price = 80},
		{weapon = 'WEAPON_NIGHTSTICK', price = 130},
		{weapon = 'WEAPON_PETROLCAN', price = 150},
		{weapon = 'WEAPON_FLARE', price = 350},
		{weapon = 'WEAPON_FIREEXTINGUISHER', price = 0}
	},

	commissioner = {
		{weapon = 'WEAPON_STUNGUN', price = 500},
		{weapon = 'WEAPON_PISTOL_MK2', price = 1000},
		{weapon = 'WEAPON_SMG', price = 2500},
		{weapon = 'WEAPON_PUMPSHOTGUN', price = 3500},
		{weapon = 'WEAPON_CARBINERIFLE', price = 5000},
		{weapon = 'WEAPON_FLASHLIGHT', price = 80},
		{weapon = 'WEAPON_NIGHTSTICK', price = 130},
		{weapon = 'WEAPON_PETROLCAN', price = 150},
		{weapon = 'WEAPON_FLARE', price = 350},
		{weapon = 'WEAPON_FIREEXTINGUISHER', price = 0}
	},

	instructor = {
		{weapon = 'WEAPON_STUNGUN', price = 500},
		{weapon = 'WEAPON_PISTOL_MK2', price = 1000},
		{weapon = 'WEAPON_SMG', price = 2500},
		{weapon = 'WEAPON_PUMPSHOTGUN', price = 3500},
		{weapon = 'WEAPON_CARBINERIFLE', price = 5000},
		{weapon = 'WEAPON_FLASHLIGHT', price = 80},
		{weapon = 'WEAPON_NIGHTSTICK', price = 130},
		{weapon = 'WEAPON_PETROLCAN', price = 150},
		{weapon = 'WEAPON_FLARE', price = 350},
		{weapon = 'WEAPON_FIREEXTINGUISHER', price = 0}
	},

	chiefofacademy = {
		{weapon = 'WEAPON_STUNGUN', price = 500},
		{weapon = 'WEAPON_PISTOL_MK2', price = 1000},
		{weapon = 'WEAPON_SMG', price = 2500},
		{weapon = 'WEAPON_PUMPSHOTGUN', price = 3500},
		{weapon = 'WEAPON_CARBINERIFLE', price = 5000},
		{weapon = 'WEAPON_FLASHLIGHT', price = 80},
		{weapon = 'WEAPON_NIGHTSTICK', price = 130},
		{weapon = 'WEAPON_PETROLCAN', price = 150},
		{weapon = 'WEAPON_FLARE', price = 350},
		{weapon = 'WEAPON_FIREEXTINGUISHER', price = 0}
	},

	chiefofdepartment = {
		{weapon = 'WEAPON_STUNGUN', price = 500},
		{weapon = 'WEAPON_PISTOL_MK2', price = 1000},
		{weapon = 'WEAPON_SMG', price = 2500},
		{weapon = 'WEAPON_PUMPSHOTGUN', price = 3500},
		{weapon = 'WEAPON_CARBINERIFLE', price = 5000},
		{weapon = 'WEAPON_FLASHLIGHT', price = 80},
		{weapon = 'WEAPON_NIGHTSTICK', price = 130},
		{weapon = 'WEAPON_PETROLCAN', price = 150},
		{weapon = 'WEAPON_FLARE', price = 350},
		{weapon = 'WEAPON_FIREEXTINGUISHER', price = 0}
	},

	boss = {
		{weapon = 'WEAPON_STUNGUN', price = 500},
		{weapon = 'WEAPON_PISTOL_MK2', price = 1000},
		{weapon = 'WEAPON_SMG', price = 2500},
		{weapon = 'WEAPON_PUMPSHOTGUN', price = 3500},
		{weapon = 'WEAPON_CARBINERIFLE', price = 5000},
		{weapon = 'WEAPON_FLASHLIGHT', price = 80},
		{weapon = 'WEAPON_NIGHTSTICK', price = 130},
		{weapon = 'WEAPON_PETROLCAN', price = 150},
		{weapon = 'WEAPON_FLARE', price = 350},
		{weapon = 'WEAPON_FIREEXTINGUISHER', price = 0}
	}
}

Config.AuthorizedVehicles = {
	car = {
		cadet = {
			{model = 'dw_lspd1', label = 'Vapid Cruiser', price = 5000},
			{model = 'police3', label = 'Vapid Interceptor', price = 5000},
		},

		officer = {
			{model = 'dw_lspd1', label = 'Vapid Cruiser', price = 5000},

			{model = 'dw_lspd2', label = 'Bravado Buffalo', price = 5000},
		},

		detective = {
			{model = 'dw_lspd1', label = 'Vapid Cruiser', price = 5000},

			{model = 'dw_lspd2', label = 'Bravado Buffalo', price = 5000},
			
			{model = 'dw_police42', label = 'Bravado Buffalo UM', price = 5000},
			{model = 'dw_lspd4', label = 'Vapid UM', price = 5000},

		},

		sergeant = {
			{model = 'dw_lspd1', label = 'Vapid Cruiser', price = 5000},

			{model = 'dw_lspd2', label = 'Bravado Buffalo', price = 5000},
			{model = 'dw_lspd3', label = 'Vapid Interceptor', price = 5000},
		},

		firstsergeant = {
			{model = 'dw_lspd1', label = 'Vapid Cruiser', price = 5000},

			{model = 'dw_lspd2', label = 'Bravado Buffalo', price = 5000},
			{model = 'dw_lspd3', label = 'Vapid Interceptor', price = 5000},
			{model = 'pdrafter', label = 'Drafter', price = 5000},

		},

		lieutenant = {
			{model = 'dw_lspd1', label = 'Vapid Cruiser', price = 5000},

			{model = 'dw_lspd2', label = 'Bravado Buffalo', price = 5000},
			{model = 'dw_lspd3', label = 'Vapid Interceptor', price = 5000},
			{model = 'pdrafter', label = 'Drafter', price = 5000},

			{model = 'dw_pscout', label = 'Vapid Scout', price = 5000},
			{model = 'dw_polspeedo', label = 'Van', price = 5000},

			{model = 'dw_lspdb', label = 'Police Bike', price = 5000},

			{model = 'dw_polriot', label = 'Riot', price = 10000},

		},

		commissioner = {
			{model = 'dw_lspd1', label = 'Vapid Cruiser', price = 5000},

			{model = 'dw_lspd2', label = 'Bravado Buffalo', price = 5000},
			{model = 'dw_lspd3', label = 'Vapid Interceptor', price = 5000},
			{model = 'pdrafter', label = 'Drafter', price = 5000},

			{model = 'dw_police42', label = 'Bravado Buffalo UM', price = 5000},
			{model = 'dw_lspd4', label = 'Vapid UM', price = 5000},

			{model = 'dw_beachp', label = 'Vapid Contender', price = 5000},
			{model = 'dw_pscout', label = 'Vapid Scout', price = 5000},
			{model = 'dw_polspeedo', label = 'Van', price = 5000},

			{model = 'dw_lspdb', label = 'Police Bike', price = 5000},

			{model = 'dw_polriot', label = 'Riot', price = 10000},
			
		},

		instructor = {
			{model = 'dw_lspd1', label = 'Vapid Cruiser', price = 5000},

			{model = 'dw_lspd2', label = 'Bravado Buffalo', price = 5000},
			{model = 'dw_lspd3', label = 'Vapid Interceptor', price = 5000},
			{model = 'pdrafter', label = 'Drafter', price = 5000},

			{model = 'dw_police42', label = 'Bravado Buffalo UM', price = 5000},
			{model = 'dw_lspd4', label = 'Vapid UM', price = 5000},

			{model = 'dw_beachp', label = 'Vapid Contender', price = 5000},
			{model = 'dw_pscout', label = 'Vapid Scout', price = 5000},
			{model = 'dw_polspeedo', label = 'Van', price = 5000},

			{model = 'dw_lspdb', label = 'Police Bike', price = 5000},

			{model = 'dw_polriot', label = 'Riot', price = 10000},
			

		},

		chiefofacademy = {
			{model = 'dw_lspd1', label = 'Vapid Cruiser', price = 5000},

			{model = 'dw_lspd2', label = 'Bravado Buffalo', price = 5000},
			{model = 'dw_lspd3', label = 'Vapid Interceptor', price = 5000},
			{model = 'pdrafter', label = 'Drafter', price = 5000},

			{model = 'dw_police42', label = 'Bravado Buffalo UM', price = 5000},
			{model = 'dw_lspd4', label = 'Vapid UM', price = 5000},

			{model = 'dw_beachp', label = 'Vapid Contender', price = 5000},
			{model = 'dw_pscout', label = 'Vapid Scout', price = 5000},
			{model = 'dw_polspeedo', label = 'Van', price = 5000},

			{model = 'dw_lspdb', label = 'Police Bike', price = 5000},

			{model = 'dw_polriot', label = 'Riot', price = 10000},
			

		},

		chiefofdepartment = {
			{model = 'dw_lspd1', label = 'Vapid Cruiser', price = 5000},

			{model = 'dw_lspd2', label = 'Bravado Buffalo', price = 5000},
			{model = 'dw_lspd3', label = 'Vapid Interceptor', price = 5000},
			{model = 'pdrafter', label = 'Drafter', price = 5000},

			{model = 'dw_police42', label = 'Bravado Buffalo UM', price = 5000},
			{model = 'dw_lspd4', label = 'Vapid UM', price = 5000},

			{model = 'dw_beachp', label = 'Vapid Contender', price = 5000},
			{model = 'dw_pscout', label = 'Vapid Scout', price = 5000},
			{model = 'dw_polspeedo', label = 'Van', price = 5000},

			{model = 'dw_lspdb', label = 'Police Bike', price = 5000},

			{model = 'dw_polriot', label = 'Riot', price = 10000},
			

		},

		boss = {
			{model = 'dw_lspd1', label = 'Vapid Cruiser', price = 5000},

			{model = 'dw_lspd2', label = 'Bravado Buffalo', price = 5000},
			{model = 'dw_lspd3', label = 'Vapid Interceptor', price = 5000},
			{model = 'police3', label = 'Vapid Interceptor 2', price = 5000},
			{model = 'pdrafter', label = 'Drafter', price = 5000},

			{model = 'dw_police42', label = 'Bravado Buffalo UM', price = 5000},
			{model = 'dw_lspd4', label = 'Vapid UM', price = 5000},

			{model = 'dw_beachp', label = 'Vapid Contender', price = 5000},
			{model = 'dw_pscout', label = 'Vapid Scout', price = 5000},
			{model = 'dw_polspeedo', label = 'Van', price = 5000},

			{model = 'dw_lspdb', label = 'Police Bike', price = 5000},

			{model = 'dw_polriot', label = 'Riot', price = 10000},
			
		}
	},

	helicopter = {
		cadet = {},

		officer = {},

		detective = {},

		sergeant = {
			{ model = 'buzzard2', label = 'Buzzard', livery = 0, price = 20000 }
		},

		firstsergeant = {
			{ model = 'buzzard2', label = 'Buzzard', livery = 0, price = 20000 }
		},

		lieutenant = {
			{ model = 'buzzard2', label = 'Buzzard', livery = 0, price = 20000 }
		},

		commissioner = {
			{ model = 'buzzard2', label = 'Buzzard', livery = 0, price = 20000 }
		},

		instructor = {
			{ model = 'buzzard2', label = 'Buzzard', livery = 0, price = 20000 }
		},

		chiefofacademy = {
			{ model = 'buzzard2', label = 'Buzzard', livery = 0, price = 20000 }
		},

		chiefofdepartment = {
			{ model = 'buzzard2', label = 'Buzzard', livery = 0, price = 20000 }
		},

		boss = {
			{ model = 'buzzard2', label = 'Buzzard', livery = 0, price = 20000 }
		}
	}
}

Config.CustomPeds = {
	shared = {
		{label = 'Sheriff Ped', maleModel = 's_m_y_sheriff_01', femaleModel = 's_f_y_sheriff_01'},
		{label = 'Police Ped', maleModel = 's_m_y_cop_01', femaleModel = 's_f_y_cop_01'}
	},

	recruit = {},

	officer = {},

	sergeant = {},

	lieutenant = {},

	boss = {
		{label = 'SWAT Ped', maleModel = 's_m_y_swat_01', femaleModel = 's_m_y_swat_01'}
	}
}

-- CHECK SKINCHANGER CLIENT MAIN.LUA for matching elements
Config.Uniforms = {
	cadet = {
		male = {
			tshirt_1 = 38,  tshirt_2 = 1,
			torso_1 = 55,   torso_2 = 0,
			decals_1 = 8,   decals_2 = 3,
			arms = 41,
			pants_1 = 25,   pants_2 = 0,
			shoes_1 = 25,   shoes_2 = 0,
			helmet_1 = -1,  helmet_2 = 0,
			chain_1 = 0,    chain_2 = 0,
			ears_1 = 2,     ears_2 = 0,
			bproof_1 = 12,	bproof_2 = 3,
			lefthand_1 = -1,	lefthand_2 = 0,
			righthand_1 = -1,	righthand_2 = 0
		},
		female = {
			tshirt_1 = 35,  tshirt_2 = 0,
			torso_1 = 48,   torso_2 = 0,
			decals_1 = 7,   decals_2 = 3,
			arms = 44,
			pants_1 = 34,   pants_2 = 0,
			shoes_1 = 27,   shoes_2 = 0,
			helmet_1 = -1,  helmet_2 = 0,
			chain_1 = 0,    chain_2 = 0,
			ears_1 = 2,     ears_2 = 0,
			bproof_1 = 13,	bproof_2 = 1
		}
	},

	officer = {
		male = {
			tshirt_1 = 58,  tshirt_2 = 0,
			torso_1 = 55,   torso_2 = 0,
			decals_1 = 8,   decals_2 = 3,
			arms = 41,
			pants_1 = 25,   pants_2 = 0,
			shoes_1 = 25,   shoes_2 = 0,
			helmet_1 = -1,  helmet_2 = 0,
			chain_1 = 0,    chain_2 = 0,
			ears_1 = 2,     ears_2 = 0,
			bproof_1 = 12,	bproof_2 = 3
		},
		female = {
			tshirt_1 = 35,  tshirt_2 = 0,
			torso_1 = 48,   torso_2 = 0,
			decals_1 = 7,   decals_2 = 3,
			arms = 44,
			pants_1 = 34,   pants_2 = 0,
			shoes_1 = 27,   shoes_2 = 0,
			helmet_1 = -1,  helmet_2 = 0,
			chain_1 = 0,    chain_2 = 0,
			ears_1 = 2,     ears_2 = 0,
			bproof_1 = 13,	bproof_2 = 1
		}
	},

	detective = {
		male = {
			tshirt_1 = 58,  tshirt_2 = 0,
			torso_1 = 55,   torso_2 = 0,
			decals_1 = 8,   decals_2 = 3,
			arms = 41,
			pants_1 = 25,   pants_2 = 0,
			shoes_1 = 25,   shoes_2 = 0,
			helmet_1 = -1,  helmet_2 = 0,
			chain_1 = 0,    chain_2 = 0,
			ears_1 = 2,     ears_2 = 0,
			bproof_1 = 12,	bproof_2 = 3
		},
		female = {
			tshirt_1 = 35,  tshirt_2 = 0,
			torso_1 = 48,   torso_2 = 0,
			decals_1 = 7,   decals_2 = 3,
			arms = 44,
			pants_1 = 34,   pants_2 = 0,
			shoes_1 = 27,   shoes_2 = 0,
			helmet_1 = -1,  helmet_2 = 0,
			chain_1 = 0,    chain_2 = 0,
			ears_1 = 2,     ears_2 = 0,
			bproof_1 = 13,	bproof_2 = 1
		}
	},

	sergeant = {
		male = {
			tshirt_1 = 58,  tshirt_2 = 0,
			torso_1 = 55,   torso_2 = 0,
			decals_1 = 8,   decals_2 = 3,
			arms = 41,
			pants_1 = 25,   pants_2 = 0,
			shoes_1 = 25,   shoes_2 = 0,
			helmet_1 = -1,  helmet_2 = 0,
			chain_1 = 0,    chain_2 = 0,
			ears_1 = 2,     ears_2 = 0,
			bproof_1 = 12,	bproof_2 = 3
		},
		female = {
			tshirt_1 = 35,  tshirt_2 = 0,
			torso_1 = 48,   torso_2 = 0,
			decals_1 = 7,   decals_2 = 3,
			arms = 44,
			pants_1 = 34,   pants_2 = 0,
			shoes_1 = 27,   shoes_2 = 0,
			helmet_1 = -1,  helmet_2 = 0,
			chain_1 = 0,    chain_2 = 0,
			ears_1 = 2,     ears_2 = 0,
			bproof_1 = 13,	bproof_2 = 1
		}
	},

	firstsergeant = {
		male = {
			tshirt_1 = 58,  tshirt_2 = 0,
			torso_1 = 55,   torso_2 = 0,
			decals_1 = 8,   decals_2 = 3,
			arms = 41,
			pants_1 = 25,   pants_2 = 0,
			shoes_1 = 25,   shoes_2 = 0,
			helmet_1 = -1,  helmet_2 = 0,
			chain_1 = 0,    chain_2 = 0,
			ears_1 = 2,     ears_2 = 0,
			bproof_1 = 12,	bproof_2 = 3
		},
		female = {
			tshirt_1 = 35,  tshirt_2 = 0,
			torso_1 = 48,   torso_2 = 0,
			decals_1 = 7,   decals_2 = 3,
			arms = 44,
			pants_1 = 34,   pants_2 = 0,
			shoes_1 = 27,   shoes_2 = 0,
			helmet_1 = -1,  helmet_2 = 0,
			chain_1 = 0,    chain_2 = 0,
			ears_1 = 2,     ears_2 = 0,
			bproof_1 = 13,	bproof_2 = 1
		}
	},

	lieutenant = {
		male = {
			tshirt_1 = 58,  tshirt_2 = 0,
			torso_1 = 55,   torso_2 = 0,
			decals_1 = 8,   decals_2 = 3,
			arms = 41,
			pants_1 = 25,   pants_2 = 0,
			shoes_1 = 25,   shoes_2 = 0,
			helmet_1 = -1,  helmet_2 = 0,
			chain_1 = 0,    chain_2 = 0,
			ears_1 = 2,     ears_2 = 0,
			bproof_1 = 12,	bproof_2 = 3
		},
		female = {
			tshirt_1 = 35,  tshirt_2 = 0,
			torso_1 = 48,   torso_2 = 0,
			decals_1 = 7,   decals_2 = 3,
			arms = 44,
			pants_1 = 34,   pants_2 = 0,
			shoes_1 = 27,   shoes_2 = 0,
			helmet_1 = -1,  helmet_2 = 0,
			chain_1 = 0,    chain_2 = 0,
			ears_1 = 2,     ears_2 = 0,
			bproof_1 = 13,	bproof_2 = 1
		}
	},

	commissioner = {
		male = {
			tshirt_1 = 58,  tshirt_2 = 0,
			torso_1 = 55,   torso_2 = 0,
			decals_1 = 8,   decals_2 = 3,
			arms = 41,
			pants_1 = 25,   pants_2 = 0,
			shoes_1 = 25,   shoes_2 = 0,
			helmet_1 = -1,  helmet_2 = 0,
			chain_1 = 0,    chain_2 = 0,
			ears_1 = 2,     ears_2 = 0,
			bproof_1 = 12,	bproof_2 = 3
		},
		female = {
			tshirt_1 = 35,  tshirt_2 = 0,
			torso_1 = 48,   torso_2 = 0,
			decals_1 = 7,   decals_2 = 3,
			arms = 44,
			pants_1 = 34,   pants_2 = 0,
			shoes_1 = 27,   shoes_2 = 0,
			helmet_1 = -1,  helmet_2 = 0,
			chain_1 = 0,    chain_2 = 0,
			ears_1 = 2,     ears_2 = 0,
			bproof_1 = 13,	bproof_2 = 1
		}
	},

	instructor = {
		male = {
			tshirt_1 = 58,  tshirt_2 = 0,
			torso_1 = 55,   torso_2 = 0,
			decals_1 = 8,   decals_2 = 3,
			arms = 41,
			pants_1 = 25,   pants_2 = 0,
			shoes_1 = 25,   shoes_2 = 0,
			helmet_1 = -1,  helmet_2 = 0,
			chain_1 = 0,    chain_2 = 0,
			ears_1 = 2,     ears_2 = 0,
			bproof_1 = 12,	bproof_2 = 3
		},
		female = {
			tshirt_1 = 35,  tshirt_2 = 0,
			torso_1 = 48,   torso_2 = 0,
			decals_1 = 7,   decals_2 = 3,
			arms = 44,
			pants_1 = 34,   pants_2 = 0,
			shoes_1 = 27,   shoes_2 = 0,
			helmet_1 = -1,  helmet_2 = 0,
			chain_1 = 0,    chain_2 = 0,
			ears_1 = 2,     ears_2 = 0,
			bproof_1 = 13,	bproof_2 = 1
		}
	},

	chiefofacademy = {
		male = {
			tshirt_1 = 58,  tshirt_2 = 0,
			torso_1 = 55,   torso_2 = 0,
			decals_1 = 8,   decals_2 = 3,
			arms = 41,
			pants_1 = 25,   pants_2 = 0,
			shoes_1 = 25,   shoes_2 = 0,
			helmet_1 = -1,  helmet_2 = 0,
			chain_1 = 0,    chain_2 = 0,
			ears_1 = 2,     ears_2 = 0,
			bproof_1 = 12,	bproof_2 = 3
		},
		female = {
			tshirt_1 = 35,  tshirt_2 = 0,
			torso_1 = 48,   torso_2 = 0,
			decals_1 = 7,   decals_2 = 3,
			arms = 44,
			pants_1 = 34,   pants_2 = 0,
			shoes_1 = 27,   shoes_2 = 0,
			helmet_1 = -1,  helmet_2 = 0,
			chain_1 = 0,    chain_2 = 0,
			ears_1 = 2,     ears_2 = 0,
			bproof_1 = 13,	bproof_2 = 1
		}
	},

	chiefofdepartment = {
		male = {
			tshirt_1 = 58,  tshirt_2 = 0,
			torso_1 = 55,   torso_2 = 0,
			decals_1 = 8,   decals_2 = 3,
			arms = 41,
			pants_1 = 25,   pants_2 = 0,
			shoes_1 = 25,   shoes_2 = 0,
			helmet_1 = -1,  helmet_2 = 0,
			chain_1 = 0,    chain_2 = 0,
			ears_1 = 2,     ears_2 = 0,
			bproof_1 = 12,	bproof_2 = 3
		},
		female = {
			tshirt_1 = 35,  tshirt_2 = 0,
			torso_1 = 48,   torso_2 = 0,
			decals_1 = 7,   decals_2 = 3,
			arms = 44,
			pants_1 = 34,   pants_2 = 0,
			shoes_1 = 27,   shoes_2 = 0,
			helmet_1 = -1,  helmet_2 = 0,
			chain_1 = 0,    chain_2 = 0,
			ears_1 = 2,     ears_2 = 0,
			bproof_1 = 13,	bproof_2 = 1
		}
	},

	boss = {
		male = {
			tshirt_1 = 58,  tshirt_2 = 0,
			torso_1 = 55,   torso_2 = 0,
			decals_1 = 8,   decals_2 = 3,
			arms = 41,
			pants_1 = 25,   pants_2 = 0,
			shoes_1 = 25,   shoes_2 = 0,
			helmet_1 = -1,  helmet_2 = 0,
			chain_1 = 0,    chain_2 = 0,
			ears_1 = 2,     ears_2 = 0,
			bproof_1 = 12,	bproof_2 = 3
		},
		female = {
			tshirt_1 = 35,  tshirt_2 = 0,
			torso_1 = 48,   torso_2 = 0,
			decals_1 = 7,   decals_2 = 3,
			arms = 44,
			pants_1 = 34,   pants_2 = 0,
			shoes_1 = 27,   shoes_2 = 0,
			helmet_1 = -1,  helmet_2 = 0,
			chain_1 = 0,    chain_2 = 0,
			ears_1 = 2,     ears_2 = 0,
			bproof_1 = 13,	bproof_2 = 1
		}
	},

	bullet_wear = {
		male = {
			bproof_1 = 11,  bproof_2 = 1
		},
		female = {
			bproof_1 = 13,  bproof_2 = 1
		}
	},

	gilet_wear = {
		male = {
			tshirt_1 = 59,  tshirt_2 = 1
		},
		female = {
			tshirt_1 = 36,  tshirt_2 = 1
		}
	}
}
