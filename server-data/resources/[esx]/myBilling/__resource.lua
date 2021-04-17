resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

ui_page('html/index.html')

client_scripts {
	'@NativeUI/NativeUI.lua',
	'config.lua',
	'client.lua',
}

server_scripts {
	'@mysql-async/lib/MySQL.lua',
	'config.lua',
	'server.lua',
}

files {
	'html/index.html',
	'html/css/fontawesome.css',
	'html/css/style.css',
	'html/img/background.png',
	'html/img/logo.png',
	'html/js/jquery-3.5.1.min.js',
	'html/js/script.js',
	'html/webfonts/fa-brands-400.eot',
	'html/webfonts/fa-brands-400.svg',
	'html/webfonts/fa-brands-400.tff',
	'html/webfonts/fa-brands-400.woff',
	'html/webfonts/fa-brands-400.woff2',

	'html/webfonts/fa-regular-400.eot',
	'html/webfonts/fa-regular-400.svg',
	'html/webfonts/fa-regular-400.tff',
	'html/webfonts/fa-regular-400.woff',
	'html/webfonts/fa-regular-400.woff2',

	'html/webfonts/fa-solid-900.eot',
	'html/webfonts/fa-solid-900.svg',
	'html/webfonts/fa-solid-900.tff',
	'html/webfonts/fa-solid-900.woff',
	'html/webfonts/fa-solid-900.woff2',
} 