ESX = nil

TriggerEvent('esx:getSharedObject', function(obj)
	ESX = obj
end)

ESX.RegisterServerCallback('ps_banking:getCurrentCash', function(source, cb)
	local s = source
	local x = ESX.GetPlayerFromId(s)

	cb(x.getMoney())
end)

ESX.RegisterServerCallback('ps_banking:getAccounts', function(source, cb)
	local s = source
	local x = ESX.GetPlayerFromId(s)

	local accounts = MySQL.Sync.fetchAll('SELECT * FROM bank_konten WHERE owner = @owner', {['@owner'] = x.identifier})

	cb(accounts)
end)

ESX.RegisterServerCallback('ps_banking:getCash', function(source, cb)
	local s = source
	local x = ESX.GetPlayerFromId(s)
	cb(x.getMoney())
end)

RegisterNetEvent('ps_banking:createNewBanking')
AddEventHandler('ps_banking:createNewBanking', function(p)
	local s = source
	local p = ESX.GetPlayerFromId(s)
	local x = ESX.GetPlayerFromId(p)

	x.showNotification('Ihr Konto wird eingerichtet...')
	x.removeMoney(5000);

	local kontonummer = generateKontoNummer()
	local label = 'Konto ' .. generateNumber(4)
	
	MySQL.Sync.execute("UPDATE bank_konten SET defaultk = 0 WHERE owner = @identifier", {['@identifier'] = x.identifier})
	MySQL.Sync.execute("INSERT INTO bank_konten (bank_nummer, owner, money, label, defaultk) VALUES (@bank, @owner, @money, @label, 1)", 
		{
			['@bank'] = kontonummer, 
			['@owner'] = x.identifier,
			['@money'] = 0,
			['@label'] = label
		}
	)

	Wait(1000)

	x.showNotification('Ihr Konto wurde eingerichtet')
	Wait(250)
	x.showNotification('Ihre Karte wird kodiert...')
	Wait(3500)
	x.showNotification('Ihre Karte wurde kodiert')
	x.showNotification('Sie können Ihr Konto nun voll nutzen!')

	p.showNotification('Konto wurde generiert.')
end)

RegisterNetEvent('ps_banking:changeLabel')
AddEventHandler('ps_banking:changeLabel', function(konto, label)
	MySQL.Sync.execute("UPDATE bank_konten SET label = @label WHERE bank_nummer = @konto", 
		{
			['@konto'] = konto, 
			['@label'] = label
		}
	)
end)

RegisterNetEvent('ps_banking:setDefault')
AddEventHandler('ps_banking:setDefault', function(bank)
	local s = source
	local x = ESX.GetPlayerFromId(s)

	MySQL.Sync.execute("UPDATE bank_konten SET defaultk = 0 WHERE owner = @identifier", {['@identifier'] = x.identifier})
	MySQL.Sync.execute("UPDATE bank_konten SET defaultk = 1 WHERE owner = @identifier AND bank_nummer = @bank", {['@identifier'] = x.identifier, ['@bank'] = bank})

	local money = MySQL.Sync.fetchScalar("SELECT money FROM bank_konten WHERE owner = @identifier AND bank_nummer = @bank",{['@identifier'] = x.identifier, ['@bank'] = bank})
	MySQL.Sync.execute("UPDATE users SET bank = @money WHERE identifier = @identifier", {['@identifier'] = x.identifier, ['@money'] = money})
end)

function generateNumber(length)
	local number = ""

	for i = 1, length, 1 do
		local back = math.random(0, 9)
		number = number .. tostring(back)

		Wait(0)
	end

	return tonumber(number)
end

function generateKontoNummer()
	local numFree = false
	local number

	while not numFree do
		number = 'LS-' .. generateNumber(12)
		local owner = MySQL.Sync.fetchScalar("SELECT owner FROM bank_konten WHERE bank_nummer = @nummer", {['@nummer'] = number})

		if owner == nil then
			numFree = true
		end

		Wait(0)
	end

	return(number)
end

RegisterNetEvent('ps_banking:CashToBank')
AddEventHandler('ps_banking:CashToBank', function(money, bank)
	local s = source
	local x = ESX.GetPlayerFromId(s)
	local m = tonumber(money)

	x.removeMoney(m)
	MySQL.Sync.execute("UPDATE bank_konten SET money = money + @money WHERE owner = @identifier AND bank_nummer = @bank", {['@money'] = money, ['@identifier'] = x.identifier, ['@bank'] = bank})
end)

RegisterNetEvent('ps_banking:BankToCash')
AddEventHandler('ps_banking:BankToCash', function(money, bank)
	local s = source
	local x = ESX.GetPlayerFromId(s)
	local m = tonumber(money)

	MySQL.Sync.execute("UPDATE bank_konten SET money = money - @money WHERE owner = @identifier AND bank_nummer = @bank", {['@money'] = money, ['@identifier'] = x.identifier, ['@bank'] = bank})
	x.addMoney(m)
end)

RegisterNetEvent('ps_banking:updateBank')
AddEventHandler('ps_banking:updateBank', function()
	local s = source
	local x = ESX.GetPlayerFromId(s)

	if x ~= nil then
		local money = MySQL.Sync.fetchScalar("SELECT bank FROM users WHERE identifier = @identifier",{['@identifier'] = x.identifier})
		MySQL.Sync.execute("UPDATE bank_konten SET money = @money WHERE owner = @identifier AND defaultk = 1", {['@money'] = money, ['@identifier'] = x.identifier})
	end	
end)

RegisterNetEvent('ps_banking:TransferBank')
AddEventHandler('ps_banking:TransferBank', function(selfa, target, money)
	local s = source
	local x = ESX.GetPlayerFromId(s)
	
	local ownK = MySQL.Sync.fetchAll('SELECT * FROM bank_konten WHERE bank_nummer = @self', {['@self'] = selfa})
	local tarK = MySQL.Sync.fetchAll('SELECT * FROM bank_konten WHERE bank_nummer = @target', {['@target'] = target})

	local t = ESX.GetPlayerFromIdentifier(tarK[1].owner)

	if tarK[1].owner ~= nil then
		if t ~= nil then
			x.removeAccountMoney('bank', money)
			t.addAccountMoney('bank', money)
			MySQL.Sync.execute("UPDATE bank_konten SET money = money - @money WHERE bank_nummer = @bank", {['@money'] = money, ['@bank'] = selfa})
			MySQL.Sync.execute("UPDATE bank_konten SET money = money + @money WHERE bank_nummer = @bank", {['@money'] = money, ['@bank'] = target})
		else
			x.removeAccountMoney('bank', money)
			MySQL.Sync.execute("UPDATE bank_konten SET money = money - @money WHERE bank_nummer = @bank", {['@money'] = money, ['@bank'] = selfa})
			MySQL.Sync.execute("UPDATE bank_konten SET money = money + @money WHERE bank_nummer = @bank", {['@money'] = money, ['@bank'] = target})
		end
	else
		x.showNotification('Das gewählte Konto wurde nicht gefunden')
	end
end)