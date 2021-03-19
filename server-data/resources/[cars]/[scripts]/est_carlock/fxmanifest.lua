fx_version 'cerulean'
games { 'gta5' }

client_scripts {
	"@extendedmode/locale.lua",
    "client/client.lua",
	'@mysql-async/lib/MySQL.lua'
}

server_scripts {
	"server/server.lua",
	'@extendedmode/locale.lua',
	'@mysql-async/lib/MySQL.lua'
	
}

