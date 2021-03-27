Config = {}
Translation = {}

Config.Debug = true -- when this is activated, you can restart the script
Config.Locale = 'de' -- de or en

Config.useOneSyncInfinity = true

Config.areFarmsUnique = true -- should farms only be sold one time?

-- Supplies
Config.Supplies = {min = 50, max = 90} -- how many items should be given at a mission
Config.VehicleModifier1 = 5 -- extra supplies through bigger vehicle
Config.VehicleModifier2 = 10 -- extra supplies through bigger vehicle

Config.PricePerPlant = 15

Config.Level2Price = 250000
Config.Level3Price = 300000

Config.useSeller = true -- should the Seller be there
Config.SellerLocation = {x = 2140.58, y = 4789.76, z = 40.97, rot = 94.16}
Config.SellerPedModel = "s_m_m_cntrybar_01"
Config.showSellerBlip = false

Config.useBlackMoney = false
Config.BlackMoneyName = 'black_money'

Config.SellItems = { -- set up the items here, that your players can sell at the seller - You can set up the items they get in the missions config.

    {sqlitem = 'weed_pooch', label = 'Weed', priceBuy = 400.0},
    {sqlitem = 'meth_pooch', label = 'Meth', priceBuy = 500.0},
    {sqlitem = 'coke_pooch', label = 'Coke', priceBuy = 600.0},

}

Config.SellDivide = 2 -- old price / SellDivide is the amount the player gets when he sells the farm

Config.UseIPLs = true -- needs bob74_ipl
-- 
Config.StoreCapacity = {

    200,
    300,
    400,

}

-- Finished drugs
Config.FinishCapacity = {

    75,
    125,
    150,

}

-- Produce rate per hour
Config.ProduceRate = {

    12, -- 2/min
    14,
    16,

}

Config.Vehicles = {

    {model = "dloader", label = 'Bravado Duneloader', price = 50000},
    {model = "burrito3", label = 'Declasse Burrito', price = 75000},
    {model = "mule2", label = 'Maibatsu Mule', price = 100000},

}

Config.WeedItem = 'weed_pooch' -- name of the final drug item
Config.MethItem = 'meth_pooch'
Config.CokeItem = 'coke_pooch'

