local _break = "<br>"
local linestrike = "<hr>"

function color(color, text) return "<font color="..color..">"..text.."</font>" end
function underlined(text) return "<u>"..text.."</u>" end
function bold(text) return "<strong>"..text.."</strong>" end
function small(text) return "<small>"..text.."</small>" end
function strikethrough(text) return "<del>"..text.."</del>" end
function italic(text) return "<i>"..text.."</i>" end
function big(text) return "<big>"..text.."</big>" end

RegisterCommand("krieg", function(source, args)
    local argString = table.concat(args, " ")
    if argString ~= nil then
        TriggerClientEvent('est_notify-broadcast:display', -1, 'Kriegsvertrag',  argString, 15000)
    end
end, true)

RegisterServerEvent('gebietnotify')
AddEventHandler("gebietnotify", function(gang, gebiet)
    TriggerClientEvent('est_notify-broadcast:display', -1, 'Gebietseinnahme',  "Die Fraktion "..gang.." nimmt nun das Gebiet "..gebiet.. " ein.", 14000)
end)

RegisterServerEvent('winnotify')
AddEventHandler("winnotify", function(gang, gebiet)
    TriggerClientEvent('est_notify-broadcast:display', -1, 'Gebietseinnahme',  "Die Fraktion "..gang.." hat das Gebiet "..gebiet.. " erfolgreich eingenommen.", 14000)
end)