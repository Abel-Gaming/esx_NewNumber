fx_version 'cerulean'
game 'gta5'
description 'ESX New Number - Change your existing phone number!'
author 'Abel Gaming'
version '1.0'

server_scripts {
	'@mysql-async/lib/MySQL.lua',
	'config.lua',
	'server/main.lua'
}

client_scripts {
	'config.lua',
	'client/main.lua'
}
