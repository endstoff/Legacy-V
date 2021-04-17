-------------------------------------
------- Created by T1GER#9080 -------
------------------------------------- 

Lang = {
  -- Menu Text:
  ['button_yes']         	    = 'Ja',
  ['button_no']         	    = 'Nein',
  ['button_return']         	= 'Zurück',
  ['rename_mech_shop']        = 'Werkstatt umbenennen',
  ['sell_mech_shop']          = 'Werkstatt verkaufen',
  ['employees_action']        = 'Mitarbeiter',
  ['hire_employee']           = 'Mitarbeiter einstellen',
  ['employee_list']           = 'Mitarbeiterliste',
  ['fire_employee']           = 'Mitarbeiter feuern',
  ['employee_job_grade']      = 'Mitarbeiterränge verwalten',
  ['accounts_action']         = 'Konten',
  ['account_withdraw']        = 'Geld abheben',
  ['account_deposit']         = 'Geld einzahlen',
  ['storage_withdraw']        = 'Gegenstände herausnehmen',
  ['storage_deposit']         = 'Gegenstände einlagern',
  ['craft_item']              = 'Gegenstand herstellen',
  ['view_recipe']             = 'Bauplan anschauen',

  -- GENERAL | NOTIFICATIONS
  ['not_enough_money']        = 'Du hast nicht genug Geld.',
  ['mech_shop_bought']        = 'Du hast einen ~b~Werkstatt Shop~s~ gekauft für ~g~$%s~s~',
  ['mech_shop_sold']          = 'Du hast deinen ~b~Werkstatt Shop~s~ verkauft für ~g~$%s~s~',
  ['not_your_mech_shop']      = 'Dir gehört dieser Shop nicht',
  ['mech_shop_renamed']       = 'Du hast deinen Shop umbenannt in: ~b~%s~s~',
  ['no_access']               = 'Kein Zugriff',
  ['invalid_amount']          = 'Ungültige Menge',
  ['repair_kit_broke']        = 'Reparatur Kit wurde zerstört.',
  ['repairkit_veh_repaired']  = 'Der Motor wurde repariert, begib dich zur nächsten Werkstatt.',
  ['no_vehicle_nearby']       = 'Kein Fahrzeug in der Nähe.',
  ['no_players_nearby']       = 'Keine Spieler in der Nähe.',

  -- EMPLOYEE | NOTIFICATIONS
  ['no_employees_hired']      = 'Keine Mitarbeiter eingestellt',
  ['mech_employee_fired']     = 'Du wurdest von der Werkstatt gefeuert.',
  ['target_alrdy_has_job_g']  = '%s hat bereits diesen Rang.',
  ['your_job_grade_updated']  = 'Dein Rang ist jetzt: %s.',
  ['you_updat_job_grade_for'] = 'Du hast: %s zu: Rang %s befördert.',
  ['mix_max_job_grade']       = 'Niedrigster Rang: 0 | Höchster Rang: %s.',
  ['already_hired']           = 'Spieler ist bereits eingestellt.',
  ['you_recruited_x']         = 'Du hast: %s eingestellt.',
  ['you_have_been_recruited'] = 'Du wurdest bei dem Werkstatt Shop eingestellt.',

  -- ACCOUNTS & STORAGE & WORKBENCH | NOTIFICATIONS
  ['you_withdrew_x_amount']   = 'Du hast ~g~$%s~s~ herausgenommen.',
  ['withdrawal_denied']       = 'Nicht genug Bestand.',
  ['you_deposited_x_amount']  = 'Du hast ~g~$%s~s~ eingelagert.',
  ['storage_inv_empty']       = 'Lagerbestand ist leer.',
  ['storage_deposited_x']     = 'Du hast: %sx %s eingelagert.',
  ['not_enough_items']        = 'Nicht genug zum einlagern.',
  ['storage_withdrew_x']      = 'Du hast: %sx %s ausgelagert.',
  ['too_high_count']          = 'Die verlangte Menge ist zu hoch',
  ['not_enough_materials']    = 'Du brauchst mehr Material, schau auf den Bauplan!',
  ['crafting_in_progress']    = 'Es wird bereits etwas hergestellt!',

  -- VEHICLE BODY REPAIRS | NOTIFICATIONS
  ['car_jack_carry']          = 'Du brauchst einen Wagenheber.',
  ['raise_and_analyze']       = 'Du musst das Auto erst aufbocken und analysieren bevor du Teile einbaust.',
  ['analyze_veh_first']       = 'Analysiere den Wagen bevor du Teile installierst.',
  ['all_doors_intact']        = 'Alle Türen wurden repariert und sind intakt.',
  ['trunk_already_installed'] = 'Kofferraum wurde schon installiert.',
  ['hood_already_installed']  = 'Motorhaube wurde bereits installiert.',
  ['all_wheels_intact']       = 'Alle Räder wurden repariert und sind intakt.',
  ['all_body_repairs_done']   = 'Alle Karosseriereparaturen sind abgeschlossen setz das Fahrzeug herab!',
  ['finish_current_install']  = 'Schliesse deine momentane Montur ab',
  ['veh_already_analyzed']    = 'Fahrzeug wurde bereits analysiert, mach deine Arbeit!',
  ['raise_veh_b4_analyze']    = 'Du musst das Fahrzeug aufbocken um es zu analysieren.',

  -- LIFT REPAIRS & HEALTH PARTS | NOTIFICATIONS
  ['lift_cannot_go_higher']   = 'Hebebühne am oberen Limit!',
  ['lift_cannot_go_lower']    = 'Hebebühne am niedrigsten Limit!',
  ['veh_must_be_on_lift']     = 'Fahrzeug muss auf einer Hebebühne sein.',
  ['veh_must_be_inspected']   = 'Inspiziere das Auto bevor du Motorteile reparierst.',
  ['health_part_exceeded']    = 'Motorteilzustand kann 10.0 nicht überschreiten',
  ['not_decrease_health_val'] = 'Du kannst den aktuellen Motorteile Wert nicht unterschreiten.',
  ['not_decrse_or_same_val']  = 'Du kannst den aktuellen Zustand nicht unterschreiten oder mit dem gleichen ersetzen, du brauchst einen besseren Zustand!',
  ['need_more_materials']     = 'Du brauchst mehr Teile um auf den gewünschten Zustand zu kommen.',
  ['you_rep_health_part']     = 'Du hast repariert: %s. Der neue Zustand ist: %s',

  -- NPC JOB | NOTIFICATIONS
  ['npc_shout_msg']           = 'Hey! Kannst du mein Auto reparieren?',
  ['npc_need_repair_kit']     = 'Du brauchst ein Reperaturkit.',
  ['npc_kit_broke']           = 'Während der Reparatur ist dein Kit kaputt gegangen.',
  ['npc_veh_repaired']        = 'Fahrzeug repariert. Sammel das Geld beim NPC ein.',
  ['npc_thanking_msg']        = 'Vielen Dank ihnen, adios!',
  ['npc_cancel_job_death']    = 'Du wurdest bewusstlos! Der Job wurde abgebrochen.',
  ['npc_job_cancel_by_ply']   = 'Du hast den aktuellen Job abgebrochen.',
  ['npc_job_cash_reward']     = 'Du hast: ~g~$%s~s~ vom NPC erhalten.',

  -- Draw 3D texts:
  ['mech_shop_manage']        = '~r~[E]~s~ Shop verwalten',
  ['no_access_to_shop']       = 'Kein Shop-Zugriff',
  ['press_to_buy_shop']       = '~r~[E]~s~ Werkstatt-Shop kaufen',
  ['only_one_mech_shop']      = 'DU KANNST NUR 1 WERKSTATT BESITZEN',
  ['repair_here']             = '~g~[E]~s~ Fahrzeug reparieren',
  ['press_to_storage']        = '~r~[E]~s~ LAGER',
  ['press_to_workbench']      = '~r~[E]~s~ WERKBANK',
  ['lower_jack']              = 'Wagenheber senken',
  ['raise_jack']              = 'Wagenheber anheben',
  ['analyze_here']            = '~r~[E]~s~ Hier analysieren',
  ['install_body_part']       = '~r~[G]~s~ Karosserieteil montieren',
  ['park_on_lift']            = '~r~[E]~s~ Auf Hebebühne parken',
  ['lift_occupied']           = 'HEBEBÜHNE BESETZT',
  ['remove_or_move_veh']      = '~r~[G]~s~ Veh entfernen | ~y~[Arrow Up/Dn]~s~ Veh Bewegen',
  ['no_veh_to_control']       = 'Kein Veh zum bedienen',
  ['health_rep_here']         = '~r~[E]~s~ Hier reparieren',
  ['inspect_here']            = '~r~[E]~s~ Hier inspizieren',
  ['repair_engine']           = '~r~[E]~s~ Motor reparieren',
  ['npc_repair_veh']          = '~r~[E]~s~ Fahrzeug reparieren',
  ['npc_collect_cash']        = '~r~[E]~s~ Geld einsammeln',
  
  -- Progress Bar Texts:
  ['repairing_veh_kit']       = 'FAHRZEUG REPARATUR',
  ['crafting_item']           = 'HERSTELLUNG: %s',
  ['progbar_lowering_jack']   = 'WAGENHEBER SENKEN',
  ['progbar_raising_jack']    = 'WAGENHEBER HEBEN',
  ['progbar_inspecting_veh']  = 'FAHRZEUG INSPIZIEREN',
  ['progbar_analyzing_veh']   = 'FAHRZEUG ANALYSIEREN',
  ['lift_repairing_veh']      = 'REPARIEREN: %s',
  ['progbar_npc_fix']         = 'NPC FAHRZEUG REPARIEREN',
  ['progbar_npc_cash']        = 'GELD EINSAMMELN',

  -- Blip Texts:
  ['vacant_shops']            = 'Leerstehender Werkstatt-Shop',
  ['npc_repair_job']          = 'NPC Fahrzeug reparieren',
  
}
