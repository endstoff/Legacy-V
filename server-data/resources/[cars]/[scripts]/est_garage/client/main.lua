
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

local garages = {
    {vector3(-619.18, -80.9, 41.2), vector3(-632.93, -75.36, 40.40), 357.97},
    {vector3(213.182, -809.534, 31.03), vector3(234.498, -805.475, 31.43), 64.0},
    {vector3(-833.255, -2351.34, 14.57), vector3(-823.68, -2342.975, 13.803), 147.0},
    {vector3(721.95, -2016.379, 29.43), vector3(728.567, -2033.28, 28.87), 354.0},
    {vector3(-2162.82, -377.15,13.28), vector3(-2169.21, -372.25, 13.08), 158.18},
    {vector3(-400.74, 1209.87, 325.92), vector3(-406.82, 1207.15, 325.664), 167.65},
    {vector3(112.23, 6619.66, 31.82), vector3(115.81,6599.34, 32.01), 265.81},
    {vector3(1951.79, 3750.95, 32.16), vector3(1949.57, 3759.33, 32.21), 34.16},
    {vector3(615.15, 2785.41, 43.48), vector3(595.16, 2789.47, 42.19), 5.76},
    {vector3(-1681.48, 56.48, 63.96), vector3(-1685.45, 48.77, 63.62), 161.99},
    {vector3(-1184.28, -1509.79, 4.65), vector3(-1191.71, -1504.35, 3.94), 304.94},
    {vector3(889.24, -53.87, 78.91), vector3(886.12, -62.68, 78.76), 236.43}
}



local enableField = false

function AddCar(plate)
    SendNUIMessage({
        action = 'add',
        plate = plate
    }) 
end

function toggleField(enable)
    SetNuiFocus(enable, enable)
    enableField = enable

    if enable then
        SendNUIMessage({
            action = 'open'
        }) 
    else
        SendNUIMessage({
            action = 'close'
        }) 
    end
end

AddEventHandler('onResourceStart', function(name)
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

RegisterNUICallback('enable-parkout', function(data, cb)
    
    ESX.TriggerServerCallback('est_garage:loadVehicles', function(vehicles)
        for key, value in pairs(vehicles) do
            AddCar(value.plate)
        end
    end)
    
    cb('ok')
end) 

RegisterNUICallback('enable-parking', function(data, cb)
    
    local vehicles = ESX.Game.GetVehiclesInArea(GetEntityCoords(GetPlayerPed(-1)), 25.0)

    for key, value in pairs(vehicles) do
        ESX.TriggerServerCallback('est_garage:isOwned', function(owned)

            if owned then
                AddCar(GetVehicleNumberPlateText(value))
            end
    
        end, GetVehicleNumberPlateText(value))
    end
    
    cb('ok')
end) 

local usedGarage

RegisterNUICallback('park-out', function(data, cb, state)
    
    ESX.TriggerServerCallback('est_garage:loadVehicle', function(vehicle)
        local x,y,z = table.unpack(garages[usedGarage][2])
        local props = json.decode(vehicle[1].vehicle)

        ESX.Game.SpawnVehicle(props.model, {
            x = x,
            y = y,
            z = z + 1
        }, garages[usedGarage][3], function(callback_vehicle)
            --TriggerEvent('persistent-vehicles/register-vehicle', callback_vehicle)
            ESX.Game.SetVehicleProperties(callback_vehicle, props)
            SetVehRadioStation(callback_vehicle, "OFF")
        end)

    end, data.plate)
    ESX.ShowNotification('Fahrzeug ausgeparkt')
    TriggerServerEvent('est_garage:changeState', data.plate, 0)
    
    cb('ok')
end)

RegisterNUICallback('park-in', function(data, cb, state)
    
    local vehicles = ESX.Game.GetVehiclesInArea(GetEntityCoords(GetPlayerPed(-1)), 25.0)
    local plate = GetVehicleNumberPlateText(vehicle)

    for key, value in pairs(vehicles) do
        if GetVehicleNumberPlateText(value) == data.plate then
            TriggerServerEvent('est_garage:saveProps', data.plate, ESX.Game.GetVehicleProperties(value))
            ESX.ShowNotification('Fahrzeug eingeparkt')
            TriggerServerEvent('est_garage:changeState', data.plate, 1)
            --TriggerEvent('persistent-vehicles/forget-vehicle', value)
            TriggerServerEvent("AdvancedParking:deleteVehicle", data.plate)
            ESX.Game.DeleteVehicle(value)
        end
    end

    cb('ok')
end)

Citizen.CreateThread(function()
    while true do
        Wait(0)
        for key, value in pairs(garages) do
            DrawMarker(22, value[1], 0.0, 0.0, 0.0, 0, 0.0, 0.0, 1.0, 1.0, 1.0, 255, 255, 255, 100, false, true, 2, true, false, false, false)
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        Wait(0)

        for key, value in pairs(garages) do
            local dist = GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), value[1])

            if dist <= 2.0 then
                ESX.ShowHelpNotification("Drücke ~INPUT_CONTEXT~ um auf die Garage zuzugreifen")

                if IsControlJustReleased(0, 38) then
                    toggleField(true)
                    usedGarage = key
                end
            end
        end
    end
end)

Citizen.CreateThread(function()
    for _, coords in pairs(garages) do
        local blip = AddBlipForCoord(coords[1])

        SetBlipSprite(blip, 473)
        SetBlipScale(blip, 0.8)
        SetBlipColour(blip, 0)
        SetBlipDisplay(blip, 2)
        SetBlipAsShortRange(blip, true)

        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString("Garage")
        EndTextCommandSetBlipName(blip)
    end
end)
