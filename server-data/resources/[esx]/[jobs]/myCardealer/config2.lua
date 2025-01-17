Cfg = {}
Translation = {}

Cfg.Locale = 'de'

Cfg.useOneSyncInfinity = true

Cfg.DeliveryTime = {h = 18, m = 30} -- When should ordered vehicles arrive at the cardealer

Cfg.Society_Name = 'society_cardealer'
Cfg.society = 'cardealer' -- = Job MySQLName
Cfg.Society = 'cardealer'
Cfg.NotificationPicture = 'CHAR_CARSITE2'
Cfg.CompanyName = 'Sunrise Autos'
Cfg.GaragePed = 's_m_y_xmech_01'

Cfg.NumberPlate = 'SUNRISE'

-- Purchased Vehicle Number plate settings:
-- looks like: 'LLL NNN'
-- The maximum plate length is 8 chars (including spaces & symbols), don't go past it!
Cfg.PlateLetters  = 3
Cfg.PlateNumbers  = 3
Cfg.PlateUseSpace = true

-- Luxury Cars Dealer Coords for Uncle Justs Car Dealer
--[[
Cfg.Coords = {

    cam = {
        pos = { x = -788.49, y = -227.87, z = 39.08},
        point = {x = -783.58, y = -223.5, z = 37.32},
    },
    cam2 = {
        pos = { x = -798.49, y = -228.87, z = 39.08},
        point = {x = -794.44, y = -231.46, z = 37.08},
    },
    cam3 = {
        pos = { x = -794.49, y = -234.87, z = 39.08},
        point = {x = -791.41, y = -237.7, z = 37.08},
    },
    cam4 = {
        pos = { x = -791.49, y = -239.87, z = 39.08},
        point = {x = -788.41, y = -242.7, z = 37.08},
    },


    Clothe = {
      {x = -804.79, y = -213.25, z = 37.08}
    },
  
    Boss = {
      {x = -788.96, y = -216.46, z = 37.08}
    },
  
    Garage = {
      {x = -767.76, y = -230.14, z = 37.08, rot = 121.02, spawn = {x = -773.2, y = -234.42, z = 37.08, rot = 205.50}}
    },
  
    DeSpawn = {
      {x = -768.27, y = -232.08, z = 37.08}
    },
  
    OnOffDuty = {
      {x = -800.69, y = -210.22, z = 37.08}
    },
  
    Ring = {
      {x = -795.9, y = -219.51, z = 37.08}
    },

    Computer = {
        {x = -793.87, y = -219.68, z = 37.08, spawn = {x = -773.2, y = -234.42, z = 37.08, rot = 205.50}}
    },
    
    Showrooms = {
        {
            spawn = {x = -783.58, y = -223.5, z = 37.32, rot = 139.81}, 
            menu = {x = -786.25, y = -229.35, z = 37.08},
            ChangeColor = false,
            spawn2 = {x = -773.2, y = -234.42, z = 37.08, rot = 205.50}
        },
        {
            spawn = {x = -788.41, y = -242.7, z = 37.08, rot = 78.96}, 
            menu = {x = -789.57, y = -244.25, z = 37.08},
            ChangeColor = true,
            spawn2 = {x = -773.2, y = -234.42, z = 37.08, rot = 205.50}
        },
        {
            spawn = {x = -791.41, y = -237.7, z = 37.08, rot = 78.96}, 
            menu = {x = -792.57, y = -239.67, z = 37.08},
            ChangeColor = false,
            spawn2 = {x = -773.2, y = -234.42, z = 37.08, rot = 205.50}
        },
        {
            spawn = {x = -794.44, y = -231.46, z = 37.08, rot = 78.96}, 
            menu = {x = -795.1, y = -234.76, z = 37.08},
            ChangeColor = false,
            spawn2 = {x = -773.2, y = -234.42, z = 37.08, rot = 205.50}
        },
    }
}
]]


