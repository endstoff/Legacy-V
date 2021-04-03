ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

_menuPool  = NativeUI.CreatePool()

local notificationID = 0
local isNearWarehouse = false
local isAtWarehouse = false
local currentWarehouse = nil
local currentWarehouseData = nil
local currentPersonaldata = nil
local isAtLeave = false
local isInWarehouse = false
local isAtComputer = false 
local ownedWarehouses = {}
local isDoingMission = false
local gotWarehouses = false

local isNearSeller = false
local isAtSeller = false
local isSellerLoaded = false
local npc

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
    gotWarehouses = false
    TriggerServerEvent('hd_postop:getWarehousesFromPlayer')

    while not gotWarehouses do
        Wait(10)
    end

    ESX.TriggerServerCallback('hd_postop:getLastWarehouse', function(WarehouseID)
        if WarehouseID ~= nil or WarehouseID ~= 0 then
            for k, ownWarehouse in pairs(ownedWarehouses) do
                if ownWarehouse.id == tonumber(WarehouseID) then
                    for k2, Warehouse in pairs(Config.Warehouses) do
                        if Warehouse.name == ownWarehouse.name then
                            currentPersonaldata = ownWarehouse
                            currentWarehouseData = Warehouse
                            currentWarehouse = Warehouse.id
                            loadAppereance()
                            isInWarehouse = true
                            TriggerServerEvent('hd_postop:setPlayerInvisible', currentPersonaldata.id)
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
	SetBlipSprite(blip, 359)
	SetBlipDisplay(blip, 6)
	SetBlipScale(blip, 0.8)
	SetBlipColour(blip, 6)
	SetBlipAsShortRange(blip, true)
	BeginTextCommandSetBlipName("STRING");
	AddTextComponentString(Translation[Config.Locale]['seller_title'])
	EndTextCommandSetBlipName(blip)
end

Citizen.CreateThread(function()
	
	if Config.Debug then
		TriggerServerEvent('hd_postop:getWarehousesFromPlayer')  -- just for Debug
	end
	
    while true do

        if isNearWarehouse then
            for k, Warehouse in pairs(Config.Warehouses) do
                if Warehouse.id == currentWarehouse then
                    DrawMarker(1, Warehouse.enter.x, Warehouse.enter.y, Warehouse.enter.z - 0.98, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0*0.75, 1.0*0.75, 1.0, 66, 246, 66, 75, false, false, 2, false, false, false, false)
                    break
                end
            end
        elseif isInWarehouse then
            DrawMarker(27, currentWarehouseData.bossActions.x, currentWarehouseData.bossActions.y, currentWarehouseData.bossActions.z - 0.98, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0*0.75, 1.0*0.75, 1.0, 66, 246, 66, 75, false, false, 2, false, false, false, false)
            if isAtComputer then
                showInfobar(Translation[Config.Locale]['access_computer'])
                _menuPool:ProcessMenus()
                if IsControlJustReleased(0, 38) then
                    generateComputer()
                end
            end
        end
        if isAtWarehouse then
            _menuPool:ProcessMenus()
            for k, Warehouse in pairs(Config.Warehouses) do
                if Warehouse.id == currentWarehouse then
                    showInfobar(Translation[Config.Locale]['enter_Warehouse'] .. Warehouse.label .. Translation[Config.Locale]['enter_Warehouse_2'])
                    if IsControlJustReleased(0, 38) then
                        if #ownedWarehouses > 0 then
						
							_menuPool:Remove()
							collectgarbage()
							
							local selectMenu = NativeUI.CreateMenu(Translation[Config.Locale]['menu_enter_Warehouse'], nil)
							_menuPool:Add(selectMenu)
							
							local hasAtLeastOneWarehouse = false
							local dataForEnter = {}
                            for k, owned in pairs(ownedWarehouses) do
                                if owned.name == Warehouse.name then
									hasAtLeastOneWarehouse = true
									local WarehouseToSelect = NativeUI.CreateItem(Warehouse.label, '~b~')
									WarehouseToSelect:RightLabel('(~b~#' .. owned.id .. '~s~)')
									selectMenu:AddItem(WarehouseToSelect)
									
									table.insert(dataForEnter, {
									WarehouseData = Warehouse,
									personalData = owned,
									
									})
                                    --break
									
								end
                                if k == #ownedWarehouses then
									if hasAtLeastOneWarehouse then
									
										selectMenu.OnItemSelect = function(sender, item, index)
											local playerPed = PlayerPedId()
											currentPersonaldata = dataForEnter[index].personalData
											currentWarehouseData = dataForEnter[index].WarehouseData
											loadAppereance()
											DoScreenFadeOut(1000)
											Citizen.Wait(1000)
											SetEntityCoords(playerPed, currentWarehouseData.inside.x, currentWarehouseData.inside.y, currentWarehouseData.inside.z, currentWarehouseData.inside.rot)
											DoScreenFadeIn(1500)
											isInWarehouse = true
											TriggerServerEvent('hd_postop:setLastLogin', currentPersonaldata)
											TriggerServerEvent('hd_postop:setPlayerInvisible', currentPersonaldata.id)
											TriggerServerEvent('hd_postop:saveLastWarehouse', currentPersonaldata.id)
											_menuPool:CloseAllMenus()
										end
										
										selectMenu:Visible(not selectMenu:Visible())
										_menuPool:RefreshIndex()
										_menuPool:MouseEdgeEnabled (false)
									else
										buyWarehouseMenu(Warehouse)
									end
                                end
                            end
                        else
                            buyWarehouseMenu(Warehouse)
                        end
                    end
                    break
                end
            end
        elseif isAtLeave then
            showInfobar(Translation[Config.Locale]['leave_Warehouse'])

            if IsControlJustReleased(0, 38) then
                for k2, WarehouseToLeave in pairs(Config.Warehouses) do
                    --print(currentWarehouse)
                    if currentWarehouse == WarehouseToLeave.id then
                        local playerPed = PlayerPedId()
                        DoScreenFadeOut(1000)
                        Citizen.Wait(1000)
                        SetEntityCoords(playerPed, WarehouseToLeave.enter.x, WarehouseToLeave.enter.y, WarehouseToLeave.enter.z)
                        DoScreenFadeIn(1500)
                        
                        TriggerServerEvent('hd_postop:leaveWarehouse', currentPersonaldata.id)
                        TriggerServerEvent('hd_postop:saveLastWarehouse', 0)

                        isInWarehouse = false
                        currentPersonaldata = nil
                        currentWarehouseData = nil
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

                BikerWeedWarehouse = exports['bob74_ipl']:GetBikerWeedWarehouseObject()
                if currentPersonaldata.upgraded == 1 then
                    BikerWeedWarehouse.Style.Set(BikerWeedWarehouse.Style.basic)
                else
                    BikerWeedWarehouse.Style.Set(BikerWeedWarehouse.Style.upgrade)
                end

                if currentPersonaldata.upgraded == 3 then
                    BikerWeedWarehouse.Security.Set(BikerWeedWarehouse.Security.upgrade)
                else
                    BikerWeedWarehouse.Security.Set(BikerWeedWarehouse.Security.basic)
                end
                RefreshInterior(BikerWeedWarehouse.interiorId)
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

        elseif currentPersonaldata.type == 'coke' then

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

        isNearWarehouse = false
        isAtWarehouse = false
        isAtLeave = false
        isAtComputer = false
        isAtSeller = false
        isNearSeller = false

        for k, Warehouse in pairs(Config.Warehouses) do
            local distance = Vdist(playerCoords, Warehouse.enter.x, Warehouse.enter.y, Warehouse.enter.z)
            

            if distance < 25.0 then
                isNearWarehouse = true
                currentWarehouse = Warehouse.id
            end
            if distance < 1.0 then
                isAtWarehouse = true
            end
            if isInWarehouse then
                local distanceLeave = Vdist(playerCoords, Warehouse.inside.x, Warehouse.inside.y, Warehouse.inside.z)
                local distanceToComputer = Vdist(playerCoords, Warehouse.bossActions.x, Warehouse.bossActions.y, Warehouse.bossActions.z)
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
                    TriggerServerEvent('hd_postop:sellItems', v.sqlitem, quantity, v.priceBuy)
                end
            end
        end

        sellMenu:Visible(not sellMenu:Visible())
        _menuPool:RefreshIndex()
        _menuPool:MouseEdgeEnabled (false)

    end
end

function buyWarehouseMenu(WarehouseData)
    _menuPool:Remove()
    collectgarbage()
   
    local buyMenu = NativeUI.CreateMenu(Translation[Config.Locale]['menu_buy_Warehouse'], nil)
    _menuPool:Add(buyMenu)
    local labelWarehouse = NativeUI.CreateItem(Translation[Config.Locale]['menu_buy_name'], '~b~')
    labelWarehouse:RightLabel(WarehouseData.label)
    local typeWarehouse = NativeUI.CreateItem(Translation[Config.Locale]['menu_buy_type'], '~b~')
    if WarehouseData.type == 'wares' then
        typeWarehouse:RightLabel(Translation[Config.Locale]['wares'])
    end
    local priceWarehouse = NativeUI.CreateItem(Translation[Config.Locale]['menu_buy_price'], '~b~')
    priceWarehouse:RightLabel(WarehouseData.price .. '$')

    buyMenu:AddItem(labelWarehouse)
    buyMenu:AddItem(typeWarehouse)
    buyMenu:AddItem(priceWarehouse)
    local buy = _menuPool:AddSubMenu(buyMenu, Translation[Config.Locale]['menu_buy_Warehouse'], '~b~')
    local yes = NativeUI.CreateItem(Translation[Config.Locale]['menu_buy_confirm'], '~b~')
    yes:RightLabel('~b~→→→')
    buy:AddItem(yes)

    buy.OnItemSelect = function(sender, item, index)

        if item == yes then

            _menuPool:CloseAllMenus()
            TriggerServerEvent('hd_postop:buyWarehouse', WarehouseData)

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


    local computer = NativeUI.CreateMenu(currentWarehouseData.label , Translation[Config.Locale]['menu_computer_level'] .. currentPersonaldata.upgraded)
    _menuPool:Add(computer)
    
    local produced = NativeUI.CreateItem(Translation[Config.Locale]['menu_computer_produced'], Translation[Config.Locale]['menu_computer_produced_desc'])
    produced:RightLabel(math.floor(currentPersonaldata.finish / finishCapacity * 100) .. '% / ' .. currentPersonaldata.finish .. 'Pakete') --items / capacity
    
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
                    TriggerServerEvent('hd_postop:giveFinalItem', currentPersonaldata.id, quantity, currentPersonaldata.type)
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
                TriggerServerEvent('hd_postop:store', currentWarehouseData.type, currentPersonaldata.id, storeCapacity, quantity)
                _menuPool:CloseAllMenus()
            end
        end

    end

    
	local playersInArea = ESX.Game.GetPlayersInArea(currentWarehouseData.enter, 10.0)

    local gotOSResult = false
    if Config.useOneSyncInfinity then
        ESX.TriggerServerCallback('hd_postop:getPlayersInArea', function(playersInArea_res)
            playersInArea = playersInArea_res
            gotOSResult = true
        end, currentWarehouseData.enter, 10.0)
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
            TriggerServerEvent('hd_postop:startMission', 'self')
        end

    end

    otherBuy.OnItemSelect = function(sender, item, index)
		if Config.useOneSyncInfinity then
			TriggerServerEvent('hd_postop:requestMission', playersInArea[index].id, currentWarehouseData, currentPersonaldata)
		else
			TriggerServerEvent('hd_postop:requestMission', GetPlayerServerId(playersInArea[index]), currentWarehouseData, currentPersonaldata)
		end
        

    end

    local upgrade = _menuPool:AddSubMenu(computer, Translation[Config.Locale]['menu_upgrade'], nil)
    local upgradeWarehouse = _menuPool:AddSubMenu(upgrade, Translation[Config.Locale]['menu_upgrade_prod'], Translation[Config.Locale]['menu_upgrade_prod_desc'])

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

    upgradeWarehouse:AddItem(level2)
    upgradeWarehouse:AddItem(level3)

    upgradeWarehouse.OnItemSelect = function(sender, item, index)

        if currentPersonaldata.upgraded == 1 then
            if item == level2 then
                TriggerServerEvent('hd_postop:upgradeWarehouse', currentPersonaldata.id, 2, Config.Level2Price)
                _menuPool:CloseAllMenus()
            end
        elseif currentPersonaldata.upgraded == 2 then
            if item == level3 then
                TriggerServerEvent('hd_postop:upgradeWarehouse', currentPersonaldata.id, 3, Config.Level3Price)
                _menuPool:CloseAllMenus()
            end
        end

    end
    
    local finishCap = NativeUI.CreateItem(Translation[Config.Locale]['menu_stats_finished'], '~b~')
    finishCap:RightLabel(Config.FinishCapacity[currentPersonaldata.upgraded] .. 'Pakete')
    upgradeWarehouse:AddItem(finishCap)
    local storeCap = NativeUI.CreateItem(Translation[Config.Locale]['menu_stats_storecap'], Translation[Config.Locale]['menu_stats_storecap_desc'])
    storeCap:RightLabel(Config.StoreCapacity[currentPersonaldata.upgraded] .. 'Pakete')
    upgradeWarehouse:AddItem(storeCap)
    local productivity = NativeUI.CreateItem(Translation[Config.Locale]['menu_stats_productivity'], '~b~')
    productivity:RightLabel(Config.ProduceRate[currentPersonaldata.upgraded] .. 'Pakete / h')
    upgradeWarehouse:AddItem(productivity)

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
            TriggerServerEvent('hd_postop:buyVehicle', index, currentPersonaldata.id)
            _menuPool:CloseAllMenus()
        end

    end

	local alreadyTrusted = _menuPool:AddSubMenu(computer, Translation[Config.Locale]['menu_access'], Translation[Config.Locale]['menu_access_desc'])
	
	for k2, trusted in pairs(currentPersonaldata.trusted) do
		local trusted = NativeUI.CreateItem(trusted.name, Translation[Config.Locale]['menu_access_trust_remove'] .. trusted.name .. Translation[Config.Locale]['menu_access_trust_remove_2'])
		alreadyTrusted:AddItem(trusted)
		
		alreadyTrusted.OnItemSelect = function(sender, item, index)
			if item == trusted then
				TriggerServerEvent('hd_postop:updateTrusted', "del", currentPersonaldata.trusted[index].steamID, currentPersonaldata.id)
				_menuPool:CloseAllMenus()
			end
		end
	end

	local addTrusted = _menuPool:AddSubMenu(alreadyTrusted, Translation[Config.Locale]['menu_addTrusted'], '~b~')
	local playersInArea2 = ESX.Game.GetPlayersInArea(currentWarehouseData.enter, 10.0)

    local gotOSResult = false
    if Config.useOneSyncInfinity then
        ESX.TriggerServerCallback('hd_postop:getPlayersInArea', function(playersInArea_res)
            playersInArea2 = playersInArea_res
            gotOSResult = true
        end, currentWarehouseData.enter, 10.0)
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
				TriggerServerEvent('hd_postop:updateTrusted', "add", playersInArea2[index].id, currentPersonaldata.id)
			else
				TriggerServerEvent('hd_postop:updateTrusted', "add", GetPlayerServerId(playersInArea2[index]), currentPersonaldata.id)
			end
			
			_menuPool:CloseAllMenus()
		end
		--end
	end
	

    local sellWarehouse = _menuPool:AddSubMenu(computer, Translation[Config.Locale]['menu_sell'], Translation[Config.Locale]['menu_sell_desc'] .. currentWarehouseData.price / Config.SellDivide .. '$')

    local sellWarehouseConfirm = NativeUI.CreateItem(Translation[Config.Locale]['menu_sell_confirm'], '~b~')
    sellWarehouse:AddItem(sellWarehouseConfirm)

    sellWarehouseConfirm.Activated = function(sender, index)

        local playerPed = PlayerPedId()
        DoScreenFadeOut(1000)
        Citizen.Wait(1000)
        SetEntityCoords(playerPed, currentWarehouseData.enter.x, currentWarehouseData.enter.y, currentWarehouseData.enter.z)
        DoScreenFadeIn(1500)
        
        TriggerServerEvent('hd_postop:leaveWarehouse', currentPersonaldata.id)
        TriggerServerEvent('hd_postop:saveLastWarehouse', 0)

        TriggerServerEvent('hd_postop:sellWarehouse', currentPersonaldata.owner, currentPersonaldata.id, currentWarehouseData.price)
        sellWarehouse:Visible(false)

        isInWarehouse = false
        currentPersonaldata = nil
        currentWarehouseData = nil

    end


    computer:Visible(not computer:Visible())
    _menuPool:RefreshIndex()
	_menuPool:MouseEdgeEnabled (false)

end

local isAtSeller = false
local startedLoading = false
local startDistance = nil
local isDelivering = false

RegisterNetEvent('hd_postop:startStorageMission')
AddEventHandler('hd_postop:startStorageMission', function(target)

    if not isDoingMission then

        isDoingMission = true

        local random = math.random(1, #Config.StorageMissionDestinations)
        local dest = Config.StorageMissionDestinations[random].loc
        SetNewWaypoint(dest.x, dest.y)

        SpawnVehicle(Config.Vehicles[tonumber(currentPersonaldata.vehicle)].model, currentWarehouseData.spawnVehicle)

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
                TriggerServerEvent('hd_postop:payPlants', amountOfItems, price, target)
				TriggerServerEvent('hd_postop:givePlants', amountOfItems, target, currentPersonaldata.type)
            end
        end
    
    else
        TriggerEvent('esx:showAdvancedNotification', 'CHAR_MALC', Translation[Config.Locale]['mission_wrongCar'], Translation[Config.Locale]['mission_seller'], '')
        TriggerEvent('hd_postop:abortMission')
    end

end

RegisterNetEvent('hd_postop:deliverPlants')
AddEventHandler('hd_postop:deliverPlants', function(amount, target)


    SetNewWaypoint(currentWarehouseData.spawnVehicle.x, currentWarehouseData.spawnVehicle.y)
    ShowNotification(Translation[Config.Locale]['mission_backToWarehouse'])
    isDelivering = true

    local isAtGarage = false

    Citizen.CreateThread(function()

        while true do
            Citizen.Wait(300)
            if isDelivering then

                local ped = PlayerPedId()
                local playerCoords = GetEntityCoords(ped)
                local distance = Vdist(playerCoords, currentWarehouseData.spawnVehicle.x, currentWarehouseData.spawnVehicle.y, currentWarehouseData.spawnVehicle.z)

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
				DrawMarker(27, currentWarehouseData.spawnVehicle.x, currentWarehouseData.spawnVehicle.y, currentWarehouseData.spawnVehicle.z - 0.98, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0*4.0, 1.0*4.0, 1.0, 66, 246, 66, 75, false, false, 2, false, false, false, false)
			end
			
            if isAtGarage then
                showInfobar(Translation[Config.Locale]['mission_press_e_deliver'])
                if IsControlJustReleased(0, 38) then
					local car = Config.Vehicles[tonumber(currentPersonaldata.vehicle)].model
					local vehicle = GetVehiclePedIsIn(PlayerPedId(-1))

					if GetEntityModel(vehicle) == GetHashKey(car) then
						GiveCarBack(PlayerPedId(-1))
						TriggerEvent('hd_postop:abortMission')
						--TriggerServerEvent('hd_postop:givePlants', amount, target, currentPersonaldata.type)
					else
						ShowNotification(Translation[Config.Locale]['mission_wrongCar_deliver'])
					end
                    break
                end
            end

        end
    
    end)

end)

RegisterNetEvent('hd_postop:abortMission')
AddEventHandler('hd_postop:abortMission', function()

    isDoingMission = false
    isAtSeller = false
    startedLoading = false
    startDistance = nil
    isDelivering = false

end)

RegisterNetEvent('hd_postop:hasRequest')
AddEventHandler('hd_postop:hasRequest', function(target, WarehouseData_res, persData_res)

	hasInvite = true

    ShowNotification(Translation[Config.Locale]['mission_invited'])
	Citizen.CreateThread(function()
	
		while hasInvite do
			Citizen.Wait(0)
			if IsControlJustReleased(0, 38) then
                
                currentWarehouseData = WarehouseData_res
                currentPersonaldata = persData_res
                hasInvite = false
                TriggerServerEvent('hd_postop:startMission', target)
			end

		end
	
	end)

	Citizen.Wait(10000)
	if hasInvite then
		hasInvite = false
		ShowNotification(Translation[Config.Locale]['mission_invited_over'])
	end

end)

RegisterNetEvent('hd_postop:receiveWarehouses')
AddEventHandler('hd_postop:receiveWarehouses', function(WarehouseOwnerServer, steamID)
	ownedWarehouses = {}
	for k2, Warehouse in pairs(WarehouseOwnerServer) do
		if Warehouse.owner == steamID then
		
			ownedWarehouses[#ownedWarehouses + 1] = Warehouse
		
		end
		for k3, trusted in pairs(Warehouse.trusted) do
			if trusted.steamID == steamID then
				ownedWarehouses[#ownedWarehouses + 1] = Warehouse
			end
		end
	end
    ownedWarehouses = WarehouseOwnerServer
    gotWarehouses = true

    for k, v in pairs(ownedWarehouses) do
        for k2, Warehouse in pairs(Config.Warehouses) do
            if Warehouse.name == v.name then
            local blip = AddBlipForCoord(Warehouse.enter.x, Warehouse.enter.y)
                SetBlipSprite(blip, 478)
                SetBlipDisplay(blip, 6)
                SetBlipScale(blip, 0.8)
                SetBlipColour(blip, 2)
                SetBlipAsShortRange(blip, true)
                BeginTextCommandSetBlipName("STRING");
                AddTextComponentString(Warehouse.label)
                EndTextCommandSetBlipName(blip)
                break
            end
        end


    end
    currentPersonaldata = ownedWarehouses[1]

end)

RegisterNetEvent('hd_postop:updateWarehouses')
AddEventHandler('hd_postop:updateWarehouses', function(line, WarehouseOwnerUpdated)

    for k, v in pairs(ownedWarehouses) do
        if v.id == WarehouseOwnerUpdated.id then
            ownedWarehouses[k] = WarehouseOwnerUpdated
            currentPersonaldata = WarehouseOwnerUpdated
        break
        end
    end
end)

RegisterNetEvent('hd_postop:deleteWarehouse')
AddEventHandler('hd_postop:deleteWarehouse', function(toDeleteID)

    for k, v in pairs(ownedWarehouses) do
        if v.id == toDeleteID then
            table.remove(ownedWarehouses, k)
        break
        end
    end
end)

RegisterNetEvent('hd_postop:setNewWarehouseOwned')
AddEventHandler('hd_postop:setNewWarehouseOwned', function(WarehouseOwnerNew, owner_res)

    print(WarehouseOwnerNew.id)

    table.insert(ownedWarehouses, {
        id = WarehouseOwnerNew.id,
        owner = owner_res,
        name = WarehouseOwnerNew.name,
        type = WarehouseOwnerNew.type,
        upgraded = 1,
        vehicle = 1,
        store = 0,
        finish = 0,
        lastlogin = 0,
    })

    for k2, Warehouse in pairs(Config.Warehouses) do
        if Warehouse.name == WarehouseOwnerNew.name then
            local blip = AddBlipForCoord(Warehouse.enter.x, Warehouse.enter.y)
            SetBlipSprite(blip, 478)
            SetBlipDisplay(blip, 6)
            SetBlipScale(blip, 0.8)
            SetBlipColour(blip, 2)
            SetBlipAsShortRange(blip, true)
            BeginTextCommandSetBlipName("STRING");
            AddTextComponentString(Warehouse.label)
            EndTextCommandSetBlipName(blip)
        end
    end

end)

RegisterNetEvent('hd_postop:sellWarehouse')
AddEventHandler('hd_postop:sellWarehouse', function(WarehouseID)
    if #ownedWarehouses > 0 then
        for k, v in pairs(ownedWarehouses) do
            if v.id == WarehouseID then
                table.remove(ownedWarehouses, k)
            end
        end
    end

end)

RegisterNetEvent('hd_postop:msg')
AddEventHandler('hd_postop:msg', function(message)

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

RegisterNetEvent('hd_postop:setPlayerInvisible')
AddEventHandler('hd_postop:setPlayerInvisible', function(playerEnter, instanceId)
	local otherPlayer = GetPlayerFromServerId(playerEnter)
	if otherPlayer ~= nil then
		local otherPlayerPed = GetPlayerPed(otherPlayer)
		if otherPlayerPed ~= GetPlayerPed(-1) then
			table.insert(vanishedUser, otherPlayerPed)
			NetworkConcealEntity(otherPlayerPed, true)
		end
	end
end)

RegisterNetEvent('hd_postop:setPlayerVisible')
AddEventHandler('hd_postop:setPlayerVisible', function(playerEnter)
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
-- 		if isInWarehouse then
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

-- RegisterNetEvent('hd_postop:setPlayerInvisible')
-- AddEventHandler('hd_postop:setPlayerInvisible', function(playerEnter)

	
-- 	local otherPlayer = GetPlayerFromServerId(playerEnter)
	
-- 	if otherPlayer ~= nil then
-- 		local otherPlayerPed = GetPlayerPed(otherPlayer)
-- 		table.insert(vanishedUser, otherPlayerPed)
-- 	end

-- end)

-- RegisterNetEvent('hd_postop:setPlayerVisible')
-- AddEventHandler('hd_postop:setPlayerVisible', function(playerEnter)


-- 	local otherPlayer = GetPlayerFromServerId(playerEnter)
-- 	local otherPlayerPed = GetPlayerPed(otherPlayer)
	
-- 	for k, vanish in pairs(vanishedUser) do
-- 		if vanish == otherPlayerPed then
-- 			table.remove(vanishedUser, k)
-- 		end
-- 	end

-- end)
