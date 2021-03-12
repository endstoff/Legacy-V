RegisterNetEvent('rw_notification:showNotification')
AddEventHandler('rw_notification:showNotification', function(text)
	if text == "+ 1 Kill" then
	else
		SendNUIMessage({
			action = 'add',
			text = text
		})

		PlaySoundFrontend(-1, "ATM_WINDOW", "HUD_FRONTEND_DEFAULT_SOUNDSET", 1)
	end
end)

