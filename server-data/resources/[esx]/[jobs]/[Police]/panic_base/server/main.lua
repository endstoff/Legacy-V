ESX = nil 
local at = 'panic'
local stage = 'Beta'
local v = '1.0.0'


TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

print('^0[^1panic_base^0]^3 Erfolgreich ^2geladen')
print('^0[^1panic_base^0]^4 Autor: ^1'..at..' |^4 Version: ^1'..v..' |^4 Stage: ^1'..stage)