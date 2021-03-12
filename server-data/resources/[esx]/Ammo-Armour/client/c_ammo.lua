ESX          = nil

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent(Config.ESX, function(obj) ESX = obj end)
        Citizen.Wait(500)
    end
end)



RegisterNetEvent('lordtiger_ammo:ammoClip')
AddEventHandler('lordtiger_ammo:ammoClip', function()

    local xPlayer = PlayerPedId()
    local Weapon = GetSelectedPedWeapon(xPlayer)

    if Weapon == GetHashKey('weapon_pumpshotgun') or Weapon == GetHashKey('weapon_sawnoffshotgun') then
        AddAmmoToPed(xPlayer, Weapon, Config.SAmmo)
        TriggerServerEvent('lordtiger_ammo:ammoClip')

        --[[
        exports['t-notify']:Alert({
            style  =  'info',
            message  =  'You Used a ammo clip',
            duration  = 4000,
            sound = true,
        }) ]]
        TriggerEvent('est_notify', '#45CE00', 'Munitionskiste', 'Du hast eine Munitionskiste verwendet')
        
    elseif Weapon == GetHashKey('weapon_combatpistol') or Weapon == GetHashKey('weapon_pistol') or Weapon == GetHashKey('weapon_heavypistol') or Weapon == GetHashKey('weapon_pistol_mk2') then

        AddAmmoToPed(xPlayer, Weapon, Config.PAmmo)
        TriggerServerEvent('lordtiger_ammo:ammoClip')
        
    --[[    exports['t-notify']:Alert({
            style  =  'info',
            message  =  'You Used a ammo clip',
            duration  = 4000,
            sound = true,
        })]]
        TriggerEvent('est_notify', '#45CE00', 'Munitionskiste', 'Du hast eine Munitionskiste verwendet')

    elseif Weapon == GetHashKey('weapon_assaultrifle') or Weapon == GetHashKey('weapon_carbinerifle') or Weapon == GetHashKey('weapon_compactrifle') then

        AddAmmoToPed(xPlayer, Weapon, Config.AAmmo)
        TriggerServerEvent('lordtiger_ammo:ammoClip')

        --[[
        exports['t-notify']:Alert({
            style  =  'info',
            message  =  'You Used a ammo clip',
            duration  = 4000,
            sound = true,
        }) ]]
        TriggerEvent('est_notify', '#45CE00', 'Munitionskiste', 'Du hast eine Munitionskiste verwendet')

    elseif Weapon == GetHashKey('weapon_microsmg') or Weapon == GetHashKey('weapon_gusenberg') then

        AddAmmoToPed(xPlayer, Weapon, Config.MAmmo)
        TriggerServerEvent('lordtiger_ammo:ammoClip')
        
        --[[
        exports['t-notify']:Alert({
            style  =  'info',
            message  =  'You Used a ammo clip',
            duration  = 4000,
            sound = true,
        }) ]]
        TriggerEvent('est_notify', '#45CE00', 'Munitionskiste', 'Du hast eine Munitionskiste verwendet')

    else
    --[[    exports['t-notify']:Alert({
            style  =  'info',
            message  =  'Please pull your gun out to apply the clip ',
            duration  = 4000,
            sound = true,
        })]]
        TriggerEvent('est_notify', '#45CE00', 'Munitionskiste', 'Bitte ziehe deine Waffe heraus um die Munitionskiste zu verwenden')
    end

end)