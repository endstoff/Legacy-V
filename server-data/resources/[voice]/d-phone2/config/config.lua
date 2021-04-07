Config                            = {}

Config.Locale             = 'de'

Config.Openkey = 288
Config.NeedItem = true

Config.CustomNotification = false
Config.MultiChar = false

-- If you're server is slow, make this higher
Config.StartupTime = 5000
Config.MysqlWaitingTime = 5000
Config.UserDataWaitingTime = 1000

-- ESX Events DONT TOUCH THIS IF YOU DONT EXACTLY KNOW WHAT THESE DOES
Config.esxgetSharedObjectevent = 'esx:getSharedObject'
Config.esxprefix = "esx:"
Config.esxprefix2 = "esx_"

-- Exports Config
Config.MumbleVoipFolderName = "mumble-voip"
Config.PMAVOICEFolderName = "pma-voice"
Config.SaltychatFolderName = 'saltychat'

-- Wallpaper
Config.backgroundurl = "https://cdn.discordapp.com/attachments/760982812223995945/809438584817713227/Legacy_Handy_Background.png"
Config.darkbackgroundurl = "https://cdn.discordapp.com/attachments/760982812223995945/809438584817713227/Legacy_Handy_Background.png"

--[[
Phone Numer
Nummer will be like [prefix-number]
The number will be randomly generated between the lower and higher number
]] 

Config.Prefix = true
-- Ignore this if Prefix = false
Config.LowerPrefix = 555
Config.HigherPrefix = 555

Config.LowerNumber = 10000
Config.HigherNumber = 99999

-- Voice Chat [only 1 can be true]
Config.TokoVoip = false
Config.PMAVoice = false
Config.MumbleVoip = false
Config.SaltyChat = true


-- Radio
Config.blockedchannels = 5 -- Number how much Channels are reserved for the listed fractions below

-- These Jobs have access to the blocked channels 
Config.Access = {
    {
        frequenz = 1,
        job = "police",
        joblabel = "LSPD"
    },
    {
        frequenz = 1,
        job = "ambulance",
        joblabel = "Ambulance"
    },

    {
        frequenz = 2,
        job = "police",
        joblabel = "LSPD"
    },
    {
        frequenz = 3,
        job = "ambulance",
        joblabel = "Ambulance"
    },
    {
        frequenz = 4,
        job = "ambulance",
        joblabel = "Ambulance"
    },
    {
        frequenz = 5,
        job = "ambulance",
        joblabel = "Ambulance"
    },
}


Config.Debug = false