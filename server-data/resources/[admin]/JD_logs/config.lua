Config = {}

Config.AllLogs = true											-- Enable/Disable All Logs Channel
Config.postal = false  											-- set to false if you want to disable nerest postal (https://forum.cfx.re/t/release-postal-code-map-minimap-new-improved-v1-2/147458)
Config.username = "System | Legacy-V" 							-- Bot Username
Config.avatar = "https://i.imgur.com/6wKJCFU.png"				-- Bot Avatar
Config.communtiyName = "Legacy-V Roleplay"						-- Icon top of the embed
Config.communtiyLogo = "https://i.imgur.com/6wKJCFU.png"		-- Icon top of the embed
Config.FooterText = "2021 © Legacy-V Roleplay"						-- Footer text for the embed
Config.FooterIcon = "https://i.imgur.com/6wKJCFU.png"			-- Footer icon for the embed


Config.weaponLog = true  			-- set to false to disable the shooting weapon logs
Config.InlineFields = true			-- set to false if you don't want the player details next to each other

Config.playerID = true				-- set to false to disable Player ID in the logs
Config.steamID = true				-- set to false to disable Steam ID in the logs
Config.steamURL = true				-- set to false to disable Steam URL in the logs
Config.discordID = true				-- set to false to disable Discord ID in the logs
Config.license = false				-- set to false to disable license in the logs
Config.IP = false					-- set to false to disable IP in the logs

-- Change color of the default embeds here
-- It used Decimal or Hex color codes. They will both work.
Config.BaseColors ={		-- For more info have a look at the docs: https://docs.preffech.com
	chat = "#A1A1A1",				-- Chat Message
	joins = "#3AF241",				-- Player Connecting
	leaving = "#F23A3A",			-- Player Disconnected
	deaths = "#000000",				-- Shooting a weapon
	shooting = "#2E66F2",			-- Player Died
	resources = "#EBEE3F",			-- Resource Stopped/Started	
}


Config.webhooks = {		-- For more info have a look at the docs: https://docs.preffech.com
	all = "DISCORD_WEBHOOK",		-- All logs will be send to this channel
	chat = "https://discord.com/api/webhooks/793252348625420298/33lx79vPoEOrTfgYQRq7G3wCPcA5S6FoR7VY4oKZqPyYskR6y1fSBJAB5YWYL_VKiDri",		-- Chat Message
	joins = "https://discord.com/api/webhooks/793252348625420298/33lx79vPoEOrTfgYQRq7G3wCPcA5S6FoR7VY4oKZqPyYskR6y1fSBJAB5YWYL_VKiDri",		-- Player Connecting
	leaving = "https://discord.com/api/webhooks/793252348625420298/33lx79vPoEOrTfgYQRq7G3wCPcA5S6FoR7VY4oKZqPyYskR6y1fSBJAB5YWYL_VKiDri",	-- Player Disconnected
	deaths = "https://discord.com/api/webhooks/793252348625420298/33lx79vPoEOrTfgYQRq7G3wCPcA5S6FoR7VY4oKZqPyYskR6y1fSBJAB5YWYL_VKiDri",		-- Shooting a weapon
	shooting = "https://discord.com/api/webhooks/808335181848379424/ovjAzKqcBlf-9KdLgelNo6hXlu3jkucabSGKq7w2ktrK8i6z-7soT79jg7IiC1j7Yd3Z",	-- Player Died
	resources = "https://discord.com/api/webhooks/831152915648348180/Qk7q8AP0SbwtbazSPfupoRujpJ1DRVDGKuOMx0C86oCfzKCO8GjFBxg_i-WjXt-QS3aa",	-- Resource Stopped/Started	
}

Config.TitleIcon = {		-- For more info have a look at the docs: https://docs.preffech.com
	chat = "💬",				-- Chat Message
	joins = "📥",				-- Player Connecting
	leaving = "📤",			-- Player Disconnected
	deaths = "💀",				-- Shooting a weapon
	shooting = "🔫",			-- Player Died
	resources = "🔧",			-- Resource Stopped/Started	
}


 --Debug shizzels :D
Config.debug = false
Config.versionCheck = "1.2.0"
