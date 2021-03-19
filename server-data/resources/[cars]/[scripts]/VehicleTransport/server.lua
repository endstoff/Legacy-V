RegisterServerEvent("VehicleTransport:DeleteRamp")
AddEventHandler("VehicleTransport:DeleteRamp", function(rampNetId, isOnesync)
	local ramp = NetworkGetEntityFromNetworkId(rampNetId)

	if (isOnesync) then
		if (DoesEntityExist(ramp)) then
			DeleteEntity(ramp)
		end
	else
		TriggerClientEvent("VehicleTransport:DeleteRamp", -1, rampNetId)
	end
end)

RegisterServerEvent("VehicleTransport:SaveTransport")
AddEventHandler("VehicleTransport:SaveTransport", function(transportData)
	print("Copy the following line into \"transportData.json\":\n" .. transportData)
end)
