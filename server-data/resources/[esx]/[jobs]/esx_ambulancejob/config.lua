Config                            = {}

Config.DrawDistance               = 20.0 -- How close do you need to be in order for the markers to be drawn (in GTA units).

Config.Marker                     = {type = 22, x = 1.0, y = 1.0, z = 1.0, r = 255, g = 255, b = 255, a = 100, rotate = true}

Config.ReviveReward               = 700  -- Revive reward, set to 0 if you don't want it enabled
Config.AntiCombatLog              = true -- Enable anti-combat logging? (Removes Items when a player logs back after intentionally logging out while dead.)
Config.LoadIpl                    = false -- Disable if you're using fivem-ipl or other IPL loaders

Config.Locale                     = 'de'

local second = 1000
local minute = 60 * second

Config.Test						  = 1 * minute
Config.EarlyRespawnTimer          = 5 * minute  -- time til respawn is available
Config.BleedoutTimer              = 10 * minute -- time til the player bleeds out

Config.EnablePlayerManagement     = true -- Enable society managing (If you are using esx_society).

Config.RemoveWeaponsAfterRPDeath  = true
Config.RemoveCashAfterRPDeath     = true
Config.RemoveItemsAfterRPDeath    = true

-- Let the player pay for respawning early, only if he can afford it.
Config.EarlyRespawnFine           = false
Config.EarlyRespawnFineAmount     = 5000

Config.RespawnPoint = {coords = vector3(323.79553222656, -585.19396972656, 43.284103393555), heading = 48.5}

Config.Hospitals = {

	CentralLosSantos = {

		Blip = {
			coords = vector3(324.17709350586, -594.18255615234, 100.3304901123),
			sprite = 61,
			scale  = 0.8,
			color  = 1
		},

		Cloakroom = {
			vector3(301.29077148438, -599.67864990234, 43.284099578857)
		},

		AmbulanceActions = {
			vector3(334.56768798828, -593.51287841797, 43.284057617188)
		},

		Pharmacies = {
			vector3(309.19277954102, -562.51501464844, 43.28409576416)
		},

		Vehicles = {
			{
				Spawner = vector3(330.19940185547, -572.87377929688, 28.796852111816),
				InsideShop = vector3(446.7, -1355.6, 43.5),
				Marker = {type = 36, x = 1.0, y = 1.0, z = 1.0, r = 255, g = 255, b = 255, a = 100, rotate = true},
				SpawnPoints = {
					{coords = vector3(319.80474853516, -569.76348876953, 28.796842575073), heading = 250.0, radius = 4.0},
					{coords = vector3(320.91900634766, -565.55609130859, 28.796844482422), heading = 250.0, radius = 4.0},
					{coords = vector3(317.29678344727, -573.89868164062, 28.796844482422), heading = 250.0, radius = 4.0},
					{coords = vector3(316.25762939453, -578.05090332031, 28.796846389771), heading = 250.0, radius = 4.0}
				}
			}
		},

		Helicopters = {
			{
				Spawner = vector3(317.5, -1449.5, 46.5),
				InsideShop = vector3(305.6, -1419.7, 41.5),
				Marker = {type = 34, x = 1.5, y = 1.5, z = 1.5, r = 100, g = 150, b = 150, a = 100, rotate = true},
				SpawnPoints = {
					{coords = vector3(313.5, -1465.1, 46.5), heading = 142.7, radius = 10.0},
					{coords = vector3(299.5, -1453.2, 46.5), heading = 142.7, radius = 10.0}
				}
			}
		},

		FastTravels = {
			{
				From = vector3(294.7, -1448.1, -29.0),
				To = { coords = vector3(272.8, -1358.8, 23.5), heading = 0.0 },
				Marker = { type = 1, x = 2.0, y = 2.0, z = 0.5, r = 102, g = 0, b = 102, a = 100, rotate = false }
			},

			{
				From = vector3(275.3, -1361, 23.5),
				To = { coords = vector3(295.8, -1446.5, 28.9), heading = 0.0 },
				Marker = { type = 1, x = 2.0, y = 2.0, z = 0.5, r = 102, g = 0, b = 102, a = 100, rotate = false }
			},

			{
				From = vector3(247.3, -1371.5, 23.5),
				To = { coords = vector3(333.1, -1434.9, 45.5), heading = 138.6 },
				Marker = { type = 1, x = 1.5, y = 1.5, z = 0.5, r = 102, g = 0, b = 102, a = 100, rotate = false }
			},

			{
				From = vector3(335.5, -1432.0, 45.50),
				To = { coords = vector3(249.1, -1369.6, 23.5), heading = 0.0 },
				Marker = { type = 1, x = 2.0, y = 2.0, z = 0.5, r = 102, g = 0, b = 102, a = 100, rotate = false }
			},

			{
				From = vector3(234.5, -1373.7, 20.9),
				To = { coords = vector3(320.9, -1478.6, 28.8), heading = 0.0 },
				Marker = { type = 1, x = 1.5, y = 1.5, z = 1.0, r = 102, g = 0, b = 102, a = 100, rotate = false }
			},

			{
				From = vector3(317.9, -1476.1, 28.9),
				To = { coords = vector3(238.6, -1368.4, 23.5), heading = 0.0 },
				Marker = { type = 1, x = 1.5, y = 1.5, z = 1.0, r = 102, g = 0, b = 102, a = 100, rotate = false }
			},
			
		},

		FastTravelsPrompt = {

			{
				From = vector3(332.39, -595.71, 43.28),
				To = { coords = vector3(339.82, -584.29, 74.0), heading = 250.0 },
				Marker = { type = 22, x = 1.0, y = 1.0, z = 1.0, r = 255, g = 255, b = 255, a = 100, rotate = true },
				Prompt = _U('fast_travel')
			},
			
			{
				From = vector3(339.82, -584.29, 74.0),
				To = { coords = vector3(332.39, -595.71, 43.28), heading = 72.0 },
				Marker = { type = 22, x = 1.0, y = 1.0, z = 1.0, r = 255, g = 255, b = 255, a = 100, rotate = true },
				Prompt = _U('fast_travel')
			},
			
			-- 
			
			{
				From = vector3(330.35, -601.16, 43.28),
				To = { coords = vector3(339.92929077148, -584.63385009766, 28.796850204468), heading = 72.0 },
				Marker = { type = 22, x = 1.0, y = 1.0, z = 1.0, r = 255, g = 255, b = 255, a = 100, rotate = true },
				Prompt = _U('fast_travel')
			},
			
			{
				From = vector3(339.92929077148, -584.63385009766, 28.796850204468),
				To = { coords = vector3(330.35, -601.16, 42.28), heading = 74.0 },
				Marker = { type = 22, x = 1.0, y = 1.0, z = 1.0, r = 255, g = 255, b = 255, a = 100, rotate = true },
				Prompt = _U('fast_travel')
			},
		}

	}
}

