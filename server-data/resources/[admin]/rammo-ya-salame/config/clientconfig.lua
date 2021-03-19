print("^2 [MIXAS AntiCheat] ^5 ClientConfig Refresh ^0")
ClientConfig = {} 
ClientConfig.EMethods = true -- it blocks eulen (you cant start or restart scripts when server is on, which means you should wait until restart of server)
ClientConfig.EMethodCheck = 10000 -- default 10000 (we dont recommend you to change it)
ClientConfig.AntiStopper = true -- it blocks cheaters to stop scripts (when its on you cant stop scripts you should wait until restart of server)
ClientConfig.AntiSpectate = true -- Cheater cant spectate when its on (dont forget to add your admin's hex ids or licences to ServerConfig.Whitelist so they can spectate !)
ClientConfig.SpectateTime = 2000 -- don't change it
ClientConfig.FreeCamBlock = false -- Cheater cant freecam when its on (we recommend you to keep it false)
ClientConfig.FreecamX = 50 -- don't change it
ClientConfig.FreecamY = -50 -- don't change it
ClientConfig.FreeCamTime = 160000 -- don't change it
ClientConfig.DevToolNuiMethod = true -- Cheater cant open dev tool/nui when its on
ClientConfig.BlacklistKey = true --don't change it
ClientConfig.BlacklistKeyCoolDown = 60000 --don't change it
ClientConfig.BlacklistKeys = { -- you can add or remove blacklisted keys below // EDIT IT FOR YOUR SERVER !
 {key = 121, name = 'INSERT'},
 {key = 212, name = 'HOME'},
}
ClientConfig.Safe = true -- it blocks cheater to burn people
ClientConfig.AntiFreeze = true -- blocks anti-cheat getting stopped by cheaters(might cause trouble for +300 servers)
ClientConfig.WeaponBlacklist = true -- if true, you activate blacklisted weapon option. (we recommend you to keep it true)
ClientConfig.WeaponCheck = 4000 -- don't change it
ClientConfig.RemoveAllWeapons = true -- when it detects blacklisted weapon in player's or cheater's inventory it deletes all weapons on him (we recommend you to keep it true)
ClientConfig.BLWeaponLog = true -- it shows on logs(webhook on discord) use of blacklisted weapons
ClientConfig.BlacklistedWeapons = { -- you can add or remove blacklisted weapons below // EDIT IT FOR YOUR SERVER !
    GetHashKey("WEAPON_HAMMER"),
    GetHashKey("WEAPON_GOLFCLUB"),
    GetHashKey("WEAPON_SAWNOFFSHOTGUN"),
    GetHashKey("WEAPON_BULLPUPSHOTGUN"),
    GetHashKey("WEAPON_GRENADELAUNCHER"),
    GetHashKey("WEAPON_GRENADELAUNCHER_SMOKE"),
    GetHashKey("WEAPON_RPG"),
    GetHashKey("WEAPON_STINGER"),
    GetHashKey("WEAPON_MINIGUN"),
    GetHashKey("WEAPON_GRENADE"),
    GetHashKey("WEAPON_BALL"),
    GetHashKey("WEAPON_BOTTLE"),
    GetHashKey("WEAPON_HEAVYSHOTGUN"),
    GetHashKey("WEAPON_GARBAGEBAG"),
    GetHashKey("WEAPON_RAILGUN"),
    GetHashKey("WEAPON_RAILPISTOL"),
    GetHashKey("WEAPON_RAYPISTOL"), 
    GetHashKey("WEAPON_RAYCARBINE"), 
    GetHashKey("WEAPON_RAYMINIGUN"),
    GetHashKey("WEAPON_DIGISCANNER"),
    GetHashKey("WEAPON_SPECIALCARBINE_MK2"),
    GetHashKey("WEAPON_BULLPUPRIFLE_MK2"),
    GetHashKey("WEAPON_PUMPSHOTGUN_MK2"),
    GetHashKey("WEAPON_MARKSMANRIFLE_MK2"),
    GetHashKey("WEAPON_COMPACTLAUNCHER"),
--  GetHashKey("WEAPON_SNSPISTOL_MK2"),
    GetHashKey("WEAPON_REVOLVER_MK2"),
    GetHashKey("WEAPON_FIREWORK"),
    GetHashKey("WEAPON_HOMINGLAUNCHER"),
    GetHashKey("WEAPON_SMG_MK2")
}
--
ClientConfig.AntiExplosiveWeapons = true -- if true, you block explosive weapons
ClientConfig.AntiWeaponDamageModifier = true -- if true, cheater cant change damage of explosive weapons
ClientConfig.WeaponDamageTime = 10000 -- don't change it. 
ClientConfig.WeaponDamages = { -- here is a list of default damages of weapons, YOU CAN CHANGE IT IF YOU WANT
    [-1357824103] = 34, -- AdvancedRifle
    [453432689] = 26, -- Pistol
    [1593441988] = 27, -- CombatPistol
    [584646201] = 25, -- APPistol
    [-1716589765] = 51, -- Pistol50
    [-1045183535] = 160, -- Revolver
    [-1076751822] = 28, -- SNSPistol
    [-771403250] = 40, -- HeavyPistol
    [137902532] = 34, -- VintagePistol
    [324215364] = 21, -- MicroSMG
    [736523883] = 22, -- SMG
    [-270015777] = 23, -- AssaultSMG
    [-1121678507] = 22, -- MiniSMG
    [-619010992] = 27, -- MachinePistol
    [171789620] = 28, -- CombatPDW
    [487013001] = 29, -- PumpShotgun
    [2017895192] = 40, -- SawnoffShotgun
    [-494615257] = 32, -- AssaultShotgun
    [-1654528753] = 14, -- BullpupShotgun
    [984333226] = 117, -- HeavyShotgun
    [-1074790547] = 30, -- AssaultRifle
    [-2084633992] = 32, -- CarbineRifle
    [-1063057011] = 32, -- SpecialCarbine
    [2132975508] = 32, -- BullpupRifle
    [1649403952] = 34, -- CompactRifle
    [-1660422300] = 40, -- MG
    [2144741730] = 45, -- CombatMG
    [1627465347] = 34, -- Gusenberg
    [100416529] = 101, -- SniperRifle
    [205991906] = 216, -- HeavySniper
    [-952879014] = 65, -- MarksmanRifle
    [1119849093] = 30, -- Minigun
    [-1466123874] = 165, -- Musket
    [911657153] = 1, -- StunGun
    [1198879012] = 10, -- FlareGun
    [-598887786] = 220, -- MarksmanPistol
    [1834241177] = 30, -- Railgun
    [-275439685] = 30, -- DoubleBarrelShotgun
    [-1746263880] = 81, -- Double Action Revolver
    [-2009644972] = 30, -- SNS Pistol Mk II
    [-879347409] = 200, -- Heavy Revolver Mk II
    [-1768145561] = 32, -- Special Carbine Mk II
    [-2066285827] = 33, -- Bullpup Rifle Mk II
    [1432025498] = 32, -- Pump Shotgun Mk II
    [1785463520] = 75, -- Marksman Rifle Mk II
    [961495388] = 40, -- Assault Rifle Mk II
    [-86904375] = 33, -- Carbine Rifle Mk II
    [-608341376] = 47, -- Combat MG Mk II
    [177293209] = 230, -- Heavy Sniper Mk II
    [-1075685676] = 32, -- Pistol Mk II
    [2024373456] = 25, -- SMG Mk II
}