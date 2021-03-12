ESX = nil 
local TPaleto1 = false
local TPaleto2 = false 
local TPaleto3 = false 
local TSandyUp1 = false 
local TSandy1 = false
local TSandyDown1 = false
local TSandyDown2 = false
local TSandyDown3 = false
local TSandyDown4 = false
local THwy1 = false 
local THwy2 = false
local TArmy1 = false
local TBeachUp1 = false
local TYakuza1 = false
local THwy3 = false 
local TCityUp1 = false
local TRF1 = false
local TMirror1 = false
local TMirror2 = false
local TMeetingpoint1 = false
local TBeach1 = false
local TBennys1 = false 
local TBennys2 = false
local TGrove1 = false 
local TMettingpoint2 = false


Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
		local playerPos = GetEntityCoords(PlayerPedId(), true)

			local distance = Vdist(playerPos.x, playerPos.y, playerPos.z, 181.69, 6594.86, 31.85)

            if distance < 80.0 then
                if TPaleto1 == true then
				else
					TPaleto1 = true
					ESX.TriggerServerCallback('panic_fuelzones:getStation10', function(data)
					local stationName = data.stationName
					local stationID = "10"
					local stationppl = data.stationPPL
					local stationFuel = data.stationFuel
					-- print("Station: "..stationName.." | Preis: "..stationppl.."$/Liter | Füllstand: "..stationFuel.. " Liter")
					TriggerEvent('est_notify-tankstellen', '#FF9933', '<span style="color:orange"><b>Tankstelle</b></span>', "Station: "..stationName.."<br/>Preis: "..stationppl.."$/Liter <br/>Füllstand: "..stationFuel.. " Liter") 
					 --[[
						 SendNUIMessage({
						action = "sendFuel",
						name = "Test",
						money = "69",
						liter = "27"
					})
					]]
				end, data)
                end

            end

            if distance > 80.0 then
				TPaleto1 = false

			end
		end
	end)

Citizen.CreateThread(function()
	while true do 
		Citizen.Wait(1)
		local playerPos = GetEntityCoords(PlayerPedId(), true)

			local distance = Vdist(playerPos.x, playerPos.y, playerPos.z, -93.96, 6419.99, 31.49)

			if distance < 40.0 then 
				if TPaleto2 == true then 
				else 
					TPaleto2 = true 
					ESX.TriggerServerCallback('panic_fuelzones:getStation11', function(data)
					local stationName = data.stationName 
					local stationID = "11"
					local stationppl = data.stationPPL 
					local stationFuel = data.stationFuel 
					print("Current: "..stationID)

					TriggerEvent('est_notify-tankstellen', '#FF9933', '<span style="color:orange"><b>Tankstelle</b></span>', "Station: "..stationName.."<br/>Preis: "..stationppl.."$/Liter <br/>Füllstand: "..stationFuel.. " Liter")
					end, data)
				end
		end
		if distance > 40.0 then 
			TPaleto2 = false 

		end 
	end
end)

Citizen.CreateThread(function()
	while true do 
		Citizen.Wait(1)
		local playerPos = GetEntityCoords(PlayerPedId(), true)

			local distance = Vdist(playerPos.x, playerPos.y, playerPos.z, 1717.6, 6391.54, 33.65)

			if distance < 80.0 then 
				if TPaleto3 == true then 
				else 
					TPaleto3 = true 
					ESX.TriggerServerCallback('panic_fuelzones:getStation9', function(data)
					local stationName = data.stationName 
					local stationID = "9"
					local stationppl = data.stationPPL 
					local stationFuel = data.stationFuel 
					print("Current: "..stationID)

					TriggerEvent('est_notify-tankstellen', '#FF9933', '<span style="color:orange"><b>Tankstelle</b></span>', "Station: "..stationName.."<br/>Preis: "..stationppl.."$/Liter <br/>Füllstand: "..stationFuel.. " Liter")
					end, data)
				end
		end
		if distance > 80.0 then 
			TPaleto3 = false 

		end 
	end
end)

