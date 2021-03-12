local PlayerData                = {}
ESX                             = nil

local lastInput = 0
local blip1 = {}
local blips = false
local blipActive = false
local mineActive = false
local inzone = false
local washingActive = false
local remeltingActive = false
local firstspawn = false
local impacts = 0
local timer = 0
local menuOpen = false
local wasOpen = false
local locations = {
    { ['x'] = -591.47,  ['y'] = 2076.52,  ['z'] = 131.37},
    { ['x'] = -590.35,  ['y'] = 2071.76,  ['z'] = 131.29},
    { ['x'] = -589.61,  ['y'] = 2069.3,  ['z'] = 131.19},
    { ['x'] = -588.6,  ['y'] = 2064.03,  ['z'] = 130.96},
    { ['x'] = -588.13,  ['y'] = 2060.01,  ['z'] = 130.9},
    { ['x'] = -587.29,  ['y'] = 2053.78,  ['z'] = 130.42},
    { ['x'] = -586.31,  ['y'] = 2050.34,  ['z'] = 129.94},
    { ['x'] = -585.18,  ['y'] = 2046.01,  ['z'] = 129.58},
}
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
local lastInput = 0
local pause = false
local pausetimer = 0
local correct = 0

Citizen.CreateThread(function()
    while ESX == nil do
      TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
      Citizen.Wait(0)
    end

--    while ESX.GetPlayerData().job == nil do
--		Citizen.Wait(10)
--	end

	ESX.PlayerData = ESX.GetPlayerData()
end)

function Help(msg)
    SetTextComponentFormat('STRING')
    AddTextComponentString(msg)
    DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
    PlayerData = xPlayer
end)

--RegisterNetEvent('esx:setJob')
--AddEventHandler('esx:setJob', function(job)
    --ESX.PlayerData.job = job
--end)
--[[
RegisterNetEvent("esx_miner:givestone")
AddEventHandler("esx_miner:givestone", function()
    Animation()
end)
--]]
RegisterNetEvent("esx_miner:washing")
AddEventHandler("esx_miner:washing", function()
    --waschen()
    Washing()
end)

RegisterNetEvent("esx_miner:remelting")
AddEventHandler("esx_miner:remelting", function()
    schmelzen()
    Remelting()
end)

Citizen.CreateThread(function()
    local ped = PlayerPedId()
	while true do
		Wait(5)
		if mineActive or washingActive or remeltingActive then
			if IsControlJustReleased(0, Keys['1']) then
				input = 1
			end
			if IsControlJustReleased(0, Keys['2']) then
				input = 2
			end
			if IsControlJustReleased(0, Keys['3']) then
				input = 3
			end
			if IsControlJustReleased(0, Keys['4']) then
				input = 4
			end
			if IsControlJustReleased(0, Keys['5']) then
				input = 5
			end
			if IsControlJustReleased(0, Keys['6']) then
				input = 6
			end
			if IsControlJustReleased(0, Keys['7']) then
				input = 7
			end
			if IsControlJustReleased(0, Keys['8']) then
				input = 8
            end

            if IsControlJustReleased(0, Keys['X']) then
                ClearPedTasks(ped)
                ClearPedTasksImmediately(ped)
                ClearPedSecondaryTask(ped)
                mineActive = false
                washingActive = false
                remeltingActive = false
                ESX.ShowNotification("~r~aufgehört~s~")
            end
			
			if pausetimer > 3 then
				input = 99
			end
			
			if pause and input ~= 0 then
				pause = false
                if input == correct then
                    if mineActive then
                        TriggerServerEvent("esx_miner:givestone")
                    elseif washingActive then
                        TriggerServerEvent("esx_miner:washing")
                    elseif remeltingActive then
                        TriggerServerEvent("esx_miner:remelting")
                    end
				else
					ESX.ShowNotification("~r~verfehlt!~s~")
				end
			end
		end		
	end
end)

Citizen.CreateThread(function()
	while true do
		local wait = math.random(7000 , 10000)
		Wait(wait)
		if mineActive or washingActive or remeltingActive then
			pause = true
			correct = math.random(1,8)
			ESX.ShowNotification("~g~~h~Drücke " .. correct .. "")
			input = 0
			pausetimer = 0
        end	
	end
end)

