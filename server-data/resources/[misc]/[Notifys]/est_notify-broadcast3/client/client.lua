local _break = "<br>"
local linestrike = "<hr>"

function color(color, text) return "<font color="..color..">"..text.."</font>" end
function underlined(text) return "<u>"..text.."</u>" end
function bold(text) return "<strong>"..text.."</strong>" end
function small(text) return "<small>"..text.."</small>" end
function strikethrough(text) return "<del>"..text.."</del>" end
function italic(text) return "<i>"..text.."</i>" end
function big(text) return "<big>"..text.."</big>" end

RegisterNetEvent("est_notify-broadcast:display")
AddEventHandler("est_notify-broadcast:display", function(title, msg, time)
	PlaySoundFrontend(-1, "CHALLENGE_UNLOCKED", "HUD_AWARDS", 1)
	ShowNotify(title, msg, time)
end)


function ShowNotify(title, msg, time)
	if msg ~= nil and msg ~= "" then
		if time == nil then
			time = Config.DefaultFadeOut
		end
	
		if title == nil then
			title = "Notification"
		end

		TriggerEvent('message:show', title, msg)
		Wait(time)
		TriggerEvent('message:hide')
	else
		print("FEHLER: Es wurde ein Announcement ohne Inhalt getriggered!")
	end
end	
	

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)

		if IsControlPressed(0, 177) then -- Falls die Nachricht nicht ausgeblendet wird einfach BACKSPACE drücken!
			TriggerEvent('message:hide')
		end
	end
end)	
-- UI Events --

RegisterNetEvent('message:show')
AddEventHandler('message:show', function(title, msg)
	SendNUIMessage({
      type = "message",
      display = true,
	  title = title,
	  message = msg
    })
end)

RegisterNetEvent('message:hide')
AddEventHandler('message:hide', function()
	SendNUIMessage({
      type = "message",
      display = false,
	  title = nil,
	  message = nil
    })
 end)
  
AddEventHandler("onResourceStart", function(resource)
	if resource == GetCurrentResourceName() then
		TriggerEvent("message:hide", true)
	end
end)

AddEventHandler("onClientResourceStart", function(resource)
	if (resource == GetCurrentResourceName()) then
		TriggerEvent("message:hide", true)
	else
		return
	end
end)

RegisterNetEvent('est_notify-broadcast:display')
AddEventHandler('est_notify-broadcast:display', function(text)
	SendNUIMessage({
		action = 'add',
		text = text
    })
	if string.match(text, "Krieg") then
		SendNUIMessage({message = 'play', sound = 'notification.ogg', volume = 1.0})
	end
end)

RegisterNetEvent('LIFE_CL:Sound:PlayOnAll')
AddEventHandler('LIFE_CL:Sound:PlayOnAll', function(soundFile, soundVolume)
    SendNUIMessage({
        transactionType     = 'playSound',
        transactionFile     = soundFile,
        transactionVolume   = soundVolume
    })
end)
