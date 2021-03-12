

local open = false
local ESX  = nil
 

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end
end)
 

RegisterNetEvent('est_dienstausweis_lspd:open')
AddEventHandler('est_dienstausweis_lspd:open', function( data, type )
    open = true
    SendNUIMessage({
        action = "open",
        array  = data,
        type   = type
    })
end)

Citizen.CreateThread(function()
    while true do
        Wait(0)
        if IsControlJustReleased(0, 322) and open or IsControlJustReleased(0, 177) and open then
            SendNUIMessage({
                action = "close"
            })
            open = false
        end
    end
end)