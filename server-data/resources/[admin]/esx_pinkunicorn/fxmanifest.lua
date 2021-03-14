fx_version 'adamant'

game 'gta5'

description 'RTX ANTICHEAT'

version '4.2'

server_scripts {
	'@mysql-async/lib/MySQL.lua',
	'server/gate.lua',
	'server/config.lua',
	'server/main.lua',
	'server/other.lua'
}

client_scripts {
	'client/config.lua',
	'client/main.lua',
	'client/loops.lua',
	'client/gate.lua',
}