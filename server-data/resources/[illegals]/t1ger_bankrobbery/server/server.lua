-------------------------------------
------- Created by T1GER#9080 -------
------------------------------------- 

ESX = nil
TriggerEvent(Config.ESXSHAREDOBJECT, function(obj) ESX = obj end)

function UpdatePoliceCount()
	local xPlayers = ESX.GetPlayers()
	PoliceOnline = 0
	for i=1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
		for k,v in pairs(Config.PoliceJobs) do
			if xPlayer.job.name == v then
				PoliceOnline = PoliceOnline + 1
			end
		end
	end
	TriggerClientEvent('t1ger_bankrobbery:getPoliceCount', -1, PoliceOnline)
	SetTimeout(30 * 1000, UpdatePoliceCount)
end
UpdatePoliceCount()

-- Remove inventory item:
ESX.RegisterServerCallback('t1ger_bankrobbery:removeInvItem',function(source,cb,item,amount)
	local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer.getInventoryItem(item).count >= amount then xPlayer.removeInventoryItem(item, 1); cb(true) else cb(false) end
end)
-- Get inventory Item:
ESX.RegisterServerCallback('t1ger_bankrobbery:getInvItem',function(source,cb,item,amount)
	local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer.getInventoryItem(item).count >= amount then cb(true) else cb(false) end
end)

-- Event to add item & amount:
RegisterServerEvent('t1ger_bankrobbery:giveItem')
AddEventHandler('t1ger_bankrobbery:giveItem', function(item, amount)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.addInventoryItem(item, amount)
end)

-- SAFES SECTIONS --

RegisterServerEvent('t1ger_bankrobbery:safeReward')
AddEventHandler('t1ger_bankrobbery:safeReward', function()
	local xPlayer = ESX.GetPlayerFromId(source)
	-- Chance to keep drill:
	math.randomseed(GetGameTimer())
	if math.random(0,100) <= Config.ChanceToKeepDrill then 
		xPlayer.addInventoryItem(Config.Drill_Item, 1)
	end
	-- Money:
	local cash = Config.Safe_Cash
	local amount = ((math.random(cash.amount.min, cash.amount.max)) * cash.multiplier)
	if cash.dirty_cash then xPlayer.addAccountMoney('black_money', amount) else xPlayer.addMoney(amount) end
	-- Item Reward:
	for k,v in pairs(Config.Safe_Items) do
		if math.random(0,100) <= v.chance then
			local item_amount = math.random(v.min,v.max)
			local item_label = ''
			if Config.HasItemLabel then item_label = ESX.GetItemLabel(v.item) else item_label = tostring(v.item) end
			xPlayer.addInventoryItem(v.item, item_amount)
			TriggerClientEvent('t1ger_bankrobbery:ShowNotifyESX', xPlayer.source, (Lang['safe_item_reward']:format(item_amount, item_label)))
		end
	end
end)

-- BANKS SECTION --

RegisterServerEvent('t1ger_bankrobbery:ResetBankSV')
AddEventHandler('t1ger_bankrobbery:ResetBankSV', function()
    for i = 1, #Config.Banks do	-- LOOP THROUGH BANKS:
		Config.Banks[i].inUse = false
		Config.Banks[i].keypads[1].hacked = false
		Config.Banks[i].keypads[2].hacked = false
		Config.Banks[i].deskDoor.lockpicked = false
		for k,v in pairs(Config.Banks[i].deskCash) do
			v.robbed = false
		end
		Config.Banks[i].powerBox.disabled = false
		if i == 8 then
			Config.Banks[i].safe.cracked = false
		end
	end
	for i = 1, #Config.Bank_Safes do -- LOOP THROUGH SAFES:
		Config.Bank_Safes[i].robbed = false
		Config.Bank_Safes[i].failed = false
    end
	alertTime = 0
	TriggerClientEvent('t1ger_bankrobbery:ResetBankCL', -1)
	-- Secure News:
	local xPlayers = ESX.GetPlayers()
	for i=1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
		if xPlayer.job.name == 'police' or xPlayer.job.name == 'ambulance' or xPlayer.job.name == 'journalist' then
			TriggerClientEvent('chatMessage', xPlayers[i], "^2News: | ^7", { 128, 128, 128 }, string.sub('The bank has been secured. All banks are now open again!',0))
		end
	end
end) 

-- ## POWER BOX ## --
alertTime = 0
RegisterServerEvent('t1ger_bankrobbery:powerBoxSV')
AddEventHandler('t1ger_bankrobbery:powerBoxSV', function(id, state, timer)
	Config.Banks[id].powerBox.disabled = state
	alertTime = timer
	TriggerClientEvent('t1ger_bankrobbery:powerBoxCL', -1, id, state, timer)
end)

RegisterServerEvent('t1ger_bankrobbery:addRobTimeSV')
AddEventHandler('t1ger_bankrobbery:addRobTimeSV', function(timer)
	alertTime = timer
	TriggerClientEvent('t1ger_bankrobbery:addRobTimeCL', -1, alertTime)
end)

-- ## PETTY CASH ## --
RegisterServerEvent('t1ger_bankrobbery:pettyCashSV')
AddEventHandler('t1ger_bankrobbery:pettyCashSV', function(id, num, state)
    local xPlayer = ESX.GetPlayerFromId(source)
	Config.Banks[id].deskCash[num].robbed = state
	TriggerClientEvent('t1ger_bankrobbery:pettyCashCL', -1, id, num, state)
	-- money reward:
	local amount = math.random(Config.Banks[id].deskCash[num].reward.min,Config.Banks[id].deskCash[num].reward.max)
	if not Config.Banks[id].deskCash[num].reward.dirty then
		xPlayer.addMoney(amount)
	else
		xPlayer.addAccountMoney('black_money', amount)
	end 
	TriggerClientEvent('t1ger_bankrobbery:ShowNotifyESX', xPlayer.source, "~g~"..amount.."$~s~ in cash taken from the desk")
end)

-- Event for police alerts
RegisterServerEvent('t1ger_bankrobbery:PoliceNotifySV')
AddEventHandler('t1ger_bankrobbery:PoliceNotifySV', function(targetCoords, streetName, name)
	TriggerClientEvent('t1ger_bankrobbery:PoliceNotifyCL', -1, (Lang['police_notify']):format(name,streetName))
	TriggerClientEvent('t1ger_bankrobbery:PoliceNotifyBlip', -1, targetCoords)
end)

