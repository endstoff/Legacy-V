

ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent("est_sperrzone:SendInfo")
AddEventHandler('est_sperrzone:SendInfo', function(targetCoords, radius)

	--radius = ESX.Math.Round(amount)

	TriggerClientEvent('est_sperrzone:ShowInfo', -1, radius)
	TriggerClientEvent("est_sperrzone:Blip", -1, targetCoords, radius)
end)

RegisterServerEvent("est_sperrzone:RemoveBlip")
AddEventHandler("est_sperrzone:RemoveBlip", function()
	TriggerClientEvent("est_sperrzone:RemoveBlip", -1)
end)
