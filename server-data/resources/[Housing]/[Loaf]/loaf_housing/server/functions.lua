ESXEvent = "esx:getSharedObject"

ESX = nil

TriggerEvent(ESXEvent, function(obj) 
    ESX = obj 
end)

HasMoney = function(source, amount)
    local xPlayer = ESX.GetPlayerFromId(source)

    if xPlayer then
        if xPlayer.getMoney() >= amount then
            return true
        elseif xPlayer.getAccount("bank").money >= amount then
            return true
        end
    end

    return false
end

PayMoney = function(source, amount)
    local xPlayer = ESX.GetPlayerFromId(source)

    if xPlayer then
        if xPlayer.getMoney() >= amount then
            xPlayer.removeMoney(amount)
            return true
        elseif xPlayer.getAccount("bank").money >= amount then
            xPlayer.removeAccountMoney("bank", amount)
            return true
        end
    end

    return false
end

AddMoney = function(source, amount)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer then
        xPlayer.addMoney(amount)
    end
end

UpdatePlayerPosition = function(identifier, houseid)
    if houseid and tonumber(houseid) and identifier then
        local data = Config.Houses[tonumber(houseid)]
        if data then
            MySQL.Async.execute("UPDATE `users` SET `position`=@pos WHERE `identifier`=@identifier", {
                ["@pos"] = json.encode({
                    x = data.Entrance.x,
                    y = data.Entrance.y,
                    z = data.Entrance.z,
                    heading = data.Entrance.w
                }),
                ["@identifier"] = identifier
            })

            debugprint("Updated player position for " .. identifier)
        end
    end 
end

RegisterServerEvent("loaf_housing:store")
AddEventHandler("loaf_housing:store", function(houseid, itemid, itemtype, amount, itemname)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    
    if houseid and itemtype and xPlayer and xPlayer.identifier and spawned_houses[houseid] then
        if itemtype == "cash" then
            if xPlayer.getMoney() >= amount then
                xPlayer.removeMoney(amount)
                Storage(houseid, itemid, "put", "cash", amount)
            end
        elseif itemtype == "black_money" then
            if xPlayer.getAccount("black_money").money >= amount then
                xPlayer.removeAccountMoney("black_money", amount)
                Storage(houseid, itemid, "put", "black_money", amount)
            end
        elseif itemtype == "items" then
            local itemData = xPlayer.getInventoryItem(itemname)
            if itemData then
                if itemData.count >= amount then
                    xPlayer.removeInventoryItem(itemname, amount)
                    Storage(houseid, itemid, "put", "items", amount, itemname, itemData.label)
                end
            end
        elseif itemtype == "weapons" then
            local loadoutNum, weapon = xPlayer.getWeapon(itemname)
            if weapon then
                -- houseid, itemid, method, itemtype, amount, itemname, label, cb
                Storage(houseid, itemid, "put", "weapons", weapon.ammo, itemname, weapon)
                xPlayer.removeWeapon(itemname)
            end
        end
    end
end)

RegisterServerEvent("loaf_housing:withdraw")
AddEventHandler("loaf_housing:withdraw", function(houseid, itemid, itemtype, amount, itemname)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    
    if houseid and itemtype and xPlayer and xPlayer.identifier and spawned_houses[houseid] then
        if itemtype == "cash" then
            -- houseid, itemid, method, itemtype, amount, itemname, label, cb
            Storage(houseid, itemid, "get", "cash", amount, nil, nil, function(success)
                if success then
                    xPlayer.addMoney(amount)
                end
            end)
        elseif itemtype == "black_money" then
            Storage(houseid, itemid, "get", "black_money", amount, nil, nil, function(success)
                if success then
                    xPlayer.addAccountMoney("black_money", amount)
                end
            end)
        elseif itemtype == "items" then
            if xPlayer.canCarryItem(itemname, amount) then
                Storage(houseid, itemid, "get", "items", amount, itemname, nil, function(success)
                    if success then
                        xPlayer.addInventoryItem(itemname, amount)
                    end
                end)
            else
                xPlayer.showNotification(Strings["cant_carry"])
            end
        elseif itemtype == "weapons" then
            Storage(houseid, itemid, "get", "weapons", 1, itemname, nil, function(success, data)
                if success and data then
                    xPlayer.addWeapon(data.weapon, data.ammo)
                    xPlayer.setWeaponTint(data.weapon, data.data.tintIndex)

                    for k, v in pairs(data.data.components) do
                        xPlayer.addWeaponComponent(data.weapon, v)
                    end
                end
            end)
        end
    end
end)