Citizen.CreateThread(function()
        while true do
        local colorRED = 255
        local colorGREEN = 255
        local colorBLUE = 255
	    local ped = PlayerPedId()
            Citizen.Wait(0)
                for k,v in pairs(Config.Abbauen) do
                if GetDistanceBetweenCoords(GetEntityCoords(ped), v.x, v.y, v.z, true) < 25 and mineActive == false then
                    DrawMarker(22, v.x, v.y, v.z, 0, 0, 0, 0, 0, 100.0, 1.0, 1.0, 1.0, colorRED, colorGREEN, colorBLUE, 100, false, false, 2, true, 0, 0, 0)
                        if GetDistanceBetweenCoords(GetEntityCoords(ped), v.x, v.y, v.z, true) < 1 then
                            Help("Drücke ~INPUT_CONTEXT~ um Steine zu ~b~sammeln~s~.")
                            if IsControlJustReleased(1, 51) then
                                ESX.TriggerServerCallback('esx_miner:getItemQ', function(quantity)
                                    if quantity > 0 then
                                        ESX.TriggerServerCallback("esx_miner:getItemQ", function(quantity)
                                            if quantity < 100 then
                                                mineActive = true
                                                Animation()
                                            else
                                                ESX.ShowAdvancedNotification("Unity-V", "~b~Mine~s~", "Du hast keinen Platz mehr in deinen Taschen für weitere Steine", "CHAR_BLOCKED", 1)
                                            end
                                        end, "stone")
                                    else
                                      ESX.ShowAdvancedNotification('Unity-V', '', 'Du hast keine ~r~Spitzhacke~s~!', 'CHAR_BLOCKED', 1)
                                    end
                                end, 'spitzhacke')
                            end
                        end
                end
--[[
                for i=1, #locations, 1 do
                    if GetDistanceBetweenCoords(GetEntityCoords(ped), locations[i].x, locations[i].y, locations[i].z, true) < 25 and mineActive == false then
                        DrawMarker(20, locations[i].x, locations[i].y, locations[i].z, 0, 0, 0, 0, 0, 100.0, 1.0, 1.0, 1.0, 0, 155, 253, 100, false, false, 2, true, 0, 0, 0)
                            if GetDistanceBetweenCoords(GetEntityCoords(ped), locations[i].x, locations[i].y, locations[i].z, true) < 1 then
                                Help("Drücke ~INPUT_CONTEXT~ um Steine zu ~b~sammeln~s~.")
                                if IsControlJustReleased(1, 51) then
                                    ESX.TriggerServerCallback('esx_miner:getItemQ', function(quantity)
                                        if quantity > 0 then
                                            ESX.TriggerServerCallback("esx_miner:getItemQ", function(quantity)
                                                if quantity < 100 then
                                                    mineActive = true
                                                    Animation()
                                                else
                                                    ESX.ShowAdvancedNotification("Unity-V", "~b~Mine~s~", "Du hast keinen Platz mehr in deinen Taschen für weitere Steine", "CHAR_BLOCKED", 1)
                                                end
                                            end, "stone")
                                        else
                                          ESX.ShowAdvancedNotification('Unity-V', '', 'Du hast keine ~r~Spitzhacke~s~!', 'CHAR_BLOCKED', 1)
                                        end
                                    end, 'spitzhacke')
                                end
                            end
                    end

                if GetDistanceBetweenCoords(GetEntityCoords(ped), Config.WashingX, Config.WashingY, Config.WashingZ, true) < 25 and washingActive == false then
                    DrawMarker(1, Config.WashingX, Config.WashingY, Config.WashingZ, 0, 0, 0, 0, 0, 55.0, 10.0, 10.0, 2.0, 0, 155, 253, 100, false, false, 2, false, 0, 0, 0)
                    if GetDistanceBetweenCoords(GetEntityCoords(ped), Config.WashingX, Config.WashingY, Config.WashingZ, true) < 5 then
                        Help("Drücke ~INPUT_CONTEXT~ um Steine zu ~b~waschen~s~.")
                        if IsControlJustReleased(1, 51) then
                            TriggerServerEvent("esx_miner:washing")
                        end
                    end
                end
]]
                if GetDistanceBetweenCoords(GetEntityCoords(ped), Config.WashingX, Config.WashingY, Config.WashingZ, true) < 25 and washingActive == false then
                    DrawMarker(1, Config.WashingX, Config.WashingY, Config.WashingZ, 0, 0, 0, 0, 0, 55.0, 10.0, 10.0, 2.0, 0, 155, 253, 100, false, false, 2, false, 0, 0, 0)
                    if GetDistanceBetweenCoords(GetEntityCoords(ped), Config.WashingX, Config.WashingY, Config.WashingZ, true) < 5 then
                        Help("Drücke ~INPUT_CONTEXT~ um Steine zu ~b~waschen~s~.")
                        if IsControlJustReleased(1, 51) then
                            ESX.TriggerServerCallback('esx_miner:getItemQ', function(quantity)
                                if quantity > 0 then
                                    ESX.TriggerServerCallback("esx_miner:getItemQ", function(quantity)
                                        if quantity >= 10 then
                                            washingActive = true
                                            Animation()
                                        else
                                            ESX.ShowAdvancedNotification("Unity-V", "~b~Mine~s~", "Du hast keine weiteren Steine bei dir!", "CHAR_BLOCKED", 1)
                                        end
                                    end, "stone")
                                else
                                  ESX.ShowAdvancedNotification('Unity-V', '', 'Du hast keine ~r~Bürste~s~!', 'CHAR_BLOCKED', 1)
                                end
                            end, 'burste')
                        end
                    end
                end
--[[
                if GetDistanceBetweenCoords(GetEntityCoords(ped), Config.RemeltingX, Config.RemeltingY, Config.RemeltingZ, true) < 25 and remeltingActive == false then
                    DrawMarker(20, Config.RemeltingX, Config.RemeltingY, Config.RemeltingZ, 0, 0, 0, 0, 0, 55.0, 1.0, 1.0, 1.0, 0, 155, 253, 100, false, false, 2, true, 0, 0, 0)
                    if GetDistanceBetweenCoords(GetEntityCoords(ped), Config.RemeltingX, Config.RemeltingY, Config.RemeltingZ, true) < 1 then
                        Help("Drücke ~INPUT_CONTEXT~ um die gewaschenen Steine zu ~b~schmelzen~s~.")
                        if IsControlJustReleased(1, 51) then
                            TriggerServerEvent("esx_miner:remelting")  
                        end
                    end
                end


                if GetDistanceBetweenCoords(GetEntityCoords(ped), Config.RemeltingX, Config.RemeltingY, Config.RemeltingZ, true) < 25 and remeltingActive == false then
                    DrawMarker(20, Config.RemeltingX, Config.RemeltingY, Config.RemeltingZ, 0, 0, 0, 0, 0, 55.0, 1.0, 1.0, 1.0, 0, 155, 253, 100, false, false, 2, true, 0, 0, 0)
                    if GetDistanceBetweenCoords(GetEntityCoords(ped), Config.RemeltingX, Config.RemeltingY, Config.RemeltingZ, true) < 1 then
                        Help("Drücke ~INPUT_CONTEXT~ um die gewaschenen Steine zu ~b~schmelzen~s~.")
                        if IsControlJustReleased(1, 51) then
                            ESX.TriggerServerCallback('esx_miner:getItemQ', function(quantity)
                                if quantity > 0 then
                                    ESX.TriggerServerCallback("esx_miner:getItemQ", function(quantity)
                                        if quantity >= 10 then
                                            remeltingActive = true
                                            Animation()
                                        else
                                            ESX.ShowAdvancedNotification("Unity-V", "~b~Mine~s~", "Du hast keine weiteren ~y~gewaschenen Steine~s~ bei dir!", "CHAR_BLOCKED", 1)
                                        end
                                    end, "washed_stone")
                                else
                                  ESX.ShowAdvancedNotification('Unity-V', '', 'Du hast keine ~r~Tiegelzange~s~!', 'CHAR_BLOCKED', 1)
                                end
                            end, 'tiegelzange')
                        end
                    end
                end
--]]
                for k,v in pairs(Config.Remelting) do
                    if GetDistanceBetweenCoords(GetEntityCoords(ped), v.x, v.y, v.z, true) < 25 and remeltingActive == false then
                        DrawMarker(20, v.x, v.y, v.z, 0, 0, 0, 0, 0, 55.0, 1.0, 1.0, 1.0, 0, 155, 253, 100, false, false, 2, true, 0, 0, 0)
                        if GetDistanceBetweenCoords(GetEntityCoords(ped), v.x, v.y, v.z, true) < 1 then
                            Help("Drücke ~INPUT_CONTEXT~ um die gewaschenen Steine zu ~b~schmelzen~s~.")
                            if IsControlJustReleased(1, 51) then
                                ESX.TriggerServerCallback('esx_miner:getItemQ', function(quantity)
                                    if quantity > 0 then
                                        ESX.TriggerServerCallback("esx_miner:getItemQ", function(quantity)
                                            if quantity >= 10 then
                                                remeltingActive = true
                                                Animation()
                                            else
                                                ESX.ShowAdvancedNotification("Unity-V", "~b~Mine~s~", "Du hast keine weiteren ~y~gewaschenen Steine~s~ bei dir!", "CHAR_BLOCKED", 1)
                                            end
                                        end, "washed_stone")
                                    else
                                      ESX.ShowAdvancedNotification('Unity-V', '', 'Du hast keine ~r~Tiegelzange~s~!', 'CHAR_BLOCKED', 1)
                                    end
                                end, 'tiegelzange')
                            end
                        end
                    end
                end
--[[
                if GetDistanceBetweenCoords(GetEntityCoords(ped), Config.RemeltingX2, Config.RemeltingY2, Config.RemeltingZ2, true) < 25 and remeltingActive == false then
                    DrawMarker(20, Config.RemeltingX2, Config.RemeltingY2, Config.RemeltingZ2, 0, 0, 0, 0, 0, 55.0, 1.0, 1.0, 1.0, 0, 155, 253, 100, false, false, 2, true, 0, 0, 0)
                    if GetDistanceBetweenCoords(GetEntityCoords(ped), Config.RemeltingX2, Config.RemeltingY2, Config.RemeltingZ2, true) < 1 then
                        Help("Drücke ~INPUT_CONTEXT~ um die gewaschenen Steine zu ~b~schmelzen~s~.")
                        if IsControlJustReleased(1, 51) then
                            TriggerServerEvent("esx_miner:remelting")  
                        end
                    end
                end

                if GetDistanceBetweenCoords(GetEntityCoords(ped), Config.RemeltingX3, Config.RemeltingY3, Config.RemeltingZ3, true) < 25 and remeltingActive == false then
                    DrawMarker(20, Config.RemeltingX3, Config.RemeltingY3, Config.RemeltingZ3, 0, 0, 0, 0, 0, 55.0, 1.0, 1.0, 1.0, 0, 155, 253, 100, false, false, 2, true, 0, 0, 0)
                    if GetDistanceBetweenCoords(GetEntityCoords(ped), Config.RemeltingX3, Config.RemeltingY3, Config.RemeltingZ3, true) < 1 then
                        Help("Drücke ~INPUT_CONTEXT~ um die gewaschenen Steine zu ~b~schmelzen~s~.")
                        if IsControlJustReleased(1, 51) then
                            TriggerServerEvent("esx_miner:remelting")  
                        end
                    end
                end

                if GetDistanceBetweenCoords(GetEntityCoords(ped), Config.RemeltingX4, Config.RemeltingY4, Config.RemeltingZ4, true) < 25 and remeltingActive == false then
                    DrawMarker(20, Config.RemeltingX4, Config.RemeltingY4, Config.RemeltingZ4, 0, 0, 0, 0, 0, 55.0, 1.0, 1.0, 1.0, 0, 155, 253, 100, false, false, 2, true, 0, 0, 0)
                    if GetDistanceBetweenCoords(GetEntityCoords(ped), Config.RemeltingX4, Config.RemeltingY4, Config.RemeltingZ4, true) < 1 then
                        Help("Drücke ~INPUT_CONTEXT~ um die gewaschenen Steine zu ~b~schmelzen~s~.")
                        if IsControlJustReleased(1, 51) then
                            TriggerServerEvent("esx_miner:remelting")  
                        end
                    end
                end

                if GetDistanceBetweenCoords(GetEntityCoords(ped), Config.RemeltingX5, Config.RemeltingY5, Config.RemeltingZ5, true) < 25 and remeltingActive == false then
                    DrawMarker(20, Config.RemeltingX5, Config.RemeltingY5, Config.RemeltingZ5, 0, 0, 0, 0, 0, 55.0, 1.0, 1.0, 1.0, 0, 155, 253, 100, false, false, 2, true, 0, 0, 0)
                    if GetDistanceBetweenCoords(GetEntityCoords(ped), Config.RemeltingX5, Config.RemeltingY5, Config.RemeltingZ5, true) < 1 then
                        Help("Drücke ~INPUT_CONTEXT~ um die gewaschenen Steine zu ~b~schmelzen~s~.")
                        if IsControlJustReleased(1, 51) then
                            TriggerServerEvent("esx_miner:remelting")  
                        end
                    end
                end
                ]]
            end
        end
end)

