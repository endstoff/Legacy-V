Config = {}
Config.Blip			= {sprite= 473, color = 4, scale = 0.8}
Config.BoatBlip		= {sprite= 410, color = 30}
Config.AirplaneBlip	= {sprite= 524, color = 188}
Config.MecanoBlip	= {sprite= 357, color = 26}
Config.Price		= 250 -- pound price to get vehicle back
Config.SwitchGaragePrice  = 500 -- price to pay to switch vehicles in garage
Config.StoreOnServerStart = false -- Store all vehicles in garage on server start?
Config.Locale = 'de'

Config.Garages = {
	Garage_Meetingpoint = {
		Pos = {x=215.800, y=-810.057, z=30.727},
		Marker = { w= 1.5, h= 1.0,r = 204, g = 204, b = 0},
		Name = _U('garage_name'),
		HelpPrompt = _U('open_car_garage'),
		SpawnPoint = {
			Pos = {x=229.700, y= -800.1149, z= 30.5722},
			Heading = 160.0,
			Marker = { w= 1.5, h= 1.0,r=0,g=255,b=0},
			HelpPrompt = _U('spawn_car')
		},
		DeletePoint = {
			Pos = {x=215.124, y=-791.377, z=30.946},
			Marker = { w= 1.5, h= 1.0,r=255,g=0,b=0},
			HelpPrompt = _U('store_car')
		}, 	
	},

	Garage_Paleto = {
		Pos = {x=116.42, y=6599.55, z=32.01},
		Marker = { w= 1.5, h= 1.0,r = 204, g = 204, b = 0},
		Name = _U('garage_name'),
		HelpPrompt = _U('open_car_garage'),
		SpawnPoint = {
			Pos = {x=125.83, y= 6589.78, z= 31.95},
			Heading = 272.29,
			Marker = { w= 1.5, h= 1.0,r=0,g=255,b=0},
			HelpPrompt = _U('spawn_car')
		},
		DeletePoint = {
			Pos = {x=135.57, y=6580.15, z=32.03},
			Marker = { w= 1.5, h= 1.0,r=255,g=0,b=0},
			HelpPrompt = _U('store_car')
		}, 	
	},

	Garage_SandyShores = {
		Pos = {x=1694.571, y=3610.924, z=35.319},
		Marker = { w= 1.5, h= 1.0,r = 204, g = 204, b = 0},
		Name = _U('garage_name'),
		HelpPrompt = _U('open_car_garage'),
		SpawnPoint = {
			Pos = {x=1713.492, y= 3598.938, z= 35.338},
			Heading = 160.0,
			Marker = { w= 1.5, h= 1.0,r=0,g=255,b=0},
			HelpPrompt = _U('spawn_car')
		},
		DeletePoint = {
			Pos = {x = 1695.156,y = 3601.061,z = 35.530},
			Marker = { w= 1.5, h= 1.0,r=255,g=0,b=0},
			HelpPrompt = _U('store_car')
		}, 	
	},

	Garage_Rancho = {
		Pos = {x = 443.6696,y = -1969.4372,z = 24.401},
		Marker = { w= 1.5, h= 1.0,r = 204, g = 204, b = 0},
		Name = _U('garage_name'),
		HelpPrompt = _U('open_car_garage'),
		SpawnPoint = {
			Pos = {x = 437.8140,y = -1958.572,z = 22.957},
			Heading = 182.0,
			Marker = { w= 1.5, h= 1.0,r=0,g=255,b=0},
			HelpPrompt = _U('spawn_car')
		},
		DeletePoint = {
			Pos = {x = 457.91,y = -1971.343,z = 22.553},
			Marker = { w= 1.5, h= 1.0,r=255,g=0,b=0},
			HelpPrompt = _U('store_car')
		}, 	
	},

	Garage_VespucciKanal = {
		Pos = {x = -1081.974609375,y = -1254.1881103516,z = 5.4244246482849 },
		Marker = { w= 1.5, h= 1.0,r = 204, g = 204, b = 0},
		Name = _U('garage_name'),
		HelpPrompt = _U('open_car_garage'),
		SpawnPoint = {
			Pos = {x = -1077.2590332031,y = -1239.3200683594,z = 5.161093711853 },
			Heading = 144.887,
			Marker = { w= 1.5, h= 1.0,r=0,g=255,b=0},
			HelpPrompt = _U('spawn_car')
		},
		DeletePoint = {
			Pos = {x = -1097.2971191406,y = -1253.8725585938,z = 5.2441983222961 },
			Marker = { w= 1.5, h= 1.0,r=255,g=0,b=0},
			HelpPrompt = _U('store_car')
		}, 	
	},

	Garage_Mirrorpark = {
		Pos = {x = 1033.9229736328,y = -767.10662841797,z = 58.003326416016 },
		Marker = { w= 1.5, h= 1.0,r = 204, g = 204, b = 0},
		Name = _U('garage_name'),
		HelpPrompt = _U('open_car_garage'),
		SpawnPoint = {
			Pos = {x = 1040.6834716797,y = -778.18170166016,z = 58.022853851318 },
			Heading = 359.92,
			Marker = { w= 1.5, h= 1.0,r=0,g=255,b=0},
			HelpPrompt = _U('spawn_car')
		},
		DeletePoint = {
			Pos = {x = 1022.7816772461,y = -763.78955078125,z = 57.961227416992 },
			Marker = { w= 1.5, h= 1.0,r=255,g=0,b=0},
			HelpPrompt = _U('store_car')
		}, 	 	
	},

	Garage_Erz = {
		Pos = {x=1028.72, y=-2313.79, z=30.51},
		Marker = { w= 1.5, h= 1.0,r = 204, g = 204, b = 0},
		Name = _U('garage_name'),
		HelpPrompt = _U('open_car_garage'),
		SpawnPoint = {
			Pos = {x=1023.22, y=-2344.51, z=30.51},
			Heading = 85.55,
			Marker = { w= 1.5, h= 1.0,r=0,g=255,b=0},
			HelpPrompt = _U('spawn_car')
		},
		DeletePoint = {
			Pos = {x=1027.41, y=-2328.77, z=30.51},
			Marker = { w= 1.5, h= 1.0,r=255,g=0,b=0},
			HelpPrompt = _U('store_car')
		}, 	
	},

	Garage_Flughafen = {
		Pos = {x=-928.35, y=-2543.3, z=15.36},
		Marker = { w= 1.5, h= 1.0,r = 204, g = 204, b = 0},
		Name = _U('garage_name'),
		HelpPrompt = _U('open_car_garage'),
		SpawnPoint = {
			Pos = {x=-926.31, y=-2548.23, z=14.05},
			Heading = 160.12,
			Marker = { w= 1.5, h= 1.0,r=0,g=255,b=0},
			HelpPrompt = _U('spawn_car')
		},
		DeletePoint = {
			Pos = {x=-935.36, y=-2542.85, z=14.05},
			Marker = { w= 1.5, h= 1.0,r=255,g=0,b=0},
			HelpPrompt = _U('store_car')
		}, 	
	},

	Garage_Grapeseed = {
		Pos = {x=1717.98, y=4792.03, z=41.98},
		Marker = { w= 1.5, h= 1.0,r = 204, g = 204, b = 0},
		Name = _U('garage_name'),
		HelpPrompt = _U('open_car_garage'),
		SpawnPoint = {
			Pos = {x=1720.46, y=4802.77, z=41.68},
			Heading = 90,
			Marker = { w= 1.5, h= 1.0,r=0,g=255,b=0},
			HelpPrompt = _U('spawn_car')
		},
		DeletePoint = {
			Pos = {x=1725.48, y=4807.55, z=41.67},
			Marker = { w= 1.5, h= 1.0,r=255,g=0,b=0},
			HelpPrompt = _U('store_car')
		},	
	},

	Garage_Harmony = {
		Pos = {x = 1136.3771972656,y = 2666.6303710938,z = 38.013275146484 },
		Marker = { w= 1.5, h= 1.0,r = 204, g = 204, b = 0},
		Name = _U('garage_name'),
		HelpPrompt = _U('open_car_garage'),
		SpawnPoint = {
			Pos = {x = 1120.9813232422,y = 2668.8684082031,z = 38.048095703125 },
			Heading = 179.84,
			Marker = { w= 1.5, h= 1.0,r=0,g=255,b=0},
			HelpPrompt = _U('spawn_car')
		},
		DeletePoint = {
			Pos = {x = 1121.9963378906,y = 2660.1179199219,z = 37.996875762939 },
			Marker = { w= 1.5, h= 1.0,r=255,g=0,b=0},
			HelpPrompt = _U('store_car')
		}, 	
	},

	Garage_Chumash = {
		Pos = {x = -3140.323,y = 1124.463,z = 20.706},
		Marker = { w= 1.5, h= 1.0,r = 204, g = 204, b = 0},
		Name = _U('garage_name'),
		HelpPrompt = _U('open_car_garage'),
		SpawnPoint = {
			Pos = {x = -3132.638,y = 1126.662,z = 20.667},
			Heading = 160.0,
			Marker = { w= 1.5, h= 1.0,r=0,g=255,b=0},
			HelpPrompt = _U('spawn_car')
		},
		DeletePoint = {
			Pos = {x = -3136.902,y = 1102.685,z = 20.654},
			Marker = { w= 1.5, h= 1.0,r=255,g=0,b=0},
			HelpPrompt = _U('store_car')
		}, 	
	},

	Garage_Tequilala = {
		Pos = {x = -575.66357421875,y = 318.41366577148,z = 84.614906311035 },
		Marker = { w= 1.5, h= 1.0,r = 204, g = 204, b = 0},
		Name = _U('garage_name'),
		HelpPrompt = _U('open_car_garage'),
		SpawnPoint = {
			Pos = {x = -569.47564697266,y = 323.53549194336,z = 84.474433898926 },
			Heading = 22.52,
			Marker = { w= 1.5, h= 1.0,r=0,g=255,b=0},
			HelpPrompt = _U('spawn_car')
		},
		DeletePoint = {
			Pos = {x = -560.84375,y = 322.41586303711,z = 84.402587890625 },
			Marker = { w= 1.5, h= 1.0,r=255,g=0,b=0},
			HelpPrompt = _U('store_car')
		}, 	
	},
}



