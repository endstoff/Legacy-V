--[[


    Do NOT CHANGE any of the code in this file,
    
    if you do so, do it on your own risk and no support will be given


]]

ESX = nil

CreateThread(function()
    while (ESX == nil) do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Wait(100)
    end
end)

RegisterServerEvent('lls-mechanic_midnight:removeCash')
AddEventHandler('lls-mechanic_midnight:removeCash', function(amount)
    local src = source

    removePlayerCashMoney(src, amount)
end)
