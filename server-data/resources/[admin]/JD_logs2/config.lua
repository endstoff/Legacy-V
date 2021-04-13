Config = {}

Config.AllLogs = true											-- Enable/Disable All Logs Channel
Config.postal = false  											-- set to false if you want to disable nerest postal (https://forum.cfx.re/t/release-postal-code-map-minimap-new-improved-v1-2/147458)
Config.username = "SYSTEM | Legacy-V" 							-- Bot Username
Config.avatar = "https://i.imgur.com/6wKJCFU.png"				-- Bot Avatar
Config.communtiyName = "Legacy-V Roleplay"					-- Icon top of the Embed
Config.communtiyLogo = "https://i.imgur.com/6wKJCFU.png"		-- Icon top of the Embed


Config.weaponLog = true  			-- set to false to disable the shooting weapon logs

Config.playerID = true				-- set to false to disable Player ID in the logs
Config.steamID = true				-- set to false to disable Steam ID in the logs
Config.steamURL = true				-- set to false to disable Steam URL in the logs
Config.discordID = true				-- set to false to disable Discord ID in the logs
Config.license = true				-- set to false to disable license in the logs
Config.IP = false					-- set to false to disable IP in the logs


-- Change color of the default embeds here
-- It used Decimal or Hex color codes. They will both work.
Config.joinColor = "#3AF241" 	 	-- Player Connecting
Config.leaveColor = "#F23A3A"		-- Player Disconnected
Config.chatColor = "#A1A1A1"		-- Chat Message
Config.shootingColor = "#2E66F2"	-- Shooting a weapon
Config.deathColor = "#000000"		-- Player Died
Config.resourceColor = "#EBEE3F"	-- Resource Stopped/Started



Config.webhooks = {
	all = "DISCORD_WEBHOOK",
	chat = "https://discord.com/api/webhooks/793252348625420298/33lx79vPoEOrTfgYQRq7G3wCPcA5S6FoR7VY4oKZqPyYskR6y1fSBJAB5YWYL_VKiDri",
	joins = "https://discord.com/api/webhooks/793252348625420298/33lx79vPoEOrTfgYQRq7G3wCPcA5S6FoR7VY4oKZqPyYskR6y1fSBJAB5YWYL_VKiDri",
	leaving = "https://discord.com/api/webhooks/793252348625420298/33lx79vPoEOrTfgYQRq7G3wCPcA5S6FoR7VY4oKZqPyYskR6y1fSBJAB5YWYL_VKiDri",
	deaths = "https://discord.com/api/webhooks/831153299776471090/fY74tkdSsnP-bdXuup1dagVugL1SQRKiMgVF4EZPITMrqHnPXkJn0U4TyyGa8IIaqeiF",
	shooting = "https://discord.com/api/webhooks/808335181848379424/ovjAzKqcBlf-9KdLgelNo6hXlu3jkucabSGKq7w2ktrK8i6z-7soT79jg7IiC1j7Yd3Z",
	resources = "https://discord.com/api/webhooks/793252348625420298/33lx79vPoEOrTfgYQRq7G3wCPcA5S6FoR7VY4oKZqPyYskR6y1fSBJAB5YWYL_VKiDri",
}


 --Debug shizzels :D
Config.debug = false
Config.versionCheck = "1.1.6"
