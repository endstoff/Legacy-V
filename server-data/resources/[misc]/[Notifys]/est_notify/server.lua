RegisterCommand("id", function(source, args)
    TriggerClientEvent('est_notify', source, "#00cc00", "INFORMATION", "Deine ID ist die: " .. source)
end, false)