Cfg.Coords = {

  Clothe = {
    {x = -50.83, y = 76.76, z = 71.94}
  },

  Boss = {
    {x = -810.14489746094, y = -207.44648742676, z = 37.121074676514} 
  },

  Garage = {
    {x = -786.51373291016, y = -191.76522827148, z = 37.283782958984, rot = 308.87, spawn = {x = -789.14660644531, y = -196.22933959961, z = 37.283782958984, rot = 303.97}} 
  },

  DeSpawn = {
    {x = -787.36297607422, y = -199.1244354248, z = 36.826034545898} 
  },

  Ring = {
    {x = -783.32495117188, y = -212.87126159668, z = 37.152744293213}  
  },

  Computer = {
    {x = -781.81384277344, y = -211.48516845703, z = 37.152751922607, spawn = {x = -787.43176269531, y = -206.78823852539, z = 37.209365844727, rot = 117.88}} 
  },
  
  Showrooms = {
      {
          spawn = {x = -786.25329589844, y = -244.80439758301, z = 37.169822692871, rot = 80.84}, 
          menu = {x = -789.12976074219, y = -244.35852050781, z = 37.167972564697}, 
          ChangeColor = true,
          spawn2 = {x = -773.30108642578, y = -234.47857666016, z = 37.147617340088, rot = 202.61} 
      },
      {
          spawn = {x = -789.80316162109, y = -237.85621643066, z = 37.163692474365, rot = 80.84}, 
          menu = {x = -792.90197753906, y = -237.45428466797, z = 37.161319732666}, 
          ChangeColor = true,
          spawn2 = {x = -773.30108642578, y = -234.47857666016, z = 37.147617340088, rot = 202.61}
      },
      {
          spawn = {x = -803.90228271484, y = -214.78915405273, z = 37.152030944824, rot = 208.22}, 
          menu = {x = -797.05560302734, y = -229.8675994873, z = 37.153968811035},
          ChangeColor = true,
          spawn2 = {x = -773.30108642578, y = -234.47857666016, z = 37.147617340088, rot = 202.61}
      },
      {
          spawn = {x = -794.45233154297, y = -231.09515380859, z = 37.156711578369, rot = 176.11}, 
          menu = {x = -804.05035400391, y = -217.88031005859, z = 37.151592254639},
          ChangeColor = true,
          spawn2 = {x = -773.30108642578, y = -234.47857666016, z = 37.147617340088, rot = 202.61}
      },
  }
}

Cfg.Marker = {
    id          = 27,
    colour      = {r = 0, g = 0, b = 128, a = 125},
    isRotating  = false,
    radius      = 1.0,
}

Cfg.Grades = {
    {number = 0, label = 'Trainee'},
    {number = 1, label = 'Seller'},
    {number = 2, label = 'Business Seller'},
    {number = 3, label = 'Boss'},
}

Cfg.MapBlip = {
    {
        Pos     	= {x = -791.77984619141, y = -217.70745849609, z = 37.41431427002},
        Sprite  	= 523,
        Display	    = 4,
        Scale  	    = 0.8,
        Colour  	= 66,
        Name        = 'Sunrise Autos',
        OnlyHasJob  = false
    },
}

