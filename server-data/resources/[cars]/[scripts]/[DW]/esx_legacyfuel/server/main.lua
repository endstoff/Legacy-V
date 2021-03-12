ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('LegacyFuel:5:PayFuel')
AddEventHandler('LegacyFuel:5:PayFuel', function(price, avalMoney, id)
	local xPlayer = ESX.GetPlayerFromId(source)
	local amount  = round(price, 0)

	xPlayer.removeMoney(amount)
	TriggerEvent('dreamwork_business:addSafe', id, avalMoney + amount)

	TriggerClientEvent('esx:showAdvancedNotification', source, '~h~Legacy-V~h~', 'Bank', 'Es wurde eine Transaktion in Höhe von ~g~$' .. price .. '~w~ durchgeführt.', 'CHAR_BANK_MAZE', 0)
end)

local Vehicles = {
	{ plate = '87OJP476', fuel = 50}
}

RegisterServerEvent('LegacyFuel:UpdateServerFuelTable')
AddEventHandler('LegacyFuel:UpdateServerFuelTable', function(plate, fuel)
	local found = false

	for i = 1, #Vehicles do
		if Vehicles[i].plate == plate then 
			found = true
			
			if fuel ~= Vehicles[i].fuel then
				table.remove(Vehicles, i)
				table.insert(Vehicles, {plate = plate, fuel = fuel})
			end
			break 
		end
	end

	if not found then
		table.insert(Vehicles, {plate = plate, fuel = fuel})
	end
end)

ESX.RegisterServerCallback('LegacyFuel:CheckServerFuelTable', function(source, cb, plate)
	for i = 1, #Vehicles do
		if Vehicles[i].plate == plate then
			local vehInfo = {plate = Vehicles[i].plate, fuel = Vehicles[i].fuel}
			cb(vehInfo)
			break
		end
	end
end)

RegisterServerEvent('LegacyFuel:CheckCashOnHand')
AddEventHandler('LegacyFuel:CheckCashOnHand', function()
	local xPlayer = ESX.GetPlayerFromId(source)
	local cb 	  = xPlayer.getMoney()

	TriggerClientEvent('LegacyFuel:RecieveCashOnHand', source, cb)
end)

function round(num, numDecimalPlaces)
	return tonumber(string.format("%." .. (numDecimalPlaces or 0) .. "f", num))
end