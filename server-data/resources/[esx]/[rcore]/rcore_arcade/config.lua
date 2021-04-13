Config = {}

-- Which translation you wish to use ?
Config.Locale = "de"

-- Key settings
Config.keyToOpenTicketMenu = "E"
Config.keyToOpenComputer = "E"

-- Marker for buying ticket
Config.Arcade = {
    {
        NPC = {
            position = vector3(334.21588134766, -914.10571289062, 28.256311416626),
            heading = 91.0,
            model = "ig_claypain",
        },
        blip = {
            position = vector3(336.29302978516, -910.58044433594, 29.256328582764),
            blipId = 521,
            scale = 0.8,
            color = 0,
            name = "Cyber Bar",
            shortRange = true,
            enable = true,
        },
        marker = {
            markerPosition = vector3(332.80502319336, -914.15405273438, 28.25145149231),
            markerType = 23,
            options = {
                scale = { x = 1.0, y = 1.0, z = 1.0 },
                color = { r = 255, g = 255, b = 255, a = 125 },
            }
        },
    },
}

-- ticket price, and time in arcade.
Config.ticketPrice = {
    [_U("bronz")] = {
        price = 300,
        time = 15, -- in minutes
    },
    [_U("silver")] = {
        price = 600,
        time = 30, -- in minutes
    },
    [_U("gold")] = {
        price = 900,
        time = 60, -- in minutes
    },
}

-- is arcade payed ?
Config.enableGameHouse = true
-- do not change unless you know what you're doing
Config.GPUList = {
    [1] = "ETX2080",
    [2] = "ETX1050",
    [3] = "ETX660",
}

-- do not change unless you know what you're doing
Config.CPUList = {
    [1] = "U9_9900",
    [2] = "U7_8700",
    [3] = "U3_6300",
    [4] = "BENTIUM",
}

Config.MyList = {
    {
        name = "Agario",
        link = "https://agar.io/#ffa",
    },
}

-- game list for retro machine
Config.RetroMachine = {
    {
        name = "Pacman",
        link = "http://xogos.robinko.eu/PACMAN/",
    },
    {
        name = "Tetris",
        link = "http://xogos.robinko.eu/TETRIS/",
    },
    {
        name = "Ping Pong",
        link = "http://xogos.robinko.eu/PONG/",
    },
    {
        name = "DOOM",
        link = string.format("nui://rcore_arcade/html/msdos.html?url=%s&params=%s", "https://www.retrogames.cz/dos/zip/Doom.zip", "./DOOM.EXE"),
    },
    {
        name = "Duke Nukem 3D",
        link = string.format("nui://rcore_arcade/html/msdos.html?url=%s&params=%s", "https://www.retrogames.cz/dos/zip/duke3d.zip", "./DUKE3D.EXE"),
    },
    {
        name = "Wolfenstein 3D",
        link = string.format("nui://rcore_arcade/html/msdos.html?url=%s&params=%s", "https://www.retrogames.cz/dos/zip/Wolfenstein3D.zip", "./WOLF3D.EXE"),
    },
    {
        name = "CHAMP Kong",
        link = string.format("nui://rcore_arcade/html/msdos.html?url=%s&params=%s", "https://dosgames.com/files/ckong11.zip", "./CKONG.EXE"),
    },
}

-- game list for gaming machine
Config.GamingMachine = {
    {
        name = "Slide a Lama",
        link = "http://lama.robinko.eu/fullscreen.html",
    },
    {
        name = "Uno",
        link = "http://uno.robinko.eu",
    },
    {
        name = "Ants",
        link = "http://ants.robinko.eu/fullscreen.html",
    },
    {
        name = "FlappyParrot",
        link = "http://xogos.robinko.eu/FlappyParrot/",
    },
    {
        name = "Zoopaloola",
        link = "http://zoopaloola.robinko.eu/Embed/fullscreen.html"
    },
}

-- game list for super computer
Config.SuperMachine = {}

for i = 1, #Config.RetroMachine do
    table.insert(Config.SuperMachine, Config.RetroMachine[i])
end

for i = 1, #Config.GamingMachine do
    table.insert(Config.SuperMachine, Config.GamingMachine[i])
end

