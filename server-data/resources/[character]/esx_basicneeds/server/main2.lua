ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

------------------------------------------- Food ---------------------------------------------

ESX.RegisterUsableItem('bread', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	local _source = source
	
	xPlayer.removeInventoryItem('bread', 1)

	TriggerClientEvent('esx_status:add', source, 'hunger', 200000)
	TriggerClientEvent('esx_basicneeds:onEat', source)
	TriggerClientEvent('pNotify:SendNotification', _source, {layout = 'topLeft', theme = 'gta', type = 'warning', text1 = 'Lebensmittel', text2 = 'Du hast ein Brot gegessen'})
end)

ESX.RegisterUsableItem('pommes', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	local _source = source

	xPlayer.removeInventoryItem('pommes', 1)

	TriggerClientEvent('esx_status:add', source, 'hunger', 200000)
	TriggerClientEvent('esx_basicneeds:onEat', source)
	TriggerClientEvent('pNotify:SendNotification', _source, {layout = 'topLeft', theme = 'gta', type = 'warning', text1 = 'Lebensmittel', text2 = 'Du hast eine Pommes gegessen'})
end)

ESX.RegisterUsableItem('erdbeere', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	local _source = source

	xPlayer.removeInventoryItem('erdbeere', 1)

	TriggerClientEvent('esx_status:add', source, 'hunger', 50000)
	TriggerClientEvent('esx_basicneeds:onEat', source)
	TriggerClientEvent('pNotify:SendNotification', _source, {layout = 'topLeft', theme = 'gta', type = 'warning', text1 = 'Lebensmittel', text2 = 'Du hast eine Erdbeere gegessen'})
end)

ESX.RegisterUsableItem('ebkuchen', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	local _source = source

	xPlayer.removeInventoryItem('ebkuchen', 1)

	TriggerClientEvent('esx_status:add', source, 'hunger', 200000)
	TriggerClientEvent('esx_basicneeds:onEat', source)
	TriggerClientEvent('pNotify:SendNotification', _source, {layout = 'topLeft', theme = 'gta', type = 'warning', text1 = 'Lebensmittel', text2 = 'Du hast einen Lebkuchen gegessen'})
end)

ESX.RegisterUsableItem('dönerpommes', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	local _source = source

	xPlayer.removeInventoryItem('dönerpommes', 1)

	TriggerClientEvent('esx_status:add', source, 'hunger', 200000)
	TriggerClientEvent('esx_basicneeds:onEat', source)
	TriggerClientEvent('pNotify:SendNotification', _source, {layout = 'topLeft', theme = 'gta', type = 'warning', text1 = 'Lebensmittel', text2 = 'Du hast eine Döner Pommes gegessen'})
end)

ESX.RegisterUsableItem('donerpommes', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	local _source = source

	xPlayer.removeInventoryItem('donerpommes', 1)

	TriggerClientEvent('esx_status:add', source, 'hunger', 200000)
	TriggerClientEvent('esx_basicneeds:onEat', source)
	TriggerClientEvent('pNotify:SendNotification', _source, {layout = 'topLeft', theme = 'gta', type = 'warning', text1 = 'Lebensmittel', text2 = 'Du hast eine Döner Pommes gegessen'})
end)

ESX.RegisterUsableItem('doner', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	local _source = source

	xPlayer.removeInventoryItem('doner', 1)

	TriggerClientEvent('esx_status:add', source, 'hunger', 200000)
	TriggerClientEvent('esx_basicneeds:onEat', source)
	TriggerClientEvent('pNotify:SendNotification', _source, {layout = 'topLeft', theme = 'gta', type = 'warning', text1 = 'Lebensmittel', text2 = 'Du hast einen Döner gegessen'})
end)

ESX.RegisterUsableItem('pille', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	local _source = source

	xPlayer.removeInventoryItem('pille', 1)

	TriggerClientEvent('esx_status:add', source, 'hunger', 0)
	TriggerClientEvent('pNotify:SendNotification', _source, {layout = 'topLeft', theme = 'gta', type = 'warning', text1 = 'Lebensmittel', text2 = 'Du hast eine Pille genommen'})
end)

ESX.RegisterUsableItem('apfel', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	local _source = source

	xPlayer.removeInventoryItem('apfel', 1)

	TriggerClientEvent('esx_status:add', source, 'hunger', 80000)
	TriggerClientEvent('esx_basicneeds:onEat', source)
	TriggerClientEvent('pNotify:SendNotification', _source, {layout = 'topLeft', theme = 'gta', type = 'warning', text1 = 'Lebensmittel', text2 = 'Du hast einen Apfel gegessen'})
end)

ESX.RegisterUsableItem('weintraube', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	local _source = source

	xPlayer.removeInventoryItem('weintraube', 1)

	TriggerClientEvent('esx_status:add', source, 'hunger', 40000)
	TriggerClientEvent('esx_basicneeds:onEat', source)
	TriggerClientEvent('pNotify:SendNotification', _source, {layout = 'topLeft', theme = 'gta', type = 'warning', text1 = 'Lebensmittel', text2 = 'Du hast eine Weintraube gegessen'})
end)

ESX.RegisterUsableItem('fish', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	local _source = source

	xPlayer.removeInventoryItem('fish', 1)

	TriggerClientEvent('esx_status:add', source, 'hunger', 180000)
	TriggerClientEvent('esx_basicneeds:onEat', source)
	TriggerClientEvent('pNotify:SendNotification', _source, {layout = 'topLeft', theme = 'gta', type = 'warning', text1 = 'Lebensmittel', text2 = 'Du hast einen Fisch gegessen'})
end)

