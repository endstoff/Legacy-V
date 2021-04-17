Config = {}

Config.DistanceToVolume = 30.0 -- The distance that will be with the volume at 1.0, so if the volume is 0.5 the distance will be 15.0, if the volume is 0.2 the distance will be 6.

Config.PlayToEveryone = true -- The music in car will be played to everyone? Or just for the people that are in that vehicle? If false the DistanceToVolume will not do anything

Config.ItemInVehicle = false -- Put here, if you want the radio to be an item, inside "", like "radio". With or false you will need to do /carradio

Config.CommandVehicle = "carradio" -- Only will work if Config.ItemInVehicle == false

Config.Zones = {
	{
		name = "Bennys", -- The name of the radio, it doesn't matter
		coords = vector3(-212.48287963867,-1341.6759033203,34.894584655762), -- the position where the music is played
		job = "bennys", --the job that can change the music
		range = 30.0, -- the range that music can be heard
		volume = 0.1, --default volume? min 0.00, max 1.00
		deflink = "https://www.youtube.com/watch?v=Emap7LU6hYk&t",-- the default link, if nill it won't play nothing
		isplaying = false, -- will the music play when the server start?
		loop = false,-- when does the music stop it will repaeat?
		deftime = 0, -- where does the music starts? 0 and it will start in the beginning
		changemusicblip = vector3(-212.48287963867,-1341.6759033203,34.894584655762) -- where the player can change the music
	},
	{
		name = "Hayes Autos", -- The name of the radio, it doesn't matter
		coords = vector3(-1429.6553955078,-455.00119018555,35.90970993042), -- the position where the music is played
		job = "acls", --the job that can change the music
		range = 30.0, -- the range that music can be heard
		volume = 0.1, --default volume? min 0.00, max 1.00
		deflink = "https://www.youtube.com/watch?v=W9iUh23Xrsg",-- the default link, if nill it won't play nothing
		isplaying = false, -- the music will play when the server start?
		loop = false,-- when the music stops it will repaeat?
		deftime = 0, -- where does the music starts? 0 and it will start in the beginning
		changemusicblip = vector3(-1429.6553955078,-455.00119018555,35.90970993042) -- where the player can change the music
	},
	{
		name = "Yellow jack in", -- The name of the radio, it doesn't matter
		coords = vector3(1987.5799560547,3051.0634765625,47.21516418457), -- the position where the music is played
		job = nil, --the job that can change the music
		range = 15.0, -- the range that music can be heard
		volume = 0.1, --default volume? min 0.00, max 1.00
		deflink = "https://streams.ilovemusic.de/iloveradio6.mp3",-- the default link, if nill it won't play nothing
		isplaying = false, -- the music will play when the server start?
		loop = false,-- when the music stops it will repaeat?
		deftime = 0, -- where does the music starts? 0 and it will start in the beginning
		changemusicblip = vector3(1987.5799560547,3051.0634765625,47.21516418457) -- where the player can change the music
	},
	{
		name = "Tiquilala", -- The name of the radio, it doesn't matter
		coords = vector3(-570.80389404297,289.01934814453,79.176666259766), -- the position where the music is played
		job = nil, --the job that can change the music
		range = 15.0, -- the range that music can be heard
		volume = 0.1, --default volume? min 0.00, max 1.00
		deflink = "https://streams.ilovemusic.de/iloveradio6.mp3",-- the default link, if nill it won't play nothing
		isplaying = false, -- the music will play when the server start?
		loop = false,-- when the music stops it will repaeat?
		deftime = 0, -- where does the music starts? 0 and it will start in the beginning
		changemusicblip = vector3(-570.80389404297,289.01934814453,79.176666259766) -- where the player can change the music
	},
	{
		name = "Cyber Bar", -- The name of the radio, it doesn't matter
		coords = vector3(334.29434204102,-911.99847412109,29.256307601929), -- the position where the music is played
		job = nil, --the job that can change the music
		range = 15.0, -- the range that music can be heard
		volume = 0.1, --default volume? min 0.00, max 1.00
		deflink = "https://streams.ilovemusic.de/iloveradio6.mp3",-- the default link, if nill it won't play nothing
		isplaying = false, -- the music will play when the server start?
		loop = false,-- when the music stops it will repaeat?
		deftime = 0, -- where does the music starts? 0 and it will start in the beginning
		changemusicblip = vector3(334.29434204102,-911.99847412109,29.256307601929) -- where the player can change the music
	},
}