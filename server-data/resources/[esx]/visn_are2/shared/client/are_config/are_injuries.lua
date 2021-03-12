--[[
-- Author: Tim 'veryinsanee' Plate
-- 
-- File: are_injuries.lua
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

-- CURRENTLY NOT IN USE!

ARE_MEDICAL_INJURIES = {}

ARE_MEDICAL_INJURIES = {

    wounds = {
        ["abrasion"] = {
            className = "abrasion",
            causes = { "falling", "ropeburn", "vehiclecrash", "collision", "unknown" },
            bleeding = 0.001,
            pain = 0.4,
            minDamage = 0.01,
            maxDamage = 0.30,
        },

        ["avulsion"] = {
            className = "avulsion",
            causes = { "explosive", "vehiclecrash", "collision", "grenade", "shell", "bullet", "backblast", "bite" },
            bleeding = 0.1,
            pain = 1.0,
            minDamage = 0.01,
            causeLimping = 1;
        },

        ["contusion"] = {
            className = "contusion",
            causes = { "bullet", "backblast", "punch", "vehiclecrash", "collision", "falling" },
            bleeding = 0,
            pain = 0.3,
            minDamage = 0.02,
            maxDamage = 0.35,
        },

        ["crush"] = {
            className = "crush",
            causes = { "falling", "vehiclecrash", "collision", "punch", "unknown" },
            bleeding = 0.05,
            pain = 0.8,
            minDamage = 0.1,
        },

        ["cut"] = {
            className = "cut",
            causes = { "vehiclecrash", "collision", "grenade", "explosive", "shell", "backblast", "stab", "unknown" },
            bleeding = 0.01,
            pain = 0.1,
            minDamage = 0.1,
        },

        ["laceration"] = {
            className = "laceration",
            causes = { "vehiclecrash", "collision", "punch" },
            bleeding = 0.05,
            pain = 0.2,
            minDamage = 0.01,
        },

        ["velocitywound"] = {
            className = "velocitywound",
            causes = { "bullet", "grenade", "explosive", "shell", "unknown" },
            bleeding = 0.2,
            pain = 0.9,
            minDamage = 0.35,
            causeLimping = 1,
            causeFracture = 1,
        },

        ["puncturewound"] = {
            className = "puncturewound",
            causes = { "stab", "grenade" },
            bleeding = 0.05,
            pain = 0.4,
            minDamage = 0.02,
            causeLimping = 1,
        },
    },

    damageTypes = {
        thresholds = {{0.1, 1}},
        selectionSpecific = 1,

        ["bullet"] = {
            thresholds = {{0.1, 1}},
            selectionSpecific = 1,
        },

        ["explosive"] = {
            thresholds = {{1, 6}, {0.1, 4}, {0, 1}},
            selectionSpecific = 0,
        },

        ["vehiclecrash"] = {
            thresholds = {{1.5, 3}, {1, 2}, {0.05, 1}},
            selectionSpecific = 0,
        },

        ["collision"] = {
            thresholds = {{1.5, 3}, {1, 2}, {0.05, 1}},
            selectionSpecific = 0,
        },

        ["stab"] = {
            thresholds = {{0.1, 1}},
            selectionSpecific = 1,
        },

        ["punch"] = {
            thresholds = {{0.05, 1}},
            selectionSpecific = 0,
        },

        ["falling"] = {
            thresholds = {{1.5, 3}, {1, 2}, {0.05, 1}},
            selectionSpecific = 0,
        },

        ["drowning"] = {
            thresholds = {{0, 0}},
        },

        ["unknown"] = {
            thresholds = {{0.1, 1}},
        },
    }
}