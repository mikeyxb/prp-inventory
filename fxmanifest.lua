fx_version 'cerulean'
use_experimental_fxv2_oal 'yes'
lua54 'yes'
game 'gta5'
name 'ox_inventory'
author 'Overextended'
version '2.44.1'
repository 'https://github.com/overextended/ox_inventory'
description 'Slot-based inventory with item metadata support'

dependencies {
    '/server:6116',
    '/onesync',
    'oxmysql',
    'ox_lib',
}

shared_scripts { '@ox_lib/init.lua', '@prp_lib/init.lua' }

ox_libs {
    'locale',
    'table',
    'math',
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'init.lua'
}

client_script 'init.lua'

ui_page 'web/build/index.html'

files {
    'metas/**/*.meta',
    'client.lua',
    'server.lua',
    'locales/*.json',
    'web/build/index.html',
    'web/build/**/*',
    'web/images/*.png',
    'modules/**/shared.lua',
    'modules/**/client.lua',
    'modules/bridge/**/client.lua',
    'data/*.lua',
}

data_file 'WEAPON_METADATA_FILE' 'metas/**/*_archetypes.meta'
data_file 'WEAPON_ANIMATIONS_FILE' 'metas/**/*_animation.meta'
data_file 'PED_PERSONALITY_FILE' 'metas/**/*_personality.meta'
data_file 'WEAPONINFO_FILE' 'metas/**/*_item.meta'