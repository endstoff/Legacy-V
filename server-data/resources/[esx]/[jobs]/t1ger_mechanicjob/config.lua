-------------------------------------
------- Created by T1GER#9080 -------
------------------------------------- 

Config = {}

Config.ESXSHAREDOBJECT = 'esx:getSharedObject'
Config.ItemLabelESX	= true	-- set to false if your ESX vers. doesn't support this

-- Buttons:
Config.KeyToManageShop			= 38		-- Default: [E]
Config.KeyToBuyMechShop			= 38		-- Default: [E]		
Config.KeyToPushPickUpObjs 		= 74		-- Set key to push or pick up/place props in prop emotes
Config.KeyToMechActionMenu 		= 167		-- Default: [F6]

-- General Settings:
Config.PurchasableMechBlip 	    = true		-- Blip to show mechanic shops forsale
Config.PayMechShopWithCash		= true		-- Set to false to pay mech shop with bank
Config.RecieveSoldMechShopCash	= true		-- Set to false to receive bank money on sale of drug lab
Config.SellPercent				= 0.75		-- Means player gets 75% in return from original paid price
Config.BillingToMechAccount		= true		-- Set to false to let the mechanic keep all the money from the billing.
Config.BillingPercentToAcc		= 0.50		-- Set percantage of billing (0.50 means 50%) amount to go to mechanic shop account, works only if BillingToMechAccount is set to true.

-- Vehicle Damage Snippet:
Config.UseKMH 					= true		-- Set to false to use MPH system for calculations with speed.
Config.SlashTires				= false		-- Set to false to disable slashing random tires, upon vehicle collision. 
Config.EngineDisable			= true		-- Set to false to disable engine being disabled, upon vehicle collision.
Config.WaitCountForHealth		= 60		-- Set amount of seconds to wait, until health part damage effects applies to vehicle.
Config.AmountPartsDamage		= 3			-- Set amount of parts to take damage, upon crash. Default; 3 parts.
Config.DegradeValue = {min = 5, max = 25}	-- Set min and max degrade value, upon crash. 5 is 0.5, 25 is 2.5. Between 0 and 100.
Config.Blacklisted_VehicleDMG = {"packer", "pounder", "biff", "ripley", "benson"}

Config.MechanicShops = {
[2] = {	
		price = 1,
		menuPos = {1769.6766357422,3323.9809570312,41.423931121826},
		storage = {1767.1079101562,3318.7692871094,41.438484191895},
		workbench = {1764.6774902344,3323.5383300781,41.438529968262},
		lifts = {
			[1] = {
				entry = {1780.1654052734,3330.8156738281,40.826171875,28.68},
				pos = {1781.5284423828,3328.2687988281,40.860782623291,28.68},
				control = {1778.7435302734,3324.5959472656,41.433292388916,67.39},
				marker = {enable = true, drawDist = 8.0, type = 36, scale = {x = 0.4, y = 0.4, z = 0.4}, color = {r = 240, g = 52, b = 52, a = 100}},
				minValue = 40.860782623291, maxValue = 43.1,
				currentVeh = nil,
				inUse = false,
				player = nil
			},
		},
	},
	[1] = { 
		price = 265000,
		menuPos = {-351.76455688477,-129.30741882324,39.014865875244},
		storage = {-325.87060546875,-123.1781539917,39.009632110596},
		workbench = {-339.96530151367,-141.74700927734,39.009609222412},
		lifts = {
			[1] = {
				entry = {-328.96591186523,-133.07327270508,39.009628295898,162.45},
				pos = {-327.96185302734,-130.41967773438,39.07971572876,161.73},
				control = {-325.28936767578,-131.36225891113,39.009620666504,67.39},
				marker = {enable = true, drawDist = 8.0, type = 36, scale = {x = 0.4, y = 0.4, z = 0.4}, color = {r = 240, g = 52, b = 52, a = 100}},
				minValue = 38.37, maxValue = 40.17,
				currentVeh = nil,
				inUse = false,
				player = nil
			},
		},
	},
}

-- Blip Settings:
Config.BlipSettings = { enable = true, sprite = 446, display = 4, scale = 0.65 } 

-- Marker settings::
Config.MarkerSettings = { enable = true, drawDist = 10.0, type = 20, scale = {x = 0.7, y = 0.7, z = 0.7}, color = {r = 240, g = 52, b = 52, a = 100} }
Config.RepairMarker = { enable = true, drawDist = 7.5, type = 20, scale = {x = 0.6, y = 0.6, z = 0.6}, color = {r = 255, g = 165, b = 0, a = 100}}

-- Repair Kit:
Config.RepairKits = {
	[1] = { label = "Repair Kit", item = "repairkit", chanceToKeep = 70, repairTime = 5000, progbar = Lang['repairing_veh_kit'] },
	[2] = { label = "Adv Reapir Kit", item = "advrepairkit", chanceToKeep = 95, repairTime = 3500, progbar = Lang['repairing_veh_kit'] },
}

-- Item name for carjack:
Config.CarJackItem = "carjack"

