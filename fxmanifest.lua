fx_version 'cerulean'
game 'gta5'

author 'BL Scripts'
description 'Vehicle Lock System (QB/ESX/Standalone)'
version '1.0.0'

lua54 'yes'

shared_script '@ox_lib/init.lua'

shared_scripts {
    'config/config.lua',  -- Your configuration file
    'locales/en.lua',      -- Language/Localization file
    '@bl_lib/lib.lua',     -- Libary of Functions
}

client_scripts {
    'client/main.lua',    -- Main client script
    'client/target.lua',   -- (If you are using target interactions)
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',  -- Database support (if using MySQL)
    'server/main.lua',           -- Main server script
}

dependencies {
    'bl_lib',           -- Required for custom functionality
}
