ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('orp:bank:deposit')
AddEventHandler('orp:bank:deposit', function(amount)
    local _source = source
	
	local xPlayer = ESX.GetPlayerFromId(_source)
	if amount == nil or amount <= 0 or amount > xPlayer.getMoney() then
		TriggerClientEvent('est_notify', source, "#B90000", "Bank", "Ungültiger Betrag")
	else
		xPlayer.removeMoney(amount)
		xPlayer.addAccountMoney('bank', tonumber(amount))
		TriggerClientEvent('est_notify', source, "#0BB900", "Bank", 'Du hast <span style="color:green"><b>$' .. amount .. '</b></span> eingezahlt!')
	end
end)

RegisterServerEvent('orp:bank:withdraw')
AddEventHandler('orp:bank:withdraw', function(amount)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local min = 0
	amount = tonumber(amount)
	min = xPlayer.getAccount('bank').money
	if amount == nil or amount <= 0 or amount > min then
		TriggerClientEvent('est_notify', source, "#B90000", "Bank", "Ungültiger Betrag")
	else
		xPlayer.removeAccountMoney('bank', amount)
		xPlayer.addMoney(amount)
		TriggerClientEvent('est_notify', source, "#0BB900", "Bank", 'Du hast <span style="color:green"><b>$' .. amount .. '</b></span> abgehoben!')
	end
end)

RegisterServerEvent('orp:bank:balance')
AddEventHandler('orp:bank:balance', function()
	
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	balance = xPlayer.getAccount('bank').money
	TriggerClientEvent('orp:bank:info', _source, balance)
end)

RegisterServerEvent('orp:bank:transfer')
AddEventHandler('orp:bank:transfer', function(to, amountt)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local xTarget = ESX.GetPlayerFromId(to)
	local amount = amountt
	local balance = 0

	if(xTarget == nil or xTarget == -1) then
		TriggerClientEvent('est_notify', source, '#FF0000', "Bank", "Empfänger nicht gefunden")
	else
		balance = xPlayer.getAccount('bank').money
		zbalance = xTarget.getAccount('bank').money
		
		if tonumber(_source) == tonumber(to) then
			TriggerClientEvent('est_notify', source, '#FF0000', "Bank", "Du kannst kein Geld an dich selbst überweisen")
		else
			if balance <= 0 or balance < tonumber(amount) or tonumber(amount) <= 0 then
				TriggerClientEvent('est_notify', source, '#FF0000', "Bank", "Du hast nicht genug Geld für diese Überweisung")
			else
				xPlayer.removeAccountMoney('bank', tonumber(amount))
				xTarget.addAccountMoney('bank', tonumber(amount))
				TriggerClientEvent('est_notify', source, '#00CC00', "Bank", 'Du hast erfolgreich <span style="color:green"><b>$' .. amount .. '</b></span> überwiesen')
				TriggerClientEvent('est_notify', to, '#CCCC00', "Bank", 'Du hast gerade <span style="color:green"><b>$' .. amount .. '</b></span> überwiesen bekommen')
			end
		end
	end
end)