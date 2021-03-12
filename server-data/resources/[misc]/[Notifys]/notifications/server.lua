RegisterCommand("id", function(source, args)
    TriggerClientEvent('notifications', source, "#00cc00", "ANKÜNDIGUNG", "Deine ID ist die: " .. source)
end, false)
