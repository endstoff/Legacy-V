local Keys = {
    ["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
    ["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
    ["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
    ["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
    ["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
    ["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
    ["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
    ["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
    ["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}


ESX = nil
local PlayerData = {}

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end

    while ESX.GetPlayerData().job == nil do
        Citizen.Wait(10)
    end

    PlayerData = ESX.GetPlayerData()
end)

local garages = {

    {vector3(-1519.98, 80.26, 56.73), vector3(-1531.92, 83.11, 56.74), 323.64 },
    {vector3(100.97, -1073.49, 29.37), vector3(117.73, -1081.17, 29.22), 0.01 },
    {vector3(213.59, -809.34, 31.01), vector3(232.98, -790.3, 30.6), 161.46 },
    {vector3(-899.275, -153.0, 41.88), vector3(-901.989, -159.28, 41.46), 204.0},
    {vector3(275.182, -345.534, 45.173), vector3(266.498, -332.475, 43.43), 251.0},
    {vector3(-833.255, -2351.34, 14.57), vector3(-823.68, -2342.975, 13.803), 147.0},
    {vector3(721.95, -2016.379, 29.43), vector3(728.567, -2033.28, 28.87), 354.0},
    {vector3(-2162.82, -377.15,13.28), vector3(-2169.21, -372.25, 13.08), 158.18},
    {vector3(-400.74, 1209.87, 325.92), vector3(-406.82, 1207.15, 325.664), 167.65},
    {vector3(112.23, 6619.66, 31.82), vector3(115.81,6599.34, 32.01), 265.81},
    {vector3(2768.34, 3462.92, 55.63), vector3(2772.88, 3472.32, 55.46), 241.84},
    {vector3(1951.79, 3750.95, 32.16), vector3(1949.57, 3759.33, 32.21), 34.16},
    {vector3(1899.46, 2605.26, 45.97), vector3(1875.88, 2595.20, 45.67), 267.31},
    {vector3(889.24, -53.87, 78.91), vector3(886.12, -62.68, 78.76), 236.43},
    {vector3(-1184.85, -1510.05, 4.65), vector3(-1183.01, -1495.34, 4.38), 125.56},
    {vector3(362.28, 298.39, 103.88), vector3(377.9, 288.46, 103.17), 71.04},
    {vector3(2434.69, 5011.78, 64.84), vector3(2451.71, 5033.78, 54.91), 225.04},
    {vector3(-73.28, -1835.79, 26.94), vector3(-60.76, -1834.67, 26.75), 234.56},
    {vector3(1036.67, -763.43, 57.99), vector3(1020.1, -766.99, 57.93), 323.98},
    {vector3(1366.22, -1833.79, 57.92), vector3(1359.46, -1849.11, 57.23), 5.91},
    {vector3(-316.38, -2748.19, 6), vector3(-335.81, -2738.82, 6.03), 5.91},
    {vector3(-73.04, 909.85, 235.63), vector3(-68.1, 897.9, 235.56), 111.54},
    {vector3(-1928.43, 2060.01, 140.84), vector3(-1919.91, 2057.23, 140.74), 260.28},
    {vector3(2763, 1346.56, 24.52), vector3(2732.62, 1329.28, 24.52), 3.22},
    {vector3(570.24, 2797.07, 42.01), vector3(588.78, 2791.1, 42.16), 359.84},
    {vector3(-945.09, 312.55, 71.35), vector3(-939.29, 294.72, 70.7), 261.51},
    {vector3(-1380.3, 735.68, 182.97), vector3(-1399.03, 738.99, 183.06), 67.58},
    {vector3(162.92, -680.19, 33.12), vector3(154.85, -692.05, 33.13), 160.41}





}

local coordinate = {
    { -1519.98, 80.26, 56.73, nil, 21.85, nil, -100858228},
    { 213.59, -809.34, 31.01, nil, 0.0, nil, -1176698112},
    { -899.275, -153.0, 41.88, nil, 121.86, nil, 436345731},
    { 275.182, -345.534, 45.173, nil, 0.0, nil, 216536661},
    { -833.255, -2351.34, 14.57, nil, 284.43, nil, -1549575121},
    { 721.95, -2016.379, 29.43, nil, 264.04, nil, 131961260},
    { -2162.82, -377.15,13.28, nil, 165.99, nil, 377976310},
    { -400.74, 1209.87, 325.92, nil, 178.25, nil, 1641152947},
    { 112.23, 6619.66, 31.82, nil, 237.14, nil, 331645324},
    { 2768.34, 3462.92, 55.63, nil, 241.17, nil, -1519253631},
    { 1951.79, 3750.95, 32.16, nil, 118.06, nil, 1169888870},
    { 1899.46, 2605.26, 45.97, nil, 266.95, nil, 1096929346},
    { 889.24, -53.87, 78.91, nil, 0.0, nil, 1822107721},
    { -1184.85, -1510.05, 4.65, nil, 300.03, nil, -995747907},
    { 362.28, 298.39, 103.88, nil, 249.97, nil, 436345731},
    { 2435.68, 5012.13, 46.87, nil, 309.63, nil, -1806291497},
    { -73.28, -1835.79, 26.94, nil, 317.45, nil, -449965460},
    { 1036.67, -763.43, 57.99, nil, 240.62, nil, -929103484},
    { 1366.22, -1833.79, 57.92, nil, 98.89, nil, 68070371},
    { -316.38, -2748.19, 6, nil, 39.39, nil, 436345731},
    { -73.04, 909.85, 235.63, nil, 207.55, nil, 2093736314},
    { -1928.43, 2060.01, 140.84, nil, 347.41, nil, -1217776881},
    { 2763, 1346.56, 24.52, nil, 92.62, nil, -72125238},
    { 570.24, 2797.07, 42.01, nil, 278.44, nil, 1380197501},
    { -945.09, 312.55, 71.35, nil, 180.36, nil, 1380197501},
    { -1380.3, 735.68, 182.97, nil, 350.69, nil, 1464257942},
    { 162.92, -680.19, 33.12, nil, 156.96, nil, 1558115333},
    {100.97, -1073.49, 29.37, nil, 73.88, nil, -1806291497}  
}



local ImpoundBlip = {
    {title="Abschlepper", colour=5, id=477, x = 408.61, y = -1625.47, z = 28.29},
    {title="Abschlepper", colour=5, id=477, x = 1651.38, y = 3804.84, z = 37.65},               --https://docs.fivem.net/docs/game-references/blips/
    {title="Abschlepper", colour=5, id=477, x = -234.82, y = 6198.65, z = 30.94}
}


Citizen.CreateThread(function()

    for _,v in pairs(coordinate) do
      RequestModel(v[7])
      while not HasModelLoaded(v[7]) do
        Wait(1)
      end
  

      ped =  CreatePed(4, v[7],v[1],v[2],v[3]-1, 3374176, false, true)
      SetEntityHeading(ped, v[5])
      FreezeEntityPosition(ped, true)
	  SetEntityInvincible(ped, true)

      SetBlockingOfNonTemporaryEvents(ped, true)
	end

end)

local enableField = false

function AddCar(plate, model)
    print("AddCar")
    SendNUIMessage({
        action = 'add',
        plate = plate,
        model = model
    }) 
end

function toggleField(enable)
    SetNuiFocus(enable, enable)
    enableField = enable

    if enable then
        SendNUIMessage({
            action = 'open'
        }) 
    else
        SendNUIMessage({
            action = 'close'
        }) 
    end
end

AddEventHandler('onResourceStart', function(name)
    if GetCurrentResourceName() ~= name then
        return
    end

    toggleField(false)
end)

RegisterNUICallback('escape', function(data, cb)
    toggleField(false)
    SetNuiFocus(false, false)

    cb('ok')
end)

RegisterNUICallback('enable-parkout', function(data, cb)
    


    	ESX.TriggerServerCallback('est_garage:loadVehicles', function(ownedCars)
		if #ownedCars == 0 then
			ESX.ShowNotification("Du hast keine Fahrzeuge")
        else
            print(ownedCars)
            for _,v in pairs(ownedCars) do
            local hashVehicule = v.vehicle.model
			local aheadVehName = GetDisplayNameFromVehicleModel(hashVehicule)
			local vehicleName = GetLabelText(aheadVehName)
            local plate = v.plate
            AddCar(plate, vehicleName)
            end
        end
    end)

    cb('ok')
end)

RegisterNUICallback('enable-parking', function(data, cb)
    local vehicles = ESX.Game.GetVehiclesInArea(GetEntityCoords(GetPlayerPed(-1)), 25.0)

    for key, value in pairs(vehicles) do
        ESX.TriggerServerCallback('est_garage:isOwned', function(owned)
		
		print(GetVehicleNumberPlateText(value))

			if owned then
				print("Ja ist owned")
                AddCar(GetVehicleNumberPlateText(value), GetDisplayNameFromVehicleModel(GetEntityModel(value)))
            else
				print("Ist nicht deins")

            end
    
        end, GetVehicleNumberPlateText(value))
    end
    
    cb('ok')
end) 

local usedGarage

RegisterNUICallback('park-out', function(data, cb)
    
    ESX.TriggerServerCallback('est_garage:loadVehicle', function(vehicle)
        local x,y,z = table.unpack(garages[usedGarage][2])
        local props = json.decode(vehicle[1].vehicle)

        ESX.Game.SpawnVehicle(props.model, {
            x = x,
            y = y,
            z = z + 1
        }, garages[usedGarage][3], function(callback_vehicle)
            ESX.Game.SetVehicleProperties(callback_vehicle, props)
            SetVehRadioStation(callback_vehicle, "OFF")
            TaskWarpPedIntoVehicle(GetPlayerPed(-1), callback_vehicle, -1)
        end)

    end, data.plate)

    TriggerServerEvent('est_garage:changeState', data.plate, 0)
    
    cb('ok')
end)

RegisterNUICallback('park-in', function(data, cb)
    
    local vehicles = ESX.Game.GetVehiclesInArea(GetEntityCoords(GetPlayerPed(-1)), 25.0)

    for key, value in pairs(vehicles) do
        if GetVehicleNumberPlateText(value) == data.plate then
            TriggerServerEvent('est_garage:saveProps', data.plate, ESX.Game.GetVehicleProperties(value))
            TriggerServerEvent('est_garage:changeState', data.plate, 1)
            ESX.Game.DeleteVehicle(value)
        end
    end

    cb('ok')
end)

Citizen.CreateThread(function()
    while true do
        Wait(0)
        for key, value in pairs(garages) do
            DrawMarker(-1, value[1], 0.0, 0.0, 0.0, 0, 0.0, 0.0, 1.0, 1.0, 1.0, 255, 0, 0, 100, false, true, 2, true, false, false, false)
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        Wait(0)

        for key, value in pairs(garages) do
            local dist = GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), value[1])

            if dist <= 2.0 then
                ESX.ShowHelpNotification("Drücke ~INPUT_CONTEXT~ um auf die Garage zuzugreifen")

                if IsControlJustReleased(0, 38) then
                    toggleField(true)
                    usedGarage = key
                end
            end
        end
    end
end)

Citizen.CreateThread(function()
    for _, coords in pairs(garages) do
        local blip = AddBlipForCoord(coords[1])

        SetBlipSprite(blip, 473)
        SetBlipScale(blip, 0.9)
        SetBlipColour(blip, 0)
        SetBlipDisplay(blip, 4)
        SetBlipAsShortRange(blip, true)

        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString("Garage")
        EndTextCommandSetBlipName(blip)
    end
end)


Citizen.CreateThread(function()

    for _, info in pairs(ImpoundBlip) do
      info.blip = AddBlipForCoord(info.x, info.y, info.z)
      SetBlipSprite(info.blip, info.id)
      SetBlipDisplay(info.blip, 4)
      SetBlipScale(info.blip, 1.0)
      SetBlipColour(info.blip, info.colour)
      SetBlipAsShortRange(info.blip, true)
	  BeginTextCommandSetBlipName("STRING")
      AddTextComponentString(info.title)
      EndTextCommandSetBlipName(info.blip)
    end
end)


-- Abschlepperhauptmenu


function OpenMenuGarage(PointType)
    ESX.UI.Menu.CloseAll()
    
    local elements = {}

        table.insert(elements, {label = 'Hole dein Auto ab. Es kostet'.." ($"..Config.AbschleppPreis..")", value = 'return_owned_cars'})

    
    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'garage_menu', {
        title    = 'Abschlepper',
        align    = Config.AlignMenu,
        elements = elements
    }, function(data, menu)
        menu.close()
        local action = data.current.value
        if action == 'return_owned_cars' then
            ReturnOwnedCarsMenu()
        end

        
    end, function (data, menu)
        menu.close()
    end)
end


-- Abschlepperfahrzeugmenu


function ReturnOwnedCarsMenu()
	ESX.TriggerServerCallback('abschlepper:getOutOwnedCars', function(ownedCars)
		local elements = {

		}
		
		for _,v in pairs(ownedCars) do
			if Config.FahrzeugLuaName == true then
				local hashVehicule = v.model
				local aheadVehName = GetDisplayNameFromVehicleModel(hashVehicule)
				local vehicleName  = GetLabelText(aheadVehName)
				local labelvehicle
				local plate = v.plate
				
				labelvehicle = ' '..plate..' | '..vehicleName..' | Zurückholen'
				
				table.insert(elements, {label = labelvehicle, value = v})
			else
				local hashVehicule = v.model
				local vehicleName = GetDisplayNameFromVehicleModel(hashVehicule)
				local labelvehicle 
				local plate = v.plate
				
				labelvehicle = ' '..plate..' | '..vehicleName..' | Zurückholen'
				
				table.insert(elements, {label = labelvehicle, value = v})
			end
		end
		
		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'return_owned_car', {
			title    = 'Abschlepper',
			align    = Config.AlignMenu,
			elements = elements
		}, function(data, menu)
			ESX.TriggerServerCallback('abschlepper:checkMoneyCars', function(hasEnoughMoney)
				if hasEnoughMoney then
					TriggerServerEvent('abschlepper:payCar')
					SpawnPoundedVehicle(data.current.value, data.current.value.plate)
				else
					ESX.ShowNotification('Du hast zu wenig Geld! Weder auf deinem Konto noch Bar hast du genug Geld.')
				end
			end)
		end, function(data, menu)
			menu.close()
		end)
	end)
end




-- Abschleppermarker betreten


AddEventHandler('abschlepper:hasEnteredMarker', function(zone)
	if zone == 'car_pound_point' then
		CurrentAction     = 'car_pound_point'
		CurrentActionMsg  = 'Drücke ~INPUT_PICKUP~ um auf den Abschlepper zuzugreifen.'
		CurrentActionData = {}
	end
end)


-- Abschleppermarker verlassen

AddEventHandler('abschlepper:hasExitedMarker', function()
	ESX.UI.Menu.CloseAll()
	CurrentAction = nil
end)


-- Abschleppermarker erstellen


Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
        
        local playerPed = PlayerPedId()
		local coords    = GetEntityCoords(playerPed)

		for k,v in pairs(Config.CarPounds) do
			if (GetDistanceBetweenCoords(coords, v.AbschleppPunkt.x, v.AbschleppPunkt.y, v.AbschleppPunkt.z, true) < 200.0) then
				DrawMarker(Config.MarkerType, v.AbschleppPunkt.x, v.AbschleppPunkt.y, v.AbschleppPunkt.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, Config.AbschlepperMarker.x, Config.AbschlepperMarker.y, Config.AbschlepperMarker.z, Config.AbschlepperMarker.r, Config.AbschlepperMarker.g, Config.AbschlepperMarker.b, 100, false, true, 2, false, false, false, false)
			end
        end
        

	end
end)


-- Abschlepperhauptmenu aktivieren wenn man im Marker ist


Citizen.CreateThread(function()
	while true do
		Citizen.Wait(5)
		
		local playerPed  = PlayerPedId()
		local coords     = GetEntityCoords(playerPed)
		local isInMarker = false

		for k,v in pairs(Config.CarPounds) do
			if (GetDistanceBetweenCoords(coords, v.AbschleppPunkt.x, v.AbschleppPunkt.y, v.AbschleppPunkt.z, true) < Config.AbschlepperMarker.x) then
				isInMarker  = true
				this_Garage = v
				currentZone = 'car_pound_point'
			end
		end

		if isInMarker and not hasAlreadyEnteredMarker then
		hasAlreadyEnteredMarker = true
		LastZone                = currentZone
		TriggerEvent('abschlepper:hasEnteredMarker', currentZone)
		end
		
		if not isInMarker and hasAlreadyEnteredMarker then
			hasAlreadyEnteredMarker = false
			TriggerEvent('abschlepper:hasExitedMarker', LastZone)
		end	
			
	end
end)


-- Abschlepper Keybind


Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		
		if CurrentAction ~= nil then
			ESX.ShowHelpNotification(CurrentActionMsg)
			
			if IsControlJustReleased(0, Keys['E']) then

				if CurrentAction == 'car_pound_point' then
					OpenMenuGarage('car_pound_point')
				end

				
				CurrentAction = nil
			end
		else
			Citizen.Wait(500)
		end
	end
end)


-- Abschlepper Fahrzeug spawnen


function SpawnPoundedVehicle(vehicle, plate)
	ESX.Game.SpawnVehicle(vehicle.model, {
		x = this_Garage.SpawnPunkt.x,
		y = this_Garage.SpawnPunkt.y,
		z = this_Garage.SpawnPunkt.z + 1
	}, this_Garage.SpawnPunkt.h, function(callback_vehicle)
		ESX.Game.SetVehicleProperties(callback_vehicle, vehicle)
		SetVehRadioStation(callback_vehicle, "OFF")
		TaskWarpPedIntoVehicle(GetPlayerPed(-1), callback_vehicle, -1)
	end)
end