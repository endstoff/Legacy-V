Config = {}
Translation = {}

Config.Locale = 'de'

Config.ShowFarmingBlipText = true

Config.FarmingAreas = { 

    {requiredJob = nil, xptype = nil, blip = {sprite = 420, color = 7, data = nil}, items = {{name = 'grapperaisin', label = 'Trauben'}}, x = -1803.03, y = 2186.55, z = 105.63, range = 110.0, randoma = 1, randomb = 3, collectingTime = 8, animation = "PROP_HUMAN_BUM_BIN"},
    {requiredJob = nil, xptype = nil, blip = {sprite = 420, color = 36, data = nil}, items = {{name = 'weat', label = 'Weizen'}}, x = 2616.83, y = 4451.19, z = 39.06, range = 70.0, randoma = 2, randomb = 6, collectingTime = 11, animation = "PROP_HUMAN_BUM_BIN"},
    {requiredJob = nil, xptype = nil, blip = {sprite = 420, color = 1, data = nil}, items = {{name = 'apple', label = 'Apfel'}}, x = 2371.95, y = 4722.87, z = 33.9, range = 30.0, randoma = 1, randomb = 3, collectingTime = 10, animation = "PROP_HUMAN_BUM_BIN"}, -- or orange
    {requiredJob = nil, xptype = nil, blip = {sprite = 420, color = 50, data = nil}, items = {{name = 'tomatos', label = 'Tomaten'}}, x = 2286.97, y = 4763.68, z = 38.61, range = 10.0, randoma = 1, randomb = 3, collectingTime = 8, animation = "PROP_HUMAN_BUM_BIN"},
    {requiredJob = nil, xptype = nil, blip = {sprite = 420, color = 69, data = nil}, items = {{name = 'salad', label = 'Salat'}}, x = 3288.39, y = 5181.42, z = 18.56, range = 8.0, randoma = 1, randomb = 3, collectingTime = 8, animation = "PROP_HUMAN_BUM_BIN"},
    {requiredJob = nil, xptype = nil, blip = {sprite = 420, color = 16, data = nil}, items = {{name = 'potato', label = 'Kartoffel'}}, x = 274.30947875977, y = 6610.6538085938, z = 30.007946014404, range = 8.0, randoma = 1, randomb = 3, collectingTime = 8, animation = "PROP_HUMAN_BUM_BIN"},
    {requiredJob = nil, xptype = nil, blip = {sprite = 420, color = 16, data = nil}, items = {{name = 'bolcacahuetes', label = 'Erdnuss'}}, x = -1818.7586669922, y = 1980.1359863281, z = 131.1247253418, range = 10.0, randoma = 1, randomb = 3, collectingTime = 8, animation = "PROP_HUMAN_BUM_BIN"},
    {requiredJob = nil, xptype = nil, blip = {sprite = 420, color = 20, data = nil}, items = {{name = 'stone', label = 'Stein', percentage = 70}, {name = 'coal', label = 'Kohle', percentage = 82}, {name = 'silver', label = 'Silber', percentage = 94}, {name = 'gold', label = 'Gold', percentage = 100}}, x = 1312.0114746094, y = 3005.9616699219, z = 53.944561004639, range = 38.0, randoma = 1, randomb = 2, collectingTime = 10, animation = "WORLD_HUMAN_HAMMERING"},
    {requiredJob = nil, xptype = nil, blip = {sprite = 420, color = 20, data = nil}, items = {{name = 'ironore', label = 'Eisenerz', percentage = 70}, {name = 'bauxit', label = 'Bauxit', percentage = 80}, {name = 'coal', label = 'Kohle', percentage = 90}}, x = 2940.1330566406, y = 2789.3664550781, z = 40.122993469238, range = 50.0, randoma = 4, randomb = 8, collectingTime = 30, animation = "WORLD_HUMAN_CONST_DRILL"},
}

Config.CraftTime = 4 -- in sek
Config.CraftBlipIcon = 728
Config.CraftBlipColour = 2

