ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

local lastAdDate 			   = 0

RegisterServerEvent("SyncAdvert")
AddEventHandler('SyncAdvert', function(inputText)
	if os.time(os.date("!*t")) > (lastAdDate + Config.Cooldown) then
		lastAdDate = os.time(os.date("!*t"))
		local _source = source
		local xPlayer = ESX.GetPlayerFromId(_source)
		TriggerClientEvent('DisplayAdvert', -1, inputText, xPlayer.getName())
				PerformHttpRequest(Config.Webhook, function(e,r,h) end, "POST", json.encode({
					["username"] = "Weazel News",
					["avatar_url"] = "https://i.imgur.com/kbwaL85.jpg",
					["content"] = "```diff\n+ [Weazel News] " .. xPlayer.name .. " hat werbung geschaltet: " .. inputText .."```"
				}), {["Content-Type"] = "application/json"})
		local xPlayer = ESX.GetPlayerFromId(source)
		if xPlayer.getMoney() >= Config.AdvertCosts then
			xPlayer.removeMoney(Config.AdvertCosts)
			xPlayer.showNotification('$~g~' .. Config.AdvertCosts .. _U('AdvertPayed'))
		else
			local missingMoney = price - xPlayer.getMoney()
			xPlayer.showNotification(_U('not_enough', ESX.Math.GroupDigits(missingMoney)))
		end
	else
		TriggerClientEvent('AdvertError', source, _U('cooldown'))
	end
end)

print("=======================================================================")
print("Weazel-News erfolgreich ^3gestartet^0 by endstoff")
print("=======================================================================")