--[[
-- Author: Tim 'veryinsanee' Plate
-- 
-- File: are_medical.lua
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

ESX = nil
bloodLevel = 6.0
isBleeding = false
isUnconscious = false
kickedOutVehicle = false
isLaying = false
inBodybag = false

peripheralResistance = 100
isFeelingPain = false

_bloodPressure = 1 * peripheralResistance;

painFactor = 0

currentPulse = 80
increasePulseRate = 0
increasePulseTimer = 0

doingCPR = false
doingCPRTarget = 0

hasCardiacArrest = false

decreasePulseRate = 0
decreasePulseTimer = 0
forceUnconscious = false

recievingBloodInfusion = 0

bloodPressureL = 0
bloodPressureH = 0

local VENTRICLE_STROKE_VOL = 95e-3
local MODIFIER_BP_HIGH = 9.4736842
local MODIFIER_BP_LOW = 6.3157894

local X, Y, W; H = 0.0125
local progressTimer = 0
local progressText = ""
local timer = 0
local xFactor = 0
local cooldownTimer = 0
local painTimer = 0
local cardiacDecided = false

local inVehicle = false
local lastPlayerId = GetPlayerServerId(PlayerPedId())
local isBusy = false

local isLimpWalkingStyle = false

openWounds = {}
bleedValue = 0

local bodyPartInfo = {}
local damagedBones = {}
local damagedAreas = {}
local needSewed = {}
local decalPool = {}
local logs = {}
local bloodAreas = {}
local storedMedications = {}
local appliedTourniquets = {}

local latestMiscObjects = {}

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent(ConfigData.sharedObjectName, function(obj) ESX = obj end)
		Citizen.Wait(1)
    end
end)

local languageData = initLanguages()

AddEventHandler('esx:onPlayerDeath', function(data)
    local ped = PlayerPedId()
    local currentCoords = GetEntityCoords(ped, true)

    SetEntityCoordsNoOffset(ped, currentCoords.x, currentCoords.y, currentCoords.z, false, false, false, true)
    NetworkResurrectLocalPlayer(currentCoords.x, currentCoords.y, currentCoords.z, heading, true, false)
    SetEntityInvincible(ped, true)
    SetPedCanBeTargetted(PlayerPedId(), false)
    SetCanAttackFriendly(PlayerPedId(), false, false)
    ClearPedBloodDamage(ped)

    TriggerEvent('esx:onPlayerSpawn')
    TriggerEvent('playerSpawned')
    
    forceUnconscious = true

    if isUnconscious then
        currentPulse = 0

        increasePulseTimer = 0
        increasePulseRate = 0
    else
        currentPulse = 16
        SendNUIMessage({
            type = 'resetTimer',
        })

        SendNUIMessage({
            type = 'setTimer',
            time = ConfigData.respawnTimer,
        })
        
        increasePulseTimer = 0
        increasePulseRate = 0
    end

    isUnconscious = true
    
    SendNUIMessage({
        type = 'checkU',
        enable = true
    })

    SendNUIMessage({
        type = 'deactivatePainEffect'
    })
    
    Citizen.Wait(200)

    SetEntityCoords(PlayerPedId(), data.victimCoords.x, data.victimCoords.y, data.victimCoords.z)       
    
    local formattedCoords = {
        x = ESX.Math.Round(currentCoords.x, 1),
        y = ESX.Math.Round(currentCoords.y, 1),
        z = ESX.Math.Round(currentCoords.z, 1)
    }

    ESX.SetPlayerData('lastPosition', formattedCoords)
    TriggerServerEvent('esx:updateLastPosition', formattedCoords)
    TriggerServerEvent('esx_ambulancejob:setDeathStatus', true)
    TriggerServerEvent('visn_are:SetDeathStatus', isUnconscious)
end)

AddEventHandler("gameEventTriggered", function(name, args)
    local playerPed = PlayerPedId()
    
    if name == "CEventNetworkEntityDamage" then
        local entity, damager, bone, fatalDamage, damageType = table.unpack(args)
        
        if entity == PlayerPedId() then
            
            if isUnconscious == false then
                if fatalDamage == 1 then
                    if damager ~= entity then
                        local killerSource = GetPlayerServerId(NetworkGetPlayerIndexFromPed(damager))
                        if killerSource ~= 0 then
                            TriggerServerEvent('visn_are:killLog', _translate("discord_kill_player", GetPlayerName(PlayerId()), GetPlayerServerId(PlayerId()), GetPlayerName(NetworkGetPlayerIndexFromPed(damager)), killerSource))
                        else
                            TriggerServerEvent('visn_are:killLog', _translate("discord_kill_self", GetPlayerName(PlayerId()), GetPlayerServerId(PlayerId())))
                        end
                    else
                        TriggerServerEvent('visn_are:killLog', _translate("discord_kill_self", GetPlayerName(PlayerId()), GetPlayerServerId(PlayerId())))
                    end
                end
            end

            if bone ~= nil and bone ~= 0 then
                local returnValue, outBone = GetPedLastDamageBone(playerPed)

                if damageType == -1569615261 and fatalDamage == 0 then
                    if ConfigData.enablePunchDamage then
                        local head = math.random(0, 1)
                        damagedAreas["head"] = 1

                        if bloodAreas["head"] == 0 then
                            bloodAreas["head"] = head
                        end
                    else
                        return
                    end
                end

                if damageType == -1323279794 then
                    local head = math.random(1, 3)
                    local leftArm = math.random(1, 3)
                    local rightArm = math.random(1, 3)
                    local torso = math.random(1, 3)
                    local leftLeg = math.random(1, 3)
                    local rightLeg = math.random(1, 3)

                    damagedAreas["head"] = head
                    damagedAreas["left_arm"] = leftArm
                    damagedAreas["right_arm"] = rightArm
                    damagedAreas["torso"] = torso
                    damagedAreas["left_leg"] = leftLeg
                    damagedAreas["right_leg"] = rightLeg

                    bloodAreas["head"] = head
                    bloodAreas["left_arm"] = leftArm
                    bloodAreas["right_arm"] = rightArm
                    bloodAreas["torso"] = torso
                    bloodAreas["left_leg"] = leftLeg
                    bloodAreas["right_leg"] = rightLeg
                end

                if damageType == -842959696 and fatalDamage == 0 then
                    if not ConfigData.enableFallDamage then
                        return
                    end
                end

                if damageType == -1323279794 and fatalDamage == 1 then
                    local leftArm = math.random(1, 3)
                    local rightArm = math.random(1, 3)
                    local torso = math.random(1, 3)

                    damagedAreas["left_arm"] = leftArm
                    damagedAreas["right_arm"] = rightArm
                    damagedAreas["torso"] = torso

                    bloodAreas["head"] = 3
                    bloodAreas["left_arm"] = 3
                    bloodAreas["right_arm"] = 3
                    bloodAreas["torso"] = 3
                    bloodAreas["left_leg"] = 3
                    bloodAreas["right_leg"] = 3
                end

                if damageType == 539292904 and fatalDamage == 1 then
                    local head = math.random(1, 3)
                    local leftArm = math.random(1, 3)
                    local rightArm = math.random(1, 3)
                    local torso = math.random(1, 3)
                    local leftLeg = math.random(1, 3)
                    local rightLeg = math.random(1, 3)

                    damagedAreas["head"] = head
                    damagedAreas["left_arm"] = leftArm
                    damagedAreas["right_arm"] = rightArm
                    damagedAreas["torso"] = torso
                    damagedAreas["left_leg"] = leftLeg
                    damagedAreas["right_leg"] = rightLeg

                    bloodAreas["head"] = head
                    bloodAreas["left_arm"] = leftArm
                    bloodAreas["right_arm"] = rightArm
                    bloodAreas["torso"] = torso
                    bloodAreas["left_leg"] = leftLeg
                    bloodAreas["right_leg"] = rightLeg
                end

                if damageType == -842959696 and fatalDamage == 1 then
                    local head = math.random(0, 3)
                    local leftArm = math.random(0, 3)
                    local rightArm = math.random(0, 3)
                    local torso = math.random(0, 3)
                    local leftLeg = math.random(0, 3)
                    local rightLeg = math.random(0, 3)

                    damagedAreas["head"] = head
                    damagedAreas["left_arm"] = leftArm
                    damagedAreas["right_arm"] = rightArm
                    damagedAreas["torso"] = torso
                    damagedAreas["left_leg"] = leftLeg
                    damagedAreas["right_leg"] = rightLeg

                    bloodAreas["head"] = head
                    bloodAreas["left_arm"] = leftArm
                    bloodAreas["right_arm"] = rightArm
                    bloodAreas["torso"] = torso
                    bloodAreas["left_leg"] = leftLeg
                    bloodAreas["right_leg"] = rightLeg
                end

                if damageType == 133987706 then
                    increasePain(math.random(0, 3))
                    damagedAreas["head"] = math.random(0, 2)
                end

                if outBone == 0 then
                    return
                end

                if not has_value(damagedBones, outBone) then
                    table.insert(damagedBones, outBone)
                    ClearPedLastDamageBone(playerPed)

                    TriggerEvent('visn_are:changePower', 1)

                    local damaged = 0
                    local loseMultiplier = 0

                    for index, value in pairsByKeys(damagedBones) do 
                        if value >= 1 then
                            damaged = damaged + 1
                        end

                        if value > 1 then
                            loseMultiplier = loseMultiplier + 0.25
                        end
                    end

                    if not isUnconscious then
                        increasePulse(damaged, loseMultiplier * 3)
                        increasePain(1)
                    end
                elseif has_value(damagedBones, outBone) then
                    TriggerEvent('visn_are:changePower', 1)

                    local damaged = 0
                    local loseMultiplier = 0

                    for index, value in pairsByKeys(damagedAreas) do 
                        if value >= 1 then
                            damaged = damaged + 1
                        end

                        if value > 1 then
                            loseMultiplier = loseMultiplier + 0.25
                        end
                    end

                    if not isUnconscious then
                        increasePulse(damaged, loseMultiplier * 3)
                        increasePain(1)
                    end
                end

                damagedAreas[pedBones[outBone][2]] = damagedAreas[pedBones[outBone][2]] + 1 

                if damagedAreas[pedBones[outBone][2]] > 3 then
                    damagedAreas[pedBones[outBone][2]] = 3
                elseif damagedAreas[pedBones[outBone][2]] < 0 then
                    damagedAreas[pedBones[outBone][2]] = 0
                end        
                
                if pedBones[outBone][2] ~= "torso" then
                    bloodAreas[pedBones[outBone][2]] = bloodAreas[pedBones[outBone][2]] + 1 
                end
                
                if pedBones[outBone][2] == "torso" then
                    if GetPedArmour(PlayerPedId()) == 0 then
                        bloodAreas[pedBones[outBone][2]] = bloodAreas[pedBones[outBone][2]] + 1 
                    end
                end

                if bloodAreas[pedBones[outBone][2]] > 3 then
                    bloodAreas[pedBones[outBone][2]] = 3
                elseif bloodAreas[pedBones[outBone][2]] < 0 then
                    bloodAreas[pedBones[outBone][2]] = 0
                end
            end
        end
    end

    if name == "CEventOnFire" then
        if entity == PlayerPedId() then
            if bone ~= nil and bone ~= 0 then
                local returnValue, outBone = GetPedLastDamageBone(playerPed)

                if outBone == 0 then
                    return
                end

                if not has_value(damagedBones, outBone) then
                    table.insert(damagedBones, outBone)
                    ClearPedLastDamageBone(playerPed)

                    TriggerEvent('visn_are:changePower', 1)

                    local damaged = 0
                    local loseMultiplier = 0

                    for index, value in pairsByKeys(damagedBones) do 
                        if value >= 1 then
                            damaged = damaged + 1
                        end

                        if value > 1 then
                            loseMultiplier = loseMultiplier + 0.25
                        end
                    end

                    increasePulse(damaged, loseMultiplier * 15)
                    increasePain(1)
                elseif has_value(damagedBones, outBone) then
                    TriggerEvent('visn_are:changePower', 1)

                    local damaged = 0
                    local loseMultiplier = 0

                    for index, value in pairsByKeys(damagedAreas) do 
                        if value >= 1 then
                            damaged = damaged + 1
                        end

                        if value > 1 then
                            loseMultiplier = loseMultiplier + 0.25
                        end
                    end

                    increasePulse(damaged, loseMultiplier * 100)
                end

                damagedAreas[pedBones[outBone][2]] = damagedAreas[pedBones[outBone][2]] + 1 

                if damagedAreas[pedBones[outBone][2]] > 3 then
                    damagedAreas[pedBones[outBone][2]] = 3
                elseif damagedAreas[pedBones[outBone][2]] < 0 then
                    damagedAreas[pedBones[outBone][2]] = 0
                end                    
                
                bloodAreas[pedBones[outBone][2]] = bloodAreas[pedBones[outBone][2]] + 1 

                if bloodAreas[pedBones[outBone][2]] > 3 then
                    bloodAreas[pedBones[outBone][2]] = 3
                elseif bloodAreas[pedBones[outBone][2]] < 0 then
                    bloodAreas[pedBones[outBone][2]] = 0
                end
            end
        end
    end
end)

function doCPR(playerId)
    doingCPR = true
    doingCPRTarget = playerId

    createProgressbar(_translate("doing_cpr"), 10000)
    Citizen.Wait(10000)

    ClearPedTasks(PlayerPedId())
    ClearPedSecondaryTask(PlayerPedId())

    TriggerServerEvent('visn_are:sendCPR', playerId)

    doingCPR = false
    doingCPRTarget = 0
end

function increasePulse(increasePulseRateParam, increaseDuration)
    increasePulseRate = increasePulseRateParam
    increasePulseTimer = increaseDuration
end

function decreasePulse(decreasePulseRateParam, decreaseDuration)
    decreasePulseRate = decreasePulseRateParam
    decreasePulseTimer = decreaseDuration
end

function increasePain(step)
    local savedPain = painFactor
    painFactor = painFactor + step

    if savedPain ~= painFactor and painFactor > 0 then
        painTimer = 600
    end

    if painFactor > 4 then
        painFactor = 4
    end
    
    if painFactor < 0 then
        painFactor = 0
    end
end

function decreasePain(step)
    painFactor = painFactor - step

    if painFactor > 4 then
        painFactor = 4
    end
    
    if painFactor < 0 then
        painFactor = 0
    end

    if painFactor == 0 then
        painTimer = 0

        SendNUIMessage({
            type = 'deactivatePainEffect'
        })
    end
end

function resetAreas()
    for index, value in pairsByKeys(pedBones) do 
        damagedAreas[value[2]] = 0
        bloodAreas[value[2]] = 0
    end
    
    for index, value in pairsByKeys(needSewed) do 
        needSewed[index] = 0
    end
    
    for index, value in pairsByKeys(damagedBones) do 
        damagedBones[index] = 0
    end
end

function useLiquid(playerId, liquidType, bodyPart)
    if playerId == 0 then
        playerId = PlayerId()
    end

    TriggerServerEvent('visn_are:addLog', GetPlayerServerId(PlayerId()), playerId, 'GIVE_' .. string.upper(liquidType) .. '_' .. string.upper(bodyPart))
    TriggerServerEvent('visn_are:sendLiquid', playerId, liquidType, bodyPart)
end


RegisterNetEvent('visn_are:setFocus')
AddEventHandler('visn_are:setFocus', function(focus)
    SetNuiFocus(focus, focus)
end)

RegisterNetEvent('visn_are:getBodyInfo')
AddEventHandler('visn_are:getBodyInfo', function()
    TriggerServerEvent('visn_are:sendBodyInfo', {
        bodyPartDamage = damagedAreas,
        bloodParts = bloodAreas,
        needSewed = needSewed,
        bodyPulse = currentPulse,
        inBodybag = inBodybag,
        bodyPain = painFactor,
        bodyInPain = isFeelingPain,
        victimBleeding = isBleeding,
        bodyBloodLevel = bloodLevel,
        isUnconscious = isUnconscious,
        recievingBloodInfusion = recievingBloodInfusion,
        bloodPressureL = bloodPressureL, 
        appliedTourniquets = appliedTourniquets,
        bloodPressureH = bloodPressureH, 
        logs = logs,
    })
end)

RegisterNetEvent('visn_are:recieveLiquid')
AddEventHandler('visn_are:recieveLiquid', function(liquidType, bodyPart)
    if appliedTourniquets[bodyPart] ~= nil then
        if storedMedications[bodyPart] == nil then
            storedMedications[bodyPart] = {}
        end

        table.insert(storedMedications[bodyPart], liquidType)
        return
    end
    
    evalLiquid(liquidType)
end)

function evalLiquid(liquidType)
    if liquidType == 'epinephrine' and currentPulse ~= 0 then
        increasePulse(increasePulseRate + 1, increasePulseTimer + 10)
    end
        
    if liquidType == 'atropine' and currentPulse ~= 0 then
        decreasePulse(decreasePulseRate + math.random(1, 2), decreasePulseRate + 10)
    end

    if liquidType == 'morphin' and currentPulse ~= 0 then
        decreasePulse(decreasePulseRate + math.random(1, 2), decreasePulseTimer + 15)
        decreasePain(5)
        bodyInPain = false
    end
end

RegisterNetEvent('visn_are:recievePainkillers')
AddEventHandler('visn_are:recievePainkillers', function()
    decreasePain(6)
end)

RegisterNetEvent('visn_are:recieveInfusion')
AddEventHandler('visn_are:recieveInfusion', function(infusionType, infusionAmount)
    if infusionType == 'blood' then
        recievingBloodInfusion = recievingBloodInfusion + infusionAmount
    end
end)

RegisterNetEvent('visn_are:syncTarget')
AddEventHandler('visn_are:syncTarget', function(target, animationLib, animation2, distans, distans2, height, length,spin,controlFlag)
	local playerPed = GetPlayerPed(-1)
	local targetPed = GetPlayerPed(GetPlayerFromServerId(target))
	carryingBackInProgress = true
	RequestAnimDict(animationLib)

	while not HasAnimDictLoaded(animationLib) do
		Citizen.Wait(10)
	end
	if spin == nil then spin = 180.0 end
	AttachEntityToEntity(GetPlayerPed(-1), targetPed, 0, distans2, distans, height, 0.5, 0.5, spin, false, false, false, false, 2, false)
	if controlFlag == nil then controlFlag = 0 end
	TaskPlayAnim(playerPed, animationLib, animation2, 8.0, -8.0, length, controlFlag, 0, false, false, false)
	carryAnimNamePlaying = animation2
	carryAnimDictPlaying = animationLib
	carryControlFlagPlaying = controlFlag
end)

RegisterNetEvent('visn_are:syncMe')
AddEventHandler('visn_are:syncMe', function(animationLib, animation,length,controlFlag,animFlag)
	local playerPed = GetPlayerPed(-1)
	RequestAnimDict(animationLib)

	while not HasAnimDictLoaded(animationLib) do
		Citizen.Wait(10)
	end
	Wait(500)
	if controlFlag == nil then controlFlag = 0 end
	TaskPlayAnim(playerPed, animationLib, animation, 8.0, -8.0, length, controlFlag, 0, false, false, false)
	carryAnimNamePlaying = animation
	carryAnimDictPlaying = animationLib
	carryControlFlagPlaying = controlFlag
end)

RegisterNetEvent('visn_are:recieveTourniquet')
AddEventHandler('visn_are:recieveTourniquet', function(bodyPart)
    appliedTourniquets[bodyPart] = GetGameTimer()
end)

RegisterNetEvent('visn_are:removeTourniquet')
AddEventHandler('visn_are:removeTourniquet', function(bodyPart)
    appliedTourniquets[bodyPart] = nil

    if storedMedications[bodyPart] ~= nil then
        for idx, medication in pairs(storedMedications[bodyPart]) do
            evalLiquid(medication)
        end
    end
end)

RegisterNetEvent('visn_are:recieveSurgicalKit')
AddEventHandler('visn_are:recieveSurgicalKit', function(bodyPart)
    needSewed[bodyPart] = 0
end)

RegisterNetEvent('visn_are:recieveCPR')
AddEventHandler('visn_are:recieveCPR', function()
    increasePulse(math.random(0, 2), math.random(0, 10))

    SendNUIMessage({
        type = 'setTimer',
        time = 300,
    })
end)

RegisterNetEvent('visn_are:recieveDefibrilator')
AddEventHandler('visn_are:recieveDefibrilator', function()
    local random = math.random(0, 1000000)

    if random < 500000 then
        increasePulse(math.random(0, 120), 1)
    end
end)

RegisterNetEvent('visn_are:reduceBloodLevel')
AddEventHandler('visn_are:reduceBloodLevel', function(bodyPart, bloodLevel)
    if bloodAreas[bodyPart] == 0 then
        createObject("prop_medstation_02", GetEntityCoords(PlayerPedId()).x + math.random(0, 1) / 4, GetEntityCoords(PlayerPedId()).y + math.random(0, 1) / 4, GetEntityCoords(PlayerPedId()).z - 2.32, GetEntityHeading(PlayerPedId()), 0.0)
    else
        createObject("prop_medstation_03", GetEntityCoords(PlayerPedId()).x + math.random(0, 1) / 4, GetEntityCoords(PlayerPedId()).y + math.random(0, 1) / 4, GetEntityCoords(PlayerPedId()).z - 1.28, GetEntityHeading(PlayerPedId()), 0.0)
    end

    bloodAreas[bodyPart] = bloodAreas[bodyPart] - bloodLevel

    if bloodAreas[bodyPart] < 0 then
        bloodAreas[bodyPart] = 0
    end

    if bloodAreas[bodyPart] > 3 then
        bloodAreas[bodyPart] = 3
    end
end)

RegisterNetEvent('visn_are:reduceDamageLevel')
AddEventHandler('visn_are:reduceDamageLevel', function(bodyPart, damageLevel)
    local savedDamaged = damagedAreas[bodyPart]
    damagedAreas[bodyPart] = damagedAreas[bodyPart] - damageLevel

    if damagedAreas[bodyPart] < 0 then
        damagedAreas[bodyPart] = 0
    end

    if damagedAreas[bodyPart] > 3 then
        damagedAreas[bodyPart] = 3
    end

    if damagedAreas[bodyPart] == 0 and damagedAreas[bodyPart] ~= savedDamaged then
        if math.random(0, 100000) > 50000 then
            needSewed[bodyPart] = 1
        end
    end
end)

function createObject(objectName, objectX, objectY, objectZ, objectHeading, objectRotation)
    TriggerServerEvent('visn_are:createObject', json.encode({
        ["objectName"] = objectName,
        ["objectX"] = objectX,
        ["objectY"] = objectY,
        ["objectZ"] = objectZ,
        ["objectHeading"] = objectHeading,
        ["objectRotation"] = objectRotation,
        ["eventName"] = "visn_are:createObjectClient",
        ["target"] = -1,
    }))
end

RegisterNetEvent('visn_are:recieveLog')
AddEventHandler('visn_are:recieveLog', function(senderId, logType, logTime)
    table.insert(logs, {
        playerId = GetPlayerServerId(PlayerId()),
        senderId = senderId,
        logType = logType,
        logTime = logTime
    })
end)

RegisterNetEvent('visn_are:createObjectClient')
AddEventHandler('visn_are:createObjectClient', function(data)
    local dataParsed = json.decode(data)
    local objectName = dataParsed.objectName
    local objectX = dataParsed.objectX
    local objectY = dataParsed.objectY
    local objectZ = dataParsed.objectZ
    local objectHeading = dataParsed.objectHeading
    local objectRotation = dataParsed.objectRotation

    RequestModel(GetHashKey(objectName))
    while not HasModelLoaded(GetHashKey(objectName)) do
      Citizen.Wait(1)
    end

    if #latestMiscObjects >= ConfigData.maxMiscObjects then
        DeleteObject(latestMiscObjects[1])
        table.remove(latestMiscObjects, 1)
    end

    local object = CreateObject(GetHashKey(objectName), objectX, objectY, objectZ, true, true, false)
    SetEntityHeading(object, objectHeading)
    SetEntityRotation(object, objectRotation, 0.0, 0.0)  

    if objectName == 'p_bloodsplat_s' then
        SetEntityRotation(object, -90.0, 0.0, 0.0, 2, false)
        SetEntityCollision(object, false, true)
    end

    table.insert(latestMiscObjects, object)
    SetEntityAsMissionEntity(object)
end)


RegisterNetEvent('InteractSound_CL_M:PlayWithinDistance')
AddEventHandler('InteractSound_CL_M:PlayWithinDistance', function(playerNetId, maxDistance, soundFile, soundVolume)
    local lCoords = GetEntityCoords(GetPlayerPed(-1))
    local eCoords = GetEntityCoords(GetPlayerPed(GetPlayerFromServerId(playerNetId)))
    local distIs  = Vdist(lCoords.x, lCoords.y, lCoords.z, eCoords.x, eCoords.y, eCoords.z)
	if(distIs <= maxDistance) then
        SendNUIMessage({
            transactionType     = 'playSound',
            transactionFile     = soundFile,
            transactionVolume   = (distIs - maxDistance) / -maxDistance * 0.4
        })
    end
end)

function createProgressbar(text, duration, xFactorParam)
    xFactor = xFactorParam or 0.09

    progressTimer = duration
    progressText = text
    timer = GetGameTimer()
end

function round(num, numDecimalPlaces)
	local mult = 10^(numDecimalPlaces or 0)
	return math.floor(num * mult + 0.5) / mult
end

function _checkPulse(playerId, bodyPart)
    createProgressbar(_translate("measuring_pulse"), 2500, 0.06)

    local lib, anim = 'anim@heists@narcotics@funding@gang_idle', 'gang_chatting_idle01' -- TODO better animations

    SetCurrentPedWeapon(PlayerPedId(), GetHashKey("WEAPON_UNARMED"), true)

    ESX.Streaming.RequestAnimDict(lib, function()
        TaskPlayAnim(PlayerPedId(), lib, anim, 8.0, -8.0, -1, 0, 0, false, false, false)
        
        while IsEntityPlayingAnim(PlayerPedId(), lib, anim, 3) do
            Citizen.Wait(1)
            --DisableAllControlActions(0)
        end
    end)

    TriggerServerEvent('visn_are:addLog', GetPlayerServerId(PlayerId()), playerId, 'CHECK_PULSE')

    Citizen.SetTimeout(2500, function()
        if GetDistanceBetweenCoords(GetEntityCoords(victimPed, true), GetEntityCoords(ownPed, true), true) < 1.5 then
            if not isUnconscious then
                ESX.TriggerServerCallback('visn_are:getBodyPartInfo', function(bodyPartInfoCB)
                    if appliedTourniquets[bodyPart] ~= nil then
                        _sendNotification(_translate("pulse_measured", math.random(0, 20), "2.5 " .. _translate("seconds")), "info", 7500)
                    else
                        _sendNotification(_translate("pulse_measured", bodyPartInfoCB.victimPulse, "2.5 " .. _translate("seconds")), "info", 7500)
                    end
                    ClearPedTasks(PlayerPedId())
                    EnableGui(true, lastPlayerId)
                end, playerId, "head")
            else
                _sendNotification(_translate("person_too_far_away"), "error", 3500)
                EnableGui(false, lastPlayerId)
            end
        end
    end)
end

function _checkPerson(playerId)
    createProgressbar(_translate('checking_reponse'), 2000, 0.08)

    local lib, anim = 'anim@heists@narcotics@funding@gang_idle', 'gang_chatting_idle01' -- TODO better animations

    SetCurrentPedWeapon(PlayerPedId(), GetHashKey("WEAPON_UNARMED"), true)

    ESX.Streaming.RequestAnimDict(lib, function()
        TaskPlayAnim(PlayerPedId(), lib, anim, 8.0, -8.0, -1, 0, 0, false, false, false)
        
        while IsEntityPlayingAnim(PlayerPedId(), lib, anim, 3) do
            Citizen.Wait(1)
            --DisableAllControlActions(0)
        end
    end)

    TriggerServerEvent('visn_are:addLog', GetPlayerServerId(PlayerId()), playerId, 'CHECK_PERSON')

    Citizen.SetTimeout(2000, function()
        if GetDistanceBetweenCoords(GetEntityCoords(victimPed, true), GetEntityCoords(ownPed, true), true) < 1.5 then
            if not isUnconscious then
                ESX.TriggerServerCallback('visn_are:getBodyPartInfo', function(bodyPartInfoCB)
                    if bodyPartInfoCB.isUnconscious then
                        _sendNotification(_translate('person_not_responsive'), "error", 6500)
                    else
                        _sendNotification(_translate('person_responsive'), "success", 6500)
                    end
                    
                    ClearPedTasks(PlayerPedId())
                    EnableGui(true, lastPlayerId)
                end, playerId, "head")
            else
                _sendNotification(_translate("person_too_far_away"), "error", 3500)
                EnableGui(false, lastPlayerId)
            end
        end
    end)
end

function _checkBloodPressure(playerId, bodyPart)
    createProgressbar(_translate('measuring_blood_pressure'), 3000, 0.08)

    local lib, anim = 'anim@heists@narcotics@funding@gang_idle', 'gang_chatting_idle01' -- TODO better animations

    SetCurrentPedWeapon(PlayerPedId(), GetHashKey("WEAPON_UNARMED"), true)

    ESX.Streaming.RequestAnimDict(lib, function()
        TaskPlayAnim(PlayerPedId(), lib, anim, 8.0, -8.0, -1, 0, 0, false, false, false)
        
        while IsEntityPlayingAnim(PlayerPedId(), lib, anim, 3) do
            Citizen.Wait(1)
            --DisableAllControlActions(0)
        end
    end)

    TriggerServerEvent('visn_are:addLog', GetPlayerServerId(PlayerId()), playerId, 'CHECK_BLOOD_PRESSURE')

    Citizen.SetTimeout(3000, function()
        if GetDistanceBetweenCoords(GetEntityCoords(victimPed, true), GetEntityCoords(ownPed, true), true) < 1.5 then
            ESX.TriggerServerCallback('visn_are:getBodyPartInfo', function(bodyPartInfoCB)
                if appliedTourniquets[bodyPart] ~= nil then
                    _sendNotification(_translate('blood_pressure_measured', math.random(0, 20), math.random(0, 20), "3 " .. _translate("seconds")), "info", 7500)
                else      
                    _sendNotification(_translate('blood_pressure_measured', bodyPartInfoCB.bloodPressureH, bodyPartInfoCB.bloodPressureL, "3 " .. _translate("seconds")), "info", 7500)
                end
                ClearPedTasks(PlayerPedId())
                EnableGui(true, lastPlayerId)
            end, playerId, "head")
        else
            _sendNotification(_translate("person_too_far_away"), "error", 3500)
            EnableGui(false, lastPlayerId)
        end
    end)
end

function _checkBloodVolume(playerId)
    createProgressbar(_translate("measuring_blood_content"), 3000, 0.08)

    local lib, anim = 'anim@heists@narcotics@funding@gang_idle', 'gang_chatting_idle01' -- TODO better animations

    SetCurrentPedWeapon(PlayerPedId(), GetHashKey("WEAPON_UNARMED"), true)

    ESX.Streaming.RequestAnimDict(lib, function()
        TaskPlayAnim(PlayerPedId(), lib, anim, 8.0, -8.0, -1, 0, 0, false, false, false)
        
        while IsEntityPlayingAnim(PlayerPedId(), lib, anim, 3) do
            Citizen.Wait(1)
            --DisableAllControlActions(0)
        end
    end)

    TriggerServerEvent('visn_are:addLog', GetPlayerServerId(PlayerId()), playerId, 'CHECK_BLOOD_VOLUME')

    Citizen.SetTimeout(3000, function()
        if GetDistanceBetweenCoords(GetEntityCoords(victimPed, true), GetEntityCoords(ownPed, true), true) < 1.5 then
            ESX.TriggerServerCallback('visn_are:getBodyPartInfo', function(bodyPartInfoCB)
                _sendNotification(_translate('blood_content_measured', bodyPartInfoCB.victimBloodLevel, "3 " .. _translate("seconds")), "info", 7500)
                ClearPedTasks(PlayerPedId())
                EnableGui(true, lastPlayerId)
            end, playerId, "head")
        else
            _sendNotification(_translate("person_too_far_away"), "error", 3500)
            EnableGui(false, lastPlayerId)
        end
    end)
end

function _useBandage(playerId, bandageArea, bandageType)
    local bandageTime = 0
    local bandageItem = ""

    if bandageType == 'bandage' then
        bandageTime = 6000
        bandageItem = "bandage"
    end

    if bandageType == 'elasticBandage' then
        bandageTime = 5000
        bandageItem = "elastic_bandage"
    end

    if bandageType == 'quickClot' then
        bandageTime = 5500
        bandageItem = "quickclot"
    end

    if bandageType == 'packingBandage' then
        bandageTime = 7000
        bandageItem = "packing_bandage"
    end

    ESX.TriggerServerCallback('visn_are:getItemCount', function(itemCount)
        if itemCount > 0 then
            createProgressbar(_translate('applying_badange'), bandageTime, 0.08)

            local lib, anim = 'anim@heists@narcotics@funding@gang_idle', 'gang_chatting_idle01' -- TODO better animations

            SetCurrentPedWeapon(PlayerPedId(), GetHashKey("WEAPON_UNARMED"), true)

            ESX.Streaming.RequestAnimDict(lib, function()
                TaskPlayAnim(PlayerPedId(), lib, anim, 8.0, -8.0, -1, 0, 0, false, false, false)
                
                while IsEntityPlayingAnim(PlayerPedId(), lib, anim, 3) do
                    Citizen.Wait(1)
                    --DisableAllControlActions(0)
                end
            end)
            
            if bandageType == 'bandage' then
                Citizen.SetTimeout(bandageTime, function()      
                    local victimPed = GetPlayerPed(GetPlayerFromServerId(playerId))
                    local ownPed = PlayerPedId()

                    if GetDistanceBetweenCoords(GetEntityCoords(victimPed, true), GetEntityCoords(ownPed, true), true) < 1.5 then
                        if not isUnconscious then
                            TriggerServerEvent('visn_are:addLog', GetPlayerServerId(PlayerId()), playerId, 'GIVE_BANDAGE_NORMAL_' ..  string.upper(bandageArea))
                            TriggerServerEvent('visn_are:sendBandage', playerId, bandageArea, 'BANDAGE_NORMAL')
                
                            ESX.TriggerServerCallback('visn_are:getBodyPartInfo', function(bodyPartInfoCB)
                                _sendNotification(_translate('bandage_applied', _translate('bandage')))
                                ClearPedTasks(PlayerPedId())
                                EnableGui(true, lastPlayerId)
                            end, playerId, "head")

                            ESX.TriggerServerCallback('visn_are:removeItem', function(result) end, bandageItem, 1)
                        else
                            _sendNotification(_translate("person_too_far_away"), "error", 3500)
                            EnableGui(false, lastPlayerId)
                        end
                    end
                end)
            end

            if bandageType == 'elasticBandage' then
                Citizen.SetTimeout(bandageTime, function()     
                    local victimPed = GetPlayerPed(GetPlayerFromServerId(playerId))
                    local ownPed = PlayerPedId()

                    if GetDistanceBetweenCoords(GetEntityCoords(victimPed, true), GetEntityCoords(ownPed, true), true) < 1.5 then
                        if not isUnconscious then
                            TriggerServerEvent('visn_are:addLog', GetPlayerServerId(PlayerId()), playerId, 'GIVE_BANDAGE_ELASTIC_' ..  string.upper(bandageArea))
                            TriggerServerEvent('visn_are:sendBandage', playerId, bandageArea, 'BANDAGE_ELASTIC')
                
                            ESX.TriggerServerCallback('visn_are:getBodyPartInfo', function(bodyPartInfoCB)
                                _sendNotification(_translate('bandage_applied', _translate('gauze_bandage')))
                                ClearPedTasks(PlayerPedId())
                                EnableGui(true, lastPlayerId)
                            end, playerId, "head")

                            ESX.TriggerServerCallback('visn_are:removeItem', function(result) end, bandageItem, 1)
                        else
                            _sendNotification(_translate("person_too_far_away"), "error", 3500)
                            EnableGui(false, lastPlayerId)
                        end
                    end
                end)
            end

            if bandageType == 'quickClot' then
                Citizen.SetTimeout(bandageTime, function()
                    local victimPed = GetPlayerPed(GetPlayerFromServerId(playerId))
                    local ownPed = PlayerPedId()

                    if GetDistanceBetweenCoords(GetEntityCoords(victimPed, true), GetEntityCoords(ownPed, true), true) < 1.5 then
                        if not isUnconscious then
                            TriggerServerEvent('visn_are:addLog', GetPlayerServerId(PlayerId()), playerId, 'GIVE_BANDAGE_QUICKCLOT_' ..  string.upper(bandageArea))
                            TriggerServerEvent('visn_are:sendBandage', playerId, bandageArea, 'BANDAGE_QUICKCLOT')
                
                            ESX.TriggerServerCallback('visn_are:getBodyPartInfo', function(bodyPartInfoCB)
                                _sendNotification(_translate('bandage_applied', _translate('quick_clot')))
                                ClearPedTasks(PlayerPedId())
                                EnableGui(true, lastPlayerId)
                            end, playerId, "head")

                            ESX.TriggerServerCallback('visn_are:removeItem', function(result) end, bandageItem, 1)
                        else
                            _sendNotification(_translate("person_too_far_away"), "error", 3500)
                            EnableGui(false, lastPlayerId)
                        end
                    end
                end)
            end

            if bandageType == 'packingBandage' then
                Citizen.SetTimeout(bandageTime, function()      
                    local victimPed = GetPlayerPed(GetPlayerFromServerId(playerId))
                    local ownPed = PlayerPedId()

                    if GetDistanceBetweenCoords(GetEntityCoords(victimPed, true), GetEntityCoords(ownPed, true), true) < 1.5 then
                        if not isUnconscious then
                            TriggerServerEvent('visn_are:addLog', GetPlayerServerId(PlayerId()), playerId, 'GIVE_BANDAGE_PACKING_' ..  string.upper(bandageArea))
                            TriggerServerEvent('visn_are:sendBandage', playerId, bandageArea, 'BANDAGE_PACKING')

                            ESX.TriggerServerCallback('visn_are:getBodyPartInfo', function(bodyPartInfoCB)
                                _sendNotification(_translate('bandage_applied', _translate('package_bandage')))
                                ClearPedTasks(PlayerPedId())
                                EnableGui(true, lastPlayerId)
                            end, playerId, "head")

                            ESX.TriggerServerCallback('visn_are:removeItem', function(result) end, bandageItem, 1)
                        else
                            _sendNotification(_translate("person_too_far_away"), "error", 3500)
                            EnableGui(false, lastPlayerId)
                        end
                    end
                end)
            end
        else
            _sendNotification(_translate("missing_item"), "error", 3500)
        end
    end, bandageItem)
end

function _useSurgicalKit(playerId, bandageArea)

    ESX.TriggerServerCallback('visn_are:getItemCount', function(itemCount)
        if itemCount > 0 then
            createProgressbar(_translate('sewing_wounds'), 7500, 0.08)

            local lib, anim = 'anim@heists@narcotics@funding@gang_idle', 'gang_chatting_idle01' -- TODO better animations

            SetCurrentPedWeapon(PlayerPedId(), GetHashKey("WEAPON_UNARMED"), true)

            ESX.Streaming.RequestAnimDict(lib, function()
                TaskPlayAnim(PlayerPedId(), lib, anim, 8.0, -8.0, -1, 2, 0, false, false, false)
                
                while IsEntityPlayingAnim(PlayerPedId(), lib, anim, 3) do
                    Citizen.Wait(1)
                    --DisableAllControlActions(0)
                end
            end)
            
            Citizen.SetTimeout(7500, function()     
                local victimPed = GetPlayerPed(GetPlayerFromServerId(playerId))
                local ownPed = PlayerPedId()

                if GetDistanceBetweenCoords(GetEntityCoords(victimPed, true), GetEntityCoords(ownPed, true), true) < 1.5 then
                    if not isUnconscious then
                        createObject("bkr_prop_meth_bigbag_04a", GetEntityCoords(PlayerPedId()).x, GetEntityCoords(PlayerPedId()).y, GetEntityCoords(PlayerPedId()).z - 0.95, GetEntityHeading(PlayerPedId()), 0.0)
                        
                        TriggerServerEvent('visn_are:addLog', GetPlayerServerId(PlayerId()), playerId, 'USE_SURGICAL_KIT_' ..  string.upper(bandageArea))
                        TriggerServerEvent('visn_are:sendSurgicalKit', playerId, bandageArea)

                        ESX.TriggerServerCallback('visn_are:getBodyPartInfo', function(bodyPartInfoCB)
                            _sendNotification(_translate('sewd_wounds'))
                            ClearPedTasks(PlayerPedId())
                            EnableGui(true, lastPlayerId)
                        end, playerId, "head")

                        ESX.TriggerServerCallback('visn_are:removeItem', function(result) end, 'surgical_kit', 1)
                    else
                        _sendNotification(_translate("person_too_far_away"), "error", 3500)
                        EnableGui(false, lastPlayerId)
                    end
                end
            end)
        end
    end, 'surgical_kit')
end

function _removeTourniquet(playerId, bodyPart)
    createProgressbar(_translate('removing_tourniquet'), 4500, 0.08)

    local lib, anim = 'anim@heists@narcotics@funding@gang_idle', 'gang_chatting_idle01' -- TODO better animations

    SetCurrentPedWeapon(PlayerPedId(), GetHashKey("WEAPON_UNARMED"), true)

    ESX.Streaming.RequestAnimDict(lib, function()
        TaskPlayAnim(PlayerPedId(), lib, anim, 8.0, -8.0, -1, 2, 0, false, false, false)
        
        while IsEntityPlayingAnim(PlayerPedId(), lib, anim, 3) do
            Citizen.Wait(1)
            --DisableAllControlActions(0)
        end
    end)
    
    Citizen.SetTimeout(4500, function()     
        local victimPed = GetPlayerPed(GetPlayerFromServerId(playerId))
        local ownPed = PlayerPedId()

        if GetDistanceBetweenCoords(GetEntityCoords(victimPed, true), GetEntityCoords(ownPed, true), true) < 1.5 then
            if not isUnconscious then
                TriggerServerEvent('visn_are:addLog', GetPlayerServerId(PlayerId()), playerId, 'REMOVE_TOURNIQUET_' ..  string.upper(bodyPart))
                TriggerServerEvent('visn_are:removeTourniquet', playerId, bodyPart)

                ESX.TriggerServerCallback('visn_are:getBodyPartInfo', function(bodyPartInfoCB)
                    _sendNotification(_translate('removed_tourniquet'))
                    ClearPedTasks(PlayerPedId())
                    EnableGui(true, lastPlayerId)
                end, playerId, "head")
            else
                _sendNotification(_translate("person_too_far_away"), "error", 3500)
                EnableGui(false, lastPlayerId)
            end
        end
    end)
end

function _useTourniquet(playerId, bodyPart)
    ESX.TriggerServerCallback('visn_are:getItemCount', function(itemCount)
        if itemCount > 0 then
            createProgressbar(_translate('applying_tourniquet'), 4500, 0.08)

            local lib, anim = 'anim@heists@narcotics@funding@gang_idle', 'gang_chatting_idle01' -- TODO better animations

            SetCurrentPedWeapon(PlayerPedId(), GetHashKey("WEAPON_UNARMED"), true)

            ESX.Streaming.RequestAnimDict(lib, function()
                TaskPlayAnim(PlayerPedId(), lib, anim, 8.0, -8.0, -1, 2, 0, false, false, false)
                
                while IsEntityPlayingAnim(PlayerPedId(), lib, anim, 3) do
                    Citizen.Wait(1)
                    --DisableAllControlActions(0)
                end
            end)
            
            Citizen.SetTimeout(4500, function()     
                local victimPed = GetPlayerPed(GetPlayerFromServerId(playerId))
                local ownPed = PlayerPedId()

                if GetDistanceBetweenCoords(GetEntityCoords(victimPed, true), GetEntityCoords(ownPed, true), true) < 1.5 then
                    if not isUnconscious then
                        TriggerServerEvent('visn_are:addLog', GetPlayerServerId(PlayerId()), playerId, 'USE_TOURNIQUET_' ..  string.upper(bodyPart))
                        TriggerServerEvent('visn_are:sendTourniquet', playerId, bodyPart)

                        ESX.TriggerServerCallback('visn_are:getBodyPartInfo', function(bodyPartInfoCB)
                            _sendNotification(_translate('applied_tourniquet'))
                            ClearPedTasks(PlayerPedId())
                            EnableGui(true, lastPlayerId)
                        end, playerId, "head")

                        ESX.TriggerServerCallback('visn_are:removeItem', function(result) end, 'surgical_kit', 1)
                    else
                        _sendNotification(_translate("person_too_far_away"), "error", 3500)
                        EnableGui(false, lastPlayerId)
                    end
                end
            end)
        end
    end, 'tourniquet')
end

function _useBodybag(playerId)

    ESX.TriggerServerCallback('visn_are:getItemCount', function(itemCount)
        if itemCount > 0 then
            createProgressbar(_translate('stow_in_body_bag'), 1000, 0.09)

            local lib, anim = 'anim@heists@narcotics@funding@gang_idle', 'gang_chatting_idle01' -- TODO better animations

            SetCurrentPedWeapon(PlayerPedId(), GetHashKey("WEAPON_UNARMED"), true)

            ESX.Streaming.RequestAnimDict(lib, function()
                TaskPlayAnim(PlayerPedId(), lib, anim, 8.0, -8.0, -1, 2, 0, false, false, false)
                
                while IsEntityPlayingAnim(PlayerPedId(), lib, anim, 3) do
                    Citizen.Wait(1)
                    --DisableAllControlActions(0)
                end
            end)
            
            Citizen.SetTimeout(1000, function()        
                local victimPed = GetPlayerPed(GetPlayerFromServerId(playerId))
                local ownPed = PlayerPedId()
            
                if GetDistanceBetweenCoords(GetEntityCoords(victimPed, true), GetEntityCoords(ownPed, true), true) < 2.5 then
                    if not isUnconscious then
                        TriggerServerEvent('visn_are:addLog', GetPlayerServerId(PlayerId()), playerId, 'USE_BODY_BAG')
                        TriggerServerEvent('visn_are:bodybag:triggerSync', playerId)
                
                        _sendNotification(_translate('person_stowed'))
                        ClearPedTasks(PlayerPedId())

                        ESX.TriggerServerCallback('visn_are:removeItem', function(result) end, 'bodybag', 1)
                    else
                        _sendNotification(_translate("person_too_far_away"), "error", 3500)
                        EnableGui(false, lastPlayerId)
                    end
                end

            end)
        end
    end, 'bodybag')
end

function _useCPR(playerId)

    createProgressbar(_translate("cpr_in_progress"), 30000, 0.08)
    doingCPR = true

    SetCurrentPedWeapon(PlayerPedId(), GetHashKey("WEAPON_UNARMED"), true)
    
    Citizen.SetTimeout(30000, function()        
        local victimPed = GetPlayerPed(GetPlayerFromServerId(playerId))
        local ownPed = PlayerPedId()
    
        if GetDistanceBetweenCoords(GetEntityCoords(victimPed, true), GetEntityCoords(ownPed, true), true) < 1.5 then
            if not isUnconscious then
                ESX.TriggerServerCallback('visn_are:getBodyPartInfo', function(bodyPartInfoCB)
                    doingCPR = false
                    TriggerServerEvent('visn_are:addLog', GetPlayerServerId(PlayerId()), playerId, 'USE_CPR')
                    TriggerServerEvent('visn_are:sendCPR', playerId)
            
                    _sendNotification(_translate("cpr_performed"))
                    ClearPedTasks(PlayerPedId())
                    EnableGui(true, lastPlayerId)
                end, playerId, "head")
            else
                _sendNotification(_translate("person_too_far_away"), "error", 3500)
                EnableGui(false, lastPlayerId)
            end
        end
    end)
end

function _usePainkillers(playerId)

    ESX.TriggerServerCallback('visn_are:getItemCount', function(itemCount)
        if itemCount > 0 then
            createProgressbar(_translate('giving_painkillers'), 5000, 0.08)

            SetCurrentPedWeapon(PlayerPedId(), GetHashKey("WEAPON_UNARMED"), true)
            
            local lib, anim = 'anim@heists@narcotics@funding@gang_idle', 'gang_chatting_idle01' -- TODO better animations

            ESX.Streaming.RequestAnimDict(lib, function()
                TaskPlayAnim(PlayerPedId(), lib, anim, 8.0, -8.0, -1, 2, 0, false, false, false)
                
                while IsEntityPlayingAnim(PlayerPedId(), lib, anim, 3) do
                    Citizen.Wait(1)
                    --DisableAllControlActions(0)
                end
            end)

            Citizen.SetTimeout(5000, function()        
                local victimPed = GetPlayerPed(GetPlayerFromServerId(playerId))
                local ownPed = PlayerPedId()
            
                if GetDistanceBetweenCoords(GetEntityCoords(victimPed, true), GetEntityCoords(ownPed, true), true) < 1.5 then
                    ESX.TriggerServerCallback('visn_are:getBodyPartInfo', function(bodyPartInfoCB)
                        TriggerServerEvent('visn_are:addLog', GetPlayerServerId(PlayerId()), playerId, 'USE_PAINKILLERS')
                        TriggerServerEvent('visn_are:sendPainkillers', playerId)
                
                        _sendNotification(_translate('given_painkillers'))
                        ClearPedTasks(PlayerPedId())
                        EnableGui(true, lastPlayerId)

                        ESX.TriggerServerCallback('visn_are:removeItem', function(result) end, 'painkillers', 1)
                    end, playerId, "head")
                else
                    _sendNotification(_translate("person_too_far_away"), "error", 3500)
                    EnableGui(false, lastPlayerId)
                end
            end)
        end
    end, 'painkillers')
end

function _useDefibrilator(playerId)
    ESX.TriggerServerCallback('visn_are:getItemCount', function(itemCount)
        if itemCount > 0 then
            createProgressbar(_translate('defibrillator_being_used'), 7500, 0.09)

            local lib, anim = 'anim@heists@narcotics@funding@gang_idle', 'gang_chatting_idle01' -- TODO better animations

            SetCurrentPedWeapon(PlayerPedId(), GetHashKey("WEAPON_UNARMED"), true)

            ESX.Streaming.RequestAnimDict(lib, function()
                TaskPlayAnim(PlayerPedId(), lib, anim, 8.0, -8.0, -1, 2, 0, false, false, false)
                
                while IsEntityPlayingAnim(PlayerPedId(), lib, anim, 3) do
                    Citizen.Wait(1)
                    --DisableAllControlActions(0)
                end
            end)

            SetCurrentPedWeapon(PlayerPedId(), GetHashKey("WEAPON_UNARMED"), true)
            TriggerServerEvent('InteractSound_SV_M:PlayWithinDistance', 5.0, 'defi-1', 0.5)

            Citizen.SetTimeout(7500, function()

                local victimPed = GetPlayerPed(GetPlayerFromServerId(playerId))
                local ownPed = PlayerPedId()
            
                if GetDistanceBetweenCoords(GetEntityCoords(victimPed, true), GetEntityCoords(ownPed, true), true) < 1.5 then
                    if not isUnconscious then
                        ESX.TriggerServerCallback('visn_are:getBodyPartInfo', function(bodyPartInfoCB)
                            TriggerServerEvent('visn_are:addLog', GetPlayerServerId(PlayerId()), playerId, 'USE_DEFIBRILATOR')
                            TriggerServerEvent('InteractSound_SV_M:PlayWithinDistance', 5.0, 'defi-2', 0.5)
                            TriggerServerEvent('visn_are:sendDefibrilator', playerId)
                    
                            _sendNotification(_translate('defibrillator_used'))
                            ClearPedTasks(PlayerPedId())
                            EnableGui(true, lastPlayerId)
                        end, playerId, "head")
                    else
                        --_sendNotification(_translate("person_too_far_away"), "error", 3500)
                        EnableGui(false, lastPlayerId)
                    end
                end
            end)
        end
    end, 'defibrilator')
end

function _useLiquid(playerId, liquidType, bodyPart)

    ESX.TriggerServerCallback('visn_are:getItemCount', function(itemCount)
        if itemCount > 0 then
            createProgressbar(_translate('injecting_liquid'), 2500, 0.07)

            local lib, anim = 'anim@heists@narcotics@funding@gang_idle', 'gang_chatting_idle01' -- TODO better animations

            SetCurrentPedWeapon(PlayerPedId(), GetHashKey("WEAPON_UNARMED"), true)

            ESX.Streaming.RequestAnimDict(lib, function()
                TaskPlayAnim(PlayerPedId(), lib, anim, 8.0, -8.0, -1, 2, 0, false, false, false)
                
                while IsEntityPlayingAnim(PlayerPedId(), lib, anim, 3) do
                    Citizen.Wait(1)
                    --DisableAllControlActions(0)
                end
            end)

            SetCurrentPedWeapon(PlayerPedId(), GetHashKey("WEAPON_UNARMED"), true)

            Citizen.SetTimeout(2500, function()        
                local victimPed = GetPlayerPed(GetPlayerFromServerId(playerId))
                local ownPed = PlayerPedId()
            
                if GetDistanceBetweenCoords(GetEntityCoords(victimPed, true), GetEntityCoords(ownPed, true), true) < 1.5 then
                    if not isUnconscious then
                        ESX.TriggerServerCallback('visn_are:getBodyPartInfo', function(bodyPartInfoCB)
                            TriggerServerEvent('visn_are:addLog', GetPlayerServerId(PlayerId()), playerId, 'GIVE_' .. string.upper(liquidType) .. '_' .. string.upper(bodyPart))
                            TriggerServerEvent('visn_are:sendLiquid', playerId, liquidType, bodyPart)
                    
                            _sendNotification(_translate('liquid_injected'))
                            ClearPedTasks(PlayerPedId())
                            EnableGui(true, lastPlayerId)

                            ESX.TriggerServerCallback('visn_are:removeItem', function(result) end, liquidType, 1)
                        end, playerId, "head")

                        if liquidType == 'atropine' then
                            createObject("bkr_prop_meth_bigbag_01a", GetEntityCoords(PlayerPedId()).x, GetEntityCoords(PlayerPedId()).y, GetEntityCoords(PlayerPedId()).z - 1.02, GetEntityHeading(PlayerPedId()), 0.0)
                        end

                        if liquidType == 'epinephrin' then
                            createObject("bkr_prop_meth_bigbag_02a", GetEntityCoords(PlayerPedId()).x, GetEntityCoords(PlayerPedId()).y, GetEntityCoords(PlayerPedId()).z - 0.97, GetEntityHeading(PlayerPedId()), 0.0)
                        end

                        if liquidType == 'morphin' then
                            createObject("bkr_prop_meth_bigbag_03a", GetEntityCoords(PlayerPedId()).x, GetEntityCoords(PlayerPedId()).y, GetEntityCoords(PlayerPedId()).z - 0.98, GetEntityHeading(PlayerPedId()), 0.0)
                        end
                    else
                        --_sendNotification(_translate("person_too_far_away"), "error", 3500)
                        EnableGui(false, lastPlayerId)
                    end
                end
            end)
        end
    end, liquidType)
end

function _giveInfusion(playerId, infusionType, infusionAmount)
    ESX.TriggerServerCallback('visn_are:getItemCount', function(itemCount)
        if itemCount > 0 then
            createProgressbar(_translate("giving_infusion"), 5000, 0.08)

            local lib, anim = 'anim@heists@narcotics@funding@gang_idle', 'gang_chatting_idle01' -- TODO better animations

            SetCurrentPedWeapon(PlayerPedId(), GetHashKey("WEAPON_UNARMED"), true)

            ESX.Streaming.RequestAnimDict(lib, function()
                TaskPlayAnim(PlayerPedId(), lib, anim, 8.0, -8.0, -1, 2, 0, false, false, false)
                
                while IsEntityPlayingAnim(PlayerPedId(), lib, anim, 3) do
                    Citizen.Wait(1)
                    --DisableAllControlActions(0)
                end
            end)

            SetCurrentPedWeapon(PlayerPedId(), GetHashKey("WEAPON_UNARMED"), true)

            Citizen.SetTimeout(5000, function()
                local victimPed = GetPlayerPed(GetPlayerFromServerId(playerId))
                local ownPed = PlayerPedId()
            
                if GetDistanceBetweenCoords(GetEntityCoords(victimPed, true), GetEntityCoords(ownPed, true), true) < 1.5 then
                    if not isUnconscious then
                        ESX.TriggerServerCallback('visn_are:getBodyPartInfo', function(bodyPartInfoCB)
                            TriggerServerEvent('visn_are:addLog', GetPlayerServerId(PlayerId()), playerId, 'GIVE_INFUSION_' .. string.upper(infusionType) .. "_" .. infusionAmount)
                            TriggerServerEvent('visn_are:sendInfusion', lastPlayerId, infusionType, infusionAmount)
                    
                            _sendNotification(_translate("infusion_given"))
                            ClearPedTasks(PlayerPedId())
                            EnableGui(true, lastPlayerId)

                            ESX.TriggerServerCallback('visn_are:removeItem', function(result) end, infusionType .. '_' .. infusionAmount, 1)
                        end, playerId, "head")
                    else
                        _sendNotification(_translate("person_too_far_away"), "error", 3500)
                        EnableGui(false, lastPlayerId)
                    end
                end
            end)
        end
    end, infusionType .. '_' .. infusionAmount)
end


function _getBloodPressure()
    local _cardiacOutput = _getCardiacOutput()
    local _resistance = peripheralResistance
    local _bloodPressure = _cardiacOutput * _resistance

    return round(_bloodPressure * MODIFIER_BP_LOW), round(_bloodPressure * MODIFIER_BP_HIGH)
end

function _getCardiacOutput()
    local heartRate = currentPulse
    local bloodVolumeRatio = bloodLevel / 6.0

    local _entering = linearConversion(0.5, 1, bloodVolumeRatio, 0, 1)
    local _cardiacOutput = (_entering * VENTRICLE_STROKE_VOL) * heartRate / 60;

    return math.max(0, _cardiacOutput)
end

function _updateWoundBloodLoss()
    local _defaultTable = {0, 0, 0, 0, 0, 0}
    local _bodyPartBleeding = {
        ["head"] = 0,
        ["left_arm"] = 0,
        ["right_arm"] = 0,
        ["torso"] = 0,
        ["left_leg"] = 0,
        ["right_leg"] = 0
    }
    
    local count = 1

    for key, value in pairsByKeys(bloodAreas) do
        if value > 0 and not appliedTourniquets[key] then
            _bodyPartBleeding[key] = _bodyPartBleeding[key] + (value)
        end

        count = count + 1
    end

    if not do_tables_match(_bodyPartBleeding, _defaultTable) then
        local _headBleeding = _bodyPartBleeding["head"] 
        local _bodyBleeding = _bodyPartBleeding["torso"]
        local _leftLegBleeding = _bodyPartBleeding["left_leg"]
        local _rightLegBleeding = _bodyPartBleeding["right_leg"]
        local _leftArmBleeding = _bodyPartBleeding["left_arm"] 
        local _rightArmBleeding = _bodyPartBleeding["right_arm"]

        local _bodyBleedingRate = math.min(((math.min(0.9, _headBleeding / 0.5) + (math.min(1.0, _bodyBleeding / 0.5)))), 1.0)
        local _limbBleedingRate = math.min(((math.min(0.3, _leftArmBleeding / 0.5)) + (math.min(0.3, _rightArmBleeding / 0.5)) + (math.min(0.5, _leftLegBleeding / 0.5)) + (math.min(0.5, _rightLegBleeding / 0.5))), 1.0)

        local _limbBleedingRate = _limbBleedingRate * (1 - _bodyBleedingRate)

        if currentPulse > 0 then
            bleedValue = ((_bodyBleedingRate + _limbBleedingRate) / peripheralResistance * 10 / 3) * (currentPulse / 27)
        else
            bleedValue = ((_bodyBleedingRate + _limbBleedingRate) / peripheralResistance * 10 / 3)
        end

        if isUnconscious then
            bleedValue = (bleedValue * (math.max(_getCardiacOutput(), 0.05) * 30))
        else
            bleedValue = (bleedValue * (math.max(_getCardiacOutput(), 0.05) * 2))
        end
    end  
end

parseConfigForInjuries()









-- REWRITE

local class1Hemorrhage = 6.0
local class2Hemorrhage = 5.1
local class3Hemorrhage = 4.2
local class4Hemorrhage = 2.6
local fatalHemorrhage = 2
local nextCheckCriticalPulse = 0

function handleVitals()
    local time = GetGameTimer()
    local bloodVolume = bloodLevel
    local hemorrage = 0
    local inPain = painFactor > 0

    if bloodVolume < fatalHemorrhage then
        hemorrage = 5
    elseif bloodVolume < class4Hemorrhage then
        hemorrage = 4
    elseif bloodVolume < class3Hemorrhage then
        hemorrage = 3
    elseif bloodVolume < class2Hemorrhage then
        hemorrage = 2
    elseif bloodVolume < class1Hemorrhage then
        hemorrage = 1
    end

    local tourniquetPain = 0
    for key, value in pairs(appliedTourniquets) do
        if time - value > 60000 then
            tourniquetPain = tourniquetPain + 1
            appliedTourniquets[key] = GetGameTimer()
        end
    end

    increasePain(tourniquetPain)

    if hemorrage == 5 and currentPulse > 3 then
        setUnconscious(true, math.random(0, 3))
        return
    end

    if hemorrage == 4 and currentPulse > 23 then
        setUnconscious(true, math.random(1, 23))
        return
    end

    if currentPulse < 20 or currentPulse > 220 then
        if not isUnconscious then
            setUnconscious(true, math.random(1, 23))
            return
        end
    end

    if (bloodPressureH < 50 or bloodPressureL < 40 or currentPulse < 40) and not isUnconscious then
        setUnconscious(true, math.random(1, 39))
        return
    end

    if bloodPressureL >= 190 then
        setUnconscious(true, math.random(0, 2))
        return
    end

    if currentPulse < 30 and not cardiacDecided then
        local enterCardiacArrest = false

        if time >= nextCheckCriticalPulse then
            enterCardiacArrest = math.random(0, 1) < (0.4 + 0.6 *(30 - currentPulse) / 10)
        end

        if enterCardiacArrest then
            setUnconscious(true, math.random(0, 3))
        else
            setUnconscious(true, math.random(21, 30))
            nextCheckCriticalPulse = GetGameTimer() + 1000
        end
        
        cardiacDecided = true
        return
    end
end
























---------------------------------------------------

keySet = {
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

local bag_model = "xm_prop_body_bag"
local bag_hash = "xm_prop_body_bag"

local bodyBag = nil
local attached = false

function PutInBodybag()
    local playerPed = PlayerPedId()
    local playerCoords = GetEntityCoords(playerPed)

    if isUnconscious and not attached then
        SetEntityVisible(playerPed, false, false)
        
        RequestModel(bag_model)
        while not HasModelLoaded(bag_model) do
            Citizen.Wait(1)
        end

        bodyBag = CreateObject(GetHashKey(bag_hash), playerCoords.x, playerCoords.y, playerCoords.z, true, true, true)

        AttachEntityToEntity(bodyBag, playerPed, 0, -0.2, 0.75, -0.1, 0.0, 0.0, 0.0, false, false, false, false, 20, false)
        attached = true
        inBodybag = true
    end
end

RegisterNetEvent('visn_are:bodybag:putInBag')
AddEventHandler('visn_are:bodybag:putInBag', PutInBodybag)

function do_tables_match( a, b )
    return table.concat(a) == table.concat(b)
end

resetAreas()


-- THREADING

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)

        RequestAnimDict("mini@cpr@char_b@cpr_def")
        while not HasAnimDictLoaded("mini@cpr@char_b@cpr_def") do
            Citizen.Wait(10)
        end

        if guiEnabled then
            local active = true
            
            DisableControlAction(0, 1, active)-- LookLeftRight
            DisableControlAction(0, 2, active)-- LookUpDown
            DisablePlayerFiring(playerPed, true)-- Disable weapon firing
            DisableControlAction(0, 142, active)-- MeleeAttackAlternate
            DisableControlAction(0, 106, active)-- VehicleMouseControlOverride
            if IsDisabledControlJustReleased(0, 142) then -- MeleeAttackAlternate
                SendNUIMessage({type = "click"})
            end
            
            if isUnconscious then
                EnableGui(false, lastPlayerId)
            end
        end
        
        if progressTimer > 0 then
            if isUnconscious then
                progressTimer = 0
                progressText = ""
                isBusy = false
            end
            
            if not HasStreamedTextureDictLoaded('timerbars') then
                RequestStreamedTextureDict('timerbars')
                while not HasStreamedTextureDictLoaded('timerbars') do
                    Citizen.Wait(1)
                end
            end
            
            if GetTimeDifference(GetGameTimer(), timer) < progressTimer then
                W = (GetTimeDifference(GetGameTimer(), timer) * (0.085 / progressTimer))
            end
            
            local correction = ((1.0 - round(GetSafeZoneSize(), 2)) * 100) * 0.005
            X, Y = 0.9350 - correction, 0.99 - correction
            
            Set_2dLayer(0)
            DrawSprite('timerbars', 'all_black_bg', X, Y, 0.15, 0.0325, 0.0, 255, 255, 255, 180)
            
            Set_2dLayer(1)
            DrawRect(X + 0.0275, Y, 0.085, 0.0095, 143, 95, 13, 180)
            
            Set_2dLayer(2)
            DrawRect(X - 0.015 + (W / 2), Y, W, 0.0095, 255, 162, 0, 180)
            
            SetTextColour(255, 255, 255, 180)
            SetTextFont(0)
            SetTextScale(0.3, 0.3)
            SetTextCentre(true)
            SetTextEntry('STRING')
            AddTextComponentString(progressText)
            Set_2dLayer(3)
            DrawText(X - xFactor, Y - 0.012)
            isBusy = true
            
            if W >= 0.0809 then
                progressTimer = 0
                progressText = ""
                isBusy = false
            end
        end
        
        if isUnconscious then
            DisableControlAction(0, 24, true) -- Attack
            DisableControlAction(0, 257, true) -- Attack 2
            DisableControlAction(0, 25, true) -- Aim
            DisableControlAction(0, 263, true) -- Melee Attack 1
            
            DisableControlAction(0, Keys['R'], true) -- Reload
            DisableControlAction(0, Keys['SPACE'], true) -- Jump
            DisableControlAction(0, Keys['Q'], true) -- Cover
            DisableControlAction(0, Keys['TAB'], true) -- Select Weapon
            DisableControlAction(0, Keys['F'], true) -- Also 'enter'?

            DisableControlAction(0, Keys['F1'], true) -- Disable phone
            DisableControlAction(0, Keys['F2'], true) -- Inventory
            DisableControlAction(0, Keys['F3'], true) -- Animations
            DisableControlAction(0, Keys['F6'], true) -- Job

            DisableControlAction(0, Keys['V'], true) -- Disable changing view
            DisableControlAction(0, Keys['C'], true) -- Disable looking behind
            DisableControlAction(0, Keys['X'], true) -- Disable clearing animation
            DisableControlAction(2, Keys['P'], true) -- Disable pause screen

            DisableControlAction(0, 59, true) -- Disable steering in vehicle
            DisableControlAction(0, 71, true) -- Disable driving forward in vehicle
            DisableControlAction(0, 72, true) -- Disable reversing in vehicle

            DisableControlAction(2, Keys['LEFTCTRL'], true) -- Disable going stealth
            DisableControlAction(2, Keys['CAPS'], true) -- Disable going stealth

            DisableControlAction(0, 47, true)  -- Disable weapon
            DisableControlAction(0, 264, true) -- Disable melee
            DisableControlAction(0, 257, true) -- Disable melee
            DisableControlAction(0, 140, true) -- Disable melee
            DisableControlAction(0, 249, true) -- Disable melee
            DisableControlAction(0, 141, true) -- Disable melee
            DisableControlAction(0, 142, true) -- Disable melee
            DisableControlAction(0, 143, true) -- Disable melee
            DisableControlAction(0, 75, true)  -- Disable exit vehicle
            DisableControlAction(27, 75, true) -- Disable exit vehicle

            if carryingBackInProgress then 
                while not IsEntityPlayingAnim(GetPlayerPed(-1), carryAnimDictPlaying, carryAnimNamePlaying, 3) do
                    TaskPlayAnim(GetPlayerPed(-1), carryAnimDictPlaying, carryAnimNamePlaying, 8.0, -8.0, 100000, carryControlFlagPlaying, 0, false, false, false)
                    Citizen.Wait(0)
                end
            end

            if not carryingBackInProgress then
                if GetVehiclePedIsTryingToEnter(PlayerPedId()) == 0 and not IsPedSittingInAnyVehicle(PlayerPedId()) then
                    while not IsEntityPlayingAnim(GetPlayerPed(-1), "mini@cpr@char_b@cpr_def", "cpr_pumpchest_idle", 3) do
                        TaskPlayAnim(GetPlayerPed(-1), "mini@cpr@char_b@cpr_def", "cpr_pumpchest_idle", 8.0, -8.0, 100000, 1, 0, false, false, false)
                        Citizen.Wait(0)
                    end
                end
            end

            if IsPedSittingInAnyVehicle(PlayerPedId()) and not kickedOutVehicle then
                TaskLeaveVehicle(PlayerPedId(), GetVehiclePedIsIn(PlayerPedId(), false), 16)
            end
        end

        if carryingBackInProgress then
			DisableControlAction(0, 24, true) -- Attack
			DisableControlAction(0, 257, true) -- Attack 2
			DisableControlAction(0, 25, true) -- Aim
            DisableControlAction(0, 263, true) -- Melee Attack 1
            
			DisableControlAction(0, Keys['R'], true) -- Reload
			DisableControlAction(0, Keys['SPACE'], true) -- Jump
			DisableControlAction(0, Keys['Q'], true) -- Cover
			DisableControlAction(0, Keys['TAB'], true) -- Select Weapon
			DisableControlAction(0, Keys['F'], true) -- Also 'enter'?

			DisableControlAction(0, Keys['F1'], true) -- Disable phone
			DisableControlAction(0, Keys['F2'], true) -- Inventory
			DisableControlAction(0, Keys['F3'], true) -- Animations
			DisableControlAction(0, Keys['F6'], true) -- Job

			DisableControlAction(0, Keys['V'], true) -- Disable changing view
			DisableControlAction(0, Keys['C'], true) -- Disable looking behind
			DisableControlAction(2, Keys['P'], true) -- Disable pause screen

			DisableControlAction(0, 59, true) -- Disable steering in vehicle
			DisableControlAction(0, 71, true) -- Disable driving forward in vehicle
			DisableControlAction(0, 72, true) -- Disable reversing in vehicle

			DisableControlAction(2, Keys['LEFTCTRL'], true) -- Disable going stealth

			DisableControlAction(0, 47, true)  -- Disable weapon
			DisableControlAction(0, 264, true) -- Disable melee
			DisableControlAction(0, 257, true) -- Disable melee
			DisableControlAction(0, 140, true) -- Disable melee
			DisableControlAction(0, 141, true) -- Disable melee
			DisableControlAction(0, 21, true) -- Disable melee
			DisableControlAction(0, 142, true) -- Disable melee
			DisableControlAction(0, 143, true) -- Disable melee
			DisableControlAction(0, 75, true)  -- Disable exit vehicle
            DisableControlAction(27, 75, true) -- Disable exit vehicle
        end

        if IsDisabledControlJustPressed(0, 47) then
            if isUnconscious then
                if cooldownTimer == 0 then
                    local PedPosition = GetEntityCoords(PlayerPedId())
                    
                    TriggerServerEvent('esx_addons_gcphone:startCall', "ambulance", _translate("phone_call_text"), {
                        x = PedPosition.x,
                        y = PedPosition.y,
                        z = PedPosition.z
                    })
                    SendNUIMessage({
                        type = 'informedEMS',
                        state = false,
                    })

                    cooldownTimer = cooldownTimer + 300

                    _sendNotification(_translate("distress_call_sent"), "info")
                end
            end
        end
        
        if isBusy then
            --DisableAllControlActions(0)
        end
        
        if not isUnconscious then
            if (not IsControlPressed(0, ConfigData.modifierKey) and not IsControlPressed(0, 21)) and IsControlJustPressed(0, ConfigData.mainKey) then
                if (not IsPedSittingInAnyVehicle(GetPlayerPed(-1))) then
                    EnableGui(true, GetPlayerServerId(PlayerId()))
                    _sendNotification(_translate("open_health_menu_self"), "info", 200)
                end
            end
            
            if IsControlJustPressed(0, 73) then
                if carryingBackInProgress then
                    local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()    

                    if closestPlayer ~= -1 and closestDistance < 3.0 then
                        TriggerServerEvent("visn_are:stopCarry", GetPlayerServerId(closestPlayer))
                    end
                end
            end
            
            if IsControlPressed(0, ConfigData.modifierKey) and IsControlJustPressed(0, ConfigData.mainKey) then
                if (not IsPedSittingInAnyVehicle(GetPlayerPed(-1))) then
                    for _, player in ipairs(GetActivePlayers()) do
                        if GetPlayerPed(player) ~= PlayerPedId() then
                            local distance = GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), GetEntityCoords(GetPlayerPed(player), true))
                            if distance ~= -1 and distance <= 2.5 then
                                EnableGui(true, GetPlayerServerId(player))
                                _sendNotification(_translate("open_health_menu_other"), "info", 200)
                            end
                        end
                    end
                end
            end
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1)
        
        if isBleedingF() then
            if bloodLevel < 0 then
                bloodLevel = 0
            end
            
            local damaged = 0
            local loseMultiplier = 1
            
            for index, value in pairsByKeys(damagedAreas) do
                if value >= 1 then
                    damaged = damaged + 1
                end
                
                if value > 1 then
                    loseMultiplier = loseMultiplier + 0.25
                end
            end
            
            randomLose = damaged * loseMultiplier / 100
            
            Citizen.Wait(10000)
            _updateWoundBloodLoss()
            bloodLevel = bloodLevel - bleedValue

            if bloodLevel <= 0 then
                if isUnconscious then
                    TriggerEvent('esx_ambulancejob:forceRespawn')

                    SendNUIMessage({
                        type = 'checkU',
                        enable = false
                    })

                    bloodLevel = 6.0
                    isBleeding = false
                    cardiacDecided = false
                    isUnconscious = false
                    kickedOutVehicle = false
                    isLaying = false

                    peripheralResistance = 100
                    isFeelingPain = false

                    _bloodPressure = 1 * peripheralResistance;

                    painFactor = 0

                    currentPulse = 80
                    increasePulseRate = 0
                    increasePulseTimer = 0

                    doingCPR = false
                    doingCPRTarget = 0

                    hasCardiacArrest = false

                    decreasePulseRate = 0
                    decreasePulseTimer = 0
                    forceUnconscious = false

                    recievingBloodInfusion = 0
                    
                    cooldownTimer = 0
                    painTimer = 0

                    isBusy = false
                    
                    bleedValue = 0
                    
                    resetAreas()

                    SendNUIMessage({
                        type = 'deactivatePainEffect'
                    })

                    TriggerServerEvent('visn_are:SetDeathStatus', isUnconscious)
                    SetEntityInvincible(PlayerPedId(), false)
                    
                    SetCanAttackFriendly(PlayerPedId(), true, true)
                    SetPedCanBeTargetted(PlayerPedId(), true)
                    SetPedConfigFlag(62, false)
                    SetPedConfigFlag(60, true)
                    SetPedRagdollOnCollision(PlayerPedId(), true)
                    SetPedConfigFlag(61, true)
                    SetPedConfigFlag(104, true)
                end
            end
            
            if ConfigData.enableBloodDrops and not IsPedSittingInAnyVehicle(PlayerPedId()) then
                unusedBool, spawnZ = GetGroundZFor_3dCoord(GetEntityCoords(PlayerPedId()).x + math.random(0, 1) / 4, GetEntityCoords(PlayerPedId()).y + math.random(0, 1) / 4, 99999.0, 1)

                createObject("p_bloodsplat_s", GetEntityCoords(PlayerPedId()).x + math.random(0, 1) / 4, GetEntityCoords(PlayerPedId()).y + math.random(0, 1) / 4, spawnZ - 0.265, 0.0, 0.0)
            end
        end
    end
