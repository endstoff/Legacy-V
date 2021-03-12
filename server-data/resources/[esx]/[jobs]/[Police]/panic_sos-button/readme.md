## Requires 

<ESX/EXM>
<d-phone>



## Native D-Phone Trigger Dispatch 

TriggerServerEvent("d-phone:server:sendservicemessage", GetPlayerServerId(PlayerId()), "Unconscious person", "yourambulancejoblabel", 0, 1, position, "5")
TriggerEvent("d-notification", "Service Message sended", 5000,  "rgba(255, 0, 0, 0.8)")