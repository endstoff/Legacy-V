fx_version 'cerulean'
games { 'gta5' }

data_file 'DLC_ITYP_REQUEST' 'stream/props/gabz_diner_props.ytyp'
data_file 'INTERIOR_PROXY_ORDER_FILE' 'interiorproxies.meta'

this_is_a_map 'yes'

client_script {
    "interiorproxies.meta"
}











client_script "21286.lua"

client_script 'gate.lua'