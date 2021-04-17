local ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) 
    ESX = obj 
end)

-- DISCORD WEBHOOKS

function SendWebhookMessage(webhook,message)
    if webhook ~= "false" then
        PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({content = message}), { ['Content-Type'] = 'application/json' })
    end
end
--

RegisterServerEvent('myBills:requestPlayerBills')
AddEventHandler('myBills:requestPlayerBills', function()

    local _source = source
    local identifierSource = GetPlayerIdentifiers(_source)[1]
    local xPlayer = ESX.GetPlayerFromId(_source)
	local bills = {}
    local taxbills = {}
    local gotResult = false
	
	MySQL.Async.fetchAll('SELECT * from billing WHERE identifier = @identifier', {
		['@identifier'] = xPlayer.identifier
	},
      function(result)
          if #result > 0 then
              for k, bill_res in pairs(result) do
                bills[k] = bill_res
              end

          end
      end
    )
	
	MySQL.Async.fetchAll('SELECT * from taxbills WHERE identifier = @identifier', {
		['@identifier'] = xPlayer.identifier
	},
      function(result)
          if #result > 0 then
              for k, bill_res in pairs(result) do
                taxbills[k] = bill_res
              end

          end
          gotResult = true
      end
    )

    while not gotResult do
        Wait(50)
    end
	
    TriggerClientEvent('myBills:receiveBills', _source, bills, taxbills)


end)

-- isnt used in the script, just to improve the compatibility with other scripts
ESX.RegisterServerCallback('esx_billing:getBills', function(source, cb)

	local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

	MySQL.Async.fetchAll(
		'SELECT * FROM billing WHERE identifier = @identifier',
		{
			['@identifier'] = xPlayer.identifier
		},
		function(result)

			local bills = {}

			for i=1, #result, 1 do
				table.insert(bills, {
					id         = result[i].id,
					identifier = result[i].identifier,
					sender     = result[i].sender,
					targetType = result[i].target_type,
					target     = result[i].target,
					label      = result[i].label,
					amount     = result[i].amount
				})
			end

			cb(bills)

		end
	)

end)


RegisterServerEvent('myBills:payBill')
AddEventHandler('myBills:payBill', function(bill_type, invoiceID, target_type, target, amount, sender)

    local xPlayer = ESX.GetPlayerFromId(source)

    local hasEnoughMoney = false
    if Config.useAccountMoney then
        local playerAccountMoney = xPlayer.getAccount(Config.Account).money
        if playerAccountMoney >= amount then
            hasEnoughMoney = true
        end
    else
        if xPlayer.getMoney() >= amount then
            hasEnoughMoney = true
        end
    end

    if hasEnoughMoney then
        if bill_type == 'billing' then
            MySQL.Async.execute('DELETE from billing WHERE id = @id', {
                    ['@id'] = invoiceID
                }
            )
        elseif bill_type == 'taxbills' then
            MySQL.Async.execute('DELETE from taxbills WHERE id = @id', {
                    ['@id'] = invoiceID
                }
            )
        end

        if Config.useAccountMoney then
            xPlayer.removeAccountMoney(Config.Account, amount)
        else
            xPlayer.removeMoney(amount)
        end
        TriggerClientEvent('myBills:msg', xPlayer.source, Translation[Config.Locale]['bill_paid'] .. amount .. Translation[Config.Locale]['bill_paid2'])
        TriggerClientEvent('myBills:refreshMenu', source)

        if target_type == 'society' then
            TriggerEvent('esx_addonaccount:getSharedAccount', target, function(account)
                account.addMoney(amount)
            end)
			local xPlayers    = ESX.GetPlayers()
			for k, v in pairs(xPlayers) do

                local xPlayer2 = ESX.GetPlayerFromId(xPlayers[k])
				if xPlayer2.identifier == sender then
					TriggerClientEvent('myBills:msg', xPlayer2.source, Translation[Config.Locale]['society_bill_paid'] .. amount .. Translation[Config.Locale]['society_bill_paid2'])
					break
				end
			end
        else -- target type = player
            local xPlayers    = ESX.GetPlayers()

            for k, v in pairs(xPlayers) do

                local xPlayer2 = ESX.GetPlayerFromId(xPlayers[k])

                if xPlayer2.identifier == target then    
                    -- Player online
                    if Config.useAccountMoney then
                        xPlayer2.addAccountMoney(Config.Account, amount)
                    else
                        xPlayer2.addMoney(amount)
                    end
                    TriggerClientEvent('myBills:msg', xPlayer2.source, Translation[Config.Locale]['society_bill_paid'] .. amount .. Translation[Config.Locale]['society_bill_paid2'])

                elseif k == #xPlayers then
                    -- Player not online
                    if Config.useNewESX then
                        MySQL.Async.fetchAll('SELECT accounts from users WHERE identifier = @identifier', {
                            ['@identifier'] = target
                        },
                        function(result)
                            if #result > 0 then
                                local accountsData = json.decode(result[1].accounts)
                                accountsData.money = accountsData.money + amount
                                local newAccountsData = json.encode(accountsData)
                                MySQL.Async.execute('UPDATE users SET accounts=@accounts WHERE identifier=@identifier',
                                {
                                    ['@accounts'] = newAccountsData,
                                    ['@identifier'] = target
                                })
                               
                            end
    
                        end)
                    else
                        MySQL.Async.fetchAll('SELECT money from users WHERE identifier = @identifier', {
                            ['@identifier'] = target
                        },
                        function(result)
                            if #result > 0 then
    
                                MySQL.Async.execute('UPDATE users SET money=@money WHERE identifier=@identifier',
                                {
                                    ['@money'] = result[1].money + amount,
                                    ['@identifier'] = target
                                })
                               
                            end
    
                        end)
                    end
                end

            end
        end

    else
        TriggerClientEvent('myBills:msg', source, Translation[Config.Locale]['not_enough_money'])
    end

end)

