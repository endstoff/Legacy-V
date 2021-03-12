local ESX = nil
local stage = 1
local micmuted = false
local Keys = {

    ["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,

    ["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,

    ["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,

    ["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,

    ["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,

    ["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,

    ["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,

    ["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,

    ["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118

}

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
	TriggerEvent('esx:setMoneyDisplay', 0.0)
	ESX.UI.HUD.SetDisplay(0.0)

end)


RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer) 
	local data = xPlayer
	local accounts = data.accounts
	for k, v in pairs(accounts) do
		local account = v
		if account.name == "black_money" then
			if account.money > 0 then
			SendNUIMessage({action = "setBlackMoney", black = account.money})
			else
			SendNUIMessage({action = "hideBlackMoney"})
			end
		end
	end
	SendNUIMessage({action = "setMoney", money = data.money})
end)

RegisterNetEvent('esx:setAccountMoney')
AddEventHandler('esx:setAccountMoney', function(account)
	if account.name == "money" then

	SendNUIMessage({action = "setMoney", money = account.money})
	end
	if account.name == "black_money" then
		if account.money > 0 then
		SendNUIMessage({action = "setBlackMoney", black = account.money})
		else
		SendNUIMessage({action = "hideBlackMoney"})
		end
	end
end)
  -- SendNUIMessage({action = "setVoiceLevel", level = stage})

--Citizen.CreateThread(function()

 -- while true do

   -- Citizen.Wait(0)


   -- if IsControlJustPressed(0, Keys['Z']) then
---	if stage <= 3 then

	--		stage = stage + 1
	--		print(stage)
  --  SendNUIMessage({action = "setVoiceLevel", level = stage})
--	else

--	stage = 1
  --  SendNUIMessage({action = "setVoiceLevel", level = stage})

--	end
--end
---end
--end)

RegisterNetEvent("MIC:muted")
AddEventHandler('MIC:muted', function()
	SendNUIMessage({action = "muted", muted = true})
	micmuted = true

end)
RegisterNetEvent("MIC:enable")
AddEventHandler('MIC:enable', function()
    SendNUIMessage({action = "nomuted"})
	micmuted = false
end)


RegisterNetEvent('ss')
AddEventHandler('ss', function(voiceRange)
	if micmuted == false then

	if voiceRange == 3 then
    SendNUIMessage({action = "setVoiceLevel", level = 1})
	end
	if voiceRange == 8 then
	SendNUIMessage({action = "setVoiceLevel", level = 2})
	end
	if voiceRange == 15 then
	SendNUIMessage({action = "setVoiceLevel", level = 3})
	end
	if voiceRange == 32 then
	SendNUIMessage({action = "setVoiceLevel", level = 4})
	end
end
end)

RegisterNetEvent('esx:activateMoney')
AddEventHandler('esx:activateMoney', function(e)
	SendNUIMessage({action = "setMoney", money = e})
end)

