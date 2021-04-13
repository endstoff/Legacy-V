local ESX = nil
local kitchenOwner = {}
local highestID = 0

TriggerEvent('esx:getSharedObject', function(obj) 
    ESX = obj 
end)

MySQL.ready(function()
    MySQL.Async.fetchAll('SELECT * from kitchen_owner', {},
        function(result)
            if #result > 0 then
                for k, kitchen_owner_res in pairs(result) do
                    table.insert(kitchenOwner, {
                        id = kitchen_owner_res.id,
                        owner = kitchen_owner_res.owner,
                        name = kitchen_owner_res.kitchen,
                        type = kitchen_owner_res.type,
                        upgraded = kitchen_owner_res.upgraded,
                        vehicle = kitchen_owner_res.vehicle,
                        store = kitchen_owner_res.store,
                        finish = kitchen_owner_res.finish,
                        lastlogin = kitchen_owner_res.lastlogin,
						trusted = json.decode(kitchen_owner_res.trusted),
                    })
                    highestID = kitchen_owner_res.id
                end
            end
        end
    )
end)

RegisterServerEvent('hd_puredrugs:updateIdentifier')
AddEventHandler('hd_puredrugs:updateIdentifier', function(src, oldidentifier, newidentifier)
	
	for k, kitchen in pairs(kitchenOwner) do
		for k2, trust in pairs(kitchen.trusted) do
			if trust.steamID == oldidentifier then
				trust.steamID = newidentifier
				MySQL.Async.execute('UPDATE kitchen_owner SET trusted=@trusted WHERE id=@kitchenID LIMIT 1',
				{
                ['@trusted'] = json.encode(kitchen.trusted),
                ['@kitchenID'] = kitchen.id
				})
				
			end
		end
		if kitchen.owner == oldidentifier then
			kitchen.owner = newidentifier
		end
		
	end

end)

RegisterServerEvent('hd_puredrugs:getkitchensFromPlayer')
AddEventHandler('hd_puredrugs:getkitchensFromPlayer', function()

    local xPlayer  = ESX.GetPlayerFromId(source)
    local ownedkitchensPlayer = {}


    --[[for k, ownedkitchen in pairs(kitchenOwner) do

        if ownedkitchen.owner == xPlayer.identifier then
            table.insert(ownedkitchensPlayer, {
                id = ownedkitchen.id,
                owner = ownedkitchen.owner,
                name = ownedkitchen.name,
                type = ownedkitchen.type,
                upgraded = ownedkitchen.upgraded,
                vehicle = ownedkitchen.vehicle,
                store = ownedkitchen.store,
                finish = ownedkitchen.finish,
                lastlogin = ownedkitchen.lastlogin,
				trusted = ownedkitchen.trusted,
            })
            
        end

        if k == #kitchenOwner then
            TriggerClientEvent('hd_puredrugs:receivekitchens', source, ownedkitchensPlayer)
            --Citizen.Wait(1500)
        end

    end--]]
	
	TriggerClientEvent('hd_puredrugs:receivekitchens', source, kitchenOwner, xPlayer.identifier)

end)

ESX.RegisterServerCallback('hd_puredrugs:IskitchenAlreadyOwned', function(source, cb, kitchenname)

    if #kitchenOwner > 0 then
        for k, v in pairs(kitchenOwner) do
            if v.name == kitchenname then
                cb(true)
                break
            elseif k == #kitchenOwner then
                cb(false)
            end
        end
    else
        cb(false)
    end

end)

