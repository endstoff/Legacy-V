local guiEnabled = false
local myIdentity = {}
local myIdentifiers = {}
local hasIdentity = false
local isDead = false

ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

AddEventHandler('esx:onPlayerDeath', function(data)
	isDead = true
end)

AddEventHandler('playerSpawned', function(spawn)
	isDead = false
end)

function EnableGui(state)
	SetNuiFocus(state, state)
	guiEnabled = state

	SendNUIMessage({
		type = "enableui",
		enable = state
	})
end
--[[
RegisterNetEvent('esx_identity:showRegisterIdentity')
AddEventHandler('esx_identity:showRegisterIdentity', function()
	if not isDead then
		EnableGui(true)
	end
end)
]]
RegisterNetEvent('esx_identity:identityCheck')
AddEventHandler('esx_identity:identityCheck', function(identityCheck)
	hasIdentity = identityCheck
end)

RegisterNetEvent('esx_identity:saveID')
AddEventHandler('esx_identity:saveID', function(data)
	myIdentifiers = data
end)

RegisterNUICallback('escape', function(data, cb)
	if hasIdentity then
		EnableGui(false)
	else
		TriggerEvent('chat:addMessage', { args = { '^1[IDENTITY]', '^1You must create your first character in order to play' } })
	end
end)

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------
local isinintroduction = false
local introstep = 0
local timer = 0
local inputgroups = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31}
local infos = {
    "Willkommen auf Unity-V",
    "Beginne dein Leben hier.",
    "put something here.",
    "Gehöre zu den Guten",
    "und Helf der Stadt",
    "Gehe zum ~y~Jobcenter~w~ und Bewirb dich für einen Job! mit etwas Glück wirst du angenommen.",
    "Das war eine Kurze Vorstellung, es Gibt noch viel mehr zu endtecken! also Los worauf wartest du."
}


---------------------------------------------------------------------------------------------------------------------------------------------------------------------------

