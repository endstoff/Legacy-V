local ESX = nil
local WarehouseOwner = {}
local highestID = 0

TriggerEvent('esx:getSharedObject', function(obj) 
    ESX = obj 
end)

MySQL.ready(function()
    MySQL.Async.fetchAll('SELECT * from Warehouse_owner', {},
        function(result)
            if #result > 0 then
                for k, Warehouse_owner_res in pairs(result) do
                    table.insert(WarehouseOwner, {
                        id = Warehouse_owner_res.id,
                        owner = Warehouse_owner_res.owner,
                        name = Warehouse_owner_res.Warehouse,
                        type = Warehouse_owner_res.type,
                        upgraded = Warehouse_owner_res.upgraded,
                        vehicle = Warehouse_owner_res.vehicle,
                        store = Warehouse_owner_res.store,
                        finish = Warehouse_owner_res.finish,
                        lastlogin = Warehouse_owner_res.lastlogin,
						trusted = json.decode(Warehouse_owner_res.trusted),
                    })
                    highestID = Warehouse_owner_res.id
                end
            end
        end
    )
end)

RegisterServerEvent('hd_postop:updateIdentifier')
AddEventHandler('hd_postop:updateIdentifier', function(src, oldidentifier, newidentifier)
	
	for k, Warehouse in pairs(WarehouseOwner) do
		for k2, trust in pairs(Warehouse.trusted) do
			if trust.steamID == oldidentifier then
				trust.steamID = newidentifier
				MySQL.Async.execute('UPDATE Warehouse_owner SET trusted=@trusted WHERE id=@WarehouseID LIMIT 1',
				{
                ['@trusted'] = json.encode(Warehouse.trusted),
                ['@WarehouseID'] = Warehouse.id
				})
				
			end
		end
		if Warehouse.owner == oldidentifier then
			Warehouse.owner = newidentifier
		end
		
	end

end)

RegisterServerEvent('hd_postop:getWarehousesFromPlayer')
AddEventHandler('hd_postop:getWarehousesFromPlayer', function()

    local xPlayer  = ESX.GetPlayerFromId(source)
    local ownedWarehousesPlayer = {}


    --[[for k, ownedWarehouse in pairs(WarehouseOwner) do

        if ownedWarehouse.owner == xPlayer.identifier then
            table.insert(ownedWarehousesPlayer, {
                id = ownedWarehouse.id,
                owner = ownedWarehouse.owner,
                name = ownedWarehouse.name,
                type = ownedWarehouse.type,
                upgraded = ownedWarehouse.upgraded,
                vehicle = ownedWarehouse.vehicle,
                store = ownedWarehouse.store,
                finish = ownedWarehouse.finish,
                lastlogin = ownedWarehouse.lastlogin,
				trusted = ownedWarehouse.trusted,
            })
            
        end

        if k == #WarehouseOwner then
            TriggerClientEvent('hd_postop:receiveWarehouses', source, ownedWarehousesPlayer)
            --Citizen.Wait(1500)
        end

    end--]]
	
	TriggerClientEvent('hd_postop:receiveWarehouses', source, WarehouseOwner, xPlayer.identifier)

end)

