ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('myMultichar:GetPlayerCharacters')
AddEventHandler('myMultichar:GetPlayerCharacters', function()
    local src = source
    local LastCharId = GetLastCharacter(src)
    SetIdentifierToChar(GetPlayerIdentifiers(src)[1], LastCharId)

    if Config.useMyDrugs then
        TriggerEvent('myDrugs:updateIdentifier', src, GetPlayerIdentifiers(src)[1], 'Char'..LastCharId..GetIdentifierWithoutSteam(GetPlayerIdentifiers(src)[1]))
    end
    
    if Config.useMyProperties then
        TriggerEvent('myProperties:updateIdentifier', src, GetPlayerIdentifiers(src)[1], 'Char'..LastCharId..GetIdentifierWithoutSteam(GetPlayerIdentifiers(src)[1]))
    end
	

    local chars = GetPlayerCharacters(src)
    local maxChars = GetPlayerMaxChars(src)
    TriggerClientEvent('myMultichar:receiveChars', src, chars, maxChars[1].maxChars)
end)

RegisterServerEvent('myMultichar:CharSelected')
AddEventHandler('myMultichar:CharSelected', function(charid, isnew)
    local src = source
    local spawn = {}
    SetLastCharacter(src, tonumber(charid))
    SetCharToIdentifier(GetPlayerIdentifiers(src)[1], tonumber(charid))
    
    if Config.useMyDrugs then
        TriggerEvent('myDrugs:updateIdentifier', src, 'Char'..tonumber(charid)..GetIdentifierWithoutSteam(GetPlayerIdentifiers(src)[1]), GetPlayerIdentifiers(src)[1])
    end

    if Config.useMyProperties then
        TriggerEvent('myProperties:updateIdentifier', src, 'Char'..tonumber(charid)..GetIdentifierWithoutSteam(GetPlayerIdentifiers(src)[1]), GetPlayerIdentifiers(src)[1])
    end

    if not isnew then
        
        if GetSpawnPos(src) == nil then
            spawn = Config.FirstSpawnLocation
        end
		spawn = GetSpawnPos(src)
		TriggerClientEvent("myMultichar:SpawnCharacter", src, spawn, false)
    else
		TriggerClientEvent('skinchanger:loadDefaultModel', src, true, cb)
        spawn = Config.FirstSpawnLocation -- DEFAULT SPAWN POSITION
		TriggerClientEvent("myMultichar:SpawnCharacter", src, spawn, true)
    end
    
end)

function GetPlayerCharacters(source)
    local identifier = GetIdentifierWithoutSteam(GetPlayerIdentifiers(source)[1])
    local Chars = executeMySQL("SELECT * FROM `users` WHERE identifier LIKE '%"..identifier.."%'")
    return Chars
end

function GetPlayerMaxChars(source)
    local identifier = GetIdentifierWithoutSteam(GetPlayerIdentifiers(source)[1])
    local maxChars = executeMySQL("SELECT `maxChars` FROM `user_lastcharacter` WHERE steamid LIKE '%"..identifier.."%'")
    return maxChars
end

function GetLastCharacter(source)
    local LastChar = executeMySQL("SELECT `charid` FROM `user_lastcharacter` WHERE `steamid` = '"..GetPlayerIdentifiers(source)[1].."'")
    if LastChar[1] ~= nil and LastChar[1].charid ~= nil then
        return tonumber(LastChar[1].charid)
    else
        executeMySQL("INSERT INTO `user_lastcharacter` (`steamid`, `charid`) VALUES('"..GetPlayerIdentifiers(source)[1].."', 1)")
        return 1
    end
end

function SetLastCharacter(source, charid)
    executeMySQL("UPDATE `user_lastcharacter` SET `charid` = '"..charid.."' WHERE `steamid` = '"..GetPlayerIdentifiers(source)[1].."'")
end

function GetSpawnPos(source)

    local posRes = executeMySQL("SELECT `position` FROM `users` WHERE `identifier` = '"..GetPlayerIdentifiers(source)[1].."'")
	
	if posRes[1] ~= nil then
		return json.decode(posRes[1].position)
	else
		return nil
	end
    
