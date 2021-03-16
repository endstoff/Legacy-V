RegisterNetEvent("notify")
AddEventHandler("notify", function(type, title, message, time)
    Wait(200)
    SendNUIMessage({
        type = type,
        title = title, 
        message = message,
        time = time
     })
     PlaySoundFrontend(-1, "ATM_WINDOW", "HUD_FRONTEND_DEFAULT_SOUNDSET", 1)
end)

RegisterCommand("notify", function()
    TriggerEvent("notify", 1, "Info Notification", "endstoff ist Cool! :D", 2500)
    TriggerEvent("notify", 2, "Success Notification", "Das ist eine Test Notification", 2500)
    TriggerEvent("notify", 3, "Warning Notification", "Das ist eine Test Notification", 2500)
    TriggerEvent("notify", 4, "Error Notification", "Das ist eine Test Notification", 2500)
end)