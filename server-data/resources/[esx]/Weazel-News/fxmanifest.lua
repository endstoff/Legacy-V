fx_version 'cerulean'
game 'gta5'

version '1.0'

client_scripts {
	'@es_extended/locale.lua',
	'locales/*.lua',
	'config.lua',
	'client/main.lua',
}

server_scripts {
	'@es_extended/locale.lua',
    'locales/*.lua',
	'config.lua',
	'server/main.lua',
}