end)

function setUnconscious(state, targetPulse)
    if not isUnconscious then
        isUnconscious = state

        SendNUIMessage({
            type = 'checkU',
            enable = state
        })
        
        SendNUIMessage({
            type = 'resetTimer',
        })
        
        if state then
            SendNUIMessage({
                type = 'setTimer',
                time = ConfigData.respawnTimer,
            })
        else
            SendNUIMessage({
                type = 'setTimer',
                time = 0,
            })
        end

        currentPulse = targetPulse

        SetEntityInvincible(PlayerPedId(), isUnconscious)
        TriggerServerEvent('esx_ambulancejob:setDeathStatus', isUnconscious)
        TriggerServerEvent('visn_are:SetDeathStatus', isUnconscious)

        SetPedCanTorsoReactIk(PlayerPedId(), false)
        SetPedConfigFlag(60, false)
        SetPedConfigFlag(62, true)
        SetPedConfigFlag(61, false)
        SetPedConfigFlag(104, false)
        SetPedRagdollOnCollision(PlayerPedId(), false)
        SetPedCanBeTargetted(PlayerPedId(), false)
        SetCanAttackFriendly(PlayerPedId(), false, false)

        SendNUIMessage({
            type = 'deactivatePainEffect'
        })
        
        cardiacDecided = false
    end
