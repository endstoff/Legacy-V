Config = {}
Translation = {}

Config.Locale = 'de'

Config.ShowFarmingBlipText = true

Config.FarmingAreas = { 

    {requiredJob = nil, xptype = nil, blip = {sprite = -1, color = 7, data = nil}, items = {{name = 'carbatt', label = 'Autobatterie'}}, x = 2334.5830078125, y = 3050.7287597656, z = 48.151702880859, range = 5.0, randoma = 1, randomb = 2, collectingTime = 10, animation = "WORLD_HUMAN_WELDING"},
    {requiredJob = nil, xptype = nil, blip = {sprite = -1, color = 7, data = nil}, items = {{name = 'psiloshroom', label = 'Psilocybine Pilze'}}, x = -2156.1760253906, y = 2441.3217773438, z = 3.2220993041992, range = 10.0, randoma = 1, randomb = 2, collectingTime = 10, animation = "PROP_HUMAN_BUM_BIN"},
    {requiredJob = nil, xptype = nil, blip = {sprite = -1, color = 7, data = nil}, items = {{name = 'amphetamine', label = 'Amphetamine'}}, x = 2433.11328125, y = 4970.7255859375, z = 42.347602844238, range = 3.0, randoma = 1, randomb = 1, collectingTime = 10, animation = "PROP_HUMAN_BUM_BIN"},
    {requiredJob = nil, xptype = nil, blip = {sprite = -1, color = 7, data = nil}, items = {{name = 'carton', label = 'Karton'}}, x = -593.12225341797, y = -1607.2611083984, z = 27.010812759399, range = 3.0, randoma = 1, randomb = 3, collectingTime = 10, animation = "PROP_HUMAN_BUM_BIN"},
    {requiredJob = nil, xptype = nil, blip = {sprite = -1, color = 7, data = nil}, items = {{name = 'chemtrash', label = 'Chemieabfälle'}}, x = 853.11499023438, y = -958.36785888672, z = 26.282341003418, range = 3.0, randoma = 1, randomb = 1, collectingTime = 10, animation = "PROP_HUMAN_BUM_BIN"},
    {requiredJob = nil, xptype = nil, blip = {sprite = -1, color = 7, data = nil}, items = {{name = 'malware', label = 'Malware Diskette'}}, x = -1044.8726806641, y = -240.38133239746, z = 37.964935302734, range = 1.0, randoma = 1, randomb = 1, collectingTime = 120, animation = "PROP_HUMAN_PARKING_METER"},
}

Config.CraftTime = 4 -- in sek
Config.CraftBlipIcon = -1
Config.CraftBlipColour = 0

Config.Processor = {
    {requiredJob = nil, ItemsId = 1, label = 'Recycler', XPType = 'recycle', ped = "s_m_y_garbage", x = 472.47836303711, y = -1311.0555419922, z = 29.218948364258, rot = 120.33},
    {requiredJob = nil, ItemsId = 2, label = 'Küche', XPType = 'chemical', ped = "csb_ortega", x = 1390.3225097656, y = 3606.9924316406, z = 38.941898345947, rot = 20.27},
    {requiredJob = nil, ItemsId = 3, label = 'Redneck', XPType = 'naturals', ped = "s_m_m_trucker_01", x = 1444.5367431641, y = 6333.451171875, z = 23.87401008606, rot = 87.94},
    {requiredJob = nil, ItemsId = 4, label = 'Waffenmanufaktur', XPType = 'weapon', ped = "csb_mweather", x = -1805.1008300781, y = 3088.8745117188, z = 32.841800689697, rot = 322.74},
    {requiredJob = nil, ItemsId = 5, label = 'Utensilien', XPType = 'hacking', ped = "ig_lestercrest", x = 1275.7425537109, y = -1710.4105224609, z = 54.771446228027, rot = 190.98},
    {requiredJob = nil, ItemsId = 6, label = 'Produkt verpacken', XPType = 'packing', ped = "g_m_m_chemwork_01", x = 153.86578369141, y = -3214.4899902344, z = 5.9286022186279, rot = 82.32},

}

Config.Seller = {
    {requiredJob = nil, isExport = true, label = 'Pablo', priceModifier = 20.0, x = -1153.1656494141, y = -1521.837890625, z = 10.642493247986, rot = 67.39},
    {requiredJob = nil, isExport = false, label = 'Vermittler', priceModifier = 20.0, x = -445.00210571289, y = -2183.5539550781, z = 10.318190574646, rot = 67.39},
}