RegisterServerEvent('hd_puredrugs:setLastLogin')
AddEventHandler('hd_puredrugs:setLastLogin', function(kitchenData)
    
    local currentTime = os.time()
    local diff = os.difftime(currentTime, kitchenData.lastlogin)
    local minutes = diff / 60
    
    local profit = math.floor(minutes * (Config.ProduceRate[kitchenData.upgraded] / 60))
    local canBeProduced = kitchenData.store / 4
    --print(profit .. ' could be, but with storage can be prod: ' .. canBeProduced .. ' and kitchenData.store = ' .. kitchenData.store)

    if canBeProduced < 1 then
        MySQL.Async.execute(
            'UPDATE kitchen_owner SET lastlogin = @time WHERE id = @id', {
                ['@time'] = currentTime, 
        })

        local editedLine = 0
        for k, v in pairs(kitchenOwner) do
            if v.id == kitchenData.id then
                kitchenOwner[k].lastlogin = currentTime
                editedLine = k
            break
            end
        end
        TriggerClientEvent('hd_puredrugs:updatekitchens', source, editedLine, kitchenOwner[editedLine])
        TriggerClientEvent('hd_puredrugs:msg', source, Translation[Config.Locale]['nothing_produced'])
        profit = 0
    end
    if profit >= 1 and canBeProduced >= 1 then

        local type = nil

        if canBeProduced >= profit then
            local oldFinish = kitchenData.finish
            local newStore = kitchenData.store
            local newFinish = kitchenData.finish

            if kitchenData.finish + profit >= Config.FinishCapacity[kitchenData.upgraded] then
                newFinish = Config.FinishCapacity[kitchenData.upgraded]
                if (Config.FinishCapacity[kitchenData.upgraded] - kitchenData.finish) > 0 then
                    newStore = kitchenData.store - ((Config.FinishCapacity[kitchenData.upgraded] - kitchenData.finish) * 4)
                end
            else
                newFinish = kitchenData.finish + profit
                newStore = kitchenData.store - (profit * 4)
            end

            MySQL.Async.execute(
                'UPDATE kitchen_owner SET lastlogin = @time, store = @store, finish = @finish WHERE id = @id', {
                    ['@time'] = currentTime, 
                    ['@store'] = newStore, 
                    ['@finish'] = newFinish,
                    ['@id'] = kitchenData.id,
            })
    
            local editedLine = 0
            for k, v in pairs(kitchenOwner) do
                if v.id == kitchenData.id then
                    kitchenOwner[k].lastlogin = currentTime
                    kitchenOwner[k].store = newStore
                    kitchenOwner[k].finish = newFinish
                    type = v.type
                    editedLine = k
                break
                end
            end
            

            TriggerClientEvent('hd_puredrugs:msg', source, Translation[Config.Locale]['successfully_produced'] .. newFinish - oldFinish .. 'x ' .. type .. Translation[Config.Locale]['successfully_produced_2'])
            TriggerClientEvent('hd_puredrugs:updatekitchens', source, editedLine, kitchenOwner[editedLine])
            profit = 0
        else
            local oldFinish = kitchenData.finish
            local newStore = kitchenData.store
            local newFinish = kitchenData.finish

            if kitchenData.finish + canBeProduced >= Config.FinishCapacity[kitchenData.upgraded] then
                newFinish = Config.FinishCapacity[kitchenData.upgraded]
                if (Config.FinishCapacity[kitchenData.upgraded] - kitchenData.finish) > 0 then
                    newStore = kitchenData.store - ((Config.FinishCapacity[kitchenData.upgraded] - kitchenData.finish) * 4)
                end
            else
                newFinish = kitchenData.finish + canBeProduced
                newStore = kitchenData.store - (canBeProduced * 4)
            end

            MySQL.Async.execute(
                'UPDATE kitchen_owner SET lastlogin = @time, store = @store, finish = @finish WHERE id = @id', {
                    ['@time'] = currentTime, 
                    ['@store'] = newStore, 
                    ['@finish'] = newFinish, 
                    ['@id'] = kitchenData.id,
            })
    
            local editedLine = 0
            for k, v in pairs(kitchenOwner) do
                if v.id == kitchenData.id then
                    kitchenOwner[k].lastlogin = currentTime
                    kitchenOwner[k].store = newStore
                    kitchenOwner[k].finish = newFinish
                    type = v.type
                    editedLine = k
                break
                end
            end
            
            if newStore == 0 then
                TriggerClientEvent('hd_puredrugs:msg', source, Translation[Config.Locale]['successfully_produced'] .. newFinish - oldFinish .. 'x ' .. type .. Translation[Config.Locale]['successfully_produced_storageEmpty'])
            else
                TriggerClientEvent('hd_puredrugs:msg', source, Translation[Config.Locale]['successfully_produced'] .. newFinish - oldFinish .. 'x ' .. type .. Translation[Config.Locale]['successfully_produced_3'])
            end
            
            TriggerClientEvent('hd_puredrugs:updatekitchens', source, editedLine, kitchenOwner[editedLine])
            profit = 0

        end

    end

end)

