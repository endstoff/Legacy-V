ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

Citizen.CreateThread(function()
    Citizen.Wait(0)
    print("^7[^1legacy_jobs^7] - ^2Aktiv! ^0") 
    while Jobs == nil do 
        Citizen.Wait(100)
    end
    TriggerClientEvent("legacy_jobs:client:getJobsData", -1, Jobs) --for restart
end)

AddEventHandler('esx:playerLoaded', function(data)
    Citizen.Wait(0)
    local player = ESX.GetPlayerFromId(data)
    while Jobs == nil do 
        Citizen.Wait(100)
    end
    TriggerClientEvent("legacy_jobs:client:getJobsData", player.source, Jobs)
end)

RegisterServerEvent("legacy_jobs:server:process")
AddEventHandler("legacy_jobs:server:process", function(coords, k, v, id)
    local player = ESX.GetPlayerFromId(source)
    if not player or k == nil or coords == nil or id == nil or v == nil then return TriggerClientEvent('mythic_notify:client:SendAlert', player.source, { type = 'error', text = "Ein Fehler ist aufgetreten. Bitte versuche es erneut."}) end
    local jobData = Jobs[k].location[id]
    if #(jobData.coords - coords) <= 10 then
        local item = player.getInventoryItem(jobData.item["itemName"])
        local requiredItem = player.getInventoryItem(jobData.item["requiredItem"])
        if item or jobData.item["process"] == "sell" then
            if jobData.item["process"] == "pickup" then
                if player.canCarryItem(jobData.item["itemName"], jobData.item["addCount"]) then
                    player.addInventoryItem(jobData.item["itemName"], jobData.item["addCount"])
                    TriggerClientEvent('mythic_notify:client:SendAlert', player.source, { type = 'inform', text = "Du hast "..jobData.item["addCount"].."x ".. ESX.GetItemLabel(jobData.item["itemName"]).. " gesammelt"})
                else
                    TriggerClientEvent('mythic_notify:client:SendAlert', player.source, { type = 'error', text = "Du kannst nicht mehr Tragen!"})
                end
            elseif jobData.item["process"] == "exchange" then
                if requiredItem.count >= jobData.item["removeCount"] then
                    if player.canCarryItem(jobData.item["itemName"], jobData.item["addCount"]) then
                        player.removeInventoryItem(jobData.item["requiredItem"], jobData.item["removeCount"])
                        player.addInventoryItem(jobData.item["itemName"], jobData.item["addCount"])
                        TriggerClientEvent('mythic_notify:client:SendAlert', player.source, { type = 'inform', text = "du hast "..jobData.item["addCount"].."x ".. ESX.GetItemLabel(jobData.item["itemName"]).. " verarbeitet"})
                    else
                        TriggerClientEvent('mythic_notify:client:SendAlert', player.source, { type = 'error', text = "Du kannst nicht mehr Tragen!"})
                    end
                else
                    TriggerClientEvent('mythic_notify:client:SendAlert', player.source, { type = 'error', text = "Du hast nicht genügend Items!"})
                end
            elseif jobData.item["process"] == "package" then
                if requiredItem.count >= jobData.item["removeCount"] then
                    if player.canCarryItem(jobData.item["itemName"], jobData.item["addCount"]) then
                        player.removeInventoryItem(jobData.item["requiredItem"], jobData.item["removeCount"])
                        player.addInventoryItem(jobData.item["itemName"], jobData.item["addCount"])
                        TriggerClientEvent('mythic_notify:client:SendAlert', player.source, { type = 'inform', text = "Du hast "..jobData.item["addCount"].."x "..ESX.GetItemLabel(jobData.item["itemName"]).. "verpackt"})
                    else
                        TriggerClientEvent('mythic_notify:client:SendAlert', player.source, { type = 'error', text = "Du kannst nicht mehr Tragen!"})
                    end
                else
                    TriggerClientEvent('mythic_notify:client:SendAlert', player.source, { type = 'error', text = "Du hast nicht genügend Items!"})
                end
            elseif jobData.item["process"] == "sell" then
                if requiredItem.count >= jobData.item["removeCount"] then
                    player.removeInventoryItem(jobData.item["requiredItem"], jobData.item["removeCount"])
                    player.addMoney(jobData.item["price"])
                    TriggerClientEvent('mythic_notify:client:SendAlert', player.source, { type = 'inform', text = "Du hast "..jobData.item["removeCount"].."x "..ESX.GetItemLabel(jobData.item["requiredItem"]).. "verkauft für $"..jobData.item["price"]})
                else
                    TriggerClientEvent('mythic_notify:client:SendAlert', player.source, { type = 'error', text = "Du hast nicht genügend Items!"})
                end
            end
        else
            TriggerClientEvent('mythic_notify:client:SendAlert', player.source, { type = 'error', text = "An error occurred."})
            print("[legacy_jobs] - ERROR - legacy_jobs:server:process Tried to query an item that isn't included in the 'items' table.") 
            print("[legacy_jobs] Item must be "..jobData.item["itemName"])
        end
    else
        print("[legacy_jobs] - WARNUNG - legacy_jobs:server:process event called without close to the process coords. User Identifier:"..player.identifier)
        DropPlayer(player.source, "Kicked for using exploit!")
    end
end)

ESX.RegisterServerCallback('legacy_jobs:checkCount', function(source, cb, itemName) 
    local player = ESX.GetPlayerFromId(source)
    local item = player.getInventoryItem(itemName)
    if item then
        cb(item.count)
    else
        cb(0)
    end
end)
