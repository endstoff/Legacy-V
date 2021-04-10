ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

_menuPool  = NativeUI.CreatePool()

local notificationID = 0
local isNearFarm = false
local isAtFarm = false
local currentFarm = nil
local currentFarmData = nil
local currentPersonaldata = nil
local isAtLeave = false
local isInFarm = false
local isAtComputer = false 
local ownedFarms = {}
local isDoingMission = false
local gotFarms = false

local isNearSeller = false
local isAtSeller = false
local isSellerLoaded = false
local npc

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
    gotFarms = false
    TriggerServerEvent('myDrugs:getFarmsFromPlayer')

    while not gotFarms do
        Wait(10)
    end

    ESX.TriggerServerCallback('myDrugs:getLastFarm', function(farmID)
        if farmID ~= nil or farmID ~= 0 then
            for k, ownfarm in pairs(ownedFarms) do
                if ownfarm.id == tonumber(farmID) then
                    for k2, farm in pairs(Config.Farms) do
                        if farm.name == ownfarm.name then
                            currentPersonaldata = ownfarm
                            currentFarmData = farm
                            currentFarm = farm.id
                            loadAppereance()
                            isInFarm = true
                            TriggerServerEvent('myDrugs:setPlayerInvisible', currentPersonaldata.id)
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
		TriggerServerEvent('myDrugs:getFarmsFromPlayer')  -- just for Debug
	end
	
    while true do

        if isNearFarm then
            for k, farm in pairs(Config.Farms) do
                if farm.id == currentFarm then
                    DrawMarker(1, farm.enter.x, farm.enter.y, farm.enter.z - 0.98, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0*0.75, 1.0*0.75, 1.0, 66, 246, 66, 75, false, false, 2, false, false, false, false)
                    break
                end
            end
        elseif isInFarm then
            DrawMarker(27, currentFarmData.bossActions.x, currentFarmData.bossActions.y, currentFarmData.bossActions.z - 0.98, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0*0.75, 1.0*0.75, 1.0, 66, 246, 66, 75, false, false, 2, false, false, false, false)
            if isAtComputer then
                showInfobar(Translation[Config.Locale]['access_computer'])
                _menuPool:ProcessMenus()
                if IsControlJustReleased(0, 38) then
                    generateComputer()
                end
            end
        end
        if isAtFarm then
            _menuPool:ProcessMenus()
            for k, farm in pairs(Config.Farms) do
                if farm.id == currentFarm then
                    showInfobar(Translation[Config.Locale]['enter_farm'] .. farm.label .. Translation[Config.Locale]['enter_farm_2'])
                    if IsControlJustReleased(0, 38) then
                        if #ownedFarms > 0 then
						
							_menuPool:Remove()
							collectgarbage()
							
							local selectMenu = NativeUI.CreateMenu(Translation[Config.Locale]['menu_enter_farm'], nil)
							_menuPool:Add(selectMenu)
							
							local hasAtLeastOneFarm = false
							local dataForEnter = {}
                            for k, owned in pairs(ownedFarms) do
                                if owned.name == farm.name then
									hasAtLeastOneFarm = true
									local farmToSelect = NativeUI.CreateItem(farm.label, '~b~')
									farmToSelect:RightLabel('(~b~#' .. owned.id .. '~s~)')
									selectMenu:AddItem(farmToSelect)
									
									table.insert(dataForEnter, {
									farmData = farm,
									personalData = owned,
									
									})
                                    --break
									
								end
                                if k == #ownedFarms then
									if hasAtLeastOneFarm then
									
										selectMenu.OnItemSelect = function(sender, item, index)
											local playerPed = PlayerPedId()
											currentPersonaldata = dataForEnter[index].personalData
											currentFarmData = dataForEnter[index].farmData
											loadAppereance()
											DoScreenFadeOut(1000)
											Citizen.Wait(1000)
											SetEntityCoords(playerPed, currentFarmData.inside.x, currentFarmData.inside.y, currentFarmData.inside.z, currentFarmData.inside.rot)
											DoScreenFadeIn(1500)
											isInFarm = true
											TriggerServerEvent('myDrugs:setLastLogin', currentPersonaldata)
											TriggerServerEvent('myDrugs:setPlayerInvisible', currentPersonaldata.id)
											TriggerServerEvent('myDrugs:saveLastFarm', currentPersonaldata.id)
											_menuPool:CloseAllMenus()
										end
										
										selectMenu:Visible(not selectMenu:Visible())
										_menuPool:RefreshIndex()
										_menuPool:MouseEdgeEnabled (false)
									else
										buyFarmMenu(farm)
									end
                                end
                            end
                        else
                            buyFarmMenu(farm)
                        end
                    end
                    break
                end
            end
        elseif isAtLeave then
            showInfobar(Translation[Config.Locale]['leave_farm'])

            if IsControlJustReleased(0, 38) then
                for k2, farmToLeave in pairs(Config.Farms) do
                    --print(currentFarm)
                    if currentFarm == farmToLeave.id then
                        local playerPed = PlayerPedId()
                        DoScreenFadeOut(1000)
                        Citizen.Wait(1000)
                        SetEntityCoords(playerPed, farmToLeave.enter.x, farmToLeave.enter.y, farmToLeave.enter.z)
                        DoScreenFadeIn(1500)
                        
                        TriggerServerEvent('myDrugs:leaveFarm', currentPersonaldata.id)
                        TriggerServerEvent('myDrugs:saveLastFarm', 0)

                        isInFarm = false
                        currentPersonaldata = nil
                        currentFarmData = nil
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

                BikerWeedFarm = exports['bob74_ipl']:GetBikerWeedFarmObject()
                if currentPersonaldata.upgraded == 1 then
                    BikerWeedFarm.Style.Set(BikerWeedFarm.Style.basic)
                else
                    BikerWeedFarm.Style.Set(BikerWeedFarm.Style.upgrade)
                end

                if currentPersonaldata.upgraded == 3 then
                    BikerWeedFarm.Security.Set(BikerWeedFarm.Security.upgrade)
                else
                    BikerWeedFarm.Security.Set(BikerWeedFarm.Security.basic)
                end
                RefreshInterior(BikerWeedFarm.interiorId)
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

        isNearFarm = false
        isAtFarm = false
        isAtLeave = false
        isAtComputer = false
        isAtSeller = false
        isNearSeller = false

        for k, farm in pairs(Config.Farms) do
            local distance = Vdist(playerCoords, farm.enter.x, farm.enter.y, farm.enter.z)
            

            if distance < 25.0 then
                isNearFarm = true
                currentFarm = farm.id
            end
            if distance < 1.0 then
                isAtFarm = true
            end
            if isInFarm then
                local distanceLeave = Vdist(playerCoords, farm.inside.x, farm.inside.y, farm.inside.z)
                local distanceToComputer = Vdist(playerCoords, farm.bossActions.x, farm.bossActions.y, farm.bossActions.z)
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
                    TriggerServerEvent('myDrugs:sellItems', v.sqlitem, quantity, v.priceBuy)
                end
            end
        end

        sellMenu:Visible(not sellMenu:Visible())
        _menuPool:RefreshIndex()
        _menuPool:MouseEdgeEnabled (false)

    end
end

function buyFarmMenu(farmData)
    _menuPool:Remove()
    collectgarbage()
   
    local buyMenu = NativeUI.CreateMenu(Translation[Config.Locale]['menu_buy_farm'], nil)
    _menuPool:Add(buyMenu)
    local labelFarm = NativeUI.CreateItem(Translation[Config.Locale]['menu_buy_name'], '~b~')
    labelFarm:RightLabel(farmData.label)
    local typeFarm = NativeUI.CreateItem(Translation[Config.Locale]['menu_buy_type'], '~b~')
    if farmData.type == 'weed' then
        typeFarm:RightLabel(Translation[Config.Locale]['weed'])
    elseif farmData.type == 'meth' then
        typeFarm:RightLabel(Translation[Config.Locale]['meth'])
    elseif farmData.type == 'coke' then
        typeFarm:RightLabel(Translation[Config.Locale]['coke'])
    end
    local priceFarm = NativeUI.CreateItem(Translation[Config.Locale]['menu_buy_price'], '~b~')
    priceFarm:RightLabel(farmData.price .. '$')

    buyMenu:AddItem(labelFarm)
    buyMenu:AddItem(typeFarm)
    buyMenu:AddItem(priceFarm)
    local buy = _menuPool:AddSubMenu(buyMenu, Translation[Config.Locale]['menu_buy_farm'], '~b~')
    local yes = NativeUI.CreateItem(Translation[Config.Locale]['menu_buy_confirm'], '~b~')
    yes:RightLabel('~b~→→→')
    buy:AddItem(yes)

    buy.OnItemSelect = function(sender, item, index)

        if item == yes then

            _menuPool:CloseAllMenus()
            TriggerServerEvent('myDrugs:buyFarm', farmData)

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


    local computer = NativeUI.CreateMenu(currentFarmData.label , Translation[Config.Locale]['menu_computer_level'] .. currentPersonaldata.upgraded)
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
                    TriggerServerEvent('myDrugs:giveFinalItem', currentPersonaldata.id, quantity, currentPersonaldata.type)
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
                TriggerServerEvent('myDrugs:store', currentFarmData.type, currentPersonaldata.id, storeCapacity, quantity)
                _menuPool:CloseAllMenus()
            end
        end

    end

    
	local playersInArea = ESX.Game.GetPlayersInArea(currentFarmData.enter, 10.0)

    local gotOSResult = false
    if Config.useOneSyncInfinity then
        ESX.TriggerServerCallback('myDrugs:getPlayersInArea', function(playersInArea_res)
            playersInArea = playersInArea_res
            gotOSResult = true
        end, currentFarmData.enter, 10.0)
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
            TriggerServerEvent('myDrugs:startMission', 'self')
        end

    end

    otherBuy.OnItemSelect = function(sender, item, index)
		if Config.useOneSyncInfinity then
			TriggerServerEvent('myDrugs:requestMission', playersInArea[index].id, currentFarmData, currentPersonaldata)
		else
			TriggerServerEvent('myDrugs:requestMission', GetPlayerServerId(playersInArea[index]), currentFarmData, currentPersonaldata)
		end
        

    end

    local upgrade = _menuPool:AddSubMenu(computer, Translation[Config.Locale]['menu_upgrade'], nil)
    local upgradeFarm = _menuPool:AddSubMenu(upgrade, Translation[Config.Locale]['menu_upgrade_prod'], Translation[Config.Locale]['menu_upgrade_prod_desc'])

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

    upgradeFarm:AddItem(level2)
    upgradeFarm:AddItem(level3)

    upgradeFarm.OnItemSelect = function(sender, item, index)

        if currentPersonaldata.upgraded == 1 then
            if item == level2 then
                TriggerServerEvent('myDrugs:upgradeFarm', currentPersonaldata.id, 2, Config.Level2Price)
                _menuPool:CloseAllMenus()
            end
        elseif currentPersonaldata.upgraded == 2 then
            if item == level3 then
                TriggerServerEvent('myDrugs:upgradeFarm', currentPersonaldata.id, 3, Config.Level3Price)
                _menuPool:CloseAllMenus()
            end
        end

    end
    
    local finishCap = NativeUI.CreateItem(Translation[Config.Locale]['menu_stats_finished'], '~b~')
    finishCap:RightLabel(Config.FinishCapacity[currentPersonaldata.upgraded] .. 'g')
    upgradeFarm:AddItem(finishCap)
    local storeCap = NativeUI.CreateItem(Translation[Config.Locale]['menu_stats_storecap'], Translation[Config.Locale]['menu_stats_storecap_desc'])
    storeCap:RightLabel(Config.StoreCapacity[currentPersonaldata.upgraded] .. 'g')
    upgradeFarm:AddItem(storeCap)
    local productivity = NativeUI.CreateItem(Translation[Config.Locale]['menu_stats_productivity'], '~b~')
    productivity:RightLabel(Config.ProduceRate[currentPersonaldata.upgraded] .. 'g / h')
    upgradeFarm:AddItem(productivity)

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
            TriggerServerEvent('myDrugs:buyVehicle', index, currentPersonaldata.id)
            _menuPool:CloseAllMenus()
        end

    end

	local alreadyTrusted = _menuPool:AddSubMenu(computer, Translation[Config.Locale]['menu_access'], Translation[Config.Locale]['menu_access_desc'])
	
	for k2, trusted in pairs(currentPersonaldata.trusted) do
		local trusted = NativeUI.CreateItem(trusted.name, Translation[Config.Locale]['menu_access_trust_remove'] .. trusted.name .. Translation[Config.Locale]['menu_access_trust_remove_2'])
		alreadyTrusted:AddItem(trusted)
		
		alreadyTrusted.OnItemSelect = function(sender, item, index)
			if item == trusted then
				TriggerServerEvent('myDrugs:updateTrusted', "del", currentPersonaldata.trusted[index].steamID, currentPersonaldata.id)
				_menuPool:CloseAllMenus()
			end
		end
	end

	local addTrusted = _menuPool:AddSubMenu(alreadyTrusted, Translation[Config.Locale]['menu_addTrusted'], '~b~')
	local playersInArea2 = ESX.Game.GetPlayersInArea(currentFarmData.enter, 10.0)

    local gotOSResult = false
    if Config.useOneSyncInfinity then
        ESX.TriggerServerCallback('myDrugs:getPlayersInArea', function(playersInArea_res)
            playersInArea2 = playersInArea_res
            gotOSResult = true
        end, currentFarmData.enter, 10.0)
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
				TriggerServerEvent('myDrugs:updateTrusted', "add", playersInArea2[index].id, currentPersonaldata.id)
			else
				TriggerServerEvent('myDrugs:updateTrusted', "add", GetPlayerServerId(playersInArea2[index]), currentPersonaldata.id)
			end
			
			_menuPool:CloseAllMenus()
		end
		--end
	end
	

    local sellFarm = _menuPool:AddSubMenu(computer, Translation[Config.Locale]['menu_sell'], Translation[Config.Locale]['menu_sell_desc'] .. currentFarmData.price / Config.SellDivide .. '$')

    local sellFarmConfirm = NativeUI.CreateItem(Translation[Config.Locale]['menu_sell_confirm'], '~b~')
    sellFarm:AddItem(sellFarmConfirm)

    sellFarmConfirm.Activated = function(sender, index)

        local playerPed = PlayerPedId()
        DoScreenFadeOut(1000)
        Citizen.Wait(1000)
        SetEntityCoords(playerPed, currentFarmData.enter.x, currentFarmData.enter.y, currentFarmData.enter.z)
        DoScreenFadeIn(1500)
        
        TriggerServerEvent('myDrugs:leaveFarm', currentPersonaldata.id)
        TriggerServerEvent('myDrugs:saveLastFarm', 0)

        TriggerServerEvent('myDrugs:sellFarm', currentPersonaldata.owner, currentPersonaldata.id, currentFarmData.price)
        sellFarm:Visible(false)

        isInFarm = false
        currentPersonaldata = nil
        currentFarmData = nil

    end


    computer:Visible(not computer:Visible())
    _menuPool:RefreshIndex()
	_menuPool:MouseEdgeEnabled (false)

end

local isAtSeller = false
local startedLoading = false
local startDistance = nil
local isDelivering = false

RegisterNetEvent('myDrugs:startStorageMission')
AddEventHandler('myDrugs:startStorageMission', function(target)

    if not isDoingMission then

        isDoingMission = true

        local random = math.random(1, #Config.StorageMissionDestinations)
        local dest = Config.StorageMissionDestinations[random].loc
        SetNewWaypoint(dest.x, dest.y)

        SpawnVehicle(Config.Vehicles[tonumber(currentPersonaldata.vehicle)].model, currentFarmData.spawnVehicle)

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

            if GetEntityModel(vehicle) == GetHashKey(car) then
                if distance >= 15.0 then
                    RemoveNotification(notificationID)
                    notificationID = ShowNotification(Translation[Config.Locale]['mission_outofrange'])
                    i = i -1
                else
                    RemoveNotification(notificationID)
                    notificationID = ShowNotification(Translation[Config.Locale]['mission_loading'] .. i .. Translation[Config.Locale]['mission_loading_2'])
                end
            else
                RemoveNotification(notificationID)
                notificationID = ShowNotification(Translation[Config.Locale]['mission_notincar'])
                TriggerEvent('myDrugs:abortMission')
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
                TriggerServerEvent('myDrugs:payPlants', amountOfItems, price, target)
				TriggerServerEvent('myDrugs:givePlants', amountOfItems, target, currentPersonaldata.type)
            end
        end
    
    else
        TriggerEvent('esx:showAdvancedNotification', 'CHAR_MALC', Translation[Config.Locale]['mission_wrongCar'], Translation[Config.Locale]['mission_seller'], '')
        TriggerEvent('myDrugs:abortMission')
    end

end

RegisterNetEvent('myDrugs:deliverPlants')
AddEventHandler('myDrugs:deliverPlants', function(amount, target)


    SetNewWaypoint(currentFarmData.spawnVehicle.x, currentFarmData.spawnVehicle.y)
    ShowNotification(Translation[Config.Locale]['mission_backToFarm'])
    isDelivering = true

    local isAtGarage = false

    Citizen.CreateThread(function()

        while true do
            Citizen.Wait(300)
            if isDelivering then

                local ped = PlayerPedId()
                local playerCoords = GetEntityCoords(ped)
                local distance = Vdist(playerCoords, currentFarmData.spawnVehicle.x, currentFarmData.spawnVehicle.y, currentFarmData.spawnVehicle.z)

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
				DrawMarker(27, currentFarmData.spawnVehicle.x, currentFarmData.spawnVehicle.y, currentFarmData.spawnVehicle.z - 0.98, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0*4.0, 1.0*4.0, 1.0, 66, 246, 66, 75, false, false, 2, false, false, false, false)
			end
			
            if isAtGarage then
                showInfobar(Translation[Config.Locale]['mission_press_e_deliver'])
                if IsControlJustReleased(0, 38) then
					local car = Config.Vehicles[tonumber(currentPersonaldata.vehicle)].model
					local vehicle = GetVehiclePedIsIn(PlayerPedId(-1))

					if GetEntityModel(vehicle) == GetHashKey(car) then
						GiveCarBack(PlayerPedId(-1))
						TriggerEvent('myDrugs:abortMission')
						--TriggerServerEvent('myDrugs:givePlants', amount, target, currentPersonaldata.type)
					else
						ShowNotification(Translation[Config.Locale]['mission_wrongCar_deliver'])
					end
                    break
                end
            end

        end
    
    end)

end)

RegisterNetEvent('myDrugs:abortMission')
AddEventHandler('myDrugs:abortMission', function()

    isDoingMission = false
    isAtSeller = false
    startedLoading = false
    startDistance = nil
    isDelivering = false

end)

RegisterNetEvent('myDrugs:hasRequest')
AddEventHandler('myDrugs:hasRequest', function(target, farmData_res, persData_res)

	hasInvite = true

    ShowNotification(Translation[Config.Locale]['mission_invited'])
	Citizen.CreateThread(function()
	
		while hasInvite do
			Citizen.Wait(0)
			if IsControlJustReleased(0, 38) then
                
                currentFarmData = farmData_res
                currentPersonaldata = persData_res
                hasInvite = false
                TriggerServerEvent('myDrugs:startMission', target)
			end

		end
	
	end)

	Citizen.Wait(10000)
	if hasInvite then
		hasInvite = false
		ShowNotification(Translation[Config.Locale]['mission_invited_over'])
	end

end)

RegisterNetEvent('myDrugs:receiveFarms')
AddEventHandler('myDrugs:receiveFarms', function(farmOwnerServer, steamID)
	--ownedFarms = {}
	for k2, farm in pairs(farmOwnerServer) do
		if farm.owner == steamID then
		
			ownedFarms[#ownedFarms + 1] = farm
		
		end
		for k3, trusted in pairs(farm.trusted) do
			if trusted.steamID == steamID then
				ownedFarms[#ownedFarms + 1] = farm
			end
		end
	end
    --ownedFarms = farmOwnerServer
    gotFarms = true

    for k, v in pairs(ownedFarms) do
        for k2, farm in pairs(Config.Farms) do
            if farm.name == v.name then
            --[[local blip = AddBlipForCoord(farm.enter.x, farm.enter.y)
                SetBlipSprite(blip, 140)
                SetBlipDisplay(blip, 6)
                SetBlipScale(blip, 1.2)
                SetBlipColour(blip, 2)
                SetBlipAsShortRange(blip, true)
                BeginTextCommandSetBlipName("STRING");
                AddTextComponentString(farm.label)
                EndTextCommandSetBlipName(blip)
                break]]
            end
        end


    end
    --currentPersonaldata = ownedFarms[1]

end)

RegisterNetEvent('myDrugs:updateFarms')
AddEventHandler('myDrugs:updateFarms', function(line, farmOwnerUpdated)

    for k, v in pairs(ownedFarms) do
        if v.id == farmOwnerUpdated.id then
            ownedFarms[k] = farmOwnerUpdated
            currentPersonaldata = farmOwnerUpdated
        break
        end
    end
end)

RegisterNetEvent('myDrugs:deleteFarm')
AddEventHandler('myDrugs:deleteFarm', function(toDeleteID)

    for k, v in pairs(ownedFarms) do
        if v.id == toDeleteID then
            table.remove(ownedFarms, k)
        break
        end
    end
end)

RegisterNetEvent('myDrugs:setNewFarmOwned')
AddEventHandler('myDrugs:setNewFarmOwned', function(farmOwnerNew, owner_res)

    --print(farmOwnerNew.id)

    table.insert(ownedFarms, {
        id = farmOwnerNew.id,
        owner = owner_res,
        name = farmOwnerNew.name,
        type = farmOwnerNew.type,
        upgraded = 1,
        vehicle = 1,
        store = 0,
        finish = 0,
        lastlogin = 0,
    })

    for k2, farm in pairs(Config.Farms) do
        if farm.name == farmOwnerNew.name then
            --[[local blip = AddBlipForCoord(farm.enter.x, farm.enter.y)
            SetBlipSprite(blip, 140)
            SetBlipDisplay(blip, 6)
            SetBlipScale(blip, 1.2)
            SetBlipColour(blip, 2)
            SetBlipAsShortRange(blip, true)
            BeginTextCommandSetBlipName("STRING");
            AddTextComponentString(farm.label)
            EndTextCommandSetBlipName(blip)]]
        end
    end

end)

RegisterNetEvent('myDrugs:sellFarm')
AddEventHandler('myDrugs:sellFarm', function(farmID)
    if #ownedFarms > 0 then
        for k, v in pairs(ownedFarms) do
            if v.id == farmID then
                table.remove(ownedFarms, k)
            end
        end
    end

end)

RegisterNetEvent('myDrugs:msg')
AddEventHandler('myDrugs:msg', function(message)

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

RegisterNetEvent('myDrugs:setPlayerInvisible')
AddEventHandler('myDrugs:setPlayerInvisible', function(playerEnter, instanceId)
	local otherPlayer = GetPlayerFromServerId(playerEnter)
	if otherPlayer ~= nil then
		local otherPlayerPed = GetPlayerPed(otherPlayer)
		if otherPlayerPed ~= GetPlayerPed(-1) then
			table.insert(vanishedUser, otherPlayerPed)
			NetworkConcealEntity(otherPlayerPed, true)
		end
	end
end)

RegisterNetEvent('myDrugs:setPlayerVisible')
AddEventHandler('myDrugs:setPlayerVisible', function(playerEnter)
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
-- 		if isInFarm then
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

-- RegisterNetEvent('myDrugs:setPlayerInvisible')
-- AddEventHandler('myDrugs:setPlayerInvisible', function(playerEnter)

	
-- 	local otherPlayer = GetPlayerFromServerId(playerEnter)
	
-- 	if otherPlayer ~= nil then
-- 		local otherPlayerPed = GetPlayerPed(otherPlayer)
-- 		table.insert(vanishedUser, otherPlayerPed)
-- 	end

-- end)

-- RegisterNetEvent('myDrugs:setPlayerVisible')
-- AddEventHandler('myDrugs:setPlayerVisible', function(playerEnter)


-- 	local otherPlayer = GetPlayerFromServerId(playerEnter)
-- 	local otherPlayerPed = GetPlayerPed(otherPlayer)
	
-- 	for k, vanish in pairs(vanishedUser) do
-- 		if vanish == otherPlayerPed then
-- 			table.remove(vanishedUser, k)
-- 		end
-- 	end

-- end)
