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

CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Wait(0)
    end

    while ESX.GetPlayerData().job == nil do
        Wait(10)
    end

    PlayerData = ESX.GetPlayerData()
end)

local enableField = false

function toggleField(enable)
    SetNuiFocus(enable, enable)
    enableField = enable

    if enable then
        ESX.TriggerServerCallback('ps_banking:getCash', function(money)
            SendNUIMessage({
                action = 'open',
                cash = money
            })
        end)
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

RegisterNUICallback('refresh', function(data, cb)
    ESX.TriggerServerCallback('ps_banking:getCash', function(money)
        SendNUIMessage({
            action = 'open',
            cash = money
        })    
    end)

    ESX.TriggerServerCallback('ps_banking:getAccounts', function(accounts)
        SendNUIMessage({
            action = 'account',
            accounts = accounts
        })
    end)

    cb('ok')
end)

local nearATM = false


local allowedATMs = 
{
    [GetHashKey("prop_fleeca_atm")] = true,
    [GetHashKey("prop_atm_01")] = true,
    [GetHashKey("prop_atm_02")] = true,
    [GetHashKey(GetHashKey("prop_atm_03"))] = true
}

function FindNearestATM()
	local coords = GetEntityCoords(PlayerPedId())
	local fuelPumps = {}
	local handle, object = FindFirstObject()
	local success

	repeat
		if allowedATMs[GetEntityModel(object)] then
			table.insert(fuelPumps, object)
		end

		success, object = FindNextObject(handle, object)
	until not success

	EndFindObject(handle)

	local atmObject = 0
	local atmDistance = 1000

	for _, obj in pairs(fuelPumps) do
        local dstcheck = GetDistanceBetweenCoords(coords[1], coords[2], coords[3], GetEntityCoords(obj)[1], GetEntityCoords(obj)[2], GetEntityCoords(obj)[3], true)

		if dstcheck < atmDistance then
			atmDistance = dstcheck
			atmObject = obj
		end
	end

	return atmObject, atmDistance
end

CreateThread(function()
    while true do
        local atmObject, atmDistance = FindNearestATM()

		if atmDistance < 1.5 then
            nearATM = atmObject
        else
            nearATM = false 
        end

        atmObject, atmDistance = nil, nil
        Wait(500)
    end
end)

CreateThread(function()
    while true do

        if nearATM then
            ESX.ShowHelpNotification('Drücke ~INPUT_CONTEXT~ um Geldbuchungen zu verwalten')
            
            if IsControlJustPressed(0, 38) then
                toggleField(true)
                
                ESX.TriggerServerCallback('ps_banking:getAccounts', function(accounts)
                    SendNUIMessage({
                        action = 'account',
                        accounts = accounts
                    })
                end)
            end
        end

        Wait(0)
    end
end)

RegisterNUICallback('change_account', function(data, cb)
    TriggerServerEvent('ps_banking:changeLabel', data.id, data.label)
end)

RegisterNUICallback('pagerequest_accounts', function(data, cb)
    ESX.TriggerServerCallback('ps_banking:getAccounts', function(accounts)
        SendNUIMessage({
            action = 'pagerequest_account',
            accounts = accounts
        })
    end)
end)

RegisterNUICallback('setDefault', function(data, cb)
    TriggerServerEvent('ps_banking:setDefault', data.bank)
end)

--[[CreateThread(function() Bug Fix -> Resource time warning
    while true do
        Wait(120 * 1000)
        TriggerServerEvent('ps_banking:updateBank')
    end
end)]]--

RegisterNUICallback('aufladen', function(data, cb)
    TriggerServerEvent('ps_banking:CashToBank', data.money, data.bank)
end)

RegisterNUICallback('abbuchen', function(data, cb)
    TriggerServerEvent('ps_banking:BankToCash', data.money, data.bank)
end)

RegisterNUICallback('transfer_money', function(data, cb)
    TriggerServerEvent('ps_banking:TransferBank', data.self, data.target, tonumber(data.money))
end)

CreateThread(function()
    while true do
        
        if IsControlJustPressed(0, Keys["F6"]) then
            if ESX.GetPlayerData().job.name == 'banker' then
                ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'banker_menu', {
                    title    = 'Bänker',
                    align    = 'top-left',
                    elements = {{label = "Konto eröffnen", value = "konto_create"}}
                }, function(data, menu)
            
                    if data.current.value == "konto_create" then
                        local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()

                        if closestPlayer and closestDistance <= 2.5 then
                            ESX.ShowNotification("Konto wird eröffnet!")
                            TriggerServerEvent('ps_banking:createNewBanking', GetPlayerServerId(closestPlayer))
                        else
                            ESX.ShowNotification("Es konnte kein Konto erstellt worden!")
                        end
                    end

                end, function(data, menu)
                    menu.close()
                end)
            end
        end

        Wait(1)
    end
end)