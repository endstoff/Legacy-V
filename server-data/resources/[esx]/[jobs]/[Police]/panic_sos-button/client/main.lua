--[[
    ESX LOADING
]]

ESX = nil  

local PlayerData = {}
local xPlayer

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(100)
	end

	PlayerLoaded = true
	ESX.PlayerData = ESX.GetPlayerData()
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	ESX.PlayerData = xPlayer
	PlayerLoaded = true
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	ESX.PlayerData.job = job
end)

--[[
    ESX LOADING END
]]


--[[
    VARIABLEN SETZTEN
]]
    local cd = 0 -- Sekunden Cooldown
    local sended = false

--[[
    VARIABLEN SETZTEN END
]]

--[[
    ESX LOAD NATIVES
]]
--
--[[
    ESX LOAD NATIVES END
]]

RegisterNetEvent('panic_sos-button:useButton')
AddEventHandler('panic_sos-button:useButton', function()
    if (ESX.PlayerData.job.label == 'LSPD') or (ESX.PlayerData.job.label ==  'Notdienst') then 
        useIt()
    else 
        ESX.ShowNotification("Du weißt nicht wie das Funktioniert!")
    end
end)
--[[
Citizen.CreateThread(function()
    while true do 
        Citizen.Wait(0)
            if IsControlJustReleased(0, 56) then 
                useIt()
            end
    end
end)
]]
local emsEmoji = "[NOTKNOPF]"
local usePD = "Ein Officer hat den Panic Button betätigt"
local useMD = "Ein Mediziner hat den Panic Button betätigt"
local labeltoSend = "LSPD"
local num = 'LSPD'

function useIt()
    local playerPed = PlayerPedId()
	local coords    = GetEntityCoords(playerPed)
	local position = {x = coords.x, y = coords.y, z = coords.z}
            if cd > 0 then 
                ESX.ShowNotification('Bitte probiere dies erneut in ' .. cd .. 'Sekunden')
            else 
                cd = 120 -- Set Cooldown to 120 Seconds
                -- TriggerServerEvent('panic_sos-button:notrufSend', GetPlayerServerId(PlayerId()), position)
               -- TriggerServerEvent("d-phone:server:sendservicemessage", GetPlayerServerId(PlayerId()), "Officer hat einen Notknopf gedrückt", "LSPD", 0, 1, position, "5")
               -- TriggerEvent("d-notification", "Notruf Gesendet", 5000,  "rgba(255, 0, 0, 0.8)")
                if (ESX.PlayerData.job.label == 'LSPD') then  
               -- TriggerServerEvent("d-phone:server:sendservicemessage", GetPlayerServerId(PlayerId()), usePD, labeltoSend, 0, 1, position, "5")
                TriggerServerEvent("d-phone:server:sendgps", GetPlayerServerId(PlayerId()), num, position)
                Citizen.Wait(500)
                TriggerServerEvent("d-phone:server:sendmessage", GetPlayerServerId(PlayerId()), emsEmoji..' '..usePD, num)
                sended = true  
                end 
                if (ESX.PlayerData.job.label == 'Notdienst') then 
               -- TriggerServerEvent("d-phone:server:sendservicemessage", GetPlayerServerId(PlayerId()), useMD, labeltoSend, 0, 1, position, "5")
                TriggerServerEvent("d-phone:server:sendgps", GetPlayerServerId(PlayerId()), num, position)
                Citizen.Wait(500)
                TriggerServerEvent("d-phone:server:sendmessage", GetPlayerServerId(PlayerId()), emsEmoji..' '..useMD, num)
                sended = true 
                end

                if sended then 
                TriggerEvent("d-notification", "Notruf wurde gesendet", 5000,  "rgba(255, 0, 0, 0.8)")
                sended = false
                else 
                TriggerEvent("d-notification", "Notruf konnte nicht zu gesendet werden", 5000, "rgba(255, 0, 0, 0.8)")
                sended = false
                end
            end
end
Citizen.CreateThread(function()
    while true do 
        Citizen.Wait(0)
        if cd > 0 then 
            Citizen.Wait(1000)
            cd = cd - 1
        end
    end
end)