Config.Farms = { 
    
    {id = 1, type = "weed", name = "GWeed", label = "Weedlabor", price = 380000, enter = {x = -13.474226951599, y = 6480.4467773438, z = 31.428388595581}, inside = {x = 1064.67, y = -3182.66, z = -39.16, rot = 133.74}, bossActions = {x = 1044.02, y = -3194.92, z = -38.16}, spawnVehicle = {x = -18.258155822754, y = 6465.0415039062, z = 31.446332931519, rot = 225.59}}, 
    {id = 2, type = "meth", name = "PMeth", label = "Methlabor", price = 385000, enter = {x = 1961.3543701172, y = 5185.0170898438, z = 47.964378356934}, inside = {x = 997.3, y = -3200.57, z = -36.39, rot = 260.1}, bossActions = {x = 1002.09, y = -3195.21, z = -38.99}, spawnVehicle = {x = 1967.7254638672, y = 5177.298828125, z = 47.833843231201, rot = 146.59}}, 
    {id = 3, type = "coke", name = "GCoke", label = "Kokainlabor", price = 460000, enter = {x = -269.42251586914, y = -2437.2082519531, z = 6.3962173461914}, inside = {x = 1088.61, y = -3187.81, z = -38.99, rot = 180.0}, bossActions = {x = 1087.4, y = -3194.22, z = -38.99}, spawnVehicle = {x = -262.82901000977, y = -2441.7531738281, z = 6.0006332397461, rot = 229.13}}, 
    --{id = 4, type = "meth", name = "SMeth", label = "Sandy Meth", price = 450000, enter = {x = 1737.69, y = 3709.59, z = 34.14}, inside = {x = 997.3, y = -3200.57, z = -36.39, rot = 260.1}, bossActions = {x = 1002.09, y = -3195.21, z = -38.99}, spawnVehicle = {x = 1730.03, y = 3712.02, z = 34.21, rot = 24.05}},
    --{id = 5, type = "weed", name = "SWeed", label = "Sandy Weed", price = 410000, enter = {x = 1407.08, y = 3603.46, z = 35.0}, inside = {x = 1064.67, y = -3182.66, z = -39.16, rot = 133.74}, bossActions = {x = 1044.02, y = -3194.92, z = -38.16}, spawnVehicle = {x = 1411.14, y = 3620.41, z = 34.89, rot = 304.19}},
    --{id = 6, type = "coke", name = "SCoke", label = "Desert Coke", price = 490000, enter = {x = 2404.55, y = 3127.57, z = 48.15}, inside = {x = 1088.61, y = -3187.81, z = -38.99, rot = 180.0}, bossActions = {x = 1087.4, y = -3194.22, z = -38.99}, spawnVehicle = {x = 2408.06, y = 3138.08, z = 48.17, rot = 241.86}},
    --{id = 7, type = "weed", name = "PWeed", label = "Paleto Weed", price = 340000, enter = {x = -400.21, y = 6378.26, z = 14.07}, inside = {x = 1064.67, y = -3182.66, z = -39.16, rot = 133.74}, bossActions = {x = 1044.02, y = -3194.92, z = -38.16}, spawnVehicle = {x = -409.76, y = 6377.92, z = 13.99, rot = 292.77}},
    --{id = 8, type = "meth", name = "HMeth", label = "Port Meth", price = 480000, enter = {x = -253.68, y = -2591.14, z = 6.0}, inside = {x = 997.3, y = -3200.57, z = -36.39, rot = 260.1}, bossActions = {x = 1002.09, y = -3195.21, z = -38.99}, spawnVehicle = {x = -257.35, y = -2586.52, z = 6.0, rot = 94.65}},
    --{id = 9, type = "weed", name = "CWeed", label = "City Hanfplantage", price = 465000, enter = {x = -400.21, y = 6378.26, z = 14.07}, inside = {x = 1064.67, y = -3182.66, z = -39.16, rot = 133.74}, bossActions = {x = 1044.02, y = -3194.92, z = -38.16}, spawnVehicle = {x = 1111.34, y = -2280.78, z = 30.27, rot = 81.42}},
    --{id = 10, type = "coke", name = "CCoke", label = "City Coke", price = 570000, enter = {x = -1421.74, y = -641.16, z = 28.67}, inside = {x = 1088.61, y = -3187.81, z = -38.99, rot = 180.0}, bossActions = {x = 1087.4, y = -3194.22, z = -38.99}, spawnVehicle = {x = -1425.48, y = -649.9, z = 28.67, rot = 215.43}},
}

Config.EnableMissionMarker = true