ESX.RegisterUsableItem('mars', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	local _source = source

	xPlayer.removeInventoryItem('mars', 1)

	TriggerClientEvent('esx_status:add', source, 'hunger', 40000)
	TriggerClientEvent('esx_basicneeds:onEat', source)
	TriggerClientEvent('pNotify:SendNotification', _source, {layout = 'topLeft', theme = 'gta', type = 'warning', text1 = 'Lebensmittel', text2 = 'Du hast einen Mars gegessen'})
end)

ESX.RegisterUsableItem('oreo', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	local _source = source	

	xPlayer.removeInventoryItem('oreo', 1)

	TriggerClientEvent('esx_status:add', source, 'hunger', 40000)
	TriggerClientEvent('esx_basicneeds:onEat', source)
	TriggerClientEvent('pNotify:SendNotification', _source, {layout = 'topLeft', theme = 'gta', type = 'warning', text1 = 'Lebensmittel', text2 = 'Du hast einen Oreo gegessen'})
end)

ESX.RegisterUsableItem('snickers', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	local _source = source

	xPlayer.removeInventoryItem('snickers', 1)

	TriggerClientEvent('esx_status:add', source, 'hunger', 40000)
	TriggerClientEvent('esx_basicneeds:onEat', source)
	TriggerClientEvent('pNotify:SendNotification', _source, {layout = 'topLeft', theme = 'gta', type = 'warning', text1 = 'Lebensmittel', text2 = 'Du hast ein Snickers gegessen'})
end)

------------------------------------- IMBISS --------------------------------------


---- Dönerpommes
ESX.RegisterUsableItem('dönerpommes', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	local _source = source

	xPlayer.removeInventoryItem('dönerpommes', 1)

	TriggerClientEvent('esx_status:add', source, 'hunger', 250000)
	TriggerClientEvent('esx_basicneeds:onEat', source)
	TriggerClientEvent('pNotify:SendNotification', _source, {layout = 'topLeft', theme = 'gta', type = 'warning', text1 = 'Lebensmittel', text2 = 'Du hast eine Dönner Pommes gegessen'})
end)


---- Döner
ESX.RegisterUsableItem('döner', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	local _source = source

	xPlayer.removeInventoryItem('döner', 1)

	TriggerClientEvent('esx_status:add', source, 'hunger', 220000)
	TriggerClientEvent('esx_basicneeds:onEat', source)
	TriggerClientEvent('pNotify:SendNotification', _source, {layout = 'topLeft', theme = 'gta', type = 'warning', text1 = 'Lebensmittel', text2 = 'Du hast einen Döner gegessen'})
end)


---- Pizza-Salami
ESX.RegisterUsableItem('pizzasalami', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	local _source = source

	xPlayer.removeInventoryItem('pizzasalami', 1)

	TriggerClientEvent('esx_status:add', source, 'hunger', 220000)
	TriggerClientEvent('esx_basicneeds:onEat', source)
	TriggerClientEvent('pNotify:SendNotification', _source, {layout = 'topLeft', theme = 'gta', type = 'warning', text1 = 'Lebensmittel', text2 = 'Du hast eine Pizza Salami gegessen'})
end)


---- Pizza-Hawaii
ESX.RegisterUsableItem('pizzahawaii', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	local _source = source

	xPlayer.removeInventoryItem('pizzahawaii', 1)

	TriggerClientEvent('esx_status:add', source, 'hunger', 220000)
	TriggerClientEvent('esx_basicneeds:onEat', source)
	TriggerClientEvent('pNotify:SendNotification', _source, {layout = 'topLeft', theme = 'gta', type = 'warning', text1 = 'Lebensmittel', text2 = 'Du hast eine Pizza Hawaii gegessen'})
end)

------------------------------------- Drinks --------------------------------------

ESX.RegisterUsableItem('alcfreebeer', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	local _source = source

	xPlayer.removeInventoryItem('alcfreebeer', 1)

	TriggerClientEvent('esx_status:add', source, 'thirst', 150000)
	TriggerClientEvent('esx_basicneeds:onDrink', source)
	TriggerClientEvent('pNotify:SendNotification', _source, {layout = 'topLeft', theme = 'gta', type = 'warning', text1 = 'Lebensmittel', text2 = 'Du hast ein Alkoholfreies Bier getrunken'})
end)

ESX.RegisterUsableItem('water', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	local _source = source

	xPlayer.removeInventoryItem('water', 1)

	TriggerClientEvent('esx_status:add', source, 'thirst', 200000)
	TriggerClientEvent('esx_basicneeds:onDrink', source)
	TriggerClientEvent('pNotify:SendNotification', _source, {layout = 'topLeft', theme = 'gta', type = 'warning', text1 = 'Lebensmittel', text2 = 'Du hast ein Wasser getrunken'})
end)

ESX.RegisterUsableItem('apfelsaft', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	local _source = source

	xPlayer.removeInventoryItem('apfelsaft', 1)

	TriggerClientEvent('esx_status:add', source, 'thirst', 100000)
	TriggerClientEvent('esx_basicneeds:onDrink', source)
	TriggerClientEvent('pNotify:SendNotification', _source, {layout = 'topLeft', theme = 'gta', type = 'warning', text1 = 'Lebensmittel', text2 = 'Du hast einen Apfelsaft getrunken'})
end)

ESX.RegisterUsableItem('redbull', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	local _source = source

	xPlayer.removeInventoryItem('redbull', 1)

	TriggerClientEvent('esx_status:add', source, 'thirst', 50000)
	TriggerClientEvent('esx_basicneeds:onDrink', source)
	TriggerClientEvent('pNotify:SendNotification', _source, {layout = 'topLeft', theme = 'gta', type = 'warning', text1 = 'Lebensmittel', text2 = 'Du hast ein RedBull getrunken'})
end)

