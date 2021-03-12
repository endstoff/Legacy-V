ESX = nil

TriggerEvent('esx:getSharedObject', function(obj)
	ESX = obj
end)

ESX.RegisterServerCallback('est_garage:loadVehicles', function(source, cb, state, plate)
	
	local s = source
	local x = ESX.GetPlayerFromId(s)
	
	MySQL.Async.fetchAll('SELECT plate FROM owned_vehicles WHERE owner = @owner AND state = 0', {['@owner'] = x.identifier}, function(vehicles)
		cb(vehicles)
	end)
end)

ESX.RegisterServerCallback('est_garage:loadVehicle', function(source, cb, plate)
	
	local s = source
	local x = ESX.GetPlayerFromId(s)
	
	MySQL.Async.fetchAll('SELECT * FROM owned_vehicles WHERE plate = @plate', {['@plate'] = plate}, function(vehicle)
		cb(vehicle)
	end)
end)

ESX.RegisterServerCallback('est_garage:isOwned', function(source, cb, plate)
	
	local s = source
	local x = ESX.GetPlayerFromId(s)
	
	MySQL.Async.fetchAll('SELECT vehicle FROM owned_vehicles WHERE plate = @plate AND owner = @owner', {['@plate'] = plate, ['@owner'] = x.identifier}, function(vehicle)
		if next(vehicle) then
			cb(true)
		else
			cb(false)
		end
	end)
end)

RegisterNetEvent('est_garage:changeState')
AddEventHandler('est_garage:changeState', function(plate, state)
	MySQL.Sync.execute("UPDATE owned_vehicles SET state=@state = '0' WHERE plate=@plate", {['@state'] = state, ['@plate'] = plate})
end)

RegisterNetEvent('est_garage:changeState2')
AddEventHandler('est_garage:changeState2', function(plate, state)
	MySQL.Sync.execute("UPDATE owned_vehicles SET state=@state = '1' WHERE plate=@plate", {['@state'] = state, ['@plate'] = plate})
end)

RegisterNetEvent('est_garage:saveProps')
AddEventHandler('est_garage:saveProps', function(plate, props)
	local xProps = json.encode(props)
	MySQL.Sync.execute("UPDATE owned_vehicles SET vehicle=@props WHERE plate=@plate", {['@plate'] = plate, ['@props'] = xProps})
end)

--Dienstfahrzeuge Clear nach Restart
AddEventHandler('onMySQLReady', function()
	--MySQL.Sync.execute("UPDATE owned_vehicles SET state = '0' WHERE state ='1'", {})
	MySQL.Sync.execute("DELETE FROM owned_vehicles WHERE job ='police'", {})
	MySQL.Sync.execute("DELETE FROM owned_vehicles WHERE job ='ambulance'", {})
	MySQL.Sync.execute("DELETE FROM owned_vehicles WHERE job ='fib'", {})
end)
--[[
--Autos Einparken nach Restart
AddEventHandler('onMySQLReady', function()

	if Config.AutosEinparken then
		MySQL.Sync.execute("UPDATE owned_vehicles SET state = '0' WHERE state ='1'", {})
	end
end)
]]