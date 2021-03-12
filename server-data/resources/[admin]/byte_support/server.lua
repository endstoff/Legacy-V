TriggerEvent('es:addGroupCommand', 'supportcall', "support", function(source, args)
    local pname = GetPlayerName(source)
	local target = tonumber(args[1])
	local targetname = GetPlayerName(target)
    Citizen.CreateThread(function()
		TriggerClientEvent('byte_supports:support', target, "Support", pname .. ": Bitte finde dich umgehend im TeamSpeak Support ein.")
    end)
end)
    