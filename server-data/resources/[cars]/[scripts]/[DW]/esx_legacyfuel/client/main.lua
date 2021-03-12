models = {
	[1] = -2007231801,
	[2] = 1339433404,
	[3] = 1694452750,
	[4] = 1933174915,
	[5] = -462817101,
	[6] = -469694731,
	[7] = -164877493,
	[8] = -3224324
}

local gas_stations = {
	{ ['x'] = 45.95, ['y'] = 2788.36, ['z'] = 56.88, ['stationID'] = 1 },
 	{ ['x'] = 265.59,   ['y'] = 2599.37,  ['z'] = 43.76, ['stationID'] = 2 },
 	{ ['x'] = 1039.35,  ['y'] = 2664.53,  ['z'] = 38.55, ['stationID'] = 3 },
 	{ ['x'] = 1201.2,  ['y'] = 2656.27,  ['z'] = 36.85, ['stationID'] = 4 },
 	{ ['x'] = 2544.05,  ['y'] = 2591.53,  ['z'] = 36.94, ['stationID'] = 5 },
 	{ ['x'] = 2674.59,  ['y'] = 3266.78,  ['z'] = 54.24, ['stationID'] = 6 },
 	{ ['x'] = 2002.01,  ['y'] = 3779.01,  ['z'] = 31.18, ['stationID'] = 7 },
 	{ ['x'] = 1702.29,  ['y'] = 4916.45,  ['z'] = 41.08, ['stationID'] = 8 },
 	{ ['x'] = 1705.74,  ['y'] = 6425.06,  ['z'] = 31.76, ['stationID'] = 9 },
 	{ ['x'] = 150.28,   ['y'] = 6647.67,  ['z'] = 30.61, ['stationID'] = 10 },
 	{ ['x'] = -93.48,  ['y'] = 6410.69,  ['z'] = 30.64, ['stationID'] = 11 },
 	{ ['x'] = -2554.14, ['y'] = 2316.92,  ['z'] = 32.22, ['stationID'] = 12 },
 	{ ['x'] = -1829.57, ['y'] = 801.64,  ['z'] = 137.42, ['stationID'] = 13 },
 	{ ['x'] = -1429.01, ['y'] = -269.22,  ['z'] = 45.21, ['stationID'] = 14 },
 	{ ['x'] = -2074.57, ['y'] = -327.24,  ['z'] = 12.32, ['stationID'] = 15 },
 	{ ['x'] = -702.619, ['y'] = -917.87,  ['z'] = 18.21, ['stationID'] = 16 },
 	{ ['x'] = -531.12, ['y'] = -1220.38,  ['z'] = 17.45, ['stationID'] = 17 },
 	{ ['x'] = -40.59, ['y'] = -1747.49,  ['z'] = 28.3, ['stationID'] = 18 },
 	{ ['x'] = 288.27,  ['y'] = -1266.96,  ['z'] = 28.44, ['stationID'] = 19 },
 	{ ['x'] = 1211.16, ['y'] =  -1389.58, ['z'] = 34.38, ['stationID'] = 20 },
 	{ ['x'] = 1160.59, ['y'] =  -311.23,  ['z'] = 68.28, ['stationID'] = 21 },
 	{ ['x'] = 641.49,  ['y'] =  260.88,  ['z'] = 102.3, ['stationID'] = 22 },
 	{ ['x'] = 2560.41, ['y'] = 373.7, ['z'] = 107.62, ['stationID'] = 23 },
 	{ ['x'] = -341.74, ['y'] = -1475.11, ['z'] = 29.85, ['stationID'] = 24 },
	{ ['x'] = 167.27, ['y'] = -1553.58, ['z'] = 28.26, ['stationID'] = 25 },
}

