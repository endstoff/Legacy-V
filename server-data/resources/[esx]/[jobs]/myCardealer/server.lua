ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
----- ESX -----
local OffDutyList = {}
local employees = {}
local vehicles = {}
local CurrPlate = nil
local gotPlate = false
TriggerEvent('esx_society:registerSociety', Cfg.society, Cfg.Society, Cfg.Society_Name, Cfg.Society_Name, Cfg.Society_Name, {type = 'public'})

MySQL.ready( function()
    vehicles = {}
    MySQL.Async.fetchAll(
        'SELECT * FROM cardealer',
        {},
        function (results)
            for i=1, #results, 1 do
                local v = results[i]
                table.insert(vehicles, {
                    id = v.id,
                    label = v.label,
                    model = v.model,
                    manufacturer = v.manufacturer,
                    price = v.price,
                    storage = v.storage,
                    bigstorage = v.bigstorage,
                    ps = v.ps,
                    maxSpeed = v.maxSpeed,
                    speedUp = v.speedUp,
                    modification = v.modification,
                    tankcapacity = v.tankcapacity,
                    orderd = v.orderd,
                    ordertotal = v.ordertotal,
                    produced = v.produced,
                    producetotal = v.producetotal,
                    time = v.time,
                    lastorder = v.lastorder
                })
            end
        end
    )
    print('myCardealer: DB import succes!')
end)

-- OneSync getPlayers