Config.useIntegratedWeightSystem = false
Config.useESXWeightSystem = true -- disable Config.useIntegratedWeightSystem when you want to use this

Config.MaxCarry = 3500

Config.ItemLimits = {

    ['battacid'] = 60,
    ['carbatt'] = 60,
    ['kroko'] = 60,
    ['psiloshroom'] = 60,
    ['magicshroom'] = 60,
    ['chemtrash'] = 60,
    ['amphetamine'] = 60,
    ['carton'] = 60,
    ['moonshine'] = 60,
    ['lsdsheets'] = 60,
    ['lsd'] = 60,
    ['xtc'] = 60,
    ['malkaloid'] = 60,
    ['semiload'] = 60,
    ['autoload'] = 60,
    ['highpress'] = 60,

}


Config.Items = {

    {
        id = 1,
        reqXP = 0,
        giveXP = {type = 'recycle', a = 1, b = 3},
        reqItems = {
            {item = 'carbatt', label = 'Autobatterie', amount = 2}},
        newitem = {sqlitem = 'battacid', label = 'Batteriesäure'},
        newitemamount = 2,
        craftAmount = 10
    },

    {
        id = 1,
        reqXP = 0,
        giveXP = {type = 'recycle', a = 1, b = 3},
        reqItems = {
            {item = 'carton', label = 'Karton', amount = 1}},
        newitem = {sqlitem = 'lsdsheets', label = 'LSD Bögen'},
        newitemamount = 1,
        craftAmount = 10
    },

    {
        id = 1,
        reqXP = 0,
        giveXP = {type = 'recycle', a = 1, b = 3},
        reqItems = {
            {item = 'fixkit', label = 'Werkzeugkasten', amount = 1}},
        newitem = {sqlitem = 'highpress', label = 'Hochdruckventil'},
        newitemamount = 1,
        craftAmount = 10
    },

    {
        id = 2,
        reqXP = 0,
        giveXP = {type = 'chemical', a = 1, b = 3},
        reqItems = {
            {item = 'painkillers', label = 'Schmerzmittel', amount = 1},
            {item = 'battacid', label = 'Batteriesäure', amount = 1}},
        newitem = {sqlitem = 'kroko', label = 'Krokodil'},
        newitemamount = 1,
        craftAmount = 10
    },

    {
        id = 2,
        reqXP = 1000,
        giveXP = {type = 'chemical', a = 1, b = 3},
        reqItems = {
            {item = 'amphetamine', label = 'Amphetamine', amount = 1},
            {item = 'chemtrash', label = 'Chemieabfälle', amount = 1}},
        newitem = {sqlitem = 'xtc', label = 'Extacy'},
        newitemamount = 1,
        craftAmount = 10
    },

    {
        id = 3,
        reqXP = 0,
        giveXP = {type = 'naturals', a = 1, b = 3},
        reqItems = {
            {item = 'weat', label = 'Weizen', amount = 5}},
        newitem = {sqlitem = 'malkaloid', label = 'Mutterkornalkaloid'},
        newitemamount = 1,
        craftAmount = 10
    },

    {
        id = 3,
        reqXP = 0,
        giveXP = {type = 'naturals', a = 1, b = 3},
        reqItems = {
            {item = 'psiloshroom', label = 'Psilocybine Pilze', amount = 1}},
        newitem = {sqlitem = 'magicshroom', label = 'Magic Shroom'},
        newitemamount = 1,
        craftAmount = 10
    },

    {
        id = 3,
        reqXP = 500,
        giveXP = {type = 'naturals', a = 1, b = 3},
        reqItems = {
            {item = 'malkaloid', label = 'Mutterkornalkaloid', amount = 1},
            {item = 'lsdsheets', label = 'LSD Bögen', amount = 1}},
        newitem = {sqlitem = 'lsd', label = 'LSD'},
        newitemamount = 1,
        craftAmount = 10
    },

    {
        id = 3,
        reqXP = 1000,
        giveXP = {type = 'naturals', a = 1, b = 3},
        reqItems = {
            {item = 'weat', label = 'Weizen', amount = 1},
            {item = 'potato', label = 'Kartoffel', amount = 1}},
        newitem = {sqlitem = 'moonshine', label = 'Moonshine'},
        newitemamount = 1,
        craftAmount = 10
    },

    {
        id = 4,
        reqXP = 0,
        giveXP = {type = 'weapon', a = 10, b = 30},
        reqItems = {
            {item = 'aluminium', label = 'Aluminium', amount = 5}},
        newitem = {sqlitem = 'grip', label = 'Griff'},
        newitemamount = 1,
        craftAmount = 10
    },

    {
        id = 4,
        reqXP = 0,
        giveXP = {type = 'weapon', a = 10, b = 30},
        reqItems = {
            {item = 'steel', label = 'steel', amount = 5}},
        newitem = {sqlitem = 'barrel', label = 'Lauf'},
        newitemamount = 1,
        craftAmount = 10
    },

    {
        id = 4,
        reqXP = 500,
        giveXP = {type = 'weapon', a = 10, b = 30},
        reqItems = {
            {item = 'bolt', label = 'Bolzen', amount = 2},
            {item = 'spring', label = 'Feder', amount = 1},
            {item = 'screws', label = 'Schrauben', amount = 4}},
        newitem = {sqlitem = 'semiload', label = 'Semi Mechanismus'},
        newitemamount = 1,
        craftAmount = 10
    },

    {
        id = 4,
        reqXP = 800,
        giveXP = {type = 'weapon', a = 10, b = 30},
        reqItems = {
            {item = 'grip', label = 'Griff', amount = 1},
            {item = 'barrel', label = 'Lauf', amount = 1},
            {item = 'semiload', label = 'Semi Mechanismus', amount = 1},
            {item = 'steel', label = 'Stahl', amount = 5}},
        newitem = {sqlitem = 'pistolcaselight', label = 'Pistolen-Koffer Leicht'},
        newitemamount = 1,
        craftAmount = 1
    },

    {
        id = 4,
        reqXP = 6000,
        giveXP = {type = 'weapon', a = 100, b = 300},
        reqItems = {
            {item = 'grip', label = 'Griff', amount = 1},
            {item = 'barrel', label = 'Lauf', amount = 1},
            {item = 'semiload', label = 'Semi Mechanismus', amount = 1},
            {item = 'steel', label = 'Stahl', amount = 10},
            {item = 'screws', label = 'Schrauben', amount = 5}},
        newitem = {sqlitem = 'pistolcaseheavy', label = 'Pistolen-Koffer Schwer'},
        newitemamount = 1,
        craftAmount = 1
    },

    {
        id = 4,
        reqXP = 10000,
        giveXP = {type = 'weapon', a = 10, b = 30},
        reqItems = {
            {item = 'highpress', label = 'Hochdruckventil', amount = 1},
            {item = 'spring', label = 'Feder', amount = 2},
            {item = 'semiload', label = 'Semi Mechanismus', amount = 1},
            {item = 'steel', label = 'Stahl', amount = 10},
            {item = 'screws', label = 'Schrauben', amount = 5}},
        newitem = {sqlitem = 'autoload', label = 'Gasdruck Mechanismus'},
        newitemamount = 1,
        craftAmount = 10
    },

    {
        id = 4,
        reqXP = 25000,
        giveXP = {type = 'weapon', a = 100, b = 300},
        reqItems = {
            {item = 'grip', label = 'Griff', amount = 1},
            {item = 'barrel', label = 'Lauf', amount = 1},
            {item = 'autoload', label = 'Gasdruck Mechanismus', amount = 1},
            {item = 'steel', label = 'Stahl', amount = 10},
            {item = 'screws', label = 'Schrauben', amount = 5}},
        newitem = {sqlitem = 'smgcaselight', label = 'SMG-Koffer-Leicht'},
        newitemamount = 1,
        craftAmount = 1
    },

    {
        id = 4,
        reqXP = 45000,
        giveXP = {type = 'weapon', a = 10, b = 30},
        reqItems = {
            {item = 'autoload', label = 'Gasdruck Mechanismus', amount = 1},
            {item = 'spring', label = 'Feder', amount = 2},
            {item = 'barrel', label = 'Lauf', amount = 2},
            {item = 'grip', label = 'Griff', amount = 1},
            {item = 'screws', label = 'Schrauben', amount = 5},
            {item = 'steel', label = 'Stahl', amount = 50}},
        newitem = {sqlitem = 'smgcaseassault', label = 'Sturm-MP-Koffer'},
        newitemamount = 1,
        craftAmount = 1
    },

    {
        id = 5,
        reqXP = 0,
        giveXP = {type = 'hacking', a = 10, b = 30},
        reqItems = {
            {item = 'usb_unbeschrieben', label = 'USB Stick - Unbeschrieben', amount = 1},
            {item = 'malware', label = 'Malware Diskette', amount = 1}},
        newitem = {sqlitem = 'usb_beschrieben', label = 'USB Stick - Beschrieben'},
        newitemamount = 1,
        craftAmount = 1
    },

    {
        id = 5,
        reqXP = 0,
        giveXP = {type = 'hacking', a = 10, b = 30},
        reqItems = {
            {item = 'laptop', label = 'laptop', amount = 1},
            {item = 'usb_cable', label = 'USB Kabel', amount = 1},
            {item = 'malware', label = 'Malware Diskette', amount = 1}},
        newitem = {sqlitem = 'hacking_laptop', label = 'Laptop'},
        newitemamount = 1,
        craftAmount = 1
    },

    {
        id = 6,
        reqXP = 0,
        giveXP = {type = 'packing', a = 200, b = 300},
        reqItems = {
            {item = 'weed_pooch', label = 'Abgepacktes Weed', amount = 100}},
        newitem = {sqlitem = 'weed_brick', label = 'Weed Paket'},
        newitemamount = 1,
        craftAmount = 1
    },

    {
        id = 6,
        reqXP = 0,
        giveXP = {type = 'packing', a = 200, b = 300},
        reqItems = {
            {item = 'meth_pooch', label = 'Abgepacktes Meth', amount = 100}},
        newitem = {sqlitem = 'meth_brick', label = 'Meth Paket'},
        newitemamount = 1,
        craftAmount = 1
    },

    {
        id = 6,
        reqXP = 0,
        giveXP = {type = 'packing', a = 200, b = 300},
        reqItems = {
            {item = 'coke_pooch', label = 'Abgepacktes Kokain', amount = 100}},
        newitem = {sqlitem = 'coke_brick', label = 'Kokain Paket'},
        newitemamount = 1,
        craftAmount = 1
    },

    {
        id = 6,
        reqXP = 0,
        giveXP = {type = 'packing', a = 100, b = 200},
        reqItems = {
            {item = 'xtc', label = 'Extacy', amount = 100}},
        newitem = {sqlitem = 'xtc_brick', label = 'Extacy Paket'},
        newitemamount = 1,
        craftAmount = 1
    },

    {
        id = 6,
        reqXP = 0,
        giveXP = {type = 'packing', a = 100, b = 200},
        reqItems = {
            {item = 'lsd', label = 'LSD', amount = 100}},
        newitem = {sqlitem = 'lsd_brick', label = 'LSD Paket'},
        newitemamount = 1,
        craftAmount = 1
    },

    {
        id = 6,
        reqXP = 0,
        giveXP = {type = 'packing', a = 100, b = 200},
        reqItems = {
            {item = 'magicshroom', label = 'Magic Mushroom', amount = 100}},
        newitem = {sqlitem = 'shroom_brick', label = 'Shroom Paket'},
        newitemamount = 1,
        craftAmount = 1
    },

    {
        id = 6,
        reqXP = 0,
        giveXP = {type = 'packing', a = 100, b = 200},
        reqItems = {
            {item = 'kroko', label = 'Krokodil', amount = 100}},
        newitem = {sqlitem = 'kroko_brick', label = 'Krokodil Paket'},
        newitemamount = 1,
        craftAmount = 1
    },



}


