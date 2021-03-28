ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

_menuPool  = NativeUI.CreatePool()

local jobXP = {}

local isInArea = false
local currentArea = nil
local currentProcessor = nil
local isAtProcessor = false
local isProcessing = false
local isAtSeller = false
local currentSeller = nil
local shopContent = {}
local gotContent = false
local isDoingDelivery = false
local currentDelivery = nil
local deliveryBlip
local isNearProcessor = false
local isNearSeller = false
local isProcessorPedLoaded = false
local ProcessorPed
local isSellerPedLoaded = false
local SellerPed 
local PlayerData

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
    ESX.PlayerData = xPlayer
    print('registered Job: ' .. xPlayer.job.name)
    TriggerServerEvent('myFarming:getJobXP')
    randomizePriceModifiers()
    TriggerServerEvent('myFarming:setRandomAssignments')
    loadBlips()
    refreshZones()
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	ESX.PlayerData.job = job
    PlayerData = ESX.GetPlayerData()
    loadBlips()
    refreshZones()
end)


local blipData  = {}
blipData['processor'] = {}
blipData['seller'] = {}

local availableFarmingZones = Config.FarmingAreas
local availableProcessor = Config.Processor
local availableSeller = Config.Seller

function refreshZones()
    availableFarmingZones = {}
    for k, v in pairs(Config.FarmingAreas) do
        if v.requiredJob == nil or ESX ~= nil and ESX.PlayerData ~= nil and ESX.PlayerData.job.name == v.requiredJob then
            table.insert(availableFarmingZones, v)
        end
    end

    availableProcessor = {}
    for k, v in pairs(Config.Processor) do
        if v.requiredJob == nil or ESX ~= nil and ESX.PlayerData ~= nil and ESX.PlayerData.job.name == v.requiredJob then
            table.insert(availableProcessor, v)
        end
    end

    availableSeller = {}
    for k, v in pairs(Config.Seller) do
        if v.requiredJob == nil or ESX ~= nil and ESX.PlayerData ~= nil and ESX.PlayerData.job.name == v.requiredJob then
            table.insert(availableSeller, v)
        end
    end


end

function loadBlips()

    for k, v in pairs(Config.FarmingAreas) do
        if v.blip.data ~= nil then
            RemoveBlip(v.blip.data)
        end
        if v.blip ~= nil then
            if v.requiredJob == nil or ESX ~= nil and ESX.PlayerData ~= nil and ESX.PlayerData.job.name == v.requiredJob then
                local blip = AddBlipForCoord(v.x, v.y, v.z)
                v.blip.data = blip
                SetBlipSprite(blip, v.blip.sprite) -- 280
                SetBlipColour(blip, v.blip.color) -- 37
                SetBlipScale(blip, 0.7)
                SetBlipAsShortRange(blip, true)
                --SetBlipHighDetail(blip, true)
                if Config.ShowFarmingBlipText then
                    BeginTextCommandSetBlipName("STRING")
                    AddTextComponentString(Translation[Config.Locale]['pre_collect'] .. v.items[1].label .. Translation[Config.Locale]['collect'])
                    --AddTextComponentString('Sammelgebiet')
                    EndTextCommandSetBlipName(blip)
                else
                    SetBlipHiddenOnLegend(blip, true)
                end

            end
		end
    end


    for k2, v2 in pairs(Config.Processor) do

        if blipData['processor'][k2] ~= nil then
            RemoveBlip(blipData['processor'][k2])
        end

        --print(v2.requiredJob)
        if v2.requiredJob == nil or ESX ~= nil and ESX.PlayerData ~= nil and ESX.PlayerData.job.name == v2.requiredJob then
            local blip = AddBlipForCoord(v2.x, v2.y, v2.z)
            blipData['processor'][k2] = blip
            SetBlipSprite(blip, Config.CraftBlipIcon)--0, --1.--489
            SetBlipColour(blip, Config.CraftBlipColour)
            SetBlipScale(blip, 0.8)
            SetBlipAsShortRange(blip, true)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString(v2.label)
            EndTextCommandSetBlipName(blip)
        end
    end

    for k3, v3 in pairs(Config.Seller) do

        if blipData['seller'][k3] ~= nil then
            RemoveBlip(blipData['seller'][k3])
        end

        if v3.requiredJob == nil or ESX ~= nil and ESX.PlayerData ~= nil and ESX.PlayerData.job.name == v3.requiredJob then
            local blip = AddBlipForCoord(v3.x, v3.y, v3.z)
            blipData['seller'][k3] = blip
            SetBlipSprite(blip, 605)--0, --1.--489
            SetBlipColour(blip, 5)
            SetBlipScale(blip, 0.8)
            SetBlipAsShortRange(blip, true)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString(v3.label)
            EndTextCommandSetBlipName(blip)
        end
    end
