resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

description 'DRP Whitelist'

version '1.0'

server_scripts {
	'@mysql-async/lib/MySQL.lua',
	'locale.lua', -- Credit es_extended
	'locales/*.lua',
	'config.lua',
	'server/server.lua'
}

client_script 'gate.lua'