RegisterServerEvent('hd_postop:setLastLogin')
AddEventHandler('hd_postop:setLastLogin', function(WarehouseData)
    
    local currentTime = os.time()
    local diff = os.difftime(currentTime, WarehouseData.lastlogin)
    local minutes = diff / 60
    
    local profit = math.floor(minutes * (Config.ProduceRate[WarehouseData.upgraded] / 60))
    local canBeProduced = WarehouseData.store / 4
    --print(profit .. ' could be, but with storage can be prod: ' .. canBeProduced .. ' and WarehouseData.store = ' .. WarehouseData.store)

    if canBeProduced < 1 then
        MySQL.Async.execute(
            'UPDATE Warehouse_owner SET lastlogin = @time WHERE id = @id', {
                ['@time'] = currentTime, 
        })

        local editedLine = 0
        for k, v in pairs(WarehouseOwner) do
            if v.id == WarehouseData.id then
                WarehouseOwner[k].lastlogin = currentTime
                editedLine = k
            break
            end
        end
        TriggerClientEvent('hd_postop:updateWarehouses', source, editedLine, WarehouseOwner[editedLine])
        TriggerClientEvent('hd_postop:msg', source, Translation[Config.Locale]['nothing_produced'])
        profit = 0
    end
    if profit >= 1 and canBeProduced >= 1 then

        local type = nil

        if canBeProduced >= profit then
            local oldFinish = WarehouseData.finish
            local newStore = WarehouseData.store
            local newFinish = WarehouseData.finish

            if WarehouseData.finish + profit >= Config.FinishCapacity[WarehouseData.upgraded] then
                newFinish = Config.FinishCapacity[WarehouseData.upgraded]
                if (Config.FinishCapacity[WarehouseData.upgraded] - WarehouseData.finish) > 0 then
                    newStore = WarehouseData.store - ((Config.FinishCapacity[WarehouseData.upgraded] - WarehouseData.finish) * 4)
                end
            else
                newFinish = WarehouseData.finish + profit
                newStore = WarehouseData.store - (profit * 4)
            end

            MySQL.Async.execute(
                'UPDATE Warehouse_owner SET lastlogin = @time, store = @store, finish = @finish WHERE id = @id', {
                    ['@time'] = currentTime, 
                    ['@store'] = newStore, 
                    ['@finish'] = newFinish,
                    ['@id'] = WarehouseData.id,
            })
    
            local editedLine = 0
            for k, v in pairs(WarehouseOwner) do
                if v.id == WarehouseData.id then
                    WarehouseOwner[k].lastlogin = currentTime
                    WarehouseOwner[k].store = newStore
                    WarehouseOwner[k].finish = newFinish
                    type = v.type
                    editedLine = k
                break
                end
            end
            

            TriggerClientEvent('hd_postop:msg', source, Translation[Config.Locale]['successfully_produced'] .. newFinish - oldFinish .. 'x ' .. type .. Translation[Config.Locale]['successfully_produced_2'])
            TriggerClientEvent('hd_postop:updateWarehouses', source, editedLine, WarehouseOwner[editedLine])
            profit = 0
        else
            local oldFinish = WarehouseData.finish
            local newStore = WarehouseData.store
            local newFinish = WarehouseData.finish

            if WarehouseData.finish + canBeProduced >= Config.FinishCapacity[WarehouseData.upgraded] then
                newFinish = Config.FinishCapacity[WarehouseData.upgraded]
                if (Config.FinishCapacity[WarehouseData.upgraded] - WarehouseData.finish) > 0 then
                    newStore = WarehouseData.store - ((Config.FinishCapacity[WarehouseData.upgraded] - WarehouseData.finish) * 4)
                end
            else
                newFinish = WarehouseData.finish + canBeProduced
                newStore = WarehouseData.store - (canBeProduced * 4)
            end

            MySQL.Async.execute(
                'UPDATE Warehouse_owner SET lastlogin = @time, store = @store, finish = @finish WHERE id = @id', {
                    ['@time'] = currentTime, 
                    ['@store'] = newStore, 
                    ['@finish'] = newFinish, 
                    ['@id'] = WarehouseData.id,
            })
    
            local editedLine = 0
            for k, v in pairs(WarehouseOwner) do
                if v.id == WarehouseData.id then
                    WarehouseOwner[k].lastlogin = currentTime
                    WarehouseOwner[k].store = newStore
                    WarehouseOwner[k].finish = newFinish
                    type = v.type
                    editedLine = k
                break
                end
            end
            
            if newStore == 0 then
                TriggerClientEvent('hd_postop:msg', source, Translation[Config.Locale]['successfully_produced'] .. newFinish - oldFinish .. 'x ' .. type .. Translation[Config.Locale]['successfully_produced_storageEmpty'])
            else
                TriggerClientEvent('hd_postop:msg', source, Translation[Config.Locale]['successfully_produced'] .. newFinish - oldFinish .. 'x ' .. type .. Translation[Config.Locale]['successfully_produced_3'])
            end
            
            TriggerClientEvent('hd_postop:updateWarehouses', source, editedLine, WarehouseOwner[editedLine])
            profit = 0

        end

    end

end)