RegisterServerEvent("loaf_housing:removeLockpick")
AddEventHandler("loaf_housing:removeLockpick", function()
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer and xPlayer.identifier then
        if xPlayer.getInventoryItem("lockpick").count > 0 then
            xPlayer.removeInventoryItem("lockpick", 1)
        end
    end
end)

ESX.RegisterServerCallback("loaf_housing:getInventory", function(src, cb)
    local xPlayer = ESX.GetPlayerFromId(src)
    
    cb({
        cash = xPlayer.getMoney(),
        black_money = xPlayer.getAccount("black_money"),
        items = xPlayer.inventory,
        weapons = xPlayer.getLoadout(),
    })
end)

GetCops = function()
    local police_job = "police"
    if Config.LockPicking and Config.LockPicking.Police then
        police_job = Config.LockPicking.Police
    end

    local cops = 0

    for k, v in pairs(ESX.GetPlayers()) do
        local xPlayer = ESX.GetPlayerFromId(v)
        if xPlayer and xPlayer.getJob() and xPlayer.getJob().name == police_job then
            cops = cops + 1
        end
    end

    return cops
end

ESX.RegisterServerCallback("loaf_housing:getOutfits", function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)

	TriggerEvent("esx_datastore:getDataStore", "property", xPlayer.identifier, function(store)
		local count  = store.count("dressing")
		local labels = {}

		for i = 1, count, 1 do
            table.insert(labels, store.get("dressing", i).label)
		end

		cb(labels)
	end)
end)

ESX.RegisterServerCallback("loaf_housing:getOutfit", function(source, cb, id)
	local xPlayer = ESX.GetPlayerFromId(source)

	TriggerEvent("esx_datastore:getDataStore", "property", xPlayer.identifier, function(store)
		local outfit = store.get("dressing", id)
        if outfit then
		    cb(outfit.skin)
        else
            cb(false)
        end
	end)
end)

ESX.RegisterServerCallback("loaf_housing:getCops", function(src, cb)
    cb(GetCops())
end)

ESX.RegisterServerCallback("loaf_housing:getName", function(src, cb, userid)
    if GetPlayerName(userid) then -- if the player is online
        local name = GetName(userid)
        if name then
            cb(name)
        end
    else
        cb(false)
    end
end)

GetName = function(source)
    local xPlayer = ESX.GetPlayerFromId(source)
    if Config.EnableESXIdentity and xPlayer then
        if Config.IdentitySQL then
            local to_return = nil
            MySQL.Async.fetchAll("SELECT `firstname`, `lastname` FROM `users` WHERE `identifier` = @identifier", {
                ["@identifier"] = xPlayer.identifier
            }, function(result)
                if result and result[1] then
                    toReturn = (result[1].firstname .. " " .. result[1].lastname)
                else
                    toReturn = (GetPlayerName(source) .. " [" .. source .. "]")
                end
            end)

            while not toReturn do
                Wait(500)
            end

            return toReturn
        else
            return(xPlayer.get("firstName") .. " " .. xPlayer.get("lastName"))
        end
    else
        return(GetPlayerName(source) .. " [" .. source .. "]")
    end
end

debugprint = function(msg)
    print("loaf_housing: " .. msg)
end