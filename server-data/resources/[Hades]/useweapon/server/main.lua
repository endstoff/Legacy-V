ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterUsableItem('pistolcaselight', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('pistolcaselight', 1)
	local weaponName = 'WEAPON_SNSPISTOL_MK2'
	if ESX.GetWeapon(weaponName) then
		weaponName = string.upper(weaponName)
	end

	if xPlayer.hasWeapon(weaponName) then
		TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM', 'Player already has that weapon.' } })
	else
		xPlayer.addWeapon(weaponName, 1)
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
		xPlayer.addWeapon(weaponName, 1)
	end

end)

ESX.RegisterUsableItem('smgcaseassault', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('smgcaseassault', 1)
	local weaponName = 'WEAPON_ASSAULTSMG'
	if ESX.GetWeapon(weaponName) then
		weaponName = string.upper(weaponName)
	end

	if xPlayer.hasWeapon(weaponName) then
		TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM', 'Player already has that weapon.' } })
	else
		xPlayer.addWeapon(weaponName, 1)
	end

end)