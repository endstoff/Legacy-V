print("^2 [MIXAS AntiCheat] ^5 TriggerConfig Refresh ^0")

TriggerConfig = {}
TriggerConfig.Blacklistevent = true -- if true = blocks all these events // we recommend you to keep it true
TriggerConfig.BlacklisteventBan = false -- if true = blocks all these events // we recommend you to keep it true
TriggerConfig.BlacklistedEvents = { -- you can add or remove events below
    "mellotrainer:adminKick",
    'antilynx8:anticheat',
    'antilynxr4:detect',
    'antilynxr6:detection',
    "HCheat:TempDisableDetection",
    'ynx8:anticheat',
    'antilynx8r4a:anticheat',
    'lynx8:anticheat',
    'AntiLynxR4:kick',
    'esx_spectate:kick',
    'AntiLynxR4:log',
    'chat:server:ServerPSA',
    'd0pamine_xyz:getFuckedNigger',
    'adminmenu:allowall',
    'esx_mafiajob:confiscatePlayerItem',
    'esx_jailer:sendToJail',
    'NB:recruterplayer',
    ':tunnel_req',
    'f0ba1292-b68d-4d95-8823-6230cdf282b6',
    'gambling:spend',
    'hentailover:xdlol',
    'OG_cuffs:cuffCheckNearest',
    'hentailover:xdlol',
    'display',
    'advancedFuel:setEssence',
    'esx:jackingcar'
}


TriggerConfig.ProtectEvent = true
TriggerConfig.ProtectEventKick = true
TriggerConfig.ProtectEventBan =  false
TriggerConfig.ProtectMaxAmount = 70000 
TriggerConfig.ProtectedEvents = { --cheat example ; example: TriggerServerEvent('esx_pizza:pay',250000000))
    "esx_fueldelivery:pay",
    "esx_carthief:pay",
    "esx_godirtyjob:pay",
    "esx_pizza:pay",
    "esx_ranger:pay",
    "esx_garbagejob:pay",
    "esx_truckerjob:pay",
    "AdminMenu:giveBank",
    "AdminMenu:giveCash",
    "esx_gopostaljob:pay",
    "esx_banksecurity:pay",
    "esx_slotmachine:sv:2",
    "esx_dmvschool:pay", 
    "esx_tankerjob:pay",
    "LegacyFuel:PayFuel",
}


--
TriggerConfig.AntiMessage = true
TriggerConfig.AntiMessageKick = true
TriggerConfig.AntiMessageBan =  false
TriggerConfig.MessageEvents = { -- Dont change it
"esx_policejob:message",
"esx_sheriffjob:message",
"esx_taxijob:message",
"esx_mechanicjob:message",
"esx_vehicleshop:message",
"esx_bankerjob:message",
"esx_unicornjob:message",
"esx_fibjob:message",
"esx_mafia:message",
"esx_truckerjob:message",
"esx_security:message",
"esx_traffic:message",
"esx_ranger:message",
"esx_cartel:message",
}
TriggerConfig.BlacklistedMessages = { -- If cheaters write blacklisted keywords they will get banned
    "MIXAS",
}

TriggerConfig.PhoneMessageTrigger = 'gcPhone:sendMessage' --you can add or remove events on phone's **message** system below (key words to avoid ads etc.)
TriggerConfig.PhoneBLMessage = false
TriggerConfig.PhoneBLMessages = { --
    'discord.gg',
    'roleplay',
    'anticheat',
    '.com',
    'ROLEPLAY',
    'Discord',
}
--
TriggerConfig.PhoneTwitterTrigger = 'gcPhone:twitter_postTweets' --you can add or remove events on phone's **tweet** below (key words to avoid ads etc.)
TriggerConfig.PhoneBLTweet = true
TriggerConfig.PhoneBLTweets = {
    'discord',
    'atg',
    'roleplay',
    'anticheat',
    'Discord',
}
--
TriggerConfig.PhoneYellowTrigger = 'gcPhone:yellow_postPagess' --you can add or remove events on phone's **yellow pages** below (key words to avoid ads etc.)
TriggerConfig.PhoneBLYellow = true
TriggerConfig.PhoneBLYellows = {
    'discord',
    'atg',
    'roleplay',
    'anticheat',
    'Discord',
}