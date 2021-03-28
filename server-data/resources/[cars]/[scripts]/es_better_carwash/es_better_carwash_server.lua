ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('es_better_carwash:checkmoney')
AddEventHandler('es_better_carwash:checkmoney', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local price = 25

	if xPlayer.getMoney() >= price then
		xPlayer.removeMoney(price)
		TriggerClientEvent('es_better_carwash:success', _source)
	else
		local missingMoney = price - xPlayer.getMoney()
		TriggerClientEvent('es_better_carwash:notenoughmoney', _source, missingMoney)
	end	
end)
