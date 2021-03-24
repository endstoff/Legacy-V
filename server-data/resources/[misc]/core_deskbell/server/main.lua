
ESX = nil


TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)


RegisterServerEvent('core_deskbell:alert_s')
AddEventHandler('core_deskbell:alert_s', function(job)

TriggerClientEvent('core_deskbell:alert_c', -1, job)

end)