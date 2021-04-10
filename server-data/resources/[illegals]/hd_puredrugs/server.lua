local ESX = nil
local KitchenOwner = {}
local highestID = 0

TriggerEvent('esx:getSharedObject', function(obj) 
    ESX = obj 
end)

MySQL.ready(function()
    MySQL.Async.fetchAll('SELECT * from Kitchen_owner', {},
        function(result)
            if #result > 0 then
                for k, Kitchen_owner_res in pairs(result) do
                    table.insert(KitchenOwner, {
                        id = Kitchen_owner_res.id,
                        owner = Kitchen_owner_res.owner,
                        name = Kitchen_owner_res.Kitchen,
                        type = Kitchen_owner_res.type,
                        upgraded = Kitchen_owner_res.upgraded,
                        vehicle = Kitchen_owner_res.vehicle,
                        store = Kitchen_owner_res.store,
                        finish = Kitchen_owner_res.finish,
                        lastlogin = Kitchen_owner_res.lastlogin,
						trusted = json.decode(Kitchen_owner_res.trusted),
                    })
                    highestID = Kitchen_owner_res.id
                end
            end
        end
    )
end)

RegisterServerEvent('hd_puredrugs:updateIdentifier')
AddEventHandler('hd_puredrugs:updateIdentifier', function(src, oldidentifier, newidentifier)
	
	for k, Kitchen in pairs(KitchenOwner) do
		for k2, trust in pairs(Kitchen.trusted) do
			if trust.steamID == oldidentifier then
				trust.steamID = newidentifier
				MySQL.Async.execute('UPDATE Kitchen_owner SET trusted=@trusted WHERE id=@KitchenID LIMIT 1',
				{
                ['@trusted'] = json.encode(Kitchen.trusted),
                ['@KitchenID'] = Kitchen.id
				})
				
			end
		end
		if Kitchen.owner == oldidentifier then
			Kitchen.owner = newidentifier
		end
		
	end

end)

RegisterServerEvent('hd_puredrugs:getKitchensFromPlayer')
AddEventHandler('hd_puredrugs:getKitchensFromPlayer', function()

    local xPlayer  = ESX.GetPlayerFromId(source)
    local ownedKitchensPlayer = {}


    --[[for k, ownedKitchen in pairs(KitchenOwner) do

        if ownedKitchen.owner == xPlayer.identifier then
            table.insert(ownedKitchensPlayer, {
                id = ownedKitchen.id,
                owner = ownedKitchen.owner,
                name = ownedKitchen.name,
                type = ownedKitchen.type,
                upgraded = ownedKitchen.upgraded,
                vehicle = ownedKitchen.vehicle,
                store = ownedKitchen.store,
                finish = ownedKitchen.finish,
                lastlogin = ownedKitchen.lastlogin,
				trusted = ownedKitchen.trusted,
            })
            
        end

        if k == #KitchenOwner then
            TriggerClientEvent('hd_puredrugs:receiveKitchens', source, ownedKitchensPlayer)
            --Citizen.Wait(1500)
        end

    end--]]
	
	TriggerClientEvent('hd_puredrugs:receiveKitchens', source, KitchenOwner, xPlayer.identifier)

end)

ESX.RegisterServerCallback('hd_puredrugs:IsKitchenAlreadyOwned', function(source, cb, Kitchenname)

    if #KitchenOwner > 0 then
        for k, v in pairs(KitchenOwner) do
            if v.name == Kitchenname then
                cb(true)
                break
            elseif k == #KitchenOwner then
                cb(false)
            end
        end
    else
        cb(false)
    end

end)