Config.SellItems = {

    {category = 'Chemische Drogen', content = {
        {sqlitem = 'xtc', label = 'Extacy', priceBuy = 50.0},
        {sqlitem = 'kroko', label = 'Krokodil', priceBuy = 240.0},
    }},
    {category = 'Natürliche Drogen', content = {
        {sqlitem = 'magicshroom', label = 'Magic Shroom', priceBuy = 35.0},
        {sqlitem = 'lsd', label = 'LSD', priceBuy = 70.0},
    }},
    {category = 'Schwarzgebrannter', content = {
        {sqlitem = 'moonshine', label = 'Moonshine', priceBuy = 65.0},
    }},
}

--[[

INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
	('grapperaisin', 'Grapperaisin', 60, 0, 1),
	('weat', 'Weat', 60, 0, 1),
	('apple', 'Apple', 60, 0, 1),
	('tomatos', 'Tomatos', 60, 0, 1),
	('salad', 'Salad', 60, 0, 1),
	('stone', 'Stone', 60, 0, 1),
	('coal', 'Coal', 60, 0, 1),
	('silver', 'Silver', 60, 0, 1),
	('gold', 'Gold', 60, 0, 1),
	('mixedsalad', 'Mixed salad', 60, 0, 1),
	('applejuice', 'Apple juice', 60, 0, 1),
	('tomatojuice', 'Tomato juice', 60, 0, 1),
	('berriesjuice', 'Berries juice', 60, 0, 1),
	('flour', 'Flour', 60, 0, 1),
	('concrete', 'Concrete', 60, 0, 1),
	('coalingot', 'Coal ingot', 60, 0, 1),
	('silveringot', 'Silver ingot', 60, 0, 1),
	('goldingot', 'Gold ingot', 60, 0, 1);
]]