end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1)
        
        local playerPed = PlayerPedId()

        if ConfigData.activateLimpWalkingStyle then
            if damagedAreas["left_leg"] > 0 or damagedAreas["right_leg"] > 0 then
                RequestAnimSet("move_m@injured")
                SetPedMovementClipset(GetPlayerPed(-1), "move_m@injured", true)
                isLimpWalkingStyle = true
            elseif damagedAreas["left_leg"] == 0 and damagedAreas["right_leg"] == 0 and isLimpWalkingStyle then
                ResetPedMovementClipset(GetPlayerPed(-1))
                ResetPedWeaponMovementClipset(GetPlayerPed(-1))
                ResetPedStrafeClipset(GetPlayerPed(-1))
            end
        end
        
		if bloodLevel > 2.5 and currentPulse > 55 then
            if isUnconscious then
                if ConfigData.recoveryAnimation then
                    local lib = 'anim@heists@fleeca_bank@ig_7_jetski_owner'
                    local anim = 'owner_idle'
                    
                    ESX.Streaming.RequestAnimDict(lib, function()
                        TaskPlayAnim(PlayerPedId(), lib, anim, 8.0, -8.0, -1, 9, 0, false, false, false)
                        
                        while IsEntityPlayingAnim(PlayerPedId(), lib, anim, 3) do
                            Citizen.Wait(1)
                            --DisableAllControlActions(0)
                        end
                    end)
                end
				
                SendNUIMessage({
                    type = 'checkU',
                    enable = false
                })
                
                SendNUIMessage({
                    type = 'setTimer',
                    time = 1,
                })
            
                SetEntityInvincible(PlayerPedId(), false)
                TriggerServerEvent('esx_ambulancejob:setDeathStatus', false)
                TriggerServerEvent('visn_are:SetDeathStatus', false)
        
                StopScreenEffect('DeathFailOut')

                SetPedConfigFlag(62, false)
                SetPedConfigFlag(60, true)
                SetPedRagdollOnCollision(PlayerPedId(), true)
                SetPedConfigFlag(61, true)
                SetPedConfigFlag(104, true)
                SetPedCanBeTargetted(PlayerPedId(), true)
                SetCanAttackFriendly(PlayerPedId(), true, true)

                cardiacDecided = false
                isUnconscious = false
                kickedOutVehicle = false
                forceUnconscious = false 
            end
        end
        
        local lowPressure, highPressure = _getBloodPressure()
        
        bloodPressureH = highPressure
        bloodPressureL = lowPressure

        
        if bloodAreas["head"] > 0 or bloodAreas["left_arm"] > 0 or bloodAreas["right_arm"] > 0 or bloodAreas["torso"] > 0 or bloodAreas["left_leg"] > 0 or bloodAreas["right_leg"] > 0 then
            isBleeding = true
        elseif bloodAreas["head"] == 0 and bloodAreas["left_arm"] == 0 and bloodAreas["right_arm"] == 0 and bloodAreas["torso"] == 0 and bloodAreas["left_leg"] == 0 and bloodAreas["right_leg"] == 0 then
            isBleeding = false
        end
        
        if increasePulseTimer > 0 then
            currentPulse = currentPulse + increasePulseRate
            increasePulseTimer = increasePulseTimer - 1
            
            if currentPulse < 0 then
                currentPulse = 0
            end
            
            if increasePulseTimer < 0 then
                increasePulseTimer = 0
            end
        end
        
        if decreasePulseTimer >= 1 then
            currentPulse = currentPulse - decreasePulseRate
            decreasePulseTimer = decreasePulseTimer - 1
            
            if currentPulse < 0 then
                currentPulse = 0
            end

            if decreasePulseTimer < 0 then
                decreasePulseTimer = 0
            end
        end
        
        if recievingBloodInfusion > 0 then
            local randomValue = 4.1667

            bloodLevel = bloodLevel + (4.1667 / 1000)
            recievingBloodInfusion = recievingBloodInfusion - randomValue
            recievingBloodInfusion = round(recievingBloodInfusion)
        end

        if cooldownTimer > 0 then
            cooldownTimer = cooldownTimer - 1

            if cooldownTimer == 0 then
                SendNUIMessage({
                    type = 'informedEMS',
                    state = true,
                })
            end
        end

        if painTimer > 0 then
            local savedPain = painTimer
            painTimer = painTimer - 1

            if painTimer == 0 and savedPain ~= 0 then
                decreasePain(5)
            end
        end

        if cooldownTimer < 0 then
            cooldownTimer = 0
        end

        if not isUnconscious and attached then
            DetachEntity(playerPed, true, false)
            SetEntityVisible(playerPed, true, true)

            SetEntityAsMissionEntity(bodyBag, false, false)
            SetEntityVisible(bodybag, false)
            SetModelAsNoLongerNeeded(bodyBag)
            
            TriggerServerEvent('visn_are:sendAlpha', 255)

            DeleteObject(bodyBag)
            DeleteEntity(bodyBag)

            bodyBag = nil
            attached = false
            inBodybag = false
        end
        
        SendNUIMessage({
            type = 'bloodEffect',
            state = isBleedingF()
        })

        local canHeal = true

        TriggerEvent('esx_status:getStatus', 'hunger', function(status)
            if status.val == 0 then
                canHeal = false
            end
        end)

        TriggerEvent('esx_status:getStatus', 'thirst', function(status)
            if status.val == 0 then
                canHeal = false
            end
        end)

        if not ConfigData.bindPulseToHealthBar then
            if currentPulse == 80 and GetEntityHealth(PlayerPedId()) ~= GetEntityMaxHealth(PlayerPedId()) and canHeal then
                SetEntityHealth(PlayerPedId(), GetEntityHealth(PlayerPedId()) + 1)
            end
        end

        handleVitals()
        Citizen.Wait(1000)
    end
