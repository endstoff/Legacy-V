ESX = nil

TriggerEvent('esx:getSharedObject', function(obj)
	ESX = obj
end)

local inUseTable = {

}

ESX.RegisterServerCallback('ps_carinventory:isOwned', function(source, cb, plate)
	local s = source
	local x = ESX.GetPlayerFromId(s)
	local iden = x.identifier

	local carOwner = MySQL.Sync.fetchScalar("SELECT owner FROM owned_vehicles WHERE plate = @plate", {['@plate'] = plate})
	cb(iden == carOwner)
end)


ESX.RegisterServerCallback("ps_carinventory:loadTargetInv", function(source, cb, target)
	local xTarget = ESX.GetPlayerFromId(target)
	local items = xTarget.getInventory()
	local _items = items

	for key, value in ipairs(_items) do
		local item = MySQL.Sync.fetchAll('SELECT * FROM items WHERE name = @name ', {['@name'] = value.name})
		value.name = item[1].name
		value.label = item[1].label
		value.limit = item[1].limit
		value.rare = value.rare
		value.can_remove = value.canRemove
		value.url = item[1].url


		if value.count <= 0 then
			_items[key] = nil
		end
	end


	cb(_items)
end)

ESX.RegisterServerCallback("ps_carinventory:loadTargetPlate", function(source, cb, target)
	local xTarget = ESX.GetPlayerFromId(source)
	local items = MySQL.Sync.fetchAll('SELECT * FROM trunk_inventory WHERE plate = @plate', {['@plate'] = target})
	local _items = items

	for key, value in ipairs(_items) do
		local item = xTarget.getInventoryItem(value.item)
		value.name = value.name
		value.label = item.label
		value.limit = item.limit
		value.rare = value.rare
		value.can_remove = value.canRemove

		if value.count <= 0 then
			_items[key] = nil
		end
	end

	cb(_items)
end)

ESX.RegisterServerCallback("ps_carinventory:loadMoneyInv", function(source, cb)
	local s = source
	local x = ESX.GetPlayerFromId(s)
	cb(x.getMoney())
end)

RegisterNetEvent('ps_carinventory:convert')
AddEventHandler('ps_carinventory:convert', function(current, item, count, plate)
	local s = source
	local x = ESX.GetPlayerFromId(s)

	if current == 'trunk' then
		removeInventoryItem(plate, item, tonumber(count))
	else
		addInventoryItem(plate, item, tonumber(count))
	end
end)

function removeInventoryItem(plate, item, count)
	if plate ~= nil and item ~= nil and count > 0 and plate ~= 'undefined' and item ~= 'undefined' then
		local _source = source
		local xPlayer = ESX.GetPlayerFromId(_source)

		MySQL.Sync.execute("UPDATE trunk_inventory SET count = count - @count WHERE plate = @plate AND item = @item", {
			['@plate'] = plate,
			['@count'] = count,
			['@item'] = item
		})

		if xPlayer ~= nil then
			xPlayer.addInventoryItem(item, count)
		end

		TriggerClientEvent('ps_carinventory:refresh', source)
	end
end

function addInventoryItem(plate, item, count)
	if plate ~= nil and item ~= nil and count > 0 and plate ~= 'undefined' and item ~= 'undefined' then
		local _source = source
		local xPlayer = ESX.GetPlayerFromId(_source)

		MySQL.Sync.execute('INSERT INTO trunk_inventory (item, count, plate) VALUES (@item, @count, @plate) ON DUPLICATE KEY UPDATE count = count + @count', {
			['@plate'] = plate,
			['@item'] = item,
			['@count'] = count,
		})

		if xPlayer ~= nil then
			xPlayer.removeInventoryItem(item, count)
		end

		TriggerClientEvent('ps_carinventory:refresh', source)
	end
end

RegisterNetEvent('ps_carinventory:setInUse')
AddEventHandler('ps_carinventory:setInUse', function(plate)
	table.insert(inUseTable, plate)
end)

RegisterNetEvent('ps_carinventory:removeInUse')
AddEventHandler('ps_carinventory:removeInUse', function(plate)
	for i = 1, #inUseTable, 1 do
		if inUseTable[i] == plate then
			table.remove(inUseTable, i)
		end
	end
end)

ESX.RegisterServerCallback("ps_carinventory:IsInUse", function(source, cb, plate)
	local inUse = false

	for i = 1, #inUseTable, 1 do
		if inUseTable[i] == plate then
			inUse = true
		end
	end

	cb(inUse)
end)