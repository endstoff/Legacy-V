ESX          = nil

Citizen.CreateThread(function()
  while ESX == nil do
    TriggerEvent(Config.ESX, function(obj) ESX = obj end)
    Citizen.Wait(500)
  end
end)

RegisterNetEvent('lordtiger_armour:t1_armour')
AddEventHandler('lordtiger_armour:t1_armour', function()

  if GetPedArmour(PlayerPedId()) == Config.Tier1 then
  --[[  exports['t-notify']:Alert({
      style  =  'error',
      message  =  'You already have Tier 1 armour on!',
      duration  = 4000,
      sound = true,
  })]]
  TriggerEvent('est_notify', '#FF0000', 'Schutzweste', 'Du hast bereits eine SK 1 Schutzweste an!')
  else
    SetPedArmour(PlayerPedId(), 0)
    ClearPedBloodDamage(PlayerPedId())
    ResetPedVisibleDamage(PlayerPedId())
    ClearPedLastWeaponDamage(PlayerPedId())
    ResetPedMovementClipset(PlayerPedId(), 0)

    TriggerServerEvent('lordtiger_armour:armour_remove1')
    TriggerEvent('skinchanger:getSkin', function(skin)
      local playerPed = PlayerPedId()

      if skin.sex == 0 then
        TriggerEvent('skinchanger:loadClothes', skin, {['bproof_1'] = 10,  ['bproof_2'] = 1})
        SetPedArmour(PlayerPedId(), Config.Tier1)

        RequestAnimDict('missmic4')

        while not HasAnimDictLoaded('missmic4') do
          Wait(100)
        end

        TaskPlayAnim(playerPed, 'missmic4', 'michael_tux_fidget', 8.0, -8, -1, 49, 0, 0, 0, 0)
        exports['progressBars']:startUI(3500, "Schutzweste Anziehen")
        Citizen.Wait(3500)
        ClearPedTasks(playerPed)

      else
        TriggerEvent('skinchanger:loadClothes', skin, {['bproof_1'] = 0,  ['bproof_2'] = 0})
        SetPedArmour(PlayerPedId(),  Config.Tier1)

        RequestAnimDict('missmic4')

        while not HasAnimDictLoaded('missmic4') do
          Wait(100)
        end

        TaskPlayAnim(playerPed, 'missmic4', 'michael_tux_fidget', 8.0, -8, -1, 49, 0, 0, 0, 0)
        exports['progressBars']:startUI(3500, "Schutzweste Anziehen")
        Citizen.Wait(3500)
        ClearPedTasks(playerPed)
      end

    end)
  --[[  exports['t-notify']:Alert({
      style  =  'success',
      message  =  'You putted Tier 1 Armour on',
      duration  = 4000,
      sound = true,
    })]]
    TriggerEvent('est_notify', '#45CE00', 'Schutzweste', 'Du hast eine SK 1 Schutzweste angezogen')
  end

end)

RegisterNetEvent('lordtiger_armour:t2_armour')
AddEventHandler('lordtiger_armour:t2_armour', function()

  if GetPedArmour(PlayerPedId()) == Config.Tier2 then


  --[[  exports['t-notify']:Alert({
      style  =  'error',
      message  =  'You already have Tier 2 armour on!',
      duration  = 4000,
      sound = true,
    })]]
    TriggerEvent('est_notify', '#FF0000', 'Schutzweste', 'Du hast bereits eine SK 2 Schutzweste an!')
  else
    SetPedArmour(PlayerPedId(), 0)
    ClearPedBloodDamage(PlayerPedId())
    ResetPedVisibleDamage(PlayerPedId())
    ClearPedLastWeaponDamage(PlayerPedId())
    ResetPedMovementClipset(PlayerPedId(), 0)

    TriggerServerEvent('lordtiger_armour:armour_remove2')
    TriggerEvent('skinchanger:getSkin', function(skin)
      local playerPed = PlayerPedId()

      if skin.sex == 0 then
        TriggerEvent('skinchanger:loadClothes', skin, {['bproof_1'] = 12,  ['bproof_2'] = 1})
        SetPedArmour(PlayerPedId(), Config.Tier2)

        RequestAnimDict('missmic4')

        while not HasAnimDictLoaded('missmic4') do
          Wait(100)
        end

        TaskPlayAnim(playerPed, 'missmic4', 'michael_tux_fidget', 8.0, -8, -1, 49, 0, 0, 0, 0)
        exports['progressBars']:startUI(7000, "Schutzweste Anziehen")
        Citizen.Wait(7000)
        ClearPedTasks(playerPed)

      else
        TriggerEvent('skinchanger:loadClothes', skin, {['bproof_1'] = 0,  ['bproof_2'] = 0})
        SetPedArmour(PlayerPedId(), Config.Tier2)

        RequestAnimDict('missmic4')

        while not HasAnimDictLoaded('missmic4') do
          Wait(100)
        end

        TaskPlayAnim(playerPed, 'missmic4', 'michael_tux_fidget', 8.0, -8, -1, 49, 0, 0, 0, 0)
        exports['progressBars']:startUI(7000, "Schutzweste Anziehen")
        Citizen.Wait(7000)
        ClearPedTasks(playerPed)
      end

    end)
    --[[
    exports['t-notify']:Alert({
      style  =  'success',
      message  =  'You putted Tier 2 Armour on',
      duration  = 4000,
      sound = true,
    })]]
    TriggerEvent('est_notify', '#45CE00', 'Schutzweste', 'Du hast eine SK 2 Schutzweste angezogen')
  end

end)

