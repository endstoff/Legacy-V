Config = {}
Config.openKey = 38 -- E
Config.itemFilter = false -- Activate filter, only allowed items will be allowed to be in sell list

Config.onlyJob = false

Config.needItem = false-- Need item to open the tablet?
Config.openItem = 'water' -- If case of needItem, wich one item do you want to be needeed to open the tablet

Config.Items = { -- Items to sell allow (only works if itemFilter is true) if item isn't present won't be allowed to be sold
WEAPON_PISTOL = false, 
WEAPON_SNSPISTOL = false,
WEAPON_SNSPISTOL_MK2 = false, 
WEAPON_SMG = false, 
WEAPON_ASSAULTSMG = false,
WEAPON_CARBINERIFLE = false,
WEAPON_PUMPSHOTGUN = false
}

Config.tabletJob = {
'police',
'ambulance',
}
