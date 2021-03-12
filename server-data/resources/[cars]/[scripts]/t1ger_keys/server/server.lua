-------------------------------------
------- Created by T1GER#9080 -------
------------------------------------- 

ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

carKeys = {}
addedKeys = {}
carKeysMenu = {}

-- Callback to fetch owned vehicle key:
ESX.RegisterServerCallback("t1ger_keys:fetchCarKey", function(source, cb, plate)
	local xPlayer = ESX.GetPlayerFromId(source)
	local vehicles = {}
	if xPlayer then
		MySQL.Async.fetchAll('SELECT * FROM owned_vehicles WHERE plate=@plate AND owner=@identifier',{ ['@plate'] = plate, ['@identifier'] = xPlayer.getIdentifier()}, function(data) 
			local KeyFound = false
			if data[1] ~= nil then
				if data[1].plate == plate then
					if data[1].gotKey == 1 then 
						KeyFound = true
					end
				end
			end
			if KeyFound then
				cb(true)
			else
				cb(false)
			end
		end)
	end
end)

        
ESX.RegisterServerCallback("t1ger_keys:fetchCarPrice", function(source, cb, model)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer then
        MySQL.Async.fetchAll('SELECT price FROM vehicles WHERE model=@model',{['@model'] = model}, function(data)
            cb(data[1].price) 
        end)
    end
end)

-- Callback to check if plate is owned by a player:
ESX.RegisterServerCallback('t1ger_keys:isCarOwned', function(source, cb, plate) 
	local xPlayer = ESX.GetPlayerFromId(source)
	local alarmType = 0
	local isCarOwned = false
    MySQL.Async.fetchAll('SELECT * FROM owned_vehicles WHERE @plate = plate', { ['@plate'] = plate }, function(data)
		if(data[1] ~= nil) then
			isCarOwned = true
			alarmType = data[1].alarm
			cb(isCarOwned,alarmType)
		else
			cb(isCarOwned,alarmType)
		end
    end)
end)

-- Callback to fetch insured vehicles for an identifier:
ESX.RegisterServerCallback("t1ger_keys:fetchInsuranceData", function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)
	local insuredCars = {}
	if xPlayer then
		MySQL.Async.fetchAll('SELECT * FROM owned_vehicles WHERE owner=@identifier',{['@identifier'] = xPlayer.getIdentifier()}, function(data) 
			for k,v in pairs(data) do
				local vehicle = json.decode(v.vehicle)
				if v.insurance == 1 then
					table.insert(insuredCars, {vehicle = vehicle, plate = v.plate, insurance = v.insurance})
				end
			end
			cb(insuredCars)
		end)
	end
end)

-- Server event to update gotKey state:
RegisterServerEvent("t1ger_keys:addKeysToVehicle")
AddEventHandler("t1ger_keys:addKeysToVehicle", function(plate)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer then
		MySQL.Async.fetchAll('SELECT * FROM owned_vehicles WHERE owner=@identifier AND plate=@plate',{['@identifier'] = xPlayer.getIdentifier(),['@plate'] = plate}, function(data) 
			if data[1] ~= nil then
				if data[1].plate == plate then
					MySQL.Async.execute('UPDATE owned_vehicles SET gotKey=@gotKey WHERE plate=@plate',{['@plate'] = plate,['@gotKey'] = 1}, function() end)
				end
			end
		end)
	end
end)

-- Server event to update gotKey state:
RegisterServerEvent("t1ger_keys:registerNewKey")
AddEventHandler("t1ger_keys:registerNewKey", function(plate)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer then
		MySQL.Async.fetchAll('SELECT * FROM owned_vehicles WHERE owner=@identifier AND plate=@plate',{['@identifier'] = xPlayer.getIdentifier(),['@plate'] = plate}, function(data) 
			if data[1] ~= nil then
				if data[1].plate == plate then
					if data[1].gotKey == 0 then
						paidKey = false
						if Config.KeyPayBankMoney then
							if xPlayer.getAccount('bank').money >= Config.RegisterKeyPrice then
								xPlayer.removeAccountMoney('bank', Config.RegisterKeyPrice)
								paidKey = true
							else
								paidKey = false
							end
						else
							if xPlayer.getMoney() >= Config.RegisterKeyPrice then
								xPlayer.removeMoney(Config.RegisterKeyPrice)
								paidKey = true
							else
								paidKey = false
							end
						end
						if paidKey then
							MySQL.Async.execute('UPDATE owned_vehicles SET gotKey=@gotKey WHERE plate=@plate',{['@plate'] = plate,['@gotKey'] = 1}, function() end)
						else
							TriggerClientEvent('t1ger_keys:ShowNotifyESX', xPlayer.source, Lang['not_enough_money'])
						end
					end
				end
			end
		end)
	end
end)

