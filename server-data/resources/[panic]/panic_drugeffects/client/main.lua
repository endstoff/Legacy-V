ESX             = nil 

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)


--[[ 

DRUG VARIABLEN

]]
local weedLevel = 0 
local cokeLevel = 0 
local methLevel = 0 
local lsdLevel = 0 
local krokoLevel = 0

local weedTime = 0 
local cokeTime = 0 
local methTime = 0 
local lsdTime = 0 
local krokoLevel = 0

local smoke = false
local bong = false
local s = false

function CLEAR()
    weedTime = 0 
    cokeTime = 0 
    methTime = 0
    lsdTime = 0
    krokoTime = 0

    weedLevel = 0 
    cokeLevel = 0
    methLevel = 0
    lsdLevel = 0
    krokoLevel = 0

    AnimpostfxStopAll()
    ResetPedMovementClipset(GetPlayerPed(-1))
    ResetPedWeaponMovementClipset(GetPlayerPed(-1))
    ResetPedStrafeClipset(GetPlayerPed(-1))
    ResetExtraTimecycleModifierStrength(0.0)
    SetTimecycleModifier(false)
    SetTimecycleModifierStrength(0.0)
    ShakeGameplayCam("DRUNK_SHAKE", 0.0)
end
function EndWeedEffect()
    if weedLevel == 1 then 
        ShakeGameplayCam("DRUNK_SHAKE", 0.0)
        SetPedMotionBlur(playerPed, false)
        SetTimecycleModifierStrength(0.0)
        weedLevel = 0
    end 
    if weedLevel == 2 then 
        ShakeGameplayCam("DRUNK_SHAKE", 0.0)
        SetPedMotionBlur(playerPed, false)
        AnimpostfxStopAll()
        SetTimecycleModifierStrength(0.0)
        weedLevel = 0
    end
    if weedLevel > 2 then 
        ShakeGameplayCam("DRUNK_SHAKE", 0.0)
        SetPedMotionBlur(playerPed, false)
        AnimpostfxStopAll()
        SetTimecycleModifierStrength(0.0)
        weedLevel = 0
    end 
    weedTime = 0
end
function EndCokeEffect()
    if cokeLevel == 1 then 
        cokeLevel = 0
        ShakeGameplayCam("DRUNK_SHAKE", 0.0)
        SetPedMotionBlur(playerPed, false)
        AnimpostfxStopAll()
        SetTimecycleModifierStrength(0.0)
    end
    if cokeLevel == 2 then 
        cokeLevel = 0
        ShakeGameplayCam("DRUNK_SHAKE", 0.0)
        SetPedMotionBlur(playerPed, false)
        AnimpostfxStopAll()
        SetTimecycleModifierStrength(0.0)
    end
    if cokeLevel == 3 then 
        cokeLevel = 0
        ShakeGameplayCam("DRUNK_SHAKE", 0.0)
        SetPedMotionBlur(playerPed, false)
        AnimpostfxStopAll()
        SetTimecycleModifierStrength(0.0)
    
    end
    cokeTime = 0 
    local arm = GetPedArmour(GetPlayerPed(-1))
    if arm > 0 then 
        SetPedArmour(GetPlayerPed(-1), 0)
    end 
end
function EndMethEffect()
    if methLevel == 1 then 
        methLevel = 0
        ShakeGameplayCam("DRUNK_SHAKE", 0.0)
        SetPedMotionBlur(playerPed, false)
        AnimpostfxStopAll()
        SetTimecycleModifierStrength(0.0)
    end
    if methLevel == 2 then 
        methLevel = 0
        ShakeGameplayCam("DRUNK_SHAKE", 0.0)
        SetPedMotionBlur(playerPed, false)
        AnimpostfxStopAll()
        SetTimecycleModifierStrength(0.0)
    end
    if methLevel == 3 then 
        methLevel = 0
        ShakeGameplayCam("DRUNK_SHAKE", 0.0)
        SetPedMotionBlur(playerPed, false)
        AnimpostfxStopAll()
        SetTimecycleModifierStrength(0.0)
    end
    methTime = 0
