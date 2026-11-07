fx_version 'cerulean'
game 'gta5'
lua54 'yes'

name 'pigeon-population'
author 'Pigeon Studios'
description 'Sets how many NPCs, cars and parked vehicles GTA spawns, by zone and time of day, plus garbage trucks, boats and distant traffic.'
version '1.0.0'
repository 'https://github.com/pigeon-studios-uk/pigeon-population'

-- Pigeon Studios version registry entry, read by server/version_check.lua.
pigeon_slug 'pigeon-population'

client_scripts {
    'configuration/config.lua',
    'client/main.lua',
}

server_scripts {
    'server/version_check.lua',
}