-- Server event to update vehicle alarm type:
RegisterServerEvent("t1ger_keys:updateCarAlarm")
AddEventHandler("t1ger_keys:updateCarAlarm", function(plate, alarmType, model, price)
	local xPlayer = ESX.GetPlayerFromId(source)
	local carPlate, carAlarm, carModel, alarmPrice = plate, alarmType, model, price
	
	MySQL.Async.fetchAll('SELECT * FROM owned_vehicles WHERE owner=@identifier and plate=@plate', {['@identifier'] = xPlayer.getIdentifier(), ['@plate'] = carPlate}, function(data)
		if data[1] ~= nil then
			if data[1].alarm == carAlarm then
				if carAlarm == 1 or carAlarm == 2 then
					TriggerClientEvent('t1ger_keys:ShowNotifyESX', xPlayer.source, Lang['alarm_already_owned'])
				else
					TriggerClientEvent('t1ger_keys:ShowNotifyESX', xPlayer.source, Lang['remove_not_exist_alarm'])
				end
			else
				-- Payment:
				local paidAlarm = false
				if not paidAlarm then
					if Config.AlarmPayBankMoney then
						if xPlayer.getAccount('bank').money >= alarmPrice then
							xPlayer.removeAccountMoney('bank', alarmPrice)
							paidAlarm = true
						else
							paidAlarm = false
						end
					else
						if xPlayer.getMoney() >= alarmPrice then
							xPlayer.removeMoney(alarmPrice)
							paidAlarm = true
						else
							paidAlarm = false
						end
					end
				end
				
				-- Update DB and notify player:
				if paidAlarm then
					MySQL.Async.execute('UPDATE owned_vehicles SET alarm=@alarm WHERE plate=@plate',{['@plate'] = plate,['@alarm'] = carAlarm}, function() end)
					if carAlarm == 1 then
						TriggerClientEvent('t1ger_keys:ShowNotifyESX', xPlayer.source, Lang['alarm_I_purchased'])
					elseif carAlarm == 2 then
						TriggerClientEvent('t1ger_keys:ShowNotifyESX', xPlayer.source, Lang['alarm_II_purchased'])	
					elseif carAlarm == 0 then
						TriggerClientEvent('t1ger_keys:ShowNotifyESX', xPlayer.source, Lang['alarm_removed'])
					end
				else
					TriggerClientEvent('t1ger_keys:ShowNotifyESX', xPlayer.source, Lang['not_enough_money'])
				end
			end
		else
			TriggerClientEvent('t1ger_keys:ShowNotifyESX', xPlayer.source, Lang['smth_went_wrong'])
		end
	end)
	
end)

-- Server event to add keys to table
RegisterServerEvent("t1ger_keys:lendCarKeys")
AddEventHandler("t1ger_keys:lendCarKeys", function(target, plate)
	local xPlayer = ESX.GetPlayerFromId(source)
	local tPlayer = ESX.GetPlayerFromId(target)
	local carPlate = tostring(plate)
	carKeys[carPlate] = {}
	table.insert(carKeys[carPlate], {identifier = tPlayer.getIdentifier(), plate = plate, type = "[COPY]"})
	table.insert(carKeysMenu, {identifier = tPlayer.getIdentifier(), plate = plate, type = "copy", label = "[COPY]"})
	TriggerClientEvent('t1ger_keys:syncTableKeys', tPlayer.source, carKeys, tPlayer.getIdentifier(), carKeysMenu)
	TriggerClientEvent('t1ger_keys:ShowNotifyESX', xPlayer.source, Lang['keys_lend_give'])
	TriggerClientEvent('t1ger_keys:ShowNotifyESX', tPlayer.source, Lang['keys_lend_receive'])
end)

-- Server event to update stolen car keys
RegisterServerEvent("t1ger_keys:stolenCarKeys")
AddEventHandler("t1ger_keys:stolenCarKeys", function(plate)
    local xPlayer = ESX.GetPlayerFromId(source)
	local carPlate = tostring(plate)
	carKeys[carPlate] = {}
	table.insert(carKeys[carPlate], {identifier = xPlayer.getIdentifier()})
	table.insert(carKeysMenu, {identifier = xPlayer.getIdentifier(), plate = plate, type = "stolen", label = "[STOLEN]"})
	TriggerClientEvent('t1ger_keys:syncTableKeys', source, carKeys, xPlayer.getIdentifier(), carKeysMenu)
end)

