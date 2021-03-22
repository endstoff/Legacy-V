-- Define the variable used to open/close the tab
local tabEnabled = false
local tabLoaded = true --false
ESX								= nil
local isInZone = false 
local xp = 5555
local yp = 5555
local zp = 5555
Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

	Citizen.Wait(5000)
	xPlayer = ESX.GetPlayerData()
	
	
end)

function REQUEST_NUI_FOCUS(bool)
    SetNuiFocus(bool, bool) -- focus, cursor
    if bool == true then
        SendNUIMessage({showtab = true, identificador = ESX.GetPlayerData().identifier })
		
    else
        SendNUIMessage({hidetab = true})
    end
    return bool
end
 
RegisterNUICallback(
    "tablet-bus",
    function(data)
        -- Do tablet hide shit
        if data.load then
            print("Loaded the tablet")
            tabLoaded = true
        elseif data.hide then
            print("Hiding the tablet")
            SetNuiFocus(false, false) -- Don't REQUEST_NUI_FOCUS here
            tabEnabled = false
        elseif data.click then
        -- if u need click events
        end
    end
)

RegisterNUICallback(
    "tienda",
    function(data)
        -- Do tablet hide shit
		Citizen.Wait(1000)
        if data.load then
            --print("Loaded the tablet")
            tabLoaded = true
        elseif data.hide then
            
            SendNUIMessage({showtab2 = true})
        elseif data.click then
        -- if u need click events
        end
    end
)



RegisterNUICallback(
    "vender",
    function(data)
        -- Do tablet hide shit
		Citizen.Wait(1000)
		
         TriggerServerEvent('esx_onlineshop:vender', data.nameventa, data.labelventa, data.cantidadventa, data.valorventa)
		 
    end
)
RegisterNUICallback(
    "comprar",
    function(data)
        -- Do tablet hide shit
		Citizen.Wait(1000)
		
         TriggerServerEvent('esx_onlineshop:comprar', data.idcompra, data.cantidadcompra)
		 
    end
)

RegisterNUICallback(
    "quierovender",
    function(data)
        -- Do tablet hide shit
		Citizen.Wait(1800)
		
		ESX.TriggerServerCallback('esx_onlineshop:obtenerinventario', function(inventario) 
			
			
			inventariopack = {}
			
			if Config.itemFilter then
				
				for i=1, #inventario.items, 1 do
				
				local invitem = inventario.items[i]
					if invitem.count > 0 then
						
						if (Config.Items[invitem.name] ~= nil and Config.Items[invitem.name] == true) then
						table.insert(inventariopack, invitem)
						end
					end
				end
			else
				for i=1, #inventario.items, 1 do
				local invitem = inventario.items[i]
					if invitem.count > 0 then
						table.insert(inventariopack, invitem)
					end
				end
			end
			
			SendNUIMessage({quierovender= true, objetosavender = inventariopack})
					
				

		end)
    end
)

RegisterNUICallback(
    "quierocomprar",
    function(data)
        -- Do tablet hide shit
		Citizen.Wait(500)
	
		
		ESX.TriggerServerCallback('esx_onlineshop:obtenerlistaventas', function(objetosenventa) 
			
			
			
			
			SendNUIMessage({quierocomprar= true, objetosenventa = objetosenventa})
					
				

		end)
    end
)

RegisterNUICallback(
    "quierocobrar",
    function(data)
        -- Do tablet hide shit
		Citizen.Wait(1800)
		
		TriggerServerEvent('esx_onlineshop:cobrar', function() 
			
					
				

		end)
    end
)
RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	ESX.PlayerData.job = job

	Citizen.Wait(5000)
	TriggerServerEvent('esx_policejob:forceBlip')
end)

