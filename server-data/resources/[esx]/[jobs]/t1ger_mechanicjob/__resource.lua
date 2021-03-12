-------------------------------------
------- Created by T1GER#9080 -------
------------------------------------- 

resource_manifest_version "44febabe-d386-4d18-afbe-5e627f4af937"
description 'T1GER Mechanic Job'
author 'T1GER#9080'
discord 'https://discord.gg/FdHkq5q'
whitelist 'Please open a ticket on my discord. Provide screenshot of order#, email and product'

server_scripts {
	'@mysql-async/lib/MySQL.lua',
	'language.lua',
	'config.lua',
	'server/server.lua',
	'server/protection_sv.lua'
}

client_scripts {
	'language.lua',
	'config.lua',
	'client/client.lua',
	'client/utils.lua'
}
