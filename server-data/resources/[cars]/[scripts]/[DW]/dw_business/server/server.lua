ESX = nil

local playerFueling    = {}

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)


ESX.RegisterServerCallback('dreamwork_business:getRealName', function(source, cb, identifier, stationID)
    local xPlayer = ESX.GetPlayerFromId(source)
    
    MySQL.Async.fetchAll('SELECT firstname, lastname FROM users WHERE identifier = @identifier', {
        ['@identifier'] = identifier
    }, function(result)
        MySQL.Async.fetchAll('SELECT stationOwner FROM stations WHERE stationID = @stationID', {
            ['@stationID'] = stationID
        }, function(result2)

            local firstname = result[1].firstname
            local lastname  = result[1].lastname
            local stationOwner  = result2[1].stationOwner
            local ownIdentifier = xPlayer.identifier

            local data = {
                firstname = firstname,
                lastname  = lastname,
                stationOwner  = stationOwner,
                ownIdentifier = ownIdentifier
            }
            
            cb(data)
        end)
    end)
end)

ESX.RegisterServerCallback('dreamwork_business:getStation', function(source, cb, stationID)
    local xPlayer = ESX.GetPlayerFromId(source)

    MySQL.Async.fetchAll('SELECT * FROM stations WHERE stationID = @stationID', {
        ['@stationID'] = stationID
    }, function(result)
        local status = result[1].stationStatus
        local cost  = result[1].stationCost
        local name  = result[1].stationName
        local owner = result[1].stationOwner
        local ppl = result[1].stationPPL
        local money = result[1].stationMoney
        local buymessage = result[1].stationBuyMessage
        local fuel = result[1].stationFuel

        local data = {
            status = status,
            cost  = cost,
            name  = name,
            owner = owner,
            ppl = ppl,
            money = money,
            buymessage = buymessage,
            fuel = fuel,
        }
        
        cb(data)
    end)
end)

RegisterServerEvent('dreamwork_business:updateStation')
AddEventHandler('dreamwork_business:updateStation', function(stationID, identifier, name, ppl, buymessage)	
    MySQL.Async.execute('UPDATE stations SET stationName=@newName, stationPPL=@newPPL, stationBuyMessage=@newBMessage WHERE stationID=@stationid',
	{
		['@stationid'] = stationID,
		['@owner'] = identifier,
		['@newName'] = name,
		['@newPPL'] = ppl,
		['@newBMessage'] = buymessage,
	}, function (rowsChanged)
	end)
end)

RegisterServerEvent('dreamwork_business:buyStation')
AddEventHandler('dreamwork_business:buyStation', function(stationID, stationPrice)	
    local xPlayer = ESX.GetPlayerFromId(source)

    if xPlayer.getMoney() >= stationPrice then
        xPlayer.removeMoney(stationPrice)

        MySQL.Async.execute('UPDATE stations SET stationOwner=@newOwner, stationStatus=@newStatus, stationFuel=@newFuel WHERE stationID=@stationid',
        {
            ['@stationid'] = stationID,
            ['@newOwner'] = xPlayer.identifier,
            ['@newStatus'] = "TYPE_SELLED",
            ['@newFuel'] = 50000,
        }, function (rowsChanged)
        end)
    end
end)

RegisterServerEvent('dreamwork_business:removeFuel')
AddEventHandler('dreamwork_business:removeFuel', function(stationID, fuelAmount)	

    if fuelAmount < 0 then
        fuelAmount = 0
    end

    MySQL.Async.execute('UPDATE stations SET stationFuel=@fuelAmount WHERE stationID=@stationid',
	{
		['@stationid'] = stationID,
		['@fuelAmount'] = fuelAmount,
	}, function (rowsChanged)
	end)
end)

