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


ESX = nil
local PlayerData = {}
local plate = ""

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

local enableField = false

function toggleField(enable)
    SetNuiFocus(enable, enable)
    enableField = enable

    if enable then
        SendNUIMessage({
            action = 'open',
            openB = enable
        })
    else
        SendNUIMessage({
            action = 'open',
            openB = enable
        })
        plate = ""
    end
end


function ReloadInventory()
        SendNUIMessage({
            action = 'reset'
        })

        ESX.TriggerServerCallback('ps_carinventory:loadTargetInv', function(data)
            for key, value in pairs(data) do
                SendNUIMessage({
                    action = "add",
                    identifier = value.identifier,
                    item = value.item,
                    count = value.count,
                    name = value.name,
                    label = value.label,
                    limit = value.limit,
                    rare = value.rare,
                    can_remove = value.can_remove,
                    url = value.url,
                    useable = value.usable
                })
            end
        end, GetPlayerServerId(PlayerId()))

        ESX.TriggerServerCallback('ps_carinventory:loadTargetPlate', function(data)
            for key, value in pairs(data) do
                SendNUIMessage({
                    action = "addK",
                    identifier = value.identifier,
                    item = value.item,
                    count = value.count,
                    name = value.name,
                    label = value.label,
                    limit = value.limit,
                    rare = value.rare,
                    can_remove = value.can_remove,
                    url = value.url,
                    useable = value.usable
                })
            end
        end, plate)
end

RegisterNUICallback('refresh', function(data, cb)
    ReloadInventory()
    cb('ok')
end)

RegisterNetEvent('ps_carinventory:refresh')
AddEventHandler('ps_carinventory:refresh', function ()
    ReloadInventory()
end)

AddEventHandler('onResourceStop', function(name)
    if GetCurrentResourceName() ~= name then
        return
    end

    toggleField(false)
end)

RegisterNUICallback('escape', function(data, cb)
    toggleField(false)
    SetNuiFocus(false, false)

    cb('ok')
end)

RegisterNUICallback('transfer', function(data, cb)
    TriggerServerEvent('ps_carinventory:convert', data.currentplace, data.item, data.count, plate)
    cb('ok')
end)

CreateThread(function()
    while true do
        
        if IsControlJustPressed(0, Keys["L"]) then
            local veh, dist = ESX.Game.GetClosestVehicle(GetEntityCoords(GetPlayerPed(-1)))

            if dist <= 4.0 then
                plate = GetVehicleNumberPlateText(veh)

                ESX.TriggerServerCallback('ps_carinventory:IsInUse', function(inuse)
                    if not inuse then
                        toggleField(true)

                        SendNUIMessage({
                            action = 'reset'
                        })

                        ReloadInventory()
                    else
                        ESX.ShowNotification("Der Kofferraum wird bereits verwendet!")
                    end
                end, plate)
            end
        end

        Wait(1)
    end
end)