Citizen.CreateThread(function()
	while true do 
		Citizen.Wait(1)
		local playerPos = GetEntityCoords(PlayerPedId(), true)

			local distance = Vdist(playerPos.x, playerPos.y, playerPos.z, 1684.12, 4936.38, 42.1)

			if distance < 50.0 then 
				if TSandyUp1 == true then 
				else 
					TSandyUp1 = true 
					ESX.TriggerServerCallback('panic_fuelzones:getStation8', function(data)
					local stationName = data.stationName 
					local stationID = "8"
					local stationppl = data.stationPPL 
					local stationFuel = data.stationFuel 
					print("Current: "..stationID)

					TriggerEvent('est_notify-tankstellen', '#FF9933', '<span style="color:orange"><b>Tankstelle</b></span>', "Station: "..stationName.."<br/>Preis: "..stationppl.."$/Liter <br/>Füllstand: "..stationFuel.. " Liter")
					end, data)
				end
		end
		if distance > 50.0 then 
			TSandyUp1 = false 

		end 
	end
end)

Citizen.CreateThread(function()
	while true do 
		Citizen.Wait(1)
		local playerPos = GetEntityCoords(PlayerPedId(), true)

			local distance = Vdist(playerPos.x, playerPos.y, playerPos.z, 2007.99, 3767.61, 32.18)

			if distance < 40.0 then 
				if TSandy1 == true then 
				else 
					TSandy1 = true 
					ESX.TriggerServerCallback('panic_fuelzones:getStation7', function(data)
					local stationName = data.stationName 
					local stationID = "7"
					local stationppl = data.stationPPL 
					local stationFuel = data.stationFuel 
					print("Current: "..stationID)

					TriggerEvent('est_notify-tankstellen', '#FF9933', '<span style="color:orange"><b>Tankstelle</b></span>', "Station: "..stationName.."<br/>Preis: "..stationppl.."$/Liter <br/>Füllstand: "..stationFuel.. " Liter")
					end, data)
				end
		end
		if distance > 40.0 then 
			TSandy1 = false 

		end 
	end
end)

Citizen.CreateThread(function()
	while true do 
		Citizen.Wait(1)
		local playerPos = GetEntityCoords(PlayerPedId(), true)

			local distance = Vdist(playerPos.x, playerPos.y, playerPos.z, 1205.23, 2661.89, 37.9)

			if distance < 40.0 then 
				if TSandyDown1 == true then 
				else 
					TSandyDown1 = true 
					ESX.TriggerServerCallback('panic_fuelzones:getStation4', function(data)
					local stationName = data.stationName 
					local stationID = "4"
					local stationppl = data.stationPPL 
					local stationFuel = data.stationFuel 
					print("Current: "..stationID)

					TriggerEvent('est_notify-tankstellen', '#FF9933', '<span style="color:orange"><b>Tankstelle</b></span>', "Station: "..stationName.."<br/>Preis: "..stationppl.."$/Liter <br/>Füllstand: "..stationFuel.. " Liter")
					end, data)
				end
		end
		if distance > 40.0 then 
			TSandyDown1 = false 

		end 
	end
end)

Citizen.CreateThread(function()
	while true do 
		Citizen.Wait(1)
		local playerPos = GetEntityCoords(PlayerPedId(), true)

			local distance = Vdist(playerPos.x, playerPos.y, playerPos.z, 1037.82, 2678.9, 39.38)

			if distance < 40.0 then 
				if TSandyDown2 == true then 
				else 
					TSandyDown2 = true 
					ESX.TriggerServerCallback('panic_fuelzones:getStation3', function(data)
					local stationName = data.stationName 
					local stationID = "3"
					local stationppl = data.stationPPL 
					local stationFuel = data.stationFuel 
					print("Current: "..stationID)

					TriggerEvent('est_notify-tankstellen', '#FF9933', '<span style="color:orange"><b>Tankstelle</b></span>', "Station: "..stationName.."<br/>Preis: "..stationppl.."$/Liter <br/>Füllstand: "..stationFuel.. " Liter")
					end, data)
				end
		end
		if distance > 40.0 then 
			TSandyDown2 = false 

		end 
	end
end)

Citizen.CreateThread(function()
	while true do 
		Citizen.Wait(1)
		local playerPos = GetEntityCoords(PlayerPedId(), true)

			local distance = Vdist(playerPos.x, playerPos.y, playerPos.z, 262.95, 2613.9, 44.87)

			if distance < 80.0 then 
				if TSandyDown3 == true then 
				else 
					TSandyDown3 = true 
					ESX.TriggerServerCallback('panic_fuelzones:getStation2', function(data)
					local stationName = data.stationName 
					local stationID = "2"
					local stationppl = data.stationPPL 
					local stationFuel = data.stationFuel 
					print("Current: "..stationID)

					TriggerEvent('est_notify-tankstellen', '#FF9933', '<span style="color:orange"><b>Tankstelle</b></span>', "Station: "..stationName.."<br/>Preis: "..stationppl.."$/Liter <br/>Füllstand: "..stationFuel.. " Liter")
					end, data)
				end
		end
		if distance > 80.0 then 
			TSandyDown3 = false 

		end 
	end
end)

