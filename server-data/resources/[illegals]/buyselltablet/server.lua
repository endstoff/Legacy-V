ESX = nil

TriggerEvent(
	"esx:getSharedObject",
	function(obj)
		ESX = obj
		
	end
)



RegisterServerEvent('esx_onlineshop:vender')
AddEventHandler('esx_onlineshop:vender', function(nameventa, labelventa, cantidadventa, valorventa)
	local b = source;
    local c = ESX.GetPlayerFromId(b)
	local xPlayer = ESX.GetPlayerFromId(source)
	local items   = xPlayer.inventory
	for i=1, #items, 1 do
		if (items[i].name == nameventa and items[i].count >= tonumber(cantidadventa) and tonumber(valorventa)>0 and tonumber(cantidadventa)>0) then
			MySQL.Async.execute('INSERT INTO schwarzmarkt (vendedor, objeto, label, cantidad, precio, vendido) VALUES (@b, @nameventa, @labelventa, @cantidadventa, @valorventa, @cantidad)',
			  { ['b'] = c.identifier, ['nameventa'] = nameventa, ['labelventa'] = labelventa, ['cantidadventa'] = cantidadventa, ['valorventa'] = valorventa, ['cantidad'] = 0 },
			  function(affectedRows)
				TriggerClientEvent("esx:showNotification", b, "You insert x " .. cantidadventa .. " " .. labelventa.. " with price of " .. valorventa .. "$ per unit succesfully")
				
			end)
				  
			c.removeInventoryItem(nameventa, cantidadventa)
		end
	end
	
	
	
	
end)

RegisterServerEvent('esx_onlineshop:cobrar')
AddEventHandler('esx_onlineshop:cobrar', function()
	local b = source;
    local c = ESX.GetPlayerFromId(b)
	
	local n=0;
	MySQL.Async.fetchAll('SELECT * FROM schwarzmarkt WHERE vendedor = @vendedor AND vendido > 0',
		  { ['vendedor'] = c.identifier },
		  function(result)
			for i,v in ipairs(result) do 
			
				if (result[i].vendido > result[i].cobrados) then
					n=n+1
					MySQL.Async.execute('UPDATE schwarzmarkt SET cobrados = @vendido WHERE id = @idventa',
					  { 
					  ['idventa'] = result[i].id,
					  ['vendido'] = result[i].vendido

					  },
					  function(affectedRows)
					  
					   c.addAccountMoney('bank', result[i].precio*(result[i].vendido-result[i].cobrados))
					  TriggerClientEvent("esx:showNotification", b, "You have received "..result[i].precio*(result[i].vendido-result[i].cobrados).."$ succesfully")
						
						
					end)
				
				end
			
			end

			
			
		if (n == 0) then
			TriggerClientEvent("esx:showNotification", b, "You have nothing to collect")
		end
	end)
	
	
	MySQL.Async.execute('DELETE FROM schwarzmarkt WHERE cantidad = cobrados',
		{ },
		function(affectedRows)
					  
	end)
end)

RegisterServerEvent('esx_onlineshop:comprar')
AddEventHandler('esx_onlineshop:comprar', function(idcompra, cantidadcompra)
	local b = source;
    local xPlayer = ESX.GetPlayerFromId(b)
	
	

	MySQL.Async.fetchAll('SELECT * FROM schwarzmarkt WHERE id = @idcompra',
		  { ['idcompra'] = idcompra },
		  function(result)
			
			restantes=(result[1].cantidad-result[1].vendido)
			cantidadcompra=tonumber(cantidadcompra)
			
			
			if (cantidadcompra <= restantes and cantidadcompra > 0) then
				if xPlayer.getAccount('bank').money >= result[1].precio*cantidadcompra then
				
				MySQL.Async.execute('UPDATE schwarzmarkt SET vendido = @vendido WHERE id = @x',
					  { 
					  ['x'] = idcompra,
					  ['vendido'] = result[1].vendido+cantidadcompra

					  },
					  function(affectedRows)
					  xPlayer.removeAccountMoney('bank', result[1].precio*cantidadcompra)
					xPlayer.addInventoryItem(result[1].objeto, cantidadcompra)
					  TriggerClientEvent("esx:showNotification", b, "Successfully purchased")
						
					  end
				)
				
				
				
				else
				TriggerClientEvent("esx:showNotification", b, "Not enought money")
				end
			else
			TriggerClientEvent("esx:showNotification", b, "Invalid quantity")
			end

	end)
		  
	
end)


ESX.RegisterServerCallback('esx_onlineshop:obtenerinventario', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)
	local items   = xPlayer.inventory
	
	
	
	
	cb({items = items})
	
		
		
		

end)


ESX.RegisterServerCallback('esx_onlineshop:obtenerlistaventas', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)
	local items   = xPlayer.inventory
	
	MySQL.Async.fetchAll('SELECT * FROM schwarzmarkt ORDER BY precio ASC', { ['@id'] = playerId }, function(result)
		cb(json.encode(result))
		
		
	end)
end)