-- computer list in world
Config.computerList = {
    -- Retro machines
    {
        -- if false player dont need a ticket to play on this computer.
        isInGamingHouse = true,
        computerType = Config.RetroMachine,
        computerGPU = Config.GPUList[2],
        computerCPU = Config.CPUList[2],
        markerType = 31,
        position = vector3(328.34579467773, -927.96997070312, 29.251455307007),
        markerOptions = {
            scale = { x = 0.5, y = 0.5, z = 0.5 },
            color = { r = 255, g = 255, b = 255, a = 125 },
            rotate = true,
        },
    },
    {
        -- if false player dont need a ticket to play on this computer.
        isInGamingHouse = true,
        computerType = Config.RetroMachine,
        computerGPU = Config.GPUList[2],
        computerCPU = Config.CPUList[2],
        markerType = 31,
        position = vector3(328.23654174805, -927.09399414062, 29.251455307007),
        markerOptions = {
            scale = { x = 0.5, y = 0.5, z = 0.5 },
            color = { r = 255, g = 255, b = 255, a = 125 },
            rotate = true,
        },
    },
    {
        -- if false player dont need a ticket to play on this computer.
        isInGamingHouse = true,
        computerType = Config.RetroMachine,
        computerGPU = Config.GPUList[2],
        computerCPU = Config.CPUList[2],
        markerType = 31,
        position = vector3(328.30624389648, -926.27514648438, 29.251455307007),
        markerOptions = {
            scale = { x = 0.5, y = 0.5, z = 0.5 },
            color = { r = 255, g = 255, b = 255, a = 125 },
            rotate = true,
        },
    },
    {
        -- if false player dont need a ticket to play on this computer.
        isInGamingHouse = true,
        computerType = Config.RetroMachine,
        computerGPU = Config.GPUList[2],
        computerCPU = Config.CPUList[2],
        markerType = 31,
        position = vector3(328.27966308594, -925.37658691406, 29.25145149231),
        markerOptions = {
            scale = { x = 0.5, y = 0.5, z = 0.5 },
            color = { r = 255, g = 255, b = 255, a = 125 },
            rotate = true,
        },
    },
    {
        -- if false player dont need a ticket to play on this computer.
        isInGamingHouse = true,
        computerType = Config.RetroMachine,
        computerGPU = Config.GPUList[2],
        computerCPU = Config.CPUList[2],
        markerType = 31,
        position = vector3(323.75939941406, -919.87585449219, 29.251453399658),
        markerOptions = {
            scale = { x = 0.5, y = 0.5, z = 0.5 },
            color = { r = 255, g = 255, b = 255, a = 125 },
            rotate = true,
        },
    },
    {
        -- if false player dont need a ticket to play on this computer.
        isInGamingHouse = true,
        computerType = Config.RetroMachine,
        computerGPU = Config.GPUList[2],
        computerCPU = Config.CPUList[2],
        markerType = 31,
        position = vector3(323.79229736328, -916.56091308594, 29.251453399658),
        markerOptions = {
            scale = { x = 0.5, y = 0.5, z = 0.5 },
            color = { r = 255, g = 255, b = 255, a = 125 },
            rotate = true,
        },
    },
    {
        -- if false player dont need a ticket to play on this computer.
        isInGamingHouse = true,
        computerType = Config.RetroMachine,
        computerGPU = Config.GPUList[2],
        computerCPU = Config.CPUList[2],
        markerType = 31,
        position = vector3(323.69464111328, -915.671875, 29.251453399658),
        markerOptions = {
            scale = { x = 0.5, y = 0.5, z = 0.5 },
            color = { r = 255, g = 255, b = 255, a = 125 },
            rotate = true,
        },
    },
    {
        -- if false player dont need a ticket to play on this computer.
        isInGamingHouse = true,
        computerType = Config.RetroMachine,
        computerGPU = Config.GPUList[2],
        computerCPU = Config.CPUList[2],
        markerType = 31,
        position = vector3(323.74554443359, -914.74365234375, 29.251449584961),
        markerOptions = {
            scale = { x = 0.5, y = 0.5, z = 0.5 },
            color = { r = 255, g = 255, b = 255, a = 125 },
            rotate = true,
        },
    },
    {
        -- if false player dont need a ticket to play on this computer.
        isInGamingHouse = true,
        computerType = Config.RetroMachine,
        computerGPU = Config.GPUList[2],
        computerCPU = Config.CPUList[2],
        markerType = 31,
        position = vector3(324.98297119141, -912.95721435547, 29.251449584961),
        markerOptions = {
            scale = { x = 0.5, y = 0.5, z = 0.5 },
            color = { r = 255, g = 255, b = 255, a = 125 },
            rotate = true,
        },
    },
    {
        -- if false player dont need a ticket to play on this computer.
        isInGamingHouse = true,
        computerType = Config.RetroMachine,
        computerGPU = Config.GPUList[2],
        computerCPU = Config.CPUList[2],
        markerType = 31,
        position = vector3(325.86044311523, -912.94183349609, 29.251449584961),
        markerOptions = {
            scale = { x = 0.5, y = 0.5, z = 0.5 },
            color = { r = 255, g = 255, b = 255, a = 125 },
            rotate = true,
        },
    },
    {
        -- if false player dont need a ticket to play on this computer.
        isInGamingHouse = true,
        computerType = Config.RetroMachine,
        computerGPU = Config.GPUList[2],
        computerCPU = Config.CPUList[2],
        markerType = 31,
        position = vector3(326.75, -912.97381591797, 29.251449584961),
        markerOptions = {
            scale = { x = 0.5, y = 0.5, z = 0.5 },
            color = { r = 255, g = 255, b = 255, a = 125 },
            rotate = true,
        },
    },

    -- Gaming computers
    {
        -- if false player dont need a ticket to play on this computer.
        isInGamingHouse = true,
        computerType = Config.GamingMachine,
        computerGPU = Config.GPUList[2],
        computerCPU = Config.CPUList[2],
        markerType = 42,
        position = vector3(325.33648681641, -903.78497314453, 29.251434326172),
        markerOptions = {
            scale = { x = 0.5, y = 0.5, z = 0.5 },
            color = { r = 125, g = 125, b = 255, a = 125 },
            rotate = true,
        },
    },
    {
        -- if false player dont need a ticket to play on this computer.
        isInGamingHouse = true,
        computerType = Config.GamingMachine,
        computerGPU = Config.GPUList[2],
        computerCPU = Config.CPUList[2],
        markerType = 42,
        position = vector3(326.92846679688, -903.91119384766, 29.251434326172),
        markerOptions = {
            scale = { x = 0.5, y = 0.5, z = 0.5 },
            color = { r = 125, g = 125, b = 255, a = 125 },
            rotate = true,
        },
    },
    {
        -- if false player dont need a ticket to play on this computer.
        isInGamingHouse = true,
        computerType = Config.GamingMachine,
        computerGPU = Config.GPUList[2],
        computerCPU = Config.CPUList[2],
        markerType = 42,
        position = vector3(328.57745361328, -903.96630859375, 29.251434326172),
        markerOptions = {
            scale = { x = 0.5, y = 0.5, z = 0.5 },
            color = { r = 125, g = 125, b = 255, a = 125 },
            rotate = true,
        },
    },
    {
        -- if false player dont need a ticket to play on this computer.
        isInGamingHouse = true,
        computerType = Config.GamingMachine,
        computerGPU = Config.GPUList[2],
        computerCPU = Config.CPUList[2],
        markerType = 42,
        position = vector3(330.33126831055, -903.91009521484, 29.501438140869),
        markerOptions = {
            scale = { x = 0.5, y = 0.5, z = 0.5 },
            color = { r = 125, g = 125, b = 255, a = 125 },
            rotate = true,
        },
    },
    {
        -- if false player dont need a ticket to play on this computer.
        isInGamingHouse = true,
        computerType = Config.GamingMachine,
        computerGPU = Config.GPUList[2],
        computerCPU = Config.CPUList[2],
        markerType = 42,
        position = vector3(331.97485351562, -904.00592041016, 29.501438140869),
        markerOptions = {
            scale = { x = 0.5, y = 0.5, z = 0.5 },
            color = { r = 125, g = 125, b = 255, a = 125 },
            rotate = true,
        },
    },
    {
        -- if false player dont need a ticket to play on this computer.
        isInGamingHouse = true,
        computerType = Config.GamingMachine,
        computerGPU = Config.GPUList[2],
        computerCPU = Config.CPUList[2],
        markerType = 42,
        position = vector3(337.53778076172, -902.59698486328, 29.501438140869),
        markerOptions = {
            scale = { x = 0.5, y = 0.5, z = 0.5 },
            color = { r = 125, g = 125, b = 255, a = 125 },
            rotate = true,
        },
    },
    {
        -- if false player dont need a ticket to play on this computer.
        isInGamingHouse = true,
        computerType = Config.GamingMachine,
        computerGPU = Config.GPUList[2],
        computerCPU = Config.CPUList[2],
        markerType = 42,
        position = vector3(339.16830444336, -902.76885986328, 29.501438140869),
        markerOptions = {
            scale = { x = 0.5, y = 0.5, z = 0.5 },
            color = { r = 125, g = 125, b = 255, a = 125 },
            rotate = true,
        },
    },
    {
        -- if false player dont need a ticket to play on this computer.
        isInGamingHouse = true,
        computerType = Config.GamingMachine,
        computerGPU = Config.GPUList[2],
        computerCPU = Config.CPUList[2],
        markerType = 42,
        position = vector3(340.95275878906, -902.779296875, 29.501438140869),
        markerOptions = {
            scale = { x = 0.5, y = 0.5, z = 0.5 },
            color = { r = 125, g = 125, b = 255, a = 125 },
            rotate = true,
        },
    },
    {
        -- if false player dont need a ticket to play on this computer.
        isInGamingHouse = true,
        computerType = Config.GamingMachine,
        computerGPU = Config.GPUList[2],
        computerCPU = Config.CPUList[2],
        markerType = 42,
        position = vector3(342.45178222656, -902.83117675781, 29.501438140869),
        markerOptions = {
            scale = { x = 0.5, y = 0.5, z = 0.5 },
            color = { r = 125, g = 125, b = 255, a = 125 },
            rotate = true,
        },
    },
    {
        -- if false player dont need a ticket to play on this computer.
        isInGamingHouse = true,
        computerType = Config.GamingMachine,
        computerGPU = Config.GPUList[2],
        computerCPU = Config.CPUList[2],
        markerType = 42,
        position = vector3(344.24072265625, -902.75537109375, 29.501438140869),
        markerOptions = {
            scale = { x = 0.5, y = 0.5, z = 0.5 },
            color = { r = 125, g = 125, b = 255, a = 125 },
            rotate = true,
        },
    },
    -- Super machines
}