RegisterServerEvent('hd_postop:store')
AddEventHandler('hd_postop:store', function(type, WarehouseID, capacity, amount)

    local _source   = source
    local xPlayer   = ESX.GetPlayerFromId(_source)
    local count = xPlayer.getInventoryItem(type).count
    local editedLine = nil

    if xPlayer then
        if count >= amount then
            
            for k, v in pairs(WarehouseOwner) do
                if v.id == WarehouseID then
                    if (v.store + amount) <= capacity then

                        MySQL.Async.execute(
                            'UPDATE Warehouse_owner SET store = @store WHERE id = @id', {
                                ['@store'] = v.store + amount, 
                                ['@id'] = WarehouseID,
                        })

                        WarehouseOwner[k].store = v.store + amount
                        xPlayer.removeInventoryItem(type, amount)
                        editedLine = k

                    else
                        TriggerClientEvent('hd_postop:msg', source, Translation[Config.Locale]['menu_storage_storageLimit'] .. capacity - v.store  .. Translation[Config.Locale]['menu_storage_storageLimit_2'])
                    end
                break
                end
            end
            TriggerClientEvent('hd_postop:updateWarehouses', source, editedLine, WarehouseOwner[editedLine])

        else

            TriggerClientEvent('hd_postop:msg', source, Translation[Config.Locale]['menu_storage_notenough'])

        end
    end

end)

RegisterServerEvent('hd_postop:sellItems')
AddEventHandler('hd_postop:sellItems', function(item, amount, price)

    local _source   = source
    local xPlayer   = ESX.GetPlayerFromId(_source)
    local itemCount = xPlayer.getInventoryItem(item).count

    if itemCount >= amount then

        xPlayer.removeInventoryItem(item, amount)
        if Config.useBlackMoney then
            xPlayer.addAccountMoney(Config.BlackMoneyName, amount * price)
        else
            xPlayer.addMoney(amount * price)
        end
        TriggerClientEvent('hd_postop:msg', _source, Translation[Config.Locale]['items_sold_for'] .. price * amount .. '$')
    else
        TriggerClientEvent('hd_postop:msg', _source, Translation[Config.Locale]['you_only_have_items'] .. itemCount .. Translation[Config.Locale]['you_only_have_items2'])
    end

end)

-- OneSync getPlayers

