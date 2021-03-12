ESX               = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterUsableItem('radio', function(source)
  local xPlayer = ESX.GetPlayerFromId(source)
  if xPlayer ~= nil then
    if xPlayer.getInventoryItem('radio').count <= 0 then
		  TriggerClientEvent('saltyradio:onRadioDrop', source)
		else
			TriggerClientEvent('saltyradio:use', source)
		end
  end
end)
