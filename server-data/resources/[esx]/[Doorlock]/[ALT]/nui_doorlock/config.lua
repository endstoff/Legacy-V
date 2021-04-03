Config = {}
Config.ShowUnlockedText = false
Config.CheckVersion = true
Config.CheckVersionDelay = 60 -- Minutes

Config.DoorList = {
------------------------------------------
--	MISSION ROW POLICE DEPARTMENT		--
------------------------------------------
	-- gabz_mrpd	FRONT DOORS
	{
		authorizedJobs = { ['police']=0, ['offpolice']=0 },
		locked = false,
		maxDistance = 2.0,
		doors = {
			{objHash = -1547307588, objHeading = 90.0, objCoords = vector3(434.7444, -983.0781, 30.8153)},
			{objHash = -1547307588, objHeading = 270.0, objCoords = vector3(434.7444, -980.7556, 30.8153)}
		},
		lockpick = true
	},
	
	-- gabz_mrpd	NORTH DOORS
	{
		authorizedJobs = { ['police']=0, ['offpolice']=0 },
		locked = true,
		maxDistance = 2.0,
		doors = {
			{objHash = -1547307588, objHeading = 180.0, objCoords = vector3(458.2087, -972.2543, 30.8153)},
			{objHash = -1547307588, objHeading = 0.0, objCoords = vector3(455.8862, -972.2543, 30.8153)}
		},
		
	},

	-- gabz_mrpd	SOUTH DOORS
	{
		authorizedJobs = { ['police']=0, ['offpolice']=0 },
		locked = true,
		maxDistance = 2.0,
		doors = {
			{objHash = -1547307588, objHeading = 0.0, objCoords = vector3(440.7392, -998.7462, 30.8153)},
			{objHash = -1547307588, objHeading = 180.0, objCoords = vector3(443.0618, -998.7462, 30.8153)}
		},
		
	},

	-- gabz_mrpd	LOBBY LEFT


	{
		authorizedJobs = {['police']=0},
		objHash = -1406685646,
		objHeading = 0.0,
		objCoords = vector3(441.13, -977.93, 30.82319),
		locked = true,
		maxDistance = 2.0,
		fixText = true
	
	},

	-- gabz_mrpd	LOBBY RIGHT
	{
		objHash = -96679321,
		objHeading = 180.0,
		objCoords = vector3(440.5201, -986.2335, 30.82319),
		authorizedJobs = { ['police']=0, ['offpolice']=0 },
		locked = true,
		maxDistance = 2.0,
	},

	-- gabz_mrpd	GARAGE ENTRANCE 1
	{
		objHash = 1830360419,
		objHeading = 269.78,
		objCoords = vector3(464.1591, -974.6656, 26.3707),
		authorizedJobs = { ['police']=0, ['offpolice']=0 },
		locked = true,
		maxDistance = 2.0,
		fixText = true
	},

	-- gabz_mrpd	GARAGE ENTRANCE 2
	{
		objHash = 1830360419,
		objHeading = 89.87,
		objCoords = vector3(464.1566, -997.5093, 26.3707),
		authorizedJobs = { ['police']=0, ['offpolice']=0 },
		locked = true,
		maxDistance = 2.0,
		fixText = true
	},
	
	-- gabz_mrpd	GARAGE ROLLER DOOR 1
	{
		objHash = 2130672747,
		objHeading = 0.0,
		objCoords = vector3(431.4119, -1000.772, 26.69661),
		authorizedJobs = { ['police']=0, ['offpolice']=0 },
		locked = true,
		maxDistance = 6,
		garage = true,
		slides = true,
		audioRemote = true
	},
	
	-- gabz_mrpd	GARAGE ROLLER DOOR 2
	{
		objHash = 2130672747,
		objHeading = 0.0,
		objCoords = vector3(452.3005, -1000.772, 26.69661),
		authorizedJobs = { ['police']=0, ['offpolice']=0 },
		locked = true,
		maxDistance = 6,
		garage = true,
		slides = true,
		audioRemote = true
	},
	
	-- gabz_mrpd	BACK GATE
	{
		objHash = -1603817716,
		objHeading = 90.0,
		objCoords = vector3(488.8948, -1017.212, 27.14935),
		authorizedJobs = { ['police']=0, ['offpolice']=0 },
		locked = true,
		maxDistance = 6,
		slides = true,
		audioRemote = true
	},

	-- gabz_mrpd	BACK DOORS
	{
		authorizedJobs = { ['police']=0, ['offpolice']=0 },
		locked = true,
		maxDistance = 2.0,
		doors = {
			{objHash = -692649124, objHeading = 0.0, objCoords = vector3(467.3686, -1014.406, 26.48382)},
			{objHash = -692649124, objHeading = 180.0, objCoords = vector3(469.7743, -1014.406, 26.48382)}
		},
		
	},

	-- gabz_mrpd	MUGSHOT
	{
		objHash = -1406685646,
		objHeading = 180.0,
		objCoords = vector3(475.9539, -1010.819, 26.40639),
		authorizedJobs = { ['police']=0 },
		locked = true,
		maxDistance = 2.0,
		fixText = true,
	},

	-- gabz_mrpd	CELL ENTRANCE 1
	{
		objHash = -53345114,
		objHeading = 270.0,
		objCoords = vector3(476.6157, -1008.875, 26.48005),
		authorizedJobs = { ['police']=0 },
		locked = true,
		maxDistance = 2.0,
		audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.35},
		audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7}
	},

	-- gabz_mrpd	CELL ENTRANCE 2
	{
		objHash = -53345114,
		objHeading = 180.0,
		objCoords = vector3(481.0084, -1004.118, 26.48005),
		authorizedJobs = { ['police']=0 },
		locked = true,
		maxDistance = 2.0,
		audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.35},
		audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7}
	},

	-- gabz_mrpd	CELL 1
	{
		objHash = -53345114,
		objHeading = 0.0,
		objCoords = vector3(477.9126, -1012.189, 26.48005),
		authorizedJobs = { ['police']=0 },
		locked = true,
		maxDistance = 2.0,
		audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.35},
		audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7}
	},

	-- gabz_mrpd	CELL 2
	{
		objHash = -53345114,
		objHeading = 0.0,
		objCoords = vector3(480.9128, -1012.189, 26.48005),
		authorizedJobs = { ['police']=0 },
		locked = true,
		maxDistance = 2.0,
		audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.35},
		audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7}
	},

	-- gabz_mrpd	CELL 3
	{
		objHash = -53345114,
		objHeading = 0.0,
		objCoords = vector3(483.9127, -1012.189, 26.48005),
		authorizedJobs = { ['police']=0 },
		locked = true,
		maxDistance = 2.0,
		audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.35},
		audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7}
	},

	-- gabz_mrpd	CELL 4
	{
		objHash = -53345114,
		objHeading = 0.0,
		objCoords = vector3(486.9131, -1012.189, 26.48005),
		authorizedJobs = { ['police']=0 },
		locked = true,
		maxDistance = 2.0,
		audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.35},
		audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7}
	},

	-- gabz_mrpd	CELL 5
	{
		objHash = -53345114,
		objHeading = 180.0,
		objCoords = vector3(484.1764, -1007.734, 26.48005),
		authorizedJobs = { ['police']=0 },
		locked = true,
		maxDistance = 2.0,
		audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.35},
		audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7}
	},

	-- gabz_mrpd	LINEUP
	{
		objHash = -288803980,
		objHeading = 90.0,
		objCoords = vector3(479.06, -1003.173, 26.4065),
		authorizedJobs = { ['police']=0 },
		locked = true,
		maxDistance = 2.0,
		fixText = true
	},

	-- gabz_mrpd	OBSERVATION I
	{
		objHash = -1406685646,
		objHeading = 270.0,
		objCoords = vector3(482.6694, -983.9868, 26.40548),
		authorizedJobs = { ['police']=0 },
		locked = true,
		maxDistance = 2.0,
		fixText = true
	},

	-- gabz_mrpd	INTERROGATION I
	{
		objHash = -1406685646,
		objHeading = 270.0,
		objCoords = vector3(482.6701, -987.5792, 26.40548),
		authorizedJobs = { ['police']=0 },
		locked = true,
		maxDistance = 2.0,
		fixText = true
	},

	-- gabz_mrpd	OBSERVATION II
	{
		objHash = -1406685646,
		objHeading = 270.0,
		objCoords = vector3(482.6699, -992.2991, 26.40548),
		authorizedJobs = { ['police']=0 },
		locked = true,
		maxDistance = 2.0,
		fixText = true
	},

	-- gabz_mrpd	INTERROGATION II
	{
		objHash = -1406685646,
		objHeading = 270.0,
		objCoords = vector3(482.6703, -995.7285, 26.40548),
		authorizedJobs = { ['police']=0 },
		locked = true,
		maxDistance = 2.0,
		fixText = true
	},

	-- gabz_mrpd	EVIDENCE
	{
		objHash = -692649124,
		objHeading = 134.7,
		objCoords = vector3(475.8323, -990.4839, 26.40548),
		authorizedJobs = { ['police']=0 },
		fixText = true,
		locked = true,
		maxDistance = 2.0,	
	},

	-- gabz_mrpd	ARMOURY 1
	{
		objHash = -692649124,
		objHeading = 90.0,
		objCoords = vector3(479.7507, -999.629, 30.78927),
		authorizedJobs = { ['police']=0 },
		locked = true,
		maxDistance = 2.0,
		fixText = true
	},

	-- gabz_mrpd	ARMOURY 2
	{
		objHash = -692649124,
		objHeading = 181.28,
		objCoords = vector3(487.4378, -1000.189, 30.78697),
		authorizedJobs = { ['police']=0 },
		locked = true,
		maxDistance = 2.0,
		fixText = true
	},

	-- gabz_mrpd	SHOOTING RANGE
	{
		authorizedJobs = { ['police']=0 },
		locked = true,
		maxDistance = 2.0,
		doors = {
			{objHash = -692649124, objHeading = 0.0, objCoords = vector3(485.6133, -1002.902, 30.78697)},
			{objHash = -692649124, objHeading = 180.0, objCoords = vector3(488.0184, -1002.902, 30.78697)}
		},
		
	},

	-- gabz_mrpd	ROOFTOP
	{
		objCoords = vector3(464.3086, -984.5284, 43.77124),
		authorizedJobs = { ['police']=0 },
		objHeading = 90.000465393066,
		slides = false,
		lockpick = false,
		audioRemote = false,
		maxDistance = 2.0,
		garage = false,
		objHash = -692649124,
		locked = true,
		fixText = true,
	}

}


