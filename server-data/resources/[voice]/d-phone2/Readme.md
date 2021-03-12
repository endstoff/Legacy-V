<IMPORTANT>
THIS IS VERSION 0.6
Join my Discord and open a Ticket.

Then type in .checkpayment <YOURTRANCSACTIONID>
You received your transactionid in the email of tebex.

Discord Link  > https://discord.gg/tngc5yN6mf

YOU NEED TO ADD YOUR IP IN MY DISCORD WRITE THIS IN THE TICKET. OTHERWISE IT WONT WORK

<INSTALLATION>
1. Drag it in your resource folder 
2. add this in your server.cfg
 start d-phone
3. insert the sql in your database
4. Replace this to <esx_ambulancejob> > <client> > <main.lua>

Search for SendDistressSignal() and replace it with this

```lua
function SendDistressSignal()
	local playerPed = PlayerPedId()
	local coords    = GetEntityCoords(playerPed)
	local position = {x = coords.x, y = coords.y, z = coords.z}


	TriggerServerEvent("d-phone:server:sendservicemessage", GetPlayerServerId(PlayerId()), "Unconscious person", "yourambulancejoblabel", 0, 1, position, "5")
	TriggerEvent("d-notification", "Service Message sended", 5000,  "rgba(255, 0, 0, 0.8)")

end
```

Pay attention that you really replace "yourambulancejoblabel" in the function

5. GO in your Database and set the jobs which you want to have an businessapp

if hasapp = 1 then the job will have the app.
If onlyboss = 1 and hasapp = 1 then only the boss will have the app
if handyservice = 1 then it will be shown in the service app
if number = 1 then the service doenst have a own number. Simple change it to the number you want


If you want to replace a locale you need to change it in the config but also in the html > js > locales.js
There are some locales in the js > locales folder

7. If you dont have an item called "phone", create one in your database
6. YOU NEED TO ADD YOUR IP IN MY DISCORD WRITE THIS IN THE TICKET. OTHERWISE IT WONT WORK

<Support>
If there are any bugs then report these on my Discord > https://discord.gg/tngc5yN6mf

 <RIGHTS>
 You are not allowed to sell this script. 
 CREATOR: d-development.xyz