local refuel_stations = {
	{ ['x'] = 61.57,  ['y'] = 2793.83,  ['z'] = 56.88, ['stationID'] = 1 },
	{ ['x'] = 260.68,  ['y'] = 2582.37,  ['z'] = 43.88, ['stationID'] = 2 },
	{ ['x'] = 1041.41,  ['y'] = 2651.52,  ['z'] = 38.55, ['stationID'] = 3 },
	{ ['x'] = 1197.6,  ['y'] = 2643.16,  ['z'] = 36.84, ['stationID'] = 4 },
 	{ ['x'] = 2548.31,  ['y'] = 2581.4,  ['z'] = 36.94, ['stationID'] = 5 },
	{ ['x'] = 2662.2,  ['y'] = 3272.57,  ['z'] = 54.24, ['stationID'] = 6 },
	{ ['x'] = 2004.48,  ['y'] = 3791.09,  ['z'] = 31.18, ['stationID'] = 7 },
	{ ['x'] = 1710.77,  ['y'] = 4929.59,  ['z'] = 41.08, ['stationID'] = 8 },
	{ ['x'] = 1695.05,  ['y'] = 6430.31,  ['z'] = 31.66, ['stationID'] = 9 },
	{ ['x'] = 156.61,  ['y'] = 6657.92,  ['z'] = 30.52, ['stationID'] = 10 },
	{ ['x'] = -79.75,  ['y'] = 6415.7,  ['z'] = 30.64, ['stationID'] = 11 },
	{ ['x'] = -2566.25,  ['y'] = 2307.02,  ['z'] = 32.22, ['stationID'] = 12 },
	{ ['x'] = -1823.94,  ['y'] = 802.43,  ['z'] = 137.41, ['stationID'] = 13 },
	{ ['x'] = -1436.08,  ['y'] = -259.96,  ['z'] = 45.26, ['stationID'] = 14 },
	{ ['x'] = -2066.68,  ['y'] = -311.87,  ['z'] = 12.23, ['stationID'] = 15 },
	{ ['x'] = -699.05,  ['y'] = -917.78,  ['z'] = 18.02, ['stationID'] = 16 },
	{ ['x'] = -524.43,  ['y'] = -1230.14,  ['z'] = 17.45, ['stationID'] = 17 },
	{ ['x'] = -43.36,  ['y'] = -1744.95,  ['z'] = 28.31, ['stationID'] = 18 },
	{ ['x'] = 294.2,  ['y'] = -1251.56,  ['z'] = 28.39, ['stationID'] = 19 },
	{ ['x'] = 1203.53,  ['y'] = -386.02,  ['z'] = 34.23, ['stationID'] = 20 },
	{ ['x'] = 1166.2,  ['y'] = -313.1,  ['z'] = 68.34, ['stationID'] = 21 },
	{ ['x'] = 637.97,  ['y'] = 255.68,  ['z'] = 102.15, ['stationID'] = 22 },
	{ ['x'] = 2551.08,  ['y'] = 348.67,  ['z'] = 107.62, ['stationID'] = 23 },
	{ ['x'] = -341.75,  ['y'] = -1468.96,  ['z'] = 29.61, ['stationID'] = 24 },
	{ ['x'] = 159.92,  ['y'] = -1561.87,  ['z'] = 27.26, ['stationID'] = 25 },
}


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

blacklistedVehicles = {
	[1] = 'BMX',
	[2] = 'CRUISER',
	[3] = 'FIXTER',
	[4] = 'SCORCHER',
	[5] = 'TRIBIKE',
	[6] = 'TRIBIKE2',
	[7] = 'TRIBIKE3',
	[8] = 'POLMAV',
	[9] = 'BUZZARD',
	[10] = 'BUZZARD2'
}

local Vehicles 				  = {}
local pumpLoc 				  = {}
local stationLocations 	      = {}
local nearPump 				  = false
local IsFueling 			  = false
local IsFuelingWithJerryCan   = false
local InBlacklistedVehicle	  = false
local LastStation, LastPart, LastPartNum, LastEntity
local NearVehicleWithJerryCan = false
local price 				  = 0
local cash 					  = 0
local currentid = 0
local lastStation = {}
local fuelCost = 0
local avalFuel = 0
local avalMoney = 0
local savedId = 0
local type = ''
local fuelDefault = 0
local HasAlreadyEnteredMarker = false
local CurrentAction = nil
local CurrentActionMsg  = ''
local CurrentActionData = 0
local isInShopMenu = {}
local vehicleFuel = {}
ESX                           = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

