RegisterNetEvent("d-customnotification")
AddEventHandler("d-customnotification", function(text, length, color)
    local color = color
    local length = length
    if color ~= nil then 
        color = "black"
    end
    if length ~= nil then 
        length = 4000
    end

    -- THIS IS AN EXAMPLE IF YOU WANT TO USE THE NORMAL ESX NOTIFIICATION
    --ESX.ShowNotification(text)

    -- TriggerEvent('mythic_notify:client:SendAlert', { type = 'inform', text = text, length = length, style = { ['background-color'] = color, ['color'] = '#fff' } })
    TriggerEvent('notify', 1, '', text, 2500)
end)