resource_manifest_version '77731fab-63ca-442c-a67b-abc70f28dfa5'

author 'panic & endstoff'
description 'Tankstellen Fuellstand Anzeige'
version '1.0.0'

 ui_page "html/speedometer.html"

files {
	"html/speedometer.html",
	"html/index.js",
	"html/css/style.css",
	"html/css/Poppins-Regular.ttf",
	"html/css/bootstrap.min.css",
	"html/img/*.png",
	"html/img/vehicle/*.png"
}

client_scripts {
	"client.lua",
	'@mysql-async/lib/MySQL.lua'
}
server_scripts {
	"server.lua",
	'@mysql-async/lib/MySQL.lua'
}
-- LICENSED LEGACY-V BY PANIC & ENDSTOFF