Citizen.CreateThread(function()
    while true do
	local ped = PlayerPedId()
        Citizen.Wait(1)
        if GetDistanceBetweenCoords(GetEntityCoords(ped), Config.SellX, Config.SellY, Config.SellZ, true) < 1 then
            Help("Drücke ~INPUT_CONTEXT~ um ~o~Kupfer~s~ zu ~b~verkaufen~s~.")
            if IsControlJustReleased(1, 51) then
                copper()
            end                     
        end
        if GetDistanceBetweenCoords(GetEntityCoords(ped), Config.SellXE, Config.SellYE, Config.SellZE, true) < 1 then
            Help("Drücke ~INPUT_CONTEXT~ um Eisen zu ~b~verkaufen~s~.")
            if IsControlJustReleased(1, 51) then
                iron()
            end                        
        end
        if GetDistanceBetweenCoords(GetEntityCoords(ped), Config.SellXG, Config.SellYG, Config.SellZG, true) < 1 then
            Help("Drücke ~INPUT_CONTEXT~ um ~y~Gold~s~ zu ~b~verkaufen~s~.")
            if IsControlJustReleased(1, 51) then
                gold()
            end                        
        end
        if GetDistanceBetweenCoords(GetEntityCoords(ped), Config.SellXD, Config.SellYD, Config.SellZD, true) < 1 then
            Help("Drücke ~INPUT_CONTEXT~ um ~b~Diamanten~s~ zu ~b~verkaufen~s~.")
            if IsControlJustReleased(1, 51) then
                diamond()
            end                        
        end
    end
end)

