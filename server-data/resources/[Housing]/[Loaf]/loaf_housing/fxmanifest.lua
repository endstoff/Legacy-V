fx_version 'adamant'
game 'gta5'
description 'ESX Housing'
version '0.9.0'

server_script 'license.lua'
server_script '@mysql-async/lib/MySQL.lua'
shared_script 'configuration/*.lua'
server_script 'server/*.lua'
client_script 'client/*.lua'

dependency 'es_extended'
dependency 'loaf_keysystem'
