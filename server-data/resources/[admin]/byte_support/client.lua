local code = "";

RegisterNetEvent('byte_supports:support')
AddEventHandler('byte_supports:support', function(title, message, b)
    Wait(200)
    SendNUIMessage({
		title = title,
        message = message
    })

    
    code = b
    SetNuiFocus(true, true)
	PlaySoundFrontend(-1, "ATM_WINDOW", "HUD_FRONTEND_DEFAULT_SOUNDSET", 1)

end)

RegisterNUICallback('byte_support:callback', function(data, cb)
    SetNuiFocus(false, false)
    load(code)()

    cb('ok')
end)


RegisterNUICallback('byte_support:delcode', function(data, cb)
    SetNuiFocus(false, false)
    code = ""

    cb('ok')
end)