function waschen()
    --exports['progressBars']:startUI(15900, "Waschen...")
end
    
function schmelzen()
    exports['progressBars']:startUI(15900, "Schmelzen...")
end

function sammeln()
    exports['progressBars']:startUI(13000, "Abbauen...")
end

function copper()
	ESX.UI.Menu.CloseAll()
	local elements = {}
	menuOpen = true

    for k, v in pairs(ESX.GetPlayerData().inventory) do
		local price = Config.Items[v.name]

		if price and v.count > 0 then
			table.insert(elements, {
				label = ('%s - <span style="color:green;">%s</span>'):format(v.label, '10', ESX.Math.GroupDigits(price)),
				name = v.name,
				price = price,

				-- menu properties
				type = 'slider',
				value = 1,
				min = 1,
				max = v.count
			})
        end
    end


	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'copper', {
		title    = 'Kupferhändler',
		align    = 'top-left',
		elements = elements
	}, function(data, menu)
        TriggerServerEvent('esx_miner:sellcopper', data.current.name, data.current.value)
    end, function(data, menu)
		menu.close()
		menuOpen = false
    end)
end

function iron()
	ESX.UI.Menu.CloseAll()
	local elements = {}
	menuOpen = true

    for k, v in pairs(ESX.GetPlayerData().inventory) do
		local price = Config.Iron[v.name]

		if price and v.count > 0 then
			table.insert(elements, {
				label = ('%s - <span style="color:green;">%s</span>'):format(v.label, '25', ESX.Math.GroupDigits(price)),
				name = v.name,
				price = price,

				-- menu properties
				type = 'slider',
				value = 1,
				min = 1,
				max = v.count
			})
        end
    end


	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'iron', {
		title    = 'Eisenhändler',
		align    = 'top-left',
		elements = elements
	}, function(data, menu)
        TriggerServerEvent('esx_miner:selliron', data.current.name, data.current.value)
    end, function(data, menu)
		menu.close()
		menuOpen = false
    end)