Config.StorageMissionDestinations = {

    {loc = {x = 1725.3040771484, y = 4731.705078125, z = 42.131866455078}},
    {loc = {x = -73.594604492188, y = 6391.1943359375, z = 31.49036026001}},
    {loc = {x = 1531.6760253906, y = 1703.1214599609, z = 109.76142883301}},
    {loc = {x = 851.470703125, y = 2163.1162109375, z = 52.280570983887}},
    {loc = {x = 1005.89, y = -2180.43, z = 30.55}},
    {loc = {x = 68.137680053711, y = -1921.1176757813, z = 21.344047546387}},
    {loc = {x = 1741.3555908203, y = 6420.2719726563, z = 35.042819976807}},
    {loc = {x = 579.18041992188, y = 131.56706237793, z = 98.041435241699}},
    {loc = {x = -88.325927734375, y = 6520.046875, z = 31.490671157837}},
    {loc = {x = -3.1815752983093, y = 6488.9702148438, z = 31.507305145264}},
    {loc = {x = 1537.4265136719, y = 6336.50390625, z = 24.076147079468}},
    {loc = {x = 2354.9680175781, y = 4874.4736328125, z = 41.811714172363}},
    {loc = {x = 1702.96484375, y = 4725.8461914063, z = 42.225402832031}},
    {loc = {x = 907.10546875, y = 3552.5773925781, z = 33.820327758789}},
    {loc = {x = 424.85559082031, y = 3565.6206054688, z = 33.238647460938}},
    {loc = {x = 24.636083602905, y = 3730.25, z = 39.162776947021}},
    {loc = {x = 1182.0393066406, y = 2629.7526855469, z = 37.285152435303}},
    {loc = {x = 525.3955078125, y = 3093.1999511719, z = 39.936347961426}},
    {loc = {x = 605.59631347656, y = 2788.8547363281, z = 41.661518096924}},
    {loc = {x = 197.34005737305, y = 2455.4086914063, z = 55.344596862793}},
    {loc = {x = 312.93176269531, y = 262.42553710938, z = 104.13414001465}},
    {loc = {x = 223.55680847168, y = -2.718318939209, z = 73.461463928223}},
    {loc = {x = -1319.1116943359, y = -1263.4224853516, z = 4.061203956604}},
    {loc = {x = -1272.3686523438, y = -1368.4937744141, z = 3.7769243717194}},
    {loc = {x = -1158.8983154297, y = -1553.7609863281, z = 3.7298440933228}},
    {loc = {x = -1175.5709228516, y = -2038.4045410156, z = 13.325268745422}},
    {loc = {x = -699.29693603516, y = -2449.8098144531, z = 13.416937828064}},
    {loc = {x = -430.32510375977, y = -2165.2971191406, z = 9.8008852005005}},
    {loc = {x = 989.18646240234, y = -2289.8581542969, z = 29.981838226318}},
    {loc = {x = 1068.9932861328, y = -1968.4029541016, z = 30.487489700317}},
    {loc = {x = 1661.6955566406, y = -1847.3522949219, z = 108.64238739014}},
    {loc = {x = 1143.1143798828, y = -1330.7443847656, z = 34.127529144287}},
    {loc = {x = 1096.2591552734, y = -261.14459228516, z = 68.754318237305}},
    {loc = {x = 474.4931640625, y = -1063.2667236328, z = 28.684412002563}},

}



