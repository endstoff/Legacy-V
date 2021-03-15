fx_version 'adamant'
game 'gta5'

description 'ESX Mechanic Job edit by endstoff for Unity-V'

version '1.1.0'

client_scripts {
	'@es_extended/locale.lua',
	'locales/*.lua',
	'config.lua',
	'client/main.lua'
}

server_scripts {
	'@es_extended/locale.lua',
	'locales/*.lua',
	'config.lua',
	'server/main.lua'
}

dependencies {
	'es_extended',
	'esx_society',
	'esx_billing'
}


client_script 'gate.lua'