end

function SetIdentifierToChar(identifier, charid)

    for k, data in pairs(Config.Tables) do
        executeMySQL("UPDATE `"..data.table.."` SET `"..data.column.."` = 'Char"..charid..GetIdentifierWithoutSteam(identifier).."' WHERE `"..data.column.."` = '"..identifier.."'")
    end
    -- REPLACE steam:111 to CharX:111
    
end

function SetCharToIdentifier(identifier, charid)

    for k, data in pairs(Config.Tables) do
        executeMySQL("UPDATE `"..data.table.."` SET `"..data.column.."` = '"..identifier.."' WHERE `"..data.column.."` = 'Char"..charid..GetIdentifierWithoutSteam(identifier).."'")
    end
    -- REPLACE CharX:111 to steam:111
    
end

function DeleteCharacter(identifier, charid, maxChars)

    for k, data in pairs(Config.Tables) do
        executeMySQL("DELETE FROM `"..data.table.."` WHERE `"..data.column.."` = 'Char"..charid..GetIdentifierWithoutSteam(identifier).."'")
    end
    --executeMySQL("DELETE FROM users WHERE identifier = 'Char"..charid..GetIdentifierWithoutSteam(identifier).."'")

    if charid ~= maxChars then
        for i=charid, maxChars-1, 1 do
            
            local oldID = math.floor(i + 1)
            local newId = math.floor(i)

            --print('change: Char' .. oldID .. ' to ' .. 'Char' .. newId)

            for k, data in pairs(Config.Tables) do
                executeMySQL("UPDATE `"..data.table.."` SET `"..data.column.."` = 'Char"..newId..GetIdentifierWithoutSteam(identifier).."' WHERE `"..data.column.."` = 'Char"..oldID..GetIdentifierWithoutSteam(identifier).."'")
            end
        end
    end
end


RegisterServerEvent('myMultichar:deleteChar')
AddEventHandler('myMultichar:deleteChar', function(charid, maxChars)
    local steamID = GetPlayerIdentifiers(source)[1]
    DeleteCharacter(steamID, charid, maxChars)
end)

function GetIdentifierWithoutSteam(Identifier)
    return string.gsub(Identifier, "steam", "")
end

function executeMySQL(queryString)
    local doing = true -- IMPORTANT! 
    local result = nil

    MySQL.Async.fetchAll(queryString, {}, function(data)
        result = data
        doing = false
    end)

    while doing do
        Citizen.Wait(0)
    end

    return result
end




function getIdentity(source, callback)

    local identifier = GetPlayerIdentifiers(source)[1]
    MySQL.Async.fetchAll("SELECT * FROM `users` WHERE `identifier` = @identifier",
    {
        ['@identifier'] = identifier
    },
    function(result)
        if #result > 0 then
            if result[1].firstname ~= nil or result[1].firstname ~= '' then
                --print('Character is there')
                local data = {
                    identifier  = result[1].identifier,
                    firstname  = result[1].firstname,
                    lastname  = result[1].lastname,
                    dateofbirth  = result[1].dateofbirth,
                    sex      = result[1].sex,
                    height    = result[1].height,
                }
                callback(data)
            else
                print(result[1].identifier)
                local data = nil
                callback(data)
            end
        else
            print('nothing there')
            local data = nil
            callback(data)
        end
    end)

end

function RegisterNewAccount(identifier_res, firstname_res, lastname_res, dateofbirth_res, sex_res, height_res)
    MySQL.Async.execute("UPDATE `users` SET `firstname` = @firstname, `lastname` = @lastname, `dateofbirth` = @dateofbirth, `sex` = @sex, `height` = @height WHERE identifier = @identifier",
    {
      ['@identifier']   = identifier_res,
      ['@firstname']    = firstname_res,
      ['@lastname']     = lastname_res,
      ['@dateofbirth']  = dateofbirth_res,
      ['@sex']          = sex_res,
      ['@height']       = height_res,
    })
	
end


