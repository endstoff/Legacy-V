Config = {

Text = {

	['someone_is_waiting'] = 'Jemand hat die Tischklingel verwendet!',
	['press_to_call'] = '[~g~E~w~] Drücke um die Tischklingel zu benutzen',
	['please_wait'] = 'Ein Mitarbeiter wurde Informiert ~g~'

},

Desks = { --Setup deskbells for each job

  {coords = vector3(442.22555541992,-981.96704101562,31.689540863037 - 0.9), job = 'police'}             

}
	

}

-- Only change if you know what are you doing!
function SendNotice(msg)

		--SetNotificationTextEntry('STRING')
		AddTextComponentString(msg)
		DrawNotification(0,1)

		--USING MYTHIC EXAMPLE
		--exports['mythic_notify']:SendAlert('inform', msg)
		TriggerEvent('notify', 3, "", msg, 10000)

end