ESX.RegisterServerCallback('hd_postop:getPlayersInArea', function(source, cb, position, distance)
    local p = GetPlayers()
    local players = {}
    local vecposition = vector3(position.x, position.y, position.z)
    if(#p > 0) then
        for index, playerID in ipairs(p) do
            local player = ESX.GetPlayerFromId(playerID)
            local coords = player.getCoords(true)
            if #(vecposition - coords) < distance then
                local playerInfo = {id = playerID, name = player.getName()}
                table.insert(players, playerInfo)
            end
        end
    end
    cb(players)
  end)
  
  
  --
  

RegisterServerEvent('hd_postop:buyVehicle')
AddEventHandler('hd_postop:buyVehicle', function(index, WarehouseID)

    local _source   = source
    local xPlayer   = ESX.GetPlayerFromId(_source)
    local car = Config.Vehicles[index]
    local editedLine = nil

    if xPlayer.getMoney() >= car.price then
        xPlayer.removeMoney(car.price)

        for k, v in pairs(WarehouseOwner) do
            if v.id == WarehouseID then
                WarehouseOwner[k].vehicle = index
                editedLine = k
            break
            end
        end

        MySQL.Async.execute(
            'UPDATE Warehouse_owner SET vehicle = @vehicle WHERE id = @id', {
                ['@vehicle'] = index, 
                ['@id'] = WarehouseID,
        })

        TriggerClientEvent('hd_postop:msg', source, Translation[Config.Locale]['mission_car_changed'] .. car.label .. Translation[Config.Locale]['mission_car_changed_2'])
        TriggerClientEvent('hd_postop:updateWarehouses', source, editedLine, WarehouseOwner[editedLine])
    else
        TriggerClientEvent('hd_postop:msg', source, Translation[Config.Locale]['notEnoughMoney'])
    end

end)

RegisterServerEvent('hd_postop:requestMission')
AddEventHandler('hd_postop:requestMission', function(target, WarehouseData, personalData)

    --target ist der Spieler der angefragt wird
    -- source ist der Auftraggeber
    TriggerClientEvent('hd_postop:hasRequest', target, source, WarehouseData, personalData)

end)

RegisterServerEvent('hd_postop:startMission')
AddEventHandler('hd_postop:startMission', function(target)

    -- target ist der Spieler, für den source die Mission macht
    if target == 'self' then

        TriggerClientEvent('hd_postop:startStorageMission', source, 'self')

    else

        TriggerClientEvent('hd_postop:startStorageMission', source, target)

    end

end)

RegisterServerEvent('hd_postop:payPlants')
AddEventHandler('hd_postop:payPlants', function(amount, price, target)

    local _source   = source
    local xPlayer   = ESX.GetPlayerFromId(_source)
    
    if target == 'self' then
        if xPlayer.getMoney() >= price then
            xPlayer.removeMoney(price)
            TriggerClientEvent('hd_postop:msg', source, '~b~' .. amount .. Translation[Config.Locale]['mission_self_plants_bought'] .. price .. Translation[Config.Locale]['mission_self_plants_bought_2'])
            TriggerClientEvent('hd_postop:deliverPlants', _source, amount, target)
        else
            TriggerClientEvent('hd_postop:msg', source, Translation[Config.Locale]['mission_self_plants_notEnoughMoney'])
            TriggerClientEvent('hd_postop:abortMission', source)
        end
    else
        local targetPlayer = ESX.GetPlayerFromId(target)
        if targetPlayer.getMoney() >= price then
            targetPlayer.removeMoney(price)
            TriggerClientEvent('hd_postop:msg', targetPlayer, '~b~' .. amount .. Translation[Config.Locale]['mission_self_plants_bought'] .. price .. Translation[Config.Locale]['mission_self_plants_bought_2'])
            TriggerClientEvent('hd_postop:msg', source, '~b~' .. amount .. Translation[Config.Locale]['mission_dou_plants_bought'])
            TriggerClientEvent('hd_postop:deliverPlants', source, amount, target)
        else
            TriggerClientEvent('hd_postop:msg', targetPlayer, Translation[Config.Locale]['mission_dou_plants_abort'] .. xPlayer.name .. Translation[Config.Locale]['mission_dou_plants_abort_2'])
            TriggerClientEvent('hd_postop:msg', source, Translation[Config.Locale]['mission_dou_plants_abort_target'])
            TriggerClientEvent('hd_postop:abortMission', source)
        end

    end

end)

RegisterServerEvent('hd_postop:givePlants')
AddEventHandler('hd_postop:givePlants', function(amount, target, type)

    local xPlayer = ESX.GetPlayerFromId(source)
	
    xPlayer.addInventoryItem(type, amount)
    TriggerClientEvent('hd_postop:msg', target, Translation[Config.Locale]['mission_dou_plants_arrived'] .. amount .. Translation[Config.Locale]['mission_dou_plants_arrived_2'])
    TriggerClientEvent('hd_postop:msg', source, Translation[Config.Locale]['mission_dou_plants_arrived_target'])
    --TriggerClientEvent('hd_postop:abortMission', source)
    

end)

RegisterServerEvent('hd_postop:giveFinalItem')
AddEventHandler('hd_postop:giveFinalItem', function(WarehouseID, amount, type)

    local xPlayer = ESX.GetPlayerFromId(source)
    local newFinish = 0
    local editedLine = nil

    for k, v in pairs(WarehouseOwner) do
        if v.id == WarehouseID then
            newFinish = WarehouseOwner[k].finish - amount
            WarehouseOwner[k].finish = newFinish
            editedLine = k
        break
        end
    end

    MySQL.Async.execute(
        'UPDATE Warehouse_owner SET finish = @finish WHERE id = @id', {
            ['@finish'] = newFinish, 
            ['@id'] = WarehouseID,
    })


	local item = type
	local label = type

	if type == 'wares' then
		item = Config.WeedItem
		label = Translation[Config.Locale]['wares']
	elseif type == 'wares' then
		item = Config.MethItem
		label = Translation[Config.Locale]['wares']
	elseif type == 'wares' then
		item = Config.CokeItem
		label = Translation[Config.Locale]['wares']
	end

    xPlayer.addInventoryItem(item, amount)
    TriggerClientEvent('hd_postop:msg', source, '~g~' .. amount .. 'x ' .. label .. Translation[Config.Locale]['get_from_storage'])
    TriggerClientEvent('hd_postop:updateWarehouses', source, editedLine, WarehouseOwner[editedLine])
	
	



end)

RegisterServerEvent('hd_postop:upgradeWarehouse')
AddEventHandler('hd_postop:upgradeWarehouse', function(WarehouseID, level, price)

    local xPlayer = ESX.GetPlayerFromId(source)

    if xPlayer.getMoney() >= price then
        xPlayer.removeMoney(price)
        local editedLine = nil

        for k, v in pairs(WarehouseOwner) do
            if v.id == WarehouseID then
                WarehouseOwner[k].upgraded = level
                editedLine = k
            break
            end
        end
    
        MySQL.Async.execute(
            'UPDATE Warehouse_owner SET upgraded = @upgraded WHERE id = @id', {
                ['@upgraded'] = level, 
                ['@id'] = WarehouseID,
        })

        TriggerClientEvent('hd_postop:updateWarehouses', source, editedLine, WarehouseOwner[editedLine])
        TriggerClientEvent('esx:showAdvancedNotification', source, 'CHAR_LJT', Translation[Config.Locale]['upgraded'] .. level .. Translation[Config.Locale]['upgraded_2'], Translation[Config.Locale]['upgraded_title'], '')
        
    else
        TriggerClientEvent('hd_postop:msg', source, Translation[Config.Locale]['notEnoughMoney'])
    end

end)
RegisterServerEvent('hd_postop:buyWarehouse')
AddEventHandler('hd_postop:buyWarehouse', function(WarehouseData)

    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

    if xPlayer.getMoney() >= WarehouseData.price then

        xPlayer.removeMoney(WarehouseData.price)

        MySQL.Async.execute(
            'INSERT INTO Warehouse_owner (id, owner, Warehouse, type, upgraded, vehicle, store, finish, lastlogin, trusted) VALUES (@id, @owner, @Warehouse, @type, @upgraded, @vehicle, @store, @finish, @lastlogin, @trusted)', {
              ['@id'] = highestID + 1, 
              ['@owner'] = xPlayer.identifier,
              ['@Warehouse'] = WarehouseData.name,
              ['@type'] = WarehouseData.type,
              ['@upgraded'] = 1,
              ['@vehicle'] = 1,
              ['@store'] = 0,
              ['@finish'] = 0,
              ['@lastlogin'] = 0,
			  ['@trusted'] = '[]',
          })
        
        table.insert(WarehouseOwner, {
            id = highestID + 1,
            owner = xPlayer.identifier,
            name = WarehouseData.name,
            type = WarehouseData.type,
            upgraded = 1,
            vehicle = 1,
            store = 0,
            finish = 0,
            lastlogin = 0,
			trusted = {},
        })

        highestID = highestID + 1
        TriggerClientEvent('hd_postop:setNewWarehouseOwned', source, WarehouseOwner[#WarehouseOwner], xPlayer.identifier)
        TriggerClientEvent('esx:showAdvancedNotification', source, 'CHAR_LJT', Translation[Config.Locale]['Warehouse_bought'] .. WarehouseData.label .. Translation[Config.Locale]['Warehouse_bought_2'], Translation[Config.Locale]['Warehouse_bought_title'], '')


    else
        TriggerClientEvent('hd_postop:msg', _source, Translation[Config.Locale]['notEnoughMoney'])
    end


end)

local playersInWarehouses = {}

RegisterServerEvent('hd_postop:setPlayerInvisible')
AddEventHandler('hd_postop:setPlayerInvisible', function(WarehouseID)

    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

    for k, player in pairs(playersInWarehouses) do
        if player.id == WarehouseID then
            TriggerClientEvent('hd_postop:setPlayerVisible', player.source, _source)
            TriggerClientEvent('hd_postop:setPlayerVisible', _source, player.source)
        else
            TriggerClientEvent('hd_postop:setPlayerInvisible', player.source, _source)
            TriggerClientEvent('hd_postop:setPlayerInvisible', _source, player.source)
        end
    end

    table.insert(playersInWarehouses, {
        id = WarehouseID,
        source = source,
        name = xPlayer.name, 
    })


end)

RegisterServerEvent('hd_postop:leaveWarehouse')
AddEventHandler('hd_postop:leaveWarehouse', function(WarehouseID)

    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

    for k, player in pairs(playersInWarehouses) do
        if player.name == xPlayer.name then
            table.remove(playersInWarehouses, k)
            break
        end
    end


end)

RegisterServerEvent('hd_postop:saveLastWarehouse')
AddEventHandler('hd_postop:saveLastWarehouse', function(WarehouseID)

  local xPlayer = ESX.GetPlayerFromId(source)

  MySQL.Async.execute(
    'UPDATE users SET last_Warehouse = @last_Warehouse WHERE identifier = @identifier',
    {
      ['@last_Warehouse'] = WarehouseID,
      ['@identifier'] = xPlayer.identifier
    }
  )

end)

ESX.RegisterServerCallback('hd_postop:getLastWarehouse', function(source, cb)

    local xPlayer = ESX.GetPlayerFromId(source)
  
    MySQL.Async.fetchAll(
    'SELECT last_Warehouse FROM users WHERE identifier = @identifier',
    {
      ['@identifier'] = xPlayer.identifier
    },
    function(users)
      cb(users[1].last_Warehouse)
    end
  )
  
end)

RegisterServerEvent('hd_postop:sellWarehouse')
AddEventHandler('hd_postop:sellWarehouse', function(owner, WarehouseID, WarehousePrice)
    local xPlayer = ESX.GetPlayerFromId(source)

    if xPlayer.identifier == owner then
        MySQL.Async.execute(
        'DELETE FROM Warehouse_owner WHERE id = @id AND owner = @owner',
            {
                ['@id'] = WarehouseID,
                ['@owner'] = xPlayer.identifier
            }
        )

        xPlayer.addMoney(WarehousePrice / Config.SellDivide)
        TriggerClientEvent('hd_postop:sellWarehouse', -1, WarehouseID)
    end

end)

RegisterServerEvent('hd_postop:updateTrusted')
AddEventHandler('hd_postop:updateTrusted', function(type, trustedPlayer, WarehouseID)
    if source ~= nil then
        local _source = source
        local xPlayer = ESX.GetPlayerFromId(_source)
        local charname = 'Unknown'
        local trusted = nil
        local trustedPlayerFinal = trustedPlayer

        if type == "add" then
			trustedPlayerFinal = ESX.GetPlayerFromId(trustedPlayer).identifier
        end

        MySQL.Async.fetchAll('SELECT firstname, lastname from users WHERE identifier = @identifier', {
            ['@identifier'] = trustedPlayerFinal
        },
        function(result)
            if #result > 0 then
                charname = result[1].firstname .. " " .. result[1].lastname
            end
        end)

        while charname == 'Unknown' do
            Wait(10)
        end

        for k, v in pairs(WarehouseOwner) do
            if v.id == WarehouseID then


                if (type == "del") then
                    for i = 1, #v.trusted, 1 do
                        if (v.trusted[i].steamID == trustedPlayerFinal) then
                            table.remove(v.trusted, i)
							TriggerClientEvent('hd_postop:updateWarehouses', _source, 0, v)
							TriggerClientEvent('hd_postop:deleteWarehouse', trustedPlayer, v.id)
							--TriggerClientEvent('hd_postop:updateWarehouses', trustedPlayer, 0, v)
							TriggerClientEvent('hd_postop:msg', _source, '~y~' .. charname .. Translation[Config.Locale]['menu_access_removed'])
							TriggerClientEvent('hd_postop:msg', trustedPlayer, Translation[Config.Locale]['menu_access_removed_target'] .. v.id .. Translation[Config.Locale]['menu_access_removed_target_2'])
							break
                        end
                    end
                elseif (type == "add") then
                    table.insert(v.trusted, {steamID = trustedPlayerFinal, name = charname})
					TriggerClientEvent('hd_postop:updateWarehouses', _source, 0, v)
					TriggerClientEvent('hd_postop:setNewWarehouseOwned', trustedPlayer, v, trustedPlayerFinal)
					TriggerClientEvent('hd_postop:updateWarehouses', trustedPlayer, 0, v)
					TriggerClientEvent('hd_postop:msg', _source, '~g~' .. charname .. Translation[Config.Locale]['menu_access_granted'])
					TriggerClientEvent('hd_postop:msg', trustedPlayer, Translation[Config.Locale]['menu_access_granted_target'] .. v.id .. Translation[Config.Locale]['menu_access_granted_target_2'])
                end

                trusted = v.trusted
				break
            end
        end
		
        if (trusted ~= nil) then
            MySQL.Async.execute('UPDATE Warehouse_owner SET trusted=@trusted WHERE id=@WarehouseID LIMIT 1',
            {
                ['@trusted'] = json.encode(trusted),
                ['@WarehouseID'] = WarehouseID
            })
        end

    end
end)