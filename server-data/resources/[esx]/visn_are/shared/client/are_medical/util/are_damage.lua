local playerPed

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        
        playerPed = PlayerPedId()
        SetPlayerHealthRechargeMultiplier(playerPed, 0.0)

        Citizen.Wait(1)
    end
end)
