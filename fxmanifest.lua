fx_version 'cerulean'
game 'gta5'

description 'Collection of small scripts'
repository 'https://github.com/Qbox-project/qbx-smallresources'
version '1.1.0'

shared_scripts {
	'@qbx-core/import.lua',
	'@ox_lib/init.lua',
	'config.lua'
}

server_script 'server/*.lua'
client_script 'client/*.lua'

data_file 'FIVEM_LOVES_YOU_4B38E96CC036038F' 'events.meta'
data_file 'FIVEM_LOVES_YOU_341B23A2F0E0F131' 'popgroups.ymt'

files {
	'events.meta',
	'popgroups.ymt',
	'relationships.dat'
}

modules {
	'qbx-core:core',
	'qbx-core:playerdata',
	'qbx-core:utils'
}

lua54 'yes'
use_experimental_fxv2_oal 'yes'