end
function EndLsdEffect()
    if lsdLevel == 1 then 
        lsdLevel = 0
        ShakeGameplayCam("DRUNK_SHAKE", 0.0)
        SetPedMotionBlur(playerPed, false)
        AnimpostfxStopAll()
        SetTimecycleModifierStrength(0.0)
    end
    if lsdLevel == 2 then 
        lsdLevel = 0
        ShakeGameplayCam("DRUNK_SHAKE", 0.0)
        SetPedMotionBlur(playerPed, false)
        AnimpostfxStopAll()
        SetTimecycleModifierStrength(0.0)
    end
    if lsdLevel == 3 then 
        lsdLevel = 0
        ShakeGameplayCam("DRUNK_SHAKE", 0.0)
        SetPedMotionBlur(playerPed, false)
        AnimpostfxStopAll()
        SetTimecycleModifierStrength(0.0)
    end
    lsdTime = 0
end
function EndKrokoEffect()
    if krokoLevel > 0 then 
        ShakeGameplayCam("DRUNK_SHAKE", 0.0)
        SetPedMotionBlur(playerPed, false)
        SetTimecycleModifierStrength(0.0)
        krokoLevel = 0
    end
end
Citizen.CreateThread(function()
    while true do 
        Citizen.Wait(1)
        if weedTime == 0 and cokeTime == 0 and methTime == 0 and lsdTime == 0 and krokoLevel == 0 and s == false and bong == false then 
            s = true
            CLEAR()
        end
    end
end)
RegisterNetEvent('panic_drugeffects:useWeed')
AddEventHandler('panic_drugeffects:useWeed', function(source)
    local playerPed = GetPlayerPed(-1)
    if weedLevel < 6 then 
    weedLevel = weedLevel + 1 
    if bong then 
    else 
    TaskStartScenarioInPlace(playerPed, "WORLD_HUMAN_SMOKING_POT", 0, 1)
    end
    bong = false
    Citizen.Wait(3000)
    ClearPedTasksImmediately(playerPed)
    Citizen.Wait(500)
    TriggerEvent('notify', 1, "", "Du hast Weed geraucht")
    weedTime = weedTime + 600
    Citizen.Wait(250)
    SetPedMotionBlur(playerPed, true)
        if weedLevel == 1 then 
            Citizen.Wait(1000)
            ShakeGameplayCam("DRUNK_SHAKE", 0.2)
            weedTime = weedTime + 100
        end
        if weedLevel == 2 then 
            Citizen.Wait(3000)
            AnimpostfxPlay("HeistCelebPass", 10000001, true)
            ShakeGameplayCam("DRUNK_SHAKE", 0.4)
            weedTime = weedTime + 400
        end 
        if (weedLevel > 2) and (weedLevel < 5) then 
            AnimpostfxPlay("HeistCelebPass", 10000001, true)
            ShakeGameplayCam("DRUNK_SHAKE", 0.5)
            weedTime = weedTime + 245
        end
        if weedLevel == 5 then 
            ShakeGameplayCam("DRUNK_SHAKE", 0.6)
            weedTime = weedTime + 250
            AnimpostfxPlay("LostTimeNight", 10000001, true)
            Citizen.Wait(5000)
            AnimpostfxStopAll()
            AnimpostfxPlay("HeistCelebPass", 10000001, true)
        end
    else 
    TriggerEvent('notify', 3, "", "Du hattest bis jetzt zu viel Weed")
    end
end)

