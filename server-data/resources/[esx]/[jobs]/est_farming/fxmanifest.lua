fx_version 'cerulean'
games { 'gta5' }

description 'est_farming by endstoff'

version '1.0'

server_scripts {
	'@mysql-async/lib/MySQL.lua',
	'@es_extended/locale.lua',
	'locales/*.lua',
	'config.lua',
	'server/main.lua',
--	'server/coke.lua',
--	'server/lsd.lua',
--	'server/meth.lua',
	'server/kuh.lua',
--	'server/heroin.lua',
--	'server/chemicals.lua',
--	'server/licenseshop.lua',
--	'server/moneywash.lua',
}

client_scripts {
	'@es_extended/locale.lua',
	'locales/*.lua',
	'config.lua',
	'client/main.lua',
	'client/kuh.lua',
--	'client/meth.lua',
--	'client/coke.lua',
--	'client/lsd.lua',
--	'client/heroin.lua',
--	'client/chemicals.lua',
--	'client/hydrochloricacid.lua',
--	'client/sodiumhydroxide.lua',
--	'client/sulfuricacid.lua',
--	'client/licenseshop.lua',
--	'client/moneywash.lua',
--	'client/teleport.lua',
}

dependencies {
	'extendedmode'
}