--	=======================================================================



Config.GaragesMecano = {
	mechanic = {
		Name = _U('bennys_pound'),
		SpawnPoint = {
			Pos = {x = 477.729,y = -1888.856,z = 26.094},
			Heading = 303.0,
			Marker = { w= 1.5, h= 1.0,r=0,g=255,b=0},
			HelpPrompt = _U('take_from_pound')
		},
		DeletePoint = {
			Pos = {x = 459.733,y = -1890.335,z = 25.776},
			Marker = { w= 1.5, h= 1.0,r=255,g=0,b=0},
			HelpPrompt = _U('store_in_pound')
		}, 	
	},
	police = {
		Name = _U('police_pound'),
		SpawnPoint = {
			Pos = {x = 449.253,y = -1024.322,z = 28.57},
			Heading = 100.0,
			Marker = { w= 1.5, h= 1.0,r=0,g=255,b=0},
			HelpPrompt = _U('take_from_pound')
		},
		DeletePoint = {
			Pos = {x = 452.305,y = -996.752,z = 25.776},
			Marker = { w= 1.5, h= 1.0,r=255,g=0,b=0},
			HelpPrompt = _U('store_in_pound')
		}, 	
	},
	police2 = {
		Name = _U('police_pound'),
		SpawnPoint = {
			Pos = {x = 1868.325,y = 3694.566,z = 33.61},
			Heading = 100.0,
			Marker = { w= 1.5, h= 1.0,r=0,g=255,b=0},
			HelpPrompt = _U('take_from_pound')
		},
		DeletePoint = {
			Pos = {x = 1860.925,y = 3706.958,z = 33.36},
			Marker = { w= 1.5, h= 1.0,r=255,g=0,b=0},
			HelpPrompt = _U('store_in_pound')
		}, 	
	},
	police3 = {
		Name = _U('police_pound'),
		SpawnPoint = {
			Pos = {x = -474.000,y = 6029.71,z = 30.94},
			Heading = 226.0,
			Marker = { w= 1.5, h= 1.0,r=0,g=255,b=0},
			HelpPrompt = _U('take_from_pound')
		},
		DeletePoint = {
			Pos = {x = -462.932,y = 60.41,z = 31.34},
			Marker = { w= 1.5, h= 1.0,r=255,g=0,b=0},
			HelpPrompt = _U('store_in_pound')
		}, 	
	},
	 Bennys2 = {
		 Marker = 1,
		 SpawnPoint = {
			 Pos = {x=-190.455, y= -1290.654, z= 30.295},
			 Color = {r=0,g=255,b=0},
			 Size  = {x = 3.0, y = 3.0, z = 1.0},
			 Marker = 1
		 },
		 DeletePoint = {
			 Pos = {x=-190.379, y=-1284.667, z=30.233},
			 Color = {r=255,g=0,b=0},
			 Size  = {x = 3.0, y = 3.0, z = 1.0},
			 Marker = 1
		 }, 	
	 },
}


