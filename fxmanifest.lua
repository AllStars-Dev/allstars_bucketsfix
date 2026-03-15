fx_version 'cerulean'
game 'gta5'

author 'Ophak'
description 'Fix Instance'
version '2.0'

shared_script 'config.lua'

client_script 'client.lua'

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'server.lua'
}