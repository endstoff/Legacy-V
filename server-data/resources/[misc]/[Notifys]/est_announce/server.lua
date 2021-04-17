tESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)
--[[
RegisterCommand("announce", function(source, args)
    local argString = table.concat(args, " ")
    if argString ~= nil then
		TriggerClientEvent('notifications2_server:on', -1, argString)
    end
end, true)
]]

TriggerEvent('es:addGroupCommand', 'announce', 'admin', function(source, args)
    local argString = table.concat(args, " ")
    if argString ~= nil then
        TriggerClientEvent('notifications2_server2:on', -1, argString)
    end
end, true)