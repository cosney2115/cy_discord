fx_version 'cerulean'
game 'gta5'

server_scripts {
    'websocket/*.js',
    'http/main.lua',
    'structures/Channel.lua',
    'structures/Message.lua',
    'structures/Interaction.lua',
    'client/*.lua',
    'events/*.lua',


    -- examples
    'examples/*.lua',
}

server_only 'yes'
lua54 'yes'

use_experimental_fxv2_oal 'yes'