Config.RandomPickAmountOnStart = 5

Config.LocalItems = {
    {id = 1, label = 'Weed Lieferung', 
    price = 50000,
    requires = {
        {item = 'weed_brick', label = 'Weed Paket', amount = 1},
    }, 
    destination = {x = 2482.5847167969, y = 3722.2109375, z = 43.92163848877},
    state = 0,
    recommendJob = nil},

    {id = 2, label = 'Meth Lieferung', 
    price = 65000,
    requires = {
        {item = 'meth_brick', label = 'Meth Paket', amount = 1},
    }, 
    destination = {x = 1592.8076171875, y = 3597.6745605469, z = 35.479736328125},
    state = 0,
    recommendJob = nil},

    {id = 3, label = 'Kokain Lieferung', 
    price = 75000,
    requires = {
        {item = 'coke_brick', label = 'Kokain Paket', amount = 1},
    }, 
    destination = {x = -1889.0581054688, y = 2050.7204589844, z = 140.98512268066},
    state = 0,
    recommendJob = nil},

    {id = 4, label = 'Extacy Lieferung', 
    price = 8000,
    requires = {
        {item = 'xtc_brick', label = 'Extacy Paket', amount = 1},
    }, 
    destination = {x = 126.75342559814, y = -1282.6983642578, z = 29.277154922485},
    state = 0,
    recommendJob = nil},

    {id = 5, label = 'LSD Lieferung', 
    price = 10000,
    requires = {
        {item = 'lsd_brick', label = 'LSD Paket', amount = 1},
    }, 
    destination = {x = 2338.0930175781, y = 2570.7575683594, z = 47.723930358887},
    state = 0,
    recommendJob = nil},

    {id = 6, label = 'Krokodil Lieferung', 
    price = 16000,
    requires = {
        {item = 'kroko_brick', label = 'Krokodil Paket', amount = 1},
    }, 
    destination = {x = -20.888982772827, y = 3030.1721191406, z = 41.686408996582},
    state = 0,
    recommendJob = nil},

    {id = 7, label = 'Mushroom Lieferung', 
    price = 5000,
    requires = {
        {item = 'shroom_brick', label = 'Shroom Paket', amount = 1},
    }, 
    destination = {x = -1111.2973632812, y = 4937.5224609375, z = 218.38349914551},
    state = 0,
    recommendJob = nil},

    {id = 8, label = 'Weed Export', 
    price = 55000,
    requires = {
        {item = 'weed_brick', label = 'Weed Paket', amount = 1},
    }, 
    destination = {x = 3807.916015625, y = 4478.6435546875, z = 6.3653903007507},
    state = 0,
    recommendJob = nil},

    {id = 9, label = 'Meth Export', 
    price = 70000,
    requires = {
        {item = 'meth_brick', label = 'Meth Paket', amount = 1},
    }, 
    destination = {x = 3807.916015625, y = 4478.6435546875, z = 6.3653903007507},
    state = 0,
    recommendJob = nil},

    {id = 10, label = 'Kokain Export', 
    price = 85000,
    requires = {
        {item = 'coke_brick', label = 'Kokain Paket', amount = 1},
    }, 
    destination = {x = 3807.916015625, y = 4478.6435546875, z = 6.3653903007507},
    state = 0,
    recommendJob = nil},

    {id = 11, label = 'Extacy Export', 
    price = 10000,
    requires = {
        {item = 'xtc_brick', label = 'Extacy Paket', amount = 1},
    }, 
    destination = {x = 3807.916015625, y = 4478.6435546875, z = 6.3653903007507},
    state = 0,
    recommendJob = nil},

    {id = 12, label = 'LSD Export', 
    price = 15000,
    requires = {
        {item = 'lsd_brick', label = 'LSD Paket', amount = 1},
    }, 
    destination = {x = 3807.916015625, y = 4478.6435546875, z = 6.3653903007507},
    state = 0,
    recommendJob = nil},

    {id = 13, label = 'Krokodil Export', 
    price = 20000,
    requires = {
        {item = 'kroko_brick', label = 'Krokodil Paket', amount = 1},
    }, 
    destination = {x = 3807.916015625, y = 4478.6435546875, z = 6.3653903007507},
    state = 0,
    recommendJob = nil},

    {id = 14, label = 'Mushroom Export', 
    price = 8000,
    requires = {
        {item = 'shroom_brick', label = 'Shroom Paket', amount = 1},
    }, 
    destination = {x = 3807.916015625, y = 4478.6435546875, z = 6.3653903007507},
    state = 0,
    recommendJob = nil},

    
}




