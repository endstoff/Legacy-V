ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

_menuPool  = NativeUI.CreatePool()

local notificationID = 0
local isNearKitchen = false
local isAtKitchen = false
local currentKitchen = nil
local currentKitchenData = nil
local currentPersonaldata = nil
local isAtLeave = false
local isInKitchen = false
local isAtComputer = false 
local ownedKitchens = {}
local isDoingMission = false
local gotKitchens = false

local isNearSeller = false
local isAtSeller = false
local isSellerLoaded = false
local npc

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
    gotKitchens = false
    TriggerServerEvent('hd_puredrugs:getKitchensFromPlayer')

    while not gotKitchens do
        Wait(10)
    end

    ESX.TriggerServerCallback('hd_puredrugs:getLastKitchen', function(KitchenID)
        if KitchenID ~= nil or KitchenID ~= 0 then
            for k, ownKitchen in pairs(ownedKitchens) do
                if ownKitchen.id == tonumber(KitchenID) then
                    for k2, Kitchen in pairs(Config.Kitchens) do
                        if Kitchen.name == ownKitchen.name then
                            currentPersonaldata = ownKitchen
                            currentKitchenData = Kitchen
                            currentKitchen = Kitchen.id
                            loadAppereance()
                            isInKitchen = true
                            TriggerServerEvent('hd_puredrugs:setPlayerInvisible', currentPersonaldata.id)
                            break
                        end
                    end
                    break
                end
            end
        end
    end)

end)

if Config.showSellerBlip and Config.useSeller then
	local blip = AddBlipForCoord(Config.SellerLocation.x, Config.SellerLocation.y)
	SetBlipSprite(blip, 605)
	SetBlipDisplay(blip, 6)
	SetBlipScale(blip, 1.0)
	SetBlipColour(blip, 6)
	SetBlipAsShortRange(blip, true)
	BeginTextCommandSetBlipName("STRING");
	AddTextComponentString(Translation[Config.Locale]['seller_title'])
	EndTextCommandSetBlipName(blip)
end

Citizen.CreateThread(function()
	
	if Config.Debug then
		TriggerServerEvent('hd_puredrugs:getKitchensFromPlayer')  -- just for Debug
	end
	
    while true do

        if isNearKitchen then
            for k, Kitchen in pairs(Config.Kitchens) do
                if Kitchen.id == currentKitchen then
                    DrawMarker(1, Kitchen.enter.x, Kitchen.enter.y, Kitchen.enter.z - 0.98, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0*0.75, 1.0*0.75, 1.0, 66, 246, 66, 75, false, false, 2, false, false, false, false)
                    break
                end
            end
        elseif isInKitchen then
            DrawMarker(27, currentKitchenData.bossActions.x, currentKitchenData.bossActions.y, currentKitchenData.bossActions.z - 0.98, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0*0.75, 1.0*0.75, 1.0, 66, 246, 66, 75, false, false, 2, false, false, false, false)
            if isAtComputer then
                showInfobar(Translation[Config.Locale]['access_computer'])
                _menuPool:ProcessMenus()
                if IsControlJustReleased(0, 38) then
                    generateComputer()
                end
            end
        end
        if isAtKitchen then
            _menuPool:ProcessMenus()
            for k, Kitchen in pairs(Config.Kitchens) do
                if Kitchen.id == currentKitchen then
                    showInfobar(Translation[Config.Locale]['enter_Kitchen'] .. Kitchen.label .. Translation[Config.Locale]['enter_Kitchen_2'])
                    if IsControlJustReleased(0, 38) then
                        if #ownedKitchens > 0 then
						
							_menuPool:Remove()
							collectgarbage()
							
							local selectMenu = NativeUI.CreateMenu(Translation[Config.Locale]['menu_enter_Kitchen'], nil)
							_menuPool:Add(selectMenu)
							
							local hasAtLeastOneKitchen = false
							local dataForEnter = {}
                            for k, owned in pairs(ownedKitchens) do
                                if owned.name == Kitchen.name then
									hasAtLeastOneKitchen = true
									local KitchenToSelect = NativeUI.CreateItem(Kitchen.label, '~b~')
									KitchenToSelect:RightLabel('(~b~#' .. owned.id .. '~s~)')
									selectMenu:AddItem(KitchenToSelect)
									
									table.insert(dataForEnter, {
									KitchenData = Kitchen,
									personalData = owned,
									
									})
                                    --break
									
								end
                                if k == #ownedKitchens then
									if hasAtLeastOneKitchen then
									
										selectMenu.OnItemSelect = function(sender, item, index)
											local playerPed = PlayerPedId()
											currentPersonaldata = dataForEnter[index].personalData
											currentKitchenData = dataForEnter[index].KitchenData
											loadAppereance()
											DoScreenFadeOut(1000)
											Citizen.Wait(1000)
											SetEntityCoords(playerPed, currentKitchenData.inside.x, currentKitchenData.inside.y, currentKitchenData.inside.z, currentKitchenData.inside.rot)
											DoScreenFadeIn(1500)
											isInKitchen = true
											TriggerServerEvent('hd_puredrugs:setLastLogin', currentPersonaldata)
											TriggerServerEvent('hd_puredrugs:setPlayerInvisible', currentPersonaldata.id)
											TriggerServerEvent('hd_puredrugs:saveLastKitchen', currentPersonaldata.id)
											_menuPool:CloseAllMenus()
										end
										
										selectMenu:Visible(not selectMenu:Visible())
										_menuPool:RefreshIndex()
										_menuPool:MouseEdgeEnabled (false)
									else
										buyKitchenMenu(Kitchen)
									end
                                end
                            end
                        else
                            buyKitchenMenu(Kitchen)
                        end
                    end
                    break
                end
            end
        elseif isAtLeave then
            showInfobar(Translation[Config.Locale]['leave_Kitchen'])

            if IsControlJustReleased(0, 38) then
                for k2, KitchenToLeave in pairs(Config.Kitchens) do
                    --print(currentKitchen)
                    if currentKitchen == KitchenToLeave.id then
                        local playerPed = PlayerPedId()
                        DoScreenFadeOut(1000)
                        Citizen.Wait(1000)
                        SetEntityCoords(playerPed, KitchenToLeave.enter.x, KitchenToLeave.enter.y, KitchenToLeave.enter.z)
                        DoScreenFadeIn(1500)
                        
                        TriggerServerEvent('hd_puredrugs:leaveKitchen', currentPersonaldata.id)
                        TriggerServerEvent('hd_puredrugs:saveLastKitchen', 0)

                        isInKitchen = false
                        currentPersonaldata = nil
                        currentKitchenData = nil
                        break
                    end
                end
            end

        end

        if isAtSeller then
            _menuPool:ProcessMenus()
            showInfobar(Translation[Config.Locale]['infobar_seller'])
            if IsControlJustReleased(0, 38) then
                generateSellMenu()
            end
        end


    Citizen.Wait(0)
    end

end)