end)

Citizen.CreateThread(function()
    while true do
        if doingCPR then
            ESX.Streaming.RequestAnimDict("mini@cpr@char_a@cpr_str", function()
                TaskPlayAnim(PlayerPedId(), "mini@cpr@char_a@cpr_str", "cpr_pumpchest", 8.0, -8.0, -1, 0, 0.0, false, false, false)
            end)
        end

        Citizen.Wait(897)
    end
end)

function isBleedingF()
    local list = {}

    for key, value in pairs(bloodAreas) do
        if value > 0 and not appliedTourniquets[key] then
            table.insert(list, key)
        end
    end

    return #list > 0
end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)

        if not isUnconscious then
            if increasePulseTimer == 0 and decreasePulseTimer == 0 and painFactor == 0 then
                if currentPulse > 80 then
                    local toDecrease = math.random(10, 20)
                    local finalDecrease = currentPulse - toDecrease
                    
                    decreasePulse(1, toDecrease)
                end

                if currentPulse < 80 then
                    local finalIncrease = 80 - currentPulse
                    
                    increasePulse(1, finalIncrease)
                end
            end
        end
            
        Citizen.Wait(1000)
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)

        if not isUnconscious then
            if painFactor > 0 then
                if painFactor == 1 then
                    SendNUIMessage({
                        type = 'runPainEffect',
                        percent = 250.5,
                    })

                    Citizen.Wait(500)
                end

                if painFactor == 2 then
                    SendNUIMessage({
                        type = 'runPainEffect',
                        percent = 250.5,
                    })
                    
                    Citizen.Wait(400)
                end

                if painFactor == 3 then
                    SendNUIMessage({
                        type = 'runPainEffect',
                        percent = 250.5,
                    })
                    
                    Citizen.Wait(300)
                end

                if painFactor == 4 then
                    SendNUIMessage({
                        type = 'runPainEffect',
                        percent = 250.5,
                    })
                    
                    Citizen.Wait(200)
                end
            end
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        
        Citizen.Wait(0)
        
        if ConfigData.bindPulseToHealthBar then
            SetPedMaxHealth(PlayerPedId(), 250)
            SetEntityHealth(PlayerPedId(), currentPulse + 100)
            Citizen.Wait(1000)
        end

        if currentPulse > 160 then
            SendNUIMessage({
                type = 'heartbeat',
                hbType = "high"
            })
            
            Citizen.Wait(424)
        end
        
        if currentPulse <= 40 and currentPulse > 0 then
            SendNUIMessage({
                type = 'heartbeat',
                hbType = "slow"
            })
            
            Citizen.Wait(1432)
        end
        
        if isUnconscious then
            if currentPulse <= 160 and currentPulse > 40 then
                SendNUIMessage({
                    type = 'heartbeat',
                    hbType = "normal"
                })
                
                Citizen.Wait(1068)
            end
        end
    end