end

local blipLoaded = false
local blipRange = nil
local messageSent = false


Citizen.CreateThread(function()

    --DEBUG 
	--
    TriggerServerEvent('myFarming:getJobXP')
    randomizePriceModifiers()
    TriggerServerEvent('myFarming:setRandomAssignments')
    

    -- PlayerData.job = {}
    -- PlayerData.job.name = 'police'
	--Citizen.Wait(10000)
    loadBlips()
    refreshZones()
	--
    while true do
        Citizen.Wait(350)


        isAtProcessor = false
        isInArea = false
        isAtSeller = false
        isNearProcessor = false
        isNearSeller = false

        local ped = PlayerPedId()
        local playerCoords = GetEntityCoords(ped)

        if not isAtProcessor and not isAtSeller then
            for k, v in pairs(availableFarmingZones) do
                local distance = Vdist(playerCoords, v.x, v.y, v.z)

                if distance <= v.range then
                    isInArea = true
                    currentArea = v

                    if not messageSent then
                        ShowNotification(Translation[Config.Locale]['enter_farming'] .. v.items[1].label .. Translation[Config.Locale]['enter_farming2'])
                        messageSent = true
                    end

					if v.blip ~= nil then
						if not blipLoaded then
							blipLoaded = true
		
							blipRange = AddBlipForRadius(v.x, v.y, v.z, v.range) 
							SetBlipSprite (blipRange, 9)
							SetBlipColour (blipRange, v.blip.color)
							SetBlipAsShortRange(blipRange, true)
							SetBlipAlpha(blipRange, 50)
						end
					end

                    break
                end

            end
        end

        if not isInArea and not isAtSeller then

            for k2, v2 in pairs(availableProcessor) do
                local distance = Vdist(playerCoords, v2.x, v2.y, v2.z)

                if distance < 2.0 then
                    isAtProcessor = true
                end

                if distance < 20.0 then
                    currentProcessor = v2
                    isNearProcessor = true

                    if not isProcessorPedLoaded then

                        RequestModel(GetHashKey(v2.ped))
                        while not HasModelLoaded(GetHashKey(v2.ped)) do
                            Wait(1)
                        end
                        ProcessorPed = CreatePed(4, GetHashKey(v2.ped), v2.x, v2.y, v2.z - 1.0, v2.rot, false, true)
                        FreezeEntityPosition(ProcessorPed, true)	
                        SetEntityHeading(ProcessorPed, v2.rot)
                        SetEntityInvincible(ProcessorPed, true)
                        SetBlockingOfNonTemporaryEvents(ProcessorPed, true)                    
                        isProcessorPedLoaded = true

                    end

                end
            end

        end

        if (not isNearProcessor and isProcessorPedLoaded) then
            DeleteEntity(ProcessorPed)
			SetModelAsNoLongerNeeded(GetHashKey(currentProcessor.ped))
			isProcessorPedLoaded = false
        end

        if not isInArea and not isAtProcessor then

            for k3, v3 in pairs(availableSeller) do
                local distance = Vdist(playerCoords, v3.x, v3.y, v3.z)

                if distance < 2.0 then
                    currentSeller = v3
                    isAtSeller = true
                end

                if distance < 20.0 then
                    isNearSeller = true
                end

            end

        end

        if isDoingDelivery then

            local distance = Vdist(playerCoords, currentDelivery.destination.x, currentDelivery.destination.y, currentDelivery.destination.z)

            if distance < 1.4 then
                isDoingDelivery = false
                RemoveBlip(deliveryBlip)
                TriggerServerEvent('myFarming:finishDelivery', currentDelivery)
            end

        end

        if blipLoaded then
            if not isInArea then
                RemoveBlip(blipRange)
                blipLoaded = false
                messageSent = false
            end
        end
    end

end)

local isCollecting = false

