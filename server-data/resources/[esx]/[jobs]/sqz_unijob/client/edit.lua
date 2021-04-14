RegisterNetEvent('sqz_unijob:sendClientNotify')
AddEventHandler('sqz_unijob:sendClientNotify', function(notify_text)
    ESX.ShowNotification(notify_text)
    -- Here you can replace the notification to your custom
end)

RegisterNetEvent('sqz_unijob:OpenCustomPutStockMenu')
AddEventHandler('sqz_unijob:OpenCustomPutStockMenu', function(station)

    ESX.TriggerServerCallback('sqz_unijob:getPlayerInventory', function(inventory)
        -- Here you can add custom event for opening the deposit stock menu, so it can open you a custom inventory

        local item_id = math.random(1, 9^9)
        TriggerServerEvent('sqz_unijob:putStockItems', itemName, count, itemLabel, station, "item", item_id) 
        -- This line above is needed to put to the item to the database
        -- If it is a weapon, change it to "weapon"
    end)


end)
RegisterNetEvent('sqz_unijob:OpenCustomPutWeaponMenu')
AddEventHandler('sqz_unijob:OpenCustomPutWeaponMenu', function(station)

    -- Here you can add custom event for opening the deposit stock menu, so it can open you a custom inventory

    local item_id = math.random(1, 9^9)
    TriggerServerEvent('sqz_unijob:putStockItems', weaponName, weaponAmmoCount, weaponLabel, station, "weapon", item_id)
    -- This line above is needed to put to the weapon to the database

end)

RegisterNetEvent('sqz_unijob:GetItemsCustomMenu')
AddEventHandler('sqz_unijob:GetItemsCustomMenu', function(station)
    -- Here you can add the custom event for opening menu where you can get weapons


    ESX.TriggerServerCallback('sqz_unijob:getStockItems', function(items)
        --[[The structure for callback data is:
    
            [1] = {
                ["item"] = bread,
                ["item_id"] = 148451344812,
                ["vault"] = armory_society_sandy_mechanic,
                ["count"] = 100,
                ["label"] = Burger,
                ["type"] = item,
            }
            
            -- Or you can use a print(ESX.DumpTable(items)) to see how it looks

            ]]
            -- To remove the item from database use this event:
            --TriggerServerEvent('sqz_unijob:getStockItem', itemName, count, station, "item")
        --print(ESX.DumpTable(items))
    end, station)

end)

RegisterNetEvent('sqz_unijob:GetWeaponsCustomMenu')
AddEventHandler('sqz_unijob:GetWeaponsCustomMenu', function(station)

    -- Here you can add the custom event for opening menu where you can get weapons


    ESX.TriggerServerCallback('sqz_unijob:getArmoryWeapons', function(weapons)
        --[[The structure for callback data is:
    
            [1] = {
                ["item"] = WEAPON_PISTOL,
                ["item_id"] = 148451344812,
                ["vault"] = armory_society_sandy_mechanic,
                ["count"] = 100,
                ["label"] = Pistol,
                ["type"] = item,
            }
            
            -- Or you can use a print(ESX.DumpTable(items)) to see how it looks

            ]]
        --print(ESX.DumpTable(weapons))

        -- To remove the item from database, use this event:
        -- TriggerServerEvent('sqz_unijob:getStockItem', WeaponName, AmmoName, station, "weapon", item_id)
    end, station)

end)

function DrawCustomMarkers(data)
    --[[
        The sctructure is:
        ["Size"] = {
            ["x"] = 0.7,
            ["y"] = 0.7,
            ["z"] = 0.7,
        },
        ["Pos"] = {
            ["x"] = 11.0,
            ["y"] = 11.0,
            ["z"] = 11.0,
        },
        ["Color"] = {
            ["r"] = 204,
            ["b"] = 0,
            ["r"] = 204
        },
        ["MotionText"] = [E] VehicleSpawner
    ]]
    -- Here you can add you custom DrawText/DrawMarker
end

RegisterNetEvent('sqz_unijob:CustomElementInPersonalMenu')
AddEventHandler('sqz_unijob:CustomElementInPersonalMenu', function()

    -- Here you can add custom element menu (function) to F6 Menu
    -- Playejob is: ESX.PlayerData.job.name
    ESX.UI.Menu.CloseAll() -- To close all the menu before opening a new one
    -- Here you can define whatever elements should be here like:

end)

RegisterNetEvent('sqz_unijob:CustomVehicleSpawnerEvent')
AddEventHandler('sqz_unijob:CustomVehicleSpawnerEvent', function(index)

    -- This event is triggered when a players open garage menu and Config.UseCustomGarageEvents is enabled
    -- This event is for vehicles
    -- The index is index of the table in the Config of your job (Like Vehicles, Vehicles2 ...)
    ESX.UI.Menu.CloseAll() -- To close all the menu before opening a new one

end)


RegisterNetEvent('sqz_unijob:CustomAirCraftSpawnerEvent')
AddEventHandler('sqz_unijob:CustomAirCraftSpawnerEvent', function(index)

    -- This event is triggered when a players open garage menu and Config.UseCustomGarageEvents is enabled
    -- This event is for AirPlanes and helicopters
    -- The index is index of the table in the Config of your job (Like AirCrafts, AirCrafts2 ...)
    ESX.UI.Menu.CloseAll() -- To close all the menu before opening a new one

end)

RegisterNetEvent('sqz_unijob:StoreVehicleCustom')
AddEventHandler('sqz_unijob:StoreVehicleCustom', function()

    -- This event is triggered when a players tries to store a vehicle and Config.UseCustomGarageEvents is enabled

end)

function DrawText3Ds(x,y,z, text)
	local onScreen,_x,_y=World3dToScreen2d(x,y,z)
	local px,py,pz=table.unpack(GetGameplayCamCoords())
	
	SetTextScale(0.5, 0.35)
	SetTextFont(Config.FontId)
	SetTextProportional(1)
	SetTextColour(255, 255, 255, 215)
	SetTextEntry("STRING")
	SetTextCentre(1)
	AddTextComponentString(text)
	DrawText(_x,_y)
	local factor = (string.len(text)) / 200
	DrawRect(_x,_y+0.0105, 0.025+ factor, 0.05, 41, 11, 41, 150)
end

-- KeyMapping, you can let it be as it is
RegisterKeyMapping('epressed', 'E pressed', 'keyboard', 'e')
RegisterKeyMapping('jobactions', 'Job Actions', 'keyboard', 'f6')