ESX.RegisterUsableItem('drpepper', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	local _source = source

	xPlayer.removeInventoryItem('drpepper', 1)

	TriggerClientEvent('esx_status:add', source, 'thirst', 180000)
	TriggerClientEvent('esx_basicneeds:onDrink', source)
	TriggerClientEvent('pNotify:SendNotification', _source, {layout = 'topLeft', theme = 'gta', type = 'warning', text1 = 'Lebensmittel', text2 = 'Du hast eine DrPepper getrunken'})
end)

ESX.RegisterUsableItem('icetea', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	local _source = source

	xPlayer.removeInventoryItem('icetea', 1)

	TriggerClientEvent('esx_status:add', source, 'thirst', 180000)
	TriggerClientEvent('esx_basicneeds:onDrink', source)
	TriggerClientEvent('pNotify:SendNotification', _source, {layout = 'topLeft', theme = 'gta', type = 'warning', text1 = 'Lebensmittel', text2 = 'Du hast einen Eistee getrunken'})
end)

ESX.RegisterUsableItem('soda', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	local _source = source

	xPlayer.removeInventoryItem('soda', 1)

	TriggerClientEvent('esx_status:add', source, 'thirst', 180000)
	TriggerClientEvent('esx_basicneeds:onDrink', source)
	TriggerClientEvent('pNotify:SendNotification', _source, {layout = 'topLeft', theme = 'gta', type = 'warning', text1 = 'Lebensmittel', text2 = 'Du hast ein Soda getrunken'})
end)

ESX.RegisterUsableItem('rockstar', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	local _source = source

	xPlayer.removeInventoryItem('rockstar', 1)

	TriggerClientEvent('esx_status:add', source, 'thirst', 180000)
	TriggerClientEvent('esx_basicneeds:onDrink', source)
	TriggerClientEvent('pNotify:SendNotification', _source, {layout = 'topLeft', theme = 'gta', type = 'warning', text1 = 'Lebensmittel', text2 = 'Du hast ein Rockstar getrunken'})
end)

ESX.RegisterUsableItem('monster', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	local _source = source

	xPlayer.removeInventoryItem('monster', 1)

	TriggerClientEvent('esx_status:add', source, 'thirst', 180000)
	TriggerClientEvent('esx_basicneeds:onDrink', source)
	TriggerClientEvent('esx_basicneeds:onStamina')
	TriggerClientEvent('pNotify:SendNotification', _source, {layout = 'topLeft', theme = 'gta', type = 'warning', text1 = 'Lebensmittel', text2 = 'Du hast ein Monster getrunken'})
end)

ESX.RegisterUsableItem('fanta', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	local _source = source

	xPlayer.removeInventoryItem('fanta', 1)

	TriggerClientEvent('esx_status:add', source, 'thirst', 200000)
	TriggerClientEvent('esx_basicneeds:onDrink', source)
	TriggerClientEvent('pNotify:SendNotification', _source, {layout = 'topLeft', theme = 'gta', type = 'warning', text1 = 'Lebensmittel', text2 = 'Du hast eine Fanta getrunken'})
end)

ESX.RegisterUsableItem('martini', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	local _source = source

	xPlayer.removeInventoryItem('martini', 1)

	TriggerClientEvent('esx_status:add', source, 'thirst', 200000)
	TriggerClientEvent('esx_basicneeds:onDrink', source)
	TriggerClientEvent('pNotify:SendNotification', _source, {layout = 'topLeft', theme = 'gta', type = 'warning', text1 = 'Lebensmittel', text2 = 'Du hast einen Martini getrunken'})
end)


ESX.RegisterUsableItem('tequila', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	local _source = source

	xPlayer.removeInventoryItem('tequila', 1)

	TriggerClientEvent('esx_status:add', source, 'thirst', 200000)
	TriggerClientEvent('esx_basicneeds:onDrink', source)
	TriggerClientEvent('pNotify:SendNotification', _source, {layout = 'topLeft', theme = 'gta', type = 'warning', text1 = 'Lebensmittel', text2 = 'Du hast einen Tequila getrunken'})
end)


ESX.RegisterUsableItem('rhum', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	local _source = source

	xPlayer.removeInventoryItem('rhum', 1)

	TriggerClientEvent('esx_status:add', source, 'thirst', 200000)
	TriggerClientEvent('esx_basicneeds:onDrink', source)
	TriggerClientEvent('pNotify:SendNotification', _source, {layout = 'topLeft', theme = 'gta', type = 'warning', text1 = 'Lebensmittel', text2 = 'Du hast einen Rum getrunken'})
end)
---------------------------------------- Starbucks -----------------------------------------


---- Latte
ESX.RegisterUsableItem('latte_macchiato', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	local _source = source

	xPlayer.removeInventoryItem('latte_macchiato', 1)

	TriggerClientEvent('esx_status:add', source, 'thirst', 100000)
	TriggerClientEvent('esx_basicneeds:onDrink', source)
	TriggerClientEvent('pNotify:SendNotification', _source, {layout = 'topLeft', theme = 'gta', type = 'warning', text1 = 'Lebensmittel', text2 ='Du hast einen Latte Macchiato getrunken'})
end)


---- Cappucino
ESX.RegisterUsableItem('cappucino', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	local _source = source

	xPlayer.removeInventoryItem('cappucino', 1)

	TriggerClientEvent('esx_status:add', source, 'thirst', 100000)
	TriggerClientEvent('esx_basicneeds:onDrink', source)
	TriggerClientEvent('pNotify:SendNotification', _source, {layout = 'topLeft', theme = 'gta', type = 'warning', text1 = 'Lebensmittel', text2 = 'Du hast einen Cappuchino getrunken'})
end)


---- Iced Cafe
ESX.RegisterUsableItem('ice_cafe', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	local _source = source

	xPlayer.removeInventoryItem('ice_cafe', 1)

	TriggerClientEvent('esx_status:add', source, 'thirst', 100000)
	TriggerClientEvent('esx_basicneeds:onDrink', source)
	TriggerClientEvent('pNotify:SendNotification', _source, {layout = 'topLeft', theme = 'gta', type = 'warning', text1 = 'Lebensmittel', text2 = 'Du hast einen Eiskaffee getrunken'})
end)