Citizen.CreateThread(function()
	while true do 
		Citizen.Wait(1)
		local playerPos = GetEntityCoords(PlayerPedId(), true)

			local distance = Vdist(playerPos.x, playerPos.y, playerPos.z, 41.09, 2782.7, 57.88)

			if distance < 40.0 then 
				if TSandyDown4 == true then 
				else 
					TSandyDown4 = true 
					ESX.TriggerServerCallback('panic_fuelzones:getStation1', function(data)
					local stationName = data.stationName 
					local stationID = "1"
					local stationppl = data.stationPPL 
					local stationFuel = data.stationFuel 
					print("Current: "..stationID)

					TriggerEvent('est_notify-tankstellen', '#FF9933', '<span style="color:orange"><b>Tankstelle</b></span>', "Station: "..stationName.."<br/>Preis: "..stationppl.."$/Liter <br/>Füllstand: "..stationFuel.. " Liter")
					end, data)
				end
		end
		if distance > 40.0 then 
			TSandyDown4 = false 

		end 
	end
end)

Citizen.CreateThread(function()
	while true do 
		Citizen.Wait(1)
		local playerPos = GetEntityCoords(PlayerPedId(), true)

			local distance = Vdist(playerPos.x, playerPos.y, playerPos.z, 2689.4, 3255.79, 55.38)

			if distance < 50.0 then 
				if THwy1 == true then 
				else 
					THwy1 = true 
					ESX.TriggerServerCallback('panic_fuelzones:getStation6', function(data)
					local stationName = data.stationName 
					local stationID = "6"
					local stationppl = data.stationPPL 
					local stationFuel = data.stationFuel 
					print("Current: "..stationID)

					TriggerEvent('est_notify-tankstellen', '#FF9933', '<span style="color:orange"><b>Tankstelle</b></span>', "Station: "..stationName.."<br/>Preis: "..stationppl.."$/Liter <br/>Füllstand: "..stationFuel.. " Liter")
					end, data)
				end
		end
		if distance > 50.0 then 
			THwy1 = false 

		end 
	end
end)

Citizen.CreateThread(function()
	while true do 
		Citizen.Wait(1)
		local playerPos = GetEntityCoords(PlayerPedId(), true)

			local distance = Vdist(playerPos.x, playerPos.y, playerPos.z, 2569.95, 2617.9, 36.8)

			if distance < 120.0 then 
				if THwy2 == true then 
				else 
					THwy2 = true 
					ESX.TriggerServerCallback('panic_fuelzones:getStation5', function(data)
					local stationName = data.stationName 
					local stationID = "5"
					local stationppl = data.stationPPL 
					local stationFuel = data.stationFuel 
					print("Current: "..stationID)

					TriggerEvent('est_notify-tankstellen', '#FF9933', '<span style="color:orange"><b>Tankstelle</b></span>', "Station: "..stationName.."<br/>Preis: "..stationppl.."$/Liter <br/>Füllstand: "..stationFuel.. " Liter")
					end, data)
				end
		end
		if distance > 120.0 then 
			THwy2 = false 

		end 
	end
end)

Citizen.CreateThread(function()
	while true do 
		Citizen.Wait(1)
		local playerPos = GetEntityCoords(PlayerPedId(), true)

			local distance = Vdist(playerPos.x, playerPos.y, playerPos.z, -2554.67, 2323.13, 33.06)

			if distance < 200.0 then 
				if TArmy1 == true then 
				else 
					TArmy1 = true 
					ESX.TriggerServerCallback('panic_fuelzones:getStation12', function(data)
					local stationName = data.stationName 
					local stationID = "12"
					local stationppl = data.stationPPL 
					local stationFuel = data.stationFuel 
					print("Current: "..stationID)

					TriggerEvent('est_notify-tankstellen', '#FF9933', '<span style="color:orange"><b>Tankstelle</b></span>', "Station: "..stationName.."<br/>Preis: "..stationppl.."$/Liter <br/>Füllstand: "..stationFuel.. " Liter")
					end, data)
				end
		end
		if distance > 200.0 then 
			TArmy1 = false 

		end 
	end
end)

