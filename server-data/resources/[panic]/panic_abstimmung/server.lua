ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterServerCallback('panic_abstimmung:getCounters', function(source, cb, id)
    MySQL.Async.fetchAll('SELECT * FROM abstimmung_votecounter WHERE id = 1', {
        ['@id'] = id
    }, function(result2)
        
        local yes_votes = result2[1].yes_votes 
        local no_votes = result2[1].no_votes
        local data = {
            yes_votes = yes_votes, 
            no_votes = no_votes 
        }

        cb(data)
    end)
end)