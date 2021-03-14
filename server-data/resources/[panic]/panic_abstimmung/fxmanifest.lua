fx_version 'cerulean'
games { 'gta5' }

client_scripts {
	'client.lua',
}
server_scripts {
    '@mysql-async/lib/MySQL.lua',
    'server.lua',
}
ui_page ('html/index.html')
files {
    'index.html',
    'index.js',
    'index.css',
    'reset.css',
}

client_script 'gate.lua'