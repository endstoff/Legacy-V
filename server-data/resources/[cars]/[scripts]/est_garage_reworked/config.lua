


Config = {}

Config.Abschlepper = false -- Abschlepper Feature ein oder aus
Config.AbschleppPreis = 120 -- Kosten um ein Fahrzeug vom Abschlepphof zu holen
Config.AbschlepperBlipName = "Abschlepper" -- Name des Blips auf der Marke
Config.FahrzeugeInGarageNachRestart = false -- Sollen alle Fahrzeuge nach restart wieder in der Garage sein? (true=ja, false=nein)
Config.BankKarte = true -- Soll der Spieler auch mit Geld auf seinem Konto bezahlen können? (true=ja, false=nein)

Config.AlignMenu = 'top-left' -- Wo liegt das Menu an? (left, top-left, top, top-right, right, bottom-right, bottom, bottom-left, center)

Config.FahrzeugLuaName = true -- Werden die Spawnnamen


Config.AbschlepperBlip = {         -- https://docs.fivem.net/docs/game-references/blips/
    Sprite = 317,                  -- Sprite = ID Also die Nummer unter dem Icon (bsp. Blip "radar_helicopter" hat die ID 64)
    Color = 60,                    -- Color = Farb ID also die Nummer aus den Farben (bsp. Farbe "Forrest Green" hat die ID 25)
    Display = 2,                   -- Display = Nummer in der Funktion "SetBlipDisplay()" die Nummer kann 0, 1, 2, 3, 4, 5 oder 8 sein; 0 = wird nicht gezeigt, 1 = wird nicht gezeigt,
    Scale = 1.0                    -- Die größe des Blips geht von 0.5-2.0                                                              2 = Wird auf Minimap und main Map angezeigt,
 --                                                                                                                                     3 = Wird nur auf der main Map angezeigt,
 --                                                                                                                                     4 = Wird nur auf der main Map angezeigt,
 --                                                                                                                                     5 = Wird nur auf der Minimap angezeigt,
 --                                                                                                                                     8 = Wird auf der Minimap und der main Map angezeigt, kann nur nicht ausgewählt werden.
}

Config.DrawDistance = 100.0        -- Wie weit sieht man jegliche Marker?

--Abschlepper Coords

Config.CarPounds = {
    Abschlepper_LosSantos = {
        AbschleppPunkt = { x = 408.61, y = -1625.47, z = 28.29 },           -- Abschlepppunkt coords in x,y,z (Hier ist das Menu öffenbar)
        SpawnPunkt = { x = 405.64, y = -1643.4, z = 27.61, h = 229.54 }     -- Spawnpunkt coords in x,y,z + Heading (Hier spawnt das abgeschleppte Auto nach dem bezahlen)
    },
    
    Abschlepper_Sandy = {
        AbschleppPunkt = { x = 1651.38, y = 3804.84, z = 37.65 },           -- Abschlepppunkt coords in x,y,z (Hier ist das Menu öffenbar)
        SpawnPunkt = { x = 1627.84, y = 3788.45, z = 33.77, h = 308.53 }    -- Spawnpunkt coords in x,y,z + Heading (Hier spawnt das abgeschleppte Auto nach dem bezahlen)
    },
    
    Abschlepper_Paleto = {
        AbschleppPunkt = { x = -234.82, y = 6198.65, z = 30.94 },           -- Abschlepppunkt coords in x,y,z (Hier ist das Menu öffenbar)
        SpawnPunkt = { x = -230.08, y = 6190.24, z = 30.49, h = 140.24 }    -- Spawnpunkt coords in x,y,z + Heading (Hier spawnt das abgeschleppte Auto nach dem bezahlen)
    }--,

    --[[Abschlepper_Name = {
        AbschleppPunkt = { x = 0, y = 0, z = 0 },           -- Abschlepppunkt coords in x,y,z (Hier ist das Menu öffenbar)
        SpawnPunkt = { x = 0, y = 0, z = 0, h = 0 }    -- Spawnpunkt coords in x,y,z + Heading (Hier spawnt das abgeschleppte Auto nach dem bezahlen)
    }]]--
}

Config.AbschlepperMarker = {
    r = 255, g = 255, b = 0,     -- https://www.rapidtables.com/web/color/RGB_Color.html
    x = 1.5, y = 1.5, z = 1.0    -- Standard Markergröße
}