Cfg.Clothes = {
    {
        name = 'Boss',
        grade = 3,
        Male = {
          Mask = {id = 121, id2 = 0},
          Arms = {id = 30, id2 = 0},
          Leg = {id = 25, id2 = 0},
          bag = {id = 0, id2 = 0},
          Shoes = {id = 21, id2 = 0},
          Accessory = {id = 11, id2 = 2},
          Tshirt = {id = 13, id2 = 2},
          Kevlar = {id = 0, id2 = 0},
          Badge = {id = 0, id2 = 0},
          Torso = {id = 60, id2 = 2},
          Watch = {id = 1, id2 = 0},
          Hat = {id = -1, id2 = 0},
          Glass = {id = -1, id2 = 0},
          Ear = {id = -1, id2 = 0}
        },
        Female = {
            Mask = {id = 121, id2 = 0},
            Arms = {id = 20, id2 = 0},
            Leg = {id = 47, id2 = 0},
            bag = {id = 0, id2 = 0},
            Shoes = {id = 29, id2 = 0},
            Accessory = {id = 23, id2 = 0},
            Tshirt = {id = 38, id2 = 2},
            Kevlar = {id = 0, id2 = 0},
            Badge = {id = 0, id2 = 0},
            Torso = {id = 53, id2 = 2},
            Watch = {id = 1, id2 = 0},
            Hat = {id = -1, id2 = 0},
            Glass = {id = -1, id2 = 3},
            Ear = {id = -1, id2 = 2}
        }
    },
    {
        name = 'Trainee',
        grade = 0,
        Male = {
          Mask = {id = 121, id2 = 0},
          Arms = {id = 20, id2 = 0},
          Leg = {id = 25, id2 = 0},
          bag = {id = 0, id2 = 0},
          Shoes = {id = 21, id2 = 0},
          Accessory = {id = 22, id2 = 0},
          Tshirt = {id = 33, id2 = 0},
          Kevlar = {id = 0, id2 = 0},
          Badge = {id = 0, id2 = 0},
          Torso = {id = 31, id2 = 0},
          Watch = {id = 1, id2 = 0},
          Hat = {id = -1, id2 = 0},
          Glass = {id = -1, id2 = 0},
          Ear = {id = -1, id2 = 0}
        },
        Female = {
          Mask = {id = 121, id2 = 0},
          Arms = {id = 20, id2 = 0},
          Leg = {id = 47, id2 = 0},
          bag = {id = 0, id2 = 0},
          Shoes = {id = 29, id2 = 0},
          Accessory = {id = 23, id2 = 0},
          Tshirt = {id = 38, id2 = 2},
          Kevlar = {id = 0, id2 = 0},
          Badge = {id = 0, id2 = 0},
          Torso = {id = 53, id2 = 0},
          Watch = {id = 1, id2 = 0},
          Hat = {id = -1, id2 = 0},
          Glass = {id = -1, id2 = 3},
          Ear = {id = -1, id2 = 2}
        }
    },
    {
        name = 'Business Seller',
        grade = 2,
        Male = {
            Mask = {id = 121, id2 = 0},
            Arms = {id = 20, id2 = 0},
            Leg = {id = 25, id2 = 0},
            bag = {id = 0, id2 = 0},
            Shoes = {id = 21, id2 = 0},
            Accessory = {id = 22, id2 = 0},
            Tshirt = {id = 33, id2 = 0},
            Kevlar = {id = 0, id2 = 0},
            Badge = {id = 0, id2 = 0},
            Torso = {id = 31, id2 = 0},
            Watch = {id = 1, id2 = 0},
            Hat = {id = -1, id2 = 0},
            Glass = {id = -1, id2 = 0},
            Ear = {id = -1, id2 = 0}
          },
        Female = {
            Mask = {id = 121, id2 = 0},
            Arms = {id = 20, id2 = 0},
            Leg = {id = 47, id2 = 0},
            bag = {id = 0, id2 = 0},
            Shoes = {id = 29, id2 = 0},
            Accessory = {id = 23, id2 = 0},
            Tshirt = {id = 38, id2 = 2},
            Kevlar = {id = 0, id2 = 0},
            Badge = {id = 0, id2 = 0},
            Torso = {id = 53, id2 = 1},
            Watch = {id = 1, id2 = 0},
            Hat = {id = -1, id2 = 0},
            Glass = {id = -1, id2 = 3},
            Ear = {id = -1, id2 = 2}
        }
    },
    {
        name = 'Seller',
        grade = 1,
        Male = {
            Mask = {id = 121, id2 = 0},
            Arms = {id = 20, id2 = 0},
            Leg = {id = 25, id2 = 0},
            bag = {id = 0, id2 = 0},
            Shoes = {id = 21, id2 = 0},
            Accessory = {id = 22, id2 = 0},
            Tshirt = {id = 33, id2 = 0},
            Kevlar = {id = 0, id2 = 0},
            Badge = {id = 0, id2 = 0},
            Torso = {id = 31, id2 = 0},
            Watch = {id = 1, id2 = 0},
            Hat = {id = -1, id2 = 0},
            Glass = {id = -1, id2 = 0},
            Ear = {id = -1, id2 = 0}
          },
        Female = {
            Mask = {id = 121, id2 = 0},
            Arms = {id = 20, id2 = 0},
            Leg = {id = 47, id2 = 0},
            bag = {id = 0, id2 = 0},
            Shoes = {id = 29, id2 = 0},
            Accessory = {id = 23, id2 = 0},
            Tshirt = {id = 38, id2 = 2},
            Kevlar = {id = 0, id2 = 0},
            Badge = {id = 0, id2 = 0},
            Torso = {id = 53, id2 = 3},
            Watch = {id = 1, id2 = 0},
            Hat = {id = -1, id2 = 0},
            Glass = {id = -1, id2 = 3},
            Ear = {id = -1, id2 = 2}
        }
    },
}

