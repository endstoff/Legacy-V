ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
	
TriggerEvent('es:addGroupCommand', 'test', 'mod', function (source)
	TriggerClientEvent('rw_notification:showNotification', source, 'Dies ist eine Test Nachricht!')
end)

RegisterNetEvent('rw_notification:showNotification')
AddEventHandler('rw_notification:showNotification', function(text)
	TriggerClientEvent('rw_notification:showNotification', source, text)
end)