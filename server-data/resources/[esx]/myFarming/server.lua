local ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) 
    ESX = obj 
end)

local playerXP = {}
local oldXP = nil
local highestid = 0

local shopContent = {}
local availableAssignments = Config.LocalItems

-- ONMYSQLREADY
MySQL.ready(function()
    MySQL.Async.fetchAll('SELECT * from job_xp', {},
        function(result)
            if #result > 0 then
                for k, res in pairs(result) do
                    table.insert(playerXP, {
                    id = res.id, 
                    steamID = res.steamID,
                    xp = json.decode(res.xp),
                    })
                    highestid = res.id

                    if k == #result then
                        oldXP = playerXP
                    end
                end

            end
        end
    )
end)

RegisterServerEvent('myFarming:getJobXP')
AddEventHandler('myFarming:getJobXP', function()
	--local xPlayer = ESX.GetPlayerFromId(source)
    --local steamid = GetPlayerIdentifiers(source)[1]
	local steamID = GetPlayerIdentifiers(source)[1]
	if Config.useNewESX then
		steamID = string.gsub(GetPlayerIdentifiers(source)[2], "license:", "")
	end
	
    for k, v in pairs(playerXP) do
        if v.steamID == steamID then
            TriggerClientEvent('myFarming:receiveJobXP', source, v.xp)
        end
    end

end)

RegisterServerEvent('myFarming:updateIdentifier')
AddEventHandler('myFarming:updateIdentifier', function(src, oldidentifier, newidentifier)
	
	for k, xp in pairs(playerXP) do
		if xp.steamID == oldidentifier then
			xp.steamID = newidentifier
		end
	end

end)

RegisterServerEvent('myFarming:collectItems')
AddEventHandler('myFarming:collectItems', function(item, label, amount, xptype)

    local xPlayer = ESX.GetPlayerFromId(source)

    if Config.useIntegratedWeightSystem then

        local weight = 0
        --if availableRessource[item] ~= nil and availableRessource[item] >= amount then

        for k, v in pairs(xPlayer.inventory) do
            if Config.ItemLimits[v.name] ~= nil then
                weight = weight + v.count * Config.ItemLimits[v.name]
                --print(v.name)
            end
        end

        --print(weight .. ' / 5 000')
        
        --print(Config.ItemLimits[item])
        if weight + amount * Config.ItemLimits[item] <= Config.MaxCarry then
            xPlayer.addInventoryItem(item, amount)
            TriggerClientEvent('myFarming:msg', source, '~g~' .. amount .. 'x ' .. label .. ' ~s~' .. Translation[Config.Locale]['collected'] .. ' (~g~' .. weight + amount * Config.ItemLimits[item] .. '~s~/~y~' .. Config.MaxCarry .. '~s~)')
            if xptype ~= nil then
                addJobXP(source, xptype, amount)
            end
        else
            TriggerClientEvent('myFarming:msg', source, Translation[Config.Locale]['too_heavy'])
        end

    elseif Config.useESXWeightSystem then
        if xPlayer.canCarryItem(item, amount) then
            xPlayer.addInventoryItem(item, amount)
            TriggerClientEvent('myFarming:msg', source, '~g~' .. amount .. 'x ' .. label .. ' ~s~' .. Translation[Config.Locale]['collected'])
            if xptype ~= nil then
                addJobXP(source, xptype, amount)
            end
        else
            TriggerClientEvent('myFarming:msg', source, Translation[Config.Locale]['too_heavy'])
        end
    else
        xPlayer.addInventoryItem(item, amount)
        TriggerClientEvent('myFarming:msg', source, '~g~' .. amount .. 'x ' .. label .. ' ~s~' .. Translation[Config.Locale]['collected'])
        if xptype ~= nil then
            addJobXP(source, xptype, amount)
        end
    end

	--availableRessource[item] = availableRessource[item] - amount
    --[[else

        TriggerClientEvent('myFarming:msg', source, '~y~Das Gebiet ist erschöpft! Komme später wieder, um mehr ~w~' .. label .. ' ~y~zu erhalten.')

    end--]]

end)


RegisterServerEvent('myFarming:craftItem')
AddEventHandler('myFarming:craftItem', function(itemData)

    local _source   = source
    local xPlayer   = ESX.GetPlayerFromId(_source)

    local craftAmount = itemData.craftAmount

    for k, v in pairs(itemData.reqItems) do
        local itemCount = xPlayer.getInventoryItem(v.item).count

        if itemCount < v.amount then
            TriggerClientEvent('myFarming:msg', _source, Translation[Config.Locale]['not_enough_items'] .. v.label)
            return
        elseif itemCount < (v.amount * craftAmount) then
            for i=craftAmount, 1, -1 do
                if itemCount >= (v.amount * i) then
                    if i < craftAmount then
                        craftAmount = i
                        break
                    end
                end
            end
        end

        if k == #itemData.reqItems then
            TriggerClientEvent('myFarming:startCrafting', _source, itemData, craftAmount)
        end

    end


end)