RegisterNetEvent('panic_drugeffects:useCoke')
AddEventHandler('panic_drugeffects:useCoke', function()
    local playerPed = GetPlayerPed(-1)
    local armor = GetPedArmour(playerPed)
    local health = GetEntityHealth(playerPed)
    local seth = health - 5
    if cokeLevel < 4 then
        cokeLevel = cokeLevel + 1 
        TaskStartScenarioInPlace(playerPed, "WORLD_HUMAN_SMOKING_POT", 0, 1)
        Citizen.Wait(3000)
        ClearPedTasksImmediately(playerPed)
        Citizen.Wait(500)
        TriggerEvent('notify', 1, "", "Du hast Koks genommen")
        Citizen.Wait(250)
        SetPedMotionBlur(playerPed, true)
            if cokeLevel == 1 then 
                cokeTime = cokeTime + 420
                ShakeGameplayCam("DRUNK_SHAKE", 0.6)
                Citizen.Wait(1500)
                ShakeGameplayCam("DRUNK_SHAKE", 0.1)
                AnimpostfxPlay("LostTimeNight", 10000001, true)
                Citizen.Wait(2000)
                AnimpostfxStopAll()
                AnimpostfxPlay("HeistCelebPass", 10000001, true)
                --AnimpostfxPlay("DrugsTrevorClownsFight", 10000001, true)
                AddArmourToPed(playerPed, 50)
                SetEntityHealth(playerPed, seth)
                cokeTime = cokeTime + 300
                if armor > 100 then 
                    SetPedArmour(playerPed, 100)
                end
            end 
            if cokeLevel > 1 then 
                cokeTime = cokeTime + 200
                AddArmourToPed(playerPed, 50)
                SetEntityHealth(playerPed, seth)
                if armor > 100 then 
                    SetPedArmour(playerPed, 100)
                end
                AddArmourToPed(playerPed, 50)
                ShakeGameplayCam("DRUNK_SHAKE", 0.1)
                AnimpostfxPlay("LostTimeNight", 10000001, true)
                Citizen.Wait(2000)
                AnimpostfxStopAll()
                AnimpostfxPlay("HeistCelebPass", 10000001, true)
                --AnimpostfxPlay("DrugsTrevorClownsFight", 10000001, true)
            end
        else
            TriggerEvent('notify', 3, "", "Du hattest bis jetzt zu viel Kokain")
        end  
end)

RegisterNetEvent('panic_drugeffects:useMeth')
AddEventHandler('panic_drugeffects:useMeth', function()
    local playerPed = GetPlayerPed(-1)
    if methLevel < 4 then 
        methLevel = methLevel + 1 
        TaskStartScenarioInPlace(playerPed, "WORLD_HUMAN_SMOKING_POT", 0, 1)
        Citizen.Wait(3000)
        ClearPedTasksImmediately(playerPed)
        Citizen.Wait(500)
        TriggerEvent('notify', 1, "", "Du hast Meth genommen")
        Citizen.Wait(250)
        SetPedMotionBlur(playerPed, true)
        if methLevel > 0 then 
            methTime = methTime + 420 
            ShakeGameplayCam("DRUNK_SHAKE", 0.3)
            Citizen.Wait(1500)
            AnimpostfxPlay("SuccessMichael", 10000001, true)
        end
    else 
        TriggerEvent('notify', 3, "", "Du hattest bis jetzt zu viel Meth")
    end
end)
-- AnimpostfxPlay("DrugsMichaelAliensFight", 10000001, true)
RegisterNetEvent('panic_drugeffects:useLSD')
AddEventHandler('panic_drugeffects:useLSD', function()
    local playerPed = GetPlayerPed(-1)
    if lsdLevel < 4 then 
        lsdLevel = lsdLevel + 1 
        TaskStartScenarioInPlace(playerPed, "WORLD_HUMAN_SMOKING_POT", 0, 1)
        Citizen.Wait(3000)
        ClearPedTasksImmediately(playerPed)
        Citizen.Wait(500)
        TriggerEvent('notify', 1, "", "Du hast LSD genommen")
        Citizen.Wait(250)
        SetPedMotionBlur(playerPed, true)
        if lsdLevel > 0 then 
            lsdTime = lsdTime + 420 
            ShakeGameplayCam("DRUNK_SHAKE", 0.4)
            Citizen.Wait(1500)
            AnimpostfxPlay("DrugsMichaelAliensFight", 10000001, true)
        end
    else 
        TriggerEvent('notify', 3, "", "Du hattest bis jetzt zu viel LSD")
    end

end)

