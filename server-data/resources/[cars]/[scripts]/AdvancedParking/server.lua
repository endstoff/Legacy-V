local vehicles = {}

-- Command to delete ALL vehicles from the database table. Needs to be executed twice for security reason.
local deleteSavedVehicles = false
RegisterCommand("deleteSavedVehicles", function(source, args, raw)
    if (deleteSavedVehicles) then
        MySQL.Async.execute("DELETE FROM vehicle_parking", { })

        vehicles = {}

        Log("Deleted all vehicles from the vehicle_parking table.")
    else
        Log("Are you sure that you want to delete all vehicles from the parking list?\nIf yes, type the command a second time!")
    end

    deleteSavedVehicles = not deleteSavedVehicles
end, true)

-- read all vehicles from the database on startup and do a cleanup check
MySQL.ready(function()
    -- fetch all database results
    MySQL.Async.fetchAll("SELECT plate, posX, posY, posZ, rotX, rotY, rotZ, modifications, lastUpdate FROM vehicle_parking", {}, function(results)
        Log("Found " .. #results .. " saved vehicles in vehicle_parking.")

        for i = 1, #results do
            vehicles[results[i].plate] = {
                handle          = nil,
                position        = vector3(results[i].posX, results[i].posY, results[i].posZ),
                rotation        = vector3(results[i].rotX, results[i].rotY, results[i].rotZ),
                modifications   = json.decode(results[i].modifications),
                lastUpdate      = results[i].lastUpdate,
	            spawning        = false
            }
        end

        CleanUp()
    end)
end)

-- Default CleanUp function. Deletes vehicles from the database after a specific amount of time has passed (configurable in config)
function CleanUp()
    local currentTime = os.time()
    local threshold = 60 * 60 * Config.cleanUpThresholdTime

    local toDelete = {}

    for plate, vehicle in pairs(vehicles) do
        if (vehicle.lastUpdate < os.difftime(currentTime, threshold)) then
            
            MySQL.Async.execute("DELETE FROM vehicle_parking WHERE plate = @plate",
            {
                ["@plate"] = plate
            })

            table.insert(toDelete, plate)
        end
    end
    
    for i = 1, #toDelete, 1 do
        local plate = toDelete[i]
        vehicles[plate] = nil
    end

    Log("CleanUp complete. Deleted " .. #toDelete .. " entries.")
end



-- loop to spawn vehicles near players
Citizen.CreateThread(function()
    while (true) do
        Citizen.Wait(5000)

        if (GetActivePlayerCount() > 0) then
            TrySpawnVehicles()
        end
    end
end)

-- loop to delete vehicles
Citizen.CreateThread(function()
    if (Config.deleteTimer <= 0) then
        return
    end

    while (true) do
        Citizen.Wait(60000 * (Config.deleteTimer - Config.deleteNotificationTimes[1]))

        TriggerClientEvent("AdvancedParking:notification", -1, string.format(Config.timeLeftNotification, Config.deleteNotificationTimes[1]))
        for i = 2, #Config.deleteNotificationTimes, 1 do
            Citizen.Wait(60000 * (Config.deleteNotificationTimes[i - 1] - Config.deleteNotificationTimes[i]))
            TriggerClientEvent("AdvancedParking:notification", -1, string.format(Config.timeLeftNotification, Config.deleteNotificationTimes[i]))
        end
        Citizen.Wait(60000 * Config.deleteNotificationTimes[#Config.deleteNotificationTimes])

        DeleteAllVehicles()
    end
end)



-- sync player position
RegisterServerEvent("AdvancedParking:syncPlayerPosition")
AddEventHandler("AdvancedParking:syncPlayerPosition", function(position)
    activePlayerPositions[source] = position
end)

-- player disconnected
AddEventHandler("playerDropped", function(disconnectReason)
    activePlayerPositions[source] = nil
end)

-- player entered a vehicle
RegisterServerEvent("AdvancedParking:enteredVehicle")
AddEventHandler("AdvancedParking:enteredVehicle", function(networkId, modifications)
    local vehicle = NetworkGetEntityFromNetworkId(networkId)

    if (DoesEntityExist(vehicle)) then
        local currentTime = os.time()
        
        local plate = GetVehicleNumberPlateText(vehicle)
        
        local position = GetEntityCoords(vehicle)
        position = vector3(math.floor(position.x * 100.0) / 100.0, math.floor(position.y * 100.0) / 100.0, math.floor(position.z * 100.0) / 100.0)
        local rotation = GetEntityRotation(vehicle)
        rotation = vector3(math.floor(rotation.x * 100.0) / 100.0, math.floor(rotation.y * 100.0) / 100.0, math.floor(rotation.z * 100.0) / 100.0)
        
        if (vehicles[plate]) then
            -- already on server list

            Log("Entered vehicle " .. plate .. ". Updating...")
            
            if (vehicles[plate].handle ~= vehicle) then
                if (DoesEntityExist(vehicles[plate].handle)) then
                    DeleteEntity(vehicles[plate].handle)
                end
                
                vehicles[plate].handle = vehicle
            end

            vehicles[plate].position = position
            vehicles[plate].rotation = rotation
            vehicles[plate].modifications = modifications
            vehicles[plate].lastUpdate = currentTime
            
            MySQL.Async.execute("UPDATE vehicle_parking SET posX = @posX, posY = @posY, posZ = @posZ, rotX = @rotX, rotY = @rotY, rotZ = @rotZ, modifications = @modifications, lastUpdate = @lastUpdate WHERE plate = @plate", {
                ["@plate"]          = plate,
                ["@posX"]           = vehicles[plate].position.x,
                ["@posY"]           = vehicles[plate].position.y,
                ["@posZ"]           = vehicles[plate].position.z,
                ["@rotX"]           = vehicles[plate].rotation.x,
                ["@rotY"]           = vehicles[plate].rotation.y,
                ["@rotZ"]           = vehicles[plate].rotation.z,
                ["@modifications"]  = json.encode(vehicles[plate].modifications),
                ["@lastUpdate"]     = vehicles[plate].lastUpdate
            })
        else
            -- insert in db
            
            Log("Entered vehicle " .. plate .. ". Inserting new...")

            vehicles[plate] = {
                handle          = vehicle,
                position        = position,
                rotation        = rotation,
                modifications   = modifications,
                lastUpdate      = currentTime,
	            spawning        = false
            }

            MySQL.Async.execute("INSERT INTO vehicle_parking (plate, posX, posY, posZ, rotX, rotY, rotZ, modifications, lastUpdate) VALUES (@plate, @posX, @posY, @posZ, @rotX, @rotY, @rotZ, @modifications, @lastUpdate)", {
                ["@plate"]          = plate,
                ["@posX"]           = vehicles[plate].position.x,
                ["@posY"]           = vehicles[plate].position.y,
                ["@posZ"]           = vehicles[plate].position.z,
                ["@rotX"]           = vehicles[plate].rotation.x,
                ["@rotY"]           = vehicles[plate].rotation.y,
                ["@rotZ"]           = vehicles[plate].rotation.z,
                ["@modifications"]  = json.encode(vehicles[plate].modifications),
                ["@lastUpdate"]     = vehicles[plate].lastUpdate
            })
        end
    else
        print("WTF IS HAPPENING")
    end
end)

-- player left a vehicle
RegisterServerEvent("AdvancedParking:leftVehicle")
AddEventHandler("AdvancedParking:leftVehicle", function(networkId, modifications)
    local vehicle = NetworkGetEntityFromNetworkId(networkId)

    if (DoesEntityExist(vehicle)) then
        local currentTime = os.time()
        
        local plate = GetVehicleNumberPlateText(vehicle)
        
        local position = GetEntityCoords(vehicle)
        position = vector3(math.floor(position.x * 100.0) / 100.0, math.floor(position.y * 100.0) / 100.0, math.floor(position.z * 100.0) / 100.0)
        local rotation = GetEntityRotation(vehicle)
        rotation = vector3(math.floor(rotation.x * 100.0) / 100.0, math.floor(rotation.y * 100.0) / 100.0, math.floor(rotation.z * 100.0) / 100.0)
        
        if (vehicles[plate]) then
            -- already on server list
            
            Log("Left vehicle " .. plate .. ". Updating...")
            
            if (vehicles[plate].handle ~= vehicle) then
                if (DoesEntityExist(vehicles[plate].handle)) then
                    DeleteEntity(vehicles[plate].handle)
                end
                
                vehicles[plate].handle = vehicle
            end

            vehicles[plate].position = position
            vehicles[plate].rotation = rotation
            vehicles[plate].modifications = modifications
            vehicles[plate].lastUpdate = currentTime

            MySQL.Async.execute("UPDATE vehicle_parking SET posX = @posX, posY = @posY, posZ = @posZ, rotX = @rotX, rotY = @rotY, rotZ = @rotZ, modifications = @modifications, lastUpdate = @lastUpdate WHERE plate = @plate",{
                ["@plate"]          = plate,
                ["@posX"]           = vehicles[plate].position.x,
                ["@posY"]           = vehicles[plate].position.y,
                ["@posZ"]           = vehicles[plate].position.z,
                ["@rotX"]           = vehicles[plate].rotation.x,
                ["@rotY"]           = vehicles[plate].rotation.y,
                ["@rotZ"]           = vehicles[plate].rotation.z,
                ["@modifications"]  = json.encode(vehicles[plate].modifications),
                ["@lastUpdate"]     = currentTime
            })
        else
            -- insert in db
            
            Log("Left vehicle " .. plate .. ". Inserting new...")
            
            vehicles[plate] = {
                handle          = vehicle,
                position        = position,
                rotation        = rotation,
                modifications   = modifications,
                lastUpdate      = currentTime,
	            spawning        = false
            }

            MySQL.Async.execute("INSERT INTO vehicle_parking (plate, posX, posY, posZ, rotX, rotY, rotZ, modifications, lastUpdate) VALUES (@plate, @posX, @posY, @posZ, @rotX, @rotY, @rotZ, @modifications, @lastUpdate)",{
                ["@plate"]          = plate,
                ["@posX"]           = vehicles[plate].position.x,
                ["@posY"]           = vehicles[plate].position.y,
                ["@posZ"]           = vehicles[plate].position.z,
                ["@rotX"]           = vehicles[plate].rotation.x,
                ["@rotY"]           = vehicles[plate].rotation.y,
                ["@rotZ"]           = vehicles[plate].rotation.z,
                ["@modifications"]  = json.encode(vehicles[plate].modifications),
                ["@lastUpdate"]     = vehicles[plate].lastUpdate
            })
        end
    end
end)

-- update a vehicle with its modifications
RegisterServerEvent("AdvancedParking:updateVehicle")
AddEventHandler("AdvancedParking:updateVehicle", function(networkId, modifications)
    local vehicle = NetworkGetEntityFromNetworkId(networkId)
    
    if (DoesEntityExist(vehicle)) then
        local currentTime = os.time()

        local plate = GetVehicleNumberPlateText(vehicle)
        
        local position = GetEntityCoords(vehicle)
        position = vector3(math.floor(position.x * 100.0) / 100.0, math.floor(position.y * 100.0) / 100.0, math.floor(position.z * 100.0) / 100.0)
        local rotation = GetEntityRotation(vehicle)
        rotation = vector3(math.floor(rotation.x * 100.0) / 100.0, math.floor(rotation.y * 100.0) / 100.0, math.floor(rotation.z * 100.0) / 100.0)
        
        if (vehicles[plate] ~= nil) then
            -- already on server list
            
            Log("Updating vehicle " .. plate)
            
            if (vehicles[plate].handle ~= vehicle) then
                if (DoesEntityExist(vehicles[plate].handle)) then
                    DeleteEntity(vehicles[plate].handle)
                end

                vehicles[plate].handle = vehicle
            end

            vehicles[plate].position = position
            vehicles[plate].rotation = rotation
            vehicles[plate].modifications = modifications
            vehicles[plate].lastUpdate = currentTime

            MySQL.Async.execute("UPDATE vehicle_parking SET posX = @posX, posY = @posY, posZ = @posZ, rotX = @rotX, rotY = @rotY, rotZ = @rotZ, modifications = @modifications, lastUpdate = @lastUpdate WHERE plate = @plate",{
                ["@plate"]          = plate,
                ["@posX"]           = vehicles[plate].position.x,
                ["@posY"]           = vehicles[plate].position.y,
                ["@posZ"]           = vehicles[plate].position.z,
                ["@rotX"]           = vehicles[plate].rotation.x,
                ["@rotY"]           = vehicles[plate].rotation.y,
                ["@rotZ"]           = vehicles[plate].rotation.z,
                ["@modifications"]  = json.encode(vehicles[plate].modifications),
                ["@lastUpdate"]     = vehicles[plate].lastUpdate
            })
        else
            -- insert in db
            
            Log("Updating vehicle " .. plate .. ". Inserting new...")
            
            vehicles[plate] = {
                handle          = vehicle,
                position        = position,
                rotation        = rotation,
                modifications   = modifications,
                lastUpdate      = currentTime,
	            spawning        = false
            }

            MySQL.Async.execute("INSERT INTO vehicle_parking (plate, posX, posY, posZ, rotX, rotY, rotZ, modifications, lastUpdate) VALUES (@plate, @posX, @posY, @posZ, @rotX, @rotY, @rotZ, @modifications, @lastUpdate)",{
                ["@plate"]          = plate,
                ["@posX"]           = vehicles[plate].position.x,
                ["@posY"]           = vehicles[plate].position.y,
                ["@posZ"]           = vehicles[plate].position.z,
                ["@rotX"]           = vehicles[plate].rotation.x,
                ["@rotY"]           = vehicles[plate].rotation.y,
                ["@rotZ"]           = vehicles[plate].rotation.z,
                ["@modifications"]  = json.encode(vehicles[plate].modifications),
                ["@lastUpdate"]     = vehicles[plate].lastUpdate
            })
        end
    end
end)

-- delete a vehicle from the table (and world) with its plate
RegisterServerEvent("AdvancedParking:deleteVehicle")
AddEventHandler("AdvancedParking:deleteVehicle", function(plate, deleteEntity)
    if (plate == nil) then
        print("^1AdvancedParking: \"plate\" was nil while trying to delete vehicle!")
        return
    end

    Log("Trying to delete " .. tostring(plate))

    if (vehicles[plate] ~= nil) then
        if (deleteEntity and DoesEntityExist(vehicles[plate].handle)) then
            DeleteEntity(vehicles[plate].handle)
        end

        vehicles[plate] = nil
        
        MySQL.Async.execute("DELETE FROM vehicle_parking WHERE plate = @plate",
        {
            ["@plate"] = plate
        })
    else
        local loadedVehicles = GetAllVehicles()
        local loadedVehicle = TryGetLoadedVehicle(plate, loadedVehicles)

        if (loadedVehicle ~= nil) then
            if (deleteEntity and DoesEntityExist(loadedVehicle)) then
                DeleteEntity(loadedVehicle)
            end
            
            MySQL.Async.execute("DELETE FROM vehicle_parking WHERE plate = @plate",
            {
                ["@plate"] = plate
            })
        end
    end
end)

-- checks if vehicles have to be spawned and spawns them if necessary
function TrySpawnVehicles()
    local loadedVehicles = GetAllVehicles()

    local playerVehiclePlates = {}
    for src, position in pairs(activePlayerPositions) do
        local ped = GetPlayerPed(src)
        local veh = GetVehiclePedIsIn(ped, false)

        if (DoesEntityExist(veh)) then
            table.insert(playerVehiclePlates, GetVehicleNumberPlateText(veh))
        end
    end

    -- check, if vehicles need to be spawned
    for plate, vehicleData in pairs(vehicles) do
        local closestPlayer, dist = GetClosestPlayerId(vehicleData.position)

        if (closestPlayer ~= nil and dist < Config.spawnDistance and not ContainsPlate(plate, playerVehiclePlates)) then
            if (vehicleData.handle ~= nil and DoesEntityExist(vehicleData.handle)) then
                -- vehicle found on server side
                -- check for changes
                
                local newPos = GetEntityCoords(vehicleData.handle)
                newPos = vector3(math.floor(newPos.x * 100.0) / 100.0, math.floor(newPos.y * 100.0) / 100.0, math.floor(newPos.z * 100.0) / 100.0)
                local newRot = GetEntityRotation(vehicleData.handle)
                newRot = vector3(math.floor(newRot.x * 100.0) / 100.0, math.floor(newRot.y * 100.0) / 100.0, math.floor(newRot.z * 100.0) / 100.0)
            
                local newLockStatus     = GetVehicleDoorLockStatus(vehicleData.handle)
                local newBodyHealth     = math.floor(GetVehicleBodyHealth(vehicleData.handle) * 10.0) / 10.0
                local newEngineHealth   = math.floor(GetVehicleEngineHealth(vehicleData.handle) * 10.0) / 10.0
                local newTankHealth     = math.floor(GetVehiclePetrolTankHealth(vehicleData.handle) * 10.0) / 10.0
                if (Vector3DistFast(vehicleData.position, newPos) > 1.0 
                    or GetRotationDifference(vehicleData.rotation, newRot) > 15.0
                    or newLockStatus ~= vehicleData.modifications[2]
                    or newBodyHealth ~= vehicleData.modifications[4]
                    or newEngineHealth ~= vehicleData.modifications[5]
                    or newTankHealth ~= vehicleData.modifications[6]
                ) then
                    vehicleData.modifications[2] = newLockStatus
                    vehicleData.modifications[4] = newBodyHealth
                    vehicleData.modifications[5] = newEngineHealth
                    vehicleData.modifications[6] = newTankHealth
                
                    Log("Updating vehicle " .. plate)

                    UpdateVehicle(plate, newPos, newRot, vehicleData.modifications)
                end
            else
                -- vehicle not found on server side
                -- check, if it is loaded differently

                local loadedVehicle = TryGetLoadedVehicle(plate, loadedVehicles)
                if (loadedVehicle ~= nil) then
                    -- vehicle Found
                    -- add values

                    vehicleData.handle = loadedVehicle
                
                    local newPos = GetEntityCoords(vehicleData.handle)
                    newPos = vector3(math.floor(newPos.x * 100.0) / 100.0, math.floor(newPos.y * 100.0) / 100.0, math.floor(newPos.z * 100.0) / 100.0)
                    local newRot = GetEntityRotation(vehicleData.handle)
                    newRot = vector3(math.floor(newRot.x * 100.0) / 100.0, math.floor(newRot.y * 100.0) / 100.0, math.floor(newRot.z * 100.0) / 100.0)
                
                    local newLockStatus     = GetVehicleDoorLockStatus(vehicleData.handle)
                    local newBodyHealth     = math.floor(GetVehicleBodyHealth(vehicleData.handle) * 10.0) / 10.0
                    local newEngineHealth   = math.floor(GetVehicleEngineHealth(vehicleData.handle) * 10.0) / 10.0
                    local newTankHealth     = math.floor(GetVehiclePetrolTankHealth(vehicleData.handle) * 10.0) / 10.0
                    if (Vector3Dist(vehicleData.position, newPos) > 1.0 
                        or GetRotationDifference(vehicleData.rotation, newRot) > 15.0
                        or newLockStatus ~= vehicleData.modifications[2]
                        or newBodyHealth ~= vehicleData.modifications[4]
                        or newEngineHealth ~= vehicleData.modifications[5]
                        or newTankHealth ~= vehicleData.modifications[6]
                    ) then
                        vehicleData.modifications[2] = newLockStatus
                        vehicleData.modifications[4] = newBodyHealth
                        vehicleData.modifications[5] = newEngineHealth
                        vehicleData.modifications[6] = newTankHealth
                    
                        Log("Updating vehicle NEW " .. plate)

                        UpdateVehicle(plate, newPos, newRot, vehicleData.modifications)
                    end
                elseif (not vehicleData.spawning) then
                    -- vehicle not found
                    -- try and spawn it
                    
                    local playerId, distance = GetClosestPlayerId(vehicleData.position)
                    if (playerId and distance < Config.spawnDistance) then
                        vehicleData.spawning = true

                        Citizen.CreateThread(function()
                            local vec4 = vector4(vehicleData.position.x, vehicleData.position.y, vehicleData.position.z, vehicleData.rotation.z)
                            local vehicle = Citizen.InvokeNative(GetHashKey("CREATE_AUTOMOBILE"), vehicleData.modifications[1], vec4.xyzw)

                            while (not DoesEntityExist(vehicle)) do
                                Citizen.Wait(0)
                            end

                            SetEntityCoords(vehicle, vehicleData.position.x, vehicleData.position.y, vehicleData.position.z)
                            SetEntityRotation(vehicle, vehicleData.rotation.x, vehicleData.rotation.y, vehicleData.rotation.z)

                            vehicleData.spawning = false
                            vehicleData.handle = vehicle

                            while (NetworkGetEntityOwner(vehicleData.handle) == -1) do
                                Citizen.Wait(0)
                            end

                            Log("Creating vehicle " .. plate .. " at " .. tostring(vehicleData.position) .. "\n at entity owner " .. tostring(NetworkGetEntityOwner(vehicleData.handle)))

                            TriggerClientEvent("AdvancedParking:setVehicleMods", NetworkGetEntityOwner(vehicleData.handle), NetworkGetNetworkIdFromEntity(vehicleData.handle), plate, vehicleData.modifications, vehicleData.position)
                        end)
                    end
                end
            end
        end
    end
end

RegisterServerEvent("AdvancedParking:setVehicleModsFailed")
AddEventHandler("AdvancedParking:setVehicleModsFailed", function(plate)
    Log("Setting mods failed... retrying...")

    if (vehicles[plate] and vehicles[plate].handle and DoesEntityExist(vehicles[plate].handle)) then
        Citizen.CreateThread(function()
            while (true) do
                Citizen.Wait(500)
                
                local closestPlayer, dist = GetClosestPlayerId(vehicles[plate].position)
                if (closestPlayer ~= nil and dist < Config.spawnDistance) then
                    TriggerClientEvent("AdvancedParking:setVehicleMods", NetworkGetEntityOwner(vehicles[plate].handle), NetworkGetNetworkIdFromEntity(vehicles[plate].handle), plate, vehicles[plate].modifications, vehicles[plate].position)
                    return
                end
            end
        end)
    end
end)

RegisterServerEvent("AdvancedParking:updatePlate")
AddEventHandler("AdvancedParking:updatePlate", function(oldPlate, newPlate)
    if (oldPlate == nil or newPlate == nil) then
        print("^1AdvancedParking: \"oldPlate\" or \"newPlate\" was nil while trying to update a plate!")
        return
    end

    if (vehicles[oldPlate]) then
        if (vehicles[newPlate]) then
            Log("Updating plate failed. New plate was already there!")
        else
            vehicles[newPlate] = vehicles[oldPlate]
            vehicles[oldPlate] = nil
            
            Log("Updating plate successful!")

            MySQL.Async.execute("UPDATE vehicle_parking SET plate = @newPlate WHERE plate = @oldPlate",
            {
                ["@newPlate"] = newPlate,
                ["@oldPlate"] = oldPlate
            })
        end
    else
        Log("Updating plate failed or unnecessary. Old plate was not found!")
    end
end)

function UpdateVehicle(plate, position, rotation, modifications)
    vehicles[plate].position = position
    vehicles[plate].rotation = rotation
    vehicles[plate].modifications = modifications

    MySQL.Async.execute("UPDATE vehicle_parking SET posX = @posX, posY = @posY, posZ = @posZ, rotX = @rotX, rotY = @rotY, rotZ = @rotZ, modifications = @modifications WHERE plate = @plate",
    {
        ["@posX"]           = vehicles[plate].position.x,
        ["@posY"]           = vehicles[plate].position.y,
        ["@posZ"]           = vehicles[plate].position.z,
        ["@rotX"]           = vehicles[plate].rotation.x,
        ["@rotY"]           = vehicles[plate].rotation.y,
        ["@rotZ"]           = vehicles[plate].rotation.z,
        ["@modifications"]  = json.encode(vehicles[plate].modifications),
        ["@plate"]          = plate
    })
end

function DeleteAllVehicles()
    TriggerClientEvent("AdvancedParking:notification", -1, Config.deleteNotification)

    local peds = GetAllPeds()
    local playerPeds = {}
    for i = 1, #peds, 1 do
        if (IsPedAPlayer(peds[i])) then
            table.insert(playerPeds, peds[i])
        end
    end

    if (#playerPeds == 0) then
        return
    end
    
    local time = GetGameTimer()

    local vehs = GetAllVehicles()
    local deleted = 0
    for i = 1, #vehs, 1 do
        if (not IsAnyPlayerInsideVehicle(vehs[i], playerPeds)) then
            local closestPlayer, distance = GetClosestPlayerPed(GetEntityCoords(vehs[i]), playerPeds)
            if (closestPlayer ~= nil and distance > Config.deleteDistance) then
                local plate = GetVehicleNumberPlateText(vehs[i])
                if (vehicles[plate] ~= nil) then
                    vehicles[plate] = nil
                    
                    MySQL.Async.execute("DELETE FROM vehicle_parking WHERE plate = @plate",
                    {
                        ["@plate"] = plate
                    })
                end

                DeleteEntity(vehs[i])

                deleted = deleted + 1
            end
        end
    end
    
    Log("Deleted " .. tostring(deleted) .. "/" .. tostring(#vehs) .. " vehicles. Took " .. tostring((GetGameTimer() - time) / 1000.0) .. "sec")
end

-- render entity scorched (trigger with netid of the vehicle and false when repairing)
RegisterServerEvent("AdvancedParking:renderScorched")
AddEventHandler("AdvancedParking:renderScorched", function(vehicleNetId, scorched)
    local vehicleHandle = NetworkGetEntityFromNetworkId(vehicleNetId)
    if (DoesEntityExist(vehicleHandle)) then
        TriggerClientEvent("AdvancedParking:renderScorched", -1, vehicleNetId, scorched)
    end
end)

-- return all vehicles plates and positions via a search string
AddEventHandler("AdvancedParking:getVehiclePosition", function(searchString, cb)
	local foundVehicles = {}

	for plate, veh in pairs(vehicles) do
		if (plate:find(searchString)) then
			table.insert(foundVehicles, {
                plate = plate,
                position = veh.position
            })
		end
	end

    cb(foundVehicles)
end)

-- if vehicle is in the world
RegisterServerEvent("AdvancedParking:doesVehicleExistInWorld")
AddEventHandler("AdvancedParking:doesVehicleExistInWorld", function(plate)
    if (vehicles[plate]) then
        TriggerClientEvent("AdvancedParking:vehicleExistsInWorld", source, plate, true)
        return
    end

    local vehs = GetAllVehicles()
    for k, veh in pairs(vehs) do
        if (DoesEntityExist(veh) and GetVehicleNumberPlateText(veh) == plate) then
            TriggerClientEvent("AdvancedParking:vehicleExistsInWorld", source, plate, true)
            return
        end
    end
        
    TriggerClientEvent("AdvancedParking:vehicleExistsInWorld", source, plate, false)
end)