ESX.RegisterServerCallback('myCardealer:getClosestPlayer', function(source, cb, position, distance)
  local p = GetPlayers()
  local players = {}
  local vecposition = vector3(position.x, position.y, position.z)
  if(#p > 0) then
      for index, playerID in ipairs(p) do
          local player = ESX.GetPlayerFromId(playerID)
		  if player ~= nil then
			  local coords = player.getCoords(true)
			  --print(player.source .. 'DIST: ' .. source)
			  if player.source ~= source and #(vecposition - coords) < distance then
				
				  local playerInfo = {id = playerID, name = player.getName()}
				  table.insert(players, playerInfo)
				  
				  cb(playerInfo)
			  end
		  else
			print('[Info] ESX was unable to get the player from an ID.')
		  end
      end
  else
    --print('cb2')
	cb(nil)
  end
  
end)


--

ESX.RegisterServerCallback('myCardealer:hasEnoughMoney', function(source, cb, price, target)
	local cardealerSrc = source
	local xPlayer = ESX.GetPlayerFromId(target)
	
	if xPlayer.getAccount('bank').money >= price then
		cb(true)
	else
		cb(false)
	end
end)

RegisterServerEvent('myCardealer:removeMoney')
AddEventHandler('myCardealer:removeMoney', function(target, amount)
	local xPlayer = ESX.GetPlayerFromId(target)
	xPlayer.removeAccountMoney('bank', amount)
	
	TriggerEvent('esx_addonaccount:getSharedAccount', Cfg.Society_Name, function(account)
        account.addMoney(amount)
    end)
	
end)

RegisterServerEvent('myCardealer:getSocietyMoney')
AddEventHandler('myCardealer:getSocietyMoney', function()
    local _source = source
    local society_money = 0
    TriggerEvent('esx_addonaccount:getSharedAccount', Cfg.Society_Name, function(account)
        society_money = account.money
    end)
    TriggerClientEvent('myCardealer:ResultSocietyMoney', _source, society_money)
end)

RegisterServerEvent('myCardealer:hire')
AddEventHandler('myCardealer:hire', function(target, playerName)

    local _source = source
    local xPlayer = ESX.GetPlayerFromId(target)
    
    if xPlayer.job.name ~= Cfg.society then
        xPlayer.setJob(Cfg.society, 0)
        Wait(100)
        TriggerClientEvent('myCardealer:ShowAdvancedMSG', xPlayer.source, Cfg.NotificationPicture, Cfg.CompanyName, Translation[Cfg.Locale]['hired'], Translation[Cfg.Locale]['you_were_hired'])
        TriggerClientEvent('myCardealer:ShowAdvancedMSG', _source, Cfg.NotificationPicture, Cfg.CompanyName, Translation[Cfg.Locale]['hired'], Translation[Cfg.Locale]['you_hired'] .. playerName .. Translation[Cfg.Locale]['you_hired2'])
        TriggerEvent('myCardealer:getEmployeesDB')
    else
        TriggerClientEvent('myCardealer:ShowAdvancedMSG', _source, Cfg.NotificationPicture, Cfg.CompanyName, Translation[Cfg.Locale]['already_hired'], playerName .. Translation[Cfg.Locale]['is_already_hired'])
    end
end)

RegisterServerEvent('myCardealer:fire')
AddEventHandler('myCardealer:fire', function(target, firstname, lastname)
    local _source = source
    local xPlayer = ESX.GetPlayerFromIdentifier(target)
    if xPlayer ~= nil then
        xPlayer.setJob('unemployed', 0)
        Wait(100)
        TriggerClientEvent('myCardealer:ShowAdvancedMSG', xPlayer.source, Cfg.NotificationPicture,Cfg.CompanyName, Translation[Cfg.Locale]['fired'], Translation[Cfg.Locale]['you_are_fired'])
        TriggerClientEvent('myCardealer:ShowAdvancedMSG', _source, Cfg.NotificationPicture, Cfg.CompanyName, Translation[Cfg.Locale]['fired'], Translation[Cfg.Locale]['you_fired'] .. firstname .. ' ' .. lastname .. Translation[Cfg.Locale]['you_fired2'])
        TriggerEvent('myCardealer:getEmployeesDB')
    else
        TriggerClientEvent('myCardealer:ShowAdvancedMSG', _source, Cfg.NotificationPicture, Cfg.CompanyName, Translation[Cfg.Locale]['error'], Translation[Cfg.Locale]['player_not_online'])
    end
end)

RegisterServerEvent('myCardealer:promote')
AddEventHandler('myCardealer:promote', function(target, firstname, lastname, grade, label)
    local _source = source
    local xPlayer = ESX.GetPlayerFromIdentifier(target)
    if xPlayer ~= nil then
        xPlayer.setJob(Cfg.society, grade)
        Wait(100)
        TriggerClientEvent('myCardealer:ShowAdvancedMSG', xPlayer.source, Cfg.NotificationPicture, Cfg.CompanyName, Translation[Cfg.Locale]['promoted'], Translation[Cfg.Locale]['you_were_promoted'] .. label ..Translation[Cfg.Locale]['you_were_promoted2'])
        TriggerClientEvent('myCardealer:ShowAdvancedMSG', _source, Cfg.NotificationPicture, Cfg.CompanyName, Translation[Cfg.Locale]['promoted'], Translation[Cfg.Locale]['you_promoted'] .. firstname .. ' ' .. lastname .. Translation[Cfg.Locale]['you_promoted2'] .. label .. Translation[Cfg.Locale]['you_promoted3'])
    else
        TriggerClientEvent('myCardealer:ShowAdvancedMSG', _source, Cfg.NotificationPicture, Cfg.CompanyName, Translation[Cfg.Locale]['error'], Translation[Cfg.Locale]['player_not_online'])
    end
end)

RegisterServerEvent('myCardealer:RingRing')
AddEventHandler('myCardealer:RingRing', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    --local firstname, lastname = ESX.GetCharName(xPlayer.getIdentifier())
    TriggerClientEvent('myCardealer:ShowMSG', -1, '~b~' .. Translation[Cfg.Locale]['ring_ring'], true)
end)

RegisterServerEvent('myCardealer:getEmployeesDB')
AddEventHandler('myCardealer:getEmployeesDB', function()
    employees = {}
    OffDutyList = {}
    local _source = source
    MySQL.Async.fetchAll(
        'SELECT firstname, lastname, job_grade, identifier, phone_number FROM users WHERE job = @job ORDER BY job_grade DESC',
        { ['@job'] = Cfg.society },
        function (results)
            if #results > 0 then
                for i=1, #results, 1 do
                    print(results[i].firstname)
                    table.insert(employees, {
                        firstname = results[i].firstname,
                        lastname = results[i].lastname,
                        job_grade = results[i].job_grade,
                        identifier = results[i].identifier
                    })
                end
                TriggerClientEvent('myCardealer:getEmployeesResult', -1, employees)
            else
                TriggerClientEvent('myCardealer:getEmployeesResult', -1, employees)
            end
            --print('done')
        end
    )
end)

RegisterServerEvent('myCardealer:getEmployees')
AddEventHandler('myCardealer:getEmployees', function()
    local _source = source
    TriggerClientEvent('myCardealer:getEmployeesResult', _source, employees)
end)

RegisterServerEvent('myCardealer:getVehicles')
AddEventHandler('myCardealer:getVehicles', function()
    local _source = source
    TriggerClientEvent('myCardealer:getVehiclesResult', -1, vehicles)
end)

RegisterServerEvent('myCardealer:BuyVeh')
AddEventHandler('myCardealer:BuyVeh', function(targetSource, manufacturer, modellabel, vehProps, currStorage, SpawnName, price, plate)
    local _source = source
    if targetSource == 0 then
        targetSource = _source
    end
    TriggerClientEvent('myCardealer:ShowAdvancedMSG', targetSource, Cfg.NotificationPicture, Cfg.CompanyName, Translation[Cfg.Locale]['vehicle_purchased'], Translation[Cfg.Locale]['you_purchased'] .. manufacturer .. ' ' .. modellabel .. Translation[Cfg.Locale]['you_purchased2']  .. vehProps.plate .. Translation[Cfg.Locale]['you_purchased3'])
    TriggerClientEvent('myCardealer:ShowAdvancedMSG', _source, Cfg.NotificationPicture, Cfg.CompanyName, Translation[Cfg.Locale]['vehicle_sold'], Translation[Cfg.Locale]['you_sold'] .. manufacturer .. ' ' .. modellabel .. Translation[Cfg.Locale]['you_sold2'])

    print('Model: ' .. vehProps.model)

    --TriggerEvent('AdvancedParking:insertNewVehicleWithIdentifierToGarage', GetPlayerIdentifiers(targetSource)[1], vehProps)
    local xPlayer = ESX.GetPlayerFromId(targetSource)
    MySQL.Async.execute('INSERT INTO owned_vehicles (owner, plate, vehicle) VALUES (@owner, @plate, @vehicle)', {
        ['@owner']   = xPlayer.identifier,
        ['@plate']   = vehProps.plate,
        ['@vehicle'] = json.encode({model = vehProps.model, plate = vehProps.plate})
    }, function(rowsChanged)
        print('Vehicle successfully sold at Luxury Cardealer. Plate: ' .. vehProps.plate)

        PerformHttpRequest(Cfg.Webhook, function(e,r,h) end, "POST", json.encode({
			["username"] = "Job Logs | Legacy-V",
			["avatar_url"] = "https://i.imgur.com/6wKJCFU.png",
			["content"] = "[cardealer] | **" .. xPlayer.name(targetSource) .. "** wurde ein **" .. modellabel .. "** mit dem Kennzeichen **" .. vehProps.plate .. "** verkauft"
		}), {["Content-Type"] = "application/json"})

    end)

    --_source, steamID, netID, position, heading, modifications
    
    MySQL.Async.execute(
        'UPDATE cardealer SET storage = @storage WHERE model = @model', {
            ['@storage'] = currStorage-1, 
            ['@model'] = SpawnName, 
        }
    )
    
    local newStorage = currStorage-1
    for k,v in pairs(vehicles) do
        if GetHashKey(v.model) == GetHashKey(SpawnName) then
            table.remove(vehicles, k)
            table.insert(vehicles, {
                id = v.id,
                label = v.label,
                model = v.model,
                manufacturer = v.manufacturer,
                price = v.price,
                storage = newStorage,
                bigstorage = v.bigstorage,
                ps = v.ps,
                maxSpeed = v.maxSpeed,
                speedUp = v.speedUp,
                modification = v.modification,
                tankcapacity = v.tankcapacity,
                orderd = v.orderd,
                ordertotal = v.ordertotal,
                produced = v.produced,
                producetotal = v.producetotal,
                time = v.time,
                lastorder = v.lastorder
            })
            TriggerClientEvent('myCardealer:getVehiclesResult', -1, vehicles)
            break
        end
    end
    
end)

RegisterServerEvent('myCardealer:updateInfo')
AddEventHandler('myCardealer:updateInfo', function(id, type, newValue)

    for k, v in pairs(vehicles) do
        if v.id == id then
            if type == 'ps' then
                v.ps = newValue
                MySQL.Async.execute(
                    'UPDATE cardealer SET ps = @ps WHERE id = @id', {
                        ['@ps'] = newValue, 
                        ['@id'] = id, 
                    }
                )
            elseif type == 'maxSpeed' then
                v.maxSpeed = newValue
                MySQL.Async.execute(
                    'UPDATE cardealer SET maxSpeed = @maxSpeed WHERE id = @id', {
                        ['@maxSpeed'] = newValue, 
                        ['@id'] = id, 
                    }
                )
            elseif type == 'speedUp' then
                v.speedUp = newValue
                MySQL.Async.execute(
                    'UPDATE cardealer SET speedUp = @speedUp WHERE id = @id', {
                        ['@speedUp'] = newValue, 
                        ['@id'] = id, 
                    }
                )
            elseif type == 'modification' then
                v.modification = newValue
                MySQL.Async.execute(
                    'UPDATE cardealer SET modification = @modification WHERE id = @id', {
                        ['@modification'] = newValue, 
                        ['@id'] = id, 
                    }
                )
            elseif type == 'fuelcapacity' then
                v.tankcapacity = newValue
                MySQL.Async.execute(
                    'UPDATE cardealer SET tankcapacity = @tankcapacity WHERE id = @id', {
                        ['@tankcapacity'] = newValue, 
                        ['@id'] = id, 
                    }
                )
            end

            TriggerClientEvent('myCardealer:getVehiclesResult', -1, vehicles)
            break
        end
    end

    

end)

RegisterServerEvent('myCardealer:ReturnPlate')
AddEventHandler('myCardealer:ReturnPlate', function(Plate)
    local _source = source
    CurrPlate = Plate
    gotPlate = true
end)

RegisterServerEvent('myCardealer:liverVehicle')
AddEventHandler('myCardealer:liverVehicle', function(model, total, label, manufacturer)
    local _source = source
    MySQL.Async.fetchAll(
        'SELECT * FROM cardealer WHERE model = @model',
        { ['@model'] = model },
        function (results)
            for i=1, #results, 1 do
                local v = results[i]
                local newTotal = total+v.ordertotal
                MySQL.Async.execute(
                    'UPDATE cardealer SET orderd = @orderd, ordertotal = @ordertotal WHERE model = @model', {
                        ['@model'] = v.model, 
                        ['@orderd'] = true, 
                        ['@ordertotal'] = newTotal, 
                    }
                )
                for k,v2 in pairs(vehicles) do
                    if v2.model == v.model then
                        table.remove(vehicles, k)
                        table.insert(vehicles, {
                            id = v2.id,
                            label = v2.label,
                            model = v2.model,
                            manufacturer = v2.manufacturer,
                            price = v2.price,
                            storage = v2.storage,
                            bigstorage = v2.bigstorage,
                            ps = v2.ps,
                            maxSpeed = v2.maxSpeed,
                            speedUp = v2.speedUp,
                            modification = v2.modification,
                            tankcapacity = v2.tankcapacity,
                            orderd = 1,
                            ordertotal = newTotal,
                            produced = v2.produced,
                            producetotal = v2.producetotal,
                            time = v2.time,
                            lastorder = v2.lastorder
                        })
                        TriggerClientEvent('myCardealer:getVehiclesResult', -1, vehicles)
                        break
                    end
                end
                TriggerClientEvent('myCardealer:ShowAdvancedMSG', _source, Cfg.NotificationPicture, Cfg.CompanyName, Translation[Cfg.Locale]['vehicle_ordered'], Translation[Cfg.Locale]['you_ordered'] .. total .. 'x ' .. manufacturer .. ' ' .. label .. Translation[Cfg.Locale]['you_ordered2'] .. newTotal .. Translation[Cfg.Locale]['you_ordered3'])
            end
        end
    )
end)

RegisterServerEvent('myCardealer:produceVehicle')
AddEventHandler('myCardealer:produceVehicle', function(model, total, label, manufacturer)
    local _source = source
    MySQL.Async.fetchAll(
        'SELECT * FROM cardealer WHERE model = @model',
        { ['@model'] = model },
        function (results)
            for i=1, #results, 1 do
                local v = results[i]
                local newTotal = total+v.producetotal
                local currentTime = os.time()
                local diff = os.difftime(currentTime, v.lastorder)
                local minutes = diff / 60
                local hours = diff / 60
                local price = v.price * 0.1
                if v.time < hours then
                    TriggerEvent('esx_addonaccount:getSharedAccount', Cfg.Society_Name, function(account)
                        if account.money > price then
                            account.removeMoney(price)
                            MySQL.Async.execute(
                                'UPDATE cardealer SET produced = @produced, producetotal = @producetotal, lastorder = @lastorder WHERE model = @model', {
                                    ['@model'] = v.model, 
                                    ['@produced'] = true, 
                                    ['@producetotal'] = newTotal, 
                                    ['@lastorder'] = os.time(), 
                                }
                            )
                            TriggerClientEvent('myCardealer:ShowAdvancedMSG', _source, Cfg.NotificationPicture, Cfg.CompanyName, Translation[Cfg.Locale]['vehicle_ordered'], Translation[Cfg.Locale]['you_applied'] .. total .. 'x ' .. manufacturer .. ' ' .. label .. Translation[Cfg.Locale]['you_applied2'] .. newTotal .. Translation[Cfg.Locale]['you_applied3'])
                            for k,v2 in pairs(vehicles) do
                                if v2.model == v.model then
                                    table.remove(vehicles, k)
                                    table.insert(vehicles, {
                                        id = v2.id,
                                        label = v2.label,
                                        model = v2.model,
                                        manufacturer = v2.manufacturer,
                                        price = v2.price,
                                        storage = v2.storage,
                                        bigstorage = v2.bigstorage,
                                        ps = v2.ps,
                                        maxSpeed = v2.maxSpeed,
                                        speedUp = v2.speedUp,
                                        modification = v2.modification,
                                        tankcapacity = v2.tankcapacity,
                                        orderd = v2.orderd,
                                        ordertotal = v2.ordertotal,
                                        produced = 1,
                                        producetotal = newTotal,
                                        time = v2.time,
                                        lastorder = os.time()
                                    })
                                    TriggerClientEvent('myCardealer:getVehiclesResult', -1, vehicles)
                                    break
                                end
                            end
                        else
                            TriggerClientEvent('myCardealer:ShowMSG', _source, Translation[Cfg.Locale]['not_enough_money'])
                        end
                    end)
                else
                    TriggerEvent('esx_addonaccount:getSharedAccount', Cfg.Society_Name, function(account)
                        if account.money > price then
                            account.removeMoney(price)
                            MySQL.Async.execute(
                                'UPDATE cardealer SET produced = @produced, producetotal = @producetotal WHERE model = @model', {
                                    ['@model'] = v.model, 
                                    ['@produced'] = true, 
                                    ['@producetotal'] = newTotal,  
                                }
                            )
                            TriggerClientEvent('myCardealer:ShowAdvancedMSG', _source, Cfg.NotificationPicture, Cfg.CompanyName, Translation[Cfg.Locale]['vehicle_ordered'], Translation[Cfg.Locale]['you_applied'] .. total .. 'x ' .. manufacturer .. ' ' .. label .. Translation[Cfg.Locale]['you_applied2'] .. newTotal .. Translation[Cfg.Locale]['you_applied3'])
                            for k,v2 in pairs(vehicles) do
                                if v2.model == v.model then
                                    table.remove(vehicles, k)
                                    table.insert(vehicles, {
                                        id = v2.id,
                                        label = v2.label,
                                        model = v2.model,
                                        manufacturer = v2.manufacturer,
                                        price = v2.price,
                                        storage = v2.storage,
                                        bigstorage = v2.bigstorage,
                                        ps = v2.ps,
                                        maxSpeed = v2.maxSpeed,
                                        speedUp = v2.speedUp,
                                        modification = v2.modification,
                                        tankcapacity = v2.tankcapacity,
                                        orderd = v2.orderd,
                                        ordertotal = v2.ordertotal,
                                        produced = 1,
                                        producetotal = newTotal,
                                        time = v2.time,
                                        lastorder = v2.lastorder
                                    })
                                    TriggerClientEvent('myCardealer:getVehiclesResult', -1, vehicles)
                                    break
                                end
                            end
                        else
                            TriggerClientEvent('myCardealer:ShowMSG', _source, Translation[Cfg.Locale]['not_enough_money'])
                        end
                    end)
                end
            end
        end
    )
end)

function LiverVeh(d, h, m)
    --if d == 6 or d == 4 then
        MySQL.Async.fetchAll(
        'SELECT * FROM cardealer WHERE orderd = @orderd',
        { ['@orderd'] = 1 },
        function (results)
            for i=1, #results, 1 do
                local v = results[i]
                local newStorage = v.storage+v.ordertotal
                local price2 = v.price*0.65
                local price = price2*v.ordertotal
                TriggerEvent('esx_addonaccount:getSharedAccount', Cfg.Society_Name, function(account)
                    if account.money > price then
                        if v.bigstorage >= v.ordertotal then
                            account.removeMoney(price)
                            MySQL.Async.execute(
                                'UPDATE cardealer SET storage = @storage, orderd = @orderd, ordertotal = @ordertotal WHERE model = @model', {
                                    ['@storage'] = newStorage, 
                                    ['@model'] = v.model, 
                                    ['@orderd'] = false, 
                                    ['@ordertotal'] = 0, 
                                }
                            )
                            TriggerClientEvent('myCardealer:ShowMSG', -1, Translation[Cfg.Locale]['vehicle_delivered'], true)
                            for k,v2 in pairs(vehicles) do
                                if v2.model == v.model then
                                    table.remove(vehicles, k)
                                    table.insert(vehicles, {
                                        id = v2.id,
                                        label = v2.label,
                                        model = v2.model,
                                        manufacturer = v2.manufacturer,
                                        price = v2.price,
                                        storage = newStorage,
                                        bigstorage = v2.bigstorage,
                                        ps = v2.ps,
                                        maxSpeed = v2.maxSpeed,
                                        speedUp = v2.speedUp,
                                        modification = v2.modification,
                                        tankcapacity = v2.tankcapacity,
                                        orderd = v2.orderd,
                                        ordertotal = v2.ordertotal,
                                        produced = v2.produced,
                                        producetotal = v2.producetotal,
                                        time = v2.time,
                                        lastorder = os.time()
                                    })
                                    TriggerClientEvent('myCardealer:getVehiclesResult', -1, vehicles)
                                    break
                                end
                            end
                        else
                            TriggerClientEvent('myCardealer:ShowMSG', -1, Translation[Cfg.Locale]['not_enough_vehicles_in_storage'], true)
                        end
                    else
                        TriggerClientEvent('myCardealer:ShowMSG', -1, Translation[Cfg.Locale]['not_enough_money'], true)
                    end
                end)
            end
       end
    )
    TriggerEvent('myCardealer:getEmployeesDB')
    print('Vehicles delivered')
    --end
    
end

TriggerEvent('cron:runAt', Cfg.DeliveryTime.h, Cfg.DeliveryTime.m, LiverVeh)

RegisterServerEvent('myCardealer:CheckTime')
AddEventHandler('myCardealer:CheckTime', function(time, lastorder, model, oldstorage, total)
    local _source = source
    local currentTime = os.time()
    local diff = os.difftime(currentTime, lastorder)
    local minutes = diff / 60
    local hours = minutes / 60
    local diff2 = time-hours
    local newStorage = oldstorage+total

    if hours < time then
        TriggerClientEvent('myCardealer:CheckTimeResult', _source, math.floor(diff2) .. Translation[Cfg.Locale]['hours'])
    elseif hours > time then
        MySQL.Async.execute(
            'UPDATE cardealer SET bigstorage = @bigstorage, produced = @produced, producetotal = @producetotal WHERE model = @model', {
                ['@bigstorage'] = newStorage, 
                ['@model'] = model, 
                ['@produced'] = false, 
                ['@producetotal'] = 0, 
            }
        )
        TriggerClientEvent('myCardealer:ShowMSG', -1, Translation[Cfg.Locale]['vehicle_delivered'], true)
        for k,v2 in pairs(vehicles) do
            if v2.model == model then
                table.remove(vehicles, k)
                table.insert(vehicles, {
                    id = v2.id,
                    label = v2.label,
                    model = v2.model,
                    manufacturer = v2.manufacturer,
                    price = v2.price,
                    storage = v2.storage,
                    bigstorage = newStorage,
                    ps = v2.ps,
                    maxSpeed = v2.maxSpeed,
                    speedUp = v2.speedUp,
                    modification = v2.modification,
                    tankcapacity = v2.tankcapacity,
                    orderd = v2.orderd,
                    ordertotal = v2.ordertotal,
                    produced = 0,
                    producetotal = 0,
                    time = v2.time,
                    lastorder = v2.lastorder
                })
                TriggerClientEvent('myCardealer:getVehiclesResult', -1, vehicles)
                break
            end
        end
    end
end)


RegisterServerEvent('myCardealer:addSocietyMoney')
AddEventHandler('myCardealer:addSocietyMoney', function(amount)

    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer.getMoney() >= amount then
        TriggerEvent('esx_addonaccount:getSharedAccount', Cfg.Society_Name, function (account)
            xPlayer.removeMoney(amount)
            account.addMoney(amount)
        end)
    else
        TriggerClientEvent('myCardealer:ShowMSG', -1, Translation[Cfg.Locale]['not_enough_money_player'], true)
    end
    
end)


RegisterCommand("Cardealer", function(source, args, rawCommand)
    LiverVeh()


    TriggerEvent('myCardealer:getEmployeesDB')
    vehicles = {}
    MySQL.Async.fetchAll(
        'SELECT * FROM cardealer',
        {},
        function (results)
            for i=1, #results, 1 do
                local v = results[i]
                table.insert(vehicles, {
                    id = v.id,
                    label = v.label,
                    model = v.model,
                    manufacturer = v.manufacturer,
                    price = v.price,
                    storage = v.storage,
                    bigstorage = v.bigstorage,
                    ps = v.ps,
                    maxSpeed = v.maxSpeed,
                    speedUp = v.speedUp,
                    modification = v.modification,
                    tankcapacity = v.tankcapacity,
                    orderd = v.orderd,
                    ordertotal = v.ordertotal,
                    produced = v.produced,
                    producetotal = v.producetotal,
                    time = v.time,
                    lastorder = v.lastorder
                })
            end
        end
    )
    Wait(1000)
    TriggerClientEvent('myCardealer:getVehiclesResult', -1, vehicles)
end, true)