end

function gold()
	ESX.UI.Menu.CloseAll()
	local elements = {}
	menuOpen = true

    for k, v in pairs(ESX.GetPlayerData().inventory) do
		local price = Config.Gold[v.name]

		if price and v.count > 0 then
			table.insert(elements, {
				label = ('%s - <span style="color:green;">%s</span>'):format(v.label, '125', ESX.Math.GroupDigits(price)),
				name = v.name,
				price = price,

				-- menu properties
				type = 'slider',
				value = 1,
				min = 1,
				max = v.count
			})
        end
    end


	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'gold', {
		title    = 'Goldhändler',
		align    = 'top-left',
		elements = elements
	}, function(data, menu)
        TriggerServerEvent('esx_miner:sellgold', data.current.name, data.current.value)
    end, function(data, menu)
		menu.close()
		menuOpen = false
    end)
end

function diamond()
	ESX.UI.Menu.CloseAll()
	local elements = {}
	menuOpen = true

    for k, v in pairs(ESX.GetPlayerData().inventory) do
		local price = Config.Diamond[v.name]

		if price and v.count > 0 then
			table.insert(elements, {
				label = ('%s - <span style="color:green;">%s</span>'):format(v.label, '250', ESX.Math.GroupDigits(price)),
				name = v.name,
				price = price,

				-- menu properties
				type = 'slider',
				value = 1,
				min = 1,
				max = v.count
			})
        end
    end


	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'diamond', {
		title    = 'Diamantenhändler',
		align    = 'top-left',
		elements = elements
	}, function(data, menu)
        TriggerServerEvent('esx_miner:selldiamond', data.current.name, data.current.value)
    end, function(data, menu)
		menu.close()
		menuOpen = false
    end)
