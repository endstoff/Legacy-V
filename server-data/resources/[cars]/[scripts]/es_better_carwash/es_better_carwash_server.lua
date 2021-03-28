ESX             = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('es_better_carwash:checkmoney')
AddEventHandler('es_better_carwash:checkmoney', function()
	local xPlayer = ESX.GetPlayerFromId(source)
		if xPlayer.getMoney() >= 25 then
			xPlayer.removeMoney(25)
			TriggerClientEvent('es_better_carwash:success', source)
		else
			local missingMoney = 25 - xPlayer.getMoney()
			TriggerClientEvent('es_better_carwash:notenoughmoney', source, missingMoney)
		end
	end)
end)
