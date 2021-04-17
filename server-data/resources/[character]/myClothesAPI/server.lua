
ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

-- Kleiderschrank
ESX.RegisterServerCallback('clothes:requestData', function(source, cb)
    if source ~= nil then

        local clothesData = {}

        MySQL.Async.fetchAll('SELECT * from user_clothes WHERE identifier = @identifier', {
            ['@identifier'] = GetPlayerIdentifiers(source)[1]
        },
            function(result)
                if #result > 0 then
                    for k, v in pairs(result) do
                        table.insert(clothesData, {
                            id = result[k].id,
                            identifier = result[k].identifier,
                            name = result[k].name,
                            clothesData = json.decode(result[k].clothesData),
                        })

                    end

                    cb(clothesData)
    
                end
            end
        )
    end

end)

RegisterServerEvent('clothes:saveOutfit')
AddEventHandler('clothes:saveOutfit', function(label, skinRes)

    if source ~= nil then
		if label and skinRes ~= nil then
		
			local steamID = GetPlayerIdentifiers(source)[1]

			MySQL.Async.execute(
				'INSERT INTO user_clothes (identifier, name, clothesData) VALUES (@identifier, @name, @clothesData)', {
				  ['@identifier'] = steamID,
				  ['@name'] = label,
				  ['@clothesData'] = json.encode(skinRes),
			  }
			)
		end
    end

end)

RegisterServerEvent('clothes:removeOutfit')
AddEventHandler('clothes:removeOutfit', function(id)

    MySQL.Async.execute(
        'DELETE FROM user_clothes WHERE id = @id', {
          ['@id'] = id,
      }
    )

end)
