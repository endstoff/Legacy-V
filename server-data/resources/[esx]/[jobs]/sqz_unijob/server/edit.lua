ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
--[[
TriggerEvent('esx_phone:registerNumber', 'sandy_mechanic', _U('alert_mechanic'), true, true)
TriggerEvent('esx_phone:registerNumber', 'fib', _U('alert_fib'), true, true)
]]
TriggerEvent('esx_society:registerSociety', 'yakuza', 'Yakuza', 'society_yakuza', 'society_yakuza', 'society_yakuza', {type = 'public'})
TriggerEvent('esx_society:registerSociety', 'midnight', 'Midnight Club', 'society_midnight', 'society_midnight', 'society_midnight', {type = 'public'})
TriggerEvent('esx_society:registerSociety', 'blackwater', 'BLK', 'society_blackwater', 'society_blackwater', 'society_blackwater', {type = 'public'})
TriggerEvent('esx_society:registerSociety', 'bmeister', 'Bürgermeister', 'society_bmeister', 'society_bmeister', 'society_bmeister', {type = 'public'})

RegisterNetEvent('sqz_unijob:Server:CanPlayerCarryItem')
AddEventHandler('sqz_unijob:Server:CanPlayerCarryItem', function(callback, playerId, itemName, count)

    -- Here you can add check if the player can carry item -> If you use for example item.limit system
    local xPlayer = ESX.GetPlayerFromId(playerId)

    if xPlayer.canCarryItem(itemName, count) then
        callback(true)
    else
        TriggerEvent('sqz_unijob:Server:ShowNotification', playerId, _U('can_not_carry'))
        callback(false)
    end

end)

RegisterNetEvent('sqz_unijob:Server:ShowNotification')
AddEventHandler('sqz_unijob:Server:ShowNotification', function(playerId, message)

    local xPlayer = ESX.GetPlayerFromId(playerId)
    xPlayer.showNotification(message)

end)