ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterUsableItem('pistolcaselight', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('pistolcaselight', 1)
	local weaponName = 'WEAPON_COMBATPISTOL'
	if ESX.GetWeapon(weaponName) then
		weaponName = string.upper(weaponName)
	end

	if xPlayer.hasWeapon(weaponName) then
		TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM', 'Player already has that weapon.' } })
	else
		xPlayer.addWeapon(weaponName, 250)
	end

end)

ESX.RegisterUsableItem('pistolcaseheavy', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('pistolcaseheavy', 1)
	local weaponName = 'WEAPON_HEAVYPISTOL'
	if ESX.GetWeapon(weaponName) then
		weaponName = string.upper(weaponName)
	end

	if xPlayer.hasWeapon(weaponName) then
		TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM', 'Player already has that weapon.' } })
	else
		xPlayer.addWeapon(weaponName, 250)
	end

end)

ESX.RegisterUsableItem('smgcaseassault', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('smgcaseassault', 1)
	local weaponName = 'WEAPON_COMBATSMG'
	if ESX.GetWeapon(weaponName) then
		weaponName = string.upper(weaponName)
	end

	if xPlayer.hasWeapon(weaponName) then
		TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM', 'Player already has that weapon.' } })
	else
		xPlayer.addWeapon(weaponName, 250)
	end

end)

ESX.RegisterUsableItem('smgcaselight', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('smgcaselight', 1)
	local weaponName = 'WEAPON_MACHINEPISTOL'
	if ESX.GetWeapon(weaponName) then
		weaponName = string.upper(weaponName)
	end

	if xPlayer.hasWeapon(weaponName) then
		TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM', 'Player already has that weapon.' } })
	else
		xPlayer.addWeapon(weaponName, 250)
	end

end)

ESX.RegisterUsableItem('brassknuckles', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('brassknuckles', 1)
	local weaponName = 'WEAPON_KNUCKLE'
	if ESX.GetWeapon(weaponName) then
		weaponName = string.upper(weaponName)
	end

	if xPlayer.hasWeapon(weaponName) then
		TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM', 'Player already has that weapon.' } })
	else
		xPlayer.addWeapon(weaponName, 1)
	end

end)