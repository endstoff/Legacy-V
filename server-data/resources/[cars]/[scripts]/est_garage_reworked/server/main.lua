ESX = nil

TriggerEvent('esx:getSharedObject', function(obj)
	ESX = obj
end)


ESX.RegisterServerCallback('est_garage:loadVehicles', function(source, cb)
	local ownedCars = {}
	local s = source
	local x = ESX.GetPlayerFromId(s)
	
	MySQL.Async.fetchAll('SELECT * FROM owned_vehicles WHERE `owner` = @owner AND `stored` = 1', {['@owner'] = x.identifier}, function(vehicles)

		for _,v in pairs(vehicles) do
			local vehicle = json.decode(v.vehicle)
			table.insert(ownedCars, {vehicle = vehicle, stored = v.stored, plate = v.plate})
		end
		cb(ownedCars)
	end)
end)

ESX.RegisterServerCallback('est_garage:loadVehicle', function(source, cb, plate)
	
	local s = source
	local x = ESX.GetPlayerFromId(s)
	
	MySQL.Async.fetchAll('SELECT * FROM owned_vehicles WHERE `plate` = @plate', {['@plate'] = plate}, function(vehicle)

		
		cb(vehicle)
	end)
end)
--[[
MySQL.ready(function()

	MySQL.Async.execute('UPDATE owned_vehicles SET `stored` = true WHERE `stored` = @stored', {
		['@stored'] = false
	}, function(rowsChanged)
		if rowsChanged > 0 then
			print(('esx_advancedgarage: %s vehicle(s) have been stored!'):format(rowsChanged))
		end
	end)
end)
]]

ESX.RegisterServerCallback('est_garage:isOwned', function(source, cb, plate)
	
	local s = source
	local x = ESX.GetPlayerFromId(s)

	
	MySQL.Async.fetchAll('SELECT `vehicle` FROM owned_vehicles WHERE `plate` = @plate AND `owner` = @owner', {['@plate'] = plate, ['@owner'] = x.identifier}, function(vehicle)
		if next(vehicle) then
			cb(true)
		else
			cb(false)
		end
	end)

end)


RegisterNetEvent('est_garage:changeState')
AddEventHandler('est_garage:changeState', function(plate, state)
	MySQL.Sync.execute("UPDATE owned_vehicles SET `stored` = @state WHERE `plate` = @plate", {['@state'] = state, ['@plate'] = plate})
end)

RegisterNetEvent('est_garage:saveProps')
AddEventHandler('est_garage:saveProps', function(plate, props)
	local xProps = json.encode(props)
	MySQL.Sync.execute("UPDATE owned_vehicles SET `vehicle` = @props WHERE `plate` = @plate", {['@plate'] = plate, ['@props'] = xProps})
end)



-- Datenbankabfrage (Sind Autos beim Abschlepper?)


ESX.RegisterServerCallback('abschlepper:getOutOwnedCars', function(source, cb)
	local ownedCars = {}
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	
	MySQL.Async.fetchAll('SELECT * FROM owned_vehicles WHERE owner = @owner AND Type = @Type AND `stored` = @stored', {
		['@owner'] = GetPlayerIdentifiers(source)[1],
		['@Type']   = 'car',
		['@stored'] = false
	}, function(data) 
		for _,v in pairs(data) do
			local vehicle = json.decode(v.vehicle)
			table.insert(ownedCars, vehicle)
		end
		cb(ownedCars)
	end)
end)




-- Abschlepper Geldabfrage


ESX.RegisterServerCallback('abschlepper:checkMoneyCars', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)
	if Config.BankKarte then
		if xPlayer.getAccount('bank').money >= Config.AbschleppPreis then
			cb(true)
	
		else
			cb(false)
		end
	else
		if xPlayer.getMoney() >= Config.AbschleppPreis then
			cb(true)
		else
			cb(false)
		end
	end
end)


-- Abschlepper bezahlen


RegisterServerEvent('abschlepper:payCar')
AddEventHandler('abschlepper:payCar', function()
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.getAccount('bank').money >= Config.AbschleppPreis then
		xPlayer.removeAccountMoney('bank', Config.AbschleppPreis)
		TriggerClientEvent('esx:showNotification', source, "Du bezahlst ~g~" .. Config.AbschleppPreis .. "$~s~ für das ~y~Abschleppen~s~ deines Fahrzeugs.")
	elseif xPlayer.getMoney() >= Config.AbschleppPreis then
		xPlayer.removeMoney(Config.AbschleppPreis)
		TriggerClientEvent('esx:showNotification', source, "Du bezahlst ~g~" .. Config.AbschleppPreis .. "$~s~ für das ~y~Abschleppen~s~ deines Fahrzeugs.")
	end
end)