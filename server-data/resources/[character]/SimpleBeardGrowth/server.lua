ESX = nil 

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)


ESX.RegisterUsableItem('shaver', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	local _source = source
	
	xPlayer.removeInventoryItem('shaver', 1)

	TriggerClientEvent('SimpleBeardGrowth:shave')
	TriggerClientEvent('pNotify:SendNotification', _source, {layout = 'topLeft', theme = 'gta', type = 'warning', text1 = 'Körperpflege', text2 = 'Du hast dich rasiert!'})
end)