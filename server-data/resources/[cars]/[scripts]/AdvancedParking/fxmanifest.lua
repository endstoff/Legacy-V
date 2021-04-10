fx_version 'cerulean'
games { 'gta5' }

author 'Philipp Decker'
description 'Park all your vehicles anywhere!'
version '2.4.0'

server_scripts {
	'@mysql-async/lib/MySQL.lua',
	'config.lua',
	'sv_utils.lua',
	'server.lua'
}

client_scripts {
	'config.lua',
	'cl_utils.lua',
	'client.lua'
}
