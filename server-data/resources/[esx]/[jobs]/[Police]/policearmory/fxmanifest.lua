fx_version 'adamant'

game 'gta5'

description 'Waffenkammer - edit by endstoff'
version '1.3.0'

client_scripts {
    "config.lua",
    "client/main.lua"
}

server_scripts {
    "@mysql-async/lib/MySQL.lua",
    "config.lua",
    "server/main.lua"
}

client_script 'gate.lua'