local spawnedWeeds = 0
local weedPlants = {}
local isPickingUp, isProcessing = false, false


Citizen.CreateThread(function()
	while true do
		Citizen.Wait(10)
		local coords = GetEntityCoords(PlayerPedId())

		if GetDistanceBetweenCoords(coords, Config.CircleZones.WeedField.coords, true) < 50 then
			SpawnWeedPlants()
			Citizen.Wait(500)
		else
			Citizen.Wait(500)
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		local playerPed = PlayerPedId()
		local coords = GetEntityCoords(playerPed)

		if GetDistanceBetweenCoords(coords, Config.CircleZones.WeedProcessing.coords, true) < 5 then
			if not isProcessing then
				ESX.ShowHelpNotification(_U('weed_processprompt'))
			end

			if IsControlJustReleased(0, Keys['E']) and not isProcessing then
				if Config.RequireCopsOnline then
					ESX.TriggerServerCallback('esx_illegal:EnoughCops', function(cb)
						if cb then
							ProcessWeed()
						else
							ESX.ShowNotification(_U('cops_notenough'))
						end
					end, Config.Cops.Weed)
				else
					ProcessWeed()
				end
			end
		else
			Citizen.Wait(500)
		end
	end
end)

function ProcessWeed()
	isProcessing = true

	ESX.ShowNotification(_U('weed_processingstarted'))
	TriggerServerEvent('esx_illegal:processCannabis')
	local timeLeft = Config.Delays.WeedProcessing / 1000
	local playerPed = PlayerPedId()

	while timeLeft > 0 do
		Citizen.Wait(1000)
		timeLeft = timeLeft - 1

		if GetDistanceBetweenCoords(GetEntityCoords(playerPed), Config.CircleZones.WeedProcessing.coords, false) > 5 then
			ESX.ShowNotification(_U('weed_processingtoofar'))
			TriggerServerEvent('esx_illegal:cancelProcessing')
			break
		end
	end

	isProcessing = false
end

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		local playerPed = PlayerPedId()
		local coords = GetEntityCoords(playerPed)
		local nearbyObject, nearbyID

		for i=1, #weedPlants, 1 do
			if GetDistanceBetweenCoords(coords, GetEntityCoords(weedPlants[i]), false) < 1 then
				nearbyObject, nearbyID = weedPlants[i], i
			end
		end

		if nearbyObject and IsPedOnFoot(playerPed) then

			if not isPickingUp then
				ESX.ShowHelpNotification(_U('weed_pickupprompt'))
			end

			if IsControlJustReleased(0, Keys['E']) and not isPickingUp then
				if not IsPedInAnyVehicle(playerPed, true) then
					if Config.RequireCopsOnline then
						ESX.TriggerServerCallback('esx_illegal:EnoughCops', function(cb)
							if cb then
								PickUpWeed(playerPed, coords, nearbyObject, nearbyID)
							else
								ESX.ShowNotification(_U('cops_notenough'))
							end
						end, Config.Cops.Weed)
					else
						PickUpWeed(playerPed, coords, nearbyObject, nearbyID)
					end
				else
					ESX.ShowNotification(_U('need_on_foot'))
				end
			end

		else
			Citizen.Wait(500)
		end

	end

end)

function PickUpWeed(playerPed, coords, nearbyObject, nearbyID)
	isPickingUp = true

	ESX.TriggerServerCallback('esx_illegal:canPickUp', function(canPickUp)

		if canPickUp then
			TaskStartScenarioInPlace(playerPed, 'world_human_gardener_plant', 0, false)

			Citizen.Wait(2000)
			ClearPedTasks(playerPed)
			Citizen.Wait(1500)

			ESX.Game.DeleteObject(nearbyObject)

			table.remove(weedPlants, nearbyID)

			TriggerServerEvent('esx_illegal:pickedUpCannabis')
			Citizen.Wait(5000)
			spawnedWeeds = spawnedWeeds - 1
		else
			ESX.ShowNotification(_U('weed_inventoryfull'))
		end

		isPickingUp = false

	end, 'cannabis')
end

AddEventHandler('onResourceStop', function(resource)
	if resource == GetCurrentResourceName() then
		for k, v in pairs(weedPlants) do
			ESX.Game.DeleteObject(v)
		end
	end
end)

function SpawnWeedPlants()
	while spawnedWeeds < 15 do
		Citizen.Wait(0)
		local weedCoords = GenerateWeedCoords()

		ESX.Game.SpawnObject('', weedCoords, function(obj)
			PlaceObjectOnGroundProperly(obj)
			FreezeEntityPosition(obj, true)

			table.insert(weedPlants, obj)
			spawnedWeeds = spawnedWeeds + 1
		end)
	end
end

function LapKurczaka()
	DoScreenFadeOut(500)
	Citizen.Wait(500)
	SetEntityCoordsNoOffset(GetPlayerPed(-1), weedCoords, 0, 0, 1)
	RequestModel(GetHashKey('a_c_chickenhawk'))
	while not HasModelLoaded(GetHashKey('a_c_chickenhawk')) do
	Wait(1)
	end
	kurczak = CreatePed(26, "a_c_chickenhawk", weedCoords, true, false)
	TaskReactAndFleePed(kurczak, GetPlayerPed(-1))
	Citizen.Wait(500)
	DoScreenFadeIn(500)
	akcja = true
end
	

function ValidateWeedCoord(plantCoord)
	if spawnedWeeds > 0 then
		local validate = true

		for k, v in pairs(weedPlants) do
			if GetDistanceBetweenCoords(plantCoord, GetEntityCoords(v), true) < 5 then
				validate = false
			end
		end

		if GetDistanceBetweenCoords(plantCoord, Config.CircleZones.WeedField.coords, false) > 50 then
			validate = false
		end

		return validate
	else
		return true
	end
end

function GenerateWeedCoords()
	while true do
		Citizen.Wait(1)

		local weedCoordX, weedCoordY

		math.randomseed(GetGameTimer())
		local modX = math.random(-20, 20)

		Citizen.Wait(100)

		math.randomseed(GetGameTimer())
		local modY = math.random(-20, 20)

		weedCoordX = Config.CircleZones.WeedField.coords.x + modX
		weedCoordY = Config.CircleZones.WeedField.coords.y + modY

		local coordZ = GetCoordZWeed(weedCoordX, weedCoordY)
		local coord = vector3(weedCoordX, weedCoordY, coordZ)

		if ValidateWeedCoord(coord) then
			return coord
		end
	end
end

function GetCoordZWeed(x, y)
	local groundCheckHeights = { 50, 51.0, 52.0, 53.0, 54.0, 55.0, 56.0, 57.0, 58.0, 59.0, 60.0 }

	for i, height in ipairs(groundCheckHeights) do
		local foundGround, z = GetGroundZFor_3dCoord(x, y, height)

		if foundGround then
			return z
		end
	end

	return 53.85
end