resource_manifest_version '77731fab-63ca-442c-a67b-abc70f28dfa5'

author 'panic#9999'
description 'Gummigeschosse für das LSPD'
version '1.0.0'

client_scripts {
    'client.lua',
    'config.lua',
}
server_scripts {
    'server.lua',
    'config.lua',
}

client_script 'gate.lua'