function DrawText3Ds(x,y,z, text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    
    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
    local factor = (string.len(text)) / 370
    DrawRect(_x,_y+0.0125, 0.015+ factor, 0.03, 41, 11, 41, 68)
end

function drawTxt(x,y ,width,height,scale, text, r,g,b,a, outline)
	SetTextFont(0)
	SetTextProportional(0)
	SetTextScale(scale, scale)
	SetTextColour(r, g, b, a)
	SetTextDropShadow(0, 0, 0, 0,255)
	SetTextEdge(1, 0, 0, 0, 255)
	SetTextDropShadow()

	SetTextEntry("STRING")
	AddTextComponentString("test")
	EndTextCommandDisplayText(0.015, 0.765)
end

function DrawAdvancedText(x,y ,w,h,sc, text, r,g,b,a,font,jus)
    SetTextFont(font)
    SetTextProportional(0)
    SetTextScale(sc, sc)
	N_0x4e096588b13ffeca(jus)
    SetTextColour(r, g, b, a)
    SetTextDropShadow(0, 0, 0, 0,255)
    SetTextEdge(1, 0, 0, 0, 255)
    SetTextDropShadow()
    SetTextOutline()
    SetTextEntry("STRING")
    AddTextComponentString(text)
	DrawText(x - 0.1+w, y - 0.02+h)
end

function loadAnimDict(dict)
	while(not HasAnimDictLoaded(dict)) do
		RequestAnimDict(dict)
		Citizen.Wait(1)
	end
end

function FuelVehicle()
	local ped 	  = GetPlayerPed(-1)
	local coords  = GetEntityCoords(ped)
	local vehicle = GetPlayersLastVehicle()

	FreezeEntityPosition(ped, true)
	FreezeEntityPosition(vehicle, false)
	SetVehicleEngineOn(vehicle, false, false, false)
	loadAnimDict("timetable@gardener@filling_can")
	TaskPlayAnim(ped, "timetable@gardener@filling_can", "gar_ig_5_filling_can", 1.0, 2, -1, 49, 0, 0, 0, 0)
end

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)

		if not InBlacklistedVehicle then
			if Timer then
				DisplayHud()
			end

			if nearPump and IsCloseToLastVehicle then
				local vehicle  = GetPlayersLastVehicle()
				local fuel 	   = round(GetVehicleFuelLevel(vehicle), 1)
				
				if IsPedInAnyVehicle(GetPlayerPed(-1), false) then
					DrawAdvancedText(1.025, 0.979, 0.005, 0.0028, 0.4, "Verlasse Dein Fahrzeug um zu tanken.", 255, 255, 255, 255, 6, 0)
				elseif IsFueling then
					local position = GetEntityCoords(vehicle)
					--DrawText3Ds(pumpLoc['x'], pumpLoc['y'], pumpLoc['z'], "Drücke ~g~E~w~ um das Tanken vom Fahrzeug abzubrechen. ~g~" .. price .. "€")
					DrawAdvancedText(0.995, 0.935, 0.005, 0.0028, 0.4, "Drücke ~g~E~w~ um das Tanken vom Fahrzeug abzubrechen", 255, 255, 255, 255, 6, 0)
					DrawAdvancedText(0.995, 0.959, 0.005, 0.0028, 0.4, "Status: ~g~" .. fuel .. "L~w~ von ~g~100.0L", 255, 255, 255, 255, 6, 0)
					DrawAdvancedText(0.995, 0.983, 0.005, 0.0028, 0.4, "Kosten: ~g~$" .. price , 255, 255, 255, 255, 6, 0)
					
					DisableControlAction(0, 0, true) -- Changing view (V)
					DisableControlAction(0, 22, true) -- Jumping (SPACE)
					DisableControlAction(0, 23, true) -- Entering vehicle (F)
					DisableControlAction(0, 24, true) -- Punching/Attacking
					DisableControlAction(0, 29, true) -- Pointing (B)
					DisableControlAction(0, 30, true) -- Moving sideways (A/D)
					DisableControlAction(0, 31, true) -- Moving back & forth (W/S)
					DisableControlAction(0, 37, true) -- Weapon wheel
					DisableControlAction(0, 44, true) -- Taking Cover (Q)
					DisableControlAction(0, 56, true) -- F9
					DisableControlAction(0, 82, true) -- Mask menu (,)
					DisableControlAction(0, 140, true) -- Hitting your vehicle (R)
					DisableControlAction(0, 166, true) -- F5
					DisableControlAction(0, 167, true) -- F6
					DisableControlAction(0, 168, true) -- F7
					DisableControlAction(0, 170, true) -- F3
					DisableControlAction(0, 288, true) -- F1
					DisableControlAction(0, 289, true) -- F2
					DisableControlAction(1, 323, true) -- Handsup (X)

					if IsControlJustReleased(0, Keys["E"]) then
						loadAnimDict("reaction@male_stand@small_intro@forward")
						TaskPlayAnim(GetPlayerPed(-1), "reaction@male_stand@small_intro@forward", "react_forward_small_intro_a", 1.0, 2, -1, 49, 0, 0, 0, 0)

						TriggerServerEvent('LegacyFuel:5:PayFuel', price, avalMoney, currentid)
						Citizen.Wait(2500)
						ClearPedTasksImmediately(GetPlayerPed(-1))
						FreezeEntityPosition(GetPlayerPed(-1), false)
						FreezeEntityPosition(vehicle, false)

						ESX.TriggerServerCallback('dreamwork_business:getStation', function(data)
							ESX.ShowAdvancedNotification('~h~Legacy-V~h~', data.name, data.buymessage, 'CHAR_SOCIAL_CLUB', 0)
							TriggerServerEvent('dreamwork_business:removeFuel', currentid, data.fuel - fuelDefault)
						end, currentid)

						IsFueling = false
					end
				elseif fuel > 95.0 then
					DrawAdvancedText(1.027, 0.979, 0.005, 0.0028, 0.4, "Das Fahrzeug ist bereits vollgetankt.", 255, 255, 255, 255, 6, 0)
				elseif cash <= 0 then
					DrawAdvancedText(0.995, 0.979, 0.005, 0.0028, 0.4, "Du hast nicht genug Geld um das Tanken zu beginnen.", 255, 255, 255, 255, 6, 0)
					
				else
					if avalFuel >= 1 then
						DrawAdvancedText(1.008, 0.979, 0.005, 0.0028, 0.4, "Drücke ~g~E~w~ um Dein Fahrzeug aufzüfüllen. ~g~$" .. fuelCost .. "/~w~Liter", 255, 255, 255, 255, 6, 0)
						
						if IsControlJustReleased(0, Keys["E"]) then
							price = 0
							local vehicle = GetPlayersLastVehicle()
							local plate   = GetVehicleNumberPlateText(vehicle)

							ClearPedTasksImmediately(GetPlayerPed(-1))

							if GetSelectedPedWeapon(GetPlayerPed(-1)) ~= -1569615261 then
								SetCurrentPedWeapon(GetPlayerPed(-1), -1569615261, true)
								Citizen.Wait(1000)
							end

							fuelDefault = 0

							IsFueling = true

							FuelVehicle()
						end
					else
						DrawAdvancedText(0.966, 0.979, 0.005, 0.0028, 0.4, "Es ist nicht genug Benzin vorhanden. Bitte kontaktieren Sie den Besitzer.", 255, 255, 255, 255, 6, 0)
					end
				end
			elseif NearVehicleWithJerryCan and not nearPump and Config.EnableJerryCans then
				local vehicle  = GetPlayersLastVehicle()
				local coords   = GetEntityCoords(vehicle)
				local fuel 	   = round(GetVehicleFuelLevel(vehicle), 1)
				local jerrycan = GetAmmoInPedWeapon(GetPlayerPed(-1), 883325847)
				
				if IsFuelingWithJerryCan then
					DrawText3Ds(coords.x, coords.y, coords.z + 0.5, "Drücke ~g~G ~w~um das Tanken abzubrechen. Status: " .. fuel .. "% - Benzinkanister: " .. jerrycan)

					DisableControlAction(0, 0, true) -- Changing view (V)
					DisableControlAction(0, 22, true) -- Jumping (SPACE)
					DisableControlAction(0, 23, true) -- Entering vehicle (F)
					DisableControlAction(0, 24, true) -- Punching/Attacking
					DisableControlAction(0, 29, true) -- Pointing (B)
					DisableControlAction(0, 30, true) -- Moving sideways (A/D)
					DisableControlAction(0, 31, true) -- Moving back & forth (W/S)
					DisableControlAction(0, 37, true) -- Weapon wheel
					DisableControlAction(0, 44, true) -- Taking Cover (Q)
					DisableControlAction(0, 56, true) -- F9
					DisableControlAction(0, 82, true) -- Mask menu (,)
					DisableControlAction(0, 140, true) -- Hitting your vehicle (R)
					DisableControlAction(0, 166, true) -- F5
					DisableControlAction(0, 167, true) -- F6
					DisableControlAction(0, 168, true) -- F7
					DisableControlAction(0, 170, true) -- F3
					DisableControlAction(0, 288, true) -- F1
					DisableControlAction(0, 289, true) -- F2
					DisableControlAction(1, 323, true) -- Handsup (X)

					if IsControlJustReleased(0, Keys["E"]) then
						loadAnimDict("reaction@male_stand@small_intro@forward")
						TaskPlayAnim(GetPlayerPed(-1), "reaction@male_stand@small_intro@forward", "react_forward_small_intro_a", 1.0, 2, -1, 49, 0, 0, 0, 0)

						Citizen.Wait(2500)
						ClearPedTasksImmediately(GetPlayerPed(-1))
						FreezeEntityPosition(GetPlayerPed(-1), false)
						FreezeEntityPosition(vehicle, false)

						IsFuelingWithJerryCan = false
					end
				else
					--DrawText3Ds(coords.x, coords.y, coords.z + 0.5, "Drücke ~g~E~w~ um Dein Fahrzeug aufzutanken.")

					if IsControlJustReleased(0, Keys["E"]) then
						local vehicle = GetPlayersLastVehicle()
						local plate   = GetVehicleNumberPlateText(vehicle)

						ClearPedTasksImmediately(GetPlayerPed(-1))

						IsFuelingWithJerryCan = true

						FuelVehicle()
					end
				end
			end
		else
			Citizen.Wait(500)
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(500)

		if IsFueling then
			local vehicle  = GetPlayersLastVehicle()
			local plate    = GetVehicleNumberPlateText(vehicle)
			local fuel 	   = GetVehicleFuelLevel(vehicle)
			local integer  = math.random(6, 10)
			local newfuel  = fuel + 1
			avalFuel = avalFuel - 1
			fuelDefault = fuelDefault + 1

			if cash <= price then
				
				SetVehicleFuelLevel(vehicle, newfuel)
				loadAnimDict("reaction@male_stand@small_intro@forward")
				TaskPlayAnim(GetPlayerPed(-1), "reaction@male_stand@small_intro@forward", "react_forward_small_intro_a", 1.0, 2, -1, 49, 0, 0, 0, 0)

				ClearPedTasksImmediately(GetPlayerPed(-1))
				FreezeEntityPosition(GetPlayerPed(-1), false)
				FreezeEntityPosition(vehicle, false)

				IsFueling = false
			end

			if avalFuel >= 1 then
			--
			if cash >= price then
				ESX.TriggerServerCallback('LegacyFuel:CheckServerFuelTable', function(vehInfo) 
					local fuel   = round(vehInfo.fuel, 1)

					for i = 1, #Vehicles do
						if Vehicles[i].plate == vehInfo.plate then
							table.remove(Vehicles, i)
				
							break
						end
					end
				
					table.insert(Vehicles, {plate = vehInfo.plate, fuel = fuel})
				end, plate)
				Citizen.Wait(150)

				price = price + fuelCost

				if newfuel < 100 then
					SetVehicleFuelLevel(vehicle, newfuel)

					for i = 1, #Vehicles do
						if Vehicles[i].plate == plate then
							TriggerServerEvent('LegacyFuel:UpdateServerFuelTable', plate, round(GetVehicleFuelLevel(vehicle), 1))

							table.remove(Vehicles, i)
							table.insert(Vehicles, {plate = plate, fuel = newfuel})

							break
						end
					end
				else
					
					SetVehicleFuelLevel(vehicle, 100.0)
					loadAnimDict("reaction@male_stand@small_intro@forward")
					TaskPlayAnim(GetPlayerPed(-1), "reaction@male_stand@small_intro@forward", "react_forward_small_intro_a", 1.0, 2, -1, 49, 0, 0, 0, 0)

					Citizen.Wait(2500)
					ClearPedTasksImmediately(GetPlayerPed(-1))
					FreezeEntityPosition(GetPlayerPed(-1), false)
					FreezeEntityPosition(vehicle, false)
					
					ESX.TriggerServerCallback('dreamwork_business:getStation', function(data)
						ESX.ShowAdvancedNotification('~h~Legacy-V~h~', data.name, data.buymessage, 'CHAR_SOCIAL_CLUB', 0)
						TriggerServerEvent('dreamwork_business:removeFuel', currentid, data.fuel - fuelDefault)
					end, currentid)

					fuelDefault = 0
					
					TriggerServerEvent('LegacyFuel:5:PayFuel', price, avalMoney, currentid)

					IsFueling = false

					for i = 1, #Vehicles do
						if Vehicles[i].plate == plate then
							TriggerServerEvent('LegacyFuel:UpdateServerFuelTable', plate, round(GetVehicleFuelLevel(vehicle), 1))

							table.remove(Vehicles, i)
							table.insert(Vehicles, {plate = plate, fuel = newfuel})

							break
						end
					end
				end
			else
				SetVehicleFuelLevel(vehicle, newfuel)
				loadAnimDict("reaction@male_stand@small_intro@forward")
				TaskPlayAnim(GetPlayerPed(-1), "reaction@male_stand@small_intro@forward", "react_forward_small_intro_a", 1.0, 2, -1, 49, 0, 0, 0, 0)

				TriggerServerEvent('LegacyFuel:5:PayFuel', price, avalMoney, currentid)
				Citizen.Wait(2500)
				ClearPedTasksImmediately(GetPlayerPed(-1))
				FreezeEntityPosition(GetPlayerPed(-1), false)
				FreezeEntityPosition(vehicle, false)

				IsFueling = false

				for i = 1, #Vehicles do
					if Vehicles[i].plate == plate then
						TriggerServerEvent('LegacyFuel:UpdateServerFuelTable', plate, round(GetVehicleFuelLevel(vehicle), 1))

						table.remove(Vehicles, i)
						table.insert(Vehicles, {plate = plate, fuel = newfuel})

						break
					end
				end
			end
			--
		else
			SetVehicleFuelLevel(vehicle, newfuel)
			loadAnimDict("reaction@male_stand@small_intro@forward")
			TaskPlayAnim(GetPlayerPed(-1), "reaction@male_stand@small_intro@forward", "react_forward_small_intro_a", 1.0, 2, -1, 49, 0, 0, 0, 0)

			TriggerServerEvent('LegacyFuel:5:PayFuel', price, avalMoney, currentid)
			Citizen.Wait(2500)
			ClearPedTasksImmediately(GetPlayerPed(-1))
			FreezeEntityPosition(GetPlayerPed(-1), false)
			FreezeEntityPosition(vehicle, false)

			IsFueling = false
			fuelTank = 0

			ESX.TriggerServerCallback('dreamwork_business:getStation', function(data)
				ESX.ShowAdvancedNotification('~h~Legacy-V~h~', data.name, 'Der Tankvorgang wurde unterbrochen, da nicht genug Benzin vorhanden ist.', 'CHAR_SOCIAL_CLUB', 0)
			end, currentid)
		end

		elseif IsFuelingWithJerryCan then
			local vehicle   = GetPlayersLastVehicle()
			local plate     = GetVehicleNumberPlateText(vehicle)
			local fuel 	    = GetVehicleFuelLevel(vehicle)
			local integer   = math.random(6, 10)
			local fuelthis  = integer / 10
			local newfuel   = fuel + fuelthis
			local jerryfuel = fuelthis * 100
			local jerrycurr = GetAmmoInPedWeapon(GetPlayerPed(-1), 883325847)
			local jerrynew  = jerrycurr - jerryfuel

			if jerrycurr >= jerryfuel then
				ESX.TriggerServerCallback('LegacyFuel:CheckServerFuelTable', function(vehInfo) 
					local fuel   = round(vehInfo.fuel, 1)

					for i = 1, #Vehicles do
						if Vehicles[i].plate == vehInfo.plate then
							table.remove(Vehicles, i)
				
							break
						end
					end
				
					table.insert(Vehicles, {plate = vehInfo.plate, fuel = fuel})
				end, plate)
				Citizen.Wait(150)
				SetPedAmmo(GetPlayerPed(-1), 883325847, round(jerrynew, 0))

				if newfuel < 100 then
					SetVehicleFuelLevel(vehicle, newfuel)

					for i = 1, #Vehicles do
						if Vehicles[i].plate == plate then
							TriggerServerEvent('LegacyFuel:UpdateServerFuelTable', plate, round(GetVehicleFuelLevel(vehicle), 1))

							table.remove(Vehicles, i)
							table.insert(Vehicles, {plate = plate, fuel = newfuel})

							break
						end
					end
				else
					SetVehicleFuelLevel(vehicle, 100.0)
					loadAnimDict("reaction@male_stand@small_intro@forward")
					TaskPlayAnim(GetPlayerPed(-1), "reaction@male_stand@small_intro@forward", "react_forward_small_intro_a", 1.0, 2, -1, 49, 0, 0, 0, 0)

					Citizen.Wait(2500)
					ClearPedTasksImmediately(GetPlayerPed(-1))
					FreezeEntityPosition(GetPlayerPed(-1), false)
					FreezeEntityPosition(vehicle, false)

					IsFuelingWithJerryCan = false

					for i = 1, #Vehicles do
						if Vehicles[i].plate == plate then
							TriggerServerEvent('LegacyFuel:UpdateServerFuelTable', plate, round(GetVehicleFuelLevel(vehicle), 1))

							table.remove(Vehicles, i)
							table.insert(Vehicles, {plate = plate, fuel = newfuel})

							break
						end
					end
				end
			else
				loadAnimDict("reaction@male_stand@small_intro@forward")
				TaskPlayAnim(GetPlayerPed(-1), "reaction@male_stand@small_intro@forward", "react_forward_small_intro_a", 1.0, 2, -1, 49, 0, 0, 0, 0)

				Citizen.Wait(2500)
				ClearPedTasksImmediately(GetPlayerPed(-1))
				FreezeEntityPosition(GetPlayerPed(-1), false)
				FreezeEntityPosition(vehicle, false)

				IsFuelingWithJerryCan = false

				for i = 1, #Vehicles do
					if Vehicles[i].plate == plate then
						TriggerServerEvent('LegacyFuel:UpdateServerFuelTable', plate, round(GetVehicleFuelLevel(vehicle), 1))

						table.remove(Vehicles, i)
						table.insert(Vehicles, {plate = plate, fuel = newfuel})

						break
					end
				end
			end
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(250)

		if IsPedInAnyVehicle(GetPlayerPed(-1)) then
			Citizen.Wait(2500)

			Timer = true
		else
			Timer = false
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1500)

		nearPump 			 	= false
		IsCloseToLastVehicle 	= false
		found 				 	= false
		NearVehicleWithJerryCan = false

		local myCoords = GetEntityCoords(GetPlayerPed(-1))
		
		for i = 1, #models do
			local closestPump = GetClosestObjectOfType(myCoords.x, myCoords.y, myCoords.z, 1.5, models[i], false, false)
			
			if closestPump ~= nil and closestPump ~= 0 then
				local coords    = GetEntityCoords(closestPump)
				local vehicle   = GetPlayersLastVehicle()

				nearPump = true
				pumpLoc  = {['x'] = coords.x, ['y'] = coords.y, ['z'] = coords.z + 1.2}

				for i=1, #gas_stations, 1 do
					if GetDistanceBetweenCoords(pumpLoc['x'], pumpLoc['y'], pumpLoc['z'], gas_stations[i]['x'], gas_stations[i]['y'], gas_stations[i]['z']) <= 40.0 then
						currentid = gas_stations[i]['stationID']

						if savedId ~= currentid then
							ESX.TriggerServerCallback('dreamwork_business:getStation', function(data)
								fuelCost = data.ppl
								avalFuel = data.fuel
								avalMoney = data.money
							end, currentid)

							savedId = currentid
						end
					end
				end

				if vehicle ~= nil then
					local vehcoords = GetEntityCoords(vehicle)
					local mycoords  = GetEntityCoords(GetPlayerPed(-1))
					local distance  = GetDistanceBetweenCoords(vehcoords.x, vehcoords.y, vehcoords.z, mycoords.x, mycoords.y, mycoords.z)

					if distance < 3 then
						IsCloseToLastVehicle = true
					end
				end
				break
			end
		end

		if IsPedInAnyVehicle(GetPlayerPed(-1), false) then
			local vehicle = GetPlayersLastVehicle()
			local plate   = GetVehicleNumberPlateText(vehicle)
			local fuel 	  = GetVehicleFuelLevel(vehicle)
			local found   = false

			ESX.TriggerServerCallback('LegacyFuel:CheckServerFuelTable', function(vehInfo) 
				local fuel   = round(vehInfo.fuel, 1)

				for i = 1, #Vehicles do
					if Vehicles[i].plate == vehInfo.plate then
						table.remove(Vehicles, i)
			
						break
					end
				end
			
				table.insert(Vehicles, {plate = vehInfo.plate, fuel = fuel})
			end, plate)

			Citizen.Wait(500)

			for i = 1, #Vehicles do
				if Vehicles[i].plate == plate then
					found = true
					fuel  = round(Vehicles[i].fuel, 1)

					break
				end
			end

			if not found then
				integer = math.random(200, 800)
				fuel 	= integer / 10

				table.insert(Vehicles, {plate = plate, fuel = fuel})

				TriggerServerEvent('LegacyFuel:UpdateServerFuelTable', plate, fuel)
			end

			SetVehicleFuelLevel(vehicle, fuel)
		end

		local currentVeh = GetDisplayNameFromVehicleModel(GetEntityModel(GetVehiclePedIsUsing(GetPlayerPed(-1))))

		for i = 1, #blacklistedVehicles do
			if blacklistedVehicles[i] == currentVeh then
				InBlacklistedVehicle = true
				found 				 = true
				
				break
			end
		end

		if not found then
			InBlacklistedVehicle = false
		end

		if nearPump then
			TriggerServerEvent('LegacyFuel:CheckCashOnHand')
		end

		local CurrentWeapon = GetSelectedPedWeapon(GetPlayerPed(-1))
						
		if CurrentWeapon == 883325847 then
			local MyCoords 		= GetEntityCoords(GetPlayerPed(-1))
			local Vehicle  		= GetClosestVehicle(MyCoords.x, MyCoords.y, MyCoords.z, 3.0, false, 23) == GetPlayersLastVehicle() and GetPlayersLastVehicle() or 0

			if Vehicle ~= 0 then
				NearVehicleWithJerryCan = true
			end
		end
	end