RegisterServerEvent('hd_puredrugs:store')
AddEventHandler('hd_puredrugs:store', function(type, kitchenID, capacity, amount)

    local _source   = source
    local xPlayer   = ESX.GetPlayerFromId(_source)
    local count = xPlayer.getInventoryItem(type).count
    local editedLine = nil

    if xPlayer then
        if count >= amount then
            
            for k, v in pairs(kitchenOwner) do
                if v.id == kitchenID then
                    if (v.store + amount) <= capacity then

                        MySQL.Async.execute(
                            'UPDATE kitchen_owner SET store = @store WHERE id = @id', {
                                ['@store'] = v.store + amount, 
                                ['@id'] = kitchenID,
                        })

                        kitchenOwner[k].store = v.store + amount
                        xPlayer.removeInventoryItem(type, amount)
                        editedLine = k

                    else
                        TriggerClientEvent('hd_puredrugs:msg', source, Translation[Config.Locale]['menu_storage_storageLimit'] .. capacity - v.store  .. Translation[Config.Locale]['menu_storage_storageLimit_2'])
                    end
                break
                end
            end
            TriggerClientEvent('hd_puredrugs:updatekitchens', source, editedLine, kitchenOwner[editedLine])

        else

            TriggerClientEvent('hd_puredrugs:msg', source, Translation[Config.Locale]['menu_storage_notenough'])

        end
    end

end)

RegisterServerEvent('hd_puredrugs:sellItems')
AddEventHandler('hd_puredrugs:sellItems', function(item, amount, price)

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
        TriggerClientEvent('hd_puredrugs:msg', _source, Translation[Config.Locale]['items_sold_for'] .. price * amount .. '$')
    else
        TriggerClientEvent('hd_puredrugs:msg', _source, Translation[Config.Locale]['you_only_have_items'] .. itemCount .. Translation[Config.Locale]['you_only_have_items2'])
    end

end)

-- OneSync getPlayers

