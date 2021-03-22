local ESX = nil
local farmOwner = {}
local highestID = 0

TriggerEvent('esx:getSharedObject', function(obj) 
    ESX = obj 
end)

MySQL.ready(function()
    MySQL.Async.fetchAll('SELECT * from farm_owner', {},
        function(result)
            if #result > 0 then
                for k, farm_owner_res in pairs(result) do
                    table.insert(farmOwner, {
                        id = farm_owner_res.id,
                        owner = farm_owner_res.owner,
                        name = farm_owner_res.farm,
                        type = farm_owner_res.type,
                        upgraded = farm_owner_res.upgraded,
                        vehicle = farm_owner_res.vehicle,
                        store = farm_owner_res.store,
                        finish = farm_owner_res.finish,
                        lastlogin = farm_owner_res.lastlogin,
						trusted = json.decode(farm_owner_res.trusted),
                    })
                    highestID = farm_owner_res.id
                end
            end
        end
    )
end)

RegisterServerEvent('myDrugs:updateIdentifier')
AddEventHandler('myDrugs:updateIdentifier', function(src, oldidentifier, newidentifier)
	
	for k, farm in pairs(farmOwner) do
		for k2, trust in pairs(farm.trusted) do
			if trust.steamID == oldidentifier then
				trust.steamID = newidentifier
				MySQL.Async.execute('UPDATE farm_owner SET trusted=@trusted WHERE id=@FARMID LIMIT 1',
				{
                ['@trusted'] = json.encode(farm.trusted),
                ['@FARMID'] = farm.id
				})
				
			end
		end
		if farm.owner == oldidentifier then
			farm.owner = newidentifier
		end
		
	end

end)

RegisterServerEvent('myDrugs:getFarmsFromPlayer')
AddEventHandler('myDrugs:getFarmsFromPlayer', function()

    local xPlayer  = ESX.GetPlayerFromId(source)
    local ownedFarmsPlayer = {}


    --[[for k, ownedFarm in pairs(farmOwner) do

        if ownedFarm.owner == xPlayer.identifier then
            table.insert(ownedFarmsPlayer, {
                id = ownedFarm.id,
                owner = ownedFarm.owner,
                name = ownedFarm.name,
                type = ownedFarm.type,
                upgraded = ownedFarm.upgraded,
                vehicle = ownedFarm.vehicle,
                store = ownedFarm.store,
                finish = ownedFarm.finish,
                lastlogin = ownedFarm.lastlogin,
				trusted = ownedFarm.trusted,
            })
            
        end

        if k == #farmOwner then
            TriggerClientEvent('myDrugs:receiveFarms', source, ownedFarmsPlayer)
            --Citizen.Wait(1500)
        end

    end--]]
	
	TriggerClientEvent('myDrugs:receiveFarms', source, farmOwner, xPlayer.identifier)

end)