Translation = {
    ['de'] = {
        ['enter_farming'] = 'Du betrittst nun ein ~g~',
        ['enter_farming2'] = ' Sammelgebiet~s~. Drücke ~g~[E]~s~, um mit dem Sammeln zu beginnen.',
        ['pre_collect'] = '',
        ['collect'] = ' sammeln',
        ['info_production'] = 'Drücke ~INPUT_CONTEXT~ um Waren zu verarbeiten',
        ['info_sell'] = 'Drücke ~INPUT_CONTEXT~ um Waren zu verkaufen',
        ['info_available_missions'] = '~b~Verfügbare Aufträge',
        ['info_current_mission'] = 'Aktueller Auftrag:',
        ['info_destination'] = 'Zielort:',
        ['info_reward'] = 'Lohn bei Abgabe:',
        ['info_reqItems'] = '~HUD_COLOUR_NET_PLAYER21~BENÖTIGTE PRODUKTE:',
        ['info_abort'] = '~r~Auftrag abbrechen',
        ['info_abort_confirm'] = '~g~Der Auftrag wurde zurückgegeben und kann nun von jemand anderem bearbeitet werden.',
        ['prefix_in_processing'] = '~HUD_COLOUR_HB_YELLOW~IN BEARBEITUNG: ~s~',
        ['prefix_special'] = '~p~SPEZIAL: ~s~',
        ['prefix_in_processing_desc'] = 'Dieser Auftrag wird gerade von einer anderen Person bearbeitet.',
        ['prefix_special_desc'] = 'Dieser Job sollte von Mitarbeitern des ~p~',
        ['prefix_special_desc2'] = '~s~ erledigt werden.',
        ['info_case'] = 'Auftrag:',
        ['info_recommendJob'] = '~r~! ~s~Empfohlener Job:',
        ['info_recommendJob_desc'] = 'Dieser Auftrag beinhaltet Produkte, die nicht jeder herstellen kann.',
        ['info_accept'] = '~g~Auftrag annehmen',
        ['info_accept_desc'] = 'Wenn du alle Produkte hast, liefere diese nun aus.',
        ['sell'] = 'Verkaufen',
        ['sell_desc'] = 'Wähle aus wie viel du verkaufen möchtest?',
        ['input_howmuch'] = 'Wie viel soll verkauft werden?',
        ['xp'] = ' Erfahrungspunkte',
        ['pre_craft'] = '',
        ['craft'] = ' herstellen',
        ['required'] = 'Benötigt ',
        ['start_craft'] = 'Gegenstände verarbeiten',
        ['not_enough_xp'] = 'Du hast nicht genügend Erfahrung! ~y~',
        ['not_enough_xp_required'] = ' Erfahrung benötigt.',
        ['notify_out_of_range'] = '~r~Du darfst den Umkreis des Verarbeiters ~w~5m ~r~nicht verlassen.',
        ['notify_aborted'] = 'Abgebrochen!',
        ['mission_started'] = '~g~Auftrag ~w~',
        ['mission_started2'] = ' ~g~angenommen. Gebe die Produkte am ~p~markierten Punkt ~g~ab.',
        ['collected'] = 'gesammelt',
        ['not_enough_items'] = '~r~Nicht genügend ~w~',
        ['craftting_finished'] = '~g~Herstellung von ~w~',
        ['craftting_finished2'] = ' ~g~abgeschlossen!',
        ['items_sold_for'] = '~s~Gegenstände verkauft für ~g~',
        ['you_only_have_items'] = '~y~Das hast nur ~w~',
        ['you_only_have_items2'] = 'x ~y~dabei',
        ['mission_in_process'] = '~y~Der Auftrag wird gerade von einer anderen Person bearbeitet.',
        ['mission_not_available'] = '~r~Dieser Auftrag ist nicht mehr verfügbar.',
        ['mission_success'] = '~g~Auftrag ~w~',
        ['mission_success2'] = ' ~g~abgeschlossen! Du hast ~w~',
        ['mission_success3'] = '$ ~g~erhalten.',
        ['too_heavy'] = '~r~Du kannst nicht so viel tragen.',
    },
    ['en'] = {
        ['enter_farming'] = 'You have entered ~g~',
        ['enter_farming2'] = ' farming zone~s~. Press ~g~E~s~, to start collecting.',
        ['pre_collect'] = 'Collect ',
        ['collect'] = '',
        ['info_production'] = 'Press ~g~E~s~, manufacture items',
        ['info_sell'] = 'Press ~g~E~s~, to sell items',
        ['info_available_missions'] = '~b~Available jobs',
        ['info_current_mission'] = 'Current job:',
        ['info_destination'] = 'Destination:',
        ['info_reward'] = 'Payment upon delivery:',
        ['info_reqItems'] = '~HUD_COLOUR_NET_PLAYER21~REQUIRED ITEMS:',
        ['info_abort'] = '~r~Abort job',
        ['info_abort_confirm'] = '~g~Your job was aborted, and is now available again.',
        ['prefix_in_processing'] = '~HUD_COLOUR_HB_YELLOW~IN PROCESSING: ~s~',
        ['prefix_special'] = '~p~SPECIAL: ~s~',
        ['prefix_in_processing_desc'] = 'This job is currently being processed by another person.',
        ['prefix_special_desc'] = 'This job should be done by employees of ~p~',
        ['prefix_special_desc2'] = '~s~.',
        ['info_case'] = 'Job:',
        ['info_recommendJob'] = '~r~! ~s~Recommend Job:',
        ['info_recommendJob_desc'] = 'This job required products that not everyone can manufacture.',
        ['info_accept'] = '~g~Do this job',
        ['info_accept_desc'] = 'When you have all the products, deliver them now.',
        ['sell'] = 'Sell',
        ['sell_desc'] = 'Decide how much do you want to sell?',
        ['input_howmuch'] = 'How much should be sold?',
        ['xp'] = ' Experience',
        ['pre_craft'] = 'Craft ',
        ['craft'] = ' ',
        ['required'] = 'Requires ',
        ['start_craft'] = 'Manufacturing',
        ['not_enough_xp'] = 'You do not have enough experience! ~y~',
        ['not_enough_xp_required'] = ' Experience required.',
        ['notify_out_of_range'] = '~r~You can not leave the range ~w~5m ~r~while manufacuring.',
        ['notify_aborted'] = 'Aborted!',
        ['mission_started'] = '~g~Job ~w~',
        ['mission_started2'] = ' ~g~started. Deliver the items to the~p~marked position~g~.',
        ['collected'] = 'collected',
        ['not_enough_items'] = '~r~Not enough ~w~',
        ['craftting_finished'] = '~g~Manufacturing of ~w~',
        ['craftting_finished2'] = ' ~g~completed!',
        ['items_sold_for'] = '~s~Items sold for ~g~',
        ['you_only_have_items'] = '~y~You only have ~w~',
        ['you_only_have_items2'] = 'x ~y~in your inventory',
        ['mission_in_process'] = '~y~This job is currently done by another person.',
        ['mission_not_available'] = '~r~This job is not available anymore.',
        ['mission_success'] = '~g~Job ~w~',
        ['mission_success2'] = ' ~g~completed! You got ~w~',
        ['mission_success3'] = '$~g~.',
        ['too_heavy'] = '~r~You can not carry that much.',
    }
}