Config.SocietyGarages = {
	police =  { -- database job name
		{
			Pos = {x = 446.39,y = -984.844,z = 30.696 },
			Marker = { w= 1.5, h= 1.0,r = 204, g = 204, b = 0},
			Name = _U('police_garage_name'),
			HelpPrompt = _U('open_police_garage'),
			SpawnPoint = {
				Pos = {x = -1285.1153564453,y = -3382.1647949219,z = 13.940155029297 },
				Heading = 160.0,
				Marker = { w= 1.5, h= 1.0,r=0,g=255,b=0},
				HelpPrompt = _U('spawn_police_garage')
			},
			DeletePoint = {
				Pos = {x = -1287.5788574219,y = -3390.4025878906,z = 13.940155029297 },
				Marker = { w= 1.5, h= 1.0,r=255,g=0,b=0},
				HelpPrompt = _U('store_police_garage')
			}, 	
		},
		{
			Pos = {x = 448.1153564453,y = -976.86,z = 30.696 },
			Marker = { w= 1.5, h= 1.0,r = 204, g = 204, b = 0},
			Name = _U('police_garage_name'),
			HelpPrompt = _U('open_police_garage'),
			SpawnPoint = {
				Pos = {x = -1285.1153564453,y = -3382.1647949219,z = 13.940155029297 },
				Heading = 160.0,
				Marker = { w= 1.5, h= 1.0,r=0,g=255,b=0},
				HelpPrompt = _U('spawn_police_garage')
			},
			DeletePoint = {
				Pos = {x = -1287.5788574219,y = -3390.4025878906,z = 13.940155029297 },
				Marker = { w= 1.5, h= 1.0,r=255,g=0,b=0},
				HelpPrompt = _U('store_police_garage')
			}, 	
		},
	},
	brinks =  {
		{
			Pos = {x = 443.1153564453,y = -993.86,z = 30.696 },
			Marker = { w= 1.5, h= 1.0,r = 204, g = 204, b = 0},
			Name = _U('brinks_garage_name'),
			HelpPrompt = _U('open_brinks_garage'),
			SpawnPoint = {
				Pos = {x = -1285.1153564453,y = -3382.1647949219,z = 13.940155029297 },
				Heading = 160.0,
				Marker = { w= 1.5, h= 1.0,r=0,g=255,b=0},
				HelpPrompt = _U('spawn_brinks_garage')
			},
			DeletePoint = {
				Pos = {x = -1287.5788574219,y = -3390.4025878906,z = 13.940155029297 },
				Marker = { w= 1.5, h= 1.0,r=255,g=0,b=0},
				HelpPrompt = _U('store_brinks_garage')
			}, 	
		},
    },
	ambulance =  {
		{
			Pos = {x = 443.1153564453,y = -993.86,z = 30.696 },
			Marker = { w= 1.5, h= 1.0,r = 204, g = 204, b = 0},
			Name = _U('ambulance_garage_name'),
			HelpPrompt = _U('open_ambulance_garage'),
			SpawnPoint = {
				Pos = {x = -1285.1153564453,y = -3382.1647949219,z = 13.940155029297 },
				Heading = 160.0,
				Marker = { w= 1.5, h= 1.0,r=0,g=255,b=0},
				HelpPrompt = _U('spawn_ambulance_garage')
			},
			DeletePoint = {
				Pos = {x = -1287.5788574219,y = -3390.4025878906,z = 13.940155029297 },
				Marker = { w= 1.5, h= 1.0,r=255,g=0,b=0},
				HelpPrompt = _U('store_ambulance_garage')
			}, 	
		},
	},
	taxi =  {
		{
			Pos = {x = 443.1153564453,y = -993.86,z = 30.696 },
			Marker = { w= 1.5, h= 1.0,r = 204, g = 204, b = 0},
			Name = _U('taxi_garage_name'),
			HelpPrompt = _U('open_taxi_garage'),
			SpawnPoint = {
				Pos = {x = -1285.1153564453,y = -3382.1647949219,z = 13.940155029297 },
				Heading = 160.0,
				Marker = { w= 1.5, h= 1.0,r=0,g=255,b=0},
				HelpPrompt = _U('spawn_taxi_garage')
			},
			DeletePoint = {
				Pos = {x = -1287.5788574219,y = -3390.4025878906,z = 13.940155029297 },
				Marker = { w= 1.5, h= 1.0,r=255,g=0,b=0},
				HelpPrompt = _U('store_taxi_garage')
			}, 	
		},
	},

	mechanic =  {
		{
			Pos = {x = -179.36,y = -1285.36,z = 31.3 },
			Marker = { w= 1.5, h= 1.0,r = 204, g = 204, b = 0},
			Name = _U('mechanic_garage_name'),
			HelpPrompt = _U('open_mechanic_garage'),
			SpawnPoint = {
				Pos = {x = -190.76,y = -1290.04,z = 31.3 },
				Heading = 282.15,
				Marker = { w= 1.5, h= 1.0,r=0,g=255,b=0},
				HelpPrompt = _U('spawn_mechanic_garage')
			},
			DeletePoint = {
				Pos = {x = -190.9,y = -1284.4,z = 31.23 },
				Marker = { w= 1.5, h= 1.0,r=255,g=0,b=0},
				HelpPrompt = _U('store_mechanic_garage')
			}, 	
		},
    },
}