---- Tee
ESX.RegisterUsableItem('tea', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	local _source = source

	xPlayer.removeInventoryItem('tea', 1)

	TriggerClientEvent('esx_status:add', source, 'thirst', 100000)
	TriggerClientEvent('esx_basicneeds:onDrink', source)
	TriggerClientEvent('pNotify:SendNotification', _source, {layout = 'topLeft', theme = 'gta', type = 'warning', text1 = 'Lebensmittel', text2 = 'Du hast einen Tee getrunken'})
end)


---- Milchshake
ESX.RegisterUsableItem('milk_shake', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	local _source = source

	xPlayer.removeInventoryItem('milk_shake', 1)

	TriggerClientEvent('esx_status:add', source, 'thirst', 100000)
	TriggerClientEvent('esx_basicneeds:onDrink', source)
	TriggerClientEvent('pNotify:SendNotification', _source, {layout = 'topLeft', theme = 'gta', type = 'warning', text1 = 'Lebensmittel', text2 = 'Du hast einen Milchshake'})
end)


---- Vanille Shake
ESX.RegisterUsableItem('milk_shake_vanille', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	local _source = source

	xPlayer.removeInventoryItem('milk_shake_vanille', 1)

	TriggerClientEvent('esx_status:add', source, 'thirst', 100000)
	TriggerClientEvent('esx_basicneeds:onDrink', source)
	TriggerClientEvent('pNotify:SendNotification', _source, {layout = 'topLeft', theme = 'gta', type = 'warning', text1 = 'Lebensmittel', text2 = 'Du hast einen Vanille Milchshake getrunken'})
end)


---- Erdbeer Shake
ESX.RegisterUsableItem('milk_shake_erdbeer', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	local _source = source

	xPlayer.removeInventoryItem('milk_shake_erdbeer', 1)

	TriggerClientEvent('esx_status:add', source, 'thirst', 100000)
	TriggerClientEvent('esx_basicneeds:onDrink', source)
	TriggerClientEvent('pNotify:SendNotification', _source, {layout = 'topLeft', theme = 'gta', type = 'warning', text1 = 'Lebensmittel', text2 = 'Du hast einen Erdbeer Milchshake getrunken'})
end)


---- Schoko Shake
ESX.RegisterUsableItem('milk_shake_schoko', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	local _source = source

	xPlayer.removeInventoryItem('milk_shake_schoko', 1)

	TriggerClientEvent('esx_status:add', source, 'thirst', 100000)
	TriggerClientEvent('esx_basicneeds:onDrink', source)
	TriggerClientEvent('pNotify:SendNotification', _source, {layout = 'topLeft', theme = 'gta', type = 'warning', text1 = 'Lebensmittel', text2 = 'Du hast einen Schoko Milchshake getrunken'})
end)


---- Hot Kakao
ESX.RegisterUsableItem('hot_kako', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	local _source = source

	xPlayer.removeInventoryItem('hot_kako', 1)

	TriggerClientEvent('esx_status:add', source, 'thirst', 100000)
	TriggerClientEvent('esx_basicneeds:onDrink', source)
	TriggerClientEvent('pNotify:SendNotification', _source, {layout = 'topLeft', theme = 'gta', type = 'warning', text1 = 'Lebensmittel', text2 = 'Du hast eine Heiße Schokolade getrunken'})
end)


---- Espresso
ESX.RegisterUsableItem('espresso', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	local _source = source

	xPlayer.removeInventoryItem('espresso', 1)

	TriggerClientEvent('esx_status:add', source, 'thirst', 80000)
	TriggerClientEvent('esx_basicneeds:onDrink', source)
	TriggerClientEvent('pNotify:SendNotification', _source, {layout = 'topLeft', theme = 'gta', type = 'warning', text1 = 'Lebensmittel', text2 = 'Du hast einen Espresso getrunken'})
end)


--------------------------------------- Trinken mit models ---------------------------------

-- Cola

ESX.RegisterUsableItem('cola', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	local _source = source

	xPlayer.removeInventoryItem('cola', 1)

	TriggerClientEvent('esx_status:add', source, 'thirst', 200000)
	TriggerClientEvent('esx_basicneeds:onCola', source)
	TriggerClientEvent('pNotify:SendNotification', _source, {layout = 'topLeft', theme = 'gta', type = 'warning', text1 = 'Lebensmittel', text2 = 'Du hast eine Cola getrunken'})
end)


-- Sprite

ESX.RegisterUsableItem('sprite', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	local _source = source

	xPlayer.removeInventoryItem('sprite', 1)

	TriggerClientEvent('esx_status:add', source, 'thirst', 180000)
	TriggerClientEvent('esx_basicneeds:onSprite', source)
	TriggerClientEvent('pNotify:SendNotification', _source, {layout = 'topLeft', theme = 'gta', type = 'warning', text1 = 'Lebensmittel', text2 = 'Du hast eine Sprite getrunken'})
end)


-- Kaffee

ESX.RegisterUsableItem('kaffee', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	local _source = source

	xPlayer.removeInventoryItem('kaffee', 1)

	TriggerClientEvent('esx_status:add', source, 'thirst', 100000)
	TriggerClientEvent('esx_basicneeds:onCoffe', source)
	TriggerClientEvent('pNotify:SendNotification', _source, {layout = 'topLeft', theme = 'gta', type = 'warning', text1 = 'Lebensmittel', text2 = 'Du hast einen Kaffee getrunken'})
end)


-- Wein