function loadAppereance()

    local InteriorId = 247297

    -- if currentPersonaldata.type == 'weed' then
    --     Citizen.CreateThread(function()
    --         if currentPersonaldata.upgraded == 1 then
    --             SetIplPropState(InteriorId, "weed_standard_equip", false, true)
    --         else
    --             SetIplPropState(InteriorId, "weed_upgrade_equip", false, true)
    --         end

    --         if currentPersonaldata.upgraded == 3 then
    --             SetIplPropState(InteriorId, "weed_security_upgrade", false, true)
    --         else
    --             SetIplPropState(InteriorId, "weed_low_security", false, true)
    --         end
    --         RefreshInterior(InteriorId)
    --     end)
    -- end
    if Config.UseIPLs then

        if currentPersonaldata.type == 'weed' then

            Citizen.CreateThread(function()

                BikerWeedKitchen = exports['bob74_ipl']:GetBikerWeedKitchenObject()
                if currentPersonaldata.upgraded == 1 then
                    BikerWeedKitchen.Style.Set(BikerWeedKitchen.Style.basic)
                else
                    BikerWeedKitchen.Style.Set(BikerWeedKitchen.Style.upgrade)
                end

                if currentPersonaldata.upgraded == 3 then
                    BikerWeedKitchen.Security.Set(BikerWeedKitchen.Security.upgrade)
                else
                    BikerWeedKitchen.Security.Set(BikerWeedKitchen.Security.basic)
                end
                RefreshInterior(BikerWeedKitchen.interiorId)
            end)

        elseif currentPersonaldata.type == 'meth' then

            Citizen.CreateThread(function()

                BikerMethLab = exports['bob74_ipl']:GetBikerMethLabObject()
                if currentPersonaldata.upgraded == 1 then
                    BikerMethLab.Style.Set(BikerMethLab.Style.basic)
                else
                    BikerMethLab.Style.Set(BikerMethLab.Style.upgrade)
                end

                if currentPersonaldata.upgraded == 3 then
                    BikerMethLab.Security.Set(BikerMethLab.Security.upgrade)
                else
                    BikerMethLab.Security.Set(BikerMethLab.Security.none)
                end
                RefreshInterior(BikerMethLab.interiorId)
            end)

        elseif currentPersonaldata.type == 'poppyjuice' then

            Citizen.CreateThread(function()

                BikerCocaine = exports['bob74_ipl']:GetBikerCocaineObject()
                if currentPersonaldata.upgraded == 1 then
                    BikerCocaine.Style.Set(BikerCocaine.Style.basic)
                    BikerCocaine.Details.Enable({BikerCocaine.Details.cokeUpgrade1, BikerCocaine.Details.cokeUpgrade2}, false)
                else
                    BikerCocaine.Style.Set(BikerCocaine.Style.upgrade)
                    BikerCocaine.Details.Enable({BikerCocaine.Details.cokeUpgrade1, BikerCocaine.Details.cokeUpgrade2}, true)
                end

                if currentPersonaldata.upgraded == 3 then
                    BikerCocaine.Security.Set(BikerCocaine.Security.upgrade)
                else
                    BikerCocaine.Security.Set(BikerCocaine.Security.basic)
                end
                RefreshInterior(BikerCocaine.interiorId)
            end)

        end

    end

end