RegisterNetEvent('panic_drugeffects:useKroko')
AddEventHandler('panic_drugeffects:useKroko', function()
    local playerPed = GetPlayerPed(-1)
    if krokoLevel < 4 then 
        krokoLevel = krokoLevel + 1 
        TaskStartScenarioInPlace(playerPed, "WORLD_HUMAN_SMOKING_POT", 0, 1)
        Citizen.Wait(3000)
        ClearPedTasksImmediately(playerPed)
        Citizen.Wait(500)
        TriggerEvent('notify', 1, "", "Du hast Krokodil genommen")
        Citizen.Wait(250)
        SetPedMotionBlur(playerPed, true)
        if krokoLevel > 0 then 
            if krokoLevel < 2 then 
            krokoTime = krokoTime + 420
            end  
            krokoTime = krokoTime + 30
            ShakeGameplayCam("DRUNK_SHAKE", 0.4)
            Citizen.Wait(1500)
            AnimpostfxPlay("LostTimeNight", 10000001, true)
            Citizen.Wait(3500)
            AnimpostfxPlay("DrugsTrevorClownsFight", 10000001, true)
            Citizen.Wait(2000)
            AnimpostfxStopAll()
            AnimpostfxPlay("DrugsTrevorClownsFight", 10000001, true)
            if krokoLevel > 1 then 
                krokoTime = krokoTime + 400
            end
        end
    else 
        TriggerEvent('notify', 3, "", "Du hattest bis jetzt zu viel Krokodil")
    end
end)

Citizen.CreateThread(function()
    while true do 
        Citizen.Wait(0)
        if weedTime > 0 then 
            Citizen.Wait(1000)
            weedTime = weedTime - 1
            if weedTime == 0 then 
                EndWeedEffect()
            end
        end
        if cokeTime > 0 then 
            Citizen.Wait(1000)
            cokeTime = cokeTime - 1
            if cokeTime == 0 then 
                EndCokeEffect()
            end
        end
        if methTime > 0 then 
            Citizen.Wait(1000)
            methTime = methTime - 1
            if methTime == 0 then 
                EndMethEffect()
            end
        end 
        if lsdTime > 0 then 
            Citizen.Wait(1000)
            lsdTime = lsdTime - 1 
            if lsdTime == 0 then 
                EndLsdEffect()
            end
        end
        if krokoTime > 0 then 
            Citizen.Wait(1000)
            krokoTime = krokoTime - 1 
            if krokoTime == 0 then 
                EndKrokoEffect()
            end
        end
    end
end)

RegisterNetEvent('panic_drugeffects:dBong')
AddEventHandler('panic_drugeffects:dBong', function()
         local playerPed = GetPlayerPed(-1)
         local coords    = GetEntityCoords(playerPed)

            Citizen.CreateThread(function()
            
            local playerPed  = GetPlayerPed(-1)
            local coords     = GetEntityCoords(playerPed)
            local boneIndex  = GetPedBoneIndex(playerPed, 18905)
            local boneIndex2 = GetPedBoneIndex(playerPed, 57005)

            RequestAnimDict('anim@safehouse@bong')
                
            while not HasAnimDictLoaded('anim@safehouse@bong') do
            Citizen.Wait(0)
            end
            
            ESX.Game.SpawnObject('hei_heist_sh_bong_01', {
            x = coords.x,
            y = coords.y,
            z = coords.z - 3
            }, function(object)

            ESX.Game.SpawnObject('p_cs_lighter_01', {
            x = coords.x,
            y = coords.y,
            z = coords.z - 3
            }, function(object2)
            
            Citizen.CreateThread(function()
            
            TaskPlayAnim(playerPed, "anim@safehouse@bong", "bong_stage1", 3.5, -8, -1, 49, 0, 0, 0, 0)
            Citizen.Wait(1500)
            AttachEntityToEntity(object2, playerPed, boneIndex2, 0.10, 0.0, 0, 99.0, 192.0, 180.0, true, true, false, true, 1, true)
            AttachEntityToEntity(object, playerPed, boneIndex, 0.10, -0.25, 0, 95.0, 190.0, 180.0, true, true, false, true, 1, true)
            Citizen.Wait(6000)
            DeleteObject(object)
            DeleteObject(object2)
            ClearPedSecondaryTask(playerPed)
            weedLevel = weedLevel + 1
            bong = true 
            TriggerEvent('panic_drugeffects:useWeed')
            end)
            end)
            end)
    end)
end)