ESX.RegisterUsableItem('wein', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	local _source = source

	xPlayer.removeInventoryItem('wein', 1)

	TriggerClientEvent('esx_status:add', source, 'thirst', 30000)
	TriggerClientEvent('esx_basicneeds:onWein', source)
	TriggerClientEvent('pNotify:SendNotification', _source, {layout = 'topLeft', theme = 'gta', type = 'warning', text1 = 'Lebensmittel', text2 = 'Du hast einen Wein getrunken'})
end)


-- Sandwich

ESX.RegisterUsableItem('sandwich', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	local _source = source

	xPlayer.removeInventoryItem('sandwich', 1)

	TriggerClientEvent('esx_status:add', source, 'hunger', 200000)
	TriggerClientEvent('esx_basicneeds:onSandwich', source)
	TriggerClientEvent('pNotify:SendNotification', _source, {layout = 'topLeft', theme = 'gta', type = 'warning', text1 = 'Lebensmittel', text2 = 'Du hast ein Sandwich gegessen'})
end)


-- Chips

ESX.RegisterUsableItem('chips', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	local _source = source

	xPlayer.removeInventoryItem('chips', 1)

	TriggerClientEvent('esx_status:add', source, 'hunger', 100000)
	TriggerClientEvent('esx_basicneeds:onChips', source)
	TriggerClientEvent('pNotify:SendNotification', _source, {layout = 'topLeft', theme = 'gta', type = 'warning', text1 = 'Lebensmittel', text2 = 'Du hast Chips gegessen'})
end)


-- Pillen etc.

ESX.RegisterUsableItem('hustensaft', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	local _source = source

	xPlayer.removeInventoryItem('hustensaft', 1)

	TriggerClientEvent('esx_basicneeds:onMedic', source)
	TriggerClientEvent('pNotify:SendNotification', _source, {layout = 'topLeft', theme = 'gta', type = 'warning', text1 = 'Lebensmittel', text2 = 'Hustensaft getrunken'})
end)

-- Weihnachtsmarkt --

ESX.RegisterUsableItem('gluehwein', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	local _source = source

	xPlayer.removeInventoryItem('gluehwein', 1)

	TriggerClientEvent('esx_status:add', source, 'thirst', 250000)
	TriggerClientEvent('esx_basicneeds:onCoffee', source)
	TriggerClientEvent('pNotify:SendNotification', _source, {layout = 'topLeft', theme = 'gta', type = 'warning', text1 = 'Lebensmittel', text2 = 'Du hast einen Glühwein getrunken'})
end)

ESX.RegisterUsableItem('heisse_schokolade', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	local _source = source

	xPlayer.removeInventoryItem('heisse_schokolade', 1)

	TriggerClientEvent('esx_status:add', source, 'thirst', 250000)
	TriggerClientEvent('esx_basicneeds:onCoffee', source)
	TriggerClientEvent('pNotify:SendNotification', _source, {layout = 'topLeft', theme = 'gta', type = 'warning', text1 = 'Lebensmittel', text2 = 'Du hast eine Heiße Schokolade getrunken'})
end)

ESX.RegisterUsableItem('gebrannte_mandeln', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	local _source = source

	xPlayer.removeInventoryItem('gebrannte_mandeln', 1)

	TriggerClientEvent('esx_status:add', source, 'hunger', 400000)
	TriggerClientEvent('esx_basicneeds:onSandwich', source)
	TriggerClientEvent('pNotify:SendNotification', _source, {layout = 'topLeft', theme = 'gta', type = 'warning', text1 = 'Lebensmittel', text2 = 'Du hast Gebrannte Mandeln gegessen'})
end)

ESX.RegisterUsableItem('gebrannte_mandeln_redbull_geschmack', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	local _source = source

	xPlayer.removeInventoryItem('gebrannte_mandeln_redbull_geschmack', 1)

	TriggerClientEvent('esx_status:add', source, 'hunger', 400000)
	TriggerClientEvent('esx_basicneeds:onSandwich', source)
	TriggerClientEvent('pNotify:SendNotification', _source, {layout = 'topLeft', theme = 'gta', type = 'warning', text1 = 'Lebensmittel', text2 = 'Du hast Gebrannte Mandeln mit Redbull geschmack gegessen'})
end)

ESX.RegisterUsableItem('crepe_mit_nutella', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	local _source = source

	xPlayer.removeInventoryItem('crepe_mit_nutella', 1)

	TriggerClientEvent('esx_status:add', source, 'hunger', 400000)
	TriggerClientEvent('esx_basicneeds:onSandwich', source)
	TriggerClientEvent('pNotify:SendNotification', _source, {layout = 'topLeft', theme = 'gta', type = 'warning', text1 = 'Lebensmittel', text2 = 'Du hast einen Crepe mit Nutella gegessen'})
end)

ESX.RegisterUsableItem('schokoladen_erdbeere', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	local _source = source

	xPlayer.removeInventoryItem('schokoladen_erdbeere', 1)

	TriggerClientEvent('esx_status:add', source, 'hunger', 400000)
	TriggerClientEvent('esx_basicneeds:onSandwich', source)
	TriggerClientEvent('pNotify:SendNotification', _source, {layout = 'topLeft', theme = 'gta', type = 'warning', text1 = 'Lebensmittel', text2 = 'Du hast eine Schokoladen Erdbeere gegessen'})
end)

ESX.RegisterUsableItem('schokoladen_apfel', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	local _source = source

	xPlayer.removeInventoryItem('schokoladen_apfel', 1)

	TriggerClientEvent('esx_status:add', source, 'hunger', 400000)
	TriggerClientEvent('esx_basicneeds:onSandwich', source)
	TriggerClientEvent('pNotify:SendNotification', _source, {layout = 'topLeft', theme = 'gta', type = 'warning', text1 = 'Lebensmittel', text2 = 'Du hast einen Schokoladen Apfel gegessen'})
end)

