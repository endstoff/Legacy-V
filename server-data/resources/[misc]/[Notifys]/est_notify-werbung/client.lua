

RegisterNetEvent('est_notify-werbung')
AddEventHandler('est_notify-werbung', function(color, title, message)
    if message == "+ 1 Kill" then
	else
        SendNUIMessage({
            type = "custom",
            color = color,
		    title = title,
            message = message,
        })
        PlaySoundFrontend(-1, "ATM_WINDOW", "HUD_FRONTEND_DEFAULT_SOUNDSET", 1)
    end
end)