Config.Processor = {
    {requiredJob = nil, ItemsId = 1, label = 'Saftpresser', XPType = 'juice', ped = "s_m_m_migrant_01", x = 2741.59, y = 4412.76, z = 48.62, rot = 190.0},
    {requiredJob = nil, ItemsId = 2, label = 'Bäckerei', XPType = 'bakery', ped = "s_m_m_strvend_01", x = -302.42, y = 6211.69, z = 31.42, rot = 0.0},
    {requiredJob = nil, ItemsId = 6, label = 'Salat Manufaktur', XPType = 'salad', ped = "a_m_m_farmer_01", x = -1693.92, y = -1085.12, z = 13.15, rot = 130.0},
    {requiredJob = nil, ItemsId = 7, label = 'Schmelze', XPType = 'stone', ped = "ig_chef2", x = 1078.8861083984, y = -1979.7579345703, z = 31.471523284912, rot = 238.72868347168},
    {requiredJob = nil, ItemsId = 8, label = 'Juwelier', XPType = 'jewellery', ped = "u_f_y_jewelass_01", x = -622.05590820313, y = -232.09861755371, z = 38.057010650635, rot = 126.61913299561},
    {requiredJob = nil, ItemsId = 9, label = 'Vodka Manufaktur', XPType = 'potato', ped = "a_m_m_farmer_01", x = 1459.3967285156, y = -1930.6866455078, z = 71.804565429688, rot = 268.56},
    {requiredJob = nil, ItemsId = 10, label = 'Schlosserei', XPType = 'smith', ped = "ig_chef2", x = 944.125, y = -1697.728515625, z = 30.090450286865, rot = 269.33},
}

Config.Seller = {
    {requiredJob = nil, isExport = true, label = 'Hafen von Los Santos', priceModifier = 2.0, x = -332.6, y = -2792.68, z = 5.0, rot = 90.0},
    {requiredJob = nil, isExport = true, label = 'JetSam Terminal', priceModifier = 2.0, x = 797.01, y = -2988.83, z = 6.02, rot = 90.0},
    {requiredJob = nil, isExport = false, label = 'Belieferungs jobs', priceModifier = 2.0, x = -1283.37, y = -565.02, z = 31.71, rot = 310.0},
}


Config.useIntegratedWeightSystem = false
Config.useESXWeightSystem = true -- disable Config.useIntegratedWeightSystem when you want to use this

Config.MaxCarry = 3500

Config.ItemLimits = {

    ['grapperaisin'] = 60,
    ['weat'] = 25,
    ['apple'] = 60,
    ['tomatos'] = 60,
    ['salad'] = 60,
    ['stone'] = 70,
    ['coal'] = 70,
    ['silver'] = 70,
    ['gold'] = 70,
    ['potato'] = 40,
    ['ironore'] = 70,
    ['bauxit'] = 70,
	
    ['flour'] = 20,
    ['applejuice'] = 50,
    ['tomatojuice'] = 50,
    ['orangejuice'] = 50,
    ['berriesjuice'] = 50,
    ['mixedsalad'] = 50,
    ['vodka'] = 60,
	
	['concrete'] = 70,
	['coalingot'] = 60,
	['silveringot'] = 60,
	['goldingot'] = 60,
	
	['ironbraclet'] = 50,
	['goldrings'] = 50,
	['necklace'] = 50,

    ['ironingot'] = 60,
    ['aluminium'] = 60,
    ['steel'] = 60,

}


