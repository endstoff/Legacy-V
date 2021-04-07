Config = {}
Translation = {}

Config.Debug = true -- when this is activated, you can restart the script
Config.Locale = 'de' -- de or en

Config.useOneSyncInfinity = true

-- Supplies
Config.Supplies = {min = 4, max = 5} -- how many items should be given at a mission
Config.VehicleModifier1 = 5 -- extra supplies through bigger vehicle
Config.VehicleModifier2 = 10 -- extra supplies through bigger vehicle

Config.PricePerPlant = 5

Config.Level2Price = 100000
Config.Level3Price = 150000

Config.useSeller = true -- should the Seller be there
Config.SellerLocation = {x = -874.90997314453, y = -2716.5236816406, z = 14.046569824219, rot = 61.38}
Config.SellerPedModel = "s_m_y_airworker"
Config.showSellerBlip = true

Config.useBlackMoney = false
Config.BlackMoneyName = 'black_money'

Config.SellItems = { -- set up the items here, that your players can sell at the seller - You can set up the items they get in the missions config.

    {sqlitem = 'package', label = 'Verpackte Waren', priceBuy = 250.0},

}

Config.SellDivide = 2 -- old price / SellDivide is the amount the player gets when he sells the Warehouse

Config.UseIPLs = true -- needs bob74_ipl
-- 
Config.StoreCapacity = {

    250,
    350,
    500,

}

-- Finished drugs
Config.FinishCapacity = {

    100,
    200,
    400,

}

-- Produce rate per hour
Config.ProduceRate = {

    30, -- 2/min
    40,
    50,

}

Config.Vehicles = {

    {model = "boxville4", label = 'Boxville', price = 10000},
    {model = "rumpo2", label = 'Rumpo', price = 30000},
    {model = "utillitruck2", label = 'Lastwagen', price = 60000},

}

Config.WeedItem = 'package' -- name of the final drug item
Config.MethItem = 'package'
Config.CokeItem = 'package'

