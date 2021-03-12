function AddTextEntry(key, value)
	Citizen.InvokeNative(GetHashKey("ADD_TEXT_ENTRY"), key, value)
end

Citizen.CreateThread(function()
AddTextEntry('FE_THDR_GTAO', '~b~Legacy-V ~w~Roleplay ~w~| ~o~discord.gg/Cut6WeR~w~ | ~r~ID: ' .. GetPlayerServerId(PlayerId()) .. ' ~w~| ~r~Name: ~r~' .. GetPlayerName(PlayerId()))
end)