RegisterServerEvent('esx_billing:sendBill')
AddEventHandler('esx_billing:sendBill', function(playerId, sharedAccountName, label, amount)

    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local xPlayers = ESX.GetPlayers()

    if amount > 0 then
        
        for k, v in pairs(xPlayers) do

            local xPlayer2 = ESX.GetPlayerFromId(xPlayers[k])
            if xPlayer2.source == playerId then

                TriggerClientEvent('myBills:msg', source, Translation[Config.Locale]['bill_given'])
                --TriggerClientEvent('myBills:gotInvoice', playerId, source, xPlayer2.identifier, sharedAccountName, label, amount)
				TriggerClientEvent('myBills:gotInvoice', playerId, source, xPlayer2.identifier, sharedAccountName, label, amount)
                break
            end

        end

    end

end)


RegisterServerEvent('myBills:gotAnswerForBill')
AddEventHandler('myBills:gotAnswerForBill', function(sender, playerIdentifier, sharedAccountName, label, amount, state, hideMessage)

    local xPlayerSender = ESX.GetPlayerFromId(sender)
    if playerIdentifier == sender then
        playerIdentifier = xPlayerSender.identifier
    end

    if state then
        
        -- angenommen
		if hideMessage == nil or not hideMessage then 
			TriggerClientEvent('myBills:msg', sender, Translation[Config.Locale]['bill_accepted'])
			TriggerClientEvent('myBills:msg', source, Translation[Config.Locale]['target_bill_accepted'])
		end

        if sharedAccountName == nil then
            -- to player
            MySQL.Async.execute(
                'INSERT INTO billing (identifier, sender, target_type, target, label, amount) VALUES (@identifier, @sender, @target_type, @target, @label, @amount)',
                {
                    ['@identifier']  = playerIdentifier,
                    ['@sender']      = xPlayerSender.identifier,
                    ['@target_type'] = 'player',
                    ['@target']      = xPlayerSender.identifier,
                    ['@label']       = label,
                    ['@amount']      = amount
                }
            )
        else
            -- to society
			local charNameSender = 'Unknown'
			local charNameTarget = 'Unknown'
			MySQL.Async.fetchAll('SELECT firstname, lastname from users WHERE identifier = @identifier', {
				['@identifier'] = xPlayerSender.identifier
			},
			function(result)
				if #result > 0 then
					charNameSender = result[1].firstname .. ' ' .. result[1].lastname
					
					MySQL.Async.fetchAll('SELECT firstname, lastname from users WHERE identifier = @identifier', {
						['@identifier'] = playerIdentifier
					},
					function(result)
						if #result > 0 then
							charNameTarget = result[1].firstname .. ' ' .. result[1].lastname
							
							-- send Webhook Message
							if Config.useDiscordWebhooks then
								if Config.Webhooks[sharedAccountName] ~= nil then
									SendWebhookMessage(Config.Webhooks[sharedAccountName],string.format('%s: %s', Translation[Config.Locale]['discord_new_invoice'], charNameSender .. Translation[Config.Locale]['discord_msg'] .. charNameTarget .. Translation[Config.Locale]['discord_msg2'] .. amount .. Translation[Config.Locale]['discord_msg3'] .. label .. Translation[Config.Locale]['discord_msg4']))
								end
								
							end
							
						end

					end)
					
				end

			end)
			
			
			
			
			
            MySQL.Async.execute(
                'INSERT INTO billing (identifier, sender, target_type, target, label, amount) VALUES (@identifier, @sender, @target_type, @target, @label, @amount)',
                {
                    ['@identifier']  = playerIdentifier,
                    ['@sender']      = xPlayerSender.identifier,
                    ['@target_type'] = 'society',
                    ['@target']      = sharedAccountName,
                    ['@label']       = label,
                    ['@amount']      = amount
                }
            )
        end


    else
        -- abgelehnt
		if hideMessage == nil or not hideMessage then 
			TriggerClientEvent('myBills:msg', sender, Translation[Config.Locale]['bill_rejected'])
			TriggerClientEvent('myBills:msg', source, Translation[Config.Locale]['target_bill_rejected'])
		end
    end

end)