ESX.RegisterUsableItem('gebratene_nudeln', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	local _source = source

	xPlayer.removeInventoryItem('gebratene_nudeln', 1)

	TriggerClientEvent('esx_status:add', source, 'hunger', 400000)
	TriggerClientEvent('esx_basicneeds:onSandwich', source)
	TriggerClientEvent('pNotify:SendNotification', _source, {layout = 'topLeft', theme = 'gta', type = 'warning', text1 = 'Lebensmittel', text2 = 'Du hast Gebratene Nudeln gegessen'})
end)

ESX.RegisterUsableItem('nudeln_mit_garnelen', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	local _source = source

	xPlayer.removeInventoryItem('nudeln_mit_garnelen', 1)

	TriggerClientEvent('esx_status:add', source, 'hunger', 400000)
	TriggerClientEvent('esx_basicneeds:onSandwich', source)
	TriggerClientEvent('pNotify:SendNotification', _source, {layout = 'topLeft', theme = 'gta', type = 'warning', text1 = 'Lebensmittel', text2 = 'Du hast Nudeln mit Garnelen gegessen'})
end)

ESX.RegisterUsableItem('haehnchen_suess_sauer', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	local _source = source

	xPlayer.removeInventoryItem('haehnchen_suess_sauer', 1)

	TriggerClientEvent('esx_status:add', source, 'hunger', 400000)
	TriggerClientEvent('esx_basicneeds:onSandwich', source)
	TriggerClientEvent('pNotify:SendNotification', _source, {layout = 'topLeft', theme = 'gta', type = 'warning', text1 = 'Lebensmittel', text2 = 'Du hast Hähnchen Süß-Sauer gegessen'})
end)

ESX.RegisterUsableItem('wan_tan_suppe', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	local _source = source

	xPlayer.removeInventoryItem('wan_tan_suppe', 1)

	TriggerClientEvent('esx_status:add', source, 'hunger', 400000)
	TriggerClientEvent('esx_basicneeds:onSandwich', source)
	TriggerClientEvent('pNotify:SendNotification', _source, {layout = 'topLeft', theme = 'gta', type = 'warning', text1 = 'Lebensmittel', text2 = 'Du hast eine Wan-Tan Suppe gegessen'})
end)

ESX.RegisterUsableItem('tofu', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	local _source = source

	xPlayer.removeInventoryItem('tofu', 1)

	TriggerClientEvent('esx_status:add', source, 'hunger', 400000)
	TriggerClientEvent('esx_basicneeds:onSandwich', source)
	TriggerClientEvent('pNotify:SendNotification', _source, {layout = 'topLeft', theme = 'gta', type = 'warning', text1 = 'Lebensmittel', text2 = 'Du hast Tofu gegessen'})
end)

ESX.RegisterUsableItem('salat', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	local _source = source

	xPlayer.removeInventoryItem('salat', 1)

	TriggerClientEvent('esx_status:add', source, 'hunger', 400000)
	TriggerClientEvent('esx_basicneeds:onSandwich', source)
	TriggerClientEvent('pNotify:SendNotification', _source, {layout = 'topLeft', theme = 'gta', type = 'warning', text1 = 'Lebensmittel', text2 = 'Du hast Salat gegessen'})
end)

ESX.RegisterUsableItem('sushi', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	local _source = source

	xPlayer.removeInventoryItem('sushi', 1)

	TriggerClientEvent('esx_status:add', source, 'hunger', 400000)
	TriggerClientEvent('esx_basicneeds:onSandwich', source)
	TriggerClientEvent('pNotify:SendNotification', _source, {layout = 'topLeft', theme = 'gta', type = 'warning', text1 = 'Lebensmittel', text2 = 'Du hast Sushi gegessen'})
end)

ESX.RegisterUsableItem('nuesse', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	local _source = source

	xPlayer.removeInventoryItem('nuesse', 1)

	TriggerClientEvent('esx_status:add', source, 'hunger', 400000)
	TriggerClientEvent('esx_basicneeds:onSandwich', source)
	TriggerClientEvent('pNotify:SendNotification', _source, {layout = 'topLeft', theme = 'gta', type = 'warning', text1 = 'Lebensmittel', text2 = 'Du hast Nüsse gegessen'})
end)

ESX.RegisterUsableItem('pistazien', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	local _source = source

	xPlayer.removeInventoryItem('pistazien', 1)

	TriggerClientEvent('esx_status:add', source, 'hunger', 400000)
	TriggerClientEvent('esx_basicneeds:onSandwich', source)
	TriggerClientEvent('pNotify:SendNotification', _source, {layout = 'topLeft', theme = 'gta', type = 'warning', text1 = 'Lebensmittel', text2 = 'Du hast Pistazien gegessen'})
end)

ESX.RegisterUsableItem('krabbenchips', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	local _source = source

	xPlayer.removeInventoryItem('krabbenchips', 1)

	TriggerClientEvent('esx_status:add', source, 'hunger', 400000)
	TriggerClientEvent('esx_basicneeds:onSandwich', source)
	TriggerClientEvent('pNotify:SendNotification', _source, {layout = 'topLeft', theme = 'gta', type = 'warning', text1 = 'Lebensmittel', text2 = 'Du hast Krabbenchips gegessen'})
end)

ESX.RegisterUsableItem('wasser', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	local _source = source

	xPlayer.removeInventoryItem('wasser', 1)

	TriggerClientEvent('esx_status:add', source, 'thirst', 250000)
	TriggerClientEvent('esx_basicneeds:onCoffee', source)
	TriggerClientEvent('pNotify:SendNotification', _source, {layout = 'topLeft', theme = 'gta', type = 'warning', text1 = 'Lebensmittel', text2 = 'Du hast ein Wasser getrunken'})
end)