Citizen.CreateThread(function()
	while true do 
		Citizen.Wait(1)
		local playerPos = GetEntityCoords(PlayerPedId(), true)

			local distance = Vdist(playerPos.x, playerPos.y, playerPos.z, -2101.98, -330.16, 13.02)

			if distance < 200.0 then 
				if TBeachUp1 == true then 
				else 
					TBeachUp1 = true 
					ESX.TriggerServerCallback('panic_fuelzones:getStation14', function(data)
					local stationName = data.stationName 
					local stationID = "14"
					local stationppl = data.stationPPL 
					local stationFuel = data.stationFuel 
					print("Current: "..stationID)

					TriggerEvent('est_notify-tankstellen', '#FF9933', '<span style="color:orange"><b>Tankstelle</b></span>', "Station: "..stationName.."<br/>Preis: "..stationppl.."$/Liter <br/>Füllstand: "..stationFuel.. " Liter")
					end, data)
				end
		end
		if distance > 200.0 then 
			TBeachUp1 = false 

		end 
	end
end)

Citizen.CreateThread(function()
	while true do 
		Citizen.Wait(1)
		local playerPos = GetEntityCoords(PlayerPedId(), true)

			local distance = Vdist(playerPos.x, playerPos.y, playerPos.z, -1812.6, 789.91, 137.79)

			if distance < 200.0 then 
				if TYakuza1 == true then 
				else 
					TYakuza1 = true 
					ESX.TriggerServerCallback('panic_fuelzones:getStation13', function(data)
					local stationName = data.stationName 
					local stationID = "13"
					local stationppl = data.stationPPL 
					local stationFuel = data.stationFuel 
					print("Current: "..stationID)

					TriggerEvent('est_notify-tankstellen', '#FF9933', '<span style="color:orange"><b>Tankstelle</b></span>', "Station: "..stationName.."<br/>Preis: "..stationppl.."$/Liter <br/>Füllstand: "..stationFuel.. " Liter")
					end, data)
				end
		end
		if distance > 200.0 then 
			TYakuza1 = false 

		end 
	end
end)

Citizen.CreateThread(function()
	while true do 
		Citizen.Wait(1)
		local playerPos = GetEntityCoords(PlayerPedId(), true)

			local distance = Vdist(playerPos.x, playerPos.y, playerPos.z, 2568.76, 360.75, 108.46)

			if distance < 400.0 then 
				if THwy3 == true then 
				else 
					THwy3 = true 
					ESX.TriggerServerCallback('panic_fuelzones:getStation23', function(data)
					local stationName = data.stationName 
					local stationID = "23"
					local stationppl = data.stationPPL 
					local stationFuel = data.stationFuel 
					print("Current: "..stationID)

					TriggerEvent('est_notify-tankstellen', '#FF9933', '<span style="color:orange"><b>Tankstelle</b></span>', "Station: "..stationName.."<br/>Preis: "..stationppl.."$/Liter <br/>Füllstand: "..stationFuel.. " Liter")
					end, data)
				end
		end
		if distance > 400.0 then 
			THwy3 = false 

		end 
	end
end)

Citizen.CreateThread(function()
	while true do 
		Citizen.Wait(1)
		local playerPos = GetEntityCoords(PlayerPedId(), true)

			local distance = Vdist(playerPos.x, playerPos.y, playerPos.z, 641.49, 260.88, 103.3)

			if distance < 100.0 then 
				if TCityUp1 == true then 
				else 
					TCityUp1 = true 
					ESX.TriggerServerCallback('panic_fuelzones:getStation22', function(data)
					local stationName = data.stationName 
					local stationID = "22"
					local stationppl = data.stationPPL 
					local stationFuel = data.stationFuel 
					print("Current: "..stationID)

					TriggerEvent('est_notify-tankstellen', '#FF9933', '<span style="color:orange"><b>Tankstelle</b></span>', "Station: "..stationName.."<br/>Preis: "..stationppl.."$/Liter <br/>Füllstand: "..stationFuel.. " Liter")
					end, data)
				end
		end
		if distance > 100.0 then 
			TCityUp1 = false 

		end 
	end
end)

