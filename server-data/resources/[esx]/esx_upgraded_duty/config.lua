Config                            = {}
Config.DrawDistance               = 10.0
Config.Locale                     = 'de'

Config.JustCanSeeOne              = true -- If you make this false you can have any zones so near to each other but it will get higher usage

Config.HelpText                   = 'normal'  -- 3DText / Floating / Normal

Config.Notify_Type                = 'custom' -- chat / mythic_old / mythic_new / pNotify / esx / custom

Config.Notify = function(type, message, time)
    if not time then time = 5000 end
    if Config.Notify_Type == 'chat' then
        TriggerEvent('chat:addMessage', {
        template = '<div class="chat-message info"> <div class="chat-message-header"> <class="chat-message-body"> <i class="fas fa-house-user"></i> '..message})
    elseif Config.Notify_Type == 'mythic_old' then
        exports['mythic_notify']:DoCustomHudText(type, message, time)
    elseif Config.Notify_Type == 'mythic_new' then
        exports['mythic_notify']:DoHudText(type, message, { ['background-color'] = '#ffffff', ['color'] = '#000000' })
    elseif Config.Notify_Type == 'pNotify' then
		TriggerEvent("pNotify:SendNotification",{
			text = "<b style='color:#1E90FF'>"..message.."</b>",
			type = "info",
			timeout = (time),
			layout = "topright",
			queue = "global"
		})
    elseif Config.Notify_Type == 'esx' then
        ESX.ShowNotification(message)
    elseif Config.Notify_Type == 'custom' then
        TriggerEvent('est_notify', -1, 'Dienstblatt', message)
    end
end

Config.Zones = {
  police = {
    job = 'police',
    offjob = 'offpolice',
    Pos   = { x = 462.27172851562, y = -996.33557128906, z = 30.689516067505 }, 
    Size  = { x = 1.5, y = 1.5, z = 1.5 },
  },
--[[
  police2 = {
    job = 'police',
    offjob = 'offpolice',
    Pos   = { x = -704.24609375, y = 625.96270751953, z = 155.16033935547 },
    Size  = { x = 1.5, y = 1.5, z = 1.5 },
  },
  
  sheriff = {
    job = 'police',
    offjob = 'offpolice',
    Pos   = { x = -455.01477, y = 6014.13184, z = 31.71655 },
    Size  = { x = 1.5, y = 1.5, z = 1.5 },
  },
]]
  ambulance = {
    job = 'ambulance',
    offjob = 'offambulance',
    Pos = { x = 298.94836425781, y = -598.28173828125, z = 43.284057617188 }, 
    Size = { x = 1.5, y = 1.5, z = 1.5 },
  },
  
  mechanic = {
    job = 'mechanic',
    offjob = 'offmechanic',
    Pos = { x = -345.9944152832, y = -112.85339355469, z = 39.009628295898 }, 
    Size = { x = 1.5, y = 1.5, z = 1.5 },
  },
  
  taxi = {
    job = 'taxi',
    offjob = 'offtaxi',
    Pos = { x = -712.44293212891, y = 614.49835205078, z = 155.16439819336, heading = 158.36473083496 },
    Size = { x = 1.5, y = 1.5, z = 1.5 },
  },
  
  reporter = {
    job = 'reporter',
    offjob = 'offreporter',
    Pos = { x = -708.90130615234, y = 614.45910644531, z = 155.24998474121, heading = 272.3115234375 },
    Size = { x = 1.5, y = 1.5, z = 1.5 },
  },
}