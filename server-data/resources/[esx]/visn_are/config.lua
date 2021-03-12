ConfigData = {}

ConfigData.respawnTimer = 900 -- The unconscious timer (in seconds)
ConfigData.primaryLanguage = "de" -- Language
ConfigData.sharedObjectName = "esx:getSharedObject" -- Shared object (editable for anticheat)
ConfigData.bindPulseToHealthBar = false -- Binds the pulse to the health bar
ConfigData.enableBloodDrops = true -- Enables blood drops. (Could affect server performance)
ConfigData.recoveryAnimation = false -- Enables the animation after revive.
ConfigData.activateLimpWalkingStyle = false -- Activates the limp walking style, if legs are hurt.
ConfigData.modifierKey = 74 -- H | https://docs.fivem.net/docs/game-references/controls/
ConfigData.mainKey = 182 -- L | https://docs.fivem.net/docs/game-references/controls/
ConfigData.bindBloodLooseOnPulse = true -- If the heart rate is higher, the player will lose more blood
ConfigData.maxMiscObjects = 50 -- The limit of the ground objects (bandages, syringes, blood drops)
ConfigData.tazerDamage = false -- When enabled, tazer will damage the person.
ConfigData.vehicleRadius = 7.0 -- Vehicle-Search-Radius of putInVehicle-Event. 
ConfigData.painTimeout = 600 -- Seconds
ConfigData.needSewedWounds = true -- Should wounds needed to be sewed?
ConfigData.sewTimeout = 600 -- Seconds; When does a sew randomly open again?
ConfigData.bleedReasons = { -- Reasons that should start bleeding. ("vehicle_hit", "fall_damage", "weapon_damage", "punch_damage")
    "vehicle_hit",
    "fall_damage",
    "weapon_damage",
    "punch_damage"
}
ConfigData.activatedReasons = { -- Reasons that should hurt the player. ("vehicle_hit", "fall_damage", "weapon_damage", "punch_damage")
    "vehicle_hit",
    "fall_damage",
    "weapon_damage", 
    "punch_damage"
}
ConfigData.startDamageTimer = 5000 -- Timer after join, after timer end, damage can be taken. READ: This is important for incorrect positions spawns.
ConfigData.flashScreens = { -- Activated flashing screens ("pain", "bleeding")
    "pain",
    "bleeding"
}