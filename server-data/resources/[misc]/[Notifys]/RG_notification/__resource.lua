resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

ui_page {
    'html/ui.html',
}

files {
	'html/ui.html',
	'html/js/app.js', 
	'html/css/style.css',
}

client_scripts {
	'client/main.lua'
}

server_scripts {
	'server/main.lua'
}

dependencies {
	'essentialmode',
	'async'
}
