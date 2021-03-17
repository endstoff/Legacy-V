RegisterCommand("id", function(source, args)
    TriggerClientEvent('notify', source, 1, "", 'Deine ID ist die: <span style="color:limegreen">' .. source, 5000)
end, false)