Config = {}

Config.HideMinimapOnOpen = false
Config.SlotsNumber = 5

--[[
    UseAnywhere

    If you set this to true a command /wardrobe will be available
    to every user and below locations will not be used.

    If you set this to false, the /wardrobe command
    will be available only to admins and wardrobe will be able
    to be opened by users at the locations defined in the table below.
--]]
Config.UseAnywhere = false
Config.DisplayBlips = false
Config.Locations = {
    -- default locations
    vector3(71.133514404297, -1387.5958251953, 29.376136779785),    -- Davis
    vector3(429.87768554688, -811.76489257812, 29.491144180298),      -- Binco PD
    vector3(-819.89770507812, -1067.2989501953, 11.328083992004),      -- Vinewood
    vector3(1698.7994384766, 4817.9794921875, 42.063125610352)         -- Grapeseed
}