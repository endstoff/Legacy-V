ESX               = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterServerCallback('esx_miner:getItemQ', function(source, cb, item)
    local xPlayer  = ESX.GetPlayerFromId(source)
    local quantity = xPlayer.getInventoryItem(item).count
    cb(quantity)
end)

RegisterNetEvent("esx_miner:givestone")
AddEventHandler("esx_miner:givestone", function(item, count)
    local _source = source
    local xPlayer  = ESX.GetPlayerFromId(_source)
		if xPlayer ~= nil then
			if xPlayer.getInventoryItem('spitzhacke').count > 0 then
			    if xPlayer.getInventoryItem('stone').count < 100 then
				    TriggerClientEvent("esx_miner:givestone", source)
				    Citizen.Wait(0)
                    xPlayer.addInventoryItem('stone', 5)
                elseif xPlayer.getInventoryItem('stone').count > 99 then
                    TriggerClientEvent('esx:showNotification', source, 'Du hast ~r~kein~s~ Platz mehr in deinen ~b~Taschen~s~.')
				end
			elseif xPlayer.getInventoryItem('spitzhacke').count < 1 then
				--TriggerClientEvent('esx:showNotification', source, 'Du hast ~r~keine~s~ Spitzhacke.')
				TriggerClientEvent('b1g_notify:client:Notify', source, { type = 'false', text = 'Du hast keine Spitzhacke' })
			end
        end
    end)

    
RegisterNetEvent("esx_miner:washing")
AddEventHandler("esx_miner:washing", function(item, count)
    local _source = source
    local xPlayer  = ESX.GetPlayerFromId(_source)
		if xPlayer ~= nil then
			if xPlayer.getInventoryItem('burste').count > 0 then
                if xPlayer.getInventoryItem('stone').count > 9 then
                    TriggerClientEvent("esx_miner:washing", source)
                    Citizen.Wait(0)
                    xPlayer.addInventoryItem('washed_stone', 10)
                    xPlayer.removeInventoryItem("stone", 10)
                elseif xPlayer.getInventoryItem('stone').count < 10 then
                    TriggerClientEvent('esx:showNotification', source, 'Du hast keine ~b~Steine~s~.')
				end
			elseif xPlayer.getInventoryItem('burste').count < 1 then
				TriggerClientEvent('b1g_notify:client:Notify', source, { type = 'false', text = 'Du hast keine Bürste' })
			end
        end
    end)

RegisterNetEvent("esx_miner:remelting")
AddEventHandler("esx_miner:remelting", function(item, count)
    local _source = source
    local xPlayer  = ESX.GetPlayerFromId(_source)
    local randomChance = math.random(1, 100)
		if xPlayer ~= nil then
			if xPlayer.getInventoryItem('tiegelzange').count > 0 then
                if xPlayer.getInventoryItem('washed_stone').count > 9 then
                    TriggerClientEvent("esx_miner:remelting", source)
                    Citizen.Wait(0)
				    if randomChance < 10 then
					    xPlayer.addInventoryItem("diamond", 1)
					    xPlayer.removeInventoryItem("washed_stone", 10)
					    TriggerClientEvent('esx:showNotification', _source, 'Du hast ~g~1~s~ ~b~Diamant~s~ ~w~erhalten~s~.')
				    elseif randomChance > 9 and randomChance < 25 then
					    xPlayer.addInventoryItem("gold", 3)
					    xPlayer.removeInventoryItem("washed_stone", 10)
					    TriggerClientEvent('esx:showNotification', _source, 'Du hast ~g~3~s~ ~y~Gold~s~ ~w~erhalten~s~.')
				    elseif randomChance > 24 and randomChance < 50 then
					    xPlayer.addInventoryItem("iron", 5)
					    xPlayer.removeInventoryItem("washed_stone", 10)
					    TriggerClientEvent('esx:showNotification', _source, 'Du hast ~g~5~s~ Eisen ~w~erhalten~s~.')
				    elseif randomChance > 49 then
					    xPlayer.addInventoryItem("copper", 10)
					    xPlayer.removeInventoryItem("washed_stone", 10)
					    TriggerClientEvent('esx:showNotification', _source, 'Du hast ~g~10~s~ ~o~Kupfer~s~ ~w~erhalten~s~.')
				    end
                elseif xPlayer.getInventoryItem('washed_stone').count < 10 then
                    TriggerClientEvent('esx:showNotification', source, 'Du hast ~r~nicht~s~ genug ~b~gewaschene Steine~s~.')
				end
			elseif xPlayer.getInventoryItem('tiegelzange').count < 1 then
				TriggerClientEvent('b1g_notify:client:Notify', source, { type = 'false', text = 'Du hast keine Tiegelzange' })
			end
        end
    end)


RegisterServerEvent('esx_miner:sellcopper')
AddEventHandler('esx_miner:sellcopper', function(itemName, amount)
	local xPlayer = ESX.GetPlayerFromId(source)
	local price = Config.Items[itemName]
	local xItem = xPlayer.getInventoryItem(itemName)

	if not price then
		print(('esx_miner: %s attempted to sell an invalid erz!'):format(xPlayer.identifier))
		return
	end

	if xItem.count < amount then
		return
	end

	price = ESX.Math.Round(price * amount)

	if Config.GiveBlack then
		xPlayer.addAccountMoney('bank', price)
	else
		xPlayer.addMoney(price)
	end

	xPlayer.removeInventoryItem(xItem.name, amount)
end)

RegisterServerEvent('esx_miner:selliron')
AddEventHandler('esx_miner:selliron', function(itemName, amount)
	local xPlayer = ESX.GetPlayerFromId(source)
	local price = Config.Iron[itemName]
	local xItem = xPlayer.getInventoryItem(itemName)

	if not price then
		print(('esx_miner: %s attempted to sell an invalid erz!'):format(xPlayer.identifier))
		return
	end

	if xItem.count < amount then
		return
	end

	price = ESX.Math.Round(price * amount)

	if Config.GiveBlack then
		xPlayer.addAccountMoney('bank', price)
	else
		xPlayer.addMoney(price)
	end

	xPlayer.removeInventoryItem(xItem.name, amount)
end)

RegisterServerEvent('esx_miner:sellgold')
AddEventHandler('esx_miner:sellgold', function(itemName, amount)
	local xPlayer = ESX.GetPlayerFromId(source)
	local price = Config.Gold[itemName]
	local xItem = xPlayer.getInventoryItem(itemName)

	if not price then
		print(('esx_miner: %s attempted to sell an invalid erz!'):format(xPlayer.identifier))
		return
	end

	if xItem.count < amount then
		return
	end

	price = ESX.Math.Round(price * amount)

	if Config.GiveBlack then
		xPlayer.addAccountMoney('bank', price)
	else
		xPlayer.addMoney(price)
	end

	xPlayer.removeInventoryItem(xItem.name, amount)
end)

RegisterServerEvent('esx_miner:selldiamond')
AddEventHandler('esx_miner:selldiamond', function(itemName, amount)
	local xPlayer = ESX.GetPlayerFromId(source)
	local price = Config.Diamond[itemName]
	local xItem = xPlayer.getInventoryItem(itemName)

	if not price then
		print(('esx_miner: %s attempted to sell an invalid erz!'):format(xPlayer.identifier))
		return
	end

	if xItem.count < amount then
		return
	end

	price = ESX.Math.Round(price * amount)

	if Config.GiveBlack then
		xPlayer.addAccountMoney('bank', price)
	else
		xPlayer.addMoney(price)
	end

	xPlayer.removeInventoryItem(xItem.name, amount)
end)
