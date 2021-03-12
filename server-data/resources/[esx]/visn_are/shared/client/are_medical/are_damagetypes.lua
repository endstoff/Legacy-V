--[[
-- Author: Tim 'veryinsanee' Plate
-- 
-- File: are_damagetypes.lua
-- 
-- Arguments: 
-- None
-- 
-- ReturnValue:
-- None
-- 
-- Example:
-- _exampleFunction(_exampleArgument)
-- 
-- Public: No
-- Copyright (c) 2020 Tim Plate
--]]

local _injuriesConfigRoot = ARE_MEDICAL_INJURIES

woundClassNames = {}
woundClassNamesComplex = {}
woundsData = {}
    
allDamageTypesData = {}

local _damageTypesConfig = _injuriesConfigRoot.damageTypes
local _thresholdsDefault = {}
local _selectionSpecificDefault = _damageTypesConfig.selectionSpecific

local _woundsConfig = _injuriesConfigRoot.wounds
local _classID = 0

function parseConfigForInjuries()

    for index, value in pairsByKeys(_woundsConfig) do
        local _entry = index
        local _className = value.className
    
        local _selections = value.selections or { "All" }
        local _bleeding = value.bleeding or 0
        local _pain = value.pain or 0
        local _minDamage = value.minDamage or 0
        local _maxDamage = value.maxDamage or -1
        local _causes = value.causes or {}
        local _causeLimping = (value.causeLimping or 0) == 1
        local _causeFracture = (value.causeFracture or 0) == 1
    
        if next(_causes) ~= nil then
            table.insert(woundClassNames, _className)
            table.insert(woundsData, {_classID, _selections, _bleeding, _pain, {_minDamage, _maxDamage}, _causes, _className, _causeLimping, _causeFracture})
    
            local types = {"Minior", "Medium", "Large"}
    
            for woundTypes = 1, #types do
                local complexString = '' .. _entry .. '' .. types[woundTypes]
                woundClassNamesComplex[10 * _classID .. types[woundTypes]] = complexString 
            end

            _classID = _classID + 1
        end
    end

    local _woundTypes = {}

    for index, value in pairsByKeys(_damageTypesConfig) do
        local _entry = index
    
        for i = 1, #woundsData do
            if has_value(woundsData[i][6], _entry) then
                if _woundTypes[woundsData[i][7]] == nil then
                    _woundTypes[woundsData[i][7]] = {}
                end
                
                table.insert(_woundTypes[woundsData[i][7]], _entry)
            end
        end

        allDamageTypesData[index] = value
    end
end
--[[

backblast
bullet
collision
drowning
explosive
falling
grenade
ropeburn

--]]