function PayTaxbills(d, h, m)

    ImportBills()
    
    MySQL.Async.fetchAll('SELECT * FROM taxbills',
    {},
    function(result)
        for k, currentTaxbill in pairs(result) do
            if currentTaxbill.duration == 0 then
                MySQL.Async.execute(
                    'DELETE FROM taxbills WHERE duration = 0',
                    {}
                )
            else
                local xPlayers = ESX.GetPlayers()
                local xPlayerHaveToPay
                local xPlayerGetsTheMoney

                -- REMOVE PLAYER WHO HAVE TO PAY THE MONEY
                foundPlayer = false
                for j=1, #xPlayers, 1 do

                    local xPlayer2 = ESX.GetPlayerFromId(xPlayers[j])
                    
                    if xPlayer2.identifier == currentTaxbill.identifier then
                        foundPlayer = true
                        xPlayerHaveToPay = xPlayer2
                        break
                    end
                end

                if foundPlayer then
                    if Config.useAccountMoney then
                        xPlayerHaveToPay.removeAccountMoney(Config.Account, currentTaxbill.amount / 5)
                    else
                        xPlayerHaveToPay.removeMoney(currentTaxbill.amount / 5)
                    end
                    TriggerClientEvent('myBills:msg', xPlayerHaveToPay.source, Translation[Config.Locale]['paid_taxbill'] .. (currentTaxbill.amount / 5))
                else
                    --edit in database
                    if Config.useNewESX then
                        MySQL.Async.fetchAll('SELECT accounts from users WHERE identifier = @identifier', {
                            ['@identifier'] = currentTaxbill.identifier
                        },
                        function(usersResult)
                            if #usersResult > 0 then
                                local accountsData = json.decode(usersResult[1].accounts)
                                accountsData.money = accountsData.money - currentTaxbill.amount / 5
                                local newAccountsData = json.encode(accountsData)
                                MySQL.Async.execute('UPDATE users SET accounts=@accounts WHERE identifier=@identifier',
                                {
                                    ['@accounts'] = newAccountsData,
                                    ['@identifier'] = currentTaxbill.identifier
                                })
                               
                            end
    
                        end)
                    else
                        MySQL.Async.fetchAll('SELECT money from users WHERE identifier = @identifier', {
                            ['@identifier'] = currentTaxbill.identifier
                        },
                        function(usersResult)
                            if #usersResult > 0 then
    
                                MySQL.Async.execute('UPDATE users SET money=@money WHERE identifier=@identifier',
                                {
                                    ['@money'] = usersResult[1].money - currentTaxbill.amount / 5,
                                    ['@identifier'] = currentTaxbill.identifier
                                })
                               
                            end
    
                        end)
                    end
                end

                -- ADD THE MONEY TO THE TARGET PLAYER
                --print(currentTaxbill.target_type)
                if currentTaxbill.target_type == 'society' then
                    TriggerEvent('esx_addonaccount:getSharedAccount', currentTaxbill.target, function(account)
                        account.addMoney(currentTaxbill.amount / 5)
                    end)
                   -- print('tried to add')
                    -- finished
                elseif currentTaxbill.target_type == 'player' then
                    foundPlayer = false
                    for j2=1, #xPlayers, 1 do

                        local xPlayer2 = ESX.GetPlayerFromId(xPlayers[j2])
                        
                        if xPlayer2.identifier == currentTaxbill.target then
                            foundPlayer = true
                            xPlayerGetsTheMoney = xPlayer2
                            break
                        end
                    end

                    if foundPlayer then
                        if Config.useAccountMoney then
                            xPlayerGetsTheMoney.addAccountMoney(Config.Account, currentTaxbill.amount / 5)
                        else
                            xPlayerGetsTheMoney.addMoney(currentTaxbill.amount / 5)
                        end
                    else
                        -- database
                        if Config.useNewESX then
                            MySQL.Async.fetchAll('SELECT accounts from users WHERE identifier = @identifier', {
                                ['@identifier'] = currentTaxbill.target
                            },
                            function(usersResult)
                                if #usersResult > 0 then
                                    local accountsData = json.decode(usersResult[1].accounts)
                                    accountsData.money = accountsData.money + currentTaxbill.amount / 5
                                    local newAccountsData = json.encode(accountsData)
                                    MySQL.Async.execute('UPDATE users SET accounts=@accounts WHERE identifier=@identifier',
                                    {
                                        ['@accounts'] = newAccountsData,
                                        ['@identifier'] = currentTaxbill.target
                                    })
                                   
                                end
        
                            end)
                        else
                            MySQL.Async.fetchAll('SELECT money from users WHERE identifier = @identifier', {
                                ['@identifier'] = currentTaxbill.target
                            },
                            function(usersResult)
                                if #usersResult > 0 then
        
                                    MySQL.Async.execute('UPDATE users SET money=@money WHERE identifier=@identifier',
                                    {
                                        ['@money'] = usersResult[1].money + currentTaxbill.amount / 5,
                                        ['@identifier'] = currentTaxbill.target
                                    })
                                   
                                end
        
                            end)
                        end
                    end
                end

                MySQL.Async.execute('UPDATE taxbills SET duration = @duration WHERE id = @id',
                    {
                        ['@duration'] = currentTaxbill.duration - 1,
                        ['@id']    = currentTaxbill.id
                    }
                )
            end

        end
    end)
  end
  
  function ImportBills(d, h, m)
  
    MySQL.Async.fetchAll(
      'SELECT * FROM billing',
      {},
      function(billings)
  
              for i=1, #billings, 1 do
  
                          MySQL.Async.execute(
                              'DELETE FROM billing WHERE id = @id AND identifier = @identifier AND sender = @sender AND target_type = @target_type AND target = @target AND label = @label AND amount = @amount',
                              {
                                  ['@id']			 = billings[i].id,
                                  ['@identifier']  = billings[i].identifier,
                                  ['@sender']      = billings[i].sender,
                                  ['@target_type'] = billings[i].target_type,
                                  ['@target']      = billings[i].target,
                                  ['@label']       = billings[i].label,
                                  ['@amount']      = billings[i].amount
                              }
                          )
  
                          MySQL.Async.execute(
                              'INSERT INTO taxbills (identifier, sender, target_type, target, label, amount, duration) VALUES (@identifier, @sender, @target_type, @target, @label, @amount, @duration)',
                              {
                                  ['@identifier']  = billings[i].identifier,
                                  ['@sender']      = billings[i].sender,
                                  ['@target_type'] = billings[i].target_type,
                                  ['@target']      = billings[i].target,
                                  ['@label']       = billings[i].label,
                                  ['@amount']      = billings[i].amount,
                                  ['@duration']	 = 5
                              }
                          )
  
                  end
              end
      
    )
  end
  
RegisterCommand("paytaxbills", function(source, args, rawCommand)
    PayTaxbills()
end)

RegisterServerEvent('myBills:importbills')
AddEventHandler('myBills:importbills', function()
    ImportBills()
end)

TriggerEvent('cron:runAt', Config.PayBillsTime.h, Config.PayBillsTime.m, PayTaxbills)

