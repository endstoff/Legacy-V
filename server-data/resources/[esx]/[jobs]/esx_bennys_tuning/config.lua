Config                   = {}
Config.DrawDistance      = 100.0
Config.Locale = 'de'
Config.IsMechanicJobOnly = true

Config.Zones = {

	ls1 = {
		Pos   = { x = -166.88163757324, y = -1304.4049072266, z = 31.296129226685},
		Size  = {x = 2.0, y = 2.0, z = 0.2},
		Color = {r = 204, g = 204, b = 0},
		Marker= 1,
		Hint  = _U('press_custom')
	},

	ls2 = {
		Pos   = { x = -214.46, y = -1323.69, z = 30.51},
		Size  = {x = 3.0, y = 3.0, z = 0.2},
		Color = {r = 204, g = 204, b = 0},
		Marker= 1,
		Hint  = _U('press_custom')
	},

	ls3 = {
		Pos   = { x = -198.17, y = -1324.4, z = 30.75},
		Size  = {x = 3.0, y = 3.0, z = 0.2},
		Color = {r = 204, g = 204, b = 0},
		Marker= 1,
		Hint  = _U('press_custom')
	},
	

}


Config.Menus = {
	main = {
		label		= 'Bennys',
		parent		= nil,
		upgrades	= _U('upgrades'),
	},
	upgrades = {
		label			= _U('upgrades'),
		parent			= 'main',
		modEngine		= _U('engine'),
		modBrakes		= _U('brakes'),
		modTransmission	= _U('transmission'),
		modSuspension	= _U('suspension'),
		modArmor		= _U('armor'),
		modTurbo		= _U('turbo')
	},
	modEngine = {
		label = _U('engine'),
		parent = 'upgrades',
		modType = 11,
		price = {1.00, 1.00, 1.00, 1.00}
	},
	modBrakes = {
		label = _U('brakes'),
		parent = 'upgrades',
		modType = 12,
		price = {1.00, 1.00, 1.00, 1.00}
	},
	modTransmission = {
		label = _U('transmission'),
		parent = 'upgrades',
		modType = 13,
		price = {1.00, 1.00, 1.00}
	},
	modSuspension = {
		label = _U('suspension'),
		parent = 'upgrades',
		modType = 15,
		price = {1.00, 1.00, 1.00, 1.00, 1.00}
	},
	modArmor = {
		label = _U('armor'),
		parent = 'upgrades',
		modType = 16,
		price = {1.00, 1.00, 1.00, 1.00, 1.00, 1.00}
	},
	modTurbo = {
		label = _U('turbo'),
		parent = 'upgrades',
		modType = 17,
		price = {1.81}
	},
	

}
