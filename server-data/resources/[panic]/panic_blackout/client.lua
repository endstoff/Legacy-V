ESX                           = nil
DRP = {}
local Pos1 = false 
local Pos2 = false 
local Pos3 = false 
local pz = 0
local pzn = 3
local Pos1In = false 
local Pos2In = false 
local Pos3In = false 
local Cooldown = 0
local Frozen = false
Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

end)

-- Pos1
Citizen.CreateThread(function()
    while true do 
    Citizen.Wait(1)
        local playerPos = GetEntityCoords(PlayerPedId(), true)
        local distance = Vdist(playerPos.x, playerPos.y, playerPos.z, 2137.73, 1949.59, 93.79)
        
        if distance < 1.0 then 
            if Pos1In == true then 
            else 
                Pos1In = true 
               -- exports['mythic_notify']:DoHudText('success', 'You Joined The Action Zone!', { ['background-color'] = '#ffffff', ['color'] = '#000000' })
            end
        end
        if (Pos1In == true) then 
            if distance > 1.0 then 
                Pos1In = false 
               -- exports['mythic_notify']:DoHudText('error', 'You Left The Action Zone!', { ['background-color'] = '#ffffff', ['color'] = '#000000' })
            end
        end
    end
end)

-- Pos2 

Citizen.CreateThread(function()
    while true do 
    Citizen.Wait(1)
        local playerPos = GetEntityCoords(PlayerPedId(), true)
        local distance = Vdist(playerPos.x, playerPos.y, playerPos.z, 2835.29, 1505.67, 24.73)
        
        if distance < 1.0 then 
            if Pos2In == true then 
            else 
                Pos2In = true 
               -- exports['mythic_notify']:DoHudText('success', 'You Joined The Action Zone!', { ['background-color'] = '#ffffff', ['color'] = '#000000' })
            end
        end
        if (Pos2In == true) then 
            if distance > 1.0 then 
                Pos2In = false 
               -- exports['mythic_notify']:DoHudText('error', 'You Left The Action Zone!', { ['background-color'] = '#ffffff', ['color'] = '#000000' })
            end
        end
    end
end)
Citizen.CreateThread(function()
    while true do 
    Citizen.Wait(1)
        local playerPos = GetEntityCoords(PlayerPedId(), true)
        local distance = Vdist(playerPos.x, playerPos.y, playerPos.z, 2279.17, 1718.05, 68.04)
        
        if distance < 1.0 then 
            if Pos3In == true then 
            else 
                Pos3In = true 
               -- exports['mythic_notify']:DoHudText('success', 'You Joined The Action Zone!', { ['background-color'] = '#ffffff', ['color'] = '#000000' })
            end
        end
        if (Pos3In == true) then 
            if distance > 1.0 then 
                Pos3In = false 
               -- exports['mythic_notify']:DoHudText('error', 'You Left The Action Zone!', { ['background-color'] = '#ffffff', ['color'] = '#000000' })
            end
        end
    end
end)

-- Pos3 

-- Pos4 

-- Pos5