Config.Items = {

    {
        id = 1,
        reqXP = 0,
        giveXP = {type = 'juice', a = 1, b = 3},
        reqItems = {
            {item = 'apple', label = 'Apfel', amount = 3}},
        newitem = {sqlitem = 'applejuice', label = 'Apfelsaft'},
        newitemamount = 1,
        craftAmount = 10
    },
    {
        id = 1,
        reqXP = 1000,
        giveXP = {type = 'juice', a = 1, b = 3},
        reqItems = {
            {item = 'tomatos', label = 'Tomaten', amount = 3}},
        newitem = {sqlitem = 'tomatojuice', label = 'Tomatensaft'},
        newitemamount = 1,
        craftAmount = 10
    },
    {
        id = 1,
        reqXP = 3000,
        giveXP = {type = 'juice', a = 1, b = 3},
        reqItems = {
            {item = 'grapperaisin', label = 'Trauben', amount = 2}},
        newitem = {sqlitem = 'berriesjuice', label = 'Beerensaft'},
        newitemamount = 1,
        craftAmount = 10
    },
    {
        id = 2,
        reqXP = 0,
        giveXP = {type = 'bakery', a = 1, b = 3},
        reqItems = {
            {item = 'weat', label = 'Weizen', amount = 3}},
        newitem = {sqlitem = 'flour', label = 'Mehl'},
        newitemamount = 1,
        craftAmount = 10
    },
    {
        id = 6,
        reqXP = 0,
        giveXP = {type = 'salad', a = 1, b = 3},
        reqItems = {
            {item = 'salad', label = 'Salat', amount = 1},
            {item = 'tomatos', label = 'Tomaten', amount = 1}},
        newitem = {sqlitem = 'mixedsalad', label = 'Gemischter Salat'},
        newitemamount = 1,
        craftAmount = 10
    },
    {
        id = 7,
        reqXP = 0,
        giveXP = {type = 'stone', a = 2, b = 4},
        reqItems = {
            {item = 'stone', label = 'Stein', amount = 4}},
        newitem = {sqlitem = 'concrete', label = 'Beton'},
        newitemamount = 1,
        craftAmount = 10
    },
    {
        id = 7,
        reqXP = 1000,
        giveXP = {type = 'stone', a = 2, b = 4},
        reqItems = {
            {item = 'coal', label = 'Kohle', amount = 3}},
        newitem = {sqlitem = 'coalingot', label = 'Kohle Brikett'},
        newitemamount = 1,
        craftAmount = 10
    },
    {
        id = 7,
        reqXP = 1500,
        giveXP = {type = 'stone', a = 2, b = 4},
        reqItems = {
            {item = 'ironore', label = 'Eisenerz', amount = 2},
            {item = 'coalingot', label = 'Kohle Brikett', amount = 1}},
        newitem = {sqlitem = 'ironingot', label = 'Eisenbarren'},
        newitemamount = 1,
        craftAmount = 10
    },
    {
        id = 7,
        reqXP = 2000,
        giveXP = {type = 'stone', a = 2, b = 4},
        reqItems = {
            {item = 'bauxit', label = 'Bauxit', amount = 2}},
        newitem = {sqlitem = 'aluminium', label = 'Aluminium'},
        newitemamount = 1,
        craftAmount = 10
    },
    {
        id = 7,
        reqXP = 2000,
        giveXP = {type = 'stone', a = 2, b = 4},
        reqItems = {
            {item = 'ironingot', label = 'Eisenbarren', amount = 1},
            {item = 'coalingot', label = 'Kohle Brikett', amount = 1}},
        newitem = {sqlitem = 'steel', label = 'Stahl'},
        newitemamount = 1,
        craftAmount = 10
    },
    {
        id = 7,
        reqXP = 3000,
        giveXP = {type = 'stone', a = 2, b = 4},
        reqItems = {
            {item = 'silver', label = 'Silber', amount = 3}},
        newitem = {sqlitem = 'silveringot', label = 'Silberbarren'},
        newitemamount = 1,
        craftAmount = 10
    },
    {
        id = 7,
        reqXP = 3500,
        giveXP = {type = 'stone', a = 2, b = 4},
        reqItems = {
            {item = 'gold', label = 'Gold', amount = 4}},
        newitem = {sqlitem = 'goldingot', label = 'Goldbarren'},
        newitemamount = 1,
        craftAmount = 10
    },
    {
        id = 8,
        reqXP = 0,
        giveXP = {type = 'jewellery', a = 2, b = 4},
        reqItems = {
            {item = 'coalingot', label = 'Kohle Brikett', amount = 2},
            {item = 'silveringot', label = 'Silberbarren', amount = 1}},
        newitem = {sqlitem = 'ironbraclet', label = 'Silberarmband'},
        newitemamount = 1,
        craftAmount = 10
    },
    {
        id = 8,
        reqXP = 3500,
        giveXP = {type = 'jewellery', a = 2, b = 4},
        reqItems = {
            {item = 'goldingot', label = 'Goldbarren', amount = 2}},
        newitem = {sqlitem = 'goldrings', label = 'Goldring'},
        newitemamount = 1,
        craftAmount = 10
    },
    {
        id = 8,
        reqXP = 5000,
        giveXP = {type = 'jewellery', a = 2, b = 4},
        reqItems = {
            {item = 'goldingot', label = 'Goldbarren', amount = 2},
            {item = 'silveringot', label = 'Silberbarren', amount = 2}},
        newitem = {sqlitem = 'necklace', label = 'Halskette'},
        newitemamount = 1,
        craftAmount = 10
    },
    {
        id = 9,
        reqXP = 0,
        giveXP = {type = 'potato', a = 3, b = 4},
        reqItems = {
            {item = 'potato', label = 'Kartoffel', amount = 2}},
        newitem = {sqlitem = 'vodka', label = 'Vodka'},
        newitemamount = 1,
        craftAmount = 10
    },
    {
        id = 9,
        reqXP = 500,
        giveXP = {type = 'potato', a = 3, b = 4},
        reqItems = {
            {item = 'vodka', label = 'Vodka', amount = 2},
            {item = 'grapperaisin', label = 'Traube', amount = 4}},
        newitem = {sqlitem = 'vodkafruit', label = 'Frucht Wodka'},
        newitemamount = 1,
        craftAmount = 10
    },
    {
        id = 9,
        reqXP = 1000,
        giveXP = {type = 'potato', a = 3, b = 4},
        reqItems = {
            {item = 'vodka', label = 'Vodka', amount = 2},
            {item = 'bolcacahuetes', label = 'Erdnuss', amount = 4}},
        newitem = {sqlitem = 'vodkapeanut', label = 'Nuss Nougat Wodka'},
        newitemamount = 1,
        craftAmount = 10
    },
    {
        id = 10,
        reqXP = 0,
        giveXP = {type = 'smith', a = 3, b = 4},
        reqItems = {
            {item = 'ironingot', label = 'Eisenbarren', amount = 1},},
        newitem = {sqlitem = 'screws', label = 'Schrauben'},
        newitemamount = 1,
        craftAmount = 10
    },
    {
        id = 10,
        reqXP = 250,
        giveXP = {type = 'smith', a = 3, b = 4},
        reqItems = {
            {item = 'ironingot', label = 'Eisenbarren', amount = 1},
            {item = 'aluminium', label = 'Aluminium', amount = 1},},
        newitem = {sqlitem = 'spring', label = 'Feder'},
        newitemamount = 1,
        craftAmount = 10
    },
    {
        id = 10,
        reqXP = 500,
        giveXP = {type = 'smith', a = 3, b = 4},
        reqItems = {
            {item = 'steel', label = 'Stahl', amount = 1},},
        newitem = {sqlitem = 'bolt', label = 'Bolzen'},
        newitemamount = 1,
        craftAmount = 10
    },

}