RegisterServerEvent('hd_puredrugs:setLastLogin')
AddEventHandler('hd_puredrugs:setLastLogin', function(KitchenData)
    
    local currentTime = os.time()
    local diff = os.difftime(currentTime, KitchenData.lastlogin)
    local minutes = diff / 60
    
    local profit = math.floor(minutes * (Config.ProduceRate[KitchenData.upgraded] / 60))
    local canBeProduced = KitchenData.store / 4
    --print(profit .. ' could be, but with storage can be prod: ' .. canBeProduced .. ' and KitchenData.store = ' .. KitchenData.store)

    if canBeProduced < 1 then
        MySQL.Async.execute(
            'UPDATE Kitchen_owner SET lastlogin = @time WHERE id = @id', {
                ['@time'] = currentTime, 
        })

        local editedLine = 0
        for k, v in pairs(KitchenOwner) do
            if v.id == KitchenData.id then
                KitchenOwner[k].lastlogin = currentTime
                editedLine = k
            break
            end
        end
        TriggerClientEvent('hd_puredrugs:updateKitchens', source, editedLine, KitchenOwner[editedLine])
        TriggerClientEvent('hd_puredrugs:msg', source, Translation[Config.Locale]['nothing_produced'])
        profit = 0
    end
    if profit >= 1 and canBeProduced >= 1 then

        local type = nil

        if canBeProduced >= profit then
            local oldFinish = KitchenData.finish
            local newStore = KitchenData.store
            local newFinish = KitchenData.finish

            if KitchenData.finish + profit >= Config.FinishCapacity[KitchenData.upgraded] then
                newFinish = Config.FinishCapacity[KitchenData.upgraded]
                if (Config.FinishCapacity[KitchenData.upgraded] - KitchenData.finish) > 0 then
                    newStore = KitchenData.store - ((Config.FinishCapacity[KitchenData.upgraded] - KitchenData.finish) * 4)
                end
            else
                newFinish = KitchenData.finish + profit
                newStore = KitchenData.store - (profit * 4)
            end

            MySQL.Async.execute(
                'UPDATE Kitchen_owner SET lastlogin = @time, store = @store, finish = @finish WHERE id = @id', {
                    ['@time'] = currentTime, 
                    ['@store'] = newStore, 
                    ['@finish'] = newFinish,
                    ['@id'] = KitchenData.id,
            })
    
            local editedLine = 0
            for k, v in pairs(KitchenOwner) do
                if v.id == KitchenData.id then
                    KitchenOwner[k].lastlogin = currentTime
                    KitchenOwner[k].store = newStore
                    KitchenOwner[k].finish = newFinish
                    type = v.type
                    editedLine = k
                break
                end
            end
            

            TriggerClientEvent('hd_puredrugs:msg', source, Translation[Config.Locale]['successfully_produced'] .. newFinish - oldFinish .. 'x ' .. type .. Translation[Config.Locale]['successfully_produced_2'])
            TriggerClientEvent('hd_puredrugs:updateKitchens', source, editedLine, KitchenOwner[editedLine])
            profit = 0
        else
            local oldFinish = KitchenData.finish
            local newStore = KitchenData.store
            local newFinish = KitchenData.finish

            if KitchenData.finish + canBeProduced >= Config.FinishCapacity[KitchenData.upgraded] then
                newFinish = Config.FinishCapacity[KitchenData.upgraded]
                if (Config.FinishCapacity[KitchenData.upgraded] - KitchenData.finish) > 0 then
                    newStore = KitchenData.store - ((Config.FinishCapacity[KitchenData.upgraded] - KitchenData.finish) * 4)
                end
            else
                newFinish = KitchenData.finish + canBeProduced
                newStore = KitchenData.store - (canBeProduced * 4)
            end

            MySQL.Async.execute(
                'UPDATE Kitchen_owner SET lastlogin = @time, store = @store, finish = @finish WHERE id = @id', {
                    ['@time'] = currentTime, 
                    ['@store'] = newStore, 
                    ['@finish'] = newFinish, 
                    ['@id'] = KitchenData.id,
            })
    
            local editedLine = 0
            for k, v in pairs(KitchenOwner) do
                if v.id == KitchenData.id then
                    KitchenOwner[k].lastlogin = currentTime
                    KitchenOwner[k].store = newStore
                    KitchenOwner[k].finish = newFinish
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
            
            TriggerClientEvent('hd_puredrugs:updateKitchens', source, editedLine, KitchenOwner[editedLine])
            profit = 0

        end

    end

end)

