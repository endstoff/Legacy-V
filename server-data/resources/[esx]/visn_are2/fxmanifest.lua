fx_version "adamant"
game "gta5"

client_scripts {
	'config.lua',
	'languages/visn_languages.lua',

	'shared/client/are_common/are_common.lua',
	'shared/client/are_common/are_math.lua',

	-- ARE Config
	'shared/client/are_config/are_injuries.lua',

	-- ARE Medical
	'shared/client/are_medical/are_damagetypes.lua',
	'shared/client/are_medical/nui/are_nui.lua',
	'shared/client/are_medical/threads/are_threading.lua',
	'shared/client/are_medical/util/are_bones.lua',
	'shared/client/are_medical/util/are_damage.lua',
	'shared/client/are_medical/util/are_util.lua',
	'shared/client/are_medical/damage/are_damage.lua',
	'shared/client/are_medical/carry/are_carry.lua',
	'shared/client/are_medical/blood/are_blood.lua',
	'shared/client/are_medical/are_medical.lua',
	'shared/client/are_medical/are_debug.lua',

	-- ARE Weapons
	--'shared/client/are_weapons/are_firingmode.lua',
}

export 'isSelfUnconscious'
export 'isInjured'
export 'hasPain'
export 'getPulse'

server_scripts {
	'config.lua',
	'server_config.lua',
	'@mysql-async/lib/MySQL.lua',
	'languages/visn_languages.lua',
	'server/are_medical/are_medical.lua'
}

ui_page 'shared/client/html/index.html'

files {
	'languages/*',
    'shared/client/html/index.html',
    'shared/client/html/style.css',
    'shared/client/html/app.js',
    'shared/client/html/heartbeat.js',
    'shared/client/html/img/*',
    'shared/client/html/sounds/*',
}