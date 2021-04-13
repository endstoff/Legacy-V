RegisterNetEvent('visn_are:catchEvent')
AddEventHandler('visn_are:catchEvent', function(eventType, eventValue)
    if eventType == 'onKeyPressed' then -- [DISTRESS_SIGNAL, CARRY_STOPPED]
        if eventValue == 'DISTRESS_SIGNAL' then
            local currentPosition = GetEntityCoords(PlayerPedId())

            -- for GCPhone
            TriggerServerEvent('esx_addons_gcphone:startCall', "ambulance", _translate("phone_call_text"), {
                x = currentPosition.x,
                y = currentPosition.y,
                z = currentPosition.z
            })
        end

        -- Same goes for CARRY_STOPPED.
    end

    if eventType == 'onAction' then -- [checkPulse, checkPerson, checkBloodPressure, bandage, emergencyReviveKit, surgicalKit, removeTourniquet, torniquet, bodybag, cpr, defibrillator, liquid, infusion]
        if eventValue == 'checkPulse' then
            -- print("Pulse has been checked! yay!")
        end

        -- Same goes for the other ones.
    end

    if eventType == 'onMenuOpened' then -- [true, false]
        if eventValue == true then
            -- print("Wow! I opened the menu for myself!")
        end

        -- Same goes for the other one.
    end

    if eventType == 'onPlayerDeath' then -- [table with coords]
        -- print(json.encode(eventValue))
    end

    if eventType == 'onFinalDeath' then
        -- print ("Oh no! I lost my life!")
    end
    
    if eventType == 'onPlayerDamage' then -- [bone string]
        -- print("Ouch! My " .. eventValue .. " hurts now.. :(")
    end

end)