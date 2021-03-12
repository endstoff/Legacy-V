ESX = nil 
local IsIn = false 
local visible = false 

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

RegisterNUICallback('main', function(data)
	SetVisible(false)
end)
RegisterNUICallback('error', function(data)
	print(data.error)
	SetVisible(false)
end)
RegisterNUICallback('exit', function(data)
	print('NUI Geschlossen')
	SetVisible(false)
end)
RegisterNUICallback('vote-yes', function(data)
	print('Du hast für Ja gestimmt')
	SetVisible(false)
	Citizen.Wait(1000)
	SetVisible(true)
end)
RegisterNUICallback('vote-no', function(data)
	print('Du hast für Nein gestimmt')
	SetVisible(false)
	Citizen.Wait(1000)
	SetVisible(true)
end)
RegisterNUICallback('vote-count', function(saved)
	ESX.TriggerServerCallback('panic_abstimmung:getCounters', function(data)
		local yes_votes = data.yes_votes 
		local no_votes = data.no_votes
		SendNUIMessage({
			type = "updateCounters",  
			yes_vote = yes_votes,
			no_votes = no_votes
		})
	end)
end)
Citizen.CreateThread(function()
	while true do 
		Citizen.Wait(0)
			local entity = PlayerPedId()
			local playerpos = GetEntityCoords(entity, true)
			local zone = Vdist(playerpos.x, playerpos.y, playerpos.z, -545.16, -203.89, 38.22)
		
		if zone < 1.0 then 
			if IsIn == true then
			else 
				IsIn = true
			end 
		end 
		if (IsIn == true) then 
			if zone > 1.0 then 
				IsIn = false
			end
		end
	end
end)

Citizen.CreateThread(function()
	while true do 
		Citizen.Wait(0)
			local entity = PlayerPedId()
			
		if (IsIn == true) then 
			if IsControlJustReleased(1, 38) then 
				visible = true
			end
		end
	end
end)

Citizen.CreateThread(function()
	while visible do 
		Citizen.Wait(0)

		DisableControlAction(0, 1, true) -- LookLeftRight
        DisableControlAction(0, 2, true) -- LookUpDown
        DisableControlAction(0, 142, true) -- AttackAlternate
        DisableControlAction(0, 18, true)  -- Enter
        DisableControlAction(0, 322, true) -- ESC 
        DisableControlAction(0, 106, true) -- VehicleMouseControlOverride
	end
end)

function visible(bool)
	visible = bool 
	SetNuiFocus(bool, bool)
	SendNUIMessage({
		type="ui",
		status = bool
	})
end