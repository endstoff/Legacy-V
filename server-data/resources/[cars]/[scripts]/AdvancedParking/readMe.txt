Hello everyone!

This time I bring to you "AdvancedParking", a non-framework dependent script which 
allows you to park your vehicles (cars, planes, helis, boats, etc.) anytime and 
anywhere! This is 100% standalone, you can use it with ANY framework!
The only requirement is mysql-async and onesync!


**Support**

Support will mainly be given through our Discord Server!
https://discord.gg/kvfeJHWJ


**What does it do exactly?**

As soon as you get out of a vehicle, it gets registered in the database as a saved 
vehicle. After that, the vehicle will stay at that location and even get updated 
when it gets moved (e.g. when ramming it)!

If a vehicle gets deleted while a player is inside (e.g. in most garage scripts or 
jobs), the vehicle automatically gets unregistered from the script and database and 
will not spawn anymore until you enter that vehicle again!


**Hotfix (v2.3.1)**

- fixed a nil value resulting in an SQL error


**Update (v2.3)**

- added xenon light colour to saved values
- added a blacklist for vehicles or whole classes as a config option
- added a configurable feature that allows to set an interval at which every vehicle 
  that is currently in the world will be deleted if it is too far away from a player.
  This is mainly useful for large servers with a lot of players. Players will receive 
  a notification prior to the deletion, so e.g. they can get to their vehicles before 
  it happens.
- (hopefully) fixed the CleanUp() function not working as expected
- fixed an error in the server console when deleting certain entities
- fixed another issue related to ESX.Game.DeleteVehicle that could prevent the vehicle 
  from being deleted if it happened just at the right moment: The code snippet inside 
  es_extended/client/functions.lua should look like this to prevent it:
ESX.Game.DeleteVehicle = function(vehicle)
    if (NetworkGetEntityIsNetworked(vehicle)) then
        TriggerServerEvent("AdvancedParking:deleteVehicle", GetVehicleNumberPlateText(vehicle), true)
        Citizen.Wait(300)
    end

    if (DoesEntityExist(vehicle)) then
        SetEntityAsMissionEntity(vehicle,  false,  true)
        DeleteVehicle(vehicle)
    end
end


**Update (v2.2)**

- fixed an error regarding vehicle plate changing
- finally re-added the command to completely wipe the database (was apparently 
  forgotten by me from v1.0 :D )


**Update (v2.1)**

- fixed a bug that could result in the respawning of a deleted vehicle
- changed a few things when spawning a vehicle (hopefully resolves all instances of 
  not properly saving vehicle health)
- if there is an update to a vehicle when the same vehicle is already spawned in the 
  world somewhere, it will first try to despawn that one in order to not create a 
  duplicate vehicle
- added nil-error handling for events that need to be triggered from other scripts
- fixed documentation of compatibility with replacing ESX.Game.DeleteVehicle:
    ESX.Game.DeleteVehicle = function(vehicle)
        if (NetworkGetEntityIsNetworked(vehicle)) then
            TriggerServerEvent("AdvancedParking:deleteVehicle", GetVehicleNumberPlateText(vehicle), true)
        end
        SetEntityAsMissionEntity(vehicle,  false,  true)
        DeleteVehicle(vehicle)
    end


**Update (v2.0)**

- IF YOU UPDATE FROM AN OLDER VERSION: YOU NEED TO EMPTY THE vehicle_parking TABLE 
  FROM YOUR DATABASE! (this should be the only time you need to do this!)
- Complete rewrite of the code base
- Server now spawns the vehicle
- Server automatically checks for position, rotation, lockStatus, bodyHealth, 
  engineHealth and petrolTankHealth and updates accordingly
- Manual update of vehicles only necessary when other values are being changed
- Vehicles that are purely client-side (meaning they can only be seen by one player) 
  are now not saved anymore
- Expanded the server event "AdvancedParking:deleteVehicle" with a boolean value 
  indicating if the vehicle should be deleted from the world and not only the table.
- Vehicle Extras now working properly
- Exploded vehicles now also spawn with a scorched look
- Broken windows now saved
- Flat tires / On rims now saved
- Missing doors now saved
- bulletproof tires now saved


**Performance**

- Client Side: 0.02ms when idle and up to 0.04ms while spawning a vehicle
- Server Side: 0.02-0.03ms


**What to do to ensure compatibility with other scripts?**

This script automatically saves EVERY SINGLE VEHICLE a player enters. And this means 
EVERY vehicle! Cars, Bikes, Boats, Planes, Helicopters, etc.. This can of course 
create problems when the player enters a vehicle that should not be saved. 

Some shops and garages are spawning a sort-of "preview" vehicle and putting the player 
inside. If this vehicle is a networked vehicle (meaning every player can see it), then 
this vehicle will be saved by my script! Of course you don't want that. This is why I 
provide this event on client side:
TriggerEvent("AdvancedParking:enable", enable)
Triggering the event with the enable variable set to false effectively disables the 
script for that client and he can use any vehicle without it being saved. Triggering 
it with true re-enables the scripts functionality again.
Example for shops that spawn networked vehicles:
Trigger with false when opening the shop menu and trigger with true when closing the 
menu or buying a vehicle.

