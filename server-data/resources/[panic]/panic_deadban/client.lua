ESX = nil 
local isDead = false
local lean1 = false

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)


Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        local ped = GetPlayerPed(-1)
        local health = GetEntityHealth(ped)
        if health < 1 then
            if (lean1 == false) then
            lean1 = true 
            print("Debug")
            end 
        end
    end
end)


function BanUser()

end