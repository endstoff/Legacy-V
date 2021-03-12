What exactly is “VehicleTransport” and what can you do with it?
VehicleTransport is a script that allows you to use common transport vehicles 
to transport other vehicles! See for yourself what can be done in this video:
https://www.youtube.com/watch?v=gOuzupboNmQ&ab_channel=Kiminaze


Features (v1.0):

- By default 15+ vehicles (flatbed, trflat, benson, mule, mule2, mule3, mule4, 
  pounder, pounder2, skylift, titan, cargoplane, wastelander, armytrailer, 
  boattrailer, freighttrailer) are defined as transport vehicles.
- No commands needed for playing! Everything can be done ingame!
- Go to the back of a transport and press the button to deploy a ramp (if the 
  transport has one defined).
- Drive onto the transport and press a button to attach / detach the vehicle.
- Fully Multiplayer compatible. It does not matter who deployed the ramp or who 
  attached a vehicle. Anyone can interact with anything!
- You can drive onto a moving truck and attach your vehicle. Or detach from a 
  moving truck.
- Set the maximum speed a transport vehicle can move at, if the ramp is still 
  deployed (see config.ini)
- Enter DebugMode, so you can define your own transport vehicles (e.g. if you 
  use mod vehicles) by using a series of commands (see tutorial below).
- Default language for the help texts and notifications is english, but this 
  can be changed in the config.ini.
- Script can be restarted at any given time!
- Compatible with basically everything? Let me know if you find any issues!


Update (v1.1):

- Fixed a bug that would lock the chat when trying to create a new transport
- Added a readMe file, so people that do not come from the forum can read 
  everything they need to know.
  

Update (v1.2):

- Added an option to enable / disable the scripts functionality. (see below 
  for how to and an esx example)
- Fixed a bug that would just make the ramp invisible and not despawn it on 
  non-onesync servers.
- IMPORTANT: If you do not use onesync: change onesync to false in the config.ini!
- If you still encounter the issue with the invisible ramp (even on onesync), 
  change onesync to false in the config! This might have something to do with 
  older server versions.


How can I attach a vehicle to another one?

- Get to any sort of transport vehicle.
- If it has a ramp, go to the back of it and press the respective button (shown
  in a help text).
- Get into your vehicle and drive onto the transport.
- Come to a halt and press the respective button (shown in a help text).
- A notification shows, if the vehicle was successfully attached.
- To detach the vehicle, get into it again and press the same button.
- You can then drive off of the transport again.


How can I enable / disable the script e.g. for certain Roleplay Jobs?

- Go into the config.ini and adjust defaultEnabled to false
- Whenever you want a player to use the script (like a mechanic), you have to 
  trigger the following client-side event (e.g. when the job is set or the player 
  is loaded):
  TriggerEvent("VehicleTransport:Enable", true)
  You can also trigger it with the value "false" which will disable the script.

  e.g. in esx_mechanicjob (https://github.com/esx-framework/esx_mechanicjob/blob/master/client/main.lua) line 701:

	RegisterNetEvent('esx:setJob')
	AddEventHandler('esx:setJob', function(job)
		ESX.PlayerData.job = job

		if (ESX.PlayerData.job.name == "mechanic") then
			TriggerEvent("VehicleTransport:Enable", true)
		end
	end)


How can I define a new transport vehicle?

If you want to define your own transport vehicles (e.g. Mod Vehicles), you need 
to first of all go into the config.ini and set DebugMode to true. Then restart 
the script.

- Make sure there is enough clear space around you.
- Get the vehicle you want to define as a transport.
- Now type in the command “transport NAME” where you replace NAME with the name 
  of the vehicle (e.g. “transport flatbed”). This is just, so you can identify 
  it later. It could be named anything.
- Now type the command “min”. This allows for adjusting the minimum restraints of 
  the loading area. You use WASD to move it left right, forward and backward and 8 
  and 5 on the numpad for moving it up and down.
- Now type the command “max”. This is the same as for min and is the maximum 
  restraint.
- If your transport needs a ramp defined, type the command “rampmodel MODELNAME” 
  where you replace MODELNAME with the name of the ramp model 
  (e.g. lts_prop_lts_ramp_02 for most of the vehicles I defined). You can also 
  move it with the same keys.
- Once you are happy with everything, type the command “save”
- You can now copy the .json string from your server console into 
  “transportData.json” in the scripts folder.
- Restart the script, to see if you did everything correctly.
- If there are no errors: Congrats! You now have a new transport vehicle!
- the "save" command can also be used to immediately exit again


Known Issues

- driving onto the truck at an angle (not directly forwards) while the truck is on 
  a slope results in a weird attach angle. I’ll fix that as soon as I got behind 
  the maths there.
