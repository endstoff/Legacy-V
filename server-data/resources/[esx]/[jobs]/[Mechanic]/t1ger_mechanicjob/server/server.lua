-------------------------------------
------- Created by T1GER#9080 -------
------------------------------------- 

ESX = nil
TriggerEvent(Config.ESXSHAREDOBJECT, function(obj) ESX = obj end)

RegisterServerEvent('t1ger_mechanicjob:fetchMechShops')
AddEventHandler('t1ger_mechanicjob:fetchMechShops', function()
    local xPlayers = ESX.GetPlayers()
    local players  = {}
    local DataFected = false
	for i = 1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
		table.insert(players, { source = xPlayer.source, identifier = xPlayer.identifier, shopID = 0 })
    end
    MySQL.Async.fetchAll("SELECT * FROM t1ger_mechanic", {}, function(results)
        if #results > 0 then 
            for l,ply in pairs(players) do
                for k,v in pairs(results) do
                    if ply.identifier == v.identifier then
                        ply.shopID = v.shopID
                    end
                    if k == #results then DataFected = true end
                end
            end
        else
            DataFected = true
        end
    end)
    while not DataFected do Wait(5) end
    local plyShopID = 0
    if DataFected then 
        for k,v in pairs(players) do
            if v.shopID > 0 then plyShopID = v.shopID else plyShopID = 0 end
            TriggerClientEvent('t1ger_mechanicjob:fetchMechShopsCL', v.source, plyShopID)
        end
    end
end)

-- Get Owned Companies:
ESX.RegisterServerCallback('t1ger_mechanicjob:getTakenShops',function(source, cb)
    local ownedShop = {}
    local dataFetched = false
    MySQL.Async.fetchAll("SELECT * FROM t1ger_mechanic",{}, function(data)
        if #data > 0 then 
            for k,v in pairs(data) do
                table.insert(ownedShop,{id = v.shopID, name = v.name})
                if k == #data then dataFetched = true end
            end
        else
            dataFetched = true
        end
        while not dataFetched do 
            Wait(5)
        end
        if dataFetched then 
            cb(ownedShop)
        end
    end)
end)

-- Callback to Get accounts:
ESX.RegisterServerCallback('t1ger_mechanicjob:getShopAccounts', function(source, cb, id)
    MySQL.Async.fetchAll("SELECT money FROM t1ger_mechanic WHERE shopID = @shopID", {['@shopID'] = id}, function(data)
        if data[1].money ~= nil then 
            cb(data[1].money)
        end
    end)
end)

-- Purchase Mech Shop:
ESX.RegisterServerCallback('t1ger_mechanicjob:buyMechShop',function(source, cb, id, val, name)
    local xPlayer = ESX.GetPlayerFromId(source)
    local money = 0
    if Config.PayMechShopWithCash then
        money = xPlayer.getMoney()
    else
        money = xPlayer.getAccount('bank').money
    end
	if money >= val.price then
		if Config.PayMechShopWithCash then
			xPlayer.removeMoney(val.price)
		else
			xPlayer.removeAccountMoney('bank', val.price)
		end
        MySQL.Sync.execute("INSERT INTO t1ger_mechanic (identifier, shopID, name, employees, storage) VALUES (@identifier, @shopID, @name, @employees, @storage)", {
            ['identifier'] = xPlayer.identifier,
            ['shopID'] = id,
            ['name'] = name,
            ['employees'] = '[]',
            ['storage'] = '[]'
        })
        cb(true)
    else
        cb(false)
    end
end)

-- Sell Mech Shop:
ESX.RegisterServerCallback('t1ger_mechanicjob:sellMechShop',function(source, cb, id, val, sellPrice)
    local xPlayer = ESX.GetPlayerFromId(source)
    MySQL.Async.fetchAll("SELECT shopID FROM t1ger_mechanic WHERE identifier = @identifier", {['@identifier'] = xPlayer.identifier}, function(data)
        if data[1].shopID ~= nil then 
            if data[1].shopID == id then
                MySQL.Async.execute("DELETE FROM t1ger_mechanic WHERE shopID=@shopID", {['@shopID'] = id}) 
                if Config.RecieveSoldMechShopCash then
                    xPlayer.addMoney(sellPrice)
                else
                    xPlayer.addAccountMoney('bank',sellPrice)
                end
                cb(true)
            else
                cb(false)
            end
        end
    end)
end)

