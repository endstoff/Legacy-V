-- ===============================================================================
-- ===             SaltyRadio - Based on ls-radio by "LS-Story"                ===
-- ===              Edited to work with SaltyChat by Doxylamin                 ===
-- ===============================================================================

ESX = nil
PlayerData                = {}

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
	
	
	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end

  PlayerData = ESX.GetPlayerData()
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
  PlayerData.job = job
end)


local radioMenu = false

function PrintChatMessage(text)
    TriggerEvent('chatMessage', "system", { 255, 0, 0 }, text)
end



function enableRadio(enable)

  SetNuiFocus(true, true)
  radioMenu = enable

  SendNUIMessage({
    type = "enableui",
    enable = enable
  })

end

RegisterCommand('radio', function(source, args)
    if Config.enableCmd then
      ESX.TriggerServerCallback("esx_thief:getItemQ", function(quantity)
        if quantity > 0 then
          enableRadio(true)
        else
        --    exports['mythic_notify']:DoHudText('error', "Du hast kein Radio.")
            TriggerEvent('est_notify', '#FF0000', '<span style="color:white"><b>Information</b></span>', 'Du hast kein Radio')
        end
      end, "radio")
    end
end, false)

RegisterCommand('radiotest', function(source, args)
  local playerName = GetPlayerName(PlayerId())
  local data = exports.saltychat:GetRadioChannel(true)

  if data == nil or data == '' then
  --  exports['mythic_notify']:DoHudText('inform', Config.messages['not_on_radio'])
    TriggerEvent('est_notify', '#FF0000', '<b>Funkgerät</b>', Config.messages['not_on_radio'])
  else
  -- exports['mythic_notify']:DoHudText('inform', Config.messages['on_radio'] .. data .. '.00 MHz </b>')
    TriggerEvent('est_notify', '#FF0000', '<b>Funkgerät</b>', Config.messages['on_radio'] .. data .. '.00 MHz </b>')
 end

end, false)

RegisterNUICallback('joinRadio', function(data, cb)
	local getPlayerRadioChannel = exports.saltychat:GetRadioChannel(true)
	local playerJob = ESX.GetPlayerData().job
	
	if playerJob == nil or playerJob.name == nil then
    exports['mythic_notify']:DoHudText('error', "Ein Fehler ist aufgetreten. Bitte versuche es später erneut.")
    TriggerEvent('est_notify', '#FF0000', '<b>Funkgerät</b>', 'Ein Fehler ist aufgetreten. Bitte versuche es später erneut.')
	end

	 if data.channel ~= getPlayerRadioChannel then
        if Config.RestrictedChannels[data.channel] ~= nil then
          if Config.RestrictedChannels[data.channel][playerJob.name] ~= nil then
            exports.saltychat:SetRadioChannel(data.channel, true)
        --  exports['mythic_notify']:DoHudText('inform', string.format(Config.messages['joined_to_radio'], data.channel))
            TriggerEvent('est_notify', '#45CE00', '<b>Funkgerät</b>', string.format(Config.messages['joined_to_radio'], data.channel))
            SendNUIMessage({ type = "changeChannel", value = data.channel})
          else
          --  exports['mythic_notify']:DoHudText('error', string.format(Config.messages['restricted_channel_error'], data.channel))
            TriggerEvent('est_notify', '#FF0000', '<b>Funkgerät</b>', string.format(Config.messages['restricted_channel_error'], data.channel))
          end
        else
          exports.saltychat:SetRadioChannel(data.channel, true)
        --  exports['mythic_notify']:DoHudText('inform', string.format(Config.messages['joined_to_radio'], data.channel))
          TriggerEvent('est_notify', '#45CE00', '<b>Funkgerät</b>', string.format(Config.messages['joined_to_radio'], data.channel))
          SendNUIMessage({ type = "changeChannel", value = data.channel})
        end
     else
      --  exports['mythic_notify']:DoHudText('error', string.format(Config.messages['you_on_radio'], data.channel))
        TriggerEvent('est_notify', '#FF0000', '<b>Funkgerät</b>', string.format(Config.messages['you_on_radio'], data.channel))
     end
    cb('ok')
end)

RegisterNUICallback('leaveRadio', function(data, cb)
	local playerName = GetPlayerName(PlayerId())
	local getPlayerRadioChannel = exports.saltychat:GetRadioChannel(true)

	if getPlayerRadioChannel == nil or getPlayerRadioChannel == '' then
    --  exports['mythic_notify']:DoHudText('inform', Config.messages['not_on_radio'])
      TriggerEvent('est_notify', '#FF0000', '<b>Funkgerät</b>', Config.messages['not_on_radio'])
    else
		exports.saltychat:SetRadioChannel('', true)
        SendNUIMessage({ type = "changeChannel", value = -1})
      --  exports['mythic_notify']:DoHudText('inform', string.format(Config.messages['you_leave'], tonumber(getPlayerRadioChannel)))
       TriggerEvent('est_notify', '#FF0000', '<b>Funkgerät</b>', string.format(Config.messages['you_leave'], tonumber(getPlayerRadioChannel)))
    end

   cb('ok')

end)

RegisterNUICallback('escape', function(data, cb)
    enableRadio(false)
    SetNuiFocus(false, false)
    cb('ok')
end)

RegisterNetEvent('saltyradio:use')
AddEventHandler('saltyradio:use', function()
	TriggerEvent('inv:close')
	enableRadio(true)
end)

RegisterNetEvent('saltyradio:onRadioDrop')
AddEventHandler('saltyradio:onRadioDrop', function(source)
  local playerName = GetPlayerName(source)
  local getPlayerRadioChannel = exports.saltychat:GetRadioChannel(true)


  if getPlayerRadioChannel ~= '' then
	exports.saltychat:SetRadioChannel('', true)
    SendNUIMessage({ type = "changeChannel", value = -1})
    exports['mythic_notify']:DoHudText('inform', string.format(Config.messages['you_leave'], tonumber(getPlayerRadioChannel)))
    SendNUIMessage({ type = "hasradio", state = false})

end
end)

Citizen.CreateThread(function()
    while true do
        if radioMenu then
            DisableControlAction(0, 1, guiEnabled) -- LookLeftRight
            DisableControlAction(0, 2, guiEnabled) -- LookUpDown
            DisableControlAction(0, 142, guiEnabled) -- MeleeAttackAlternate
            DisableControlAction(0, 106, guiEnabled) -- VehicleMouseControlOverride
            if IsDisabledControlJustReleased(0, 142) then -- MeleeAttackAlternate
                SendNUIMessage({
                    type = "click"
                })
            end
        end
        Citizen.Wait(0)
    end
end)