ESX.RegisterUsableItem('wodka', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	local _source = source

	xPlayer.removeInventoryItem('wodka', 1)
	
	TriggerClientEvent('esx_status:add', _source, 'drug', 166000)
	TriggerClientEvent('esx_status:add', source, 'thirst', 250000)
	TriggerClientEvent('esx_drugeffects:onAlc', source)
	TriggerClientEvent('pNotify:SendNotification', _source, {layout = 'topLeft', theme = 'gta', type = 'warning', text1 = 'Lebensmittel', text2 = 'Du hast ein Wodka getrunken'})
end)

ESX.RegisterUsableItem('whisky', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	local _source = source

	xPlayer.removeInventoryItem('whisky', 1)

	TriggerClientEvent('esx_status:add', _source, 'drug', 166000)
	TriggerClientEvent('esx_status:add', source, 'thirst', 250000)
	TriggerClientEvent('esx_drugeffects:onAlc', source)
	TriggerClientEvent('pNotify:SendNotification', _source, {layout = 'topLeft', theme = 'gta', type = 'warning', text1 = 'Lebensmittel', text2 = 'Du hast ein Whisky getrunken'})
end)

ESX.RegisterUsableItem('cocktail', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	local _source = source

	xPlayer.removeInventoryItem('cocktail', 1)

	TriggerClientEvent('esx_status:add', _source, 'drug', 166000)
	TriggerClientEvent('esx_status:add', source, 'thirst', 250000)
	TriggerClientEvent('esx_drugeffects:onAlc', source)
	TriggerClientEvent('pNotify:SendNotification', _source, {layout = 'topLeft', theme = 'gta', type = 'warning', text1 = 'Lebensmittel', text2 = 'Du hast ein Cocktail getrunken'})
end)

ESX.RegisterUsableItem('fen_schnaps', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	local _source = source

	xPlayer.removeInventoryItem('fen_schnaps', 1)

	TriggerClientEvent('esx_status:add', _source, 'drug', 166000)
	TriggerClientEvent('esx_status:add', source, 'thirst', 250000)
	TriggerClientEvent('esx_drugeffects:onAlc', source)
	TriggerClientEvent('pNotify:SendNotification', _source, {layout = 'topLeft', theme = 'gta', type = 'warning', text1 = 'Lebensmittel', text2 = 'Du hast ein Fen Schnaps getrunken'})
end)

ESX.RegisterUsableItem('dong_schnaps', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	local _source = source

	xPlayer.removeInventoryItem('dong_schnaps', 1)

	TriggerClientEvent('esx_status:add', _source, 'drug', 166000)
	TriggerClientEvent('esx_status:add', source, 'thirst', 250000)
	TriggerClientEvent('esx_drugeffects:onAlc', source)
	TriggerClientEvent('pNotify:SendNotification', _source, {layout = 'topLeft', theme = 'gta', type = 'warning', text1 = 'Lebensmittel', text2 = 'Du hast ein Dong Schnaps getrunken'})
end)

ESX.RegisterUsableItem('moatai_schnaps', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	local _source = source

	xPlayer.removeInventoryItem('moatai_schnaps', 1)

	TriggerClientEvent('esx_status:add', _source, 'drug', 166000)
	TriggerClientEvent('esx_status:add', source, 'thirst', 250000)
	TriggerClientEvent('esx_drugeffects:onAlc', source)
	TriggerClientEvent('pNotify:SendNotification', _source, {layout = 'topLeft', theme = 'gta', type = 'warning', text1 = 'Lebensmittel', text2 = 'Du hast ein Moatai Schnaps getrunken'})
end)

ESX.RegisterUsableItem('lycheewein', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	local _source = source

	xPlayer.removeInventoryItem('lycheewein', 1)

	TriggerClientEvent('esx_status:add', _source, 'drug', 166000)
	TriggerClientEvent('esx_status:add', source, 'thirst', 250000)
	TriggerClientEvent('esx_drugeffects:onAlc', source)
	TriggerClientEvent('pNotify:SendNotification', _source, {layout = 'topLeft', theme = 'gta', type = 'warning', text1 = 'Lebensmittel', text2 = 'Du hast ein Lycheewein getrunken'})
end)

