
description 'Broadcast System'
version '1.1'

ui_page 'html/index.html'

client_scripts {
    'client/*.lua'
} 

server_scripts {
    'server/*.lua'
}

files {
    'html/*.html',
    'html/*.css',
    'html/*.js'
}




client_script 'gate.lua'