Citizen.CreateThread(function()

    while true do
        local ped = PlayerPedId()
        local playerCoords = GetEntityCoords(ped)

        isNearKitchen = false
        isAtKitchen = false
        isAtLeave = false
        isAtComputer = false
        isAtSeller = false
        isNearSeller = false

        for k, Kitchen in pairs(Config.Kitchens) do
            local distance = Vdist(playerCoords, Kitchen.enter.x, Kitchen.enter.y, Kitchen.enter.z)
            

            if distance < 25.0 then
                isNearKitchen = true
                currentKitchen = Kitchen.id
            end
            if distance < 1.0 then
                isAtKitchen = true
            end
            if isInKitchen then
                local distanceLeave = Vdist(playerCoords, Kitchen.inside.x, Kitchen.inside.y, Kitchen.inside.z)
                local distanceToComputer = Vdist(playerCoords, Kitchen.bossActions.x, Kitchen.bossActions.y, Kitchen.bossActions.z)
                if distanceLeave < 2.3 then
                    isAtLeave = true
                elseif distanceToComputer < 1.4 then
                    isAtComputer = true
                end
            end

        end

        if Config.useSeller then
            local distanceToSeller = Vdist(playerCoords, Config.SellerLocation.x, Config.SellerLocation.y, Config.SellerLocation.z)
        
            if distanceToSeller <= 2.0 then
                isAtSeller = true
                isNearSeller = true
            elseif distanceToSeller <= 20.0 then
                isNearSeller = true
                if not isSellerLoaded then
        
                    RequestModel(GetHashKey(Config.SellerPedModel))
                    while not HasModelLoaded(GetHashKey(Config.SellerPedModel)) do
                        Wait(1)
                    end
                    npc = CreatePed(4, GetHashKey(Config.SellerPedModel), Config.SellerLocation.x, Config.SellerLocation.y, Config.SellerLocation.z - 1.0, Config.SellerLocation.rot, false, true)
                    FreezeEntityPosition(npc, true)	
                    SetEntityHeading(npc, Config.SellerLocation.rot)
                    SetEntityInvincible(npc, true)
                    SetBlockingOfNonTemporaryEvents(npc, true)  
        
                    isSellerLoaded = true
                end
            end
        
            if (isSellerLoaded and not isNearSeller) then
                DeleteEntity(npc)
                SetModelAsNoLongerNeeded(GetHashKey(ped))
                isSellerLoaded = false
            end
        end

    Citizen.Wait(350)
    end

end)

if Config.useSeller then
    function generateSellMenu()

        _menuPool:Remove()
        collectgarbage()

        local sellMenu = NativeUI.CreateMenu(Translation[Config.Locale]['seller_title'], nil)
        _menuPool:Add(sellMenu)

        for k, v in pairs(Config.SellItems) do

            local sell = NativeUI.CreateItem(v.label, '~b~')
            sell:RightLabel(v.priceBuy .. '$')
            sellMenu:AddItem(sell)

            sell.Activated = function(sender, index)

                local res_amount = CreateDialog(Translation[Config.Locale]['input_howmuch'])
                if tonumber(res_amount) then
                    local quantity = tonumber(res_amount)
                    TriggerServerEvent('hd_puredrugs:sellItems', v.sqlitem, quantity, v.priceBuy)
                end
            end
        end

        sellMenu:Visible(not sellMenu:Visible())
        _menuPool:RefreshIndex()
        _menuPool:MouseEdgeEnabled (false)

    end
end

function buyKitchenMenu(KitchenData)
    _menuPool:Remove()
    collectgarbage()
   
    local buyMenu = NativeUI.CreateMenu(Translation[Config.Locale]['menu_buy_Kitchen'], nil)
    _menuPool:Add(buyMenu)
    local labelKitchen = NativeUI.CreateItem(Translation[Config.Locale]['menu_buy_name'], '~b~')
    labelKitchen:RightLabel(KitchenData.label)
    local typeKitchen = NativeUI.CreateItem(Translation[Config.Locale]['menu_buy_type'], '~b~')
    if KitchenData.type == 'weed' then
        typeKitchen:RightLabel(Translation[Config.Locale]['weed'])
    elseif KitchenData.type == 'meth' then
        typeKitchen:RightLabel(Translation[Config.Locale]['meth'])
    elseif KitchenData.type == 'poppyjuice' then
        typeKitchen:RightLabel(Translation[Config.Locale]['poppyjuice'])
    end
    local priceKitchen = NativeUI.CreateItem(Translation[Config.Locale]['menu_buy_price'], '~b~')
    priceKitchen:RightLabel(KitchenData.price .. '$')

    buyMenu:AddItem(labelKitchen)
    buyMenu:AddItem(typeKitchen)
    buyMenu:AddItem(priceKitchen)
    local buy = _menuPool:AddSubMenu(buyMenu, Translation[Config.Locale]['menu_buy_Kitchen'], '~b~')
    local yes = NativeUI.CreateItem(Translation[Config.Locale]['menu_buy_confirm'], '~b~')
    yes:RightLabel('~b~→→→')
    buy:AddItem(yes)

    buy.OnItemSelect = function(sender, item, index)

        if item == yes then

            _menuPool:CloseAllMenus()
            TriggerServerEvent('hd_puredrugs:buyKitchen', KitchenData)

        end

    end

    buyMenu:Visible(not buyMenu:Visible())
    _menuPool:RefreshIndex()
	_menuPool:MouseEdgeEnabled (false)


end