RegisterServerEvent('myDrugs:setLastLogin')
AddEventHandler('myDrugs:setLastLogin', function(farmData)
    
    local currentTime = os.time()
    local diff = os.difftime(currentTime, farmData.lastlogin)
    local minutes = diff / 60
    
    local profit = math.floor(minutes * (Config.ProduceRate[farmData.upgraded] / 60))
    local canBeProduced = farmData.store / 4
    --print(profit .. ' could be, but with storage can be prod: ' .. canBeProduced .. ' and farmData.store = ' .. farmData.store)

    if canBeProduced < 1 then
        MySQL.Async.execute(
            'UPDATE farm_owner SET lastlogin = @time WHERE id = @id', {
                ['@time'] = currentTime, 
        })

        local editedLine = 0
        for k, v in pairs(farmOwner) do
            if v.id == farmData.id then
                farmOwner[k].lastlogin = currentTime
                editedLine = k
            break
            end
        end
        TriggerClientEvent('myDrugs:updateFarms', source, editedLine, farmOwner[editedLine])
        TriggerClientEvent('myDrugs:msg', source, Translation[Config.Locale]['nothing_produced'])
        profit = 0
    end
    if profit >= 1 and canBeProduced >= 1 then

        local type = nil

        if canBeProduced >= profit then
            local oldFinish = farmData.finish
            local newStore = farmData.store
            local newFinish = farmData.finish

            if farmData.finish + profit >= Config.FinishCapacity[farmData.upgraded] then
                newFinish = Config.FinishCapacity[farmData.upgraded]
                if (Config.FinishCapacity[farmData.upgraded] - farmData.finish) > 0 then
                    newStore = farmData.store - ((Config.FinishCapacity[farmData.upgraded] - farmData.finish) * 4)
                end
            else
                newFinish = farmData.finish + profit
                newStore = farmData.store - (profit * 4)
            end

            MySQL.Async.execute(
                'UPDATE farm_owner SET lastlogin = @time, store = @store, finish = @finish WHERE id = @id', {
                    ['@time'] = currentTime, 
                    ['@store'] = newStore, 
                    ['@finish'] = newFinish,
                    ['@id'] = farmData.id,
            })
    
            local editedLine = 0
            for k, v in pairs(farmOwner) do
                if v.id == farmData.id then
                    farmOwner[k].lastlogin = currentTime
                    farmOwner[k].store = newStore
                    farmOwner[k].finish = newFinish
                    type = v.type
                    editedLine = k
                break
                end
            end
            

            TriggerClientEvent('myDrugs:msg', source, Translation[Config.Locale]['successfully_produced'] .. newFinish - oldFinish .. 'x ' .. type .. Translation[Config.Locale]['successfully_produced_2'])
            TriggerClientEvent('myDrugs:updateFarms', source, editedLine, farmOwner[editedLine])
            profit = 0
        else
            local oldFinish = farmData.finish
            local newStore = farmData.store
            local newFinish = farmData.finish

            if farmData.finish + canBeProduced >= Config.FinishCapacity[farmData.upgraded] then
                newFinish = Config.FinishCapacity[farmData.upgraded]
                if (Config.FinishCapacity[farmData.upgraded] - farmData.finish) > 0 then
                    newStore = farmData.store - ((Config.FinishCapacity[farmData.upgraded] - farmData.finish) * 4)
                end
            else
                newFinish = farmData.finish + canBeProduced
                newStore = farmData.store - (canBeProduced * 4)
            end

            MySQL.Async.execute(
                'UPDATE farm_owner SET lastlogin = @time, store = @store, finish = @finish WHERE id = @id', {
                    ['@time'] = currentTime, 
                    ['@store'] = newStore, 
                    ['@finish'] = newFinish, 
                    ['@id'] = farmData.id,
            })
    
            local editedLine = 0
            for k, v in pairs(farmOwner) do
                if v.id == farmData.id then
                    farmOwner[k].lastlogin = currentTime
                    farmOwner[k].store = newStore
                    farmOwner[k].finish = newFinish
                    type = v.type
                    editedLine = k
                break
                end
            end
            
            if newStore == 0 then
                TriggerClientEvent('myDrugs:msg', source, Translation[Config.Locale]['successfully_produced'] .. newFinish - oldFinish .. 'x ' .. type .. Translation[Config.Locale]['successfully_produced_storageEmpty'])
            else
                TriggerClientEvent('myDrugs:msg', source, Translation[Config.Locale]['successfully_produced'] .. newFinish - oldFinish .. 'x ' .. type .. Translation[Config.Locale]['successfully_produced_3'])
            end
            
            TriggerClientEvent('myDrugs:updateFarms', source, editedLine, farmOwner[editedLine])
            profit = 0

        end

    end

end)

RegisterServerEvent('myDrugs:store')
AddEventHandler('myDrugs:store', function(type, farmID, capacity, amount)

    local _source   = source
    local xPlayer   = ESX.GetPlayerFromId(_source)
    local count = xPlayer.getInventoryItem(type).count
    local editedLine = nil

    if xPlayer then
        if count >= amount then
            
            for k, v in pairs(farmOwner) do
                if v.id == farmID then
                    if (v.store + amount) <= capacity then

                        MySQL.Async.execute(
                            'UPDATE farm_owner SET store = @store WHERE id = @id', {
                                ['@store'] = v.store + amount, 
                                ['@id'] = farmID,
                        })

                        farmOwner[k].store = v.store + amount
                        xPlayer.removeInventoryItem(type, amount)
                        editedLine = k

                    else
                        TriggerClientEvent('myDrugs:msg', source, Translation[Config.Locale]['menu_storage_storageLimit'] .. capacity - v.store  .. Translation[Config.Locale]['menu_storage_storageLimit_2'])
                    end
                break
                end
            end
            TriggerClientEvent('myDrugs:updateFarms', source, editedLine, farmOwner[editedLine])

        else

            TriggerClientEvent('myDrugs:msg', source, Translation[Config.Locale]['menu_storage_notenough'])

        end
    end

end)

RegisterServerEvent('myDrugs:sellItems')
AddEventHandler('myDrugs:sellItems', function(item, amount, price)

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
        TriggerClientEvent('myDrugs:msg', _source, Translation[Config.Locale]['items_sold_for'] .. price * amount .. '$')
    else
        TriggerClientEvent('myDrugs:msg', _source, Translation[Config.Locale]['you_only_have_items'] .. itemCount .. Translation[Config.Locale]['you_only_have_items2'])
    end

end)