RegisterServerEvent('myMultichar:updateAccount')
AddEventHandler('myMultichar:updateAccount', function(firstname_res, lastname_res, dateofbirth_res, sex_res, height_res)


    local identifier_res = GetPlayerIdentifiers(source)[1]
    RegisterNewAccount(identifier_res, firstname_res, lastname_res, dateofbirth_res, sex_res, height_res)

end)


RegisterServerEvent('myMultichar:updatePedModel')
AddEventHandler('myMultichar:updatePedModel', function(newModel)
    local steamID = GetPlayerIdentifiers(source)[1]
    MySQL.Async.execute("UPDATE `users` SET `pedModel` = @pedModel WHERE identifier = @identifier",
    {
      ['@identifier']   = steamID,
      ['@pedModel']    = newModel,
    })
end)

RegisterServerEvent('myMultichar:updatePermissions')
AddEventHandler('myMultichar:updatePermissions', function(target, type, value)
    local steamID = GetPlayerIdentifiers(target)[1]

    if steamID ~= nil then
        if type == 'pedmode' then
            MySQL.Async.execute("UPDATE `users` SET `pedModeAllowed` = @pedAllowed WHERE identifier = @identifier",
            {
            ['@identifier']   = steamID,
            ['@pedAllowed']    = value,
            })
            TriggerClientEvent('myMultichar:msg', source, Translation[Config.Locale]['giveperm_success'])

        elseif type == 'charamount' then
            MySQL.Async.execute("UPDATE `user_lastcharacter` SET `maxChars` = @maxChars WHERE steamid = @identifier",
            {
            ['@identifier']   = steamID,
            ['@maxChars']    = value,
            })
            TriggerClientEvent('myMultichar:msg', source, Translation[Config.Locale]['giveperm_success'])
        end
    else
        TriggerClientEvent('myMultichar:msg', source, Translation[Config.Locale]['giveperm_error'])
    end

   
end)

AddEventHandler('es:playerLoaded', function(source)

    getIdentity(source, function(data)
    
        if data.firstname == '' then
			if Config.useRegisterMenu then
				TriggerClientEvent('myMultichar:RegisterNewAccount', source)
			end
        else
            print('Character loaded: ' .. data.firstname .. ' ' .. data.lastname)
        end
    
    end)

    local steamID = GetPlayerIdentifiers(source)[1]

    MySQL.Async.fetchAll('SELECT pedModel FROM users WHERE identifier = @identifier',
    {
        ['@identifier'] = steamID,

    },
    function(result)
        if #result > 0 then
            if result[1].pedModel ~= nil then
                TriggerClientEvent('myMultichar:applyPed', source, result[1].pedModel)
            end
        end
    end
    )

end)

if Config.useRegisterMenu then
	RegisterCommand('register', function(source, args, raw)

		local steamID = GetPlayerIdentifiers(source)[1]

		MySQL.Async.fetchAll('SELECT * FROM users WHERE identifier = @identifier',
		{
			['@identifier'] = steamID,

		},
		function(result)
			if #result > 0 then
				TriggerClientEvent('myMultichar:RegisterNewAccount', source, result[1].firstname, result[1].lastname, result[1].dateofbirth, result[1].sex, result[1].height)
			else
				TriggerClientEvent('myMultichar:RegisterNewAccount', source)
			end
		end
		)
	end, false)
end

RegisterCommand('changePed', function(source, args, raw)

    local steamID = GetPlayerIdentifiers(source)[1]

    MySQL.Async.fetchAll('SELECT pedModeAllowed, pedModel FROM users WHERE identifier = @identifier',
    {
        ['@identifier'] = steamID,

    },
    function(result)
        if #result > 0 then
            if result[1].pedModeAllowed ~= nil then
                TriggerClientEvent('myMultichar:openPedMenu', source, result[1].pedModel)
            else
                TriggerClientEvent('myMultichar:msg', source, Translation[Config.Locale]['pedmode_no_perms'])
            end
        else
            TriggerClientEvent('myMultichar:msg', source, Translation[Config.Locale]['pedmode_no_perms'])
        end
    end
    )
end, false)