Citizen.CreateThread(function()
	while true do 
		Citizen.Wait(1)
		local playerPos = GetEntityCoords(PlayerPedId(), true)

			local distance = Vdist(playerPos.x, playerPos.y, playerPos.z, -1444.13, -285.65, 45.99)

			if distance < 100.0 then 
				if TRF1 == true then 
				else 
					TRF1 = true 
					ESX.TriggerServerCallback('panic_fuelzones:getStation14', function(data)
					local stationName = data.stationName 
					local stationID = "14"
					local stationppl = data.stationPPL 
					local stationFuel = data.stationFuel 
					print("Current: "..stationID)

					TriggerEvent('est_notify-tankstellen', '#FF9933', '<span style="color:orange"><b>Tankstelle</b></span>', "Station: "..stationName.."<br/>Preis: "..stationppl.."$/Liter <br/>Füllstand: "..stationFuel.. " Liter")
					end, data)
				end
		end
		if distance > 100.0 then 
			TRF1 = false 

		end 
	end
end)

Citizen.CreateThread(function()
	while true do 
		Citizen.Wait(1)
		local playerPos = GetEntityCoords(PlayerPedId(), true)

			local distance = Vdist(playerPos.x, playerPos.y, playerPos.z, 1184.1, -334.35, 69.18)

			if distance < 150.0 then 
				if TMirror1 == true then 
				else 
					TMirror1 = true 
					ESX.TriggerServerCallback('panic_fuelzones:getStation21', function(data)
					local stationName = data.stationName 
					local stationID = "21"
					local stationppl = data.stationPPL 
					local stationFuel = data.stationFuel 
					print("Current: "..stationID)

					TriggerEvent('est_notify-tankstellen', '#FF9933', '<span style="color:orange"><b>Tankstelle</b></span>', "Station: "..stationName.."<br/>Preis: "..stationppl.."$/Liter <br/>Füllstand: "..stationFuel.. " Liter")
					end, data)
				end
		end
		if distance > 150.0 then 
			TMirror1 = false 

		end 
	end
end)

Citizen.CreateThread(function()
	while true do 
		Citizen.Wait(1)
		local playerPos = GetEntityCoords(PlayerPedId(), true)

			local distance = Vdist(playerPos.x, playerPos.y, playerPos.z, 1201.87, -1398.86, 35.22)

			if distance < 100.0 then 
				if TMirror2 == true then 
				else 
					TMirror2 = true 
					ESX.TriggerServerCallback('panic_fuelzones:getStation20', function(data)
					local stationName = data.stationName 
					local stationID = "20"
					local stationppl = data.stationPPL 
					local stationFuel = data.stationFuel 
					print("Current: "..stationID)

					TriggerEvent('est_notify-tankstellen', '#FF9933', '<span style="color:orange"><b>Tankstelle</b></span>', "Station: "..stationName.."<br/>Preis: "..stationppl.."$/Liter <br/>Füllstand: "..stationFuel.. " Liter")
					end, data)
				end
		end
		if distance > 100.0 then 
			TMirror2 = false 

		end 
	end
end)

Citizen.CreateThread(function()
	while true do 
		Citizen.Wait(1)
		local playerPos = GetEntityCoords(PlayerPedId(), true)

			local distance = Vdist(playerPos.x, playerPos.y, playerPos.z, 262.91, -1254.55, 29.14)

			if distance < 100.0 then 
				if TMeetingpoint1 == true then 
				else 
					TMeetingpoint1 = true 
					ESX.TriggerServerCallback('panic_fuelzones:getStation19', function(data)
					local stationName = data.stationName 
					local stationID = "19"
					local stationppl = data.stationPPL 
					local stationFuel = data.stationFuel 
					print("Current: "..stationID)

					TriggerEvent('est_notify-tankstellen', '#FF9933', '<span style="color:orange"><b>Tankstelle</b></span>', "Station: "..stationName.."<br/>Preis: "..stationppl.."$/Liter <br/>Füllstand: "..stationFuel.. " Liter")
					end, data)
				end
		end
		if distance > 100.0 then 
			TMeetingpoint1 = false 

		end 
	end
end)

Citizen.CreateThread(function()
	while true do 
		Citizen.Wait(1)
		local playerPos = GetEntityCoords(PlayerPedId(), true)

			local distance = Vdist(playerPos.x, playerPos.y, playerPos.z, -721.95, -934.81, 19.02)

			if distance < 100.0 then 
				if TBeach1 == true then 
				else 
					TBeach1 = true 
					ESX.TriggerServerCallback('panic_fuelzones:getStation16', function(data)
					local stationName = data.stationName 
					local stationID = "16"
					local stationppl = data.stationPPL 
					local stationFuel = data.stationFuel 
					print("Current: "..stationID)

					TriggerEvent('est_notify-tankstellen', '#FF9933', '<span style="color:orange"><b>Tankstelle</b></span>', "Station: "..stationName.."<br/>Preis: "..stationppl.."$/Liter <br/>Füllstand: "..stationFuel.. " Liter")
					end, data)
				end
		end
		if distance > 100.0 then 
			TBeach1 = false 

		end 
	end
end)