Citizen.CreateThread(function()

    while true do
        Citizen.Wait(1)

        if isInArea then
			local player = PlayerPedId()
			if not IsPedInAnyVehicle(player) then
				if IsControlJustReleased(0, 38) then
					if not isCollecting then
						local random = math.random(currentArea.randoma, currentArea.randomb)
						isCollecting = true
						exports['pogressBar']:drawBar(currentArea.collectingTime * 1000, Translation[Config.Locale]['pre_collect'] .. currentArea.items[1].label .. Translation[Config.Locale]['collect']) -- 8000
						if currentArea.animation ~= nil then
							TaskStartScenarioInPlace(PlayerPedId(), currentArea.animation, 0, true)
							Citizen.Wait(currentArea.collectingTime * 1000)
							ClearPedTasksImmediately(PlayerPedId())
						else
							Citizen.Wait(currentArea.collectingTime * 1000)
						end

                        
                        if #currentArea.items == 1 then
							--[[local PlayerSkin
							TriggerEvent('skinchanger:getSkin', function(skin)
								PlayerSkin = skin
							end)
							if PlayerSkin ~= nil and PlayerSkin['bags_1'] ~= 0 then
								TriggerServerEvent('myFarming:collectItems', currentArea.items[1].name, currentArea.items[1].label, random, true, currentArea.xptype)
							else	
								TriggerServerEvent('myFarming:collectItems', currentArea.items[1].name, currentArea.items[1].label, random, false, currentArea.xptype)
							end--]]
                            TriggerServerEvent('myFarming:collectItems', currentArea.items[1].name, currentArea.items[1].label, random, currentArea.xptype)
                        else
                            local randomPercentage = math.random(1, 100)

                            for i=1, #currentArea.items, 1 do
                                --print(randomPercentage .. ' ' .. currentArea.items[i].percentage)
                                if randomPercentage <= currentArea.items[i].percentage then
									--[[local PlayerSkin
									TriggerEvent('skinchanger:getSkin', function(skin)
										PlayerSkin = skin
									end)
									print('Bag' .. PlayerSkin['bags_1'])
									if PlayerSkin ~= nil and PlayerSkin['bags_1'] ~= 0 then
										TriggerServerEvent('myFarming:collectItems', currentArea.items[i].name, currentArea.items[i].label, random, true, currentArea.xptype)
									else
										TriggerServerEvent('myFarming:collectItems', currentArea.items[i].name, currentArea.items[i].label, random, false, currentArea.xptype)
									end--]]
									TriggerServerEvent('myFarming:collectItems', currentArea.items[i].name, currentArea.items[i].label, random, currentArea.xptype)
                                    
                                    break
                                end
                            end
                        end
						--Abfrage Inventarlimit
						--TriggerServerEvent('myFarming:addJobXP', currentArea.name, random)
						--ShowNotification('~g~' .. random .. 'x ' .. currentArea.label .. ' ~s~gesammelt.')
						isCollecting = false
					end
				end
			end
        end

        if isAtProcessor then
            _menuPool:ProcessMenus()
            showInfobar(Translation[Config.Locale]['info_production'])
            if IsControlJustReleased(0, 38) then
                generateMenu()
            end

        end

        if isAtSeller then
            _menuPool:ProcessMenus()
            showInfobar(Translation[Config.Locale]['info_sell'])
            if IsControlJustReleased(0, 38) then
                if currentSeller.isExport then
                    generateSellMenu()
                else
                    generateLocalShopMenu()
                end
            end
        end
    end

end)