Scripts, that update a vehicle from the OUTSIDE can cause problems as well. The only 
values that will be registered automatically (where you don't need to do anything) are: 
position, rotation, lockStatus, bodyHealth, engineHealth, petrolTankHealth
If anything else changes from the OUTSIDE, you need to trigger the following client 
event:
TriggerEvent("AdvancedParking:updateVehicle", vehicle)
Replace the vehicle variable with the vehicle of course.
An Example could be an LSCustoms where the vehicle is tuned when no player is inside.

Vehicles are saved by their license plate. And these need to be unique! Otherwise they 
will override each other!
If you change a vehicles license plate while it is saved in the scripts table, it needs 
to be updated as well. There is another event for this:
TriggerServerEvent("AdvancedParking:updatePlate", oldPlate, newPlate)
Replace oldPlate with the old plate of the vehicle and newPlate with the new one.
An example for this would be a license plate changer script. Trigger this when you are 
sure, that there are no duplicates.

If you delete a vehicle from the OUTSIDE, this vehicle also needs to be deleted from 
the scripts table. For this I provide another event:
TriggerServerEvent("AdvancedParking:deleteVehicle", vehiclePlate, deleteEntity)
Replace vehiclePlate with the vehicles plate and deleteEntity should be true, if you 
also want to delete the vehicle from the world! If you set deleteEntity to false, it 
will simply delete it from the scripts table, but not from the world.
An example for this would be in police scripts the impound function. The event needs 
to be triggered before the vehicle is deleted. But the best way (for ESX users) is to 
simply make a little change in es_extended:
Go to es_extended/client/functions.lua and find the following function (might be 
different depending on your version) and add the 3 lines from "if" til "end":
ESX.Game.DeleteVehicle = function(vehicle)
    if (NetworkGetEntityIsNetworked(vehicle)) then
        TriggerServerEvent("AdvancedParking:deleteVehicle", GetVehicleNumberPlateText(vehicle), true)
        Citizen.Wait(300)
    end
    SetEntityAsMissionEntity(vehicle,  false,  true)
    DeleteVehicle(vehicle)
end
If you don't want to fiddle in ESX itself, this event needs to be triggered anywhere 
you could need it.



**OLD UPDATES**

**Update (v1.4)**

- Fixed an error on serverside that could happen, when a vehicle was updated that 
  was not already registered in the database.


**Update (v1.3)**

- (probably) fixed duplicating vehicles in a certain case


**Update (v1.2)**

- Fixed saving and re-applying of all vehicle health values
- Fixed compatibility with several scripts that used "Previews" of vehicles (mainly 
  vehicle shops and some garages) by adding a client event that has to be triggered when 
  the script should stop (and start) working again.
  Stopping: TriggerEvent("AdvancedParking:enable", false)
  Starting: TriggerEvent("AdvancedParking:enable", true)


**Update (v1.1)**

- Bugfix: Compatibility with Garage from Codesign (vehicle did respawn after storing 
  in garage)
- Bugfix: liveries not saving properly
- custom wheels saving
- new Client Event to trigger a manual update of a vehicle: TriggerEvent("AdvancedParking:updateVehicle", vehicle)
  This needs to be done when working with the vehicles from outside! E.g. when locking a 
  vehicle this event needs to be added to your lockscript
- Admin Command for deleting all vehicles from the database table: "deleteSavedVehicles" 
  (needs to be executed twice to take effect)
- GTA spawn limit for vehicles now taken into account when spawning vehicles (a client 
  can now spawn maximum of 32 vehicles)


**Features (v1.0)**

- Park any vehicle (cars, planes, boats, bikes, etc.) anytime anywhere!
- Vehicles are saved with
  - status (engine health, dirt level, fuel level etc.)
  - mods (spoiler, bumper, performance tuning, etc.)
  - colours (primary, secondary, etc.)
  - extras (all vehicles extras (e.g. the banshee roof)
- Configurable spawn distance (when a vehicle despawned or after e.g. server restart)
- Configurable debug mode (debug messages to figure out what's wrong)
- Configurable "cleanup" time for the cleanup functionality
- includes full source code


**Planned features:**

- expanded cleanup functionality
- feel free to provide any suggestions and feedback!


**How does it clean up the server?**

Currently I only provide a function "CleanUp()" on server side. This way you can 
decide on your own when you want to call it. By default it just does it on script 
startup. It saves the last update of  a vehicle in the database and uses this to 
remove it after a time threshold (by default this is one week). This will be 
expanded in the future. I just wanted to get this script finally out there.


**Requirements:**

- [MySQL Async Library](https://forum.cfx.re/t/release-mysql-async-library-3-3-2/21881) (v3.3.2)
- OneSync
