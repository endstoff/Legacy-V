ESX               = nil
local isDead = false 
local v1 = false
local v2 = false 
local Stunned = false 
Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

end)


-- CHECKT OB SPIELER TOT IST
Citizen.CreateThread(function()
    while true do 
        Citizen.Wait(0)
        local ped = GetPlayerPed(-1)
        local health = GetEntityHealth(ped)
        if health < 1 then 
            isDead = true 
            print('is dead')
        else 
            isDead = false 
        end
    end
end)

-- CHECKT WAFFE 
Citizen.CreateThread(function()
    while true do 
        Citizen.Wait(0)
        if (isDead == true) then 
            local ped = GetPlayerPed(-1)
            local playerPed = PlayerPedId()
            local kbw = GetPedCauseOfDeath(playerPed)
            local r = GetHashKey(kbw)
            local w = GetHashKey('WEAPON_SMG')
            local xPlayer = PlayerPedId()
            print('KW TEST')
            if (r == w) then 
                Citizen.Wait(500)
                Revive()
                xPlayer.triggerServerEvent('esx_ambulancejob:revive')
	            xPlayer.triggerServerEvent('visn_are:resetValues')
                AnimpostfxPlay("LostTimeNight", 10000001, true)
                print('Killed by SMG')
                Stunned = true 
                Citizen.Wait(10000)
                Stunned = false 
                AnimpostfxStopAll()
                ClearPedTasksImmediately(ped)
            end 
        end
    end
end)

Citizen.CreateThread(function()
    while true do 
        Citizen.Wait(0)
        if (Stunned == true) then 
            Citizen.Wait(100)
            TaskStartScenarioInPlace(playerPed, "timetable@tracy@sleep@", 0, 1)
            if (v1 == false) then
                print('Stunned = true')
            end
            v1 = true 
        end
    end
end)

function Revive()
    local playerPed = PlayerPedId()
	local coords = GetEntityCoords(playerPed)
	TriggerServerEvent('esx_ambulancejob:setDeathStatus', false)

	DoScreenFadeOut(800)

	while not IsScreenFadedOut() do
		Citizen.Wait(50)
	end

	local formattedCoords = {
		x = ESX.Math.Round(coords.x, 1),
		y = ESX.Math.Round(coords.y, 1),
		z = ESX.Math.Round(coords.z, 1)
	}

	RespawnPed(playerPed, formattedCoords, 0.0)

	StopScreenEffect('DeathFailOut')
	DoScreenFadeIn(800)
end