end)

Citizen.CreateThread(function()
	while true do
        for index, value in pairsByKeys(needSewed) do 
            if value == 1 then
                damagedAreas[index] = 1
                needSewed[index] = 0
            end
        end

        Citizen.Wait(math.random(300000, 600000))
    end
end)

-----------------


function GetPlayers()
    local players = {}

    for i = 0, 1024 do
        if NetworkIsPlayerActive(i) then
            table.insert(players, i)
        end
    end

    return players
end

function GetClosestPlayer(radius)
    local players = GetPlayers()
    local closestDistance = -1
    local closestPlayer = -1
    local ply = PlayerPedId()
    local plyCoords = GetEntityCoords(ply, 0)

    for index,value in ipairs(players) do
        local target = GetPlayerPed(value)
        if(target ~= ply) then
            local targetCoords = GetEntityCoords(GetPlayerPed(value), 0)
            local distance = GetDistanceBetweenCoords(targetCoords['x'], targetCoords['y'], targetCoords['z'], plyCoords['x'], plyCoords['y'], plyCoords['z'], true)
            if(closestDistance == -1 or closestDistance > distance) then
                closestPlayer = value
                closestDistance = distance
            end
        end
    end

	if closestDistance <= radius then
		return closestPlayer
	else
		return nil
	end
