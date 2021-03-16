ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterUsableItem('weed_pooch', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
    xPlayer.removeInventoryItem('weed_pooch', 1)
	TriggerClientEvent('panic_drugeffects:useWeed', source)

end)

ESX.RegisterUsableItem('meth_pooch', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
    xPlayer.removeInventoryItem('meth_pooch', 1)
	TriggerClientEvent('panic_drugeffects:useMeth', source)
    
end)

ESX.RegisterUsableItem('coke_pooch', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
    xPlayer.removeInventoryItem('coke_pooch', 1)
	TriggerClientEvent('panic_drugeffects:useCoke', source)

end)

ESX.RegisterUsableItem('lsd', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
    xPlayer.removeInventoryItem('lsd', 1)
	TriggerClientEvent('panic_drugeffects:useLSD', source)

end)