RegisterNetEvent('lordtiger_armour:t3_armour')
AddEventHandler('lordtiger_armour:t3_armour', function()

  if GetPedArmour(PlayerPedId()) == Config.Tier3 then
--[[
    exports['t-notify']:Alert({
      style  =  'error',
      duration  = 4000,
      message  =  'You already have Tier 3 armour on!',
      sound = true,
    })]]
    TriggerEvent('est_notify', '#FF0000', 'Schutzweste', 'Du hast bereits eine SK 3 Schutzweste an!')
  else
    SetPedArmour(PlayerPedId(), 0)
    ClearPedBloodDamage(PlayerPedId())
    ResetPedVisibleDamage(PlayerPedId())
    ClearPedLastWeaponDamage(PlayerPedId())
    ResetPedMovementClipset(PlayerPedId(), 0)

    TriggerServerEvent('lordtiger_armour:armour_remove3')
    TriggerEvent('skinchanger:getSkin', function(skin)
      local playerPed = PlayerPedId()

      if skin.sex == 0 then
        TriggerEvent('skinchanger:loadClothes', skin, {['bproof_1'] = 15,  ['bproof_2'] = 2})
        SetPedArmour(PlayerPedId(), Config.Tier3)

        RequestAnimDict('missmic4')

        while not HasAnimDictLoaded('missmic4') do
          Wait(100)
        end

        TaskPlayAnim(playerPed, 'missmic4', 'michael_tux_fidget', 8.0, -8, -1, 49, 0, 0, 0, 0)
        exports['progressBars']:startUI(7000, "Schutzweste Anziehen")
        Citizen.Wait(7000)
        ClearPedTasks(playerPed)
      else
        TriggerEvent('skinchanger:loadClothes', skin, {['bproof_1'] = 0,  ['bproof_2'] = 0})
        SetPedArmour(PlayerPedId(), Config.Tier3)
        
        RequestAnimDict('missmic4')

        while not HasAnimDictLoaded('missmic4') do
          Wait(100)
        end

        TaskPlayAnim(playerPed, 'missmic4', 'michael_tux_fidget', 8.0, -8, -1, 49, 0, 0, 0, 0)
        exports['progressBars']:startUI(7000, "Schutzweste Anziehen")
        Citizen.Wait(7000)
        ClearPedTasks(playerPed)
      end

    end)

  --[[  exports['t-notify']:Alert({
      style  =  'success',
      duration  = 4000,
      message  =  'You putted Tier 3 Armour on!',
      sound = true,
    })]]
    TriggerEvent('est_notify', '#45CE00', 'Schutzweste', 'Du hast eine SK 3 Schutzweste angezogen')
  end

end)

RegisterNetEvent('lordtiger_armour:t4_armour')
AddEventHandler('lordtiger_armour:t4_armour', function()

  if GetPedArmour(PlayerPedId()) == Config.Tier4 then
--[[
    exports['t-notify']:Alert({
      style  =  'error',
      message  =  'You already have Tier 4 armour on!',
      duration  = 4000,
      sound = true,
    })]]
    TriggerEvent('est_notify', '#FF0000', 'Schutzweste', 'Du hast bereits eine SK 4 Schutzweste an!')
  else
    SetPedArmour(PlayerPedId(), 0)
    ClearPedBloodDamage(PlayerPedId())
    ResetPedVisibleDamage(PlayerPedId())
    ClearPedLastWeaponDamage(PlayerPedId())
    ResetPedMovementClipset(PlayerPedId(), 0)

    TriggerServerEvent('lordtiger_armour:armour_remove4')
    TriggerEvent('skinchanger:getSkin', function(skin)
      local playerPed = PlayerPedId()

      if skin.sex == 0 then
        TriggerEvent('skinchanger:loadClothes', skin, {['bproof_1'] = 16,  ['bproof_2'] = 2})
        SetPedArmour(PlayerPedId(), Config.Tier4)

        RequestAnimDict('missmic4')

        while not HasAnimDictLoaded('missmic4') do
          Wait(100)
        end

        TaskPlayAnim(playerPed, 'missmic4', 'michael_tux_fidget', 8.0, -8, -1, 49, 0, 0, 0, 0)
        exports['progressBars']:startUI(7500, "Schutzweste Anziehen")
        Citizen.Wait(7500)
        ClearPedTasks(playerPed)
        
      else
        TriggerEvent('skinchanger:loadClothes', skin, {['bproof_1'] = 0,  ['bproof_2'] = 0})
        SetPedArmour(PlayerPedId(), Config.Tier4)

        RequestAnimDict('missmic4')

        while not HasAnimDictLoaded('missmic4') do
          Wait(100)
        end

        TaskPlayAnim(playerPed, 'missmic4', 'michael_tux_fidget', 8.0, -8, -1, 49, 0, 0, 0, 0)
        exports['progressBars']:startUI(7500, "Schutzweste Anziehen")
        Citizen.Wait(7500)
        ClearPedTasks(playerPed)
      end

    end)
    --[[
    exports['t-notify']:Alert({
      style  =  'success',
      message  =  'You putted Tier 4 Armour on!',
      duration  = 4000,
      sound = true,
    })]]
    TriggerEvent('est_notify', '#45CE00', 'Schutzweste', 'Du hast eine SK 4 Schutzweste angezogen')
  end

end)

RegisterNetEvent('lordtiger_armour:scuba')
AddEventHandler('lordtiger_armour:scuba', function()


    local playerPed = PlayerPedId()

    SetEnableScuba(playerPed, true)
    SetPedMaxTimeUnderwater(playerPed, 15000.00)

end)
