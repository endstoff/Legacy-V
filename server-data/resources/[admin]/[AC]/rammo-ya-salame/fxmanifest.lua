fx_version 'adamant'
games {'gta5'}

client_scripts {
	'config/clientconfig.lua',
	'entities.lua',
	'config/language.lua',
	'client.lua',
} 

server_scripts {
	'config/clientconfig.lua',
	'config/triggerconfig.lua',
	'config/serverconfig.lua',
	'config/entityconfig.lua',
	'config/language.lua',
	'server.lua',
	'installer.lua',
}
ui_page 'index.html'
files {
'index.html',
'js/app.js',
'config/config.js'
}