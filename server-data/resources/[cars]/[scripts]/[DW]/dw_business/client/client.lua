ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

function EnableGui(enable)

	SetNuiFocus(enable, enable)
    guiEnabled = enable	
    
    SendNUIMessage({
		type = "enableui",
		enable = enable
	})
end

RegisterNetEvent('dreamwork_business:openStation')
AddEventHandler('dreamwork_business:openStation', function(stationID)

    ESX.TriggerServerCallback('dreamwork_business:getStation', function(stationData)

        local stID = stationID
        local status = stationData.status
        local cost = stationData.cost
        local name = stationData.name
        local owner = stationData.owner
        local ppl = stationData.ppl
        local money = stationData.money
        local buymessage = stationData.buymessage
        local fuel = stationData.fuel

        if starts_with(owner, 'steam:') then
            ESX.TriggerServerCallback('dreamwork_business:getRealName', function(nameData)
                SendNUIMessage({
                    type = "loadStation",
                    stationid = stID,
                    status = status,
                    cost = cost,
                    name = name,
                    owner = nameData.firstname .. ' ' .. nameData.lastname,
                    ppl = ppl,
                    money = money,
                    buyMessage = buymessage,
                    fuel = fuel,
                    identifier = owner,
                    isAdmin = nameData.stationOwner == nameData.ownIdentifier,
                })     

                EnableGui(true)       
            end, owner, stationID)
        else
            SendNUIMessage({
                type = "loadStation",  
                stationid = stID, 
                status = "TYPE_FREE",
                cost = cost,
                name = "",
                owner = "",
                ppl = 0,
                money = 0,
                buyMessage = "Vielen Dank für Ihren Einkauf.",
                fuel = 0,
                identifier = "",
                isAdmin = false,
            })

            EnableGui(true)
        end
    end, stationID)
end)

RegisterNetEvent('dreamwork_business:status')
AddEventHandler('dreamwork_business:status', function(status)
    EnableGui(status)
end)
RegisterNUICallback('enable', function(state)
    EnableGui(state)
end)

RegisterNUICallback('buyStation', function(data)
    TriggerServerEvent('dreamwork_business:buyStation', data.id, data.price)
end)

RegisterNUICallback('sellStation', function(data)
    TriggerServerEvent('dreamwork_business:sellStation', data.id, data.price)
end)

RegisterNUICallback('reload', function(data)
    TriggerEvent('dreamwork_business:openStation', data.id)
end)

RegisterNUICallback('payout', function(data)
    print(data.money)
    ESX.TriggerServerCallback('dreamwork_business:getStation', function(stationData)
        if stationData.money >= data.money then
            SendNUIMessage({type = "sendToast", message = "Der angegebene Betrag wurde erfolgreich ausgezahlt.", color = "COLOR_SUCCESS"})
            TriggerServerEvent('dreamwork_business:removeSafe', data.id, stationData.money - data.money, data.money)
            SendNUIMessage({type = "updateMoneyValue", value = stationData.money - data.money})
        else
            SendNUIMessage({type = "sendToast", message = "Es befindet sich nicht genügend Guthaben im Tresor um diesen Betrag auszuzahlen.", color = "COLOR_ERROR"})
        end
    end, data.id)
end)

RegisterNUICallback('updateStation', function(data)
    TriggerServerEvent('dreamwork_business:updateStation', data.id, data.owner, data.name, data.ppl, data.bmi)
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)

        if guiEnabled then
            local ply = GetPlayerPed(-1)
            local active = true

            DisablePlayerFiring(ply, true) -- Disable weapon firing
            DisableControlAction(0, 142, active) -- MeleeAttackAlternate
            DisableControlAction(0, 288, active) -- MeleeAttackAlternate
            DisableControlAction(0, 106, active) -- VehicleMouseControlOverride
            if IsDisabledControlJustReleased(0, 142) then -- MeleeAttackAlternate
                SendNUIMessage({type = "click"})
            end
        end
    end
end)

function starts_with(str, start)
    return str:sub(1, #start) == start
end

