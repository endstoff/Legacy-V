ESX             = nil 

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)


RegisterNetEvent('useweapon_ammo:ammoClip')
AddEventHandler('useweapon_ammo:ammoClip', function()

    local xPlayer = PlayerPedId()
    local Weapon = GetSelectedPedWeapon(xPlayer)

    if Weapon == GetHashKey('weapon_pistol') or Weapon == GetHashKey('weapon_combatpistol') or Weapon == GetHashKey('weapon_heavypistol') or Weapon == GetHashKey('weapon_machinepistol') or Weapon == GetHashKey('weapon_pistol_mk2') or Weapon == GetHashKey('weapon_combatpdw') or Weapon == GetHashKey('weapon_smg') then
        AddAmmoToPed(xPlayer, Weapon, 30)
        TriggerServerEvent('useweapon_ammo:ammoClip')

        --[[
        exports['t-notify']:Alert({
            style  =  'info',
            message  =  'You Used a ammo clip',
            duration  = 4000,
            sound = true,
        }) ]]
        TriggerEvent('est_notify', '#45CE00', 'Munitionskiste', 'Du hast eine Munitionskiste verwendet')
        
	end

end)