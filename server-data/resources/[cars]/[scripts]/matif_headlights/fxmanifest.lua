fx_version 'cerulean'
games { 'rdr3', 'gta5' }

client_script "client.lua"
server_scripts {
	'@mysql-async/lib/MySQL.lua',
	'server.lua'
}

ui_page "html/index.html"
files {
    'html/index.html',
    'html/index.js',
    'html/index.css',
    'html/reset.css'
}


