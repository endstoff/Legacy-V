ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterUsableItem('watermelon', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('watermelon', 1)

	TriggerClientEvent('esx_status:add', source, 'hunger', 100000)
	TriggerClientEvent('esx_basicneeds:onEat', source)
--	xPlayer.showNotification(_U('used_watermelon'))
	TriggerClientEvent('est_notify', source, '#ffffff', 'Lebensmittel', _U('used_watermelon'))
end)

ESX.RegisterUsableItem('tomatos', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('tomatos', 1)

	TriggerClientEvent('esx_status:add', source, 'hunger', 100000)
	TriggerClientEvent('esx_basicneeds:onEat', source)
--	xPlayer.showNotification(_U('used_tomatos'))
	TriggerClientEvent('est_notify', source, '#ffffff', 'Lebensmittel', _U('used_tomatos'))
end)

ESX.RegisterUsableItem('salad', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('salad', 1)

	TriggerClientEvent('esx_status:add', source, 'hunger', 100000)
	TriggerClientEvent('esx_basicneeds:onEat', source)
--	xPlayer.showNotification(_U('used_salad'))
	TriggerClientEvent('est_notify', source, '#ffffff', 'Lebensmittel', _U('used_salad'))
end)

ESX.RegisterUsableItem('mixedsalad', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('mixedsalad', 1)

	TriggerClientEvent('esx_status:add', source, 'hunger', 100000)
	TriggerClientEvent('esx_basicneeds:onEat', source)
--	xPlayer.showNotification(_U('used_mixedsalad'))
	TriggerClientEvent('est_notify', source, '#ffffff', 'Lebensmittel', _U('used_mixedsalad'))
end)


ESX.RegisterUsableItem('grapperaisin', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('grapperaisin', 1)

	TriggerClientEvent('esx_status:add', source, 'hunger', 100000)
	TriggerClientEvent('esx_basicneeds:onEat', source)
--	xPlayer.showNotification(_U('used_grapperaisin'))
	TriggerClientEvent('est_notify', source, '#ffffff', 'Lebensmittel', _U('used_grapperaisin'))
end)

ESX.RegisterUsableItem('water', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('water', 1)

	TriggerClientEvent('esx_status:add', source, 'thirst', 500000)
	TriggerClientEvent('esx_basicneeds:onDrink', source)
--	xPlayer.showNotification(_U('used_water'))
	TriggerClientEvent('est_notify', source, '#ffffff', 'Lebensmittel', _U('used_water'))
end)

ESX.RegisterUsableItem('tomatojuice', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('tomatojuice', 1)

	TriggerClientEvent('esx_status:add', source, 'thirst', 100000)
	TriggerClientEvent('esx_basicneeds:onDrink', source)
--	xPlayer.showNotification(_U('used_tomatojuice'))
	TriggerClientEvent('est_notify', source, '#ffffff', 'Lebensmittel', _U('used_tomatojuice'))
end)


ESX.RegisterUsableItem('applejuice', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('applejuice', 1)

	TriggerClientEvent('esx_status:add', source, 'thirst', 100000)
	TriggerClientEvent('esx_basicneeds:onDrink', source)
--	xPlayer.showNotification(_U('used_applejuice'))
	TriggerClientEvent('est_notify', source, '#ffffff', 'Lebensmittel', _U('used_applejuice'))
end)


ESX.RegisterUsableItem('berriesjuice', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('berriesjuice', 1)

	TriggerClientEvent('esx_status:add', source, 'thirst', 100000)
	TriggerClientEvent('esx_basicneeds:onDrink', source)
--	xPlayer.showNotification(_U('used_berriesjuice'))
	TriggerClientEvent('est_notify', source, '#ffffff', 'Lebensmittel', _U('used_berriesjuice'))
end)

ESX.RegisterUsableItem('fanta', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('fanta', 1)

	TriggerClientEvent('esx_status:add', source, 'thirst', 100000)
	TriggerClientEvent('esx_basicneeds:onDrink', source)
--	xPlayer.showNotification(_U('used_berriesjuice'))
	TriggerClientEvent('est_notify', source, '#ffffff', 'Lebensmittel', _U('used_fanta'))
end)

ESX.RegisterUsableItem('peanut', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('peanut', 1)

	TriggerClientEvent('esx_status:add', source, 'hunger', 100000)
	TriggerClientEvent('esx_basicneeds:onEat', source)
--	xPlayer.showNotification(_U('used_peanut'))
	TriggerClientEvent('est_notify', source, '#ffffff', 'Lebensmittel', _U('used_peanut'))
end)

ESX.RegisterUsableItem('sandwich', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('sandwich', 1)

	TriggerClientEvent('esx_status:add', source, 'hunger', 333333)
	TriggerClientEvent('esx_basicneeds:onEat', source)
--	xPlayer.showNotification(_U('used_sandwich'))
	TriggerClientEvent('est_notify', source, '#ffffff', 'Lebensmittel', _U('used_sandwich'))
end)


ESX.RegisterUsableItem('Pizzaa', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('Pizzaa', 1)

	TriggerClientEvent('esx_status:add', source, 'hunger', 100000)
	TriggerClientEvent('esx_basicneeds:onEat', source)
--	xPlayer.showNotification(_U('used_pizzaa'))
	TriggerClientEvent('est_notify', source, '#ffffff', 'Lebensmittel', _U('used_pizzaa'))
end)



ESX.RegisterUsableItem('apple', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('apple', 1)

	TriggerClientEvent('esx_status:add', source, 'hunger', 100000)
	TriggerClientEvent('esx_basicneeds:onEat', source)
--	xPlayer.showNotification(_U('used_apple'))
	TriggerClientEvent('est_notify', source, '#ffffff', 'Lebensmittel', _U('used_apple'))
end)


ESX.RegisterCommand('heal', 'admin', function(xPlayer, args, showError)
	args.playerId.triggerEvent('esx_basicneeds:healPlayer')
	args.playerId.triggerEvent('chat:addMessage', {args = {'^5HEAL', 'You have been healed.'}})
end, true, {help = 'Heal a player, or yourself - restores thirst, hunger and health.', validate = true, arguments = {
	{name = 'playerId', help = 'the player id', type = 'player'}
}})
