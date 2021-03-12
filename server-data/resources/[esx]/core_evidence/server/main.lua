ESX = nil

local shots = {}
local blood = {}

TriggerEvent(
    "esx:getSharedObject",
    function(obj)
        ESX = obj
    end
)

ESX.RegisterServerCallback(
    "core_evidence:getData",
    function(source, cb)
        cb({shots = shots, blood = blood, time = os.time()})
    end
)

RegisterServerEvent("core_evidence:removeBlood")
AddEventHandler(
    "core_evidence:removeBlood",
    function(identifier)
        blood[identifier] = nil
    end
)

RegisterServerEvent("core_evidence:removeShot")
AddEventHandler(
    "core_evidence:removeShot",
    function(identifier)
        shots[identifier] = nil
    end
)

RegisterServerEvent("core_evidence:LastInCar")
AddEventHandler(
    "core_evidence:LastInCar",
    function(id)
        local src = source
        local entity = NetworkGetEntityFromNetworkId(id)
        local xPlayer = ESX.GetPlayerFromId(NetworkGetEntityOwner(entity))

        if NetworkGetEntityOwner(entity) ~= src then
            MySQL.Async.fetchAll(
                "SELECT " ..
                    Config.EvidenceReportInformationFingerprint .. " FROM `users` WHERE identifier = @owner LIMIT 1",
                {
                    ["@owner"] = xPlayer.identifier
                },
                function(reportInfo)
                    TriggerClientEvent("core_evidence:addFingerPrint", src, reportInfo[1])
                end
            )
        else
            TriggerClientEvent("core_evidence:SendTextMessage", src, Config.Text["no_fingerprints_found"])
        end
    end
)

RegisterServerEvent("core_evidence:saveBlood")
AddEventHandler(
    "core_evidence:saveBlood",
    function(coords)
        local src = source
        local xPlayer = ESX.GetPlayerFromId(src)

        MySQL.Async.fetchAll(
            "SELECT " .. Config.EvidenceReportInformationBlood .. " FROM `users` WHERE identifier = @owner LIMIT 1",
            {
                ["@owner"] = xPlayer.identifier
            },
            function(reportInfo)
                local time = os.time()
                blood[time] = {coords = coords, reportInfo = reportInfo[1]}
            end
        )
    end
)

ESX.RegisterUsableItem(
    "uvlight",
    function(playerId)
        TriggerClientEvent("core_evidence:checkForFingerprints", playerId)
    end
)

RegisterServerEvent("core_evidence:saveShot")
AddEventHandler(
    "core_evidence:saveShot",
    function(coords, bullet, weapon)
        local src = source
        local xPlayer = ESX.GetPlayerFromId(src)

        MySQL.Async.fetchAll(
            "SELECT " .. Config.EvidenceReportInformationBullet .. " FROM `users` WHERE identifier = @owner LIMIT 1",
            {
                ["@owner"] = xPlayer.identifier
            },
            function(reportInfo)
                local time = os.time()
                shots[time] = {coords = coords, bullet = bullet, id = weapon, reportInfo = reportInfo[1]}
            end
        )
    end
)