Citizen.CreateThread(function()
	while true do 
		Citizen.Wait(1)
		local playerPos = GetEntityCoords(PlayerPedId(), true)

			local distance = Vdist(playerPos.x, playerPos.y, playerPos.z, -534.56, -1205.13, 18.2)

			if distance < 150.0 then 
				if TBennys1 == true then 
				else 
					TBennys1 = true 
					ESX.TriggerServerCallback('panic_fuelzones:getStation17', function(data)
					local stationName = data.stationName 
					local stationID = "17"
					local stationppl = data.stationPPL 
					local stationFuel = data.stationFuel 
					print("Current: "..stationID)

					TriggerEvent('est_notify-tankstellen', '#FF9933', '<span style="color:orange"><b>Tankstelle</b></span>', "Station: "..stationName.."<br/>Preis: "..stationppl.."$/Liter <br/>Füllstand: "..stationFuel.. " Liter")
					end, data)
				end
		end
		if distance > 150.0 then 
			TBennys1 = false 

		end 
	end
end)

Citizen.CreateThread(function()
	while true do 
		Citizen.Wait(1)
		local playerPos = GetEntityCoords(PlayerPedId(), true)

			local distance = Vdist(playerPos.x, playerPos.y, playerPos.z, -324.0, -1463.96, 30.55)

			if distance < 100.0 then 
				if TBennys2 == true then 
				else 
					TBennys2 = true 
					ESX.TriggerServerCallback('panic_fuelzones:getStation24', function(data)
					local stationName = data.stationName 
					local stationID = "24"
					local stationppl = data.stationPPL 
					local stationFuel = data.stationFuel 
					print("Current: "..stationID)

					TriggerEvent('est_notify-tankstellen', '#FF9933', '<span style="color:orange"><b>Tankstelle</b></span>', "Station: "..stationName.."<br/>Preis: "..stationppl.."$/Liter <br/>Füllstand: "..stationFuel.. " Liter")
					end, data)
				end
		end
		if distance > 100.0 then 
			TBennys2 = false 

		end 
	end
end)

Citizen.CreateThread(function()
	while true do 
		Citizen.Wait(1)
		local playerPos = GetEntityCoords(PlayerPedId(), true)

			local distance = Vdist(playerPos.x, playerPos.y, playerPos.z, -66.91, -1762.31, 29.28)

			if distance < 100.0 then 
				if TGrove1 == true then 
				else 
					TGrove1 = true 
					ESX.TriggerServerCallback('panic_fuelzones:getStation18', function(data)
					local stationName = data.stationName 
					local stationID = "18"
					local stationppl = data.stationPPL 
					local stationFuel = data.stationFuel 
					print("Current: "..stationID)

					TriggerEvent('est_notify-tankstellen', '#FF9933', '<span style="color:orange"><b>Tankstelle</b></span>', "Station: "..stationName.."<br/>Preis: "..stationppl.."$/Liter <br/>Füllstand: "..stationFuel.. " Liter")
					end, data)
				end
		end
		if distance > 100.0 then 
			TGrove1 = false 

		end 
	end
end)

Citizen.CreateThread(function()
	while true do 
		Citizen.Wait(1)
		local playerPos = GetEntityCoords(PlayerPedId(), true)

			local distance = Vdist(playerPos.x, playerPos.y, playerPos.z, 170.09, -1558.05, 29.24)

			if distance < 100.0 then 
				if TMettingpoint2 == true then 
				else 
					TMettingpoint2 = true 
					ESX.TriggerServerCallback('panic_fuelzones:getStation25', function(data)
					local stationName = data.stationName 
					local stationID = "25"
					local stationppl = data.stationPPL 
					local stationFuel = data.stationFuel 
					print("Current: "..stationID)

					TriggerEvent('est_notify-tankstellen', '#FF9933', '<span style="color:orange"><b>Tankstelle</b></span>', "Station: "..stationName.."<br/>Preis: "..stationppl.."$/Liter <br/>Füllstand: "..stationFuel.. " Liter")
					end, data)
				end
		end
		if distance > 100.0 then 
			TMettingpoint2 = false 

		end 
	end
end)