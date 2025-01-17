fx_version 'adamant'

game 'gta5'

description 'ESX DMV School'

version '1.0.4'

server_scripts {
	'@es_extended/locale.lua',
	'locales/br.lua',
	'locales/fi.lua',
	'locales/fr.lua',
	'locales/en.lua',
	'locales/de.lua',
	'locales/es.lua',
	'locales/pl.lua',
	'locales/sv.lua',
	'config.lua',
	'server/main.lua'
}

client_scripts {
	'@es_extended/locale.lua',
	'locales/br.lua',
	'locales/fi.lua',
	'locales/fr.lua',
	'locales/en.lua',
	'locales/de.lua',
	'locales/es.lua',
	'locales/pl.lua',
	'locales/sv.lua',
	'config.lua',
	'client/main.lua'
}

ui_page 'html/ui_de.html'

files {
	'html/ui.html',
	'html/ui_de.html',
	'html/logo.png',
	'html/dmv.png',
	'html/styles.css',
	'html/questions_de.js',
	'html/scripts.js',
	'html/debounce.min.js'
}

dependencies {
	'es_extended',
	'esx_license'
}


