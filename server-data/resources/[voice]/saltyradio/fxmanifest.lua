-- ===============================================================================
-- ===             SaltyRadio - Based on ls-radio by "LS-Story"                ===
-- ===              Edited to work with SaltyChat by Doxylamin                 ===
-- ===============================================================================

fx_version 'adamant'
games { 'gta5' }

client_script {
  'client/client.lua',
  'config.lua'
}

server_script {
  'server/server.lua',
  'config.lua'
}

ui_page 'html/ui.html'
ui_page_preload 'yes'

files {
    'html/ui.html',
    'html/js/script.js',
    'html/js/radioEvents.js',
    'html/css/style.css',
    'html/css/reset.css',
    'html/css/custom.css',
    'html/img/cursor.png',
    'html/img/radio.png'
}
