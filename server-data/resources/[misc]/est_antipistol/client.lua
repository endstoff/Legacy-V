-- EZAnti PistolWhip-Script by opìe

Citizen.CreateThread(function() 
    while true do
        Citizen.Wait(0)
		local ped = PlayerPedId()
        if IsPedArmed(ped, 6) then
	    	DisableControlAction(1, 140, true) -- Disabled "INPUT_MELEE_ATTACK_LIGHT" R
            --DisableControlAction(1, 141, true) -- Disabled "INPUT_MELEE_ATTACK_HEAVY" Q
            DisableControlAction(1, 142, true) -- Disabled "INPUT_MELEE_ATTACK_ALTERNATE" Linksklick
        end
    end
end)