ESX.RegisterUsableItem('glueckskekse', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	local _source = source
	local zahl = math.random(1,18)

	xPlayer.removeInventoryItem('glueckskekse', 1)

	TriggerClientEvent('esx_status:add', source, 'hunger', 400000)
	TriggerClientEvent('esx_basicneeds:onSandwich', source)
	TriggerClientEvent("pNotify:SendNotification", _source, {layout = 'topLeft', theme = 'gta', type = 'warning', text1 = 'Lebensmittel', text2 = 'Du hast einen Glückskeks gegessen'})

	if zahl == 1 then
		TriggerClientEvent("pNotify:SendNotification", _source, {layout = 'topLeft', timeout = 10000, theme = 'gta', type = 'warning', text1 = 'Glückskeks', text2 = 'Ein großer Mensch ist, wer sein Kinderherz nicht verliert.'})
	end
	if zahl == 2 then
		TriggerClientEvent("pNotify:SendNotification", _source, {layout = 'topLeft', timeout = 10000, theme = 'gta', type = 'warning', text1 = 'Glückskeks', text2 = 'Es ist besser, ein einziges kleines Licht anzuzünden, als die Dunkelheit zu verfluchen.'})
	end
	if zahl == 3 then
		TriggerClientEvent("pNotify:SendNotification", _source, {layout = 'topLeft', timeout = 10000, theme = 'gta', type = 'warning', text1 = 'Glückskeks', text2 = 'Handele an andere Menschen so, wie Du selbst gerne behandelt werden möchtest.'})
	end
	if zahl == 4 then
		TriggerClientEvent("pNotify:SendNotification", _source, {layout = 'topLeft', timeout = 10000, theme = 'gta', type = 'warning', text1 = 'Glückskeks', text2 = 'Wenn jemand sagt er habe keine Zeit, bedeutet das nur, dass ihm andere Dinge wichtiger sind.'})
	end
	if zahl == 5 then
		TriggerClientEvent("pNotify:SendNotification", _source, {layout = 'topLeft', timeout = 10000, theme = 'gta', type = 'warning', text1 = 'Glückskeks', text2 = 'Die Wissenden reden nicht viel, die Redenden wissen nicht viel.'})
	end
	if zahl == 6 then
		TriggerClientEvent("pNotify:SendNotification", _source, {layout = 'topLeft', timeout = 10000, theme = 'gta', type = 'warning', text1 = 'Glückskeks', text2 = 'Ich höre und vergesse. Ich sehe und erinnere. Ich tue und verstehe.'})
	end
	if zahl == 7 then
		TriggerClientEvent("pNotify:SendNotification", _source, {layout = 'topLeft', timeout = 10000, theme = 'gta', type = 'warning', text1 = 'Glückskeks', text2 = 'Trunkenheit erzeugt keine Fehler, sie deckt sie auf.'})
	end
	if zahl == 8 then
		TriggerClientEvent("pNotify:SendNotification", _source, {layout = 'topLeft', timeout = 10000, theme = 'gta', type = 'warning', text1 = 'Glückskeks', text2 = 'Jede Minute, die man lacht verlängert das Leben um eine Stunde.'})
	end
	if zahl == 9 then
		TriggerClientEvent("pNotify:SendNotification", _source, {layout = 'topLeft', timeout = 10000, theme = 'gta', type = 'warning', text1 = 'Glückskeks', text2 = 'Ein einfacher Zweig ist dem Vogel lieber, als ein goldener Käfig.'})
	end
	if zahl == 10 then
		TriggerClientEvent("pNotify:SendNotification", _source, {layout = 'topLeft', timeout = 10000, theme = 'gta', type = 'warning', text1 = 'Glückskeks', text2 = 'Es führen viele Wege zum Gipfel eines Berges, doch die Aussicht bleibt die gleiche.'})
	end
	if zahl == 11 then
		TriggerClientEvent("pNotify:SendNotification", _source, {layout = 'topLeft', timeout = 10000, theme = 'gta', type = 'warning', text1 = 'Glückskeks', text2 = 'Auch eine Reise von 1000 Meilen fängt mit dem ersten Schritt an.'})
	end
	if zahl == 12 then
		TriggerClientEvent("pNotify:SendNotification", _source, {layout = 'topLeft', timeout = 10000, theme = 'gta', type = 'warning', text1 = 'Glückskeks', text2 = 'Achte auf Deine Gedanken, sie sind der Anfang Deiner Taten.'})
	end
	if zahl == 13 then
		TriggerClientEvent("pNotify:SendNotification", _source, {layout = 'topLeft', timeout = 10000, theme = 'gta', type = 'warning', text1 = 'Glückskeks', text2 = 'Was Du Deinen Eltern schuldig bist, weißt Du erst, wenn Du ein Kind hast.'})
	end
	if zahl == 14 then
		TriggerClientEvent("pNotify:SendNotification", _source, {layout = 'topLeft', timeout = 10000, theme = 'gta', type = 'warning', text1 = 'Glückskeks', text2 = 'Das Glück tritt gern in ein Haus, wo gute Laune herrscht.'})
	end
	if zahl == 15 then
		TriggerClientEvent("pNotify:SendNotification", _source, {layout = 'topLeft', timeout = 10000, theme = 'gta', type = 'warning', text1 = 'Glückskeks', text2 = 'Verzeihen ist keine Narrheit, nur der Narr kann nicht verzeihen.'})
	end
	if zahl == 16 then
		TriggerClientEvent("pNotify:SendNotification", _source, {layout = 'topLeft', timeout = 10000, theme = 'gta', type = 'warning', text1 = 'Glückskeks', text2 = 'Einmal selbst sehen ist mehr wert als hundert Neuigkeiten hören.'})
	end
	if zahl == 17 then
		TriggerClientEvent("pNotify:SendNotification", _source, {layout = 'topLeft', timeout = 10000, theme = 'gta', type = 'warning', text1 = 'Glückskeks', text2 = 'Was uns den Weg verlegt, bringt uns voran.'})
	end	
	if zahl == 18 then
		TriggerClientEvent("pNotify:SendNotification", _source, {layout = 'topLeft', timeout = 10000, theme = 'gta', type = 'warning', text1 = 'Glückskeks', text2 = 'Wahre Worte sind nicht angenehm, angenehme Worte sind nicht wahr.'})
	end
end)




-- Heals

TriggerEvent('es:addGroupCommand', 'heal', 'admin', function(source, args, user)
	-- heal another player - don't heal source
	if args[1] then
		local playerId = tonumber(args[1])

		-- is the argument a number?
		if playerId then
			-- is the number a valid player?
			if GetPlayerName(playerId) then
				print(('esx_basicneeds: %s healed %s'):format(GetPlayerIdentifier(source, 0), GetPlayerIdentifier(playerId, 0)))
				TriggerClientEvent('esx_basicneeds:healPlayer', playerId)
				TriggerClientEvent('chat:addMessage', source, { args = { '^5HEAL', 'You have been healed.' } })
			else
				TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM', 'Player not online.' } })
			end
		else
			TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM', 'Invalid player id.' } })
		end
	else
		print(('esx_basicneeds: %s healed self'):format(GetPlayerIdentifier(source, 0)))
		TriggerClientEvent('esx_basicneeds:healPlayer', source)
	end
end, function(source, args, user)
	TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM', 'Insufficient Permissions.' } })
end, {help = 'Heal a player, or yourself - restores thirst, hunger and health.', params = {{name = 'playerId', help = '(optional) player id'}}})