function generateLocalShopMenu()
    _menuPool:Remove()
    collectgarbage()

    local sellMenu = NativeUI.CreateMenu(currentSeller.label, Translation[Config.Locale]['info_available_missions'])
    _menuPool:Add(sellMenu)

    if isDoingDelivery then

        local runnigDelivery = NativeUI.CreateItem(Translation[Config.Locale]['info_current_mission'], '~b~')
        runnigDelivery:RightLabel(currentDelivery.label)
        sellMenu:AddItem(runnigDelivery)

        local s1 = Citizen.InvokeNative( 0x2EB41072B4C1E4C0, currentDelivery.destination.x, currentDelivery.destination.y, currentDelivery.destination.z, Citizen.PointerValueInt(), Citizen.PointerValueInt() )
	    local street1 = GetStreetNameFromHashKey(s1)
        local dest = NativeUI.CreateItem(Translation[Config.Locale]['info_destination'], '~b~')
        dest:RightLabel(street1)
        sellMenu:AddItem(dest)

        local price = NativeUI.CreateItem(Translation[Config.Locale]['info_reward'], '~b~')
        price:RightLabel('~g~' .. currentDelivery.price .. '$')
        sellMenu:AddItem(price)

        local spacer = NativeUI.CreateItem('~b~', '~b~')
        sellMenu:AddItem(spacer)

        local req = NativeUI.CreateItem(Translation[Config.Locale]['info_reqItems'], '~b~')
        sellMenu:AddItem(req)
        for k2, v2 in pairs(currentDelivery.requires) do
            local requiredItem = NativeUI.CreateItem('- ' .. v2.label, '~b~')
            requiredItem:RightLabel(v2.amount .. '~b~x')
            sellMenu:AddItem(requiredItem)
        end

        local spacer2 = NativeUI.CreateItem('~b~', '~b~')
        sellMenu:AddItem(spacer2)

        local abort = NativeUI.CreateItem(Translation[Config.Locale]['info_abort'], '~b~')
        abort:SetRightBadge(BadgeStyle.Alert)
        sellMenu:AddItem(abort)

        sellMenu.OnItemSelect = function(sender, item, index)

            if item == abort then
                isDoingDelivery = false
                TriggerServerEvent('myFarming:abortMission', currentDelivery.id)
                sellMenu:Visible(false)
                ShowNotification(Translation[Config.Locale]['info_abort_confirm'])
            elseif item == dest then
                SetNewWaypoint(currentDelivery.destination.x, currentDelivery.destination.y)
            end

        end

    else

        --local privateItems = NativeUI.CreateItem('~HUD_COLOUR_NET_PLAYER21~PRIVATE AUFTRÄGE', '~b~')
        --sellMenu:AddItem(privateItems)

        gotContent = false
        TriggerServerEvent('myFarming:getShopContent')

        while not gotContent do
            Wait(10)
        end

        for k, v in pairs(shopContent) do

            local prefix = ''
            local desc = nil
            if v.state == 1 then
                prefix = Translation[Config.Locale]['prefix_in_processing']
                desc = Translation[Config.Locale]['prefix_in_processing_desc']
            elseif v.recommendJob ~= nil then
                prefix = Translation[Config.Locale]['prefix_special']
                desc = Translation[Config.Locale]['prefix_special_desc'] .. v.recommendJob .. Translation[Config.Locale]['prefix_special_desc2']
            end

            local sub = _menuPool:AddSubMenu(sellMenu, ' ' .. prefix .. v.label, desc)
            sellMenu.Items[k]:RightLabel(v.price .. '$')

            local case = NativeUI.CreateItem(Translation[Config.Locale]['info_case'], '~b~')
            case:RightLabel(v.label)
            sub:AddItem(case)
            
            if v.recommendJob ~= nil then
                local reqJob = NativeUI.CreateItem(Translation[Config.Locale]['info_recommendJob'], Translation[Config.Locale]['info_recommendJob_desc'])
                reqJob:RightLabel('~p~' .. v.recommendJob)
                sub:AddItem(reqJob)
            end

            local price = NativeUI.CreateItem(Translation[Config.Locale]['info_reward'], '~b~')
            price:RightLabel('~g~' .. v.price .. '$')
            sub:AddItem(price)

            local s1 = Citizen.InvokeNative( 0x2EB41072B4C1E4C0, v.destination.x, v.destination.y, v.destination.z, Citizen.PointerValueInt(), Citizen.PointerValueInt() )
            local street1 = GetStreetNameFromHashKey(s1)
            local dest = NativeUI.CreateItem(Translation[Config.Locale]['info_destination'], '~b~')
            dest:RightLabel(street1)
            sub:AddItem(dest)

            local spacer = NativeUI.CreateItem('~b~', '~b~')
            sub:AddItem(spacer)

            local spacer2 = NativeUI.CreateItem('~b~', '~b~')

            local req = NativeUI.CreateItem(Translation[Config.Locale]['info_reqItems'], '~b~')
            --req:SetRightBadge(BadgeStyle.Tick)
            --req:RightLabel(#v.requires)
            sub:AddItem(req)
            
            
            
            

            for k2, v2 in pairs(v.requires) do
                local requiredItem = NativeUI.CreateItem('- ' .. v2.label, '~b~')
                requiredItem:RightLabel(v2.amount .. '~b~x')
                sub:AddItem(requiredItem)
            end

            local submit = NativeUI.CreateItem(Translation[Config.Locale]['info_accept'], Translation[Config.Locale]['info_accept_desc'])
            submit:SetRightBadge(BadgeStyle.Tick)

            sub:AddItem(spacer2)
            sub:AddItem(submit)

            sub.OnItemSelect = function(sender, item, index)

                if item == submit then
                    TriggerServerEvent('myFarming:startDelivery', v)
                elseif item == dest then
                    SetNewWaypoint(v.destination.x, v.destination.y)
                end

            end

        end

        --local jobItems = NativeUI.CreateItem('~HUD_COLOUR_NET_PLAYER21~GEWERBLICHE AUFTRÄGE', '~b~')
        --sellMenu:AddItem(jobItems)



    end


    sellMenu:Visible(not sellMenu:Visible())
    _menuPool:RefreshIndex()
	_menuPool:MouseEdgeEnabled (false)
end

function randomizePriceModifiers()

    for k, v in pairs(Config.Seller) do

        local random = math.random(97, 103)

        v.priceModifier = random / 100

    end

end

function generateSellMenu()

    _menuPool:Remove()
    collectgarbage()

    

    local sellMenu = NativeUI.CreateMenu(currentSeller.label, nil)
    _menuPool:Add(sellMenu)

    for k, v in pairs(Config.SellItems) do

        local sub = _menuPool:AddSubMenu(sellMenu, v.category)

        for k2, v2 in pairs(v.content) do
            --local buySellItem = NativeUI.CreateItem(v2.label, '~b~')
            --buySellItem:RightLabel(currentSeller.priceModifier * v2.priceBuy .. '$')
            --sub:AddItem(buySellItem)

            local buySellItem_sub = _menuPool:AddSubMenu(sub, v2.label)
            sub.Items[k2]:RightLabel(currentSeller.priceModifier * v2.priceBuy .. '$')

            local sell = NativeUI.CreateItem(Translation[Config.Locale]['sell'], Translation[Config.Locale]['sell_desc'])
            buySellItem_sub:AddItem(sell)

            buySellItem_sub.OnItemSelect = function(sender, item, index)

                if item == sell then
                    local res_amount = CreateDialog(Translation[Config.Locale]['input_howmuch'])
                    if tonumber(res_amount) then
                        local quantity = tonumber(res_amount)
                        --print(v2.sqlitem)
                        TriggerServerEvent('myFarming:sellItems', v2.sqlitem, quantity, currentSeller.priceModifier * v2.priceBuy)
                    end
                    
                end

            end
        end

    end

    
    sellMenu:Visible(not sellMenu:Visible())
    _menuPool:RefreshIndex()
	_menuPool:MouseEdgeEnabled (false)

end

function generateMenu()

    _menuPool:Remove()
    collectgarbage()
    
    local xpProcess = 0
    for x, xp in pairs(jobXP) do
        if xp.type == currentProcessor.XPType then
            xpProcess = xp.amount
            break
        end
    end


    local processorMenu = NativeUI.CreateMenu(currentProcessor.label, xpProcess .. Translation[Config.Locale]['xp'])
    _menuPool:Add(processorMenu)


    for j, cfg in pairs(Config.Items) do
        if cfg.id == currentProcessor.ItemsId then
            if cfg.reqXP <= xpProcess then
                local reqString = ''
                for k, v in pairs(cfg.reqItems) do
                
                    reqString = reqString .. ' ' .. v.amount .. 'x ' .. v.label
            
                end

                --local craftItem = NativeUI.CreateItem(cfg.newitem.label .. ' herstellen', 'Benötigt ' .. reqString)
                --processorMenu:AddItem(craftItem)
                local craftItem = _menuPool:AddSubMenu(processorMenu,Translation[Config.Locale]['pre_craft'] .. cfg.newitem.label .. Translation[Config.Locale]['craft'], Translation[Config.Locale]['required'] .. reqString)

                local startCrafting = NativeUI.CreateItem(Translation[Config.Locale]['start_craft'], '~b~')
                craftItem:AddItem(startCrafting)

                craftItem.OnItemSelect = function(sender, item, index)

                    if item == startCrafting then
                        TriggerServerEvent('myFarming:craftItem', cfg)
                        --TriggerServerEvent('myFarming:craftItem', cfg.reqItems, cfg.newitem, cfg.newitemamount)
                    end

                end

            else

                local craftItemNotPossible = NativeUI.CreateItem('~c~' .. cfg.newitem.label, Translation[Config.Locale]['not_enough_xp'] .. cfg.reqXP .. Translation[Config.Locale]['not_enough_xp_required'])
                craftItemNotPossible:SetRightBadge(BadgeStyle.Lock)
                processorMenu:AddItem(craftItemNotPossible)

            end
        end
    end
    


    processorMenu:Visible(not processorMenu:Visible())
    _menuPool:RefreshIndex()
	_menuPool:MouseEdgeEnabled (false)

end

RegisterNetEvent('myFarming:startCrafting')
AddEventHandler('myFarming:startCrafting', function(itemData, craftAmount)

    if not isProcessing then
        
        isProcessing = true
        exports['pogressBar']:drawBar((Config.CraftTime * 1000) * craftAmount, itemData.newitem.label .. Translation[Config.Locale]['craft'] .. ' (' .. craftAmount .. 'x)')

        local time = 0
        local ped = PlayerPedId()
        local oldPlayerCoords = GetEntityCoords(ped)

        Citizen.CreateThread(function()
            while true do
                Citizen.Wait(1000)

                time = time + 1
                local currentPos = GetEntityCoords(ped)
                local distance = Vdist(oldPlayerCoords, currentPos.x, currentPos.y, currentPos.z)

                if distance > 5 then

                    ShowNotification(Translation[Config.Locale]['notify_out_of_range'])
                    exports['pogressBar']:drawBar(500, Translation[Config.Locale]['notify_aborted'], function()
                    end, {
                        color = 'red',
                    })
                    isProcessing = false
                    break
                elseif time == Config.CraftTime * craftAmount then

                    TriggerServerEvent('myFarming:finishedCrafting', itemData, craftAmount)
                    isProcessing = false
                    break
                end


            end
        end)

    end

end)



RegisterNetEvent('myFarming:startDelivery_cl')
AddEventHandler('myFarming:startDelivery_cl', function(deliveryData)

    isDoingDelivery = true
    currentDelivery = deliveryData

    _menuPool:CloseAllMenus()
    generateLocalShopMenu()

    deliveryBlip = AddBlipForCoord(deliveryData.destination.x, deliveryData.destination.y, deliveryData.destination.z)
    SetBlipSprite(deliveryBlip, 432)--0, --1.--489
    SetBlipColour(deliveryBlip, 18)
    SetBlipScale(deliveryBlip, 0.8)
    SetBlipAsShortRange(deliveryBlio, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString('Lieferung abgeben')
    EndTextCommandSetBlipName(deliveryBlip)

    SetNewWaypoint(deliveryData.destination.x, deliveryData.destination.y)
    ShowNotification(Translation[Config.Locale]['mission_started'] .. deliveryData.label .. Translation[Config.Locale]['mission_started2'])



end)


RegisterNetEvent('myFarming:receiveJobXP')
AddEventHandler('myFarming:receiveJobXP', function(xp)

    jobXP = xp

    --print(jobXP[1].type)

end)

RegisterNetEvent('myFarming:receiveShopContent')
AddEventHandler('myFarming:receiveShopContent', function(content)

    shopContent = content
    gotContent = true

end)

RegisterNetEvent('myFarming:msg')
AddEventHandler('myFarming:msg', function(msg)

    ShowNotification(msg)

end)


function ShowNotification(text)
	SetNotificationTextEntry('STRING')
	AddTextComponentString(text)
	return DrawNotification(false, true)
end

function showInfobar(msg)

	CurrentActionMsg  = msg
	SetTextComponentFormat('STRING')
	AddTextComponentString(CurrentActionMsg)
	DisplayHelpTextFromStringLabel(0, 0, 1, -1)

end

function CreateDialog(OnScreenDisplayTitle_shopmenu) --general OnScreenDisplay for KeyboardInput
	AddTextEntry(OnScreenDisplayTitle_shopmenu, OnScreenDisplayTitle_shopmenu)
	DisplayOnscreenKeyboard(1, OnScreenDisplayTitle_shopmenu, "", "", "", "", "", 32)
	while (UpdateOnscreenKeyboard() == 0) do
		DisableAllControlActions(0);
		Wait(0);
	end
	if (GetOnscreenKeyboardResult()) then
		local displayResult = GetOnscreenKeyboardResult()
		return displayResult
	end
end

