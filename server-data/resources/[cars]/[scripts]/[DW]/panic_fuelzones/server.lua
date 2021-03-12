ESX = nil 

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

--[[
ESX.RegisterServerCallback('panic_fuelzones:TPALETO1', function(source, cb)

    local s = source 
    local x = ESX.GetPlayerFromId(s)

    MySQL.Async.fetchAll('')
end)
]]

ESX.RegisterServerCallback('panic_fuelzones:getStation10', function(source, cb, stationID)
    
        MySQL.Async.fetchAll('SELECT * FROM stations WHERE stationID = 10', {
            ['@stationID'] = stationID
        }, function(result2)

			local stationName  = result2[1].stationName
			local stationFuel  = result2[1].stationFuel 
			local stationPPL   = result2[1].stationPPL
            local data = {
				stationName  = stationName,
				stationFuel  = stationFuel,
				stationPPL   = stationPPL
            }
            
			cb(data)
		end)
	end)

ESX.RegisterServerCallback('panic_fuelzones:getStation11', function(source, cb, stationID)
    
        MySQL.Async.fetchAll('SELECT * FROM stations WHERE stationID = 11', {
            ['@stationID'] = stationID
        }, function(result2)

			local stationName  = result2[1].stationName
			local stationFuel  = result2[1].stationFuel 
			local stationPPL   = result2[1].stationPPL
            local data = {
				stationName  = stationName,
				stationFuel  = stationFuel,
				stationPPL   = stationPPL
            }
            
			cb(data)
		end)
	end)