RegisterServerEvent("t1ger_keys:removeTempKeySV")
AddEventHandler("t1ger_keys:removeTempKeySV", function(plate)
	print(plate)
	local xPlayer = ESX.GetPlayerFromId(source)
	for k,v in pairs(carKeys[plate]) do
		table.remove(carKeys[plate],k)
	end
	for k,v in pairs(carKeysMenu) do 
		if plate == v.plate then
			table.remove(carKeysMenu,k)
		end
	end
end)

-- Server event to add keys to a plate
RegisterServerEvent("t1ger_keys:addTempKeysToVeh")
AddEventHandler("t1ger_keys:addTempKeysToVeh", function(plate)
    local xPlayer = ESX.GetPlayerFromId(source)
	local carPlate = plate:gsub("^%s*(.-)%s*$", "%1")
	addedKeys[carPlate] = {}
	table.insert(addedKeys[carPlate], {identifier = xPlayer.getIdentifier()})
	TriggerClientEvent('t1ger_keys:syncAddedKeys', source, addedKeys, xPlayer.getIdentifier())
end)

-- Usable item to lockpick vehicles:
Citizen.CreateThread(function()
	for k,v in pairs(Config.LockpickItem) do 
		ESX.RegisterUsableItem(v.ItemName, function(source)
			local xPlayer = ESX.GetPlayerFromId(source)
			local itemLabel = v.ItemLabel
			TriggerClientEvent("t1ger_keys:lockpickCL",source,k,v)
			-- Remove Item Upon Callback:
			ESX.RegisterServerCallback("t1ger_keys:removeLockpick",function(source,cb)
				local xPlayer = ESX.GetPlayerFromId(source)
				local lockpick = xPlayer.getInventoryItem(v.ItemName).count >= 1
				if lockpick then
					xPlayer.removeInventoryItem(v.ItemName,1)
					cb(true)
				end
			end)	
		end)
	end
end)

-- Callback to fetch whitelisted vehicle key:
ESX.RegisterServerCallback("t1ger_keys:fetchCarWlKey", function(source, cb, hashKey)
	local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer then
		local HasWhitelist = false
		for k,v in pairs(Config.WhitelistCars) do
			if hashKey == v.model then
				for _,y in pairs (Config.WhitelistCars[k].job) do
					if xPlayer.job.name == y then
						HasWhitelist = true
					end
				end
			end
		end
		if HasWhitelist then
			cb(true)
		else
			cb(false)
		end
	end
end)

-- Server Event for Job Reward:
RegisterServerEvent("t1ger_keys:giveSearchReward")
AddEventHandler("t1ger_keys:giveSearchReward", function()
	local xPlayer = ESX.GetPlayerFromId(source)
	
	-- CASH REWARDS:
	local cashChance = (math.random() * 100)
	if Config.ExtraCash.chance < cashChance then
		local type = Config.ExtraCash.type
		local amount = math.random(Config.ExtraCash.min,Config.ExtraCash.max) 
		if type == "cash" then
			xPlayer.addMoney(amount)
		elseif type == "dirty" then
			xPlayer.addAccountMoney('black_money',amount)
		end
		TriggerClientEvent('t1ger_keys:ShowNotifyESX', xPlayer.source, (Lang['cash_found']):format(amount))
	end
	
	-- ITEM REWARDS:
	local k = 0
	for k,v in pairs(Config.SearchItems) do
		local itemChance = (math.random() * 100)
		if v.chance > itemChance then
			local item = v.item
			local name = v.name
			local amount = math.random(v.min,v.max)
			xPlayer.addInventoryItem(item, tonumber(amount))
			TriggerClientEvent('t1ger_keys:ShowNotifyESX', xPlayer.source, (Lang['item_found']):format(amount,name))
		end
		k = (k + 1)
	end
	
end)

-- Event for police alerts
RegisterServerEvent('t1ger_keys:PoliceNotifySV')
AddEventHandler('t1ger_keys:PoliceNotifySV', function(targetCoords, streetName)
	TriggerClientEvent('t1ger_keys:PoliceNotifyCL', -1, (Lang['police_notify']):format(streetName))
	TriggerClientEvent('t1ger_keys:PoliceNotifyBlip', -1, targetCoords)
end)

-- Event for police alerts
RegisterServerEvent('t1ger_keys:PoliceNotifySV2')
AddEventHandler('t1ger_keys:PoliceNotifySV2', function(targetCoords, streetName, vehInfo)
	TriggerClientEvent('t1ger_keys:PoliceNotifyCL', -1, vehInfo)
	TriggerClientEvent('t1ger_keys:PoliceNotifyBlip', -1, targetCoords)
end)