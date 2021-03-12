--[[
-- Author: Tim 'veryinsanee' Plate
-- 
-- File: are_debug.lua
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

debugMode = false

if debugMode then
    
    print('ARE: Debug Mode enabled, be careful!')

    RegisterCommand("are_blood", function()
        print('b: ', bloodLevel)
    end)
end