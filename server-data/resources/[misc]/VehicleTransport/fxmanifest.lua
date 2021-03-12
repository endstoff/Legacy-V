fx_version 'adamant'
games { 'gta5' }

author 'Philipp Decker'
description 'Attach vehicles to other vehicles!'
version '1.0.0'

files {
    'config.ini',
    'transportData.json'
}

server_scripts {
    'Kiminaze_VehicleTransport_Shared.net.dll',
    'Kiminaze_VehicleTransport_Server.net.dll'
}

client_scripts {
    'Newtonsoft.Json.dll',
    'Kiminaze_FiveM_FileHandler.net.dll',
    'Kiminaze_VehicleTransport_Shared.net.dll',
    'Kiminaze_VehicleTransport.net.dll'
}
