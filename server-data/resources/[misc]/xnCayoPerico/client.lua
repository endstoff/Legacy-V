local cayoOffset = vec(-5757.178, -6489.789, 0)

local toCayoA = vec(7200, -2000, -1000)
local toCayoB = vec(15000, 4000, 10000)

local toLSA = vec3((toCayoA.x + cayoOffset.x), (toCayoA.y + cayoOffset.y), toCayoA.z)
local toLSB = vec3((toCayoB.x + cayoOffset.x), (toCayoB.y + cayoOffset.y), toCayoB.z)

local cayoLODs = {"xn_h4_islandx_terrain_01_slod", "xn_h4_islandx_terrain_02_slod", "xn_h4_islandx_terrain_04_slod", "xn_h4_islandx_terrain_05_slod", "xn_h4_islandx_terrain_06_slod"}
local LosSantosLODs = {	"xn_ap1_lod", "xn_apa_ch2_lod", "xn_apa_ch2_lod2", "xn_apa_ch2_lod3", "xn_apa_ch2_lod4", "xn_apa_ss1_lod", "xn_bh1_lod", "xn_bkr_id1_lod", "xn_ch1_lod", "xn_ch2_lod",
						"xn_ch2_lod2", "xn_ch2_lod3", "xn_ch2_lod4", "xn_ch3_lod", "xn_cs1_lod", "xn_cs1_lod2", "xn_cs1_lod3", "xn_cs2_lod", "xn_cs2_lod2", "xn_cs3_lod", "xn_cs4_lod", "xn_cs5_lod",
						"xn_cs6_lod", "xn_dt1_lod", "xn_hei_ap1_lod", "xn_hei_bh1_lod", "xn_hei_ch1_lod", "xn_hei_ch2_lod", "xn_hei_ch2_lod2", "xn_hei_ch2_lod3", "xn_hei_ch2_lod4", "xn_hei_ch3_lod",
						"xn_hei_cs1_lod", "xn_hei_cs1_lod2", "xn_hei_cs1_lod3", "xn_hei_cs2_lod", "xn_hei_cs2_lod2", "xn_hei_cs3_lod", "xn_hei_cs4_lod", "xn_hei_cs6_lod", "xn_hei_dt1_lod", "xn_hei_hw1_lod",
						"xn_hei_id1_lod", "xn_hei_id2_lod", "xn_hei_kt1_lod", "xn_hei_po1_lod", "xn_hei_sc1_lod", "xn_hei_sm_lod", "xn_hei_ss1_lod", "xn_hei_vb_lod", "xn_hw1_lod", "xn_id1_lod", "xn_id2_lod",
						"xn_kt1_lod", "xn_lr_cs4_lod", "xn_lr_cs6_lod", "xn_lr_id1_lod", "xn_lr_sc1_lod", "xn_po1_lod", "xn_sc1_lod", "xn_sm_lod", "xn_sp1_lod", "xn_ss1_lod", "xn_vb_lod"}

local inCayoPerico = false
local cam = nil

function TogglePerico()
	local ped = PlayerPedId()
	local offset = inCayoPerico and -cayoOffset or cayoOffset
	
	if not DoesCamExist(cam) then
		cam = CreateCam("DEFAULT_SCRIPTED_CAMERA", 1)
		SetCamActive(cam, true)
		RenderScriptCams(true, false, 0, true, true)
		StopCamShaking(cam, true)
	end
	
	local veh = GetVehiclePedIsIn(ped)
	local entity = veh ~= 0 and veh or ped
	local coords = GetEntityCoords(entity)
	local velocity = GetEntityVelocity(entity)
	local heading = GetEntityHeading(entity)
	
	local camOffset = GetOffsetFromEntityInWorldCoords(entity, 20.0, 50.0, 5.0)
	SetCamCoord(cam, camOffset)
	PointCamAtCoord(cam, coords)
	
	if veh ~= 0 then
		TaskVehicleTempAction(ped, entity, 23, 5000)
	end
	
	DoScreenFadeOut(2000)
	Wait(2000)
	
	if inCayoPerico then
		DisableCayoPerico(false)
	else
		EnableCayoPerico(false)
	end
	
	DetachCam(cam)
	SetCamActive(cam, false)
	RenderScriptCams(false, false, 0, 1, 0)
	DestroyCam(cam, false)
	SetEntityCoordsNoOffset(entity, coords + offset)
	SetEntityHeading(heading)
	SetEntityVelocity(entity, velocity)
	SetGameplayCamRelativeHeading(0.0)
	
	Wait(1000)
	DoScreenFadeIn(2000)
	
	inCayoPerico = not inCayoPerico
	
	TriggerEvent("IsInCayoPerico", inCayoPerico)
	TriggerServerEvent("IsInCayoPerico", inCayoPerico)
end

function EnableCayoPerico(event)
	Citizen.InvokeNative(0x9A9D1BA639675CF1, 'HeistIsland', true)
	Citizen.InvokeNative(0x5E1460624D194A38, true)
	Citizen.InvokeNative(0xF74B1FFA4A15FBEA, true)
	Citizen.InvokeNative(0x53797676AD34A9AA, false)
	SetScenarioGroupEnabled('Heist_Island_Peds', true)
	SetAudioFlag('PlayerOnDLCHeist4Island', true)
	SetAmbientZoneListStatePersistent('AZL_DLC_Hei4_Island_Zones', true, true)
	SetAmbientZoneListStatePersistent('AZL_DLC_Hei4_Island_Disabled_Zones', false, true)
	
	for _, v in ipairs(LosSantosLODs) do
		RequestIpl(v)
	end
	for _, v in ipairs(cayoLODs) do
		RemoveIpl(v)
	end
	
	if event then
		inCayoPerico = true
		
		TriggerEvent("IsInCayoPerico", true)
		TriggerServerEvent("IsInCayoPerico", true)
	end
end

function DisableCayoPerico(event)
	Citizen.InvokeNative(0x9A9D1BA639675CF1, 'HeistIsland', false)
	Citizen.InvokeNative(0x5E1460624D194A38, false)
	Citizen.InvokeNative(0xF74B1FFA4A15FBEA, false)
	Citizen.InvokeNative(0x53797676AD34A9AA, true)
	SetScenarioGroupEnabled('Heist_Island_Peds', false)
	SetAudioFlag('PlayerOnDLCHeist4Island', false)
	SetAmbientZoneListStatePersistent('AZL_DLC_Hei4_Island_Zones', false, false)
	SetAmbientZoneListStatePersistent('AZL_DLC_Hei4_Island_Disabled_Zones', true, false)
	
	for _, v in ipairs(cayoLODs) do
		RequestIpl(v)
	end
	for _, v in ipairs(LosSantosLODs) do
		RemoveIpl(v)
	end
	
	if event then
		inCayoPerico = false
		
		TriggerEvent("IsInCayoPerico", false)
		TriggerServerEvent("IsInCayoPerico", false)
	end
end

CreateThread(function()	
	while true do
		Wait(2000)
		local ped = PlayerPedId()
		
		if not inCayoPerico then
			if IsEntityInArea(ped, toCayoA, toCayoB) then
				TogglePerico()
			end
		else
			if not IsEntityInArea(ped, toLSA, toLSB) then
				TogglePerico()
			end
		end
	end
end)

RegisterNetEvent('EnableCayoPerico')
AddEventHandler('EnableCayoPerico', function()
    EnableCayoPerico(true)
end)

RegisterNetEvent('DisableCayoPerico')
AddEventHandler('DisableCayoPerico', function()
    DisableCayoPerico(true)
end)