ESX.RegisterServerCallback('hd_puredrugs:getPlayersInArea', function(source, cb, position, distance)
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
  

RegisterServerEvent('hd_puredrugs:buyVehicle')
AddEventHandler('hd_puredrugs:buyVehicle', function(index, kitchenID)

    local _source   = source
    local xPlayer   = ESX.GetPlayerFromId(_source)
    local car = Config.Vehicles[index]
    local editedLine = nil

    if xPlayer.getMoney() >= car.price then
        xPlayer.removeMoney(car.price)

        for k, v in pairs(kitchenOwner) do
            if v.id == kitchenID then
                kitchenOwner[k].vehicle = index
                editedLine = k
            break
            end
        end

        MySQL.Async.execute(
            'UPDATE kitchen_owner SET vehicle = @vehicle WHERE id = @id', {
                ['@vehicle'] = index, 
                ['@id'] = kitchenID,
        })

        TriggerClientEvent('hd_puredrugs:msg', source, Translation[Config.Locale]['mission_car_changed'] .. car.label .. Translation[Config.Locale]['mission_car_changed_2'])
        TriggerClientEvent('hd_puredrugs:updatekitchens', source, editedLine, kitchenOwner[editedLine])
    else
        TriggerClientEvent('hd_puredrugs:msg', source, Translation[Config.Locale]['notEnoughMoney'])
    end

end)

RegisterServerEvent('hd_puredrugs:requestMission')
AddEventHandler('hd_puredrugs:requestMission', function(target, kitchenData, personalData)

    --target ist der Spieler der angefragt wird
    -- source ist der Auftraggeber
    TriggerClientEvent('hd_puredrugs:hasRequest', target, source, kitchenData, personalData)

end)

RegisterServerEvent('hd_puredrugs:startMission')
AddEventHandler('hd_puredrugs:startMission', function(target)

    -- target ist der Spieler, für den source die Mission macht
    if target == 'self' then

        TriggerClientEvent('hd_puredrugs:startStorageMission', source, 'self')

    else

        TriggerClientEvent('hd_puredrugs:startStorageMission', source, target)

    end

end)

RegisterServerEvent('hd_puredrugs:payPlants')
AddEventHandler('hd_puredrugs:payPlants', function(amount, price, target)

    local _source   = source
    local xPlayer   = ESX.GetPlayerFromId(_source)
    
    if target == 'self' then
        if xPlayer.getMoney() >= price then
            xPlayer.removeMoney(price)
            TriggerClientEvent('hd_puredrugs:msg', source, '~b~' .. amount .. Translation[Config.Locale]['mission_self_plants_bought'] .. price .. Translation[Config.Locale]['mission_self_plants_bought_2'])
            TriggerClientEvent('hd_puredrugs:deliverPlants', _source, amount, target)
        else
            TriggerClientEvent('hd_puredrugs:msg', source, Translation[Config.Locale]['mission_self_plants_notEnoughMoney'])
            TriggerClientEvent('hd_puredrugs:abortMission', source)
        end
    else
        local targetPlayer = ESX.GetPlayerFromId(target)
        if targetPlayer.getMoney() >= price then
            targetPlayer.removeMoney(price)
            TriggerClientEvent('hd_puredrugs:msg', targetPlayer, '~b~' .. amount .. Translation[Config.Locale]['mission_self_plants_bought'] .. price .. Translation[Config.Locale]['mission_self_plants_bought_2'])
            TriggerClientEvent('hd_puredrugs:msg', source, '~b~' .. amount .. Translation[Config.Locale]['mission_dou_plants_bought'])
            TriggerClientEvent('hd_puredrugs:deliverPlants', source, amount, target)
        else
            TriggerClientEvent('hd_puredrugs:msg', targetPlayer, Translation[Config.Locale]['mission_dou_plants_abort'] .. xPlayer.name .. Translation[Config.Locale]['mission_dou_plants_abort_2'])
            TriggerClientEvent('hd_puredrugs:msg', source, Translation[Config.Locale]['mission_dou_plants_abort_target'])
            TriggerClientEvent('hd_puredrugs:abortMission', source)
        end

    end

end)

RegisterServerEvent('hd_puredrugs:givePlants')
AddEventHandler('hd_puredrugs:givePlants', function(amount, target, type)

    local xPlayer = ESX.GetPlayerFromId(source)
	
    xPlayer.addInventoryItem(type, amount)
    TriggerClientEvent('hd_puredrugs:msg', target, Translation[Config.Locale]['mission_dou_plants_arrived'] .. amount .. Translation[Config.Locale]['mission_dou_plants_arrived_2'])
    TriggerClientEvent('hd_puredrugs:msg', source, Translation[Config.Locale]['mission_dou_plants_arrived_target'])
    --TriggerClientEvent('hd_puredrugs:abortMission', source)
    

end)

RegisterServerEvent('hd_puredrugs:giveFinalItem')
AddEventHandler('hd_puredrugs:giveFinalItem', function(kitchenID, amount, type)

    local xPlayer = ESX.GetPlayerFromId(source)
    local newFinish = 0
    local editedLine = nil

    for k, v in pairs(kitchenOwner) do
        if v.id == kitchenID then
			if kitchenOwner[k].finish >= amount then
				newFinish = kitchenOwner[k].finish - amount
				kitchenOwner[k].finish = newFinish
				editedLine = k
			else
				print('Tried to get too much drugs. Attempt was blocked')
				return
			end
        break
        end
    end

    MySQL.Async.execute(
        'UPDATE kitchen_owner SET finish = @finish WHERE id = @id', {
            ['@finish'] = newFinish, 
            ['@id'] = kitchenID,
    })


	local item = type
	local label = type

	if type == 'poppyjuice' then
		item = Config.CokeItem
        label = Translation[Config.Locale]['pureheroin']
    end
    
    --[[elseif type == 'meth' then
		item = Config.MethItem
		label = Translation[Config.Locale]['meth']
	elseif type == 'coke' then
		item = Config.CokeItem
		label = Translation[Config.Locale]['coke']
	end]]--

    xPlayer.addInventoryItem(item, amount)
    TriggerClientEvent('hd_puredrugs:msg', source, '~g~' .. amount .. 'x ' .. label .. Translation[Config.Locale]['get_from_storage'])
    TriggerClientEvent('hd_puredrugs:updatekitchens', source, editedLine, kitchenOwner[editedLine])
	
	



end)

RegisterServerEvent('hd_puredrugs:upgradekitchen')
AddEventHandler('hd_puredrugs:upgradekitchen', function(kitchenID, level, price)

    local xPlayer = ESX.GetPlayerFromId(source)

    if xPlayer.getMoney() >= price then
        xPlayer.removeMoney(price)
        local editedLine = nil

        for k, v in pairs(kitchenOwner) do
            if v.id == kitchenID then
                kitchenOwner[k].upgraded = level
                editedLine = k
            break
            end
        end
    
        MySQL.Async.execute(
            'UPDATE kitchen_owner SET upgraded = @upgraded WHERE id = @id', {
                ['@upgraded'] = level, 
                ['@id'] = kitchenID,
        })

        TriggerClientEvent('hd_puredrugs:updatekitchens', source, editedLine, kitchenOwner[editedLine])
        TriggerClientEvent('esx:showAdvancedNotification', source, 'CHAR_LJT', Translation[Config.Locale]['upgraded'] .. level .. Translation[Config.Locale]['upgraded_2'], Translation[Config.Locale]['upgraded_title'], '')
        
    else
        TriggerClientEvent('hd_puredrugs:msg', source, Translation[Config.Locale]['notEnoughMoney'])
    end

end)
RegisterServerEvent('hd_puredrugs:buykitchen')
AddEventHandler('hd_puredrugs:buykitchen', function(kitchenData)

    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

    if xPlayer.getMoney() >= kitchenData.price then

        xPlayer.removeMoney(kitchenData.price)

        MySQL.Async.execute(
            'INSERT INTO kitchen_owner (id, owner, kitchen, type, upgraded, vehicle, store, finish, lastlogin, trusted) VALUES (@id, @owner, @kitchen, @type, @upgraded, @vehicle, @store, @finish, @lastlogin, @trusted)', {
              ['@id'] = highestID + 1, 
              ['@owner'] = xPlayer.identifier,
              ['@kitchen'] = kitchenData.name,
              ['@type'] = kitchenData.type,
              ['@upgraded'] = 1,
              ['@vehicle'] = 1,
              ['@store'] = 0,
              ['@finish'] = 0,
              ['@lastlogin'] = 0,
			  ['@trusted'] = '[]',
          })
        
        table.insert(kitchenOwner, {
            id = highestID + 1,
            owner = xPlayer.identifier,
            name = kitchenData.name,
            type = kitchenData.type,
            upgraded = 1,
            vehicle = 1,
            store = 0,
            finish = 0,
            lastlogin = 0,
			trusted = {},
        })

        highestID = highestID + 1
        TriggerClientEvent('hd_puredrugs:setNewkitchenOwned', source, kitchenOwner[#kitchenOwner], xPlayer.identifier)
        TriggerClientEvent('esx:showAdvancedNotification', source, 'CHAR_LJT', Translation[Config.Locale]['kitchen_bought'] .. kitchenData.label .. Translation[Config.Locale]['kitchen_bought_2'], Translation[Config.Locale]['kitchen_bought_title'], '')


    else
        TriggerClientEvent('hd_puredrugs:msg', _source, Translation[Config.Locale]['notEnoughMoney'])
    end


end)

local playersInkitchens = {}

RegisterServerEvent('hd_puredrugs:setPlayerInvisible')
AddEventHandler('hd_puredrugs:setPlayerInvisible', function(kitchenID)

    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

    for k, player in pairs(playersInkitchens) do
        if player.id == kitchenID then
            TriggerClientEvent('hd_puredrugs:setPlayerVisible', player.source, _source)
            TriggerClientEvent('hd_puredrugs:setPlayerVisible', _source, player.source)
        else
            TriggerClientEvent('hd_puredrugs:setPlayerInvisible', player.source, _source)
            TriggerClientEvent('hd_puredrugs:setPlayerInvisible', _source, player.source)
        end
    end

    table.insert(playersInkitchens, {
        id = kitchenID,
        source = source,
        name = xPlayer.name, 
    })


end)

RegisterServerEvent('hd_puredrugs:leavekitchen')
AddEventHandler('hd_puredrugs:leavekitchen', function(kitchenID)

    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

    for k, player in pairs(playersInkitchens) do
        if player.name == xPlayer.name then
            table.remove(playersInkitchens, k)
            break
        end
    end


end)

RegisterServerEvent('hd_puredrugs:saveLastkitchen')
AddEventHandler('hd_puredrugs:saveLastkitchen', function(kitchenID)

  local xPlayer = ESX.GetPlayerFromId(source)

  MySQL.Async.execute(
    'UPDATE users SET last_kitchen = @last_kitchen WHERE identifier = @identifier',
    {
      ['@last_kitchen'] = kitchenID,
      ['@identifier'] = xPlayer.identifier
    }
  )

end)

ESX.RegisterServerCallback('hd_puredrugs:getLastkitchen', function(source, cb)

    local xPlayer = ESX.GetPlayerFromId(source)
  
    MySQL.Async.fetchAll(
    'SELECT last_kitchen FROM users WHERE identifier = @identifier',
    {
      ['@identifier'] = xPlayer.identifier
    },
    function(users)
      cb(users[1].last_kitchen)
    end
  )
  
end)

RegisterServerEvent('hd_puredrugs:sellkitchen')
AddEventHandler('hd_puredrugs:sellkitchen', function(owner, kitchenID, kitchenPrice)
    local xPlayer = ESX.GetPlayerFromId(source)

    if xPlayer.identifier == owner then
        MySQL.Async.execute(
        'DELETE FROM kitchen_owner WHERE id = @id AND owner = @owner',
            {
                ['@id'] = kitchenID,
                ['@owner'] = xPlayer.identifier
            }
        )

        xPlayer.addMoney(kitchenPrice / Config.SellDivide)
        TriggerClientEvent('hd_puredrugs:sellkitchen', -1, kitchenID)
    end

end)

RegisterServerEvent('hd_puredrugs:updateTrusted')
AddEventHandler('hd_puredrugs:updateTrusted', function(type, trustedPlayer, kitchenID)
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

        for k, v in pairs(kitchenOwner) do
            if v.id == kitchenID then


                if (type == "del") then
                    for i = 1, #v.trusted, 1 do
                        if (v.trusted[i].steamID == trustedPlayerFinal) then
                            table.remove(v.trusted, i)
							TriggerClientEvent('hd_puredrugs:updatekitchens', _source, 0, v)
							TriggerClientEvent('hd_puredrugs:deletekitchen', trustedPlayer, v.id)
							--TriggerClientEvent('hd_puredrugs:updatekitchens', trustedPlayer, 0, v)
							TriggerClientEvent('hd_puredrugs:msg', _source, '~y~' .. charname .. Translation[Config.Locale]['menu_access_removed'])
							TriggerClientEvent('hd_puredrugs:msg', trustedPlayer, Translation[Config.Locale]['menu_access_removed_target'] .. v.id .. Translation[Config.Locale]['menu_access_removed_target_2'])
							break
                        end
                    end
                elseif (type == "add") then
                    table.insert(v.trusted, {steamID = trustedPlayerFinal, name = charname})
					TriggerClientEvent('hd_puredrugs:updatekitchens', _source, 0, v)
					TriggerClientEvent('hd_puredrugs:setNewkitchenOwned', trustedPlayer, v, trustedPlayerFinal)
					TriggerClientEvent('hd_puredrugs:updatekitchens', trustedPlayer, 0, v)
					TriggerClientEvent('hd_puredrugs:msg', _source, '~g~' .. charname .. Translation[Config.Locale]['menu_access_granted'])
					TriggerClientEvent('hd_puredrugs:msg', trustedPlayer, Translation[Config.Locale]['menu_access_granted_target'] .. v.id .. Translation[Config.Locale]['menu_access_granted_target_2'])
                end

                trusted = v.trusted
				break
            end
        end
		
        if (trusted ~= nil) then
            MySQL.Async.execute('UPDATE kitchen_owner SET trusted=@trusted WHERE id=@kitchenID LIMIT 1',
            {
                ['@trusted'] = json.encode(trusted),
                ['@kitchenID'] = kitchenID
            })
        end

    end
end)