-- Pos1 
Citizen.CreateThread(function()
    while true do 
        Citizen.Wait(0)

        if IsControlJustPressed(1, 38) then 

            if (Pos1In == true) then 
                if (Pos1 == false) then 
                    if (Cooldown == 0) then 
                        if (Frozen == false) then 
                            FreezePlayer()
                            ExecuteCommand('e weld')
                            Citizen.Wait(30000)
                            ClearPedTasksImmediately(GetPlayerPed(-1))
                            ExecuteCommand('e hammer')
                            Citizen.Wait(60000)
                            UnFreezePlayer()
                            Pos1 = true
                        else 
                            UnFreezePlayer()
                        end
                    else 
                    exports['mythic_notify']:DoHudText('inform', 'Bitte warte noch ' .. Cooldown .. ' Sekunden!', { ['background-color'] = '#454545', ['color'] = '#ffffff' })
                    end
                else 
                exports['mythic_notify']:DoHudText('success', 'Du hast den Generator bereits zerstört', { ['background-color'] = '#ffffff', ['color'] = '#000000' })
                end
            end
        end
    end
end)
-- Pos2
Citizen.CreateThread(function()
    while true do 
        Citizen.Wait(0)

        if IsControlJustPressed(1, 38) then 

            if (Pos2In == true) then 
                if (Pos2 == false) then 
                    if (Cooldown == 0) then 
                        if (Frozen == false) then 
                            FreezePlayer() 
                            ExecuteCommand('e weld')
                            Citizen.Wait(30000)
                            ClearPedTasksImmediately(GetPlayerPed(-1))
                            ExecuteCommand('e hammer')
                            Citizen.Wait(60000)
                            UnFreezePlayer()
                            Pos2 = true
                        else 
                            UnFreezePlayer()
                        end
                    else 
                    exports['mythic_notify']:DoHudText('inform', 'Bitte warte noch ' .. Cooldown .. ' Sekunden!', { ['background-color'] = '#454545', ['color'] = '#ffffff' })
                    end
                else 
                exports['mythic_notify']:DoHudText('success', 'Du hast den Generator bereits zerstört', { ['background-color'] = '#ffffff', ['color'] = '#000000' })
                end
            end
        end
    end
end)
-- Pos3 
Citizen.CreateThread(function()
    while true do 
        Citizen.Wait(0)

        if IsControlJustPressed(1, 38) then 

            if (Pos3In == true) then 
                if (Pos3 == false) then 
                    if (Cooldown == 0) then 
                        if (Frozen == false) then 
                            FreezePlayer() 
                            ExecuteCommand('e weld')
                            Citizen.Wait(30000)
                            ClearPedTasksImmediately(GetPlayerPed(-1))
                            ExecuteCommand('e hammer')
                            Citizen.Wait(60000)
                            UnFreezePlayer()
                            Pos3 = true
                        else 
                            UnFreezePlayer()
                        end
                    else 
                    exports['mythic_notify']:DoHudText('inform', 'Bitte warte noch ' .. Cooldown .. ' Sekunden!', { ['background-color'] = '#454545', ['color'] = '#ffffff' })
                    end
                else 
                exports['mythic_notify']:DoHudText('success', 'Du hast den Generator bereits zerstört', { ['background-color'] = '#ffffff', ['color'] = '#000000' })
                end
            end
        end
    end
end)
function FreezePlayer()
    FreezeEntityPosition(GetPlayerPed(-1), true)
    Frozen = true 
    exports['mythic_notify']:DoHudText('inform', 'Du zerstörst den Generator!', { ['background-color'] = '#454545', ['color'] = '#000000' })
    -- Citizen.Wait(500)
   --  DRP.On = true 
    -- TriggerEvent('panic_blackout:changeToBlackout')
end

function UnFreezePlayer()
    FreezeEntityPosition(GetPlayerPed(-1), false)
    Frozen = false
    local ped = GetPlayerPed(-1)
    if Frozen == false then
        local playerCoords = GetEntityCoords(ped)
        SetEntityCoords(ped, playerCoords.x, playerCoords.y, playerCoords.z, false, false, false, false)
        ClearPedTasksImmediately(GetPlayerPed(-1))
    end
    pz = pz + 1
    exports['mythic_notify']:DoHudText('error', 'Du hast den Generator zerstört! ' .. pz .. '/' .. pzn, { ['background-color'] = '#454545', ['color'] = '#000000' })
    -- Citizen.Wait(500)
    -- TriggerEvent('panic_blackout:changeToClear')
end

RegisterCommand('generators', function()
    Citizen.Wait(0)

    ExecuteCommand('e think')
    Citizen.Wait(5000)
    ClearPedTasksImmediately(GetPlayerPed(-1))
    exports['mythic_notify']:DoHudText('inform', 'Du hast ' .. pz .. '/' .. pzn .. ' Generatoren zerstört', { ['background-color'] = '#454545', ['color'] = '#000000' })
end)

RegisterCommand('debug3', function()
    Citizen.Wait(0)

    Pos1 = true 
    Pos2 = true 
    Pos3 = true
    pz = 3
    exports['mythic_notify']:DoHudText('inform', 'Du hast ' .. pz .. '/' .. pzn .. ' Generatoren zerstört', { ['background-color'] = '#454545', ['color'] = '#000000' })
end)

Citizen.CreateThread(function()
    while true do 
        Citizen.Wait(0)
        if pz == 3 then 
            pz = 0
            Pos1 = false 
            Pos2 = false 
            Pos3 = false 
            -- CHANGE WEATHER 
            -- FUNCTION 
            -- INSERT HERE 
            print('Scs set value')
            TriggerServerEvent('panic_blackout:weatherBlackout')
            Cooldown = 1800 --s (30min)
        end
    end
end)

Citizen.CreateThread(function()
    while true do 
        Citizen.Wait(1000)
        if Cooldown > 0 then 
            Cooldown = Cooldown - 1
        end
    end
end)
-- TriggerClientEvent('vSync:updateWeather', -1, CurrentWeather, blackout)
-- TriggerClientEvent('vSync:updateWeather', -1, CurrentWeather, clear)