Translation = {
    ['en'] = {
        ['ring_infobar'] = 'Press ~b~E~s~ to notify a cardealer',
        ['showroom_infobar'] = 'Press ~b~E~w~, to access the ~o~Showroom~w~!',
        ['boss_infobar'] = 'Press ~b~E~w~, to access the ~o~Boss Menü~w~!',
        ['wardrobe_infobar'] = 'Press ~b~E~w~, to access the ~o~wardrobe~w~!',
        ['garage_infobar'] = 'Press ~b~E~w~, to access the ~o~garage~w~!',
        ['computer_infobar'] = 'Press ~b~E~w~, to access the ~o~Computer~w~!',
        ['delete_vehicle'] = 'Press ~b~E~w~, to ~o~store the vehicle~w~!',
        ['wardrobe'] = 'Wardrobe',
        ['private_clothes'] = 'Private clothes',
        ['bossmenu'] = 'Boss Menu',
        ['finance_management'] = 'Financial management',
        ['staff'] = 'Staff management',
        ['society_money'] = 'Society money',
        ['withdraw_money'] = 'Withdraw money',
        ['deposit_money'] = 'Deposit money',
        ['withdraw_desc'] = 'Do you want to ~g~withdraw~w~ money?',
        ['deposit_desc'] = 'Do you want to ~g~deposit~w~ money?',
        ['how_much'] = 'How much?',
        ['company_money'] = 'Society money',
        ['unknown_amount'] = '~r~Invlaid amount!',
        ['deposit_msg'] = 'You deposited ~g~',
        ['deposit_msg2'] = ' $~w~',
        ['withdraw_msg'] = 'You have withdrawn ~g~',
        ['withdraw_msg2'] = ' $~w~ from your society',
        ['hire'] = 'Hire somebody',
        ['staff_management'] = 'Staff management',
        ['job_rank'] = 'Job rank:',
        ['fire'] = '~r~Fire',
        ['fire_msg'] = 'Do you want to fire ~b~',
        ['fire_msg2'] = '~w~?',
        ['promote'] = 'Promote',
        ['promote_msg'] = 'Do you want to promote ~b~',
        ['promote_msg2'] = '~w~ to ~b~',
        ['promote_msg3'] = ' ~w~?',
        ['showroom'] = 'Showroom',
        ['change_color'] = '~b~Change color',
        ['primary_color'] = 'Primary color',
        ['primary_color_msg'] = 'Set as primary color',
        ['secondary_color'] = 'Secondary color',
        ['secondary_color_msg'] = 'Set as secondary color',
        ['pearl'] = 'Pearlescent',
        ['pearl_msg'] = 'Set as pearlescent',
        ['show_manufacturer'] = 'Manufacturer:',
        ['show_price'] = 'Price:',
        ['show_model'] = 'Model:',
        ['show_park_item'] = 'Exhibit at Showroom',
        ['show_performance'] = 'Performance:',
        ['show_maxSpeed'] = 'Max. speed:',
        ['show_speedup'] = 'Speedup 0-100:',
        ['show_modifications'] = 'Amount of modifications:',
        ['show_fuelcapacity'] = 'Fuel capacity:',
        ['show_suffix_performance'] = ' PS',
        ['show_suffix_maxSpeed'] = ' mp/h',
        ['show_suffix_speedup'] = ' seconds',
        ['show_suffix_modifications'] = ' parts',
        ['show_suffix_fuelcapacity'] = ' l',
        ['test_drive'] = '~b~Prepare for a test drive',
        ['amount_cardealer'] = 'Stock in cardealership:',
        ['amount_storage'] = 'Stock in warehouse:',
        ['set_to_showroom'] = 'Exhibit at Showroom',
        ['amount_cars'] = ' Cars available',
        ['computer'] = 'Computer',
        ['sell_vehicle'] = 'Sell vehicle',
        ['show_1'] = 'Showroom 1',
        ['show_2'] = 'Showroom 2',
        ['show_3'] = 'Showroom 3',
        ['show_4'] = 'Showroom 4',
        ['show_abort'] = '~r~Abort',
        ['yes'] = 'Yes',
        ['no'] = 'No',
        ['car_sell'] = ' (Press to sell)',
        ['bill_purchase_of'] = 'Purchase of a ',
        ['dialog_price'] = 'Price',
        ['no_customers'] = '~o~There is no customer next to you! There have to be a customer next to you to sell a car.',
        ['vehicles_list'] = 'Vehicles',
        ['car_deliver'] = 'Bring this car to the dealership: ',
        ['car_craft'] = 'Manufacture this vehicle: ',
        ['amount'] = 'Amount',
        ['ordered'] = 'Ordered: ',
        ['reserved'] = 'Reserved: ',
        ['orders'] = 'Orders',
        ['total_production_time'] = 'Remaining production time:',
        ['current_production_time'] = 'Ordered vehicles:',
        ['refresh_time'] = 'Refresh',
        ['hours'] = ' hours',
        ['hired'] = '~g~Hired~w~!',
        ['you_were_hired'] = 'You were ~g~hired!~w~',
        ['you_hired'] = 'You ~g~hired ~b~',
        ['you_hired2'] = '~g~~w~!',
        ['already_hired'] = '~r~Already hired!~w~',
        ['is_already_hired'] = ' is already ~r~hired~w~!',
        ['fired'] = '~r~Fired~w~!',
        ['you_are_fired'] = 'You were ~r~fired~w~!',
        ['you_fired'] = 'You ~r~fired ~b~',
        ['you_fired2'] = '~r~~w~!',
        ['error'] = '~r~Error~w~!',
        ['player_not_online'] = 'This ~b~player~w~ is not online!',
        ['promoted'] = '~g~Promoted~w~!',
        ['you_were_promoted'] = 'You were ~b~promoted ~s~to~b~',
        ['you_were_promoted2'] = '~g~~w~!',
        ['you_promoted'] = 'You ~b~promoted ~b~',
        ['you_promoted2'] = '~w~ to ~b~',
        ['you_promoted3'] = '~g~~w~!',
        ['ring_ring'] = '~b~There is a ~w~customer waiting ~b~at the dealership!',
        ['vehicle_purchased'] = '~g~Vehicle purchased~w~!',
        ['you_purchased'] = 'You got a ',
        ['you_purchased2'] = ', with the number plate ',
        ['you_purchased3'] = ' ~g~',
        ['vehicle_sold'] = '~g~Vehicle sold~w~!',
        ['you_sold'] = 'You sold a ',
        ['you_sold2'] = ' ~g~',
        ['vehicle_ordered'] = '~g~Vehicle ordered~w~!',
        ['you_ordered'] = 'You ~g~ordered ',
        ['you_ordered2'] = ' ~s~. In total you ~g~ordered ',
        ['you_ordered3'] = 'x ~s~!',
        ['you_applied'] = 'You ~g~reserved ',
        ['you_applied2'] = ' ~s~. In total you ~g~reserved ',
        ['you_applied3'] = 'x ~s~!',
        ['not_enough_money'] = 'There is ~r~not enough money~s~ on your society wallet!',
        ['vehicle_delivered'] = 'Vehicles ~g~successfully delivered~s~!',
        ['not_enough_vehicles_in_storage'] = 'There are not enough vehicles in the large warehouse',
        ['presented_prefix'] = '~y~Displayed: ~s~',
        ['insert_new_value'] = 'Insert a new value',
        ['click_to_change'] = '~b~click to change the value',
        ['not_enough_money_player'] = '~r~Not enough money!',
        ['required_order_time'] = 'Required manufacturing time:',
		['customer_not_enough_money'] = '~r~The customer does not have enough money!',
    },
    ['de'] = {
        ['ring_infobar'] = 'Drücke ~b~E~s~ um einen Verkäufer zu rufen',
        ['showroom_infobar'] = 'Drücke ~b~E~w~, um den ~o~Showroom~w~ zu öffnen!',
        ['boss_infobar'] = 'Drücke ~b~E~w~, um das ~o~Boss Menü~w~ zu öffnen!',
        ['wardrobe_infobar'] = 'Drücke ~b~E~w~, um die ~o~Umkleide~w~ zu öffnen!',
        ['garage_infobar'] = 'Drücke ~b~E~w~, um die ~o~Garage~w~ zu öffnen!',
        ['computer_infobar'] = 'Drücke ~b~E~w~, um den ~o~Computer~w~ zu öffnen!',
        ['delete_vehicle'] = 'Drücke ~b~E~w~, um das ~o~einzuparken~w~!',
        ['wardrobe'] = 'Umkleide',
        ['private_clothes'] = 'Privatkleidung',
        ['bossmenu'] = 'Boss Menü',
        ['finance_management'] = 'Finanzverwaltung',
        ['staff'] = 'Personal',
        ['society_money'] = 'Firmenkonto',
        ['withdraw_money'] = 'Firmengeld abheben',
        ['deposit_money'] = 'Firmengeld einzahlen',
        ['withdraw_desc'] = 'Willst du ~g~Geld~w~ vom Firmenkonto abheben?',
        ['deposit_desc'] = 'Willst du ~g~Geld~w~ auf das Firmenkonto einzaheln?',
        ['how_much'] = 'Wie viel?',
        ['company_money'] = 'Firmenkonto',
        ['unknown_amount'] = '~r~Ungültiger Betrag!',
        ['deposit_msg'] = 'Du hast ~g~',
        ['deposit_msg2'] = ' $~w~ auf das Firmenkonto eingezahlt',
        ['withdraw_msg'] = 'Du hast ~g~',
        ['withdraw_msg2'] = ' $~w~ vom Firmenkonto abgehoben',
        ['hire'] = 'Mitarbeiter einstellen',
        ['staff_management'] = 'Mitarbeiterverwaltung',
        ['job_rank'] = 'Rang:',
        ['fire'] = '~r~Feuern',
        ['fire_msg'] = 'Willst du ~b~',
        ['fire_msg2'] = '~w~ ~r~feuern~w~?',
        ['promote'] = 'Befördern',
        ['promote_msg'] = 'Willst du ~b~',
        ['promote_msg2'] = '~w~ zum ~b~',
        ['promote_msg3'] = ' ~g~befördern~w~?',
        ['showroom'] = 'Showroom',
        ['change_color'] = '~b~Farbe ändern',
        ['primary_color'] = 'Primärfarbe',
        ['primary_color_msg'] = 'Als Primärfarbe setzen',
        ['secondary_color'] = 'Sekundärfarbe',
        ['secondary_color_msg'] = 'Als Sekundärfarbe setzen',
        ['pearl'] = 'Pearl-Effekt',
        ['pearl_msg'] = 'Als Pearl-Effekt setzen',
        ['show_manufacturer'] = 'Hersteller:',
        ['show_price'] = 'Preis:',
        ['show_model'] = 'Model:',
        ['show_park_item'] = 'Fahrzeug ausstellen',
        ['show_performance'] = 'Pferdestärke:',
        ['show_maxSpeed'] = 'Höchst Geschwindigkeit:',
        ['show_speedup'] = 'Beschleunigung 0-100:',
        ['show_modifications'] = 'Mögliche Modifikationen:',
        ['show_fuelcapacity'] = 'Tankkapazität:',
        ['show_suffix_performance'] = ' PS',
        ['show_suffix_maxSpeed'] = ' km/h',
        ['show_suffix_speedup'] = ' Sekunden',
        ['show_suffix_modifications'] = ' Teile',
        ['show_suffix_fuelcapacity'] = ' Liter',
        ['test_drive'] = '~b~Fahrzeug zur Probefahrt bereitstellen',
        ['amount_cardealer'] = 'Bestand im Autohaus:',
        ['amount_storage'] = 'Bestand im Lager:',
        ['set_to_showroom'] = 'Fahrzeug ausstellen',
        ['amount_cars'] = ' Exemplare',
        ['computer'] = 'Computer',
        ['sell_vehicle'] = 'Fahrzeug verkaufen',
        ['show_1'] = 'Stellplatz 1',
        ['show_2'] = 'Stellplatz 2',
        ['show_3'] = 'Stellplatz 3',
        ['show_4'] = 'Stellplatz 4',
        ['show_abort'] = 'Abbrechen',
        ['yes'] = 'Ja',
        ['no'] = 'Nein',
        ['car_sell'] = ' verkaufen',
        ['bill_purchase_of'] = 'Kauf von einem ',
        ['dialog_price'] = 'Preis',
        ['no_customers'] = '~r~Keine Kunden!',
        ['vehicles_list'] = 'Fahrzeugliste',
        ['car_deliver'] = 'Fahrzeug liefern lassen für: ',
        ['car_craft'] = 'Fahrzeug herstellen lassen für: ',
        ['amount'] = 'Menge',
        ['ordered'] = 'Bestellt: ',
        ['reserved'] = 'Beantragt: ',
        ['orders'] = 'Bestellungen',
        ['total_production_time'] = 'Verbleibende Produktionszeit:',
        ['current_production_time'] = 'Offene Aufträge:',
        ['refresh_time'] = 'Zeit aktualisieren',
        ['hours'] = ' Stunden',
        ['hired'] = '~g~Eingestellt~w~!',
        ['you_were_hired'] = 'Du wurdest ~g~eingestellt!~w~',
        ['you_hired'] = 'Du hast ~b~',
        ['you_hired2'] = ' ~g~eingestellt~w~!',
        ['already_hired'] = '~r~Schon Angestellt!~w~',
        ['is_already_hired'] = ' ist schon bei dir ~r~angestellt~w~!',
        ['fired'] = '~r~Gefeuert~w~!',
        ['you_are_fired'] = 'Du wurdest ~r~gefeuert~w~!',
        ['you_fired'] = 'Du hast ~b~',
        ['you_fired2'] = ' ~r~gefeuert~w~!',
        ['error'] = '~r~Error~w~!',
        ['player_not_online'] = 'Der ~b~Spieler~w~ ist nicht online!',
        ['promoted'] = '~g~Befördert~w~!',
        ['you_were_promoted'] = 'Du wurdest zum ~b~',
        ['you_were_promoted2'] = ' ~g~befördert~w~!',
        ['you_promoted'] = 'Du hast ~b~',
        ['you_promoted2'] = '~w~ zum ~b~',
        ['you_promoted3'] = ' ~g~befördert~w~!',
        ['ring_ring'] = '~b~Ein Kunde wartet im Autohaus!',
        ['vehicle_purchased'] = '~g~Fahrzeug gekauft~w~!',
        ['you_purchased'] = 'Du hast ein ',
        ['you_purchased2'] = ', mit dem Nummernschild ',
        ['you_purchased3'] = ' ~g~gekauft',
        ['vehicle_sold'] = '~g~Fahrzeug verkauft~w~!',
        ['you_sold'] = 'Du hast ein ',
        ['you_sold2'] = ' ~g~verkauft',
        ['vehicle_ordered'] = '~g~Fahrzeug bestellt~w~!',
        ['you_ordered'] = 'Du hast ',
        ['you_ordered2'] = ' ~g~bestelt~s~. Insgesamt hast du ',
        ['you_ordered3'] = 'x ~g~bestellt~s~!',
        ['you_applied'] = 'Du hast ',
        ['you_applied2'] = ' ~g~beantragt~s~. Insgesamt hast du ',
        ['you_applied3'] = 'x ~g~beantragt~s~!',
        ['not_enough_money'] = 'Es ist ~r~zu wenig Geld~s~ auf dem Firmenkonto, um die Fahrzeuge zu bezahlen!',
        ['vehicle_delivered'] = 'Fahrzeuge ~g~erfolgreich geliefert~s~!',
        ['not_enough_vehicles_in_storage'] = 'Es sind nicht so viele Fahrzeuge im Hauptlager',
        ['presented_prefix'] = '~y~Ausgestellt: ~s~',
        ['insert_new_value'] = 'Gebe einen neuen Wert ein',
        ['click_to_change'] = '~b~Klicke, um die Werte zu aktualisieren',
        ['not_enough_money_player'] = '~r~Nicht genügend Geld!',
        ['required_order_time'] = 'Benötigte Zeit zur Herstellung:',
		['customer_not_enough_money'] = '~r~Der Kunde hat nicht genügend Geld!',
    },
}

