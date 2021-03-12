ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
local v = '1.0.3'
local at = 'panic'
local stage = 'Beta'

ESX.RegisterUsableItem('notknopf', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)

	TriggerClientEvent('panic_sos-button:useButton', source)

end)


	print('^0[^3panic_sos-button^0] ^4wurde Erfolgreich geladen.')
	print('^0[^3panic_sos-button^0] ^1Version: ^2'..v..' ^1Phase: ^2'..stage..' ^1Autor: ^2'..at)
