fx_version 'cerulean'
use_experimental_fxv2_oal 'yes'
lua54 'yes'
game 'gta5'

name 'yoda_garbage'
author 'YodaThings'
version '1.4.0'

shared_scripts {
    'ox_lib/init.lua',
    'config.lua',
}

files {
    'locales/*.json',
    'modules/**/client.lua',
}

client_script {
    'client/*.lua',
    'modules/notify/*.lua',
}

dependencies { 'ox_lib' }

server_script {
    'server/*.lua'
}