end

function EnableGui(enable, playerId)
    local selfOpened = false
    playerId = playerId or GetPlayerServerId(PlayerId())

    lastPlayerId = playerId

    if enable then            
        ESX.TriggerServerCallback('visn_are:getBodyPartInfo', function(bodyPartInfoCB)
            bodyPartInfo = bodyPartInfoCB

            SendNUIMessage({
                type = "personData",
                jsonString = json.encode(bodyPartInfo)
            })

            SetNuiFocus(enable, enable)
            guiEnabled = enable

            SendNUIMessage({
                type = "enableui",
                enable = enable
            })
            
            SendNUIMessage({
                type = "languageInit",
                messageData = json.encode(languageData.messages)
            })

            if lastPlayerId == GetPlayerServerId(PlayerId()) then
                selfOpened = true
            else
                selfOpened = false
            end
            
            SendNUIMessage({
                type = "selfOpened",
                state = selfOpened
            })
        end, playerId, "head")
    else
        SetNuiFocus(enable, enable)
        guiEnabled = enable

        SendNUIMessage({
            type = "enableui",
            enable = enable
        })
    end
end

RegisterNetEvent('visn_are:menuToggle')
AddEventHandler('visn_are:menuToggle', function(state)
    EnableGui(state, lastPlayerId)
end)