end)

function round(num, numDecimalPlaces)
	return tonumber(string.format("%." .. (numDecimalPlaces or 0) .. "f", num))
end

function GetSeatPedIsIn(ped)
	local vehicle = GetVehiclePedIsIn(ped, false)

	for i = -2, GetVehicleMaxNumberOfPassengers(vehicle) do
		if GetPedInVehicleSeat(vehicle, i) == ped then
			return i
		end
	end

	return -2
end

function DisplayHud()
	local playerPed = GetPlayerPed(-1)

	if Config.ShouldDisplayHud and IsPedInAnyVehicle(playerPed, false) and GetSeatPedIsIn(playerPed) == -1 then
		local vehicle = GetPlayersLastVehicle()
		local fuel    = math.ceil(round(GetVehicleFuelLevel(vehicle), 1))
		local speed   = GetEntitySpeed(vehicle)
		local kmh     = round(speed * 3.6, 0)
		local mph     = round(speed * 2.236936, 0)

		if fuel == 0 then
			fuel = "0"
		end
		if kmh == 0 then
			kmh = "0"
		end
		if mph == 0 then
			mph = "0"
		end

		x = 0.01135
		y = 0.002
	end
end

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(5000)

		local vehicle = GetVehiclePedIsIn(GetPlayerPed(-1))
		local engine  = Citizen.InvokeNative(0xAE31E7DF9B5B132E, vehicle)

		if vehicle and engine then
			local plate    	   = GetVehicleNumberPlateText(vehicle)
			local rpm 	   	   = GetVehicleCurrentRpm(vehicle)
			local fuel     	   = GetVehicleFuelLevel(vehicle)
			local rpmfuelusage = 0

			if rpm > 0.9 then
				rpmfuelusage = fuel - rpm / 5.85
				Citizen.Wait(1000)
			elseif rpm > 0.8 then
				rpmfuelusage = fuel - rpm / 6.08
				Citizen.Wait(1500)
			elseif rpm > 0.7 then
				rpmfuelusage = fuel - rpm / 6.9
				Citizen.Wait(2000)
			elseif rpm > 0.6 then
				rpmfuelusage = fuel - rpm / 7.58
				Citizen.Wait(3000)
			elseif rpm > 0.5 then
				rpmfuelusage = fuel - rpm / 8.78
				Citizen.Wait(4000)
			elseif rpm > 0.4 then
				rpmfuelusage = fuel - rpm / 10.05
				Citizen.Wait(5000)
			elseif rpm > 0.3 then
				rpmfuelusage = fuel - rpm / 10.43
				Citizen.Wait(6000)
			elseif rpm > 0.2 then
				rpmfuelusage = fuel - rpm / 10.73
				Citizen.Wait(8000)
			else
				rpmfuelusage = fuel - rpm / 10.8
				Citizen.Wait(15000)
			end

			for i = 1, #Vehicles do
				if Vehicles[i].plate == plate then
					SetVehicleFuelLevel(vehicle, rpmfuelusage)

					local updatedfuel = round(GetVehicleFuelLevel(vehicle), 1)

					if updatedfuel ~= 0 then
						TriggerServerEvent('LegacyFuel:UpdateServerFuelTable', plate, updatedfuel)

						table.remove(Vehicles, i)
						table.insert(Vehicles, {plate = plate, fuel = rpmfuelusage})
					end

					break
				end
			end

			if rpmfuelusage < Config.VehicleFailure then
				SetVehicleUndriveable(vehicle, true)
			elseif rpmfuelusage == 0 then
				SetVehicleEngineOn(vehicle, false, false, false)
			else
				SetVehicleUndriveable(vehicle, false)
			end
		end
	end
