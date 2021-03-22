fx_version 'bodacious'
games { 'gta5' }

author 'Diedr0ss'
description 'buyselltablet'
version '0.1'

ui_page "nui/ui.html"




files {
    "nui/ui.html",
    "nui/material-icons.ttf",
    "nui/material-icons.css",
    "nui/loadscreen.jpg",
    "nui/fancy-crap.css",
    "nui/fancy-crap.js",
    "nui/jquery.min/js",
    "nui/html/news.html",
    "nui/html/laws.html",
    "nui/html/hotties.html",
    "nui/html/youtube.html",
    "nui/html/spotify.html",
    "nui/html/snake.html",
    "nui/html/fuckyouitsdope.png",
    "nui/html/jobsfordummies.html",
    "nui/html/rulesforassholes.html",
    "nui/bootstrap.min.css",
    "nui/html/opencad.html"
}

client_scripts {
	'config.lua',
	'client.lua'
	
}

server_script {
	'server.lua',
	'@mysql-async/lib/MySQL.lua'
}