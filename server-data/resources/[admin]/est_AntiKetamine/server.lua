AddEventHandler("playerConnecting", function (name, kick, defer)
    defer.defer()
    Citizen.Wait(50)

    if(name:find("<") ~= nil or name:find (">") ~= nil) then
        defer.done("Verbindung verwehrt")
        return
    end
    
    defer.done()
end)