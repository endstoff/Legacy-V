---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by Dylan Malandain.
--- DateTime: 20/12/2019 22:32
---
fx_version 'adamant'
games { 'gta5' };

name 'NativeUILua-Reloaded'
description 'NativeUILua-Reloaded is UI library for FiveM designed specifically for making interface based on GTA:Online style. (Base source: https://github.com/FrazzIe/NativeUILua ) | (Base NativeUI : https://github.com/Guad/NativeUI) '

contributor {
    'Dylan Malandain',
    'Parow',
    'Frazzle'
};

--[[
client_scripts {
    "src/Wrapper/*.lua",
    "src/UIElements/*.lua",
}

client_scripts {
    "src/UIMenu/elements/*.lua",
    "src/UIMenu/items/*.lua",
    "src/UIMenu/windows/*.lua",
    "src/UIMenu/panels/*.lua",
    "src/UIMenu/*.lua",
}

client_scripts {
    'src/UITimerBar/*.lua',
    'src/UITimerBar/items/*.lua',
}

client_scripts {
    'src/UIProgressBar/*.lua',
    'src/UIProgressBar/items/*.lua',
}
]]--

client_scripts {
    "src/NativeUI.lua",
    "src/NativeUIReloaded.lua",
}