Config.Warehouses = { 
    
    {id = 1, type = "wares", name = "GWeed", label = "PostOp", price = 50000, enter = {x = 1197.23046875, y = -3253.5908203125, z = 7.0951871871948}, inside = {x = 1105.0660400391, y = -3099.5134277344, z = -38.999969482422, rot = 91.45}, bossActions = {x = 1088.3814697266, y = -3101.2524414062, z = -38.999961853027}, spawnVehicle = {x = 1188.2104492188, y = -3249.66015625, z = 6.0287680625916, rot = 85.6}}, 
    {id = 2, type = "wares", name = "PMeth", label = "AlphaMail", price = 50000, enter = {x = 1240.1387939453, y = -3322.1625976562, z = 6.0287656784058}, inside = {x = 1048.1350097656, y = -3097.1049804688, z = -38.999954223633, rot = 265.96}, bossActions = {x = 1048.9520263672, y = -3100.5483398438, z = -38.999954223633}, spawnVehicle = {x = 1247.3115234375, y = -3327.7487792969, z = 6.0287637710571, rot = 268.65}}, 
    {id = 3, type = "wares", name = "GCoke", label = "ThriftEx", price = 50000, enter = {x = 1181.8558349609, y = -3113.8583984375, z = 6.0281319618225}, inside = {x = 992.578125, y = -3097.8046875, z = -38.995872497559, rot = 270.32}, bossActions = {x = 994.62921142578, y = -3100.0517578125, z = -38.995861053467}, spawnVehicle = {x = 1177.5438232422, y = -3105.4348144531, z = 6.0280222892761, rot = 91.52}}, 
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
        ['enter_Warehouse'] = 'Press ~g~E~s~, to enter ~o~',
        ['enter_Warehouse_2'] = '~s~.',
        ['leave_Warehouse'] = 'Press ~g~E~s~, to leave the Warehouse',

        ['nothing_produced'] = '~y~Nothing could be produced in your absence as there are no supplies.',
        ['successfully_produced'] = '~g~During your absence, ~w~',
        ['successfully_produced_2'] = '~g~were produced.',
        ['successfully_produced_3'] = ' ~g~produced.',
        ['successfully_produced_storageEmpty'] = ' ~g~produced. Supplies are empty!',

        ['get_from_storage'] = '~s~ taken from the Warehouse.',
        ['Warehouse_bought_title'] = 'Warehouse bought',
        ['Warehouse_bought'] = 'Well! ~g~',
        ['Warehouse_bought_2'] = ' ~s~is now yours. Good choice!',

        ['wares'] = '~g~wares',
        ['wares'] = '~b~wares',
        ['wares'] = '~w~wares',

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
        ['mission_backToWarehouse'] = 'Drive back to your Warehouse!',

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

        ['menu_enter_Warehouse'] = 'Enter the Warehouse',
        ['menu_buy_Warehouse'] = 'Buy the Warehouse',
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
        ['menu_storage_buy_others_desc'] = 'The person have to stay next to the Warehouse entrance',
        ['menu_storage_inputseeds'] = 'How much should be stored?',
        ['storagemission_invite'] = 'Click to ask ~b~',
        ['storagemission_invite_2'] = '~s~',

        ['menu_upgrade'] = 'Upgrade Warehouse',
        ['menu_upgrade_prod'] = 'Improve Warehouse',
        ['menu_upgrade_prod_desc'] = 'Increase productivity and storage',
        ['menu_upgrade_prod_level2'] = 'Improve equipment',
        ['menu_upgrade_prod_level2_desc'] = 'Increase performance by improving your equipment: e.g. better fans',
        ['menu_upgrade_prod_level3'] = 'Improve security',
        ['menu_upgrade_prod_level3_desc'] = 'Increase performance by improving your monitoring: e.g. Video recording',
        ['menu_upgrade_level2required'] = 'Level 2 required',
        ['upgraded_title'] = 'Buy upgrade',
        ['upgraded'] = 'The ~y~level ~s~of your Warehouse was upgraded to ~y~',
        ['upgraded_2'] = ' ~s~. Reenter the Warehouse to see the progress.',

        ['menu_stats_finished'] = '~b~Storage capacity (finished drugs):',
        ['menu_stats_storecap'] = '~b~Storage capacity (supplies):',
        ['menu_stats_storecap_desc'] = '~s~4x supplies = 1x drug',
        ['menu_stats_productivity'] = '~b~Production speed',

        ['menu_changeVehicle'] = 'Change mission vehicle',
        ['menu_changeVehicle_change'] = 'Click to select ~b~',
        ['menu_changeVehicle_change2'] = ' ~s~as your mission vehicle',

        ['menu_access'] = 'Key cards',
        ['menu_access_desc'] = 'Set up who have access to the Warehouse',
        ['menu_access_trust_remove'] = 'Click to revoke ~b~',
        ['menu_access_trust_remove_2'] = ' ~s~s access',
        ['menu_addTrusted'] = '~g~Grant access',
        ['menu_access_trust_add'] = 'Click to grant ~b~',
        ['menu_access_trust_add_2'] = ' ~s~access',

        ['menu_access_removed'] = ' ~s~s access was revoked.',
        ['menu_access_removed_target'] = 'You access for ~y~Warehouse (#',
        ['menu_access_removed_target_2'] = ') was revoked.',
        ['menu_access_granted'] = ' ~s~s access was granted.',
        ['menu_access_granted_target'] = 'You now have access to ~g~Warehouse (#',
        ['menu_access_granted_target_2'] = ')',

        ['menu_sell'] = 'Sell Warehouse',
        ['menu_sell_confirm'] = 'Confirm selling Warehouse',
        ['infobar_seller'] = 'Press ~o~E~s~, to talk with the seller',
        ['items_sold_for'] = '~s~Items sold for ~g~',
        ['you_only_have_items'] = '~y~You only have ~w~',
        ['you_only_have_items2'] = 'x ~y~with you',
        ['seller_title'] = 'Seller',
        ['input_howmuch'] = 'How much should be sold?',
        ['menu_sell_desc'] = 'Sell the Warehouse for ~g~',

    },

    ['de'] = {
        ['access_computer'] = 'Drücke ~g~E~s~, um auf den Computer zuzugreifen',
        ['enter_Warehouse'] = 'Drücke ~g~E~s~, um ~o~',
        ['enter_Warehouse_2'] = '~s~ zu betreten',
        ['leave-Warehouse'] = 'Drücke ~g~E~s~, um das Warenhaus zu verlassen',

        ['nothing_produced'] = '~y~Während deiner Abwesenheit konnte nichts verpackt werden, da keine Waren vorhanden sind.',
        ['successfully_produced'] = '~g~Während du weg warst, wurden ~w~',
        ['successfully_produced_2'] = '~g~verpackt.',
        ['successfully_produced_3'] = ' ~g~fertiggestellt.',
        ['successfully_produced_storageEmpty'] = ' ~g~abgepackt. Dein Lager ist leer!',

        ['get_from_storage'] = '~s~ aus dem Lager entnommen.',
        ['Warehouse_bought_title'] = 'Warenhaus gekauft',
        ['Warehouse_bought'] = 'Dann ist das ~g~',
        ['Warehouse_bought_2'] = ' ~s~wohl ab Sofort deins..gute Wahl!',

        ['wares'] = '~g~Pakete',
        ['wares'] = '~b~Pakete',
        ['wares'] = '~w~Pakete',

        ['supplies'] = 'Waren',
        ['already_started_mission'] = '~r~Du hast bereits eine Order gestartet!',
        ['notEnoughMoney'] = '~r~Du hast nicht genügend Geld!',

        ['mission_car_changed'] = 'Dein neues Fahrzeug ~y~',
        ['mission_car_changed_2'] = ' ~s~wird umgehend geliefert.',
        ['mission_startLoading'] = 'Hee! Du musst hier sein, um die Waren abzuholen. Wir beginnen mit dem Beladen.',
        ['mission_seller'] = 'Spediteur',
        ['mission_outofrange'] = '~y~Das Fahrzeug konnte nicht vollständig beladen werden. Kehre zurück zum Versender!',
        ['mission_loading'] = 'Fahrzeug wird beladen: \n~g~',
        ['mission_loading_2'] = '% ~s~abgeschlossen.',
        ['mission_wrongCar'] = 'In das Fahrzeug bekommen wir die Ware aber nicht rein..',
        ['mission_backToWarehouse'] = 'Fahre nun zurück zur Anlage',

        ['mission_self_plants_bought'] = 'x Waren ~s~für ~g~',
        ['mission_self_plants_bought_2'] = '$ ~s~bezahlt.',
        ['mission_self_plants_notEnoughMoney'] = 'Die Ware wird wieder ~r~abgeladen~s~, da du nicht genug Geld hast.',
        ['mission_dou_plants_bought'] = 'x Waren ~s~wurden von deinem Auftraggeber ~g~bezahlt.',
        ['mission_dou_plants_abort'] = 'Mission von ~b~',
        ['mission_dou_plants_abort_2'] = ' ~s~wurde abgebrochen, da du die Ware nicht bezahlt hast.',
        ['mission_dou_plants_abort_target'] = 'Die Mission wurde ~r~abgebrochen~s~, da die Ware nicht bezahlt wurde.',
        ['mission_dou_plants_arrived'] = 'Die Lieferung über ~g~',
        ['mission_dou_plants_arrived_2'] = ' Waren ist soeben eingetroffen.',
        ['mission_dou_plants_arrived_target'] = 'Ware erfolgreich ~g~eingeladen',

        ['mission_press_e_deliver'] = 'Drücke ~g~E~s~, um die Ware auszuladen',
        ['mission_wrongCar_deliver'] = 'Wo ist denn das Fahrzeug, was beladen wurde?',

        ['mission_invited'] = 'Du wurdest ~g~eingeladen ~s~eine ~b~Lieferung ~s~durchzuführen. Drücke  ~g~E~s~, um anzunehmen.',
        ['mission_invited_over'] = 'Die Einladung ist ~r~abgelaufen~s~!',

        ['menu_enter_Warehouse'] = 'Warenhaus betreten',
        ['menu_buy_Warehouse'] = 'Warenhaus kaufen',
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

        ['menu_storage'] = 'Ware bestellen',
        ['menu_storage_input'] = 'Waren einlagern',
        ['menu_storage_input_desc'] = 'Lagere bereits beschaffte Waren ein',
        ['menu_storage_storageLimit'] = '~s~Du kannst nur noch ~y~',
        ['menu_storage_storageLimit_2'] = ' Waren ~s~einlagern!',
        ['menu_storage_notenough'] = '~r~Du hast nicht genügend dabei!',
        ['menu_storage_buy'] = 'Waren kaufen',
        ['menu_storage_buy_desc'] = 'Kaufe Waren vom Spediteur',
        ['menu_storage_buy_self'] = 'Waren selber abholen',
        ['menu_storage_buy_others'] = 'Waren liefern lassen',
        ['menu_storage_buy_others_desc'] = 'Beauftrage einen Mitarbeiter, der vor der Tür steht',
        ['menu_storage_inputseeds'] = 'Wie viel soll eingelagert werden?',
        ['storagemission_invite'] = 'Klicke, um ~b~',
        ['storagemission_invite_2'] = ' ~s~anzufragen',

        ['menu_upgrade'] = 'Warenhaus erweitern',
        ['menu_upgrade_prod'] = 'Warenhaus verbessern',
        ['menu_upgrade_prod_desc'] = 'Erhöhe die Produktivität und Lagerkapazitäten',
        ['menu_upgrade_prod_level2'] = 'Ausrüstung verbessern',
        ['menu_upgrade_prod_level2_desc'] = 'Steigere Leistung durch eine Verbesserung deiner Ausrüstung: z.B. bessere Maschinen',
        ['menu_upgrade_prod_level3'] = 'Sicherheit verbessern',
        ['menu_upgrade_prod_level3_desc'] = 'Steigere Leistung durch die Verbesserung deiner Überwachung: z.B. Videoaufzeichnung',
        ['menu_upgrade_level2required'] = 'Level 2 benötigt',
        ['upgraded_title'] = 'Verbesserung gekauft',
        ['upgraded'] = 'Das ~y~Level ~s~deiner Anlage wurde auf ~y~',
        ['upgraded_2'] = ' ~s~verbessert. Der Umbau beginnt in Kürze',

        ['menu_stats_finished'] = '~b~Lagerkapazität (Fertige Pakete):',
        ['menu_stats_storecap'] = '~b~Vorratskapazität:',
        ['menu_stats_storecap_desc'] = '~s~Verhältnis zum Endprodukt 4:1',
        ['menu_stats_productivity'] = '~b~Produktionsgeschwindigkeit',

        ['menu_changeVehicle'] = 'Lieferwagen ändern',
        ['menu_changeVehicle_change'] = 'Klicke, um ~b~',
        ['menu_changeVehicle_change2'] = ' ~s~als Lieferwagen zu verwenden',

        ['menu_access'] = 'Zugänge:',
        ['menu_access_desc'] = 'Verwalte die Zugänge der Mitarbeiter',
        ['menu_access_trust_remove'] = 'Klicke, um ~b~',
        ['menu_access_trust_remove_2'] = ' ~s~den Zugang zu entziehen',
        ['menu_addTrusted'] = 'Zugang freischalten',
        ['menu_access_trust_add'] = 'Klicke, um ~b~',
        ['menu_access_trust_add_2'] = ' ~s~den Zugang zu entziehen',

        ['menu_access_removed'] = ' ~s~wurde der Zugang entzogen.',
        ['menu_access_removed_target'] = 'Dir wurde der Zugang für ~y~Warehouse (#',
        ['menu_access_removed_target_2'] = ') entzogen.',
        ['menu_access_granted'] = ' ~s~wurde der Zugang freigeschaltet.',
        ['menu_access_granted_target'] = 'Dir wurde der Zugang für ~g~Warehouse (#',
        ['menu_access_granted_target_2'] = ') erteilt.',

        ['menu_sell'] = 'Warenhaus verkaufen',
        ['menu_sell_confirm'] = 'Warenhaus verkauf bestätigen',
        ['infobar_seller'] = 'Drücke ~o~E~s~, um mit dem Abnehmer zu sprechen',
        ['items_sold_for'] = '~s~Pakete verkauft für ~g~',
        ['you_only_have_items'] = '~y~Das hast nur ~w~',
        ['you_only_have_items2'] = 'x ~y~dabei',
        ['seller_title'] = 'Abnehmer',
        ['input_howmuch'] = 'Wie viel soll verkauft werden?',
        ['menu_sell_desc'] = 'Sell the Warehouse for ~g~',

    }

}