-- BODY PARTS FOR VEHICLE REPAIR:
Config.BodyParts = {
	[1] = {item = "car_door", prop = "prop_car_door_01", pos = {0.0, 0.0, 0.0}, rot = {0.0, 0.0, 0.0}},
	[2] = {item = "car_hood", prop = "prop_car_bonnet_01", pos = {0.0, 0.0, 0.0}, rot = {0.0, 0.0, 0.0}},
	[3] = {item = "car_trunk", prop = "prop_car_bonnet_02", pos = {0.0, 0.0, 0.0}, rot = {0.0, 0.0, 0.0}},
	[4] = {item = "car_wheel", prop = "prop_wheel_03", pos = {0.0, 0.0, 0.0}, rot = {0.0, 0.0, 0.0}},
}

-- CRAFTING PART:
Config.CraftTime = 4		-- set time in seconds, to craft item.

Config.Workbench = {
	[1] = {
		label = "Door", item = "car_door", 
		recipe = { [1] = {id = 2, qty = 5}, [2] = {id = 1, qty = 2}, [3] = {id = 4, qty = 4}, [4] = {id = 5, qty = 2} }
	},
	[2] = {
		label = "Hood", item = "car_hood", 
		recipe = { [1] = {id = 2, qty = 3}, [2] = {id = 4, qty = 2}, [3] = {id = 5, qty = 1} }
	},
	[3] = {
		label = "Trunk", item = "car_trunk", 
		recipe = { [1] = {id = 2, qty = 2}, [2] = {id = 1, qty = 1}, [3] = {id = 4, qty = 2}, [4] = {id = 3, qty = 1}, [5] = {id = 5, qty = 1} }
	},
	[4] = {
		label = "Wheel", item = "car_wheel", 
		recipe = { [1] = {id = 2, qty = 5}, [2] = {id = 1, qty = 8} }
	},
}

-- Materials used throughout the script:
Config.Materials = {
	[1] = {label = "Gummi", item = "rubber"},
	[2] = {label = "Altmetall", item = "scrap_metal"},
	[3] = {label = "Elektroschrott", item = "electric_scrap"},
	[4] = {label = "Plastik", item = "plastic"},
	[5] = {label = "Glas", item = "glass"},
	[6] = {label = "Aluminium", item = "aluminium"},
	[7] = {label = "Kupfer", item = "copper"},
	[8] = {label = "Stahl", item = "steel"}
}

-- Available Health Parts to repair and required materials and amounts:
Config.HealthParts = {
	[1] = { label = "Bremsen", degName = "brakes", materials = { [1] = {id = 1, qty = 3}, [2] = {id = 2, qty = 2} } },
	[2] = { label = "Motorkühlung", degName = "radiator", materials = { [1] = {id = 2, qty = 2} } },
	[3] = { label = "Kupplung", degName = "clutch", materials = { [1] = {id = 2, qty = 4} } },
	[4] = { label = "Getriebe", degName = "transmission", materials = { [1] = {id = 6, qty = 4} } },
	[5] = { label = "Elektronik", degName = "electronics", materials = {[1] = {id = 3, qty = 5}, [2] = {id = 4, qty = 3}}},
	[6] = { label = "Antriebswelle", degName = "driveshaft", materials = { [1] = {id = 2, qty = 4} } },
	[7] = { label = "Einspritzdüse", degName = "fuelinjector", materials = { [1] = {id = 7, qty = 4} } },
	[8] = { label = "Motor", degName = "engine", materials = { [1] = {id = 2, qty = 4}, [2] = {id = 8, qty = 4} } },
}

-- NPC Jobs Position:
Config.NPC_RepairJobs = {
	[1] = { pos = {879.88,-33.99,78.76,238.22}, inUse = false, ped = "s_m_y_dealer_01", payout = {min = 250, max = 400}},
	[2] = { pos = {1492.09,758.45,77.45,288.26}, inUse = false, ped = "s_m_y_dealer_01", payout = {min = 250, max = 400}},
	[3] = { pos = {387.67,-767.56,29.29,358.94}, inUse = false, ped = "s_m_y_dealer_01", payout = {min = 250, max = 400}},
	[4] = { pos = {-583.75,-239.55,36.08,33.14}, inUse = false, ped = "s_m_y_dealer_01", payout = {min = 250, max = 400}},
}

Config.TravelDistance = 2500.0 -- Set maximum distance for NPC repair jobs.

-- Vehicle scrambler for npc jobs:
Config.RepairVehicles = {"sultan", "blista", "glendale", "exemplar"}

-- Prop Emotes:
Config.PropEmotes = {
	["prop_roadcone02a"] = {label = "Road Cone", model = "prop_roadcone02a", bone = 28422, pos = {0.6,-0.15,-0.1}, rot = {315.0,288.0,0.0}},
	["prop_cs_trolley_01"] = {label = "Tool Trolley", model = "prop_cs_trolley_01", bone = 28422, pos = {-0.1,-0.6,-0.85}, rot = {-180.0,-165.0,90.0}},
	["prop_tool_box_04"] = {label = "Tool Box", model = "prop_tool_box_04", bone = 28422, pos = {0.4,-0.1,-0.1}, rot = {315.0,288.0,0.0}},
	["prop_engine_hoist"] = {label = "Engine Hoist", model = "prop_engine_hoist", bone = 28422, pos = {0.0,-0.5,-1.3}, rot = {-195.0,-180.0,180.0}}
}

-- Config blacklist vehicle on lift / carjack:
Config.Blacklisted_Lift = {"packer", "pounder", "biff", "ripley", "rumpo3", "benson"}
