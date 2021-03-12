Thanks for downloading the script!
For support and further updates you can join my Discord: https://discord.gg/UyAu2jABzE

Installation:
1.) Put the script in your ressources folder
2.) Import the multichar.sql to your database
3.) Set up the Config.lua
4.) Add 'start myMultichar' to your server.cfg

If you currently have KASHacters Multi Char running, this system should be able to perfectly adapt to this.
Important: You still have to import the .sql File! But afterwards all data should perfectly migrate to this system.

If you haven't installed any Multichar System before, be sure to remove the following thread in essentialmode/client/main.lua lines 6-18
--[[Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)

		if NetworkIsSessionStarted() then
			TriggerServerEvent('es:firstJoinProper')
			TriggerEvent('es:allowedToSpawn')
			return
		end
	end
end)

TriggerServerEvent('es:firstJoinProper')
--]]

Moreover you have to remove a small part from esx_skin. esx_skin/client/main.lua line 268. Should look like this:

	TriggerEvent('skinchanger:loadSkin', {sex = 0}, OpenSaveableMenu)

This could be removed. The script will automatically open the menu, when required.

From essentialmode/client/main.lua (Lines 6-16 normally)

Pay attention that ESX and NativeUI are running.
Right NativeUI version: https://github.com/FrazzIe/NativeUILua