RegisterServerEvent('dreamwork_business:addSafe')
AddEventHandler('dreamwork_business:addSafe', function(stationID, money)	

    if money < 0 then
        money = 0
    end

    MySQL.Async.execute('UPDATE stations SET stationMoney=@newMoney WHERE stationID=@stationid',
	{
		['@stationid'] = stationID,
		['@newMoney'] = money,
	}, function (rowsChanged)
	end)
end)

RegisterServerEvent('dreamwork_business:removeSafe')
AddEventHandler('dreamwork_business:removeSafe', function(stationID, money, playerMoney)	
    local xPlayer = ESX.GetPlayerFromId(source)

    if money < 0 then
        money = 0
    end

    MySQL.Async.execute('UPDATE stations SET stationMoney=@newMoney WHERE stationID=@stationid',
	{
		['@stationid'] = stationID,
		['@newMoney'] = money,
	}, function (rowsChanged)
    end)
    
    xPlayer.addMoney(playerMoney)
end)

RegisterServerEvent('dreamwork_business:setFuel')
AddEventHandler('dreamwork_business:setFuel', function(stationID, setAmount)	
    if setAmount < 0 then
        setAmount = 0
    end

    MySQL.Async.execute('UPDATE stations SET stationFuel=@newFuel WHERE stationID=@stationid',
	{
		['@stationid'] = stationID,
		['@newFuel'] = setAmount,
	}, function (rowsChanged)
    end)
end)

RegisterServerEvent('dreamwork_business:sellStation')
AddEventHandler('dreamwork_business:sellStation', function(stationID, stationPrice)	    
    local xPlayer = ESX.GetPlayerFromId(source)
    xPlayer.addMoney(tonumber(stationPrice))

    MySQL.Async.execute('UPDATE stations SET stationOwner=@newOwner, stationStatus=@newStatus, stationBuyMessage=@newMessage, stationPPL=@newPPL, stationMoney=@newMoney, stationName=@newName WHERE stationID=@stationid',
	{
		['@stationid'] = stationID,
		['@newOwner'] = "",
		['@newName'] = "Freie Tankstelle",
		['@newStatus'] = "TYPE_FREE",
		['@newMessage'] = "Vielen Dank für Ihren Einkauf.",
		['@newPPL'] = 0,
		['@newMoney'] = 0,
	}, function (rowsChanged)
	end)
end)


local function refuel(source, stationId)

	SetTimeout(1500, function()
		if playerFueling[source] then
			local xPlayer = ESX.GetPlayerFromId(source)
            local quantity = xPlayer.getInventoryItem('petrol_raffin').count

            if quantity < 2 then
               --TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = 'Du hast nicht genügend raffiniertes Öl bei Dir, um den Prozess fortzusetzen.' })
                TriggerClientEvent('notify', source, 3, "", "Du hast nicht genügend raffiniertes Öl bei Dir, um den Prozess fortzusetzen")
            else
                local fuel = 0

                MySQL.Async.fetchAll('SELECT stationFuel FROM stations WHERE stationID = @stationID', {
                    ['@stationID'] = stationId
                }, function(result)
                    fuel = result[1].stationFuel + 2
                    
                --    TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'success', text = '2 Liter raffiniertes Öl wurden zum Tank der Tankstelle hinzugefügt.' })
                    TriggerClientEvent('notify', source, 2, "", "2 Liter raffiniertes Öl wurden zum Tank der Tankstelle hinzugefügt")
                    
                    xPlayer.removeInventoryItem('petrol_raffin', 2)
                    xPlayer.addAccountMoney('money', 6)
                    TriggerEvent('dreamwork_business:removeFuel', stationId, fuel)
                end)

                refuel(source, stationId)
            end
        end
	end)
end

RegisterServerEvent('dreamwork_business:stopRefuel')
AddEventHandler('dreamwork_business:stopRefuel', function()
	local _source = source

	playerFueling[_source] = false
end)

RegisterServerEvent('dreamwork_business:startRefuel')
AddEventHandler('dreamwork_business:startRefuel', function(stationID)
    playerFueling[source] = true

    refuel(source, stationID)
end)