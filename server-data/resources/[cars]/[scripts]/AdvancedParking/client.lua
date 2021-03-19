local enabled = true

Citizen.CreateThread(function()
	while (true) do
		local playerPed = PlayerPedId()
		if (DoesEntityExist(playerPed)) then
			TriggerServerEvent("AdvancedParking:syncPlayerPosition", GetEntityCoords(playerPed))
		end
		
		Citizen.Wait(3000)
	end
end)

Citizen.CreateThread(function()
	Citizen.Wait(3000)

	local isInVehicle = false
	local currentVehiclePlate = nil
	local wasDead = false

	while (true) do
		Citizen.Wait(50)
		
        local playerPed = PlayerPedId()

		if (not isInVehicle and IsPedInAnyVehicle(playerPed)) then
			-- entered vehicle

			isInVehicle = true

			if (enabled) then
				local vehicle = GetVehiclePedIsIn(playerPed, false)
				if (NetworkGetEntityIsNetworked(vehicle) and not IsVehicleBlacklisted(vehicle)) then
					local networkId = NetworkGetNetworkIdFromEntity(vehicle)
					SetNetworkIdCanMigrate(netId, true)
					local modifications = GetVehicleModifications(vehicle)

					currentVehiclePlate = GetVehicleNumberPlateText(vehicle)

					TriggerServerEvent("AdvancedParking:enteredVehicle", networkId, modifications)

					Log("Vehicle " .. currentVehiclePlate .. " entered")
				end
			end
		elseif (isInVehicle and not IsPedInAnyVehicle(playerPed, false)) then
			-- left vehicle

			isInVehicle = false

			if (enabled and not wasDead) then
				local vehicle = GetVehiclePedIsIn(playerPed, true)

				if (vehicle ~= 0) then
					if (NetworkGetEntityIsNetworked(vehicle) and not IsVehicleBlacklisted(vehicle)) then
						local networkId = NetworkGetNetworkIdFromEntity(vehicle)
						SetNetworkIdCanMigrate(netId, true)
						local modifications = GetVehicleModifications(vehicle)

						TriggerServerEvent("AdvancedParking:leftVehicle", networkId, modifications)

						Log("Vehicle " .. GetVehicleNumberPlateText(vehicle) .. " left")

						-- if vehicle is deleted soon after
						Citizen.CreateThread(function()
							local veh = vehicle
							local plate = GetVehicleNumberPlateText(veh)
							local startTime = GetGameTimer()
							local playerPed = PlayerPedId()
							local playerPos

							while (true) do
								Citizen.Wait(0)

								if (GetGameTimer() - startTime >= 1000) then
									break
								end

								if (not DoesEntityExist(veh)) then
									TriggerServerEvent("AdvancedParking:deleteVehicle", plate, false)

									Log("Vehicle " .. currentVehiclePlate .. " left and deleted after exit")

									currentVehiclePlate = nil
									break
								end
							
								playerPed = PlayerPedId()
								playerPos = GetEntityCoords(playerPed)
								vehPos = GetEntityCoords(veh)

								if (Vdist(playerPos.x, playerPos.y, playerPos.z, vehPos.x, vehPos.y, vehPos.z) > 50.0) then
									currentVehiclePlate = nil
									break
								end
							end
						end)
					end
				elseif (currentVehiclePlate) then
					TriggerServerEvent("AdvancedParking:deleteVehicle", currentVehiclePlate, false)

					Log("Vehicle " .. currentVehiclePlate .. " left and deleted")

					currentVehiclePlate = nil
				end
			end
		end

		if (not wasDead and IsPlayerDead(PlayerId())) then
			wasDead = true
		elseif (wasDead and not IsPlayerDead(PlayerId())) then
			Citizen.CreateThread(function()
				Citizen.Wait(1000)

				wasDead = false
			end)
		end
	end
end)

RegisterNetEvent("AdvancedParking:setVehicleMods")
AddEventHandler("AdvancedParking:setVehicleMods", function(netId, plate, modifications)
	while (not NetworkDoesEntityExistWithNetworkId(netId)) do
		Citizen.Wait(0)
	end

	local vehicle = NetworkGetEntityFromNetworkId(netId)

	Log("Setting modifications for vehicle " .. plate)

    if (DoesEntityExist(vehicle)) then
        SetVehicleModifications(vehicle, plate, modifications)
    end
end)

AddEventHandler("AdvancedParking:updateVehicle", function(vehicle)
	if (vehicle == nil) then
		print("^1[ERROR] \"vehicle\" was nil while trying to update a vehicle!")
		return
	end

	if (DoesEntityExist(vehicle) and NetworkGetEntityIsNetworked(vehicle) and not IsVehicleBlacklisted(vehicle)) then
		Log("Triggering manual update of vehicle")

		local networkId = NetworkGetNetworkIdFromEntity(vehicle)
		local modifications = GetVehicleModifications(vehicle)

		TriggerServerEvent("AdvancedParking:updateVehicle", networkId, modifications)
	end
end)

RegisterNetEvent("AdvancedParking:enable")
AddEventHandler("AdvancedParking:enable", function(enable)
	if (enable == nil) then
		print("^1[ERROR] \"enable\" was nil while trying to enable/disable script!")
		return
	end

	enabled = enable

	if (enabled) then
		Log("AdvancedParking enabled")
	else
		Log("AdvancedParking disabled")
	end
end)

RegisterNetEvent("AdvancedParking:notification")
AddEventHandler("AdvancedParking:notification", function(msg)
    SetNotificationTextEntry('STRING')
    AddTextComponentSubstringPlayerName(msg)
    DrawNotification(false, true)
end)