RegisterServerEvent('myFarming:finishedCrafting')
AddEventHandler('myFarming:finishedCrafting', function(itemData, craftAmount)


    local _source   = source
    local xPlayer   = ESX.GetPlayerFromId(_source)

    for k, v in pairs(itemData.reqItems) do
        local itemCount = xPlayer.getInventoryItem(v.item).count

        if itemCount < (v.amount * craftAmount) then
            TriggerClientEvent('myFarming:msg', _source, Translation[Config.Locale]['not_enough_items'] .. v.label)
            return
        end

        if k == #itemData.reqItems then
            
            for k2, v2 in pairs(itemData.reqItems) do

                xPlayer.removeInventoryItem(v2.item, v2.amount * craftAmount)

            end

            xPlayer.addInventoryItem(itemData.newitem.sqlitem, itemData.newitemamount * craftAmount)
            print(itemData.newitem.sqlitem)
            TriggerClientEvent('myFarming:msg', _source, Translation[Config.Locale]['craftting_finished'] .. itemData.newitemamount * craftAmount .. 'x ' .. itemData.newitem.label .. Translation[Config.Locale]['craftting_finished2'])
			
            if itemData.giveXP ~= nil then
                addJobXP(_source, itemData.giveXP.type, math.random(itemData.giveXP.a, itemData.giveXP.b) * craftAmount)
            end

        end

    end

end)


RegisterServerEvent('myFarming:sellItems')
AddEventHandler('myFarming:sellItems', function(item, amount, price)

    local _source   = source
    local xPlayer   = ESX.GetPlayerFromId(_source)
    local itemCount = xPlayer.getInventoryItem(item).count

    if itemCount > 0 and itemCount >= amount then
        --print('test')
        xPlayer.removeInventoryItem(item, amount)
        xPlayer.addMoney(price * amount)
        TriggerClientEvent('myFarming:msg', _source, Translation[Config.Locale]['items_sold_for'] .. price * amount .. '$')

    else
        TriggerClientEvent('myFarming:msg', _source, Translation[Config.Locale]['you_only_have_items'] .. itemCount .. Translation[Config.Locale]['you_only_have_items2'])
    end

end)

RegisterServerEvent('myFarming:startDelivery')
AddEventHandler('myFarming:startDelivery', function(deliveryData)

    local _source   = source
    local xPlayer   = ESX.GetPlayerFromId(_source)


    for j, assignment in pairs(shopContent) do
        if assignment.id == deliveryData.id then
            if assignment.state ~= 0 then
                TriggerClientEvent('myFarming:msg', _source, Translation[Config.Locale]['mission_in_process'])
                return
            else
                for k, v in pairs(deliveryData.requires) do
                    local itemCount = xPlayer.getInventoryItem(v.item).count
            
                    if itemCount < v.amount then
                        TriggerClientEvent('myFarming:msg', _source, Translation[Config.Locale]['not_enough_items'] .. v.label)
                        return
                    end
            
                    if k == #deliveryData.requires then
                        TriggerClientEvent('myFarming:startDelivery_cl', _source, deliveryData)
                        assignment.state = 1
                        --print(assignment.label .. ' set to ' .. assignment.state)
                    end
            
                end
            end
            break
        elseif j == #shopContent then
            TriggerClientEvent('myFarming:msg', _source, Translation[Config.Locale]['mission_not_available'])
            return
        end
    end

end)

RegisterServerEvent('myFarming:abortMission')
AddEventHandler('myFarming:abortMission', function(id)

    for k, v in pairs(shopContent) do

        if v.id == id then
            v.state = 0
            break
        end

    end

end)

RegisterServerEvent('myFarming:finishDelivery')
AddEventHandler('myFarming:finishDelivery', function(deliveryData)

    local _source   = source
    local xPlayer   = ESX.GetPlayerFromId(_source)

    for k, v in pairs(deliveryData.requires) do
        local itemCount = xPlayer.getInventoryItem(v.item).count

        if itemCount < v.amount then
            TriggerClientEvent('myFarming:msg', _source, Translation[Config.Locale]['not_enough_items'] .. v.label)
            TriggerEvent('myFarming:abortMission', deliveryData.id)
            return
        end

        if k == #deliveryData.requires then

            for k2, v2 in pairs(deliveryData.requires) do
                xPlayer.removeInventoryItem(v2.item, v2.amount)
            end

            xPlayer.addMoney(deliveryData.price)

            TriggerClientEvent('myFarming:msg', _source, Translation[Config.Locale]['mission_success'] .. deliveryData.label .. Translation[Config.Locale]['mission_success2'] .. deliveryData.price .. Translation[Config.Locale]['mission_success3'])

            for k3, v3 in pairs(shopContent) do
                --print(v3.label .. ': ' .. v3.state)
                if v3.id == deliveryData.id then

                    shopContent[k3].state = 0
                    table.insert(availableAssignments, shopContent[k3])
                    table.remove(shopContent, k3)
                    addAssignment(1)
                    
                end
            end

            
        end

    end

end)

