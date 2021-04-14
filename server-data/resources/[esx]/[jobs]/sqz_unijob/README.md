# sqz_unijob

Next the other things is, that this script was made, because I saw many servers having resources and jobs like:
esx_mafiajob, esx_vagosjob, esx_gangjob, esx_carteljob and these resources did not have anything more than this script
(at lease I think :-) ) and these scripts were taking about 0.46ms each and it is a lot.

This script includes basic things as: 
**handcuffing, uncuffing (with animations), draging person, searching person, putting person it/out of vehicle, revivng persons, billing, cleaning, repairing, deleting, attaching vehicles** and helicopter, vehicle spawner/deleter, config for blips, buying weapons with configuration, storage rooms (with permission config) and etc. ... (more below)

## Features overview
- Easy config and easy job adding
- Citizen interactions
- Vehicle interactions
- Revive
- Vehicle and helicopters easy configuration
- Beter optimalization the other
- 3dText instead of Help text
- Own label of billings
- Get number of ammo you deposited
- Every Armory has its own items
- Custom Armory system
- Job Shop
- Limit access to armories by job grades
- Easy adding blips
- Everybody has F6, but if Config Enabled, needs items
- Discord webhook log
- MySQL database log
- Custom vehicle spawn options (properties)
- Crafting items
- Collecting items
- Selling items

## Requierements
- es_extended (using weight system)
- esx_menu_default and esx_menu_dialog
- esx_society
- esx_billing

Lets see, how to install the script: *(This script was made to help beginning server which are at the start to be easy to configure)*
## Instalation:
```
1) Put sqz_unijob into your resources folder
2) Run the SQL file
3) Put licenses you get on the Discord to the license.lua
4) Configure Config.lua
```
## Configuration:
1) Configure your Config, items eventually add items to database if you need so:
```
You can add as much jobs as you want to, you only need to copy part of the Config beggining with "Config.Jobs", replace the job name - Config.Jobs.sandy_mechanic -> to -> Config.Jobs.your_job_name  (your_job_name is the name you add to the database or you set yourself the job using /setjob command)
```
2) Configure client/edit.lua & server/edit.lua

``` 
TriggerEvent('esx_phone:registerNumber', 'sandy_mechanic', 'SandyMechanic', true, true) -- If you do not add this and you will try to add the number into your gcphone or others phones, you will NOT receive any messages or calls to this number
TriggerEvent('esx_society:registerSociety', 'sandy_mechanic', 'SandyMechanic', 'society_sandy_mechanic', 'society_sandy_mechanic', 'society_sandy_mechanic', {type = 'public'}) -- This registers society and allows you boss menu 
```

### Starting:
```
start sqz_unijob
```

## Discord
You can chceck my Discord where I can help with problems and etc. ...
https://discord.gg/FVXAu2F

## To-DO
- Czech locale

## TOS:
- You are NOT allowed to share the code with other people that do not have access to it
- You are NOT allowed to try to decrypt it
- Any leaking and breaking the TOS may and WILL lead to blacklisting your IPs, ban from the Discord and adding you to Blacklist.

### You can edit this resource only in config, client and server side part, you can't rename the script or re-release it as yours and sell it as yours. For suggestions contact me to the PM -> Squizer#3020