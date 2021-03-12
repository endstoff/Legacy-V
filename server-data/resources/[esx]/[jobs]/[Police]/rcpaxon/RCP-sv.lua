ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterUsableItem('bodycam', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)

	TriggerClientEvent('rcpaxon:use', source)

end)