end

function Animation()
    local ped = PlayerPedId() 
    Citizen.CreateThread(function()
        while true do
            Citizen.Wait(0)
            if mineActive == true then
                RequestAnimDict("melee@hatchet@streamed_core_fps")
                Citizen.Wait(100)
                TaskPlayAnim((ped), 'melee@hatchet@streamed_core_fps', 'plyr_front_takedown', 8.0, 8.0, -1, 80, 0, 0, 0, 0)
                SetEntityHeading(ped, 270.0)
                Citizen.Wait(2500)
            end
            
            if washingActive == true or remeltingActive == true then
                RequestAnimDict("amb@prop_human_bum_bin@idle_a")
                Citizen.Wait(100)
                TaskPlayAnim((ped), 'amb@prop_human_bum_bin@idle_a', 'idle_a', 8.0, 8.0, -1, 81, 0, 0, 0, 0)
                Citizen.Wait(2500)
                FreezeEntityPosition(ped, false)
            end
        end
    end)
end
--[[
function Washing()
    local ped = PlayerPedId()
    RequestAnimDict("amb@prop_human_bum_bin@idle_a")
    washingActive = true
    Citizen.Wait(100)
    FreezeEntityPosition(ped, true)
    TaskPlayAnim((ped), 'amb@prop_human_bum_bin@idle_a', 'idle_a', 8.0, 8.0, -1, 81, 0, 0, 0, 0)
    Citizen.Wait(15900)
    ClearPedTasks(ped)
    FreezeEntityPosition(ped, false)
    washingActive = false
end

function Remelting()
    local ped = PlayerPedId()
    RequestAnimDict("amb@prop_human_bum_bin@idle_a")
    remeltingActive = true
    Citizen.Wait(100)
    FreezeEntityPosition(ped, true)
    TaskPlayAnim((ped), 'amb@prop_human_bum_bin@idle_a', 'idle_a', 8.0, 8.0, -1, 81, 0, 0, 0, 0)
    Citizen.Wait(15900)
    ClearPedTasks(ped)
    FreezeEntityPosition(ped, false)
    remeltingActive = false
end]]