-- Reanme Mech Shop:
ESX.RegisterServerCallback('t1ger_mechanicjob:renameMechShop',function(source, cb, id, val, name)
    local xPlayer = ESX.GetPlayerFromId(source)
    MySQL.Async.fetchAll("SELECT shopID FROM t1ger_mechanic WHERE identifier = @identifier", {['@identifier'] = xPlayer.identifier}, function(data)
        if data[1].shopID ~= nil then 
            if data[1].shopID == id then
                MySQL.Sync.execute("UPDATE t1ger_mechanic SET name = @name WHERE shopID = @shopID", {
                    ['@name'] = name,
                    ['@shopID'] = id
                })
                cb(true)
            else
                cb(false)
            end
        end
    end)
end)

-- Get Employees:
ESX.RegisterServerCallback('t1ger_mechanicjob:getEmployees',function(source, cb, id)
    local xPlayer = ESX.GetPlayerFromId(source)
    local dataFected = false
    local shopEmployees = {}
    local noEmployees = false
    MySQL.Async.fetchAll("SELECT employees FROM t1ger_mechanic WHERE shopID = @shopID", {['@shopID'] = id}, function(data)
        if data[1].employees ~= nil then
            local employees = json.decode(data[1].employees)
            if #employees > 0 then
                for k,v in pairs(employees) do 
                    MySQL.Async.fetchAll('SELECT * FROM users WHERE identifier = @identifier', {['@identifier'] = v.identifier}, function (info)
                        for j,l in pairs(info) do 
                            if v.identifier == l.identifier then 
                                table.insert(shopEmployees,{identifier = v.identifier, firstname = l.firstname, lastname = l.lastname, jobGrade = v.jobGrade})
                                if k == #employees then 
                                    dataFected = true
                                end
                            end
                        end
                    end)
                end
            else
                noEmployees = true
                dataFected = true
            end
        end 
    end)
    while not dataFected do
        Citizen.Wait(1)
    end
    if dataFected then
        if noEmployees then cb(nil) else cb(shopEmployees) end
    end
end)

-- Fire Employee:
RegisterServerEvent('t1ger_mechanicjob:fireEmployee')
AddEventHandler('t1ger_mechanicjob:fireEmployee', function(id, plyIdentifier)
    local xPlayer = ESX.GetPlayerFromId(source)
    MySQL.Async.fetchAll("SELECT * FROM t1ger_mechanic WHERE shopID = @shopID", {['@shopID'] = id}, function(data)
        if data[1].employees ~= nil then
            local employees = json.decode(data[1].employees)
            if #employees > 0 then 
                for k,v in pairs(employees) do 
                    if plyIdentifier == v.identifier then 
                        table.remove(employees, k)
                        MySQL.Sync.execute("UPDATE t1ger_mechanic SET employees = @employees WHERE shopID = @shopID", {
                            ['@employees'] = json.encode(employees),
                            ['@shopID'] = id
                        })
                        local xTarget = ESX.GetPlayerFromIdentifier(plyIdentifier)
                        xTarget.setJob("unemployed", 0)
                        TriggerClientEvent('t1ger_mechanicjob:ShowNotifyESX', xTarget.source, Lang['mech_employee_fired'])
                        break
                    end
                end
            end
        end
    end)
end)

