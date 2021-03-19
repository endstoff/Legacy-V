fx_version 'adamant'
games { 'gta5' }

author 'Philipp Decker'
description 'Attach vehicles to other vehicles!'
version '1.5'

files {
    'config.ini',
    'transportData.json'
}

server_scripts {
    'server.lua'
}

client_scripts {
    'Newtonsoft.Json.dll',
    'Kiminaze_FiveM_FileHandler.net.dll',
    'Kiminaze_VehicleTransport_Client.net.dll'
}
