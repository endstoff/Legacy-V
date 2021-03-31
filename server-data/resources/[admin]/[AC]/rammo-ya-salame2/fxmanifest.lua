fx_version 'adamant'
games {'gta5'}

client_scripts {
	'config/clientconfig.lua',
	'entities.lua',
	'config/language.lua',
	'client.lua',
} 

server_scripts {
	'config/triggerconfig.lua',
	'config/serverconfig.lua',
	'config/entityconfig.lua',
	'config/language.lua',
	'server.lua',
	'server2.lua'
}
ui_page 'index.html'
files {
'index.html',
'js/index.js',
'config/config.js'
}