-----------------------------------------------------------------------------------------------------------------------
 ######    #####   ######       ######                                                                                 
 #     #  #     #  #     #      #     #  ######  #    #  ######  #        ####   #####   #    #  ######  #    #  ##### 
 #     #  #        #     #      #     #  #       #    #  #       #       #    #  #    #  ##  ##  #       ##   #    #   
 ######    #####   ######       #     #  #####   #    #  #####   #       #    #  #    #  # ## #  #####   # #  #    #   
 #   #          #  #     #      #     #  #       #    #  #       #       #    #  #####   #    #  #       #  # #    #   
 #    #   #     #  #     #      #     #  #        #  #   #       #       #    #  #       #    #  #       #   ##    #   
 #     #   #####   ######       ######   ######    ##    ######  ######   ####   #       #    #  ######  #    #    # 
-----------------------------------------------------------------------------------------------------------------------




Event zum Triggern:

Clientside:
TriggerEvent('rsb_broadcast:display', 'TITEL',  'NACHRICHT', 'ZEIT IN MS')

Serverside: 
( Benutze -1 wenn die Nachricht an jeden Spieler gesendet werden soll und source wenn diese nur an dem Client durch dem das Event getriggered wird angezeigt werden soll)
 
TriggerClientEvent('rsb_broadcast:display', -1, 'TITEL',  'NACHRICHT', 'ZEIT IN MS')