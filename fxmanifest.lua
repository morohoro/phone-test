fx_version 'adamant'
game 'gta5'
lua54 'yes'

author 'ASL'
description 'Phonebooth'
version '1.0'
  
shared_scripts {
  '@ox_lib/init.lua',
  'config.lua',
} 

server_scripts {
  'server/main.lua',
}

client_scripts {
  'client/main.lua',
}

lua54 'yes'