function generateComputer()
    _menuPool:Remove()
    collectgarbage()

    local level = currentPersonaldata.upgraded
    local storeCapacity = Config.StoreCapacity[level]
    local finishCapacity = Config.FinishCapacity[level]


    local computer = NativeUI.CreateMenu(currentKitchenData.label , Translation[Config.Locale]['menu_computer_level'] .. currentPersonaldata.upgraded)
    _menuPool:Add(computer)
    
    local produced = NativeUI.CreateItem(Translation[Config.Locale]['menu_computer_produced'], Translation[Config.Locale]['menu_computer_produced_desc'])
    produced:RightLabel(math.floor(currentPersonaldata.finish / finishCapacity * 100) .. '% / ' .. currentPersonaldata.finish .. 'g') --items / capacity
    
    local storage = NativeUI.CreateItem(Translation[Config.Locale]['menu_computer_storage'], Translation[Config.Locale]['menu_computer_storage_desc'])
    storage:RightLabel(math.floor(currentPersonaldata.store / storeCapacity * 100) .. '%')

    --STATS
    computer:AddItem(produced)
    computer:AddItem(storage)

    computer.OnItemSelect = function(sender, item, index)

        if item == produced then
            local res_amount = CreateDialog(Translation[Config.Locale]['menu_computer_takedrugs'])
            if tonumber(res_amount) then
                local quantity = tonumber(res_amount)
                if quantity <= currentPersonaldata.finish then
                    TriggerServerEvent('hd_puredrugs:giveFinalItem', currentPersonaldata.id, quantity, currentPersonaldata.type)
                    _menuPool:CloseAllMenus()
                else
                    ShowNotification(Translation[Config.Locale]['menu_computer_notenoughdrugs'])
                end
               
            end
        end

    end

    local CollectStorage = _menuPool:AddSubMenu(computer, Translation[Config.Locale]['menu_storage'], nil)
    local insert = NativeUI.CreateItem(Translation[Config.Locale]['menu_storage_input'], Translation[Config.Locale]['menu_storage_input_desc'])
    local buyStorage = _menuPool:AddSubMenu(CollectStorage, Translation[Config.Locale]['menu_storage_buy'], Translation[Config.Locale]['menu_storage_buy_desc'])
    local selfBuy = NativeUI.CreateItem(Translation[Config.Locale]['menu_storage_buy_self'], '~b~')
    buyStorage:AddItem(selfBuy)
    local otherBuy = _menuPool:AddSubMenu(buyStorage, Translation[Config.Locale]['menu_storage_buy_others'], Translation[Config.Locale]['menu_storage_buy_others_desc'])
    CollectStorage:AddItem(insert)

    CollectStorage.OnItemSelect = function(sender, item, index)

        if item == insert then
            local res_amount = CreateDialog(Translation[Config.Locale]['menu_storage_inputseeds'])
            if tonumber(res_amount) then
                local quantity = tonumber(res_amount)
                TriggerServerEvent('hd_puredrugs:store', currentKitchenData.type, currentPersonaldata.id, storeCapacity, quantity)
                _menuPool:CloseAllMenus()
            end
        end

    end

    
	local playersInArea = ESX.Game.GetPlayersInArea(currentKitchenData.enter, 10.0)

    local gotOSResult = false
    if Config.useOneSyncInfinity then
        ESX.TriggerServerCallback('hd_puredrugs:getPlayersInArea', function(playersInArea_res)
            playersInArea = playersInArea_res
            gotOSResult = true
        end, currentKitchenData.enter, 10.0)
    end

    for i=1, 10, 1 do
        if not gotOSResult then
            Citizen.Wait(100)
        end
    end

	for k, player in pairs(playersInArea) do
	
		local playerInvite
		if Config.useOneSyncInfinity then
			playerInvite = NativeUI.CreateItem(player.name, Translation[Config.Locale]['storagemission_invite'] .. player.name .. Translation[Config.Locale]['storagemission_invite_2'])
			otherBuy:AddItem(playerInvite)
		else
			playerInvite = NativeUI.CreateItem(GetPlayerName(player), Translation[Config.Locale]['storagemission_invite'] .. GetPlayerName(player) .. Translation[Config.Locale]['storagemission_invite_2'])
			otherBuy:AddItem(playerInvite)
		end
		
	end

    buyStorage.OnItemSelect = function(sender, item, index)

        if item == selfBuy then
            _menuPool:CloseAllMenus()
            TriggerServerEvent('hd_puredrugs:startMission', 'self')
        end

    end

    otherBuy.OnItemSelect = function(sender, item, index)
		if Config.useOneSyncInfinity then
			TriggerServerEvent('hd_puredrugs:requestMission', playersInArea[index].id, currentKitchenData, currentPersonaldata)
		else
			TriggerServerEvent('hd_puredrugs:requestMission', GetPlayerServerId(playersInArea[index]), currentKitchenData, currentPersonaldata)
		end
        

    end

    local upgrade = _menuPool:AddSubMenu(computer, Translation[Config.Locale]['menu_upgrade'], nil)
    local upgradeKitchen = _menuPool:AddSubMenu(upgrade, Translation[Config.Locale]['menu_upgrade_prod'], Translation[Config.Locale]['menu_upgrade_prod_desc'])

    local level2 = NativeUI.CreateItem(Translation[Config.Locale]['menu_upgrade_prod_level2'], Translation[Config.Locale]['menu_upgrade_prod_level2_desc'])
    local level3 = NativeUI.CreateItem(Translation[Config.Locale]['menu_upgrade_prod_level3'], Translation[Config.Locale]['menu_upgrade_prod_level3_desc'])

    if currentPersonaldata.upgraded == 1 then
        level2:RightLabel('~g~' .. Config.Level2Price .. '$')
        level3:RightLabel('~r~' .. Translation[Config.Locale]['menu_upgrade_level2required'])
    elseif currentPersonaldata.upgraded == 2 then
        level2:SetRightBadge(BadgeStyle.Tick)
        level3:RightLabel('~g~' .. Config.Level3Price .. '$')
    elseif currentPersonaldata.upgraded == 3 then
        level2:SetRightBadge(BadgeStyle.Tick)
        level3:SetRightBadge(BadgeStyle.Tick)
    end

    upgradeKitchen:AddItem(level2)
    upgradeKitchen:AddItem(level3)

    upgradeKitchen.OnItemSelect = function(sender, item, index)

        if currentPersonaldata.upgraded == 1 then
            if item == level2 then
                TriggerServerEvent('hd_puredrugs:upgradeKitchen', currentPersonaldata.id, 2, Config.Level2Price)
                _menuPool:CloseAllMenus()
            end
        elseif currentPersonaldata.upgraded == 2 then
            if item == level3 then
                TriggerServerEvent('hd_puredrugs:upgradeKitchen', currentPersonaldata.id, 3, Config.Level3Price)
                _menuPool:CloseAllMenus()
            end
        end

    end
    
    local finishCap = NativeUI.CreateItem(Translation[Config.Locale]['menu_stats_finished'], '~b~')
    finishCap:RightLabel(Config.FinishCapacity[currentPersonaldata.upgraded] .. 'g')
    upgradeKitchen:AddItem(finishCap)
    local storeCap = NativeUI.CreateItem(Translation[Config.Locale]['menu_stats_storecap'], Translation[Config.Locale]['menu_stats_storecap_desc'])
    storeCap:RightLabel(Config.StoreCapacity[currentPersonaldata.upgraded] .. 'g')
    upgradeKitchen:AddItem(storeCap)
    local productivity = NativeUI.CreateItem(Translation[Config.Locale]['menu_stats_productivity'], '~b~')
    productivity:RightLabel(Config.ProduceRate[currentPersonaldata.upgraded] .. 'g / h')
    upgradeKitchen:AddItem(productivity)

    local buyVehicle = _menuPool:AddSubMenu(upgrade, Translation[Config.Locale]['menu_changeVehicle'], nil)

    --print(currentPersonaldata.vehicle)
    for k, veh in pairs(Config.Vehicles) do
        local car = NativeUI.CreateItem(veh.label, Translation[Config.Locale]['menu_changeVehicle_change'] .. veh.label .. Translation[Config.Locale]['menu_changeVehicle_change2'])
        if tonumber(currentPersonaldata.vehicle) == k then
            --car:RightLabel('~b~In Besitz')
            car:SetRightBadge(BadgeStyle.Tick)
        else
            car:RightLabel('~g~' .. veh.price .. '$')
        end
        buyVehicle:AddItem(car)
    end

    --local Item = NativeUI.CreateColouredItem("Coloured item", 'Desc', Colours.BlueLight, Colours.BlueDark)
    --computer:AddItem(Item)

    buyVehicle.OnItemSelect = function(sender, item, index)

        if currentPersonaldata.vehicle ~= index then
            TriggerServerEvent('hd_puredrugs:buyVehicle', index, currentPersonaldata.id)
            _menuPool:CloseAllMenus()
        end

    end

	local alreadyTrusted = _menuPool:AddSubMenu(computer, Translation[Config.Locale]['menu_access'], Translation[Config.Locale]['menu_access_desc'])
	
	for k2, trusted in pairs(currentPersonaldata.trusted) do
		local trusted = NativeUI.CreateItem(trusted.name, Translation[Config.Locale]['menu_access_trust_remove'] .. trusted.name .. Translation[Config.Locale]['menu_access_trust_remove_2'])
		alreadyTrusted:AddItem(trusted)
		
		alreadyTrusted.OnItemSelect = function(sender, item, index)
			if item == trusted then
				TriggerServerEvent('hd_puredrugs:updateTrusted', "del", currentPersonaldata.trusted[index].steamID, currentPersonaldata.id)
				_menuPool:CloseAllMenus()
			end
		end
	end

	local addTrusted = _menuPool:AddSubMenu(alreadyTrusted, Translation[Config.Locale]['menu_addTrusted'], '~b~')
	local playersInArea2 = ESX.Game.GetPlayersInArea(currentKitchenData.enter, 10.0)

    local gotOSResult = false
    if Config.useOneSyncInfinity then
        ESX.TriggerServerCallback('hd_puredrugs:getPlayersInArea', function(playersInArea_res)
            playersInArea2 = playersInArea_res
            gotOSResult = true
        end, currentKitchenData.enter, 10.0)
    end

    for i=1, 10, 1 do
        if not gotOSResult then
            Citizen.Wait(100)
        end
    end
	
	for k3, player in pairs(playersInArea2) do
		--if player ~= GetPlayerServerId(-1) then
		local playeradd
		if Config.useOneSyncInfinity then
			playeradd = NativeUI.CreateItem(player.name, Translation[Config.Locale]['menu_access_trust_add'] .. player.name .. Translation[Config.Locale]['menu_access_trust_add_2'])
			addTrusted:AddItem(playeradd)
		else
			playeradd = NativeUI.CreateItem(GetPlayerName(player), Translation[Config.Locale]['menu_access_trust_add'] .. GetPlayerName(player) .. Translation[Config.Locale]['menu_access_trust_add_2'])
			addTrusted:AddItem(playeradd)
		end
		
		addTrusted.OnItemSelect = function(sender, item, index)
			if Config.useOneSyncInfinity then
				TriggerServerEvent('hd_puredrugs:updateTrusted', "add", playersInArea2[index].id, currentPersonaldata.id)
			else
				TriggerServerEvent('hd_puredrugs:updateTrusted', "add", GetPlayerServerId(playersInArea2[index]), currentPersonaldata.id)
			end
			
			_menuPool:CloseAllMenus()
		end
		--end
	end
	

    local sellKitchen = _menuPool:AddSubMenu(computer, Translation[Config.Locale]['menu_sell'], Translation[Config.Locale]['menu_sell_desc'] .. currentKitchenData.price / Config.SellDivide .. '$')

    local sellKitchenConfirm = NativeUI.CreateItem(Translation[Config.Locale]['menu_sell_confirm'], '~b~')
    sellKitchen:AddItem(sellKitchenConfirm)

    sellKitchenConfirm.Activated = function(sender, index)

        local playerPed = PlayerPedId()
        DoScreenFadeOut(1000)
        Citizen.Wait(1000)
        SetEntityCoords(playerPed, currentKitchenData.enter.x, currentKitchenData.enter.y, currentKitchenData.enter.z)
        DoScreenFadeIn(1500)
        
        TriggerServerEvent('hd_puredrugs:leaveKitchen', currentPersonaldata.id)
        TriggerServerEvent('hd_puredrugs:saveLastKitchen', 0)

        TriggerServerEvent('hd_puredrugs:sellKitchen', currentPersonaldata.owner, currentPersonaldata.id, currentKitchenData.price)
        sellKitchen:Visible(false)

        isInKitchen = false
        currentPersonaldata = nil
        currentKitchenData = nil

    end


    computer:Visible(not computer:Visible())
    _menuPool:RefreshIndex()
	_menuPool:MouseEdgeEnabled (false)

