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
--[[
RegisterServerEvent('lls-mechanic_hayes:removeCash')
AddEventHandler('lls-mechanic_hayes:removeCash', function(amount)
    local src = source

    removePlayerCashMoney(src, amount)
end)
]]

RegisterServerEvent('lls-mechanic_hayes:removeCash')
AddEventHandler('lls-mechanic_hayes:removeCash', function(amount)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	amount = tonumber(amount)

    local societyAccount

    TriggerEvent('esx_addonaccount:getSharedAccount', 'society_acls', function(account)
		societyAccount = account
	end)

    if amount < societyAccount.money then
        TriggerClientEvent('notify', _source, 1, "", "Gekauft", 2500)
		societyAccount.removeMoney(amount)
	else
		TriggerClientEvent('notify', _source, 3, "", "<span style='color:#ff0000'>Nicht genug geld auf dem Geschäftskonto</span>", 3500)
		xPlayer.removeMoney(amount)
		Citizen.Wait(500)
		TriggerClientEvent('notify', _source, 1, "", "Es wurden dir stattdessen <span style='color:lime'>$" .. amount .. "</span> abgezogen")
	end
end) 