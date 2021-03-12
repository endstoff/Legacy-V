local _break = "<br>"
local linestrike = "<hr>"

function color(color, text) return "<font color="..color..">"..text.."</font>" end
function underlined(text) return "<u>"..text.."</u>" end
function bold(text) return "<strong>"..text.."</strong>" end
function small(text) return "<small>"..text.."</small>" end
function strikethrough(text) return "<del>"..text.."</del>" end
function italic(text) return "<i>"..text.."</i>" end
function big(text) return "<big>"..text.."</big>" end

RegisterCommand("announce", function(source, args)
    local argString = table.concat(args, " ")
    if argString ~= nil then
        TriggerClientEvent('est_notify-broadcast:display', -1, 'Ankündigung',  argString, 14000)
    end
end, true)