-- OneSync getPlayers

ESX.RegisterServerCallback('myDrugs:getPlayersInArea', function(source, cb, position, distance)
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
  

RegisterServerEvent('myDrugs:buyVehicle')
AddEventHandler('myDrugs:buyVehicle', function(index, farmID)

    local _source   = source
    local xPlayer   = ESX.GetPlayerFromId(_source)
    local car = Config.Vehicles[index]
    local editedLine = nil

    if xPlayer.getMoney() >= car.price then
        xPlayer.removeMoney(car.price)

        for k, v in pairs(farmOwner) do
            if v.id == farmID then
                farmOwner[k].vehicle = index
                editedLine = k
            break
            end
        end

        MySQL.Async.execute(
            'UPDATE farm_owner SET vehicle = @vehicle WHERE id = @id', {
                ['@vehicle'] = index, 
                ['@id'] = farmID,
        })

        TriggerClientEvent('myDrugs:msg', source, Translation[Config.Locale]['mission_car_changed'] .. car.label .. Translation[Config.Locale]['mission_car_changed_2'])
        TriggerClientEvent('myDrugs:updateFarms', source, editedLine, farmOwner[editedLine])
    else
        TriggerClientEvent('myDrugs:msg', source, Translation[Config.Locale]['notEnoughMoney'])
    end

end)

RegisterServerEvent('myDrugs:requestMission')
AddEventHandler('myDrugs:requestMission', function(target, farmData, personalData)

    --target ist der Spieler der angefragt wird
    -- source ist der Auftraggeber
    TriggerClientEvent('myDrugs:hasRequest', target, source, farmData, personalData)

end)

RegisterServerEvent('myDrugs:startMission')
AddEventHandler('myDrugs:startMission', function(target)

    -- target ist der Spieler, für den source die Mission macht
    if target == 'self' then

        TriggerClientEvent('myDrugs:startStorageMission', source, 'self')

    else

        TriggerClientEvent('myDrugs:startStorageMission', source, target)

    end

end)

RegisterServerEvent('myDrugs:payPlants')
AddEventHandler('myDrugs:payPlants', function(amount, price, target)

    local _source   = source
    local xPlayer   = ESX.GetPlayerFromId(_source)
    
    if target == 'self' then
        if xPlayer.getMoney() >= price then
            xPlayer.removeMoney(price)
            TriggerClientEvent('myDrugs:msg', source, '~b~' .. amount .. Translation[Config.Locale]['mission_self_plants_bought'] .. price .. Translation[Config.Locale]['mission_self_plants_bought_2'])
            TriggerClientEvent('myDrugs:deliverPlants', _source, amount, target)
        else
            TriggerClientEvent('myDrugs:msg', source, Translation[Config.Locale]['mission_self_plants_notEnoughMoney'])
            TriggerClientEvent('myDrugs:abortMission', source)
        end
    else
        local targetPlayer = ESX.GetPlayerFromId(target)
        if targetPlayer.getMoney() >= price then
            targetPlayer.removeMoney(price)
            TriggerClientEvent('myDrugs:msg', targetPlayer, '~b~' .. amount .. Translation[Config.Locale]['mission_self_plants_bought'] .. price .. Translation[Config.Locale]['mission_self_plants_bought_2'])
            TriggerClientEvent('myDrugs:msg', source, '~b~' .. amount .. Translation[Config.Locale]['mission_dou_plants_bought'])
            TriggerClientEvent('myDrugs:deliverPlants', source, amount, target)
        else
            TriggerClientEvent('myDrugs:msg', targetPlayer, Translation[Config.Locale]['mission_dou_plants_abort'] .. xPlayer.name .. Translation[Config.Locale]['mission_dou_plants_abort_2'])
            TriggerClientEvent('myDrugs:msg', source, Translation[Config.Locale]['mission_dou_plants_abort_target'])
            TriggerClientEvent('myDrugs:abortMission', source)
        end

    end

end)

RegisterServerEvent('myDrugs:givePlants')
AddEventHandler('myDrugs:givePlants', function(amount, target, type)

    local xPlayer = ESX.GetPlayerFromId(source)
	
    xPlayer.addInventoryItem(type, amount)
    TriggerClientEvent('myDrugs:msg', target, Translation[Config.Locale]['mission_dou_plants_arrived'] .. amount .. Translation[Config.Locale]['mission_dou_plants_arrived_2'])
    TriggerClientEvent('myDrugs:msg', source, Translation[Config.Locale]['mission_dou_plants_arrived_target'])
    --TriggerClientEvent('myDrugs:abortMission', source)
    

end)

RegisterServerEvent('myDrugs:giveFinalItem')
AddEventHandler('myDrugs:giveFinalItem', function(farmID, amount, type)

    local xPlayer = ESX.GetPlayerFromId(source)
    local newFinish = 0
    local editedLine = nil

    for k, v in pairs(farmOwner) do
        if v.id == farmID then
            newFinish = farmOwner[k].finish - amount
            farmOwner[k].finish = newFinish
            editedLine = k
        break
        end
    end

    MySQL.Async.execute(
        'UPDATE farm_owner SET finish = @finish WHERE id = @id', {
            ['@finish'] = newFinish, 
            ['@id'] = farmID,
    })


	local item = type
	local label = type

	if type == 'weed' then
		item = Config.WeedItem
		label = Translation[Config.Locale]['weed']
	elseif type == 'meth' then
		item = Config.MethItem
		label = Translation[Config.Locale]['meth']
	elseif type == 'coke' then
		item = Config.CokeItem
		label = Translation[Config.Locale]['coke']
	end

    xPlayer.addInventoryItem(item, amount)
    TriggerClientEvent('myDrugs:msg', source, '~g~' .. amount .. 'x ' .. label .. Translation[Config.Locale]['get_from_storage'])
    TriggerClientEvent('myDrugs:updateFarms', source, editedLine, farmOwner[editedLine])
	
	



end)

RegisterServerEvent('myDrugs:upgradeFarm')
AddEventHandler('myDrugs:upgradeFarm', function(farmID, level, price)

    local xPlayer = ESX.GetPlayerFromId(source)

    if xPlayer.getMoney() >= price then
        xPlayer.removeMoney(price)
        local editedLine = nil

        for k, v in pairs(farmOwner) do
            if v.id == farmID then
                farmOwner[k].upgraded = level
                editedLine = k
            break
            end
        end
    
        MySQL.Async.execute(
            'UPDATE farm_owner SET upgraded = @upgraded WHERE id = @id', {
                ['@upgraded'] = level, 
                ['@id'] = farmID,
        })

        TriggerClientEvent('myDrugs:updateFarms', source, editedLine, farmOwner[editedLine])
        TriggerClientEvent('esx:showAdvancedNotification', source, 'CHAR_LJT', Translation[Config.Locale]['upgraded'] .. level .. Translation[Config.Locale]['upgraded_2'], Translation[Config.Locale]['upgraded_title'], '')
        
    else
        TriggerClientEvent('myDrugs:msg', source, Translation[Config.Locale]['notEnoughMoney'])
    end

end)
RegisterServerEvent('myDrugs:buyFarm')
AddEventHandler('myDrugs:buyFarm', function(farmData)

    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

    if xPlayer.getMoney() >= farmData.price then

        xPlayer.removeMoney(farmData.price)

        MySQL.Async.execute(
            'INSERT INTO farm_owner (id, owner, farm, type, upgraded, vehicle, store, finish, lastlogin, trusted) VALUES (@id, @owner, @farm, @type, @upgraded, @vehicle, @store, @finish, @lastlogin, @trusted)', {
              ['@id'] = highestID + 1, 
              ['@owner'] = xPlayer.identifier,
              ['@farm'] = farmData.name,
              ['@type'] = farmData.type,
              ['@upgraded'] = 1,
              ['@vehicle'] = 1,
              ['@store'] = 0,
              ['@finish'] = 0,
              ['@lastlogin'] = 0,
			  ['@trusted'] = '[]',
          })
        
        table.insert(farmOwner, {
            id = highestID + 1,
            owner = xPlayer.identifier,
            name = farmData.name,
            type = farmData.type,
            upgraded = 1,
            vehicle = 1,
            store = 0,
            finish = 0,
            lastlogin = 0,
			trusted = {},
        })

        highestID = highestID + 1
        TriggerClientEvent('myDrugs:setNewFarmOwned', source, farmOwner[#farmOwner], xPlayer.identifier)
        TriggerClientEvent('esx:showAdvancedNotification', source, 'CHAR_LJT', Translation[Config.Locale]['farm_bought'] .. farmData.label .. Translation[Config.Locale]['farm_bought_2'], Translation[Config.Locale]['farm_bought_title'], '')


    else
        TriggerClientEvent('myDrugs:msg', _source, Translation[Config.Locale]['notEnoughMoney'])
    end


end)

local playersInFarms = {}

RegisterServerEvent('myDrugs:setPlayerInvisible')
AddEventHandler('myDrugs:setPlayerInvisible', function(farmID)

    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

    for k, player in pairs(playersInFarms) do
        if player.id == farmID then
            TriggerClientEvent('myDrugs:setPlayerVisible', player.source, _source)
            TriggerClientEvent('myDrugs:setPlayerVisible', _source, player.source)
        else
            TriggerClientEvent('myDrugs:setPlayerInvisible', player.source, _source)
            TriggerClientEvent('myDrugs:setPlayerInvisible', _source, player.source)
        end
    end

    table.insert(playersInFarms, {
        id = farmID,
        source = source,
        name = xPlayer.name, 
    })


end)

RegisterServerEvent('myDrugs:leaveFarm')
AddEventHandler('myDrugs:leaveFarm', function(farmID)

    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

    for k, player in pairs(playersInFarms) do
        if player.name == xPlayer.name then
            table.remove(playersInFarms, k)
            break
        end
    end


end)

RegisterServerEvent('myDrugs:saveLastFarm')
AddEventHandler('myDrugs:saveLastFarm', function(farmID)

  local xPlayer = ESX.GetPlayerFromId(source)

  MySQL.Async.execute(
    'UPDATE users SET last_farm = @last_farm WHERE identifier = @identifier',
    {
      ['@last_farm'] = farmID,
      ['@identifier'] = xPlayer.identifier
    }
  )

end)

ESX.RegisterServerCallback('myDrugs:getLastFarm', function(source, cb)

    local xPlayer = ESX.GetPlayerFromId(source)
  
    MySQL.Async.fetchAll(
    'SELECT last_farm FROM users WHERE identifier = @identifier',
    {
      ['@identifier'] = xPlayer.identifier
    },
    function(users)
      cb(users[1].last_farm)
    end
  )
  
end)

RegisterServerEvent('myDrugs:sellFarm')
AddEventHandler('myDrugs:sellFarm', function(owner, farmID, farmPrice)
    local xPlayer = ESX.GetPlayerFromId(source)

    if xPlayer.identifier == owner then
        MySQL.Async.execute(
        'DELETE FROM farm_owner WHERE id = @id AND owner = @owner',
            {
                ['@id'] = farmID,
                ['@owner'] = xPlayer.identifier
            }
        )

        xPlayer.addMoney(farmPrice / Config.SellDivide)
        TriggerClientEvent('myDrugs:sellFarm', -1, farmID)
    end

end)

RegisterServerEvent('myDrugs:updateTrusted')
AddEventHandler('myDrugs:updateTrusted', function(type, trustedPlayer, farmID)
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

        for k, v in pairs(farmOwner) do
            if v.id == farmID then


                if (type == "del") then
                    for i = 1, #v.trusted, 1 do
                        if (v.trusted[i].steamID == trustedPlayerFinal) then
                            table.remove(v.trusted, i)
							TriggerClientEvent('myDrugs:updateFarms', _source, 0, v)
							TriggerClientEvent('myDrugs:deleteFarm', trustedPlayer, v.id)
							--TriggerClientEvent('myDrugs:updateFarms', trustedPlayer, 0, v)
							TriggerClientEvent('myDrugs:msg', _source, '~y~' .. charname .. Translation[Config.Locale]['menu_access_removed'])
							TriggerClientEvent('myDrugs:msg', trustedPlayer, Translation[Config.Locale]['menu_access_removed_target'] .. v.id .. Translation[Config.Locale]['menu_access_removed_target_2'])
							break
                        end
                    end
                elseif (type == "add") then
                    table.insert(v.trusted, {steamID = trustedPlayerFinal, name = charname})
					TriggerClientEvent('myDrugs:updateFarms', _source, 0, v)
					TriggerClientEvent('myDrugs:setNewFarmOwned', trustedPlayer, v, trustedPlayerFinal)
					TriggerClientEvent('myDrugs:updateFarms', trustedPlayer, 0, v)
					TriggerClientEvent('myDrugs:msg', _source, '~g~' .. charname .. Translation[Config.Locale]['menu_access_granted'])
					TriggerClientEvent('myDrugs:msg', trustedPlayer, Translation[Config.Locale]['menu_access_granted_target'] .. v.id .. Translation[Config.Locale]['menu_access_granted_target_2'])
                end

                trusted = v.trusted
				break
            end
        end
		
        if (trusted ~= nil) then
            MySQL.Async.execute('UPDATE farm_owner SET trusted=@trusted WHERE id=@FARMID LIMIT 1',
            {
                ['@trusted'] = json.encode(trusted),
                ['@FARMID'] = farmID
            })
        end

    end
end)