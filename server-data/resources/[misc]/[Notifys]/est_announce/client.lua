ESX = nil
local blip = nil
local radiusBlip = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)


--announcements types

RegisterNetEvent('notifications2_server:on')
AddEventHandler('notifications2_server:on', function(title)
    SendNUIMessage({
        type = "server",
        title = title
    })
	
	PlaySoundFrontend(-1, "Exit_Capture_Zone", "DLC_Apartments_Drop_Zone_Sounds", 1)
end)

RegisterNetEvent('notifications2_server2:on')
AddEventHandler('notifications2_server2:on', function(title)
    SendNUIMessage({
        type = "server2",
        title = title
    })
	
	PlaySoundFrontend(-1, "Exit_Capture_Zone", "DLC_Apartments_Drop_Zone_Sounds", 1)
end)

RegisterNetEvent('notifications2_fib')
AddEventHandler('notifications2_fib', function(title)
    SendNUIMessage({
        type = "fib",
        title = title
    })
	
	PlaySoundFrontend(-1, "Exit_Capture_Zone", "DLC_Apartments_Drop_Zone_Sounds", 1)
end)

RegisterNetEvent('notifications2_anc')
AddEventHandler('notifications2_anc', function(title)
    SendNUIMessage({
        type = "anc",
        title = title
    })
	
	PlaySoundFrontend(-1, "Exit_Capture_Zone", "DLC_Apartments_Drop_Zone_Sounds", 1)
end)

--Sperrzone


blipRadius = 170.0 -- default radius, if none is specified.
blipCol = 1 -- Default: 2 (Green) Use colors from https://wiki.gt-mp.net/index.php?title=Blips (At Bottom)
blipName = "Sperrzone"

function missionTextDisplay(text, time)
    ClearPrints()
    SetTextEntry_2("STRING")
    AddTextComponentString(text)
    DrawSubtitleTimed(time, 1)
end

RegisterNetEvent('Fax:AdminAreaSet2')
AddEventHandler("Fax:AdminAreaSet2", function(s, adaRadius)
    RemoveBlip(blip)
    RemoveBlip(radiusBlip)

    if adaRadius == nil then
        adaRadius = blipRadius
    end

    local src = s
    local coords = GetEntityCoords(GetPlayerPed(GetPlayerFromServerId(src)))
    blip = AddBlipForCoord(coords.x, coords.y, coords.z)
    radiusBlip = AddBlipForRadius(coords.x, coords.y, coords.z, adaRadius)
    SetBlipSprite(blip, 378)
    SetBlipAsShortRange(blip, true)
    SetBlipColour(blip, blipCol)
    SetBlipScale(blip, 1.0)
    BeginTextCommandSetBlipName('STRING')
    AddTextComponentString(blipName)
    EndTextCommandSetBlipName(blip)
    
    SetBlipAlpha(radiusBlip, 80)
    SetBlipColour(radiusBlip, blipCol)
end)

RegisterNetEvent('Fax:AdminAreaClear2')
AddEventHandler("Fax:AdminAreaClear2", function()
    RemoveBlip(blip)
    RemoveBlip(radiusBlip)
end)
