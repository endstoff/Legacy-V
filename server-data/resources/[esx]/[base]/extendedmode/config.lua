Config = {}
Config.Locale = 'de'

Config.Accounts = {
	bank = _U('account_bank'),
	black_money = _U('account_black_money'),
	money = _U('account_money')
}

Config.FirstSpawnCoords = {x = -1035.2248535156, y = -2729.5324707031, z = 13.756646156311, heading = 325.5} -- first spawn coordinates

Config.StartingAccountMoney = {bank = 40000, money = 10000}

Config.EnableSocietyPayouts = true -- pay from the society account that the player is employed at? Requirement: esx_society
Config.DisableWantedLevel   = true
Config.EnableHud            = false -- enable the default hud? Display current job and accounts (black, bank & cash)
Config.EnablePvP            = true -- enable pvp?
Config.MaxWeight            = 10000   -- the max inventory weight without backpack(this is in grams, not kg!)

Config.PaycheckInterval     = 60 * 60000 -- how often to recieve pay checks in milliseconds

Config.EnableDebug          = true
Config.PrimaryIdentifier	= "steam" -- Options: steam, license (social club), fivem, discord, xbl, live (default steam, recommended: fivem) this SHOULD function with most older scripts too!

Config.Webhook				= "https://discord.com/api/webhooks/822564652071911504/CzbssF91erGtNWA52E8xzS7HNXXcJYNp2ewnRLDMnqz-hyDUMX4gi_LqHsKLwIoOPRA8"

-- The default player model you will use if no other scripts control your player model
-- We have set a MP ped as default since if you use another script that controls your player model
-- then this will make them invisible until the actual outfit/model has loaded, this looks better than
-- loading another model then changing it immediately after
Config.DefaultPlayerModel	= `mp_m_freemode_01` 

Config.DefaultPickupModel = `prop_money_bag_01`