Config.AuthorizedVehicles = {
	car = {
		rettungshelfer = {
			{model = 'ambulance', price = 5000}
		},

		rettungssani = {
			{model = 'ambulance', price = 4500},
			{model = 'dw_ambulance', price = 5000},
			{model = 'emsnspeedo', price = 6500}
		},

		notfallsani = {
			{model = 'ambulance', price = 3000},
			{model = 'dw_ambulance', price = 5000},
			{model = 'dw_ambulance2', price = 5000},
			{model = 'emsnspeedo', price = 6500}
		},

		arzt = {
			{model = 'ambulance', price = 3000},
			{model = 'dw_ambulance', price = 5000},
			{model = 'dw_ambulance2', price = 5000},
			{model = 'dw_emscar', price = 5000},
			{model = 'emsnspeedo', price = 6500}
		},

		notundfacharzt = {
			{model = 'ambulance', price = 3000},
			{model = 'dw_ambulance', price = 5000},
			{model = 'dw_ambulance2', price = 5000},
			{model = 'dw_emscar', price = 5000},
			{model = 'dw_emscar2', price = 5000},
			{model = 'emsnspeedo', price = 6500}
		},

		oberarzt = {
			{model = 'emsnspeedo', price = 5000},
			{model = 'dw_ambulance', price = 5000},
			{model = 'dw_ambulance2',  price = 5000},
			{model = 'dw_emscar', price = 5000},
			{model = 'dw_emscar2', price = 5000},
			{model = 'dw_emssuv', price = 5000},
			{model = 'dw_emsvan', price = 5000}
		},

		boss = {
			{model = 'emsnspeedo', price = 5000},
			{model = 'dw_ambulance', price = 5000},
			{model = 'dw_ambulance2',  price = 5000},
			{model = 'dw_emscar', price = 5000},
			{model = 'dw_emscar2', price = 5000},
			{model = 'dw_emssuv', price = 5000},
			{model = 'dw_emsvan', price = 5000}
		}
	},

	helicopter = {
		rettungshelfer = {},

		rettungssani = {},

		notfallsani = {},

		arzt = {
			{ model = 'mh65c', label = 'MH 65 C', price = 10000},
			{ model = 'seasparrow', label = 'Sea Sparrow', price = 10000}
		},

		notundfacharzt = {
			{ model = 'mh65c', label = 'MH 65 C', price = 10000},
			{ model = 'seasparrow', label = 'Sea Sparrow', price = 10000}
		},

		oberarzt = {
			{model = 'mh65c', label = 'MH 65 C', price = 10000},
			{model = 'seasparrow', label = 'Sea Sparrow', price = 10000}
		},

		boss = {
			{model = 'mh65c', label = 'MH 65 C', price = 10000},
			{model = 'seasparrow', label = 'Sea Sparrow', price = 10000}
		}
	}
}
