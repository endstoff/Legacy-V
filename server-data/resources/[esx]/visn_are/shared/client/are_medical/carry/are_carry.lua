--[[
-- Author: Tim 'veryinsanee' Plate
-- 
-- File: are_carry.lua
-- 
-- Arguments: 
-- None
-- 
-- ReturnValue:
-- None
-- 
-- Example:
-- _exampleFunction(_exampleArgument)
-- 
-- Public: No
-- Copyright (c) 2020 Tim Plate
--]]

carryingBackInProgress = false
carryAnimNamePlaying = ""
carryAnimDictPlaying = ""
carryControlFlagPlaying = 0

function _tryCarry(playerData)	
    if not carryingBackInProgress then
        if playerData.personData.isUnconscious then
            local player = PlayerPedId()	
            lib = 'missfinale_c2mcs_1'
            anim1 = 'fin_c2_mcs_1_camman'
            lib2 = 'nm'
            anim2 = 'firemans_carry'
            distans = 0.15
            distans2 = 0.27
            height = 0.63
            spin = 0.0		
            length = 100000
            controlFlagMe = 49
            controlFlagTarget = 33
            animFlagTarget = 1
    
            local closestPlayer = GetClosestPlayer(3)
            target = GetPlayerServerId(closestPlayer)
            if closestPlayer ~= -1 and closestPlayer ~= nil then
                carryingBackInProgress = true
                TriggerServerEvent('visn_are:sync', closestPlayer, lib,lib2, anim1, anim2, distans, distans2, height, target,length,spin,controlFlagMe,controlFlagTarget,animFlagTarget)
    
                _sendNotification(_translate("carrying_person", "X"), "info", 5500)
                EnableGui(false, lastPlayerId)
            end
        else
            _sendNotification(_translate("person_must_be_unconscious"), "error", 2500)
        end
    else
        carryingBackInProgress = false
        ClearPedSecondaryTask(GetPlayerPed(-1))
        DetachEntity(GetPlayerPed(-1), true, false)
        local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()    
    
        if closestPlayer ~= -1 and closestDistance < 3.0 then
            TriggerServerEvent("visn_are:stopCarry", GetPlayerServerId(closestPlayer))
        end
    end
end

function _tryPutInVehicle(playerData)	
    if playerData.personData.isUnconscious and not playerData.personData.inBodybag then
        local closestPlayer = GetClosestPlayer(3)
        target = GetPlayerServerId(closestPlayer)
        if closestPlayer ~= -1 and closestPlayer ~= nil then
            TriggerServerEvent('visn_are:putInVehicle', target)
            EnableGui(false, lastPlayerId)
        end
    else
        _sendNotification(_translate("person_must_be_unconscious"), "error", 2500)
    end
end

function _tryPullOutVehicle(playerData)	
    if playerData.personData.isUnconscious and not playerData.personData.inBodybag then
        local closestPlayer = GetClosestPlayer(2.5)
        target = GetPlayerServerId(closestPlayer)
        if closestPlayer ~= -1 and closestPlayer ~= nil then
            if GetVehiclePedIsIn(GetPlayerPed(closestPlayer), false) == 0 then return end

            TriggerServerEvent('visn_are:pullOutVehicle', target)
            EnableGui(false, lastPlayerId)
        end
    else
        _sendNotification(_translate("person_must_be_unconscious"), "error", 2500)
    end
end

RegisterNetEvent('visn_are:stopCarry')
AddEventHandler('visn_are:stopCarry', function()
	carryingBackInProgress = false
	ClearPedSecondaryTask(PlayerPedId())
	DetachEntity(PlayerPedId(), true, false)
end)