Cfg.Colors = {
	['black'] = 'black',
	['graphite'] = 'graphite',
	['black_metallic'] = 'black Metallic',
	['caststeel'] = 'cast Steel',
	['black_anth'] = 'black Anthracite',
	['matteblack'] = 'matte Black',
	['darknight'] = 'dark Night',
	['deepblack'] = 'deep Black',
	['oil'] = 'oil',
	['carbon'] = 'carbon',
	-- White
	['white'] = 'white',
	['vanilla'] = 'vanilla',
	['creme'] = 'creme',
	['polarwhite'] = 'polar White',
	['beige'] = 'beige',
	['mattewhite'] = 'matte White',
	['snow'] = 'snow',
	['cotton'] = 'cotton',
	['alabaster'] = 'alabaster',
	['purewhite'] = 'pure White',
	-- Grey
	['grey'] = 'grey',
	['silver'] = 'silver',
	['metallicgrey'] = 'metallic Grey',
	['laminatedsteel'] = 'laminated Steel',
	['darkgray'] = 'dark Grey',
	['rockygray'] = 'rocky Grey',
	['graynight'] = 'gray Night',
	['aluminum'] = 'aluminum',
	['graymat'] = 'matte Grey',
	['lightgrey'] = 'light Grey',
	['asphaltgray'] = 'asphalt Grey',
	['grayconcrete'] = 'concrete Grey',
	['darksilver'] = 'dark Silver',
	['magnesite'] = 'magnesite',
	['nickel'] = 'nickel',
	['zinc'] = 'zinc',
	['dolomite'] = 'dolomite',
	['bluesilver'] = 'blue Silver',
	['titanium'] = 'titanium',
	['steelblue'] = 'steel Blue',
	['champagne'] = 'champagne',
	['grayhunter'] = 'grey Hunter',
	-- Red
	['red'] = 'red',
	['torino_red'] = 'torino Red',
	['poppy'] = 'poppy',
	['copper_red'] = 'copper Red',
	['cardinal'] = 'cardinal Red',
	['brick'] = 'brick Red',
	['garnet'] = 'Garnet',
	['cabernet'] = 'cabernet Red',
	['candy'] = 'candy Red',
	['matte_red'] = 'matte Red',
	['dark_red'] = 'dark Red',
	['red_pulp'] = 'red Pulp',
	['bril_red'] = 'brilliant Red',
	['pale_red'] = 'pale Red',
	['wine_red'] = 'wine Red',
	['volcano'] = 'Volcano',
	-- Pink
	['pink'] = 'pink',
	['electricpink'] = 'electric Pink',
	['brightpink'] = 'bright Pink',
	['salmon'] = 'salmon',
	['sugarplum'] = 'sugar Plum',
	-- Blue
	['blue'] = 'blue',
	['topaz'] = 'topaz',
	['light_blue'] = 'light Blue',
	['galaxy_blue'] = 'galaxy Blue',
	['dark_blue'] = 'dark Blue',
	['azure'] = 'azure',
	['navy_blue'] = 'navy Blue',
	['lapis'] = 'lapis Lazuli',
	['blue_diamond'] = 'blue Diamond',
	['surfer'] = 'surfer',
	['pastel_blue'] = 'pastel Blue',
	['celeste_blue'] = 'celeste Blue',
	['rally_blue'] = 'rally Blue',
	['blue_paradise'] = 'blue Paradise',
	['blue_night'] = 'blue Night',
	['cyan_blue'] = 'cyan Blue',
	['cobalt'] = 'cobalt',
	['electric_blue'] = 'electric Blue',
	['horizon_blue'] = 'horizon Blue',
	['metallic_blue'] = 'metallic Blue',
	['aquamarine'] = 'aquamarine',
	['blue_agathe'] = 'blue Agathe',
	['zirconium'] = 'zirconium',
	['spinel'] = 'spinel',
	['tourmaline'] = 'tourmaline',
	['paradise'] = 'paradise',
	['bubble_gum'] = 'bubble Gum',
	['midnight_blue'] = 'midnight Blue',
	['forbidden_blue'] = 'forbidden Blue',
	['glacier_blue'] = 'glacier Blue',
	-- Yellow
	['yellow'] = 'yellow',
	['wheat'] = 'wheat',
	['raceyellow'] = 'race Yellow',
	['paleyellow'] = 'pale Yellow',
	['lightyellow'] = 'light Yellow',
	-- Green
	['green'] = 'green',
	['met_dark_green'] = 'metallic Dark Green',
	['rally_green'] = 'Rally Green',
	['pine_green'] = 'pine Green',
	['olive_green'] = 'olive Green',
	['light_green'] = 'Light Green',
	['lime_green'] = 'lime green',
	['forest_green'] = 'forest Green',
	['lawn_green'] = 'lawn Green',
	['imperial_green'] = 'imperial Green',
	['green_bottle'] = 'breen Bottle',
	['citrus_green'] = 'citrus Green',
	['green_anis'] = 'green Anis',
	['khaki'] = 'Khaki',
	['army_green'] = 'army Green',
	['dark_green'] = 'dark Green',
	['hunter_green'] = 'hunter Green',
	['matte_foilage_green'] = 'matte Foilage Green',
	-- Orange
	['orange'] = 'orange',
	['tangerine'] = 'Tangerine',
	['matteorange'] = 'Matte Orange',
	['lightorange'] = 'Light Orange',
	['peach'] = 'Peach',
	['pumpkin'] = 'Pumpkin',
	['orangelambo'] = 'Orange Lambo',
	-- Brown
	['brown'] = 'brown',
	['copper'] = 'Copper',
	['lightbrown'] = 'Light Brown',
	['darkbrown'] = 'Dark Brown',
	['bronze'] = 'Bronze',
	['brownmetallic'] = 'Brown Metallic',
	['espresso'] = 'Espresso',
	['chocolate'] = 'Chocolate',
	['terracotta'] = 'Terracotta',
	['marble'] = 'Marble',
	['sand'] = 'Sand',
	['sepia'] = 'Sepia',
	['bison'] = 'Bison',
	['palm'] = 'Palm',
	['caramel'] = 'Caramel',
	['rust'] = 'Rust',
	['chestnut'] = 'Chestnut',
	['hazelnut'] = 'Hazelnut',
	['shell'] = 'Shell',
	['mahogany'] = 'Mahogany',
	['cauldron'] = 'Cauldron',
	['blond'] = 'Blond',
	['gravel'] = 'Gravel',
	['darkearth'] = 'Dark Earth',
	['desert'] = 'Desert',
	-- Purple
	['purple'] = 'purple',
	['indigo'] = 'Indigo',
	['deeppurple'] = 'Deep Purple',
	['darkviolet'] = 'Dark Violet',
	['amethyst'] = 'Amethyst',
	['mysticalviolet'] = 'Mystic Violet',
	['purplemetallic'] = 'Purple Metallic',
	['matteviolet'] = 'Matte Violet',
	['mattedeeppurple'] = 'Matte Deep Purple',
	-- Chrome
	['chrome'] = 'chrome',
	['brushedchrome'] = 'brushed Chrome',
	['blackchrome'] = 'black Chrome',
	['brushedaluminum'] = 'brushed Aluminum',
	-- Metal
	['gold'] = 'gold',
	['puregold'] = 'pure Gold',
	['brushedgold'] = 'brushed Gold',
	['lightgold'] = 'light Gold',
}
