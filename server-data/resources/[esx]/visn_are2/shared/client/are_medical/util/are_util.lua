
RegisterNetEvent('visn_are:changePower')
AddEventHandler('visn_are:changePower', function(changePower)
    if changePower == 1 then
        painFactor = painFactor + 1

        if painFactor > 2 then
            painFactor = 2
        end

        if painFactor < -2 then
            painFactor = 0
        end
    elseif changePower == 2 then
        painFactor = painFactor + 2

        if painFactor > 2 then
            painFactor = 2
        end

        if painFactor < -2 then
            painFactor = 0
        end
    elseif changePower == 0 then
        painFactor = 0

        if painFactor > 2 then
            painFactor = 2
        end

        if painFactor < -2 then
            painFactor = 0
        end
    elseif changePower == -1 then
        painFactor = painFactor - 1

        if painFactor > 2 then
            painFactor = 2
        end

        if painFactor < -2 then
            painFactor = 0
        end
    elseif changePower == -2 then
        painFactor = painFactor - 2

        if painFactor > 2 then
            painFactor = 2
        end

        if painFactor < -2 then
            painFactor = 0
        end
    end 

    if painFactor == 1 then
    end
end)

function startScenario(anim)
	TaskStartScenarioInPlace(PlayerPedId(), anim, 0, false)
end