-- ACLS Aufhenhaltsraum
table.insert(Config.DoorList, {
	objHash = -2023754432,
	objCoords = vector3(-347.5988, -132.6898, 39.17981),
	slides = false,
	fixText = true,
	maxDistance = 2.0,
	objHeading = 249.99996948242,
	garage = false,
	authorizedJobs = { ['mechanic']=0 },
	locked = false,
	lockpick = false,
	audioRemote = false,		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- ACLS Büro 1
table.insert(Config.DoorList, {
	objHash = -2023754432,
	objCoords = vector3(-348.0408, -129.5036, 39.17981),
	slides = false,
	fixText = true,
	maxDistance = 2.0,
	objHeading = 159.99996948242,
	garage = false,
	authorizedJobs = { ['mechanic']=3 },
	locked = true,
	lockpick = false,
	audioRemote = false,		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- ACLS Büro 2
table.insert(Config.DoorList, {
	objHash = -2023754432,
	objCoords = vector3(-347.9567, -123.5184, 39.17981),
	slides = false,
	fixText = true,
	maxDistance = 2.0,
	objHeading = 340.1075,
	garage = false,
	authorizedJobs = { ['mechanic']=3 },
	locked = true,
	lockpick = false,
	audioRemote = false,		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- ACLS Dienstraum
table.insert(Config.DoorList, {
	objHash = -2023754432,
	objCoords = vector3(-344.8004, -114.1268, 39.17981),
	slides = false,
	fixText = true,
	maxDistance = 1.0,
	objHeading = 69.9999,
	garage = false,
	authorizedJobs = { ['mechanic']=0, ['offmechanic']=0 },
	locked = true,
	lockpick = false,
	audioRemote = false,		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- ACLS Garagen Tor
--[[table.insert(Config.DoorList, {
	objHash = -550347177,
	objCoords = vector3(-356.1168, -134.7702, 40.00971),
	slides = 6.0,
	fixText = true,
	maxDistance = 6.0,
	objHeading = 249.99993896484,
	garage = true,
	authorizedJobs = { ['mechanic']=0, ['offmechanic']=0 },
	locked = true,
	lockpick = false,
	audioRemote = false,		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})]]--

--XX--XX--XX--XX--XX--XX--XX--XX--XX--XX--XX--XX--XX--XX--XX--XX--XX--XX--XX--XX--XX--XX--XX--XX--XX

-- LSMD Surgery 1
table.insert(Config.DoorList, {
	slides = 6.0,
	lockpick = false,
	locked = true,
	authorizedJobs = { ['ambulance']=0 },
	garage = true,
	objHash = -1700911976,
	audioRemote = false,
	fixText = true,
	doors = {
		{objHash = -1700911976, objHeading = 340.0000, objCoords = vector3(314.4241, -572.2216, 43.43391)},
		{objHash = -434783486, objHeading = 340.1090, objCoords = vector3(312.0051, -571.3412, 43.43391)}
 	},
	objHeading = 340.00003051758,
	maxDistance = 2.0,		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- LSMD Surgery 2
table.insert(Config.DoorList, {
	slides = 6.0,
	lockpick = false,
	locked = true,
	authorizedJobs = { ['ambulance']=0 },
	garage = true,
	objHash = -1700911976,
	audioRemote = false,
	fixText = true,
	doors = {
		{objHash = -1700911976, objHeading = 340.0000, objCoords = vector3(320.2515, -574.3463, 43.43391)},
		{objHash = -434783486, objHeading = 340.1090, objCoords = vector3(317.8426, -573.4659, 43.43391)}
 	},
	objHeading = 340.00003051758,
	maxDistance = 2.0,		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- LSMD Surgery 3
table.insert(Config.DoorList, {
	slides = 6.0,
	lockpick = false,
	locked = true,
	authorizedJobs = { ['ambulance']=0 },
	garage = true,
	objHash = -1700911976,
	audioRemote = false,
	fixText = true,
	doors = {
		{objHash = -1700911976, objHeading = 340.0000, objCoords = vector3(325.6565, -576.3099, 43.43391)},
		{objHash = -434783486, objHeading = 340.1090, objCoords = vector3(323.2375, -575.4294, 43.43391)}
 	},
	objHeading = 340.00003051758,
	maxDistance = 2.0,		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- LSMD MRI
table.insert(Config.DoorList, {
	objHash = 854291622,
	objCoords = vector3(336.1628, -580.1403, 43.43391),
	slides = false,
	fixText = true,
	maxDistance = 2.0,
	objHeading = 340.0000,
	garage = false,
	authorizedJobs = { ['ambulance']=0 },
	locked = true,
	lockpick = false,
	audioRemote = false,		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- LSMD Diagnostics
table.insert(Config.DoorList, {
	objHash = 854291622,
	objCoords = vector3(340.7818, -581.8215, 43.43391),
	slides = false,
	fixText = true,
	maxDistance = 2.0,
	objHeading = 340.0000,
	garage = false,
	authorizedJobs = { ['ambulance']=0 },
	locked = true,
	lockpick = false,
	audioRemote = false,		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- LSMD X-RAY
table.insert(Config.DoorList, {
	objHash = 854291622,
	objCoords = vector3(340.7818, -581.8215, 43.43391),
	slides = false,
	fixText = true,
	maxDistance = 2.0,
	objHeading = 340.0000,
	garage = false,
	authorizedJobs = { ['ambulance']=0 },
	locked = true,
	lockpick = false,
	audioRemote = false,		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- LSMD Administration
table.insert(Config.DoorList, {
	objHash = 854291622,
	objCoords = vector3(339.005, -586.7034, 43.43391),
	slides = false,
	fixText = true,
	maxDistance = 2.0,
	objHeading = 340.5788,
	garage = false,
	authorizedJobs = { ['ambulance']=0 },
	locked = true,
	lockpick = false,
	audioRemote = false,		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- LSMD Director Office
table.insert(Config.DoorList, {
	objHash = 854291622,
	objCoords = vector3(336.8665, -592.5788, 43.43391),
	slides = false,
	fixText = true,
	maxDistance = 2.0,
	objHeading = 340.5788,
	garage = false,
	authorizedJobs = { ['ambulance']=5 },
	locked = true,
	lockpick = false,
	audioRemote = false,		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- LSMD Garagen Tor L
table.insert(Config.DoorList, {
	objHash = -820650556,
	objCoords = vector3(337.2777, -564.432, 29.77529),
	slides = 6.0,
	fixText = true,
	maxDistance = 6.0,
	objHeading = 160.0060,
	garage = true,
	authorizedJobs = { ['ambulance']=0 },
	locked = true,
	lockpick = false,
	audioRemote = false,		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- LSMD Garagen Tor R
table.insert(Config.DoorList, {
	objHash = -820650556,
	objCoords = vector3(330.1349, -561.8331, 29.77529),
	slides = 6.0,
	fixText = true,
	maxDistance = 6.0,
	objHeading = 160.0060,
	garage = true,
	authorizedJobs = { ['ambulance']=0 },
	locked = true,
	lockpick = false,
	audioRemote = false,		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- LSMD Garagen Tür
table.insert(Config.DoorList, {
	slides = 2.0,
	lockpick = false,
	locked = true,
	authorizedJobs = { ['ambulance']=0, ['offambulance']=0 },
	garage = true,
	objHash = -1700911976,
	audioRemote = false,
	fixText = true,
	doors = {
		{objHash = -1421582160, objHeading = 25.0059, objCoords = vector3(321.0148, -559.9127, 28.94724)},
		{objHash = 1248599813, objHeading = 205.0061, objCoords = vector3(318.6656, -561.0086, 28.94724)}
 	},
	objHeading = 340.00003051758,
	maxDistance = 6.0,		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- LSMD Reception Door 1
table.insert(Config.DoorList, {
	objHash = 854291622,
	objCoords = vector3(313.4901, -595.4583, 43.43391),
	slides = false,
	fixText = true,
	maxDistance = 2.0,
	objHeading = 249.8233,
	garage = false,
	authorizedJobs = { ['ambulance']=0, ['offambulance']=0 },
	locked = true,
	lockpick = false,
	audioRemote = false,		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- LSMD Reception Door 2
table.insert(Config.DoorList, {
	objHash = 854291622,
	objCoords = vector3(309.1337, -597.7515, 43.43391),
	slides = false,
	fixText = true,
	maxDistance = 2.0,
	objHeading = 160.0000,
	garage = false,
	authorizedJobs = { ['ambulance']=0, ['offambulance']=0 },
	locked = true,
	lockpick = false,
	audioRemote = false,		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- LSMD Pharmacie
table.insert(Config.DoorList, {
	objHash = 854291622,
	objCoords = vector3(307.1182, -569.569, 43.43391),
	slides = false,
	fixText = true,
	maxDistance = 2.0,
	objHeading = 339.7637,
	garage = false,
	authorizedJobs = { ['ambulance']=0 },
	locked = true,
	lockpick = false,
	audioRemote = false,		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- Flywheels Büro
table.insert(Config.DoorList, {
	authorizedJobs = { ['bennys']=0 },
	audioRemote = false,
	objCoords = vector3(1775.62, 3327.711, 41.45468),
	lockpick = false,
	fixText = true,
	garage = false,
	locked = true,
	objHeading = 299.94638061523,
	maxDistance = 2.0,
	slides = false,
	objHash = -725970636,		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

table.insert(Config.DoorList, {
	authorizedJobs = { ['bennys']=0 },
	audioRemote = false,
	objCoords = vector3(1756.851, 3311.377, 40.25931),
	lockpick = false,
	fixText = true,
	garage = true,
	locked = true,
	objHeading = 24.7809,
	maxDistance = 6.0,
	slides = true,
	objHash = -250842784,		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- Flywheels Büro innen
table.insert(Config.DoorList, {
	authorizedJobs = { ['bennys']=0 },
	locked = true,
	slides = false,
	objHash = -129553421,
	fixText = false,
	lockpick = false,
	audioRemote = false,
	maxDistance = 2.0,
	objCoords = vector3(1770.89, 3325.574, 41.56491),
	objHeading = 209.70960998535,
	garage = false,		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- State
table.insert(Config.DoorList, {
	authorizedJobs = { ['police']=0 },
	fixText = true,
	audioRemote = false,
	objCoords = vector3(1844.998, 2604.813, 44.63978),
	objHash = 741314661,
	lockpick = true,
	garage = false,
	maxDistance = 6.0,
	objHeading = 89.998756408691,
	locked = true,
	slides = true,		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- State 2
table.insert(Config.DoorList, {
	slides = true,
	lockpick = false,
	objCoords = vector3(1818.543, 2604.813, 44.611),
	objHeading = 90.000267028809,
	locked = true,
	fixText = true,
	audioRemote = false,
	authorizedJobs = { ['police']=0 },
	maxDistance = 6.0,
	garage = false,
	objHash = 741314661,		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- ACLS Abschlepphof
table.insert(Config.DoorList, {
	objHash = 1817008884,
	objHeading = 339.83334350586,
	garage = false,
	maxDistance = 3.0,
	objCoords = vector3(-377.3235, -88.91736, 45.97765),
	authorizedJobs = { ['mechanic']=0 },
	fixText = true,
	audioRemote = false,
	lockpick = false,
	locked = true,
	slides = false,		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})

-- ACLS Abschlepphof 
table.insert(Config.DoorList, {
	objHash = 1286535678,
	objHeading = 250.14544677734,
	garage = false,
	maxDistance = 6.0,
	objCoords = vector3(-378.7925, -74.71045, 44.67314),
	authorizedJobs = { ['mechanic']=0 },
	fixText = false,
	audioRemote = false,
	lockpick = false,
	locked = true,
	slides = true,		
	-- oldMethod = true,
	-- audioLock = {['file'] = 'metal-locker.ogg', ['volume'] = 0.6},
	-- audioUnlock = {['file'] = 'metallic-creak.ogg', ['volume'] = 0.7},
	-- autoLock = 1000
})