Translation = {
    ['en'] = {
        ['access_computer'] = 'Press ~g~E~s~, to access the computer',
        ['enter_farm'] = 'Press ~g~E~s~, to enter ~o~',
        ['enter_farm_2'] = '~s~.',
        ['leave_farm'] = 'Press ~g~E~s~, to leave the farm',

        ['nothing_produced'] = '~y~Nothing could be produced in your absence as there are no supplies.',
        ['successfully_produced'] = '~g~During your absence, ~w~',
        ['successfully_produced_2'] = '~g~were produced.',
        ['successfully_produced_3'] = ' ~g~produced.',
        ['successfully_produced_storageEmpty'] = ' ~g~produced. Supplies are empty!',

        ['get_from_storage'] = '~s~ taken from the warehouse.',
        ['farm_bought_title'] = 'Farm bought',
        ['farm_bought'] = 'Well! ~g~',
        ['farm_bought_2'] = ' ~s~is now yours. Good choice!',

        ['weed'] = '~g~Weed',
        ['meth'] = '~b~Meth',
        ['coke'] = '~w~Coke',

        ['supplies'] = 'Supplies',
        ['already_started_mission'] = '~r~You have already started a mission!',
        ['notEnoughMoney'] = '~r~Not enough money!',

        ['mission_car_changed'] = 'You new vehicle ~y~',
        ['mission_car_changed_2'] = ' ~s~is being delivered.',
        ['mission_startLoading'] = 'Hee! You have to be here to pick up the supplies. We start loading.',
        ['mission_seller'] = 'Seller',
        ['mission_outofrange'] = '~y~The vehicle could not be fully loaded. Return to the seller!',
        ['mission_loading'] = 'Vehicle is being loaded: \n~g~',
        ['mission_loading_2'] = '% ~s~completed.',
        ['mission_wrongCar'] = 'I guess this vehicle is not the right one..',
        ['mission_backToFarm'] = 'Drive back to your farm!',

        ['mission_self_plants_bought'] = 'x supplies ~s~bought for ~g~',
        ['mission_self_plants_bought_2'] = '$~s~.',
        ['mission_self_plants_notEnoughMoney'] = 'The supplies were ~r~unloaded~s~, because you do not have enough money!.',
        ['mission_dou_plants_bought'] = 'x supplies ~s~were ~g~bought ~s~by your boss.',
        ['mission_dou_plants_abort'] = '~b~',
        ['mission_dou_plants_abort_2'] = '~s~s Mission was ~r~canceled~s~, because you do not have enough money.',
        ['mission_dou_plants_abort_target'] = 'Mission was ~r~aborted~s~, because the supplies were not paid for.',
        ['mission_dou_plants_arrived'] = 'The delivery with ~g~',
        ['mission_dou_plants_arrived_2'] = ' supplies arrived at this moment.',
        ['mission_dou_plants_arrived_target'] = 'Supplies successfully ~g~loaded',

        ['mission_press_e_deliver'] = 'Press ~g~E~s~, to unload the supplies',
        ['mission_wrongCar_deliver'] = 'This is not the vehicle we have loaded?',

        ['mission_invited'] = 'You were ~g~invited ~s~to do a ~b~mission~s~. Press  ~g~E~s~, to accept.',
        ['mission_invited_over'] = 'The invite has ~r~expired~s~!',

        ['menu_enter_farm'] = 'Enter the farm',
        ['menu_buy_farm'] = 'Buy the farm',
        ['menu_buy_name'] = 'Name:',
        ['menu_buy_type'] = 'Type:',
        ['menu_buy_price'] = 'Price:',
        ['menu_buy_confirm'] = 'Confirm',

        ['menu_computer_level'] = 'Level ',
        ['menu_computer_produced'] = 'Finished drugs',
        ['menu_computer_produced_desc'] = 'Finished and packed drugs',
        ['menu_computer_storage'] = 'Supplies',
        ['menu_computer_storage_desc'] = 'Supplies are needed for the production',
        ['menu_computer_takedrugs'] = 'How much should be withdrawn?',
        ['menu_computer_notenoughdrugs'] = 'You do not have that much in stock!',

        ['menu_storage'] = 'Get supplies',
        ['menu_storage_input'] = 'Store supplies',
        ['menu_storage_input_desc'] = 'Store supplies you have in your inventory',
        ['menu_storage_storageLimit'] = '~s~There is only space left for ~y~',
        ['menu_storage_storageLimit_2'] = ' supplies~s~!',
        ['menu_storage_notenough'] = '~r~You do not have enough supplies!',
        ['menu_storage_buy'] = 'Buy supplies',
        ['menu_storage_buy_desc'] = 'Buy supplies from black market',
        ['menu_storage_buy_self'] = 'Buy supplies on your own',
        ['menu_storage_buy_others'] = 'Let somebody buy your supplys',
        ['menu_storage_buy_others_desc'] = 'The person have to stay next to the farm entrance',
        ['menu_storage_inputseeds'] = 'How much should be stored?',
        ['storagemission_invite'] = 'Click to ask ~b~',
        ['storagemission_invite_2'] = '~s~',

        ['menu_upgrade'] = 'Upgrade farm',
        ['menu_upgrade_prod'] = 'Improve farm',
        ['menu_upgrade_prod_desc'] = 'Increase productivity and storage',
        ['menu_upgrade_prod_level2'] = 'Improve equipment',
        ['menu_upgrade_prod_level2_desc'] = 'Increase performance by improving your equipment: e.g. better fans',
        ['menu_upgrade_prod_level3'] = 'Improve security',
        ['menu_upgrade_prod_level3_desc'] = 'Increase performance by improving your monitoring: e.g. Video recording',
        ['menu_upgrade_level2required'] = 'Level 2 required',
        ['upgraded_title'] = 'Buy upgrade',
        ['upgraded'] = 'The ~y~level ~s~of your farm was upgraded to ~y~',
        ['upgraded_2'] = ' ~s~. Reenter the farm to see the progress.',

        ['menu_stats_finished'] = '~b~Storage capacity (finished drugs):',
        ['menu_stats_storecap'] = '~b~Storage capacity (supplies):',
        ['menu_stats_storecap_desc'] = '~s~4x supplies = 1x drug',
        ['menu_stats_productivity'] = '~b~Production speed',

        ['menu_changeVehicle'] = 'Change mission vehicle',
        ['menu_changeVehicle_change'] = 'Click to select ~b~',
        ['menu_changeVehicle_change2'] = ' ~s~as your mission vehicle',

        ['menu_access'] = 'Key cards',
        ['menu_access_desc'] = 'Set up who have access to the farm',
        ['menu_access_trust_remove'] = 'Click to revoke ~b~',
        ['menu_access_trust_remove_2'] = ' ~s~s access',
        ['menu_addTrusted'] = '~g~Grant access',
        ['menu_access_trust_add'] = 'Click to grant ~b~',
        ['menu_access_trust_add_2'] = ' ~s~access',

        ['menu_access_removed'] = ' ~s~s access was revoked.',
        ['menu_access_removed_target'] = 'You access for ~y~farm (#',
        ['menu_access_removed_target_2'] = ') was revoked.',
        ['menu_access_granted'] = ' ~s~s access was granted.',
        ['menu_access_granted_target'] = 'You now have access to ~g~farm (#',
        ['menu_access_granted_target_2'] = ')',

        ['menu_sell'] = 'Sell farm',
        ['menu_sell_confirm'] = 'Confirm selling farm',
        ['infobar_seller'] = 'Press ~o~E~s~, to talk with the seller',
        ['items_sold_for'] = '~s~Items sold for ~g~',
        ['you_only_have_items'] = '~y~You only have ~w~',
        ['you_only_have_items2'] = 'x ~y~with you',
        ['seller_title'] = 'Seller',
        ['input_howmuch'] = 'How much should be sold?',
        ['menu_sell_desc'] = 'Sell the farmDiese Farm ist nicht mehr verfügbar!',

    },

    ['de'] = {
        ['access_computer'] = 'Drücke ~g~E~s~, um auf den Computer zuzugreifen',
        ['enter_farm'] = 'Drücke ~g~E~s~, um ~o~',
        ['enter_farm_2'] = '~s~ zu betreten',
        ['leave-farm'] = 'Drücke ~g~E~s~, um die Produktion zu verlassen',

        ['nothing_produced'] = '~y~Während deiner Abwesenheit konnte nichts produziert werden, da keine Vorräte vorhanden sind.',
        ['successfully_produced'] = '~g~Während du weg warst, wurden ~w~',
        ['successfully_produced_2'] = '~g~verarbeitet.',
        ['successfully_produced_3'] = ' ~g~produziert.',
        ['successfully_produced_storageEmpty'] = ' ~g~produziert. Deine Vorräte sind leer!',

        ['get_from_storage'] = '~s~ aus dem Lager entnommen.',
        ['farm_bought_title'] = 'Farm gekauft',
        ['farm_bought'] = 'Dann ist die ~g~',
        ['farm_bought_2'] = ' ~s~wohl ab Sofort deins..gute Wahl!',

        ['weed'] = '~g~Hanf',
        ['meth'] = '~b~Meth',
        ['coke'] = '~w~Kokain',

        ['supplies'] = 'Vorräte',
        ['already_started_mission'] = '~r~Du hast bereits eine Beschaffungsmission gestartet!',
        ['notEnoughMoney'] = '~r~Du hast nicht genügend Geld!',

        ['mission_car_changed'] = 'Dein neues Beschaffungsfahrzeug ~y~',
        ['mission_car_changed_2'] = ' ~s~wird umgehend geliefert.',
        ['mission_startLoading'] = 'Hee! Du musst hier sein, um die Vorräte abzuholen. Wir beginnen mit dem Beladen.',
        ['mission_seller'] = 'Verkäufer',
        ['mission_outofrange'] = '~y~Das Fahrzeug konnte nicht vollständig beladen werden. Kehre zurück zum Verkäufer!',
        ['mission_loading'] = 'Fahrzeug wird beladen: \n~g~',
        ['mission_loading_2'] = '% ~s~abgeschlossen.',
        ['mission_wrongCar'] = 'In das Fahrzeug bekommen wir die Ware aber nicht rein..',
        ['mission_backToFarm'] = 'Fahre nun zurück zur Anlage',

        ['mission_self_plants_bought'] = 'x Rohmaterial ~s~für ~g~',
        ['mission_self_plants_bought_2'] = '$ ~s~bezahlt.',
        ['mission_self_plants_notEnoughMoney'] = 'Die Ware wird wieder ~r~abgeladen~s~, da du nicht genug Geld hast.',
        ['mission_dou_plants_bought'] = 'x Rohmaterial ~s~wurden von deinem Auftraggeber ~g~bezahlt.',
        ['mission_dou_plants_abort'] = 'Mission von ~b~',
        ['mission_dou_plants_abort_2'] = ' ~s~wurde abgebrochen, da du die Ware nicht bezahlt hast.',
        ['mission_dou_plants_abort_target'] = 'Die Mission wurde ~r~abgebrochen~s~, da die Ware nicht bezahlt wurde.',
        ['mission_dou_plants_arrived'] = 'Die Lieferung über ~g~',
        ['mission_dou_plants_arrived_2'] = ' Pflanzen ist soeben eingetroffen.',
        ['mission_dou_plants_arrived_target'] = 'Ware erfolgreich ~g~eingeladen',

        ['mission_press_e_deliver'] = 'Drücke ~g~E~s~, um die Ware auszuladen',
        ['mission_wrongCar_deliver'] = 'Wo ist denn das Fahrzeug, was beladen wurde?',

        ['mission_invited'] = 'Du wurdest ~g~eingeladen ~s~eine ~b~Beschaffungsmission ~s~durchzuführen. Drücke  ~g~E~s~, um anzunehmen.',
        ['mission_invited_over'] = 'Die Einladung ist ~r~abgelaufen~s~!',

        ['menu_enter_farm'] = 'Farm betreten',
        ['menu_buy_farm'] = 'Farm kaufen',
        ['menu_buy_name'] = 'Name:',
        ['menu_buy_type'] = 'Art:',
        ['menu_buy_price'] = 'Preis:',
        ['menu_buy_confirm'] = 'Kauf bestätigen',

        ['menu_computer_level'] = 'Stufe',
        ['menu_computer_produced'] = 'Fertige Ware',
        ['menu_computer_produced_desc'] = 'Fertig verpackte Ware',
        ['menu_computer_storage'] = 'Vorräte',
        ['menu_computer_storage_desc'] = 'Für die Produktion benötigte Vorräte',
        ['menu_computer_takedrugs'] = 'Wie viel soll entnommen werden?',
        ['menu_computer_notenoughdrugs'] = 'Du hast nicht so viel im Lager!',

        ['menu_storage'] = 'Vorräte besorgen',
        ['menu_storage_input'] = 'Vorräte einlagern',
        ['menu_storage_input_desc'] = 'Lagere bereits beschaffte Vorräte ein',
        ['menu_storage_storageLimit'] = '~s~Du kannst nur noch ~y~',
        ['menu_storage_storageLimit_2'] = ' Vorräte ~s~einlagern!',
        ['menu_storage_notenough'] = '~r~Du hast nicht genügend dabei!',
        ['menu_storage_buy'] = 'Vorräte kaufen',
        ['menu_storage_buy_desc'] = 'Kaufe Vorräte vom Schwarzmarkt',
        ['menu_storage_buy_self'] = 'Vorräte selber besorgen',
        ['menu_storage_buy_others'] = 'Vorräte besorgen lassen',
        ['menu_storage_buy_others_desc'] = 'Beauftrage einen Mitarbeiter, der vor der Tür steht',
        ['menu_storage_inputseeds'] = 'Wie viel soll eingelagert werden?',
        ['storagemission_invite'] = 'Klicke, um ~b~',
        ['storagemission_invite_2'] = ' ~s~anzufragen',

        ['menu_upgrade'] = 'Anlage erweitern',
        ['menu_upgrade_prod'] = 'Anlage verbessern',
        ['menu_upgrade_prod_desc'] = 'Erhöhe die Produktivität und Lagerkapazitäten',
        ['menu_upgrade_prod_level2'] = 'Ausrüstung verbessern',
        ['menu_upgrade_prod_level2_desc'] = 'Steigere Leistung durch eine Verbesserung deiner Ausrüstung: z.B. bessere Lüfter',
        ['menu_upgrade_prod_level3'] = 'Sicherheit verbessern',
        ['menu_upgrade_prod_level3_desc'] = 'Steigere Leistung durch die Verbesserung deiner Überwachung: z.B. Videoaufzeichnung',
        ['menu_upgrade_level2required'] = 'Level 2 benötigt',
        ['upgraded_title'] = 'Verbesserung gekauft',
        ['upgraded'] = 'Das ~y~Level ~s~deiner Anlage wurde auf ~y~',
        ['upgraded_2'] = ' ~s~verbessert. Der Umbau beginnt in Kürze',

        ['menu_stats_finished'] = '~b~Lagerkapazität (Fertige Ware):',
        ['menu_stats_storecap'] = '~b~Vorratskapazität:',
        ['menu_stats_storecap_desc'] = '~s~Verhältnis zum Endprodukt 4:1',
        ['menu_stats_productivity'] = '~b~Produktionsgeschwindigkeit',

        ['menu_changeVehicle'] = 'Beschaffungswagen ändern',
        ['menu_changeVehicle_change'] = 'Klicke, um ~b~',
        ['menu_changeVehicle_change2'] = ' ~s~als Beschaffungsfahrzeug zu verwenden',

        ['menu_access'] = 'Zugänge:',
        ['menu_access_desc'] = 'Verwalte die Zugänge der Mitarbeiter',
        ['menu_access_trust_remove'] = 'Klicke, um ~b~',
        ['menu_access_trust_remove_2'] = ' ~s~den Zugang zu entziehen',
        ['menu_addTrusted'] = 'Zugang freischalten',
        ['menu_access_trust_add'] = 'Klicke, um ~b~',
        ['menu_access_trust_add_2'] = ' ~s~den Zugang zu entziehen',

        ['menu_access_removed'] = ' ~s~wurde der Zugang entzogen.',
        ['menu_access_removed_target'] = 'Dir wurde der Zugang für ~y~Farm (#',
        ['menu_access_removed_target_2'] = ') entzogen.',
        ['menu_access_granted'] = ' ~s~wurde der Zugang freigeschaltet.',
        ['menu_access_granted_target'] = 'Dir wurde der Zugang für ~g~Farm (#',
        ['menu_access_granted_target_2'] = ') erteilt.',

        ['menu_sell'] = 'Farm verkaufen',
        ['menu_sell_confirm'] = 'Farm verkaufen bestätigen',
        ['infobar_seller'] = 'Drücke ~o~E~s~, um mit dem Händler zu sprechen',
        ['items_sold_for'] = '~s~Gegenstände verkauft für ~g~',
        ['you_only_have_items'] = '~y~Das hast nur ~w~',
        ['you_only_have_items2'] = 'x ~y~dabei',
        ['seller_title'] = 'Händler',
        ['input_howmuch'] = 'Wie viel soll verkauft werden?',
        ['menu_sell_desc'] = 'Sell the farm for ~g~',
        ['farm_already_owned'] = '~r~Diese Farm ist nicht mehr verfügbar!',

    }

}