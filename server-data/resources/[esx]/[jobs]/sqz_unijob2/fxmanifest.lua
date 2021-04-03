fx_version 'cerulean'

game 'gta5'

description 'SQZ unijob'

version '1.1.6'

server_scripts {
	'license.lua',
	'@mysql-async/lib/MySQL.lua',
	'@es_extended/locale.lua',
	'locales/*.lua',
	'config.lua',
	'server/edit.lua',
	'server/main.lua'
}

client_scripts {
	'@es_extended/locale.lua',
	'locales/*.lua',
	'config.lua',
	'client/edit.lua',
	'client/main.lua'
}

dependencies {
	'extendedmode',
	'esx_billing',
	'esx_menu_default'
}