Config.SellItems = {

    {category = 'Rohmaterial', content = {
        {sqlitem = 'grapperaisin', label = 'Traube', priceBuy = 2.0},
        {sqlitem = 'weat', label = 'Weizen', priceBuy = 1.0},
        {sqlitem = 'apple', label = 'Apfel', priceBuy = 1.0},
        {sqlitem = 'tomatos', label = 'Tomaten', priceBuy = 2.0},
        {sqlitem = 'salad', label = 'Salat', priceBuy = 2.0},
        {sqlitem = 'potato', label = 'Kartoffel', priceBuy = 1.0},
        {sqlitem = 'bolcacahuetes', label = 'Erdnuss', priceBuy = 3.0},
        {sqlitem = 'stone', label = 'Stein', priceBuy = 2.0},
        {sqlitem = 'coal', label = 'Kohle', priceBuy = 10.0},
        {sqlitem = 'silver', label = 'Silber', priceBuy = 24.0},
        {sqlitem = 'gold', label = 'Gold', priceBuy = 40.0},
    }},
    {category = 'Salate', content = {
        {sqlitem = 'mixedsalad', label = 'Gemischter Salat', priceBuy = 20.0},
    }},
    {category = 'Säfte', content = {
        {sqlitem = 'applejuice', label = 'Apfelsaft', priceBuy = 10.0},
        {sqlitem = 'tomatojuice', label = 'Tomatensaft', priceBuy = 15.0},
        {sqlitem = 'berriesjuice', label = 'Beerensaft', priceBuy = 20.0},
    }},
    {category = 'Bäckerei', content = {
        {sqlitem = 'flour', label = 'Mehl', priceBuy = 4.0},
    }},
    {category = 'Schmelzen', content = {
        {sqlitem = 'concrete', label = 'Beton', priceBuy = 13.0},
        {sqlitem = 'coalingot', label = 'Kohlebrikett', priceBuy = 45.0},
        {sqlitem = 'silveringot', label = 'Silberbarren', priceBuy = 90.0},
        {sqlitem = 'goldingot', label = 'Goldbarren', priceBuy = 180.0},
    }},
    {category = 'Juwelen', content = { 
        {sqlitem = 'ironbraclet', label = 'Silberarmband', priceBuy = 300.0},
        {sqlitem = 'goldrings', label = 'Goldring', priceBuy = 550.0},
        {sqlitem = 'necklace', label = 'Halskette', priceBuy = 800.0},
    }},
    {category = 'Wodka Manufaktur', content = {
        {sqlitem = 'vodka', label = 'Wodka', priceBuy = 10.0},
        {sqlitem = 'vodkafruit', label = 'Frucht Wodka', priceBuy = 35.0},
        {sqlitem = 'vodkapeanut', label = 'Nuss Nougat Wodka', priceBuy = 45.0},
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

Config.RandomPickAmountOnStart = 7

Config.LocalItems = {
    {id = 1, label = 'Panic Catering', 
    price = 155,
    requires = {
        {item = 'flour', label = 'Mehl', amount = 6},
        {item = 'apple', label = 'Äpfel', amount = 8},
    }, 
    destination = {x = -278.05, y = -2037.44, z = 30.15},
    state = 0,
    recommendJob = nil},

    {id = 2, label = 'Richman Breakfast', 
    price = 116, 
    requires = {
        {item = 'mixedsalad', label = 'Gemischter Salat', amount = 3},
    }, 
    destination = {x = -1274.4, y = 314.91, z = 65.51},
    state = 0,
    recommendJob = nil},

    {id = 3, label = 'Richman Happy Hour', 
    price = 685, 
    requires = {
        {item = 'bolcacahuetes', label = 'Peanuts', amount = 20},
        {item = 'vodkapeanut', label = 'Nuss Nougat Wodka', amount = 10},
        {item = 'vodkafruit', label = 'Frucht Wodka', amount = 10},
    }, 
    destination = {x = -1274.4, y = 314.91, z = 65.51},
    state = 0,
    recommendJob = nil},

    {id = 4, label = 'Shark Bites Beach', 
    price = 465, 
    requires = {
        {item = 'applejuice', label = 'Apfelsaft', amount = 8},
        {item = 'berriesjuice', label = 'Beerensaft', amount = 8},
    }, 
    destination = {x = -1298.01, y = -1387.61, z = 4.54},
    state = 0,
    recommendJob = nil},

    {id = 5, label = 'Airport Bilgeco', 
    price = 1125, 
    requires = {
        {item = 'tomatojuice', label = 'Tomatensaft', amount = 40},
    }, 
    destination = {x = -874.55, y = -2735.07, z = 13.9},
    state = 0,
    recommendJob = nil},

    {id = 6, label = 'Crastenburg Breakfast', 
    price = 506, 
    requires = {
        {item = 'tomatos', label = 'Tomaten', amount = 20},
        {item = 'mixedsalad', label = 'Gemischter Salat', amount = 10},
    }, 
    destination = {x= -1858.72, y= -348.64, z = 49.84},
    state = 0,
    recommendJob = nil},

    {id = 7, label = 'Construction', 
    price = 300, 
    requires = {
        {item = 'concrete', label = 'Beton', amount = 12},
    }, 
    destination = {x = -585.78631591797, y = -286.04611206055, z = 35.454780578613},
    state = 0,
    recommendJob = nil},

    {id = 8, label = 'Construction II', 
    price = 500, 
    requires = {
        {item = 'concrete', label = 'Beton', amount = 25},
    }, 
    destination = {x = -939.75567626953, y = 160.41754150391, z = 65.983016967773},
    state = 0,
    recommendJob = nil},

    {id = 9, label = 'Construction III', 
    price = 2000, 
    requires = {
        {item = 'concrete', label = 'Beton', amount = 100},
    }, 
    destination = {x = -97.227279663086, y = -1013.9320068359, z = 27.275217056274},
    state = 0,
    recommendJob = nil},

    {id = 10, label = 'Construction IV', 
    price = 2200, 
    requires = {
        {item = 'concrete', label = 'Beton', amount = 100},
    }, 
    destination = {x = 907.39514160156, y = -1.5027470588684, z = 78.764083862305},
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