RegisterServerEvent('hd_puredrugs:store')
AddEventHandler('hd_puredrugs:store', function(type, KitchenID, capacity, amount)

    local _source   = source
    local xPlayer   = ESX.GetPlayerFromId(_source)
    local count = xPlayer.getInventoryItem(type).count
    local editedLine = nil

    if xPlayer then
        if count >= amount then
            
            for k, v in pairs(KitchenOwner) do
                if v.id == KitchenID then
                    if (v.store + amount) <= capacity then

                        MySQL.Async.execute(
                            'UPDATE Kitchen_owner SET store = @store WHERE id = @id', {
                                ['@store'] = v.store + amount, 
                                ['@id'] = KitchenID,
                        })

                        KitchenOwner[k].store = v.store + amount
                        xPlayer.removeInventoryItem(type, amount)
                        editedLine = k

                    else
                        TriggerClientEvent('hd_puredrugs:msg', source, Translation[Config.Locale]['menu_storage_storageLimit'] .. capacity - v.store  .. Translation[Config.Locale]['menu_storage_storageLimit_2'])
                    end
                break
                end
            end
            TriggerClientEvent('hd_puredrugs:updateKitchens', source, editedLine, KitchenOwner[editedLine])

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
AddEventHandler('hd_puredrugs:buyVehicle', function(index, KitchenID)

    local _source   = source
    local xPlayer   = ESX.GetPlayerFromId(_source)
    local car = Config.Vehicles[index]
    local editedLine = nil

    if xPlayer.getMoney() >= car.price then
        xPlayer.removeMoney(car.price)

        for k, v in pairs(KitchenOwner) do
            if v.id == KitchenID then
                KitchenOwner[k].vehicle = index
                editedLine = k
            break
            end
        end

        MySQL.Async.execute(
            'UPDATE Kitchen_owner SET vehicle = @vehicle WHERE id = @id', {
                ['@vehicle'] = index, 
                ['@id'] = KitchenID,
        })

        TriggerClientEvent('hd_puredrugs:msg', source, Translation[Config.Locale]['mission_car_changed'] .. car.label .. Translation[Config.Locale]['mission_car_changed_2'])
        TriggerClientEvent('hd_puredrugs:updateKitchens', source, editedLine, KitchenOwner[editedLine])
    else
        TriggerClientEvent('hd_puredrugs:msg', source, Translation[Config.Locale]['notEnoughMoney'])
    end

end)

RegisterServerEvent('hd_puredrugs:requestMission')
AddEventHandler('hd_puredrugs:requestMission', function(target, KitchenData, personalData)

    --target ist der Spieler der angefragt wird
    -- source ist der Auftraggeber
    TriggerClientEvent('hd_puredrugs:hasRequest', target, source, KitchenData, personalData)

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
AddEventHandler('hd_puredrugs:giveFinalItem', function(KitchenID, amount, type)

    local xPlayer = ESX.GetPlayerFromId(source)
    local newFinish = 0
    local editedLine = nil

    for k, v in pairs(KitchenOwner) do
        if v.id == KitchenID then
			if KitchenOwner[k].finish >= amount then
				newFinish = KitchenOwner[k].finish - amount
				KitchenOwner[k].finish = newFinish
				editedLine = k
			else
				print('Tried to get too much drugs. Attempt was blocked')
				return
			end
        break
        end
    end

    MySQL.Async.execute(
        'UPDATE Kitchen_owner SET finish = @finish WHERE id = @id', {
            ['@finish'] = newFinish, 
            ['@id'] = KitchenID,
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
    TriggerClientEvent('hd_puredrugs:updateKitchens', source, editedLine, KitchenOwner[editedLine])
	
	



end)

RegisterServerEvent('hd_puredrugs:upgradeKitchen')
AddEventHandler('hd_puredrugs:upgradeKitchen', function(KitchenID, level, price)

    local xPlayer = ESX.GetPlayerFromId(source)

    if xPlayer.getMoney() >= price then
        xPlayer.removeMoney(price)
        local editedLine = nil

        for k, v in pairs(KitchenOwner) do
            if v.id == KitchenID then
                KitchenOwner[k].upgraded = level
                editedLine = k
            break
            end
        end
    
        MySQL.Async.execute(
            'UPDATE Kitchen_owner SET upgraded = @upgraded WHERE id = @id', {
                ['@upgraded'] = level, 
                ['@id'] = KitchenID,
        })

        TriggerClientEvent('hd_puredrugs:updateKitchens', source, editedLine, KitchenOwner[editedLine])
        TriggerClientEvent('esx:showAdvancedNotification', source, 'CHAR_LJT', Translation[Config.Locale]['upgraded'] .. level .. Translation[Config.Locale]['upgraded_2'], Translation[Config.Locale]['upgraded_title'], '')
        
    else
        TriggerClientEvent('hd_puredrugs:msg', source, Translation[Config.Locale]['notEnoughMoney'])
    end

end)
RegisterServerEvent('hd_puredrugs:buyKitchen')
AddEventHandler('hd_puredrugs:buyKitchen', function(KitchenData)

    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

    if xPlayer.getMoney() >= KitchenData.price then

        xPlayer.removeMoney(KitchenData.price)

        MySQL.Async.execute(
            'INSERT INTO Kitchen_owner (id, owner, Kitchen, type, upgraded, vehicle, store, finish, lastlogin, trusted) VALUES (@id, @owner, @Kitchen, @type, @upgraded, @vehicle, @store, @finish, @lastlogin, @trusted)', {
              ['@id'] = highestID + 1, 
              ['@owner'] = xPlayer.identifier,
              ['@Kitchen'] = KitchenData.name,
              ['@type'] = KitchenData.type,
              ['@upgraded'] = 1,
              ['@vehicle'] = 1,
              ['@store'] = 0,
              ['@finish'] = 0,
              ['@lastlogin'] = 0,
			  ['@trusted'] = '[]',
          })
        
        table.insert(KitchenOwner, {
            id = highestID + 1,
            owner = xPlayer.identifier,
            name = KitchenData.name,
            type = KitchenData.type,
            upgraded = 1,
            vehicle = 1,
            store = 0,
            finish = 0,
            lastlogin = 0,
			trusted = {},
        })

        highestID = highestID + 1
        TriggerClientEvent('hd_puredrugs:setNewKitchenOwned', source, KitchenOwner[#KitchenOwner], xPlayer.identifier)
        TriggerClientEvent('esx:showAdvancedNotification', source, 'CHAR_LJT', Translation[Config.Locale]['Kitchen_bought'] .. KitchenData.label .. Translation[Config.Locale]['Kitchen_bought_2'], Translation[Config.Locale]['Kitchen_bought_title'], '')


    else
        TriggerClientEvent('hd_puredrugs:msg', _source, Translation[Config.Locale]['notEnoughMoney'])
    end


end)

local playersInKitchens = {}

RegisterServerEvent('hd_puredrugs:setPlayerInvisible')
AddEventHandler('hd_puredrugs:setPlayerInvisible', function(KitchenID)

    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

    for k, player in pairs(playersInKitchens) do
        if player.id == KitchenID then
            TriggerClientEvent('hd_puredrugs:setPlayerVisible', player.source, _source)
            TriggerClientEvent('hd_puredrugs:setPlayerVisible', _source, player.source)
        else
            TriggerClientEvent('hd_puredrugs:setPlayerInvisible', player.source, _source)
            TriggerClientEvent('hd_puredrugs:setPlayerInvisible', _source, player.source)
        end
    end

    table.insert(playersInKitchens, {
        id = KitchenID,
        source = source,
        name = xPlayer.name, 
    })


end)

RegisterServerEvent('hd_puredrugs:leaveKitchen')
AddEventHandler('hd_puredrugs:leaveKitchen', function(KitchenID)

    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

    for k, player in pairs(playersInKitchens) do
        if player.name == xPlayer.name then
            table.remove(playersInKitchens, k)
            break
        end
    end


end)

RegisterServerEvent('hd_puredrugs:saveLastKitchen')
AddEventHandler('hd_puredrugs:saveLastKitchen', function(KitchenID)

  local xPlayer = ESX.GetPlayerFromId(source)

  MySQL.Async.execute(
    'UPDATE users SET last_Kitchen = @last_Kitchen WHERE identifier = @identifier',
    {
      ['@last_Kitchen'] = KitchenID,
      ['@identifier'] = xPlayer.identifier
    }
  )

end)

ESX.RegisterServerCallback('hd_puredrugs:getLastKitchen', function(source, cb)

    local xPlayer = ESX.GetPlayerFromId(source)
  
    MySQL.Async.fetchAll(
    'SELECT last_Kitchen FROM users WHERE identifier = @identifier',
    {
      ['@identifier'] = xPlayer.identifier
    },
    function(users)
      cb(users[1].last_Kitchen)
    end
  )
  
end)

RegisterServerEvent('hd_puredrugs:sellKitchen')
AddEventHandler('hd_puredrugs:sellKitchen', function(owner, KitchenID, KitchenPrice)
    local xPlayer = ESX.GetPlayerFromId(source)

    if xPlayer.identifier == owner then
        MySQL.Async.execute(
        'DELETE FROM Kitchen_owner WHERE id = @id AND owner = @owner',
            {
                ['@id'] = KitchenID,
                ['@owner'] = xPlayer.identifier
            }
        )

        xPlayer.addMoney(KitchenPrice / Config.SellDivide)
        TriggerClientEvent('hd_puredrugs:sellKitchen', -1, KitchenID)
    end

end)

RegisterServerEvent('hd_puredrugs:updateTrusted')
AddEventHandler('hd_puredrugs:updateTrusted', function(type, trustedPlayer, KitchenID)
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

        for k, v in pairs(KitchenOwner) do
            if v.id == KitchenID then


                if (type == "del") then
                    for i = 1, #v.trusted, 1 do
                        if (v.trusted[i].steamID == trustedPlayerFinal) then
                            table.remove(v.trusted, i)
							TriggerClientEvent('hd_puredrugs:updateKitchens', _source, 0, v)
							TriggerClientEvent('hd_puredrugs:deleteKitchen', trustedPlayer, v.id)
							--TriggerClientEvent('hd_puredrugs:updateKitchens', trustedPlayer, 0, v)
							TriggerClientEvent('hd_puredrugs:msg', _source, '~y~' .. charname .. Translation[Config.Locale]['menu_access_removed'])
							TriggerClientEvent('hd_puredrugs:msg', trustedPlayer, Translation[Config.Locale]['menu_access_removed_target'] .. v.id .. Translation[Config.Locale]['menu_access_removed_target_2'])
							break
                        end
                    end
                elseif (type == "add") then
                    table.insert(v.trusted, {steamID = trustedPlayerFinal, name = charname})
					TriggerClientEvent('hd_puredrugs:updateKitchens', _source, 0, v)
					TriggerClientEvent('hd_puredrugs:setNewKitchenOwned', trustedPlayer, v, trustedPlayerFinal)
					TriggerClientEvent('hd_puredrugs:updateKitchens', trustedPlayer, 0, v)
					TriggerClientEvent('hd_puredrugs:msg', _source, '~g~' .. charname .. Translation[Config.Locale]['menu_access_granted'])
					TriggerClientEvent('hd_puredrugs:msg', trustedPlayer, Translation[Config.Locale]['menu_access_granted_target'] .. v.id .. Translation[Config.Locale]['menu_access_granted_target_2'])
                end

                trusted = v.trusted
				break
            end
        end
		
        if (trusted ~= nil) then
            MySQL.Async.execute('UPDATE Kitchen_owner SET trusted=@trusted WHERE id=@KitchenID LIMIT 1',
            {
                ['@trusted'] = json.encode(trusted),
                ['@KitchenID'] = KitchenID
            })
        end

    end
end)