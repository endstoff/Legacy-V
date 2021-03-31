print("^2 [MIXAS AntiCheat] ^5 ServerConfig Refresh ^0")
ServerConfig = {}
ServerConfig.KickBanMessage = 'Cheating' -- You can edit the message when player gets kicked
ServerConfig.KickBanEmoji = '[🐒]' -- You can edit the message when player gets kicked
ServerConfig.BanSystem = true
ServerConfig.Webhook = "https://discord.com/api/webhooks/822492321596833862/mJAX0Fee4s2K80DY1ozmh2zQbGga3pi25TwQvP661VgYF72tmFW0EOgKr-H60mE-FIs6" -- You should create a text channel on discord and add it's webhook here
ServerConfig.BlacklistKeyWebhook = "https://discord.com/api/webhooks/822492321596833862/mJAX0Fee4s2K80DY1ozmh2zQbGga3pi25TwQvP661VgYF72tmFW0EOgKr-H60mE-FIs6" -- this is blacklist key log
ServerConfig.JoinLog = true -- Join log edit next line
ServerConfig.JoinLogWebhook = 'https://discord.com/api/webhooks/822492786929565706/2H63Gs7QVVx6UfwyPVbijwZ9hyKktpzI12MiWLAoquVaLfxAWOumJ6iWQHrobr6OKBV1' --this is blacklist join log
ServerConfig.ConfigRefreshCommand = 'acconfigrefresh' -- when you type this command to console it refresh your config without restarting your server (you can change the command if you want),
ServerConfig.DontTouch = -1 -- Don't touch [!!!!!!!]
ServerConfig.Whitelist = { --if you add player's hex id or license below they wil bypass the anti-cheat
"steam:110000113df958c", -- endstoff
"steam:11000013d1c551a", -- ixinzane
"steam:1100001032b0c37", -- gargani
"steam:1100001074f2d61", -- kaba
"steam:110000104034487", -- Hades
"steam:11000010e77bfb7", -- Terminal
"steam:11000010c661632", -- Alexadioz
}
ServerConfig.BlacklistNickname = true
ServerConfig.BlacklistNickNames = {
  "administrator", "admin", "adm1n", "adm!n", "admln", "moderator", "owner", "nigger", "n1gger", "moderator", "eulencheats", "lynxmenu", "atgmenu", "hacker", "bastard", "hamhaxia", "333gang", "ukrp", "eguk", "n1gger", "n1ga", "nigga", "n1gga", "nigg3r",
  "nig3r", "shagged", "4dm1n", "4dmin", "m0d3r4t0r", "n199er", "n1993r", "rustchance.com", "rustchance", "hellcase.com", "hellcase", "youtube.com", "youtu.be", "youtube", "twitch.tv", "twitch", "anticheat.gg", "anticheat", "fucking", "ψ", "@", "&", "{", "}", ";", "ϟ", "♕", "Æ", "Œ", "‰", "™", "š", "œ", "Ÿ", "µ", "ß",
  "±", "¦", "»", "«", "¼", "½", "¾", "¬", "¿", "Ñ", "®", "©", "²", "·", "•", "°", "þ",  "✪", "Ä", "ƒ", "Ã", "¢", "?", "†", "€", "웃", "и", "】", "【", "j4p.pl", "ֆ", "ȶ", "L͙", "a͙", "l͙", "ľ̶̚͝", "Ḩ̷̤͚̤͑͂̎̎͆", "a̸̢͉̠͎͒͌͐̑̇", "♚", "я", "Ʒ", "Ӂ̴", "Ƹ̴", "≋",
  "chocohax", "civilgamers.com", "civilgamers", "csgoempire.com", "csgoempire", "g4skins.com", "g4skins", "gameodds.gg", "duckfuck.com", "crysishosting.com", "crysishosting", "key-drop.com", "key-drop.pl", "skinhub.com", "skinhub", "`", "¤", "¡",
  "<",">"
}
ServerConfig.VPNBlock = true
ServerConfig.ClearPedTaskMethod = false -- Anti Kick Vehicle
ServerConfig.CPTMethodKick = false -- Anti Kick Vehicle KICK
ServerConfig.CPTMethodBan = false -- Anti Kick Vehicle BAN
ServerConfig.AntiExplosions = true 
ServerConfig.ExplosionKick = true
ServerConfig.ExplosionBan = false
ServerConfig.ExplosionDebug = true
ServerConfig.ExplosionsList = {
    [0] = { name = "Grenade", log = true, kick = true },
    [1] = { name = "GrenadeLauncher", log = true, kick = true },
    [2] = { name = "C4", log = true, kick = true },
   -- [3] = { name = "Molotov", log = true, kick = true },
    [4] = { name = "Rocket", log = true, kick = true },
    [5] = { name = "TankShell", log = true, kick = true},
  --  [6] = { name = "Hi_Octane", log = true, kick = true },
   -- [7] = { name = "Car", log = true, kick = true },
   -- [8] = { name = "Plance", log = true, kick = true },
    --[9] = { name = "PetrolPump", log = true, kick = true },
   -- [10] = { name = "Bike", log = true, kick = true },
   -- [11] = { name = "Dir_Steam", log = true, kick = true },
   -- [12] = { name = "Dir_Flame", log = true, kick = true },
   -- [13] = { name = "Dir_Water_Hydrant", log = false, kick = true },
   -- [14] = { name = "Dir_Gas_Canister", log = true, kick = true },
   -- [15] = { name = "Boat", log = true, kick = true },
    --[16] = { name = "Ship_Destroy", log = true, kick = true },
    --[17] = { name = "Truck", log = true, kick = true },
    [18] = { name = "Bullet", log = true, kick = true },
    [19] = { name = "SmokeGrenadeLauncher", log = true, kick = true },
   -- [20] = { name = "SmokeGrenade", log = true, kick = true },
   -- [21] = { name = "BZGAS", log = true, kick = true },
   --[22] = { name = "Flare", log = true, kick = true },
    --[23] = { name = "Gas_Canister", log = true, kick = true },
    --[24] = { name = "Extinguisher", log = true, kick = true },
    --[25] = { name = "Programmablear",log = true, kick = true },
    --[26] = { name = "Train", log = true, kick = true },
    --[27] = { name = "Barrel", log = true, kick = true },
    --[28] = { name = "PROPANE", log = true, kick = true },
    --[29] = { name = "Blimp", log = true, kick = true },
   -- [30] = { name = "Dir_Flame_Explode", log = true, kick = true },
   -- [31] = { name = "Tanker", log = true, kick = true },
    [32] = { name = "PlaneRocket", log = true, kick = true },
  --  [33] = { name = "VehicleBullet", kick = true },
   -- [34] = { name = "Gas_Tank", log = true, kick = true },
    --[35] = { name = "FireWork", log = true, kick = true },
    --[36] = { name = "SnowBall", log = true, kick = true },
    [37] = { name = "ProxMine", log = true, kick = true },
    [38] = { name = "Valkyrie_Cannon", log = true, kick = true },
    [70] = { name = "AutoMizer", log = true, kick = true }
}