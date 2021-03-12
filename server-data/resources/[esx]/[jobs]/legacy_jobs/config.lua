Jobs = {
    ["Schlachter"] = {
        jobRequired = false,
        jobName = "schlachter",
        location = { 
            [1] = { --collect
                coords = vector3(-67.091247558594,6247.3525390625,31.087303161621),
                blip = {
                    showBlip = true,
                    blipName = "Schlachter | Sammeln",
                    sprite = 475,
                    color = 8,
                    scale = 0.65,
                },
                marker = {
                    enable = true,
                    size  = { x = 0.7, y = 0.7, z = 0.4 },
                    color = { r = 255, g = 0, b = 0 },
                    type  = 2
                },
                draw3dtext = {
                    enable = true,
                    text = "Drücke~g~E ~w~um Hähnchen zu sammeln",
                },
                item = {
                    process = "pickup", --dont touch

                    itemName = "lebendes_huhn",
                    addCount = 1,
                },                
                animation = {
                    enable = true,
                    animationFunction = function(ped)
                        animDict = "mp_car_bomb"
                        animName = "car_bomb_mechanic"
                        Citizen.CreateThread(function() 
                            RequestAnimDict(animDict) 
                            while not HasAnimDictLoaded(animDict) do Citizen.Wait(10) end 
                            TaskPlayAnim(ped, animDict, animName, 8.0, -8, -1, 49, 0, 0, 0, 0)
                        end)
                    end,
                },
                progressbar = {
                    enable = true,
                    progText = "Sammeln...", 
                    duration = 5000 
                }
            },
            [2] = { --process
                coords = vector3(-101.75285339355, 6208.5317382812, 31.025020599365), 
                blip = {
                    showBlip = true,
                    blipName = "Schlachter | Verarbeiten",
                    sprite = 475, 
                    color = 8,
                    scale = 0.65,
                },
                marker = {
                    enable = true,
                    size  = { x = 0.7, y = 0.7, z = 0.4 },
                    color = { r = 204, g = 204, b = 0 },
                    type  = 2
                },
                draw3dtext = {
                    enable = true,
                    text = "Drücke~g~E ~w~um Hühnchen zu verarbeiten",
                },
                item = {
                    process = "exchange", --dont touch
                    
                    addCount = 1,
                    itemName = "geschlachtetes_huhn",
                    
                    removeCount = 1,
                    requiredItem = "lebendes_huhn",
                },
                animation = {
                    enable = true,
                    animationFunction = function(ped)
                        animDict = "mp_car_bomb"
                        animName = "car_bomb_mechanic"
                        Citizen.CreateThread(function()
                            RequestAnimDict(animDict) 
                            while not HasAnimDictLoaded(animDict) do Citizen.Wait(10) end
                            TaskPlayAnim(ped, animDict, animName, 8.0, -8, -1, 49, 0, 0, 0, 0)
                        end)
                    end,
                },
                progressbar = {
                    enable = true,
                    progText = "Verarbeiten...",
                    duration = 5000
                }
            },
            [3] = { --package
                coords = 
                    vector3(-158.23475646973, 6154.40234375, 31.206380844116),
                blip = {
                    showBlip = true,
                    blipName = "Schlachter | Abpacken",
                    sprite = 475, 
                    color = 8,
                    scale = 0.65,
                },
                marker = {
                    enable = true,
                    size  = { x = 0.7, y = 0.7, z = 0.4 },
                    color = { r = 204, g = 204, b = 0 },
                    type  = 2
                },
                draw3dtext = {
                    enable = true,
                    text = "Drücke~g~E ~w~um geschlachtete Hühner zu verpacken",
                },
                item = {
                    process = "package", --dont touch

                    addCount = 1,
                    itemName = "verpacktes_huhn",

                    removeCount = 1,
                    requiredItem = "geschlachtetes_huhn", 
                },
                animation = {
                    enable = true,
                    animationFunction = function(ped)
                        animDict = "mp_arresting"
                        animName = "arrested_spin_l_0"
                        Citizen.CreateThread(function()
                            RequestAnimDict(animDict) 
                            while not HasAnimDictLoaded(animDict) do Citizen.Wait(10) end
                            TaskPlayAnim(ped, mp_arresting, arrested_spin_l_0, 8.0, -8, -1, 49, 0, 0, 0, 0)
                        end)
                    end,
                },
                progressbar = {
                    enable = true,
                    progText = "Abpacken...",
                    duration = 5000
                }
            }
            --[[
            [4] = { --sell
                coords = vector3(1177.7438964844, 3592.576171875, 33.646907806396), 
                blip = {
                    showBlip = true,
                    blipName = "Schlachter | Verkaufen",
                    sprite = 475, 
                    color = 8,
                    scale = 0.65,
                },
                marker = {
                    enable = true,
                    size  = { x = 0.7, y = 0.7, z = 0.4 },
                    color = { r = 204, g = 204, b = 0 },
                    type  = 2
                },
                draw3dtext = {
                    enable = true,
                    text = "Press~g~E ~w~for sell packaged chickens",
                },
                item = {
                    process = "sell", --dont touch

                    removeCount = 1,
                    requiredItem = "packaged_chicken",
                    price = 100
                },
                animation = {
                    enable = true,
                    animationFunction = function(ped)
                        animDict = "mp_car_bomb"
                        animName = "car_bomb_mechanic"
                        Citizen.CreateThread(function()
                            RequestAnimDict(animDict) while not HasAnimDictLoaded(animDict) do Citizen.Wait(10) end
                            TaskPlayAnim(ped, animDict, animName, 8.0, -8, -1, 49, 0, 0, 0, 0)
                        end)
                    end,
                },
                progressbar = {
                    enable = true,
                    progText = "Selling...",
                    duration = 5000
                }
            }]]
        },
    },
}