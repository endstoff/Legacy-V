fx_version 'cerulean'
games { 'gta5' }

client_scripts {
	'client/client.lua',
}

server_scripts {
    '@mysql-async/lib/MySQL.lua',
	'config.lua',
	'server/server.lua',
}

ui_page ('html/index.html')

files {
	'html/assets/fonts/bold.ttf',
	'html/assets/fonts/light.ttf',
	'html/assets/fonts/regular.ttf',
    'html/index.html',
    'html/assets/css/style.css',
    'html/assets/js/script.js',
}

