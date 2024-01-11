
fx_version 'cerulean'
lua54 'yes'
games { 'rdr3', 'gta5' }
rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'
author 'DirkScripts discord.gg/dirkscripts'
description 'Allow change of players names by authorised jobs'
version '1.0.0'

shared_script '@ox_lib/init.lua'

shared_script{
  'usersettings/config.lua',
  'usersettings/labels.lua',
  'src/init.lua',
}

client_script {
  'src/client.lua',
}

server_script {
  'src/server.lua',
}

dependencies {
  'dirk-core',
}

escrow_ignore{
  'INSTALLATION/*.*',
  'INSTALLATION/**/*.*',
  'INSTALLATION/**/**/*.*',
  'usersettings/config.lua',
  'usersettings/labels.lua',
}