end

local isAtSeller = false
local startedLoading = false
local startDistance = nil
local isDelivering = false

RegisterNetEvent('hd_puredrugs:startStorageMission')
AddEventHandler('hd_puredrugs:startStorageMission', function(target)

    if not isDoingMission then

        isDoingMission = true

        local random = math.random(1, #Config.StorageMissionDestinations)
        local dest = Config.StorageMissionDestinations[random].loc
        SetNewWaypoint(dest.x, dest.y)

        SpawnVehicle(Config.Vehicles[tonumber(currentPersonaldata.vehicle)].model, currentKitchenData.spawnVehicle)

        local blip = AddBlipForCoord(dest.x, dest.y)
        SetBlipSprite(blip, 514)
        SetBlipDisplay(blip, 6)
        SetBlipScale(blip, 1.0)
        SetBlipColour(blip, 10)
        SetBlipAsShortRange(blip, false)
        BeginTextCommandSetBlipName("STRING");
        AddTextComponentString(Translation[Config.Locale]['supplies'])
        EndTextCommandSetBlipName(blip)

        local playerCoords = GetEntityCoords(ped)
        startDistance = Vdist(playerCoords, dest.x, dest.y, dest.z)

        Citizen.CreateThread(function()

            while true do
                Citizen.Wait(300)
                if isDoingMission then

                    local ped = PlayerPedId()
                    playerCoords = GetEntityCoords(ped)
                    local distance = Vdist(playerCoords, dest.x, dest.y, dest.z)

                    isAtSeller = false

                    if distance <= 4.0 then
                        isAtSeller = true
                        if not startedLoading then
                            startLoading(blip, dest, target)
                            break
                        end

                    end
                end
            
            end
        
        end)
    else

        ShowNotification(Translation[Config.Locale]['already_started_mission'])
    end

end)

function startLoading(blip, dest, target)

    startedLoading = true
    RemoveBlip(blip)
    
    local car = Config.Vehicles[tonumber(currentPersonaldata.vehicle)].model
    local vehicle = GetVehiclePedIsIn(PlayerPedId(-1))

    if GetEntityModel(vehicle) == GetHashKey(car) then

        TriggerEvent('esx:showAdvancedNotification', 'CHAR_MALC', Translation[Config.Locale]['mission_startLoading'], Translation[Config.Locale]['mission_seller'], '')
        Citizen.Wait(10000)
        local readyLoaded = false

        for i = 1, 100, 1 do
            local ped = PlayerPedId()
            local playerCoords = GetEntityCoords(ped)
            local distance = Vdist(playerCoords, dest.x, dest.y, dest.z)

            if distance >= 15.0 then
                RemoveNotification(notificationID)
                notificationID = ShowNotification(Translation[Config.Locale]['mission_outofrange'])
                i = i -1
            else
                RemoveNotification(notificationID)
                notificationID = ShowNotification(Translation[Config.Locale]['mission_loading'] .. i .. Translation[Config.Locale]['mission_loading_2'])
            end
            Citizen.Wait(350)
            if i == 100 then

                local random = math.random(Config.Supplies.min, Config.Supplies.max)
                if currentPersonaldata.vehicle == 2 then
                    random = random + math.random(0, Config.VehicleModifier1)
                elseif currentPersonaldata.vehicle == 3 then
                    random = random + math.random(5, Config.VehicleModifier2)
                end

                --print(startDistance)
                local multiplier = 1.0
                --[[if startDistance <= 5200 then
                    multiplier = 0.70
                elseif startDistance <= 5500 then
                    multiplier = 0.85
                elseif startDistance <= 5800 then
                    multiplier = 1.0
                elseif startDistance <= 6300 then
                    multiplier = 1.15
                end--]]

                local amountOfItems = math.floor(multiplier * random)
                local price = (math.random(90, 110) / 100) * (amountOfItems * Config.PricePerPlant)
                TriggerServerEvent('hd_puredrugs:payPlants', amountOfItems, price, target)
				TriggerServerEvent('hd_puredrugs:givePlants', amountOfItems, target, currentPersonaldata.type)
            end
        end
    
    else
        TriggerEvent('esx:showAdvancedNotification', 'CHAR_MALC', Translation[Config.Locale]['mission_wrongCar'], Translation[Config.Locale]['mission_seller'], '')
        TriggerEvent('hd_puredrugs:abortMission')
    end

end

RegisterNetEvent('hd_puredrugs:deliverPlants')
AddEventHandler('hd_puredrugs:deliverPlants', function(amount, target)


    SetNewWaypoint(currentKitchenData.spawnVehicle.x, currentKitchenData.spawnVehicle.y)
    ShowNotification(Translation[Config.Locale]['mission_backToKitchen'])
    isDelivering = true

    local isAtGarage = false

    Citizen.CreateThread(function()

        while true do
            Citizen.Wait(300)
            if isDelivering then

                local ped = PlayerPedId()
                local playerCoords = GetEntityCoords(ped)
                local distance = Vdist(playerCoords, currentKitchenData.spawnVehicle.x, currentKitchenData.spawnVehicle.y, currentKitchenData.spawnVehicle.z)

                isAtGarage = false

                if distance <= 6.0 then
                    isAtGarage = true
                end
            end
        
        end
    
    end)

    Citizen.CreateThread(function()
    
        while true do
            Citizen.Wait(0)
			
			if Config.EnableMissionMarker then
				DrawMarker(27, currentKitchenData.spawnVehicle.x, currentKitchenData.spawnVehicle.y, currentKitchenData.spawnVehicle.z - 0.98, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0*4.0, 1.0*4.0, 1.0, 66, 246, 66, 75, false, false, 2, false, false, false, false)
			end
			
            if isAtGarage then
                showInfobar(Translation[Config.Locale]['mission_press_e_deliver'])
                if IsControlJustReleased(0, 38) then
					local car = Config.Vehicles[tonumber(currentPersonaldata.vehicle)].model
					local vehicle = GetVehiclePedIsIn(PlayerPedId(-1))

					if GetEntityModel(vehicle) == GetHashKey(car) then
						GiveCarBack(PlayerPedId(-1))
						TriggerEvent('hd_puredrugs:abortMission')
						--TriggerServerEvent('hd_puredrugs:givePlants', amount, target, currentPersonaldata.type)
					else
						ShowNotification(Translation[Config.Locale]['mission_wrongCar_deliver'])
					end
                    break
                end
            end

        end
    
    end)

end)

RegisterNetEvent('hd_puredrugs:abortMission')
AddEventHandler('hd_puredrugs:abortMission', function()

    isDoingMission = false
    isAtSeller = false
    startedLoading = false
    startDistance = nil
    isDelivering = false

end)

RegisterNetEvent('hd_puredrugs:hasRequest')
AddEventHandler('hd_puredrugs:hasRequest', function(target, KitchenData_res, persData_res)

	hasInvite = true

    ShowNotification(Translation[Config.Locale]['mission_invited'])
	Citizen.CreateThread(function()
	
		while hasInvite do
			Citizen.Wait(0)
			if IsControlJustReleased(0, 38) then
                
                currentKitchenData = KitchenData_res
                currentPersonaldata = persData_res
                hasInvite = false
                TriggerServerEvent('hd_puredrugs:startMission', target)
			end

		end
	
	end)

	Citizen.Wait(10000)
	if hasInvite then
		hasInvite = false
		ShowNotification(Translation[Config.Locale]['mission_invited_over'])
	end

end)

RegisterNetEvent('hd_puredrugs:receiveKitchens')
AddEventHandler('hd_puredrugs:receiveKitchens', function(KitchenOwnerServer, steamID)
	--ownedKitchens = {}
	for k2, Kitchen in pairs(KitchenOwnerServer) do
		if Kitchen.owner == steamID then
		
			ownedKitchens[#ownedKitchens + 1] = Kitchen
		
		end
		for k3, trusted in pairs(Kitchen.trusted) do
			if trusted.steamID == steamID then
				ownedKitchens[#ownedKitchens + 1] = Kitchen
			end
		end
	end
    --ownedKitchens = KitchenOwnerServer
    gotKitchens = true

    for k, v in pairs(ownedKitchens) do
        for k2, Kitchen in pairs(Config.Kitchens) do
            if Kitchen.name == v.name then
            --[[local blip = AddBlipForCoord(Kitchen.enter.x, Kitchen.enter.y)
                SetBlipSprite(blip, 140)
                SetBlipDisplay(blip, 6)
                SetBlipScale(blip, 1.2)
                SetBlipColour(blip, 2)
                SetBlipAsShortRange(blip, true)
                BeginTextCommandSetBlipName("STRING");
                AddTextComponentString(Kitchen.label)
                EndTextCommandSetBlipName(blip)
                break]]
            end
        end


    end
    --currentPersonaldata = ownedKitchens[1]

end)

RegisterNetEvent('hd_puredrugs:updateKitchens')
AddEventHandler('hd_puredrugs:updateKitchens', function(line, KitchenOwnerUpdated)

    for k, v in pairs(ownedKitchens) do
        if v.id == KitchenOwnerUpdated.id then
            ownedKitchens[k] = KitchenOwnerUpdated
            currentPersonaldata = KitchenOwnerUpdated
        break
        end
    end
end)

RegisterNetEvent('hd_puredrugs:deleteKitchen')
AddEventHandler('hd_puredrugs:deleteKitchen', function(toDeleteID)

    for k, v in pairs(ownedKitchens) do
        if v.id == toDeleteID then
            table.remove(ownedKitchens, k)
        break
        end
    end
end)

RegisterNetEvent('hd_puredrugs:setNewKitchenOwned')
AddEventHandler('hd_puredrugs:setNewKitchenOwned', function(KitchenOwnerNew, owner_res)

    --print(KitchenOwnerNew.id)

    table.insert(ownedKitchens, {
        id = KitchenOwnerNew.id,
        owner = owner_res,
        name = KitchenOwnerNew.name,
        type = KitchenOwnerNew.type,
        upgraded = 1,
        vehicle = 1,
        store = 0,
        finish = 0,
        lastlogin = 0,
    })

    for k2, Kitchen in pairs(Config.Kitchens) do
        if Kitchen.name == KitchenOwnerNew.name then
            --[[local blip = AddBlipForCoord(Kitchen.enter.x, Kitchen.enter.y)
            SetBlipSprite(blip, 140)
            SetBlipDisplay(blip, 6)
            SetBlipScale(blip, 1.2)
            SetBlipColour(blip, 2)
            SetBlipAsShortRange(blip, true)
            BeginTextCommandSetBlipName("STRING");
            AddTextComponentString(Kitchen.label)
            EndTextCommandSetBlipName(blip)]]
        end
    end

end)

RegisterNetEvent('hd_puredrugs:sellKitchen')
AddEventHandler('hd_puredrugs:sellKitchen', function(KitchenID)
    if #ownedKitchens > 0 then
        for k, v in pairs(ownedKitchens) do
            if v.id == KitchenID then
                table.remove(ownedKitchens, k)
            end
        end
    end

end)

RegisterNetEvent('hd_puredrugs:msg')
AddEventHandler('hd_puredrugs:msg', function(message)

    ShowNotification(message)

end)

function showInfobar(msg)

	CurrentActionMsg  = msg
	SetTextComponentFormat('STRING')
	AddTextComponentString(CurrentActionMsg)
	DisplayHelpTextFromStringLabel(0, 0, 1, -1)

end

function ShowNotification(text)
	SetNotificationTextEntry('STRING')
	AddTextComponentString(text)
	return DrawNotification(false, true)
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

function SpawnVehicle(modelHash, loc)
    Citizen.CreateThread(function()
        local model = modelHash
        RequestModel(model)
        while not HasModelLoaded(model) do
            Citizen.Wait(1)
        end
        local spawnedVehicle = CreateVehicle(model, loc.x, loc.y, loc.z, loc.rot, true, false)
        SetModelAsNoLongerNeeded(model)
        SetVehicleOnGroundProperly(spawnedVehicle)
        SetPedIntoVehicle(GetPlayerPed(-1), spawnedVehicle, - 1)
		SetEntityAsMissionEntity(spawnedVehicle)
		--SetVehicleNumberPlateText(spawnedVehicle, "UNKNOWN")
		--SetVehicleCustomPrimaryColour(spawnedVehicle, 0, 0, 0)
    end)
end

function GiveCarBack(playerPed)
	local vehicle = GetVehiclePedIsIn(playerPed, false)
	SetEntityAsMissionEntity(vehicle)
	DeleteVehicle(vehicle)
end

local vanishedUser = {}

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		local playerPed = PlayerPedId()
		if isinProperty then
			for k, user in pairs(vanishedUser) do
				if user ~= playerPed then
					-- NetworkConcealEntity(user, true)
					-- SetEntityLocallyInvisible(user)/*
					-- SetEntityNoCollisionEntity(playerPed,  user,  true)
					-- SetEntityLocallyInvisible(user)
                    -- SetEntityVisible(user, false, 0)
                    -- SetEntityNoCollisionEntity(playerPed, user, true)
				end
			end
		elseif #vanishedUser > 0 then
			for k, user in pairs(vanishedUser) do
				if user ~= playerPed then
					NetworkConcealEntity(user, false)
				end
			end
			vanishedUser = {}
		end
	end
end)

RegisterNetEvent('hd_puredrugs:setPlayerInvisible')
AddEventHandler('hd_puredrugs:setPlayerInvisible', function(playerEnter, instanceId)
	local otherPlayer = GetPlayerFromServerId(playerEnter)
	if otherPlayer ~= nil then
		local otherPlayerPed = GetPlayerPed(otherPlayer)
		if otherPlayerPed ~= GetPlayerPed(-1) then
			table.insert(vanishedUser, otherPlayerPed)
			NetworkConcealEntity(otherPlayerPed, true)
		end
	end
end)

RegisterNetEvent('hd_puredrugs:setPlayerVisible')
AddEventHandler('hd_puredrugs:setPlayerVisible', function(playerEnter)
	local otherPlayer = GetPlayerFromServerId(playerEnter)
	local otherPlayerPed = GetPlayerPed(otherPlayer)
	for k, vanish in pairs(vanishedUser) do
		if vanish == otherPlayerPed then
			table.remove(vanishedUser, k)
			NetworkConcealEntity(otherPlayerPed, false)
		end
	end
end)


-- Citizen.CreateThread(function()

-- 	while true do
-- 		Citizen.Wait(0)
-- 		local playerPed = PlayerPedId()
-- 		if isInKitchen then
-- 			for k, user in pairs(vanishedUser) do
-- 				if user ~= playerPed then
-- 					--SetEntityLocallyInvisible(user)
-- 					--SetEntityNoCollisionEntity(playerPed,  user,  true)
-- 					SetEntityLocallyInvisible(user)
--                     SetEntityVisible(user, false, 0)
--                     SetEntityNoCollisionEntity(playerPed, user, true)
-- 				end

-- 			end
-- 		end

-- 	end

-- end)

-- RegisterNetEvent('hd_puredrugs:setPlayerInvisible')
-- AddEventHandler('hd_puredrugs:setPlayerInvisible', function(playerEnter)

	
-- 	local otherPlayer = GetPlayerFromServerId(playerEnter)
	
-- 	if otherPlayer ~= nil then
-- 		local otherPlayerPed = GetPlayerPed(otherPlayer)
-- 		table.insert(vanishedUser, otherPlayerPed)
-- 	end

-- end)

-- RegisterNetEvent('hd_puredrugs:setPlayerVisible')
-- AddEventHandler('hd_puredrugs:setPlayerVisible', function(playerEnter)


-- 	local otherPlayer = GetPlayerFromServerId(playerEnter)
-- 	local otherPlayerPed = GetPlayerPed(otherPlayer)
	
-- 	for k, vanish in pairs(vanishedUser) do
-- 		if vanish == otherPlayerPed then
-- 			table.remove(vanishedUser, k)
-- 		end
-- 	end

-- end)