RegisterNUICallback('enable', function(state)
    EnableGui(state, lastPlayerId)
end)

RegisterNUICallback('close', function()
    EnableGui(false, lastPlayerId)
end)

RegisterNUICallback('focus', function(state)
    SetNuiFocus(true, state)
end)

RegisterNUICallback('revive', function(state)
    if isUnconscious then
        TriggerEvent('esx_ambulancejob:forceRespawn')

        SendNUIMessage({
            type = 'checkU',
            enable = false
        })

        bloodLevel = 6.0
        isBleeding = false
        cardiacDecided = false
        isUnconscious = false
        kickedOutVehicle = false
        isLaying = false

        peripheralResistance = 100
        isFeelingPain = false

        _bloodPressure = 1 * peripheralResistance;

        painFactor = 0

        currentPulse = 80
        increasePulseRate = 0
        increasePulseTimer = 0

        doingCPR = false
        doingCPRTarget = 0

        hasCardiacArrest = false

        decreasePulseRate = 0
        decreasePulseTimer = 0
        forceUnconscious = false

        recievingBloodInfusion = 0

        bloodPressureL = 0
        bloodPressureH = 0
        
        cooldownTimer = 0
        painTimer = 0

        isBusy = false
        
        bleedValue = 0
        
        resetAreas()

        SendNUIMessage({
            type = 'deactivatePainEffect'
        })

        TriggerServerEvent('visn_are:SetDeathStatus', isUnconscious)
        SetEntityInvincible(PlayerPedId(), false)
        SetPedConfigFlag(60, true)
        SetPedConfigFlag(62, false)
        SetCanAttackFriendly(PlayerPedId(), true, true)
        SetPedCanBeTargetted(PlayerPedId(), true)
        SetPedRagdollOnCollision(PlayerPedId(), true)
        SetPedConfigFlag(61, true)
        SetPedConfigFlag(104, true)
    end
end)