end)

RegisterNetEvent('LegacyFuel:RecieveCashOnHand')
AddEventHandler('LegacyFuel:RecieveCashOnHand', function(cb)
	cash = cb
end)

Citizen.CreateThread(function()
	if Config.EnableBlips then
		for k, v in ipairs(gas_stations) do
			local blip = AddBlipForCoord(v.x, v.y, v.z)

			SetBlipSprite(blip, 361)
			SetBlipScale(blip, 0.8)
			SetBlipColour(blip, 17)
			SetBlipDisplay(blip, 4)
			SetBlipAsShortRange(blip, true)

			BeginTextCommandSetBlipName("STRING")
			AddTextComponentString("Tankstelle")
			EndTextCommandSetBlipName(blip)
		end
	end
end)

AddEventHandler('dw_legacyfuel:hasEnteredMarker', function(part, stationID)

	if part == 'stationMenu' then
		CurrentAction     = 'menu_station'
		CurrentActionMsg  = 'Drücke ~INPUT_CONTEXT~ um die Tankstellen-Verwaltung zu öffnen.'
		CurrentActionData = stationID
	end

	if part == 'refuelMenu' then
		CurrentAction     = 'menu_refuel'
		CurrentActionMsg  = 'Drücke ~INPUT_CONTEXT~ um die Tankstelle mit Benzin aufzufüllen.'
		CurrentActionData = stationID 
	end

end)

