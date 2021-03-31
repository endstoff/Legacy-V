RegisterServerEvent('d-phone:server:fire')
AddEventHandler('d-phone:server:fire', function(source, id, unemployed2 )
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local zPlayer = ESX.GetPlayerFromId(id)
    local grade = 0
    if zPlayer then
            Wait(100)
            zPlayer.setJob("unemployed", 0)
            TriggerClientEvent("d-notification", _source, _U("successfired"), 5000, "orange")
            TriggerClientEvent("d-notification", zPlayer.source, _U("gotfired"), 5000, "orange")
    else
         TriggerClientEvent("d-notification", _source, _U("personoffline"), 5000, "red")
    end
end)

--[[ ESX 1.1
TriggerEvent('es:addGroupCommand', 'sca', 'user', function(p, args, user)
    TriggerClientEvent("d-phone:client:acceptsharecontact", p)
end)

TriggerEvent('es:addGroupCommand', 'scd', 'user', function(p, args, user)
    TriggerClientEvent("d-phone:client:declinesharecontact", p)
end)
]]
-- ESX 1.2

ESX.RegisterCommand('sca', 'user', function(xPlayer, args, showError)
    TriggerClientEvent("d-phone:client:acceptsharecontact", xPlayer.source)
  end)
  
  ESX.RegisterCommand('scd', 'user', function(xPlayer, args, showError)
    TriggerClientEvent("d-phone:client:declinesharecontact", xPlayer.source)
  end)