RegisterNUICallback('register', function(data, cb)
	local reason = ""
	myIdentity = data
	for theData, value in pairs(myIdentity) do
		if theData == "firstname" or theData == "lastname" then
			reason = verifyName(value)
			
			if reason ~= "" then
				break
			end
		elseif theData == "dateofbirth" then
			if value == "invalid" then
				reason = "Invalid date of birth!"
				break
			end
		elseif theData == "height" then
			local height = tonumber(value)
			if height then
				if height > 200 or height < 140 then
					reason = "Unacceptable player height!"
					break
				end
			else
				reason = "Unacceptable player height!"
				break
			end
		end
	end
	
	if reason == "" then
		TriggerServerEvent('esx_identity:setIdentity', data, myIdentifiers)
		EnableGui(false)
	
        local introcam
        TriggerEvent('chat:clear')  --- Clear current chat
        TriggerEvent('chat:toggleChat') --- Toggle chat chat
        SetEntityVisible(playerPed, false, 0) --- Make Player Invisible
        SetEntityCoordsNoOffset(playerPed, -103.8, -921.06, 287.29, false, false, false, true) --- Teleport Infront of Maze Bank IN Air
        FreezeEntityPosition(playerPed, true) --- Freeze The Player There
        SetFocusEntity(playerPed) ---- Focus on the player (To Render the building)
        PrepareMusicEvent("FM_INTRO_START")
        Wait(1)
        SetOverrideWeather("EXTRASUNNY")
        NetworkOverrideClockTime(19, 0, 0)
        BeginSrl()
        introstep = 1
        isinintroduction = true
        Wait(1)
        DoScreenFadeIn(500)
        while true do
            Wait(0)
            if introstep == 1 then
                TriggerMusicEvent("FM_INTRO_START")
                introcam = CreateCam("DEFAULT_SCRIPTED_CAMERA", false)
                SetCamActive(introcam, true)
                SetFocusArea(754.2219, 1226.831, 356.5081, 0.0, 0.0, 0.0)
                SetCamParams(introcam, 754.2219, 1226.831, 356.5081, -14.367, 0.0, 157.3524, 42.2442, 0, 1, 1, 2) ---vinewood schild
                SetCamParams(introcam, 740.7797, 1193.923, 351.1997, -9.6114, 0.0, 157.8659, 44.8314, 7200, 0, 0, 2)
                ShakeCam(introcam, "HAND_SHAKE", 0.15)
                RenderScriptCams(true, false, 3000, 1, 1)
                timer = GetNetworkTime() + 6700
                introstep = 1.5
            elseif introstep == 1.5 then
                Wait(800)
                while GetNetworkTime() < timer do
                    Wait(0)
                    TriggerEvent("amaazing:helptext", infos[1])
                end
                introstep = 2
            elseif introstep == 2 then
                DoScreenFadeOut(800)
                Wait(800)
                SetFocusArea(-259.36859130859375, -553.8571166992188, 142.60479736328125, 0.0, 0.0, 0.0)  ---mazebank
                NetworkOverrideClockTime(19, 0, 0)
                Wait(320)
                DoScreenFadeIn(800)
                SetCamParams(introcam, -259.36859130859375, -553.8571166992188, 142.60479736328125, 13.275199890136719, 0.5186, -143.33779907226562, 44.9958992, 0, 1, 1, 2)
                SetCamParams(introcam, -259.36859130859375, -553.8571166992188, 142.60479736328125, 13.275199890136719, 0.5186, -143.33779907226562, 44.9958992, 6000, 0, 0, 2)
                timer = GetNetworkTime() + 8000
                introstep = 2.5
            elseif introstep == 2.5 then
                Wait(800)
                while GetNetworkTime() < timer do
                    Wait(0)
                    TriggerEvent("amaazing:helptext", infos[2])
                end
                introstep = 8
                --[[
            elseif introstep == 3 then
                Wait(800)
                while GetNetworkTime() < timer do
                    Wait(0)
                    TriggerEvent("amaazing:helptext", infos[3])
                end
                introstep = 3.5
            elseif introstep == 3.5 then
                DoScreenFadeOut(800)
                Wait(800)
                SetFocusArea(400.56, -954.76, 38.74, 0.0, 0.0, 0.0)--- pd 1
                NetworkOverrideClockTime(19, 0, 0)
                Wait(320)
                DoScreenFadeIn(800)
                SetCamParams(introcam, 400.56, -954.76, 38.74, 230.0682, 0.0572, 0.7306, 40.033, 0, 1, 1, 2)
                SetCamParams(introcam, 400.56, -954.76, 36.74, 240.3097, 0.0572, 0.7306, 40.033, 6000, 0, 0, 2)
                timer = GetNetworkTime() + 8000
                introstep = 4
            elseif introstep == 4 then
                Wait(800)
                while GetNetworkTime() < timer do
                    Wait(0)
                    TriggerEvent("amaazing:helptext", infos[4])
                end
                introstep = 4.5
            elseif introstep == 4.5 then
                DoScreenFadeOut(800)
                Wait(800)
                SetFocusArea(400.56, -954.76, -38.74, 0.0, 0.0, 0.0)--- pd 2
                NetworkOverrideClockTime(19, 0, 0)
                Wait(320)
                DoScreenFadeIn(800)
                SetCamParams(introcam, 405.2, -1031.48, 38.77, 330.5453, 0.0572, -57.3736, 31.9442, 0, 1, 1, 2)
                SetCamParams(introcam, 421.77, -1033.09, 38.77, 325.5453, 0.0572, -56.24369812011719, 31.9442, 3500, 0, 0, 2)
                timer = GetNetworkTime() + 8000
                introstep = 5
            elseif introstep == 5 then
                Wait(800)
                while GetNetworkTime() < timer do
                    Wait(0)
                    TriggerEvent("amaazing:helptext", infos[5])
                end
                introstep = 5.5
            elseif introstep == 5.5 then
                DoScreenFadeOut(800)
                Wait(800)
                SetFocusArea(-1306.851, -391.109, 38.2952, 0.0, 0.0, 0.0)---waffenladen
                NetworkOverrideClockTime(19, 0, 0)
                Wait(320)
                DoScreenFadeIn(800)
                SetCamParams(introcam, -97.01, -1733.86, 38.33, 0.7142, 0.3156, -105.7306, 40.033, 0, 1, 1, 2)
                SetCamParams(introcam, -105.67, -1759.74, 38.33, 0.9614, 0.5214, -120.7306, 40.033, 8800, 0, 0, 2)
                timer = GetNetworkTime() + 8000
                introstep = 6
            elseif introstep == 6 then
                Wait(800)
                while GetNetworkTime() < timer do
                    Wait(0)
                    TriggerEvent("amaazing:helptext", infos[6])
                end
                introstep = 6.5
            elseif introstep == 6.5 then
                DoScreenFadeOut(800)
                Wait(800)
                SetFocusArea(-1066.286, -243.3144, 46.19627, 0.0, 0.0, 0.0)---jobcenter
                NetworkOverrideClockTime(19, 0, 0)
                Wait(320)
                DoScreenFadeIn(800)
                SetCamParams(introcam, -1066.286, -243.3144, 46.19627, -5.7142, 0.3156, -170.7306, 60.033, 0, 1, 1, 2)
                SetCamParams(introcam, -1057.979, -239.101, 44.79618, -5.9614, 0.5214, -120.7306, 60.033, 8800, 0, 0, 2)
                timer = GetNetworkTime() + 8000
                introstep = 8
                --[[
            elseif introstep == 7 then
                Wait(800)
                while GetNetworkTime() < timer do
                    Wait(0)
                    TriggerEvent("amaazing:helptext", infos[7])
                end
                introstep = 7.5
            elseif introstep == 7.5 then
                DoScreenFadeOut(800)
                Wait(800)
                SetFocusArea(-4.6668, -900.9736, 184.887, 0.0, 0.0, 0.0)------- maze bank andere richtung
                NetworkOverrideClockTime(19, 0, 0)
                Wait(320)
                DoScreenFadeIn(800)
                SetCamParams(introcam, -4.6668, -900.9736, 184.887, -1.6106, -0.5186, 78.3786, 45.0069, 0, 1, 1, 2)
                SetCamParams(introcam, -23.0087, -896.4288, 184.1939, -2.8529, -0.5186, 81.8262, 45.0069, 8800, 0, 0, 2)
                timer = GetNetworkTime() + 8000
                introstep = 8
                --]]
            elseif introstep == 8 then
                Wait(800)
                while GetNetworkTime() < timer do
                    Wait(0)
                    TriggerEvent("amaazing:helptext", infos[8])
                end
                introstep = 8.5
            elseif introstep == 8.5 then
               SetEntityCoordsNoOffset(playerPed, -195.14, -830.31, 31.08, false, false, false, true) --- Teleport Player Back to start
               FreezeEntityPosition(playerPed, true) --- Freeze The Player There
               SetEntityVisible(playerPed, true, 0) --- set visable
               FreezeEntityPosition(playerPed, false) -- unfreeze
               DestroyCam(createdCamera, 0)
               DestroyCam(createdCamera, 0)
               RenderScriptCams(0, 0, 1, 1, 1)
               createdCamera = 0
               ClearTimecycleModifier("scanline_cam_cheap")
               SetFocusEntity(GetPlayerPed(PlayerId()))    
			   
               Citizen.Wait(1000)
            -- TriggerEvent('esx_skin:openSaveableMenu', myIdentifiers.id)	 
               return			   		   
		end
		
	 end		
	else
		ESX.ShowNotification(reason)
	end
end)

RegisterNetEvent("amaazing:helptext")
AddEventHandler("amaazing:helptext", function(text)
		AddNextMessageToPreviousBriefs(0)
		BeginTextCommandDisplayHelp("STRING")
		AddTextComponentSubstringPlayerName(text)
		EndTextCommandDisplayHelp(0, 0, true, -1)
end)


Citizen.CreateThread(function()
	while true do
		if guiEnabled then
			DisableControlAction(0, 1,   true) -- LookLeftRight
			DisableControlAction(0, 2,   true) -- LookUpDown
			DisableControlAction(0, 106, true) -- VehicleMouseControlOverride
			DisableControlAction(0, 142, true) -- MeleeAttackAlternate
			DisableControlAction(0, 30,  true) -- MoveLeftRight
			DisableControlAction(0, 31,  true) -- MoveUpDown
			DisableControlAction(0, 21,  true) -- disable sprint
			DisableControlAction(0, 24,  true) -- disable attack
			DisableControlAction(0, 25,  true) -- disable aim
			DisableControlAction(0, 47,  true) -- disable weapon
			DisableControlAction(0, 58,  true) -- disable weapon
			DisableControlAction(0, 263, true) -- disable melee
			DisableControlAction(0, 264, true) -- disable melee
			DisableControlAction(0, 257, true) -- disable melee
			DisableControlAction(0, 140, true) -- disable melee
			DisableControlAction(0, 141, true) -- disable melee
			DisableControlAction(0, 143, true) -- disable melee
			DisableControlAction(0, 75,  true) -- disable exit vehicle
			DisableControlAction(27, 75, true) -- disable exit vehicle
		end
		Citizen.Wait(10)
	end
end)

function verifyName(name)
	-- Don't allow short user names
	local nameLength = string.len(name)
	if nameLength > 25 or nameLength < 2 then
		return 'Your player name is either too short or too long.'
	end
	
	-- Don't allow special characters (doesn't always work)
	local count = 0
	for i in name:gmatch('[abcdefghijklmnopqrstuvwxyzåäöABCDEFGHIJKLMNOPQRSTUVWXYZÅÄÖ0123456789 -]') do
		count = count + 1
	end
	if count ~= nameLength then
		return 'Your player name contains special characters that are not allowed on this server.'
	end
	
	-- Does the player carry a first and last name?
	-- 
	-- Example:
	-- Allowed:     'Bob Joe'
	-- Not allowed: 'Bob'
	-- Not allowed: 'Bob joe'
	local spacesInName    = 0
	local spacesWithUpper = 0
	for word in string.gmatch(name, '%S+') do

		if string.match(word, '%u') then
			spacesWithUpper = spacesWithUpper + 1
		end

		spacesInName = spacesInName + 1
	end

	if spacesInName > 2 then
		return 'Your name contains more than two spaces'
	end
	
	if spacesWithUpper ~= spacesInName then
		return 'your name must start with a capital letter.'
	end

	return ''
end
