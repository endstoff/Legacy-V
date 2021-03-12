Config = {}

--[[
Welchen job braucht man für..?
Falls Feature nicht erwünscht:
Nein = nil
]]
-- Für CopNet:
Config.CopNetJob = {'police'}
-- Für MedicNet:
Config.MedicNetJob = {'ambulance'}
-- Für CarNet:
Config.CarNetJob = {'cardealer'}

--[[
Welchen Item braucht man um das Tablet öffnen zu können..?
Falls Feature nicht erwünscht:
Nein = nil
]]
Config.NeededItem = nil

--[[
Animation beim öffnen des Tablets?
Ja = true
Nein = false
]]
Config.Animation = true

--[[
Befehl "/copnet"?
Ja = true
Nein = false
]]
Config.Commands = false

--[[
Entscheidet was beim nutzen des Befehls geöffnet wird:
'tab' für das Tablet
'pc' für den PC
]]
Config.CommandOpenType = 'tab'

--[[
Hotkey fürs Tablet?
Ja = Taste Beispiel: 'F10'
Nein = nil
]]
-- Für CopNet:
Config.Hotkey = 'F10' 
-- Für MedicNet:
Config.MedicHotkey = 'F9'
-- Für CarNet:
Config.CarHotkey = 'F7'

--[[
Entscheidet was beim nutzen des Hotkeys geöffnet wird:
'tab' für das Tablet
'pc' für den PC
]]
Config.HotkeyOpenType = 'tab'

--[[
Man soll das Tablet nur in eine Fahrzeug öffnen können?
Ja = true
Nein = false
]]
Config.OnlyInVehicle = false

--[[
Man soll das Tablet nur in eine Dienstfahrzeug öffnen können? (Fahrzeug muss in der Emergency Class sein)
Diese Funktion funktioniert nur, wenn Config.OnlyInVehicle "true" ist.
Ja = true
Nein = false
]]
Config.InEmergencyVehicle = false

--[[
Entscheidet was beim nutzen des Tablets im Auto geöffnet wird:
Diese Funktion funktioniert nur, wenn Config.OnlyInVehicle "true" ist.
'tab' für das Tablet
'pc' für den PC
]]
Config.VehicleOpenType = 'tab'

--[[
Aktiviert das "Autoscaling" des Uis:
Einfach gesagt: Tablet klein, PC groß.
Ja = true
Nein = false

! WICHTIG ! 
Beim Tablet können manche Knöpfe und/oder Textfelder nicht erreichbar sein!
Das passiert, da das Tablet nicht für die kleine Ansicht ausgelegt ist!
! WICHTIG !
]]
Config.AutoScale = false

--[[
Liste an Fahrzeugen in denen das Tablet geöffnet werden kann.
Wenn die Tabelle leer ist, ist die Funktion deaktiviert. Fahrzeug Spawnname oder Hashwert angeben.
Diese Funktion funktioniert nur, wenn Config.OnlyInVehicle "true" ist.
]]
Config.Vehicles = {
    ['cop'] = {
        'police',
        -1627000575
    },

    ['medic'] = {
    },

    ['car'] = {
    }
}

--[[
Liste an Orten in denen das Tablet geöffnet werden kann.
Wenn die Tabelle leer ist, ist die Funktion deaktiviert.

System = 'cop' für CopNet
System = 'medic' für MedicNet
ystem = 'car' für CarNet
]]
Config.Zones = {
    -- Misson Row PD
    {
        Coords = vector3(450.1301574707, -979.83843994141, 30.689554214478),
        Marker = { type = -1, x = 1.0, y = 1.0, z = 1.0, r = 255, g = 255, b = 255, a = 100, rotate = true },
        Prompt = 'Drücke ~INPUT_CONTEXT~ um den PC zu nutzen.',
        System = 'cop',
        OpenType = 'pc',
        Job = 'police'
    },

    {
        Coords = vector3(450.04705810547, -988.2861328125, 30.689554214478),
        Marker = { type = -1, x = 1.0, y = 1.0, z = 1.0, r = 255, g = 255, b = 255, a = 100, rotate = true },
        Prompt = 'Drücke ~INPUT_CONTEXT~ um den PC zu nutzen.',
        System = 'cop',
        OpenType = 'pc',
        Job = 'police'
    },

    {
        Coords = vector3(453.14743041992, -988.17272949219, 30.689554214478),
        Marker = { type = -1, x = 1.0, y = 1.0, z = 1.0, r = 255, g = 255, b = 255, a = 100, rotate = true },
        Prompt = 'Drücke ~INPUT_CONTEXT~ um den PC zu nutzen.',
        System = 'cop',
        OpenType = 'pc',
        Job = 'police'
    },

    {
        Coords = vector3(453.30810546875, -990.11590576172, 30.689554214478),
        Marker = { type = -1, x = 1.0, y = 1.0, z = 1.0, r = 255, g = 255, b = 255, a = 100, rotate = true },
        Prompt = 'Drücke ~INPUT_CONTEXT~ um den PC zu nutzen.',
        System = 'cop',
        OpenType = 'pc',
        Job = 'police'
    },

    {
        Coords = vector3(453.5719909668, -982.03973388672, 30.689554214478),
        Marker = { type = -1, x = 1.0, y = 1.0, z = 1.0, r = 255, g = 255, b = 255, a = 100, rotate = true },
        Prompt = 'Drücke ~INPUT_CONTEXT~ um den PC zu nutzen.',
        System = 'cop',
        OpenType = 'pc',
        Job = 'police'
    },

    {
        Coords = vector3(453.19186401367, -979.69256591797, 30.689554214478),
        Marker = { type = -1, x = 1.0, y = 1.0, z = 1.0, r = 255, g = 255, b = 255, a = 100, rotate = true },
        Prompt = 'Drücke ~INPUT_CONTEXT~ um den PC zu nutzen.',
        System = 'cop',
        OpenType = 'pc',
        Job = 'police'
    },

    -- Pillbox Hill KH
    {
        Coords = vector3(310.19525146484, -594.19403076172, 43.289604187012),
        Marker = { type = -1, x = 1.0, y = 1.0, z = 1.0, r = 255, g = 255, b = 255, a = 100, rotate = true },
        Prompt = 'Drücke ~INPUT_CONTEXT~ um den PC zu nutzen.',
        System = 'medic',
        OpenType = 'pc'
    },

    --[[
    --Carnet Katalog BEISPIEL!!
    {
        Coords = vector3(441.94, -978.87, 29.69),
        Marker = { type = 1, x = 2.0, y = 2.0, z = 0.5, r = 102, g = 0, b = 102, a = 100, rotate = false },
        Prompt = 'Drücke ~INPUT_CONTEXT~ um den Katalog anzuschauen.',
        System = 'car',
        OpenType = 'katalog',
        PublicID = '' --  <- PublicID HIER EINFÜGEN!!
    }
    ]]
}