ESX.RegisterServerCallback('panic_fuelzones:getStation9', function(source, cb, stationID)
    
        MySQL.Async.fetchAll('SELECT * FROM stations WHERE stationID = 9', {
            ['@stationID'] = stationID
        }, function(result2)

			local stationName  = result2[1].stationName
			local stationFuel  = result2[1].stationFuel 
			local stationPPL   = result2[1].stationPPL
            local data = {
				stationName  = stationName,
				stationFuel  = stationFuel,
				stationPPL   = stationPPL
            }
            
			cb(data)
		end)
	end)

	ESX.RegisterServerCallback('panic_fuelzones:getStation8', function(source, cb, stationID)
    
        MySQL.Async.fetchAll('SELECT * FROM stations WHERE stationID = 8', {
            ['@stationID'] = stationID
        }, function(result2)

			local stationName  = result2[1].stationName
			local stationFuel  = result2[1].stationFuel 
			local stationPPL   = result2[1].stationPPL
            local data = {
				stationName  = stationName,
				stationFuel  = stationFuel,
				stationPPL   = stationPPL
            }
            
			cb(data)
		end)
	end)

	ESX.RegisterServerCallback('panic_fuelzones:getStation7', function(source, cb, stationID)
    
        MySQL.Async.fetchAll('SELECT * FROM stations WHERE stationID = 7', {
            ['@stationID'] = stationID
        }, function(result2)

			local stationName  = result2[1].stationName
			local stationFuel  = result2[1].stationFuel 
			local stationPPL   = result2[1].stationPPL
            local data = {
				stationName  = stationName,
				stationFuel  = stationFuel,
				stationPPL   = stationPPL
            }
            
			cb(data)
		end)
	end)

	ESX.RegisterServerCallback('panic_fuelzones:getStation4', function(source, cb, stationID)
    
        MySQL.Async.fetchAll('SELECT * FROM stations WHERE stationID = 4', {
            ['@stationID'] = stationID
        }, function(result2)

			local stationName  = result2[1].stationName
			local stationFuel  = result2[1].stationFuel 
			local stationPPL   = result2[1].stationPPL
            local data = {
				stationName  = stationName,
				stationFuel  = stationFuel,
				stationPPL   = stationPPL
            }
            
			cb(data)
		end)
	end)

	ESX.RegisterServerCallback('panic_fuelzones:getStation3', function(source, cb, stationID)
    
        MySQL.Async.fetchAll('SELECT * FROM stations WHERE stationID = 3', {
            ['@stationID'] = stationID
        }, function(result2)

			local stationName  = result2[1].stationName
			local stationFuel  = result2[1].stationFuel 
			local stationPPL   = result2[1].stationPPL
            local data = {
				stationName  = stationName,
				stationFuel  = stationFuel,
				stationPPL   = stationPPL
            }
            
			cb(data)
		end)
	end)

	ESX.RegisterServerCallback('panic_fuelzones:getStation2', function(source, cb, stationID)
    
        MySQL.Async.fetchAll('SELECT * FROM stations WHERE stationID = 2', {
            ['@stationID'] = stationID
        }, function(result2)

			local stationName  = result2[1].stationName
			local stationFuel  = result2[1].stationFuel 
			local stationPPL   = result2[1].stationPPL
            local data = {
				stationName  = stationName,
				stationFuel  = stationFuel,
				stationPPL   = stationPPL
            }
            
			cb(data)
		end)
	end)

	ESX.RegisterServerCallback('panic_fuelzones:getStation1', function(source, cb, stationID)
    
        MySQL.Async.fetchAll('SELECT * FROM stations WHERE stationID = 1', {
            ['@stationID'] = stationID
        }, function(result2)

			local stationName  = result2[1].stationName
			local stationFuel  = result2[1].stationFuel 
			local stationPPL   = result2[1].stationPPL
            local data = {
				stationName  = stationName,
				stationFuel  = stationFuel,
				stationPPL   = stationPPL
            }
            
			cb(data)
		end)
	end)

	ESX.RegisterServerCallback('panic_fuelzones:getStation6', function(source, cb, stationID)
    
        MySQL.Async.fetchAll('SELECT * FROM stations WHERE stationID = 6', {
            ['@stationID'] = stationID
        }, function(result2)

			local stationName  = result2[1].stationName
			local stationFuel  = result2[1].stationFuel 
			local stationPPL   = result2[1].stationPPL
            local data = {
				stationName  = stationName,
				stationFuel  = stationFuel,
				stationPPL   = stationPPL
            }
            
			cb(data)
		end)
	end)

	ESX.RegisterServerCallback('panic_fuelzones:getStation5', function(source, cb, stationID)
    
        MySQL.Async.fetchAll('SELECT * FROM stations WHERE stationID = 5', {
            ['@stationID'] = stationID
        }, function(result2)

			local stationName  = result2[1].stationName
			local stationFuel  = result2[1].stationFuel 
			local stationPPL   = result2[1].stationPPL
            local data = {
				stationName  = stationName,
				stationFuel  = stationFuel,
				stationPPL   = stationPPL
            }
            
			cb(data)
		end)
	end)

	ESX.RegisterServerCallback('panic_fuelzones:getStation12', function(source, cb, stationID)
    
        MySQL.Async.fetchAll('SELECT * FROM stations WHERE stationID = 12', {
            ['@stationID'] = stationID
        }, function(result2)

			local stationName  = result2[1].stationName
			local stationFuel  = result2[1].stationFuel 
			local stationPPL   = result2[1].stationPPL
            local data = {
				stationName  = stationName,
				stationFuel  = stationFuel,
				stationPPL   = stationPPL
            }
            
			cb(data)
		end)
	end)

	ESX.RegisterServerCallback('panic_fuelzones:getStation14', function(source, cb, stationID)
    
        MySQL.Async.fetchAll('SELECT * FROM stations WHERE stationID = 14', {
            ['@stationID'] = stationID
        }, function(result2)

			local stationName  = result2[1].stationName
			local stationFuel  = result2[1].stationFuel 
			local stationPPL   = result2[1].stationPPL
            local data = {
				stationName  = stationName,
				stationFuel  = stationFuel,
				stationPPL   = stationPPL
            }
            
			cb(data)
		end)
	end)

	ESX.RegisterServerCallback('panic_fuelzones:getStation13', function(source, cb, stationID)
    
        MySQL.Async.fetchAll('SELECT * FROM stations WHERE stationID = 13', {
            ['@stationID'] = stationID
        }, function(result2)

			local stationName  = result2[1].stationName
			local stationFuel  = result2[1].stationFuel 
			local stationPPL   = result2[1].stationPPL
            local data = {
				stationName  = stationName,
				stationFuel  = stationFuel,
				stationPPL   = stationPPL
            }
            
			cb(data)
		end)
	end)

	ESX.RegisterServerCallback('panic_fuelzones:getStation23', function(source, cb, stationID)
    
        MySQL.Async.fetchAll('SELECT * FROM stations WHERE stationID = 23', {
            ['@stationID'] = stationID
        }, function(result2)

			local stationName  = result2[1].stationName
			local stationFuel  = result2[1].stationFuel 
			local stationPPL   = result2[1].stationPPL
            local data = {
				stationName  = stationName,
				stationFuel  = stationFuel,
				stationPPL   = stationPPL
            }
            
			cb(data)
		end)
	end)

	ESX.RegisterServerCallback('panic_fuelzones:getStation22', function(source, cb, stationID)
    
        MySQL.Async.fetchAll('SELECT * FROM stations WHERE stationID = 22', {
            ['@stationID'] = stationID
        }, function(result2)

			local stationName  = result2[1].stationName
			local stationFuel  = result2[1].stationFuel 
			local stationPPL   = result2[1].stationPPL
            local data = {
				stationName  = stationName,
				stationFuel  = stationFuel,
				stationPPL   = stationPPL
            }
            
			cb(data)
		end)
	end)

	ESX.RegisterServerCallback('panic_fuelzones:getStation14', function(source, cb, stationID)
    
        MySQL.Async.fetchAll('SELECT * FROM stations WHERE stationID = 14', {
            ['@stationID'] = stationID
        }, function(result2)

			local stationName  = result2[1].stationName
			local stationFuel  = result2[1].stationFuel 
			local stationPPL   = result2[1].stationPPL
            local data = {
				stationName  = stationName,
				stationFuel  = stationFuel,
				stationPPL   = stationPPL
            }
            
			cb(data)
		end)
	end)

	ESX.RegisterServerCallback('panic_fuelzones:getStation21', function(source, cb, stationID)
    
        MySQL.Async.fetchAll('SELECT * FROM stations WHERE stationID = 21', {
            ['@stationID'] = stationID
        }, function(result2)

			local stationName  = result2[1].stationName
			local stationFuel  = result2[1].stationFuel 
			local stationPPL   = result2[1].stationPPL
            local data = {
				stationName  = stationName,
				stationFuel  = stationFuel,
				stationPPL   = stationPPL
            }
            
			cb(data)
		end)
	end)

	ESX.RegisterServerCallback('panic_fuelzones:getStation20', function(source, cb, stationID)
    
        MySQL.Async.fetchAll('SELECT * FROM stations WHERE stationID = 20', {
            ['@stationID'] = stationID
        }, function(result2)

			local stationName  = result2[1].stationName
			local stationFuel  = result2[1].stationFuel 
			local stationPPL   = result2[1].stationPPL
            local data = {
				stationName  = stationName,
				stationFuel  = stationFuel,
				stationPPL   = stationPPL
            }
            
			cb(data)
		end)
	end)

	ESX.RegisterServerCallback('panic_fuelzones:getStation19', function(source, cb, stationID)
    
        MySQL.Async.fetchAll('SELECT * FROM stations WHERE stationID = 19', {
            ['@stationID'] = stationID
        }, function(result2)

			local stationName  = result2[1].stationName
			local stationFuel  = result2[1].stationFuel 
			local stationPPL   = result2[1].stationPPL
            local data = {
				stationName  = stationName,
				stationFuel  = stationFuel,
				stationPPL   = stationPPL
            }
            
			cb(data)
		end)
	end)

	ESX.RegisterServerCallback('panic_fuelzones:getStation16', function(source, cb, stationID)
    
        MySQL.Async.fetchAll('SELECT * FROM stations WHERE stationID = 16', {
            ['@stationID'] = stationID
        }, function(result2)

			local stationName  = result2[1].stationName
			local stationFuel  = result2[1].stationFuel 
			local stationPPL   = result2[1].stationPPL
            local data = {
				stationName  = stationName,
				stationFuel  = stationFuel,
				stationPPL   = stationPPL
            }
            
			cb(data)
		end)
	end)

	ESX.RegisterServerCallback('panic_fuelzones:getStation17', function(source, cb, stationID)
    
        MySQL.Async.fetchAll('SELECT * FROM stations WHERE stationID = 17', {
            ['@stationID'] = stationID
        }, function(result2)

			local stationName  = result2[1].stationName
			local stationFuel  = result2[1].stationFuel 
			local stationPPL   = result2[1].stationPPL
            local data = {
				stationName  = stationName,
				stationFuel  = stationFuel,
				stationPPL   = stationPPL
            }
            
			cb(data)
		end)
	end)

	ESX.RegisterServerCallback('panic_fuelzones:getStation24', function(source, cb, stationID)
    
        MySQL.Async.fetchAll('SELECT * FROM stations WHERE stationID = 24', {
            ['@stationID'] = stationID
        }, function(result2)

			local stationName  = result2[1].stationName
			local stationFuel  = result2[1].stationFuel 
			local stationPPL   = result2[1].stationPPL
            local data = {
				stationName  = stationName,
				stationFuel  = stationFuel,
				stationPPL   = stationPPL
            }
            
			cb(data)
		end)
	end)

	ESX.RegisterServerCallback('panic_fuelzones:getStation18', function(source, cb, stationID)
    
        MySQL.Async.fetchAll('SELECT * FROM stations WHERE stationID = 18', {
            ['@stationID'] = stationID
        }, function(result2)

			local stationName  = result2[1].stationName
			local stationFuel  = result2[1].stationFuel 
			local stationPPL   = result2[1].stationPPL
            local data = {
				stationName  = stationName,
				stationFuel  = stationFuel,
				stationPPL   = stationPPL
            }
            
			cb(data)
		end)
	end)

	ESX.RegisterServerCallback('panic_fuelzones:getStation25', function(source, cb, stationID)
    
        MySQL.Async.fetchAll('SELECT * FROM stations WHERE stationID = 25', {
            ['@stationID'] = stationID
        }, function(result2)

			local stationName  = result2[1].stationName
			local stationFuel  = result2[1].stationFuel 
			local stationPPL   = result2[1].stationPPL
            local data = {
				stationName  = stationName,
				stationFuel  = stationFuel,
				stationPPL   = stationPPL
            }
            
			cb(data)
		end)
	end)