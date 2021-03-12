------ // N I P A M O \\ ------

local SperrzoneActive = false
local SperrBlip       = nil
local pdBlip          = nil
ESX                   = nil

Citizen.CreateThread(function ()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end
end)

RegisterNetEvent("est_sperrzone:ShowInfo")
AddEventHandler('est_sperrzone:ShowInfo', function(radius)
    ESX.ShowAdvancedNotification("LSPD", "~r~SPERRZONE~s~", "Eine Sperrzone wurde ausgerufen. ~y~UMKREIS: " .. radius .. "M~s~", "CHAR_CALL911", 1)
    Citizen.Wait(2500)
    ESX.ShowAdvancedNotification("LSPD", "~r~SPERRZONE~s~", "Wer sich dennoch nähert, muss mit einer ~r~Festnahme~s~ rechnen", "CHAR_CALL911", 1)
end)

RegisterNetEvent("est_sperrzone:RemoveBlip")
AddEventHandler("est_sperrzone:RemoveBlip", function()
    RemoveBlip(SperrBlip)
    RemoveBlip(pdBlip)
    SperrBlip = nil
    pdBlip    = nil
    ESX.ShowAdvancedNotification("LSPD", "~r~SPERRZONE~s~", "Die aktuelle Sperrzone wurde aufgehoben!", "CHAR_CALL911", 1)
end)

RegisterNetEvent("est_sperrzone:Blip")
AddEventHandler("est_sperrzone:Blip", function(targetCoords, radius)

    SperrBlip = AddBlipForRadius(targetCoords.x, targetCoords.y, targetCoords.z, 250.0)
    pdBlip    = AddBlipForCoord(targetCoords.x, targetCoords.y, targetCoords.z)
        
    SetBlipColour(SperrBlip, 38)
    SetBlipSprite(SperrBlip, 4)
    --
    SetBlipSprite(pdBlip, 60)
    SetBlipScale(pdBlip, 1.0)
    SetBlipDisplay(pdBlip, 4)
    SetBlipColour(pdBlip, 29)
    SetBlipAsShortRange(pdBlip, true)

    BeginTextCommandSetBlipName('STRING')
    AddTextComponentString('Sperrzone')
    EndTextCommandSetBlipName(pdBlip)

end)

RegisterNetEvent("est_sperrzone:OpenSperrMenu")
AddEventHandler("est_sperrzone:OpenSperrMenu", function()
    ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'police_actions', {
		title    = 'Police',
		align    = 'top-left',
		elements = {
            { label = "Sperrzone ausrufen", value = "sperr"     },
            { label = "Sperrzone beenden",  value = "sperrende" }
        }
    }, function(data, menu)

        local player    = PlayerPedId()
        local playerPos = GetEntityCoords(player)

        if data.current.value == 'sperr' then
            if SperrzoneActive == false then

                SperrzoneActive = true

                ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'billing', {
                    title = 'Umkreis'
                }, function(data, menu)

                    local radius = tonumber(data.value)

                    if radius == nil then
                        ESX.ShowNotification("~r~~h~Ungültige Eingabe")
                    else
                        TriggerServerEvent('est_sperrzone:SendInfo', playerPos, radius)
                    end

                end, function(data, menu)
                    menu.close()
                end)

            else
                ESX.ShowNotification("Du hast bereits eine Sperrzone ausgerufen! Beende diese zuerst")
            end
        elseif data.current.value == "sperrende" then
            if SperrzoneActive == true then
                SperrzoneActive = false
                TriggerServerEvent("est_sperrzone:RemoveBlip")
            else
                ESX.ShowNotification("Es gibt aktuell keine ausgerufene Sperrzone")
            end
        end
    end, function(data, menu)
		menu.close()
	end)
end)

------ \\ N I P A M O // ------