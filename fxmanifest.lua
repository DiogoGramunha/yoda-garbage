fx_version 'cerulean'
lua54 'yes'
game 'gta5'

name 'yoda_garbage'
author 'YodaThings'
version '1.4.0'

shared_scripts {
	'@ox_lib/init.lua',
	'config.lua',
	'shared/init.lua',
}

files {
    'locales/*.json',
    'modules/**/client.lua',
    'modules/bridge/**/client.lua',
}

client_script 'client/client.lua'

server_script 'server/server.lua'

dependencies { 'ox_lib' }