-- Update Employee Job Grade:
RegisterServerEvent('t1ger_mechanicjob:updateEmployeJobGrade')
AddEventHandler('t1ger_mechanicjob:updateEmployeJobGrade', function(id, plyIdentifier, newJobGrade)
    local xPlayer = ESX.GetPlayerFromId(source)
    MySQL.Async.fetchAll("SELECT employees FROM t1ger_mechanic WHERE shopID = @shopID", {['@shopID'] = id}, function(data)
        if data[1].employees ~= nil then 
            local employees = json.decode(data[1].employees)
            if #employees > 0 then 
                for k,v in pairs(employees) do 
                    if plyIdentifier == v.identifier then
                        local xTarget = ESX.GetPlayerFromIdentifier(plyIdentifier)
                        MySQL.Async.fetchAll('SELECT * FROM job_grades WHERE job_name = @job_name', {['@job_name'] = 'mechanic'}, function (results)
                            if newJobGrade >= 0 and newJobGrade <= results[#results].grade then
                                if xTarget.job.grade ~= newJobGrade then 
                                    v.jobGrade = newJobGrade
                                    MySQL.Sync.execute("UPDATE t1ger_mechanic SET employees = @employees WHERE shopID = @shopID", {
                                        ['@employees'] = json.encode(employees),
                                        ['@shopID'] = id
                                    })
                                    xTarget.setJob("mechanic", tonumber(newJobGrade))
                                    Wait(200)
                                    TriggerClientEvent('t1ger_mechanicjob:ShowNotifyESX', xPlayer.source, (Lang['you_updat_job_grade_for']:format(xTarget.getName(), newJobGrade)))
                                    TriggerClientEvent('t1ger_mechanicjob:ShowNotifyESX', xTarget.source, (Lang['your_job_grade_updated']:format(newJobGrade)))
                                else
                                    TriggerClientEvent('t1ger_mechanicjob:ShowNotifyESX', xPlayer.source, (Lang['target_alrdy_has_job_g']:format(xTarget.getName())))
                                end
                            else
                                TriggerClientEvent('t1ger_mechanicjob:ShowNotifyESX', xPlayer.source, (Lang['mix_max_job_grade']:format(results[#results].grade)))
                            end
                        end)
                    end 
                end
            end
        end
    end)
end)

-- Callback to Get online players:
ESX.RegisterServerCallback('t1ger_mechanicjob:getOnlinePlayers', function(source, cb)
	local fetchedPlayers = GetOnlinePlayers()
	cb(fetchedPlayers)
end)

-- Reqruit Employee:
RegisterServerEvent('t1ger_mechanicjob:reqruitEmployee')
AddEventHandler('t1ger_mechanicjob:reqruitEmployee', function(id, plyIdentifier, newJobGrade, name)
    local xPlayer = ESX.GetPlayerFromId(source)
    local loopDone = false
    local identifierMatch = false
    local noEmployees = false
    MySQL.Async.fetchAll("SELECT employees FROM t1ger_mechanic WHERE shopID = @shopID", {['@shopID'] = id}, function(data)
        if data[1].employees ~= nil then 
            local employees = json.decode(data[1].employees)
            if #employees > 0 then
                for k,v in pairs(employees) do 
                    if plyIdentifier == v.identifier then
                        identifierMatch = true
                        break
                    else
                        if k == #employees then 
                            loopDone = true
                        end
                    end
                end
            else
                noEmployees = true
                loopDone = true
            end
        end
    end)
    while not loopDone do 
        Citizen.Wait(1)
    end
    if identifierMatch then 
        TriggerClientEvent('t1ger_mechanicjob:ShowNotifyESX', xPlayer.source, Lang['already_hired'])
    end
    if loopDone then
        if noEmployees then
            MySQL.Async.fetchAll("SELECT * FROM t1ger_mechanic WHERE shopID = @shopID", {['@shopID'] = id}, function(data)
                for _,y in pairs(data) do 
                    local employees = {}
                    table.insert(employees,{identifier = plyIdentifier, jobGrade = newJobGrade})
                    MySQL.Sync.execute("UPDATE t1ger_mechanic SET employees = @employees WHERE shopID = @shopID", {
                        ['@employees'] = json.encode(employees),
                        ['@shopID'] = id
                    })
                    TriggerClientEvent('t1ger_mechanicjob:ShowNotifyESX', xPlayer.source, (Lang['you_recruited_x']:format(name)))
                    local xTarget = ESX.GetPlayerFromIdentifier(plyIdentifier)
                    xTarget.setJob("mechanic", tonumber(newJobGrade))
                    TriggerClientEvent('t1ger_mechanicjob:ShowNotifyESX', xTarget.source, Lang['you_have_been_recruited'])
                    break
                end
            end)
        else
            if not identifierMatch then
                MySQL.Async.fetchAll("SELECT * FROM t1ger_mechanic WHERE shopID = @shopID", {['@shopID'] = id}, function(data)
                    for _,y in pairs(data) do 
                        local employees = json.decode(y.employees)
                        table.insert(employees,{identifier = plyIdentifier, jobGrade = newJobGrade})
                        MySQL.Sync.execute("UPDATE t1ger_mechanic SET employees = @employees WHERE shopID = @shopID", {
                            ['@employees'] = json.encode(employees),
                            ['@shopID'] = id
                        })
                        TriggerClientEvent('t1ger_mechanicjob:ShowNotifyESX', xPlayer.source, (Lang['you_recruited_x']:format(name)))
                        local xTarget = ESX.GetPlayerFromIdentifier(plyIdentifier)
                        xTarget.setJob("mechanic", 0)
                        TriggerClientEvent('t1ger_mechanicjob:ShowNotifyESX', xTarget.source, Lang['you_have_been_recruited'])
                        break
                    end
                end)
            end
        end
    end
end)

-- Withdraw Account Money:
RegisterServerEvent('t1ger_mechanicjob:withdrawMoney')
AddEventHandler('t1ger_mechanicjob:withdrawMoney', function(id, amount)
    local xPlayer = ESX.GetPlayerFromId(source)
    local accountMoney = 0
    MySQL.Async.fetchAll("SELECT money FROM t1ger_mechanic WHERE shopID = @shopID", {['@shopID'] = id}, function(data)
        if data[1].money ~= nil then 
            accountMoney = data[1].money
        end
        if amount <= accountMoney then 
            MySQL.Sync.execute("UPDATE t1ger_mechanic SET money = @money WHERE shopID = @shopID", {
                ['@money'] = (accountMoney - amount),
                ['@shopID'] = id
            })
            xPlayer.addMoney(amount)
            TriggerClientEvent('t1ger_mechanicjob:ShowNotifyESX', xPlayer.source, (Lang['you_withdrew_x_amount']:format(amount)))
        else
            TriggerClientEvent('t1ger_mechanicjob:ShowNotifyESX', xPlayer.source, Lang['withdrawal_denied'])
        end
    end)
end)

-- Deposit Account Money:
RegisterServerEvent('t1ger_mechanicjob:depositMoney')
AddEventHandler('t1ger_mechanicjob:depositMoney', function(id, amount)
    local xPlayer = ESX.GetPlayerFromId(source)
    local accountMoney = 0
    MySQL.Async.fetchAll("SELECT money FROM t1ger_mechanic WHERE shopID = @shopID", {['@shopID'] = id}, function(data)
        if data[1].money ~= nil then 
            accountMoney = data[1].money
        end
        local plyMoney = xPlayer.getMoney()
        if plyMoney >= amount then 
            MySQL.Sync.execute("UPDATE t1ger_mechanic SET money = @money WHERE shopID = @shopID", {
                ['@money'] = (accountMoney + amount),
                ['@shopID'] = id
            })
            xPlayer.removeMoney(amount)
            TriggerClientEvent('t1ger_mechanicjob:ShowNotifyESX', xPlayer.source, (Lang['you_deposited_x_amount']:format(amount)))
        else
            TriggerClientEvent('t1ger_mechanicjob:ShowNotifyESX', xPlayer.source, Lang['not_enough_money'])
        end
    end)
end)

-- Check Storage Access:
ESX.RegisterServerCallback('t1ger_mechanicjob:checkAccess',function(source, cb, id)
    local xPlayer = ESX.GetPlayerFromId(source)
    MySQL.Async.fetchAll("SELECT * FROM t1ger_mechanic WHERE shopID = @shopID", {['@shopID'] = id}, function(data)
        for shops,columns in pairs(data) do 
            if columns.shopID == id then 
                if xPlayer.getIdentifier() == columns.identifier then 
                    cb(true)
                    break
                end
                if columns.employees ~= nil then 
                    local employees = json.decode(columns.employees)
                    if #employees > 0 then 
                        for k,v in pairs(employees) do 
                            if xPlayer.getIdentifier() == v.identifier then 
                                cb(true)
                                break
                            end
                        end
                    else
                        cb(false)
                    end
                end
            end
        end
    end)
end)

-- Get User Inventory:
ESX.RegisterServerCallback('t1ger_mechanicjob:getUserInventory', function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)
    local inventoryItems = xPlayer.inventory
    cb(inventoryItems)
end)

-- Deposit Items into Storage:
RegisterServerEvent('t1ger_mechanicjob:depositItem')
AddEventHandler('t1ger_mechanicjob:depositItem', function(item, amount, id)
    local xPlayer = ESX.GetPlayerFromId(source)
    local addItem = item
    local itemAdded = false
    if xPlayer.getInventoryItem(addItem).count >= amount then

        MySQL.Async.fetchAll("SELECT storage FROM t1ger_mechanic WHERE shopID = @shopID", {['@shopID'] = id}, function(data)
            if data[1].storage ~= nil then
                local storage = json.decode(data[1].storage)
                if #storage > 0 then 
                    for k,v in ipairs(storage) do 
                        if v.item == addItem then
                            v.count = (v.count + amount)
                            itemAdded = true
                            break
                        else
                            if k == #storage then
                                if Config.ItemLabelESX then
                                    table.insert(storage, {item = addItem, count = amount, label = ESX.GetItemLabel(addItem)})
                                else
                                    table.insert(storage, {item = addItem, count = amount, label = tostring(addItem)})
                                end
                                itemAdded = true
                                break
                            end
                        end
                    end
                    while not itemAdded do Citizen.Wait(1) end
                    if itemAdded then 
                        MySQL.Sync.execute("UPDATE t1ger_mechanic SET storage = @storage WHERE shopID = @shopID", {
                            ['@storage'] = json.encode(storage),
                            ['@shopID'] = id
                        })
                        xPlayer.removeInventoryItem(addItem, amount)
                        local itemLabel = ''
                        if Config.ItemLabelESX then itemLabel = ESX.GetItemLabel(addItem) else itemLabel = tostring(addItem) end
                        TriggerClientEvent('t1ger_mechanicjob:ShowNotifyESX', xPlayer.source, (Lang['storage_deposited_x']:format(amount, itemLabel)))
                    end
                else
                    storage = {}
                    if Config.ItemLabelESX then
                        table.insert(storage, {item = addItem, count = amount, label = ESX.GetItemLabel(addItem)})
                    else
                        table.insert(storage, {item = addItem, count = amount, label = tostring(addItem)})
                    end
                    MySQL.Sync.execute("UPDATE t1ger_mechanic SET storage = @storage WHERE shopID = @shopID", {
                        ['@storage'] = json.encode(storage),
                        ['@shopID'] = id
                    })   
                    xPlayer.removeInventoryItem(addItem, amount)
                    local itemLabel = ''
                    if Config.ItemLabelESX then itemLabel = ESX.GetItemLabel(addItem) else itemLabel = tostring(addItem) end
                    TriggerClientEvent('t1ger_mechanicjob:ShowNotifyESX', xPlayer.source, (Lang['storage_deposited_x']:format(amount, itemLabel)))
                end
            end
        end)
    else
        TriggerClientEvent('t1ger_mechanicjob:ShowNotifyESX', xPlayer.source, Lang['not_enough_items'])
    end
end)

-- Get Storage Inventory:
ESX.RegisterServerCallback('t1ger_mechanicjob:getStorageInventory', function(source, cb, id)
	local xPlayer = ESX.GetPlayerFromId(source)
    local dataFected = false
    local storageInv = {}
    MySQL.Async.fetchAll("SELECT storage FROM t1ger_mechanic WHERE shopID = @shopID", {['@shopID'] = id}, function(data)
        if data[1].storage ~= nil then
            local storage = json.decode(data[1].storage)
            if #storage > 0 then 
                for k,v in pairs(storage) do 
                    table.insert(storageInv,{item = v.item, count = v.count, label = v.label})
                    if k == #storage then 
                        dataFected = true
                    end
                end
            else
                cb(nil)
            end
        end
    end)
    while not dataFected do
        Citizen.Wait(1)
    end
    if dataFected then 
        cb(storageInv)
    end
end)

-- Withdraw Items from Storage:
RegisterServerEvent('t1ger_mechanicjob:withdrawItem')
AddEventHandler('t1ger_mechanicjob:withdrawItem', function(item, amount, id)
    local xPlayer = ESX.GetPlayerFromId(source)
    local removeItem = item
    MySQL.Async.fetchAll("SELECT storage FROM t1ger_mechanic WHERE shopID = @shopID", {['@shopID'] = id}, function(data)
        if data[1].storage ~= nil then
            local storage = json.decode(data[1].storage)
            for k,v in pairs(storage) do
                if removeItem == v.item then
                    v.count = (v.count - amount)
                    Citizen.Wait(250)
                    if v.count == 0 then
                        table.remove(storage, k)
                    end
                    MySQL.Sync.execute("UPDATE t1ger_mechanic SET storage = @storage WHERE shopID = @shopID", {
                        ['@storage'] = json.encode(storage),
                        ['@shopID'] = id
                    })
                    xPlayer.addInventoryItem(removeItem, amount)
                    local itemLabel = ''
                    if Config.ItemLabelESX then itemLabel = ESX.GetItemLabel(removeItem) else itemLabel = tostring(removeItem) end
                    TriggerClientEvent('t1ger_mechanicjob:ShowNotifyESX', xPlayer.source, (Lang['storage_withdrew_x']:format(amount, itemLabel)))
                end
            end
        end
    end)
end)

-- Craft Items:
RegisterServerEvent('t1ger_mechanicjob:craftItem')
AddEventHandler('t1ger_mechanicjob:craftItem', function(item_label, item_name, item_recipe, id, val)
    local xPlayer = ESX.GetPlayerFromId(source)
    local removeItems = {}
    local loopDone = false
    local hasRecipeItems = false
    for k,v in ipairs(item_recipe) do
		local material = Config.Materials[v.id]
        if xPlayer.getInventoryItem(material.item).count >= v.qty then
            table.insert(removeItems, {item = material.item, amount = v.qty})
        else
            loopDone = true
            hasRecipeItems = false
            break
        end
        if k == #item_recipe then 
            loopDone = true
            hasRecipeItems = true
        end
    end
    while not loopDone do 
        Citizen.Wait(1)
    end
    if hasRecipeItems then 
        for k,v in pairs(removeItems) do
            xPlayer.removeInventoryItem(v.item, v.amount)
        end
        xPlayer.addInventoryItem(item_name, 1)
    else
        TriggerClientEvent('t1ger_mechanicjob:ShowNotifyESX', xPlayer.source, Lang['not_enough_materials'])
    end
end)

-- Billing:
RegisterServerEvent('t1ger_mechanicjob:sendBill')
AddEventHandler('t1ger_mechanicjob:sendBill',function(target, amount)
	local xPlayer = ESX.GetPlayerFromId(source)
    local xPlayers = ESX.GetPlayers()
    local shopID = 0
    if amount ~= nil then
        if amount >= 0 then
            for i = 1, #xPlayers, 1 do
                local tPlayer = ESX.GetPlayerFromId(xPlayers[i])
                if tPlayer.source == target then
                    tPlayer.removeAccountMoney('bank', tonumber(amount))
                    TriggerClientEvent('t1ger_mechanicjob:ShowNotifyESX', tPlayer.source, "Du hast die Rechnung in höhe von ~g~$"..amount.."~s~ dem Mechaniker gezahlt.")
                    if Config.BillingToMechAccount then
                        local identifierMatch = false
                        local accountAmount = tonumber(amount * Config.BillingPercentToAcc)
                        local mechanicAmount = tonumber(amount - accountAmount)
                        xPlayer.addAccountMoney('bank', tonumber(mechanicAmount))
                        -- Get current mechanic shop account: 
                        MySQL.Async.fetchAll("SELECT * FROM t1ger_mechanic", {}, function(data)
                            for k,v in pairs(data) do
                                local employees = json.decode(v.employees)
                                if #employees > 0 then
                                    for _,y in pairs(employees) do
                                        if y.identifier == xPlayer.getIdentifier() then
                                            shopID = v.shopID
                                            identifierMatch = true
                                            break
                                        end
                                    end
                                end
                                if identifierMatch then break end
                                if k == #data then identifierMatch = true; break end
                            end
                        end)
                        while not identifierMatch do Wait(500) end 
                        -- update mechanic shop account:
                        local currentAccount = 0
                        MySQL.Async.fetchAll("SELECT money FROM t1ger_mechanic WHERE shopID = @shopID", {['@shopID'] = shopID}, function(data)
                            if data[1].money ~= nil then currentAccount = data[1].money end
                            MySQL.Sync.execute("UPDATE t1ger_mechanic SET money = @money WHERE shopID = @shopID", {
                                ['@money'] = (currentAccount + accountAmount),
                                ['@shopID'] = shopID
                            })
                        end)
                        TriggerClientEvent('t1ger_mechanicjob:ShowNotifyESX', xPlayer.source, "Du hast die Zahlung in höhe von ~g~$"..mechanicAmount.."~s~ erhalten. Der rest geht in das Firmen Konto.")
                    else
                        xPlayer.addAccountMoney('bank', tonumber(amount))
                        TriggerClientEvent('t1ger_mechanicjob:ShowNotifyESX', xPlayer.source, "Du hast die Zahlung in höhe von ~g~$"..amount.."~s~ erhalten.")
                    end
                    break
                end
            end
        end
    end
end)

-- Repair Kits:
Citizen.CreateThread(function()
	for k,v in pairs(Config.RepairKits) do 
		ESX.RegisterUsableItem(v.item, function(source)
			local xPlayer = ESX.GetPlayerFromId(source)
			TriggerClientEvent('t1ger_mechanicjob:useRepairKit', xPlayer.source, k, v)
		end)
	end
end)

-- Remove item event:
RegisterServerEvent('t1ger_mechanicjob:removeItem')
AddEventHandler('t1ger_mechanicjob:removeItem', function(item, amount)
    local xPlayer = ESX.GetPlayerFromId(source)
    xPlayer.removeInventoryItem(item, amount)
end)

-- Get inventory item:
ESX.RegisterServerCallback('t1ger_mechanicjob:getInventoryItem',function(source, cb, item)
    local xPlayer = ESX.GetPlayerFromId(source)
    local hasItem = xPlayer.getInventoryItem(item).count >= 1
    if hasItem then cb(true) else cb(false) end
end)

Citizen.CreateThread(function()
	for k,v in pairs(Config.BodyParts) do 
		ESX.RegisterUsableItem(v.item, function(source)
			local xPlayer = ESX.GetPlayerFromId(source)
			TriggerClientEvent('t1ger_mechanicjob:installBodyPartCL', xPlayer.source, k, v)
		end)
	end
end)

function GetOnlinePlayers()
    local xPlayers = ESX.GetPlayers()
	local players  = {}
	for i=1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
		table.insert(players, {
			source     = xPlayer.source,
			identifier = xPlayer.identifier,
			name       = xPlayer.name
		})
    end
    return players
end

-- Lift Features:
RegisterServerEvent('t1ger_mechanicjob:liftStateSV') 
AddEventHandler('t1ger_mechanicjob:liftStateSV', function(k, id, val, vehicle, state, player) 
    local xPlayer = ESX.GetPlayerFromId(source)
    local identifier = nil
    if player ~= nil then 
        identifier = xPlayer.getIdentifier()
    end
    Config.MechanicShops[k].lifts[id] = val
    Config.MechanicShops[k].lifts[id].currentVeh = vehicle
    Config.MechanicShops[k].lifts[id].inUse = state
    Config.MechanicShops[k].lifts[id].player = identifier
    Citizen.Wait(100)
    TriggerClientEvent('t1ger_mechanicjob:liftStateCL', -1, k, id, val, vehicle, state, identifier)
end)

-- Get Lift Player:
ESX.RegisterServerCallback('t1ger_mechanicjob:getLiftPlayer', function(source, cb, num, id, val)
    local xPlayer = ESX.GetPlayerFromId(source)
    local currentLift = Config.MechanicShops[num].lifts[id]
    if currentLift.player == xPlayer.getIdentifier() then
        cb(true)
    else
        cb(false)
    end
end)

-- Get Materials for Health Part Repair:
ESX.RegisterServerCallback('t1ger_mechanicjob:getMaterialsForHealthRep',function(source, cb, plate, degName, materials, newValue, addValue, vehOnLift)
    local xPlayer = ESX.GetPlayerFromId(source)
    -- Get & Remove materials:
    local removeItems = {}
    local loopDone = false
    local hasMaterials = false
    for k,v in ipairs(materials) do
        local items = Config.Materials[v.id]
        local multiplier = math.floor(addValue)
        local reqAmount = (v.qty * multiplier)
        if xPlayer.getInventoryItem(items.item).count >= reqAmount then
            table.insert(removeItems, {item = items.item, amount = reqAmount})
        else
            loopDone = true
            hasMaterials = false
            break
        end
        if k == #materials then 
            loopDone = true
            hasMaterials = true
        end
    end
    while not loopDone do 
        Citizen.Wait(1)
    end
    if hasMaterials then 
        for k,v in pairs(removeItems) do
            xPlayer.removeInventoryItem(v.item, v.amount)
        end
        cb(true)
    else
        cb(false)
    end
end)

-- Update Vehicle Degradation:
RegisterServerEvent('t1ger_mechanicjob:updateVehDegradation') 
AddEventHandler('t1ger_mechanicjob:updateVehDegradation', function(plate, label, degName, vehOnLift)
    local xPlayer = ESX.GetPlayerFromId(source)
    MySQL.Async.fetchAll("SELECT health FROM owned_vehicles WHERE plate=@plate",{['@plate'] = plate}, function(data) 
        if #data > 0 then
            if data[1].health ~= nil then 
                local health = json.decode(data[1].health)
                if #health > 0 then 
                    for k,v in pairs(health) do
                        if v.part == degName then
                            local updateValue = vehOnLift[plate].health[degName].value
                            if v.part == "engine" then
                                v.value = math.floor(updateValue * 10 * 10)
                            else
                                v.value = math.floor(updateValue * 10)
                            end
                            MySQL.Sync.execute("UPDATE owned_vehicles SET health = @health WHERE plate = @plate", {
                                ['@health'] = json.encode(health),
                                ['@plate'] = plate
                            })
                            TriggerClientEvent('t1ger_mechanicjob:ShowNotifyESX', xPlayer.source, (Lang['you_rep_health_part']:format(degName, updateValue)))
                            break
                        end
                    end
                end
            end 
        end
	end)
end)

-- Degrade Vehicle Degradation:
RegisterServerEvent('t1ger_mechanicjob:degradeVehHealth') 
AddEventHandler('t1ger_mechanicjob:degradeVehHealth', function(plate, damageArray)
    local xPlayer = ESX.GetPlayerFromId(source)
    MySQL.Async.fetchAll("SELECT health FROM owned_vehicles WHERE plate=@plate",{['@plate'] = plate}, function(data) 
        if #data > 0 then
            if data[1].health ~= nil then 
                local health = json.decode(data[1].health)
                if #health > 0 then 
                    for k,v in pairs(health) do
                        local part = damageArray[v.part]
                        if part ~= nil then
                            if v.part == part.degName then 
                                local degVal = part.degValue
                                local oldVal = v.value
                                v.value = (oldVal - degVal)
                                if v.value < 0 then v.value = 0 end
                                MySQL.Sync.execute("UPDATE owned_vehicles SET health = @health WHERE plate = @plate", {
                                    ['@health'] = json.encode(health),
                                    ['@plate'] = plate
                                })
                                TriggerClientEvent('t1ger_mechanicjob:ShowNotifyESX', xPlayer.source, part.label.." took damage. Degradation by: "..round(degVal/10,2)..". New Value: "..round(v.value/10,2))
                            end
                        end
                    end
                else
                    local healthJSON = {}
                    for k,v in ipairs(Config.HealthParts) do
                        local partVal = 100
                        if v.degName == "engine" then partVal = 1000 end
                        table.insert(healthJSON, {part = v.degName, value = partVal})
                        if k == #Config.HealthParts then 
                            MySQL.Sync.execute("UPDATE owned_vehicles SET health = @health WHERE plate = @plate", {
                                ['@health'] = json.encode(healthJSON),
                                ['@plate'] = plate
                            })
                            Wait(1000)
                            MySQL.Async.fetchAll("SELECT health FROM owned_vehicles WHERE plate=@plate",{['@plate'] = plate}, function(data) 
                                local health = json.decode(data[1].health)
                                if #health > 0 then 
                                    for k,v in pairs(health) do
                                        local part = damageArray[v.part]
                                        if part ~= nil then
                                            if v.part == part.degName then 
                                                local degVal = part.degValue
                                                local oldVal = v.value
                                                v.value = (oldVal - degVal)
                                                if v.value < 0 then v.value = 0 end
                                                MySQL.Sync.execute("UPDATE owned_vehicles SET health = @health WHERE plate = @plate", {
                                                    ['@health'] = json.encode(health),
                                                    ['@plate'] = plate
                                                })
                                                TriggerClientEvent('t1ger_mechanicjob:ShowNotifyESX', xPlayer.source, part.label.." took damage. Degradation by: "..round(degVal/10,2)..". New Value: "..round(v.value/10,2))
                                            end
                                        end
                                    end
                                end
                            end)
                        end
                    end
                end
            end 
        end
	end)
end)

-- Get Vehicle Owned Status:
ESX.RegisterServerCallback('t1ger_mechanicjob:getIfVehicleOwned',function(source, cb, plate)
    MySQL.Async.fetchAll("SELECT * FROM owned_vehicles WHERE plate=@plate",{['@plate'] = plate}, function(data) 
        if #data > 0 then
            cb(true)
        else
            cb(false)
        end
    end)
end)

-- Get Vehicle Degradation:
ESX.RegisterServerCallback('t1ger_mechanicjob:getVehDegradation',function(source, cb, plate)
    local healthArray = {}
    MySQL.Async.fetchAll("SELECT health FROM owned_vehicles WHERE plate=@plate",{['@plate'] = plate}, function(data) 
        if #data > 0 then
            if data[1].health ~= nil then
                local health = json.decode(data[1].health)
                if #health > 0 then
                    for k,v in pairs(health) do
                        table.insert(healthArray, {part = v.part, value = v.value})
                        if k == #health then
                            cb(healthArray)
                        end
                    end
                else
                    for k,v in ipairs(Config.HealthParts) do
                        local partVal = 100
                        if v.degName == "engine" then partVal = 1000 end
                        table.insert(healthArray, {part = v.degName, value = partVal})
                        if k == #Config.HealthParts then 
                            MySQL.Sync.execute("UPDATE owned_vehicles SET health = @health WHERE plate = @plate", {
                                ['@health'] = json.encode(healthArray),
                                ['@plate'] = plate
                            })
                            cb(healthArray)
                        end
                    end
                end
            else cb(nil) end 
        else cb(nil) end
    end)
end)

RegisterServerEvent('t1ger_mechanicjob:JobReward')
AddEventHandler('t1ger_mechanicjob:JobReward',function(payout)
    local xPlayer = ESX.GetPlayerFromId(source)
    local cash = math.random(payout.min,payout.max)
    xPlayer.addMoney(cash)
    TriggerClientEvent('t1ger_mechanicjob:ShowNotifyESX', xPlayer.source, (Lang['npc_job_cash_reward']:format(cash)))
end)

function round(num, numDecimalPlaces)
    local mult = 10^(numDecimalPlaces or 0)
    return math.floor(num * mult + 0.5) / mult
end

