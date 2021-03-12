Citizen.CreateThread(function()
	while true do
		SetDiscordAppId(805536189724491846)
		SetDiscordRichPresenceAsset('legacy_richpresence')
        SetDiscordRichPresenceAssetText('✨ Legacy-V Roleplay ✨')
		Citizen.Wait(2500)
	end
end)

Citizen.CreateThread(function()
	while true do
		local VehName = GetLabelText(GetDisplayNameFromVehicleModel(GetEntityModel(GetVehiclePedIsUsing(PlayerPedId()))))
		if VehName == "NULL" then VehName = GetDisplayNameFromVehicleModel(GetEntityModel(GetVehiclePedIsUsing(PlayerPedId()))) end
		local x,y,z = table.unpack(GetEntityCoords(PlayerPedId(),true))
		local StreetHash = GetStreetNameAtCoord(x, y, z)
		local pId = GetPlayerServerId(PlayerId())
		local pName = GetPlayerName(PlayerId())
		Citizen.Wait(15000)
		if StreetHash ~= nil then
			StreetName = GetStreetNameFromHashKey(StreetHash)
			if IsPedOnFoot(PlayerPedId()) and not IsEntityInWater(PlayerPedId()) then
				if IsPedSprinting(PlayerPedId()) then
					SetRichPresence("ID: "..pId.." | "..pName.." Sprintet entlang der  "..StreetName)
				elseif IsPedRunning(PlayerPedId()) then
					SetRichPresence("ID: "..pId.." | "..pName.." Rennt entlang der "..StreetName)
				elseif IsPedWalking(PlayerPedId()) then
					SetRichPresence("ID: "..pId.." | "..pName.." Läuft entlang der "..StreetName)
				elseif IsPedStill(PlayerPedId()) then
					SetRichPresence("ID: "..pId.." | "..pName.." Steht auf "..StreetName.."")
				end
			elseif GetVehiclePedIsUsing(PlayerPedId()) ~= nil and not IsPedInAnyHeli(PlayerPedId()) and not IsPedInAnyPlane(PlayerPedId()) and not IsPedOnFoot(PlayerPedId()) and not IsPedInAnySub(PlayerPedId()) and not IsPedInAnyBoat(PlayerPedId()) then
				local MPH = math.ceil(GetEntitySpeed(GetVehiclePedIsUsing(PlayerPedId())) * 2.236936)
				if MPH > 50 then
					SetRichPresence("ID: "..pId.." | "..pName.." Rast entlang der "..StreetName.." in einem "..VehName)
				elseif MPH <= 50 and MPH > 0 then
					SetRichPresence("ID: "..pId.." | "..pName.." Fährt entlang der "..StreetName.." in einem "..VehName)
				elseif MPH == 0 then
					SetRichPresence("ID: "..pId.." | "..pName.." Parkt an der "..StreetName.." in einem "..VehName)
				end
			elseif IsPedInAnyHeli(PlayerPedId()) or IsPedInAnyPlane(PlayerPedId()) then
				if IsEntityInAir(GetVehiclePedIsUsing(PlayerPedId())) or GetEntityHeightAboveGround(GetVehiclePedIsUsing(PlayerPedId())) > 5.0 then
					SetRichPresence("ID: "..pId.." | "..pName.." Fliegt über "..StreetName.." in einem "..VehName)
				else
					SetRichPresence("ID: "..pId.." | "..pName.." Landed auf "..StreetName.." in einem "..VehName)
				end
			elseif IsEntityInWater(PlayerPedId()) then
				SetRichPresence("ID: "..pId.." | "..pName.." Am herumschwimmen")
			elseif IsPedInAnyBoat(PlayerPedId()) and IsEntityInWater(GetVehiclePedIsUsing(PlayerPedId())) then
				SetRichPresence("ID: "..pId.." | "..pName.." Segelt in einem "..VehName)
			elseif IsPedInAnySub(PlayerPedId()) and IsEntityInWater(GetVehiclePedIsUsing(PlayerPedId())) then
				SetRichPresence("ID: "..pId.." | "..pName.." In einem gelbem Uboot")
			end
		end
	end
end)

local firstSpawn = true
AddEventHandler('playerSpawned', function()
    if firstSpawn then
        for _, v in pairs(Config.Buttons) do
            SetDiscordRichPresenceAction(v.index, v.name, v.url)
        end
        firstSpawn = false
    end
end)