RegisterNetEvent('visn_are:resetValues')
AddEventHandler('visn_are:resetValues', function()
    
    SendNUIMessage({
        type = 'checkU',
        enable = false
    })

    bloodLevel = 6.0
    isBleeding = false
    cardiacDecided = false
    isUnconscious = false
    kickedOutVehicle = false
    isLaying = false

    peripheralResistance = 100
    isFeelingPain = false

    _bloodPressure = 1 * peripheralResistance;

    painFactor = 0

    currentPulse = 80
    increasePulseRate = 0
    increasePulseTimer = 0

    doingCPR = false
    doingCPRTarget = 0

    hasCardiacArrest = false

    decreasePulseRate = 0
    decreasePulseTimer = 0
    forceUnconscious = false

    recievingBloodInfusion = 0

    bloodPressureL = 0
    bloodPressureH = 0
    
    cooldownTimer = 0
    painTimer = 0

    isBusy = false
    
    bleedValue = 0
    
    resetAreas()

    SendNUIMessage({
        type = 'deactivatePainEffect'
    })

    TriggerServerEvent('visn_are:SetDeathStatus', isUnconscious)  
    SetEntityInvincible(PlayerPedId(), false)

    SetPedCanBeTargetted(PlayerPedId(), true)
    SetCanAttackFriendly(PlayerPedId(), true, true)
    SetPedConfigFlag(60, true)
    SetPedConfigFlag(62, false)
    SetPedRagdollOnCollision(PlayerPedId(), true)
    SetPedConfigFlag(61, true)
    SetPedConfigFlag(104, true)
end)

RegisterNUICallback('checkPerson', function(data)
    local victimPed = GetPlayerPed(GetPlayerFromServerId(data.source))
    local ownPed = PlayerPedId()

    if not data.personData.inBodybag then
        if GetDistanceBetweenCoords(GetEntityCoords(victimPed, true), GetEntityCoords(ownPed, true), true) < 1.5 then
            _checkPerson(data.source)
        else
            _sendNotification(_translate("person_too_far_away"), "error", 3500)
            EnableGui(false, lastPlayerId)
        end
    end
end)

RegisterNUICallback('checkBloodPressure', function(data)
    local victimPed = GetPlayerPed(GetPlayerFromServerId(data.source))
    local ownPed = PlayerPedId()

    if not data.personData.inBodybag then
        if GetDistanceBetweenCoords(GetEntityCoords(victimPed, true), GetEntityCoords(ownPed, true), true) < 1.5 then
            _checkBloodPressure(data.source, data.bodyPart)
        else
            _sendNotification(_translate("person_too_far_away"), "error", 3500)
            EnableGui(false, lastPlayerId)
        end
    end
end)

RegisterNUICallback('checkBloodVolume', function(data)
    local victimPed = GetPlayerPed(GetPlayerFromServerId(data.source))
    local ownPed = PlayerPedId()

    if not data.personData.inBodybag then
        if GetDistanceBetweenCoords(GetEntityCoords(victimPed, true), GetEntityCoords(ownPed, true), true) < 1.5 then
            _checkBloodVolume(data.source)
        else
            _sendNotification(_translate("person_too_far_away"), "error", 3500)
            EnableGui(false, lastPlayerId)
        end
    end
end)

RegisterNUICallback('checkPulse', function(data)
    local victimPed = GetPlayerPed(GetPlayerFromServerId(data.source))
    local ownPed = PlayerPedId()

    if not data.personData.inBodybag then
        if GetDistanceBetweenCoords(GetEntityCoords(victimPed, true), GetEntityCoords(ownPed, true), true) < 1.5 then
            _checkPulse(data.source, data.bodyPart)
        else
            _sendNotification(_translate("person_too_far_away"), "error", 3500)
            EnableGui(false, lastPlayerId)
        end
    end
end)

RegisterNUICallback('useBandage', function(data)
    local victimPed = GetPlayerPed(GetPlayerFromServerId(data.source))
    local ownPed = PlayerPedId()

    if not data.personData.inBodybag then
        if GetDistanceBetweenCoords(GetEntityCoords(victimPed, true), GetEntityCoords(ownPed, true), true) < 1.5 then
            _useBandage(data.source, data.bandageArea, data.bandageType)
        else
            _sendNotification(_translate("person_too_far_away"), "error", 3500)
            EnableGui(false, lastPlayerId)
        end
    end
end)

RegisterNUICallback('useBodybag', function(data)
    if data.personData.isUnconscious and not data.personData.inBodybag then
        local victimPed = GetPlayerPed(GetPlayerFromServerId(data.source))
        local ownPed = PlayerPedId()

        if GetDistanceBetweenCoords(GetEntityCoords(victimPed, true), GetEntityCoords(ownPed, true), true) < 1.5 then
            _useBodybag(data.source)
        else
            _sendNotification(_translate("person_too_far_away"), "error", 3500)
            EnableGui(false, lastPlayerId)
        end
    else
        _sendNotification(_translate("person_must_be_unconscious"), "error")
    end
end)

RegisterNUICallback('useCPR', function(data)
    if data.personData.isUnconscious and not data.personData.inBodybag then
        local victimPed = GetPlayerPed(GetPlayerFromServerId(data.source))
        local ownPed = PlayerPedId()

        if GetDistanceBetweenCoords(GetEntityCoords(victimPed, true), GetEntityCoords(ownPed, true), true) < 1.5 then
            _useCPR(data.source)
        else
            _sendNotification(_translate("person_too_far_away"), "error", 3500)
            EnableGui(false, lastPlayerId)
        end
    else
        _sendNotification(_translate("person_must_be_unconscious"), "error")
    end
end)

RegisterNUICallback('usePainkillers', function(data)
    local victimPed = GetPlayerPed(GetPlayerFromServerId(data.source))
    local ownPed = PlayerPedId()

    if GetDistanceBetweenCoords(GetEntityCoords(victimPed, true), GetEntityCoords(ownPed, true), true) < 1.5 then
        _usePainkillers(data.source)
    else
        _sendNotification(_translate("person_too_far_away"), "error", 3500)
        EnableGui(false, lastPlayerId)
    end
end)

RegisterNUICallback('useDefibrilator', function(data)
    if data.personData.isUnconscious and not data.personData.inBodybag then
        if data.personData.isMedic then
            local victimPed = GetPlayerPed(GetPlayerFromServerId(data.source))
            local ownPed = PlayerPedId()

            if GetDistanceBetweenCoords(GetEntityCoords(victimPed, true), GetEntityCoords(ownPed, true), true) < 1.5 then
                _useDefibrilator(data.source)
            else
                _sendNotification(_translate("person_too_far_away"), "error", 3500)
                EnableGui(false, lastPlayerId)
            end
        end
    else
        _sendNotification(_translate("person_must_be_unconscious"), "error")
    end
end)

RegisterNUICallback('removeTourniquet', function(data)
    if not data.personData.inBodybag then
        local victimPed = GetPlayerPed(GetPlayerFromServerId(data.source))
        local ownPed = PlayerPedId()

        if GetDistanceBetweenCoords(GetEntityCoords(victimPed, true), GetEntityCoords(ownPed, true), true) < 1.5 then
            _removeTourniquet(data.source, data.bodyPart)
        else
            _sendNotification(_translate("person_too_far_away"), "error", 3500)
            EnableGui(false, lastPlayerId)
        end
    end
end)

RegisterNUICallback('useTourniquet', function(data)
    if not data.personData.inBodybag then
        local victimPed = GetPlayerPed(GetPlayerFromServerId(data.source))
        local ownPed = PlayerPedId()

        if GetDistanceBetweenCoords(GetEntityCoords(victimPed, true), GetEntityCoords(ownPed, true), true) < 1.5 then
            _useTourniquet(data.source, data.bodyPart)
        else
            _sendNotification(_translate("person_too_far_away"), "error", 3500)
            EnableGui(false, lastPlayerId)
        end
    end
end)

RegisterNUICallback('useSurgicalKit', function(data)
    if data.personData.isMedic and not data.personData.inBodybag then
        local victimPed = GetPlayerPed(GetPlayerFromServerId(data.source))
        local ownPed = PlayerPedId()

        if GetDistanceBetweenCoords(GetEntityCoords(victimPed, true), GetEntityCoords(ownPed, true), true) < 1.5 then
            _useSurgicalKit(data.source, data.bandageArea)
        else
            _sendNotification(_translate("person_too_far_away"), "error", 3500)
            EnableGui(false, lastPlayerId)
        end
    end
end)

RegisterNUICallback('giveInfusion', function(data)
    if data.personData.isMedic and not data.personData.inBodybag then
        local victimPed = GetPlayerPed(GetPlayerFromServerId(data.source))
        local ownPed = PlayerPedId()

        if GetDistanceBetweenCoords(GetEntityCoords(victimPed, true), GetEntityCoords(ownPed, true), true) < 1.5 then
            _giveInfusion(data.source, data.giveType, data.giveAmount)
        else
            _sendNotification(_translate("person_too_far_away"), "error", 3500)
            EnableGui(false, lastPlayerId)
        end
    end
end)

RegisterNUICallback('requestResync', function(data)
    ESX.TriggerServerCallback('visn_are:getBodyPartInfo', function(bodyPartInfoCB)
        EnableGui(true, lastPlayerId)
    end, data.source, "head")
end)

RegisterNUICallback('tryCarry', function(data)
    _tryCarry(data)
end)

RegisterNUICallback('tryPutInVehicle', function(data)
    _tryPutInVehicle(data)
end)

RegisterNUICallback('tryPullOutVehicle', function(data)
    _tryPullOutVehicle(data)
end)

RegisterNUICallback('useLiquid', function(data)
    _useLiquid(data.source, data.liquidType, data.bodyPart)
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(playerData)
    --if ConfigData.stateSaving then
        ESX.TriggerServerCallback('visn_are:requestDatabase', function(data)
            damagedAreas = data.bodyPartDamage
            bloodAreas = data.bloodParts
            needSewed = data.needSewed
            currentPulse = data.bodyPulse
            painFactor = data.bodyPain
            isFeelingPain = data.bodyInPain
            inBodybag = data.inBodybag
            isBleeding = data.victimBleeding
            bloodLevel = data.bodyBloodLevel
            isUnconscious = data.isUnconscious
            recievingBloodInfusion = data.recievingBloodInfusion
            logs = data.logs
            bloodPressureL = data.bodyBloodLevel
            bloodPressureH = data.bodyBloodLevel
        end, playerData.identifier)
    --end
end)

RegisterNetEvent('visn_are:putInVehicle')
AddEventHandler('visn_are:putInVehicle', function()
	if isUnconscious and not inBodybag then
		local playerPed = PlayerPedId()
		local coords = GetEntityCoords(playerPed)

		if IsAnyVehicleNearPoint(coords, 5.0) then
			local vehicle = GetClosestVehicle(coords, 5.0, 0, 71)

			if DoesEntityExist(vehicle) then
				local maxSeats, freeSeat = GetVehicleMaxNumberOfPassengers(vehicle)

				for i=1, 0, -1 do
					if IsVehicleSeatFree(vehicle, i) then
						freeSeat = i
						break
					end
				end

                if freeSeat then
                    kickedOutVehicle = true
                    TaskWarpPedIntoVehicle(playerPed, vehicle, freeSeat)
				end
			end
		end
	end
end)

RegisterNetEvent('visn_are:pullOutVehicle')
AddEventHandler('visn_are:pullOutVehicle', function()
    local playerPed = PlayerPedId()

    if isUnconscious and not inBodybag then
        if IsPedSittingInAnyVehicle(playerPed) then
            local vehicle = GetVehiclePedIsIn(playerPed, false)
            TaskLeaveVehicle(playerPed, vehicle, 16)
            kickedOutVehicle = false
        end
    end
end)

exports('isSelfUnconscious', function()
    return isUnconscious
end)

exports('isInjured', function()
    if damagedAreas["head"] > 0 or damagedAreas["left_arm"] > 0 or damagedAreas["right_arm"] > 0 or damagedAreas["torso"] > 0 or damagedAreas["left_leg"] > 0 or damagedAreas["right_leg"] > 0 then
        return true
    else
        return false
    end

    return false
end)

exports('getPulse', function()
    return currentPulse
end)

exports('hasPain', function()
    if painFactor > 0 then
        return true
    else
        return false
    end

    return false
end)