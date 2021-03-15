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

ESX.RegisterUsableItem('ecola', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('ecola', 1)

	TriggerClientEvent('esx_status:add', source, 'thirst', 250000)
	TriggerClientEvent('esx_basicneeds:onEat', source)
--	xPlayer.showNotification(_U('used_ecola'))
	TriggerClientEvent('est_notify', source, '#ffffff', 'Lebensmittel', _U('used_ecola'))
end)

ESX.RegisterUsableItem('sprunk', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('sprunk', 1)

	TriggerClientEvent('esx_status:add', source, 'thirst', 250000)
	TriggerClientEvent('esx_basicneeds:onEat', source)
--	xPlayer.showNotification(_U('used_sprunk'))
	TriggerClientEvent('est_notify', source, '#ffffff', 'Lebensmittel', _U('used_sprunk'))
end)

ESX.RegisterUsableItem('icetea', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('icetea', 1)

	TriggerClientEvent('esx_status:add', source, 'thirst', 350000)
	TriggerClientEvent('esx_basicneeds:onEat', source)
--	xPlayer.showNotification(_U('used_icetea'))
	TriggerClientEvent('est_notify', source, '#ffffff', 'Lebensmittel', _U('used_icetea'))
end)


ESX.RegisterUsableItem('icetea_sparkling', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('icetea_sparkling', 1)

	TriggerClientEvent('esx_status:add', source, 'thirst', 350000)
	TriggerClientEvent('esx_basicneeds:onEat', source)
--	xPlayer.showNotification(_U('used_icetea_sparkling'))
	TriggerClientEvent('est_notify', source, '#ffffff', 'Lebensmittel', _U('used_icetea_sparkling'))
end)


ESX.RegisterUsableItem('p&qs', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('p&qs', 1)

	TriggerClientEvent('esx_status:add', source, 'hunger', 100000)
	TriggerClientEvent('esx_basicneeds:onEat', source)
--	xPlayer.showNotification(_U('used_p&qs'))
	TriggerClientEvent('est_notify', source, '#ffffff', 'Lebensmittel', _U('used_p&qs'))
end)


ESX.RegisterUsableItem('phatchips', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('phatchips', 1)

	TriggerClientEvent('esx_status:add', source, 'hunger', 100000)
	TriggerClientEvent('esx_basicneeds:onEat', source)
--	xPlayer.showNotification(_U('used_phatchips'))
	TriggerClientEvent('est_notify', source, '#ffffff', 'Lebensmittel', _U('used_phatchips'))
end)


ESX.RegisterUsableItem('fries', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('fries', 1)

	TriggerClientEvent('esx_status:add', source, 'hunger', 250000)
	TriggerClientEvent('esx_basicneeds:onEat', source)
--	xPlayer.showNotification(_U('used_fries'))
	TriggerClientEvent('est_notify', source, '#ffffff', 'Lebensmittel', _U('used_fries'))
end)


ESX.RegisterUsableItem('waffle', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('waffle', 1)

	TriggerClientEvent('esx_status:add', source, 'hunger', 250000)
	TriggerClientEvent('esx_basicneeds:onEat', source)
--	xPlayer.showNotification(_U('used_waffle'))
	TriggerClientEvent('est_notify', source, '#ffffff', 'Lebensmittel', _U('used_waffle'))
end)


ESX.RegisterUsableItem('beefsnack', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('beefsnack', 1)

	TriggerClientEvent('esx_status:add', source, 'hunger', 250000)
	TriggerClientEvent('esx_basicneeds:onEat', source)
--	xPlayer.showNotification(_U('used_beefsnack'))
	TriggerClientEvent('est_notify', source, '#ffffff', 'Lebensmittel', _U('used_beefsnack'))
end)

ESX.RegisterCommand('heal', 'admin', function(xPlayer, args, showError)
	args.playerId.triggerEvent('esx_basicneeds:healPlayer')
	args.playerId.triggerEvent('chat:addMessage', {args = {'^5HEAL', 'You have been healed.'}})
end, true, {help = 'Heal a player, or yourself - restores thirst, hunger and health.', validate = true, arguments = {
	{name = 'playerId', help = 'the player id', type = 'player'}
}})