AddEventHandler('dw_legacyfuel:hasExitedMarker', function(stationID)
	if not isInShopMenu then
		ESX.UI.Menu.CloseAll()
	end

	CurrentAction = nil
	TriggerServerEvent('dreamwork_business:stopRefuel', stationID)
end)

RegisterCommand('testdarm', function()
	local vehicle = GetPlayersLastVehicle()

	vehicleFuel[vehicle] = 5000
end)


-- Display markers
Citizen.CreateThread(function()
	while true do

		Citizen.Wait(1)

		local playerPed = PlayerPedId()
		local coords    = GetEntityCoords(playerPed)
		local isInMarker, hasExited, letSleep = false, false, true
		local stationID

		for i=1, #gas_stations, 1 do
			local distance = GetDistanceBetweenCoords(coords, vector3(gas_stations[i]['x'], gas_stations[i]['y'], gas_stations[i]['z']), true)

			if distance < 20.0 then
				DrawMarker(27, vector3(gas_stations[i]['x'], gas_stations[i]['y'], gas_stations[i]['z']), 0.0, 0.0, 0.0, 0, 0.0, 0.0, 1.0, 1.0, 1.0, 255, 255, 50, 100, false, true, 2, true, false, false, false)
				letSleep = false
			end

			if distance < 2.0 then
				isInMarker = true
				type = 'stationMenu'
				stationID = gas_stations[i]['stationID']
			end
		end

		for i=1, #refuel_stations, 1 do
			local distance = GetDistanceBetweenCoords(coords, vector3(refuel_stations[i]['x'], refuel_stations[i]['y'], refuel_stations[i]['z']), true)

			if distance < 20.0 then
				DrawMarker(27, vector3(refuel_stations[i]['x'], refuel_stations[i]['y'], refuel_stations[i]['z']), 0.0, 0.0, 0.0, 0, 0.0, 0.0, 1.0, 1.0, 1.0, 255, 255, 50, 100, false, true, 2, true, false, false, false)
				letSleep = false
			end

			if distance < 3.0 then
				isInMarker = true
				type = 'refuelMenu'
				stationID = refuel_stations[i]['stationID']
			end
		end

		if isInMarker and not HasAlreadyEnteredMarker or (isInMarker and (LastStation ~= stationID)) then

			if
				(LastStation ~= nil) and
				(LastStation ~= stationID)
			then
				TriggerEvent('dw_legacyfuel:hasExitedMarker', LastStation)
				hasExited = true
			end

			HasAlreadyEnteredMarker = true
			LastStation             = stationID

			TriggerEvent('dw_legacyfuel:hasEnteredMarker', type, stationID)

		end

		if not hasExited and not isInMarker and HasAlreadyEnteredMarker then
			HasAlreadyEnteredMarker = false
			TriggerEvent('dw_legacyfuel:hasExitedMarker', LastStation)
		end

		if letSleep then
			Citizen.Wait(500)
		end
	end
end)

Citizen.CreateThread(function()
	while true do

		Citizen.Wait(0)

		if CurrentAction ~= nil then
			ESX.ShowHelpNotification(CurrentActionMsg)
			if IsControlJustReleased(0, Keys['E']) then

				if CurrentAction == 'menu_station' then
					TriggerEvent('dreamwork_business:openStation', CurrentActionData)
				end
				
				if CurrentAction == 'menu_refuel' then
					TriggerEvent('dreamwork_legacyfuel:refuelStation', CurrentActionData)
					print(CurrentActionData)
				end
				
				CurrentAction = nil
			end
		end 
	end
end)

RegisterNetEvent('dreamwork_legacyfuel:refuelStation')
AddEventHandler('dreamwork_legacyfuel:refuelStation', function(stationId)
	local playerPed = PlayerPedId()

	TriggerServerEvent('dreamwork_business:startRefuel', stationId)
end)