Citizen.CreateThread(
    function()
        -- Wait for nui to load or just timeout
        local l = 0
        local timeout = false
        while not tabLoaded do
            Citizen.Wait(0)
            l = l + 1
            if l > 500 then
                tabLoaded = true --
                timeout = true
            end
        end

        if timeout == true then
            print("Failed to load tablet nui...")
        -- return ---- Quit
        end

        print("::The client lua for tablet loaded::")

        REQUEST_NUI_FOCUS(false) -- This is just in case the resources restarted whilst the NUI is focused.

        while true do

            -- Control ID 20 is the 'Z' key by default
            -- 244 = M
            -- Use https://wiki.fivem.net/wiki/Controls to find a different key
            if (IsControlJustPressed(0, Config.openKey)) and GetLastInputMethod( 0 ) and Config.needItem and not Config.onlyJob and isInZone then
					local inventory = ESX.GetPlayerData().inventory
					local count = 0
					for i=1, #inventory, 1 do
						if ((inventory[i].name == Config.openItem) and (inventory[i].count > 0)) then
							
								 tabEnabled = not tabEnabled -- Toggle tablet visible state
								REQUEST_NUI_FOCUS(tabEnabled)
								print("The tablet state is: " .. tostring(tabEnabled))
								Citizen.Wait(0)
						end
					end
               
            end
			
			if (IsControlJustPressed(0, Config.openKey)) and GetLastInputMethod( 0 ) and Config.needItem and Config.onlyJob and isInZone then
					local inventory = ESX.GetPlayerData().inventory
					local count = 0
					local allowopen = false
					for i=0, #Config.tabletJob, 1 do
						if (Config.tabletJob[i]==ESX.PlayerData.job.name) then
							allowopen = true
						end--Config.tabletJob==ESX.PlayerData.job.name
					end
					--print('abriendo aqui')
					for i=1, #inventory, 1 do
						if ((inventory[i].name == Config.openItem) and (inventory[i].count > 0) and allowopen==true) then
							
								 tabEnabled = not tabEnabled -- Toggle tablet visible state
								REQUEST_NUI_FOCUS(tabEnabled)
								print("The tablet state is: " .. tostring(tabEnabled))
								Citizen.Wait(0)
						end
					end
               
            end
			
			if (IsControlJustPressed(0, Config.openKey)) and GetLastInputMethod( 0 ) and not Config.needItem and Config.onlyJob then
				for i=0, #Config.tabletJob, 1 do
					if (Config.tabletJob[i]==ESX.PlayerData.job.name) then
							tabEnabled = not tabEnabled -- Toggle tablet visible state
							REQUEST_NUI_FOCUS(tabEnabled)
							print("The tablet state is: " .. tostring(tabEnabled))
							Citizen.Wait(0)
					end--Config.tabletJob==ESX.PlayerData.job.name
				end
                
            end
			
			if (IsControlJustPressed(0, Config.openKey)) and GetLastInputMethod( 0 ) and not Config.needItem and not Config.onlyJob then
				
                tabEnabled = not tabEnabled -- Toggle tablet visible state
                REQUEST_NUI_FOCUS(tabEnabled)
                print("The tablet state is: " .. tostring(tabEnabled))
                Citizen.Wait(0)
            end
            if (tabEnabled) then
                local ped = GetPlayerPed(-1)
                DisableControlAction(0, 1, tabEnabled) -- LookLeftRight
                DisableControlAction(0, 2, tabEnabled) -- LookUpDown
                DisableControlAction(0, 24, tabEnabled) -- Attack
                DisablePlayerFiring(ped, tabEnabled) -- Disable weapon firing
                DisableControlAction(0, 142, tabEnabled) -- MeleeAttackAlternate
                DisableControlAction(0, 106, tabEnabled) -- VehicleMouseControlOverride
            end
            Citizen.Wait(0)
        end
    end
)

Citizen.CreateThread(function()
    while true do
    Citizen.Wait(0)
        local playerPos = GetEntityCoords(PlayerPedId(), true)
        local distance = Vdist(playerPos.x, playerPos.y, playerPos.z, xp, yp, zp)
        local drawm2 = false
        if distance < 1.0 then 
            if isInZone == true then 
            else 
                isInZone = true 
                TriggerEvent('notify', 1, "", "Drücke [E] um den Schwarzmarkt zu öffnen")
            end
        end
        if distance > 1.0 then 
            isInZone = false 
        end
        if distance < 15.0 then
                DrawMarker(27, xp, yp, zp, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 2.0, 2.0, 1.0, 204, 204, 0, 100, false, true, 2, false, false, false, false)
        end
    end
end)