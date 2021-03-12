local visible = false 

RegisterCommand("nui", function(source)
    SetVisible(not visible)
end)

RegisterNUICallback('main', function(data)
    chat(data.text, {0,255,0})
    SetVisible(false)
end)

RegisterNUICallback('error', function(data)
    chat(data.error, {255,0,0})
    SetVisible(false)
end)

RegisterNUICallback('exit', function(data)
    chat('Exited', {0,255,0})
    SetVisible(false)
end)

Citizen.CreateThread(function()
    while visible do 
        Citizen.Wait(0)

        DisableControlAction(0, 1, visible) -- LookLeftRight
        DisableControlAction(0, 2, visible) -- LookUpDown
        DisableControlAction(0, 142, visible) -- AttackAlternate
        DisableControlAction(0, 18, visible)  -- Enter
        DisableControlAction(0, 322, visible) -- ESC 
        DisableControlAction(0, 106, visible) -- VehicleMouseControlOverride
    end
end)

function Visible(bool)
    visible = bool 
    SetNuiFocus(bool, bool)
    SendNUIMessage({
        type = "ui",
        status = bool
    })
end

function chat(str, color)
    TriggerEvent('chat:addMessage', {
        color = color,
        multiline = true,
        args = {str}
    })
end