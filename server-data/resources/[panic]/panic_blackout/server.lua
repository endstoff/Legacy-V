ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('panic_blackout:weatherBlackout')
AddEventHandler('panic_blackout:weatherBlackout', function()
    Citizen.Wait(0)
    print('^3[panic_blackout] ^0Generatoren wurden zerstört!')
    Citizen.Wait(600000)
    print('[panic_blackout] Generatoren wurden gefixt!')
end)
