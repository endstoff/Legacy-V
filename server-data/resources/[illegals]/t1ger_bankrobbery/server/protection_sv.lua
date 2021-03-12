-------------------------------------
------- Created by T1GER#9080 -------
------------------------------------- 
local authoriseID = 'Love U Tiger | ilAn#0393'

		-- Event to update safe state:
        RegisterServerEvent('t1ger_bankrobbery:SafeDataSV')
        AddEventHandler('t1ger_bankrobbery:SafeDataSV', function(type, id, state)
            local xPlayer = ESX.GetPlayerFromId(source)
            if type == "robbed" then
                Config.Bank_Safes[id].robbed = state
            elseif type == "failed" then
                Config.Bank_Safes[id].failed = state
            end
            TriggerClientEvent('t1ger_bankrobbery:SafeDataCL', -1, type, id, state)
        end)

        -- inUse state:
        RegisterServerEvent('t1ger_bankrobbery:inUseSV')
        AddEventHandler('t1ger_bankrobbery:inUseSV', function(state)
            for i = 1, #Config.Banks do
                Config.Banks[i].inUse = state
            end
            TriggerClientEvent('t1ger_bankrobbery:inUseCL', -1, state)
        end)

        -- Keypad State:
        RegisterServerEvent('t1ger_bankrobbery:KeypadStateSV')
        AddEventHandler('t1ger_bankrobbery:KeypadStateSV', function(num, id, state)
            Config.Banks[id].keypads[num].hacked = state
            TriggerClientEvent('t1ger_bankrobbery:KeypadStateCL', -1, id, state, num)
        end)

        -- Desk Door State:
        RegisterServerEvent('t1ger_bankrobbery:DeskDoorStateSV')
        AddEventHandler('t1ger_bankrobbery:DeskDoorStateSV', function(id, state)
            Config.Banks[id].deskDoor.lockpicked = state
            TriggerClientEvent('t1ger_bankrobbery:DeskDoorStateCL', -1, id, state)
        end)

        -- Open / Close Vault Door:
        RegisterServerEvent('t1ger_bankrobbery:VaultDoorHandleSV')
        AddEventHandler('t1ger_bankrobbery:VaultDoorHandleSV', function(action, k, v, heading, amount)
            TriggerClientEvent('t1ger_bankrobbery:VaultDoorHandleCL', -1, action, k, v, heading, amount)
        end)

        -- Open / Close Desk Door:
        RegisterServerEvent('t1ger_bankrobbery:DeskDoorHandleSV')
        AddEventHandler('t1ger_bankrobbery:DeskDoorHandleSV', function(action, k, v, heading, amount)
            TriggerClientEvent('t1ger_bankrobbery:DeskDoorHandleCL', -1, action, k, v, heading, amount)
        end)

        -- ## PACIFIC SAFE ## --
        RegisterServerEvent('t1ger_bankrobbery:pacificSafeSV')
        AddEventHandler('t1ger_bankrobbery:pacificSafeSV', function(id, state)
            Config.Banks[id].safe.cracked = state
            TriggerClientEvent('t1ger_bankrobbery:pacificSafeCL', -1, id, state)
        end)

RegisterServerEvent('loaf_test:getAccess')
AddEventHandler('loaf_test:getAccess', function()
    local src = source
    TriggerClientEvent('loaf_test:setAccess', src, true)
end)