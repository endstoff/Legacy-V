resource_manifest_version '77731fab-63ca-442c-a67b-abc70f28dfa5'

ui_page 'html/index.html'

client_scripts {
	'@es_extended/locale.lua',
  'client/*.lua',
}

server_scripts {
  'server/server.lua',
}


files {
  'html/*.css',
  'html/utils/*.css',
  'html/utils/css/*.css',
  'html/*.js',
  'html/utils/*.js',
  'html/utils/js/*.js',
  'html/utils/fonts/*.ttf',
  'html/index.html'
}