function addJobXP(_source, typec, amountc)

	--local xPlayer = ESX.GetPlayerFromId(_source)
	local steamID = GetPlayerIdentifiers(_source)[1]
	print('got steamID: ' .. GetPlayerIdentifiers(_source)[1])
	if Config.useNewESX then
		steamID = string.gsub(GetPlayerIdentifiers(_source)[2], "license:", "")
		print('updated to license: ' .. steamID)
	end
	--print('set ' .. _source .. ' ' .. typec .. amountc )
	
    if #playerXP > 0 then
        print('case 0')
		for k, v in pairs(playerXP) do
            if v.steamID == steamID then
				if #v.xp > 0 then
					for k2, v2 in pairs(v.xp) do
						if v2.type == typec then
							v2.amount = v2.amount + amountc
                        elseif k2 == #v.xp then
							table.insert(v.xp, {
								type = typec,
								amount = amountc,
							})
						end
					end
				else
					table.insert(v.xp, {
						type = typec,
						amount = amountc,
					})

				end
				MySQL.Async.execute(
					'UPDATE job_xp SET xp=@xp WHERE steamID=@steamID', {
					['@steamID'] = steamID,
					['@xp'] = json.encode(v.xp),
				})
				
				TriggerClientEvent('myFarming:receiveJobXP', _source, v.xp)
                break
                
            elseif k == #playerXP then

                createPlayer(steamID)

                local xp = {}
                table.insert(xp, {
                    type = typec,
                    amount = amountc,
                })

                MySQL.Async.execute(
					'UPDATE job_xp SET xp=@xp WHERE steamID=@steamID', {
					['@steamID'] = steamID,
					['@xp'] = json.encode(xp),
				})
				
                TriggerClientEvent('myFarming:receiveJobXP', _source, xp)
                return

            end
			
		end
		
	else
		createPlayer(steamID)

		local xp = {}
		table.insert(xp, {
			type = typec,
			amount = amountc,
		})

		MySQL.Async.execute(
			'UPDATE job_xp SET xp=@xp WHERE steamID=@steamID', {
			['@steamID'] = steamID,
			['@xp'] = json.encode(xp),
		})
		
		TriggerClientEvent('myFarming:receiveJobXP', _source, xp)
		return
	end

end


function createPlayer(steamID_res)

    MySQL.Async.execute(
    'INSERT INTO job_xp (id, steamID, xp) VALUES (@id, @steamID, @xp)', {
      ['@id'] = highestid +1, 
      ['@steamID'] = steamID_res,
      ['@xp'] = '[]',
    })

    table.insert(playerXP, {
        id = highestid+1,
        steamID = steamID_res,
        xp = {},
    })

    highestid = highestid + 1

end

Citizen.CreateThread(function()

    while true do
        Citizen.Wait(1800000) -- 1800000
        if #shopContent > 0 then
            table.insert(availableAssignments, shopContent[1])
            table.remove(shopContent, 1)
            addAssignment(1)
        else
            addAssignment(Config.RandomPickAmountOnStart)
        end

        --[[for k, v in pairs(availableRessource) do
            if v < 0.8 * Config.AvailableRessources[k] then
                v = v + 0.3 * Config.FullRessources
            end
        end--]]
    end

end)

    

RegisterServerEvent('myFarming:setRandomAssignments')
AddEventHandler('myFarming:setRandomAssignments', function()

    if #shopContent == 0 then

        for i=1, Config.RandomPickAmountOnStart, 1 do

            local random = math.random(1, #availableAssignments)
            table.insert(shopContent, availableAssignments[random])
            table.remove(availableAssignments, random)

        end

    end
end)

function addAssignment(amount)

    if #availableAssignments >= amount then
        for i=1, amount, 1 do

            local random = math.random(1, #availableAssignments)
            table.insert(shopContent, availableAssignments[random])
            table.remove(availableAssignments, random)

        end
    end

end

RegisterServerEvent('myFarming:getShopContent')
AddEventHandler('myFarming:getShopContent', function()

    TriggerClientEvent('myFarming:receiveShopContent', source, shopContent)

end)