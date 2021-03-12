local labels = {
  ['en'] = {
    ['Entry']       = "Entry",
    ['Exit']        = "Exit",
    ['Garage']      = "Garage",
    ['Wardrobe']    = "Wardrobe",
    ['Inventory']   = "Inventory",
    ['InventoryLocation']   = "Inventory",

    ['LeavingHouse']      = "Leaving house",

    ['EquipOutfit']       = "Equip Outfit",
    ['DeleteOutfit']      = "Delete Outfit",
    ['LeftHouse']         = "You left the house and aborted the action.",

    ['AccessHouseMenu']   = "Access the house menu",

    ['InteractDrawText']  = "["..Config.TextColors[Config.MarkerSelection].."E~s~] ",
    ['InteractHelpText']  = "~INPUT_PICKUP~ ",

    ['AcceptDrawText']    = "["..Config.TextColors[Config.MarkerSelection].."G~s~] ",
    ['AcceptHelpText']    = "~INPUT_DETONATE~ ",

    ['FurniDrawText']     = "["..Config.TextColors[Config.MarkerSelection].."F~s~] ",
    ['CancelDrawText']    = "["..Config.TextColors[Config.MarkerSelection].."F~s~] ",

    ['VehicleStored']     = "Vehicle stored",
    ['CantStoreVehicle']  = "You can't store this vehicle",

    ['HouseNotOwned']     = "You don't own this house",
    ['InvitedInside']     = "Accept house invitation",
    ['MovedTooFar']       = "You moved too far from the door",
    ['KnockAtDoor']       = "Someone is knocking at your door",

    ['TrackMessage']      = "Track message",

    ['Unlocked']          = "House unlocked",
    ['Locked']            = "House locked",

    ['WardrobeSet']       = "Wardrobe set",
    ['InventorySet']      = "Inventory set",

    ['ToggleFurni']       = "Toggle furniture UI",

    ['GivingKeys']        = "Giving keys to player",
    ['TakingKeys']        = "Taking keys from player",

    ['GarageSet']         = "Garage location set",
    ['GarageTooFar']      = "Garage is too far away",

    ['PurchasedHouse']    = "You bought the house for $%d",
    ['CantAffordHouse']   = "You can't afford this house",

    ['MortgagedHouse']    = "You mortgaged the house for $%d",

    ['NoLockpick']        = "You don't have a lockpick",
    ['LockpickFailed']    = "You failed to crack the lock",
    ['LockpickSuccess']   = "You successfully cracked the lock",

    ['NotifyRobbery']     = "Someone is attempting to rob a house at %s",

    ['ProgressLockpicking'] = "Lockpicking Door",

    ['InvalidShell']        = "Invalid house shell: %s, Bitte gehe mit diesem Fehler zum Support.",
    ['ShellNotLoaded']      = "Shell would not load: %s, Bitte gehe mit diesem Fehler zum Support.",
    ['BrokenOffset']        = "Offset is messed up for house with ID %s, Bitte gehe mit diesem Fehler zum Support.",

    ['UpgradeHouse']        = "Upgrade house to: %s",
    ['CantAffordUpgrade']   = "You can't afford this upgrade",

    ['SetSalePrice']        = "Set sale price",
    ['InvalidAmount']       = "Invalid amount entered",
    ['InvalidSale']         = "You can't sell a house that you still owe money on",
    ['InvalidMoney']        = "You don't have enough money",

    ['EvictingTenants']     = "Evicting tenants",

    ['NoOutfits']           = "You don't have any outfits stored",

    ['EnterHouse']          = "Enter House",
    ['KnockHouse']          = "Knock On Door",
    ['RaidHouse']           = "Raid House",
    ['BreakIn']             = "Break In",
    ['InviteInside']        = "Invite Inside",
    ['HouseKeys']           = "House Keys",
    ['UpgradeHouse2']       = "Upgrade House",
    ['UpgradeShell']        = "Upgrade Shell",
    ['SellHouse']           = "Sell House",
    ['FurniUI']             = "Furni UI",
    ['SetWardrobe']         = "Set Wardrobe",
    ['SetInventory']        = "Set Inventory",
    ['SetGarage']           = "Set Garage",
    ['LockDoor']            = "Lock House",
    ['UnlockDoor']          = "Unlock House",
    ['LeaveHouse']          = "Leave House",
    ['Mortgage']            = "Mortgage",
    ['Buy']                 = "Buy",
    ['View']                = "View",
    ['Upgrades']            = "Upgrades",
    ['MoveGarage']          = "Move Garage",

    ['GiveKeys']            = "Give Keys",
    ['TakeKeys']            = "Take Keys",

    ['MyHouse']             = "My House",
    ['PlayerHouse']         = "Player House",
    ['EmptyHouse']          = "Empty House",

    ['NoUpgrades']          = "No upgrades available",
    ['NoVehicles']          = "No vehicles",
    ['NothingToDisplay']    = "Nothing to display",

    ['ConfirmSale']         = "Yes, sell my house",
    ['CancelSale']          = "No, don't sell my house",
    ['SellingHouse']        = "Sell House ($%d)",

    ['MoneyOwed']           = "Money Owed: $%s",
    ['LastRepayment']       = "Last Repayment: %s",
    ['PayMortgage']         = "Pay Mortgage",
    ['MortgageInfo']        = "Mortgage Info",

    ['SetEntry']            = "Set Entry",
    ['CancelGarage']        = "Cancel Garage",
    ['UseInterior']         = "Use Interior",
    ['UseShell']            = "Use Shell",
    ['InteriorType']        = "Set Interior Type",
    ['SetInterior']         = "Select Current Interior",
    ['SelectDefaultShell']  = "Select default house shell",
    ['ToggleShells']        = "Toggle shells available for this property",
    ['AvailableShells']     = "Available Shells",
    ['Enabled']             = "~g~ENABLED~s~",
    ['Disabled']            = "~r~DISABLED~s~",
    ['NewDoor']             = "Add New Door",
    ['Done']                = "Done",
    ['Doors']               = "Doors",
    ['Interior']            = "Interior",

    ['CreationComplete']    = "House creation complete.",

    ['HousePurchased'] = "Your house was purchased for $%d",
    ['HouseEarning']   = ", you earnt $%d from the sale."
  },

  ['de'] = {
    ['Entry']       = "Eingang",
    ['Exit']        = "Ausgang",
    ['Garage']      = "Garage",
    ['Wardrobe']    = "Umkleide",
    ['Inventory']   = "Lager",
    ['InventoryLocation']   = "Lager",

    ['LeavingHouse']      = "Leaving house",

    ['EquipOutfit']       = "Outift Wählen",
    ['DeleteOutfit']      = "Outift löschen",
    ['LeftHouse']         = "Du hast das Haus verlassen und die Aktion abgebrochen.",

    ['AccessHouseMenu']   = "Hausmenü öffnen",

    ['InteractDrawText']  = "["..Config.TextColors[Config.MarkerSelection].."E~s~] ",
    ['InteractHelpText']  = "~INPUT_PICKUP~ ",

    ['AcceptDrawText']    = "["..Config.TextColors[Config.MarkerSelection].."G~s~] ",
    ['AcceptHelpText']    = "~INPUT_DETONATE~ ",

    ['FurniDrawText']     = "["..Config.TextColors[Config.MarkerSelection].."F~s~] ",
    ['CancelDrawText']    = "["..Config.TextColors[Config.MarkerSelection].."F~s~] ",

    ['VehicleStored']     = "Fahrzeug eingeparkt",
    ['CantStoreVehicle']  = "Du kannst das Fahrzeug nicht einparken",

    ['HouseNotOwned']     = "Du besitzt dieses Haus nicht",
    ['InvitedInside']     = "Hauseinladen annehmen",
    ['MovedTooFar']       = "Du hast dich zuweit von der Tür entfernt",
    ['KnockAtDoor']       = "Jemand klopft an deiner Tür",

    ['TrackMessage']      = "Nachricht nachverfolgen",

    ['Unlocked']          = "Haus aufgesperrt",
    ['Locked']            = "Haus abgesperrt",

    ['WardrobeSet']       = "Umkleider setzen",
    ['InventorySet']      = "Lager setzen",

    ['ToggleFurni']       = "Einrichtungsmenü Umschalten",

    ['GivingKeys']        = "Schlüssel an Spieler weitergeben",
    ['TakingKeys']        = "Schlüssel von Spieler nehemen",

    ['GarageSet']         = "Garage wurde gesetzt",
    ['GarageTooFar']      = "Garage ist zu weit Entfernt",

    ['PurchasedHouse']    = "Du hast das Haus für $%d gekauft",
    ['CantAffordHouse']   = "Du kannst dir das Haus nicht leisten",

    ['MortgagedHouse']    = "Du hast das Haus mit einer Hypothek belastet für $%d",

    ['NoLockpick']        = "Du hast keinen Dietrich",
    ['LockpickFailed']    = "Du hast versagt das Schloss zu knacken",
    ['LockpickSuccess']   = "Du hast das Schloss geknackt",

    ['NotifyRobbery']     = "Jemand versucht bei %s in ein Haus einzubrechen",

    ['ProgressLockpicking'] = "Knacke Schloss",

    ['InvalidShell']        = "Ungültiger Shell: %s, Bitte gehe mit diesem Fehler zum Support.",
    ['ShellNotLoaded']      = "Shell konnte nicht geladen werden: %s, Bitte gehe mit diesem Fehler zum Support.",
    ['BrokenOffset']        = "Offset ist am Arsch mit der ID %s, Bitte gehe mit diesem Fehler zum Support.",

    ['UpgradeHouse']        = "Haus zu %s Upgraden",
    ['CantAffordUpgrade']   = "Du kannst dir dieses Upgrad nicht leisten",

    ['SetSalePrice']        = "Verkaufspreis setzen",
    ['InvalidAmount']       = "Ungültige Eingabe",
    ['InvalidSale']         = "Du kannst ein Haus nicht verkaufen, auf dem du noch Schulden hast",
    ['InvalidMoney']        = "Du hast nicht genug Geld",

    ['EvictingTenants']     = "Mieter zwangsräumen",

    ['NoOutfits']           = "Du hast keine Outifts in deinem Schrank",

    ['EnterHouse']          = "Haus betreten",
    ['KnockHouse']          = "An der Tür klopfen",
    ['RaidHouse']           = "Raid House",
    ['BreakIn']             = "Einbrechen",
    ['InviteInside']        = "In das Haus einladen",
    ['HouseKeys']           = "Hausschlüssel",
    ['UpgradeHouse2']       = "Haus Upgraden",
    ['UpgradeShell']        = "Shell Upgraden",
    ['SellHouse']           = "Haus verkaufen",
    ['FurniUI']             = "Einrichtungsmenü",
    ['SetWardrobe']         = "Set Wardrobe",
    ['SetInventory']        = "Lager setzen",
    ['SetGarage']           = "Garage setzen",
    ['LockDoor']            = "Tür Absperren",
    ['UnlockDoor']          = "Tür Aufsperren",
    ['LeaveHouse']          = "Haus verlassen",
    ['Mortgage']            = "Hypothek",
    ['Buy']                 = "Kaufen",
    ['View']                = "Besichtigen",
    ['Upgrades']            = "Upgrades",
    ['MoveGarage']          = "Garage versetzen",

    ['GiveKeys']            = "Schlüssel weitergeben",
    ['TakeKeys']            = "Schlüssel zurücknehmen",

    ['MyHouse']             = "Mein Haus",
    ['PlayerHouse']         = "Spieler Haus",
    ['EmptyHouse']          = "Leerstehendes Haus",

    ['NoUpgrades']          = "keine Upgrades Verfügbar",
    ['NoVehicles']          = "keine Fahrzeuge",
    ['NothingToDisplay']    = "Nichts zum Anzeigen",

    ['ConfirmSale']         = "Ja, Haus verkaufen",
    ['CancelSale']          = "Nein, ich möchte mein Haus nicht verkaufen",
    ['SellingHouse']        = "Haus verkaufen ($%d)",

    ['MoneyOwed']           = "Schulden: $%s",
    ['LastRepayment']       = "Letzte Rückzahlung: %s",
    ['PayMortgage']         = "Hypothek zahlen",
    ['MortgageInfo']        = "Hypothek Information",

    ['SetEntry']            = "Eingang setzen",
    ['CancelGarage']        = "Garage abbrechen",
    ['UseInterior']         = "Interior verwenden",
    ['UseShell']            = "Shell verwenden",
    ['InteriorType']        = "Set Interior Type",
    ['SetInterior']         = "Select Current Interior",
    ['SelectDefaultShell']  = "Select default house shell",
    ['ToggleShells']        = "Toggle shells available for this property",
    ['AvailableShells']     = "Verfügbare Shells",
    ['Enabled']             = "~g~AKTIVIERT~s~",
    ['Disabled']            = "~r~DEAKTIVIERT~s~",
    ['NewDoor']             = "Neue Tür hinzufügen",
    ['Done']                = "Fertig",
    ['Doors']               = "Türen",
    ['Interior']            = "Interior",

    ['CreationComplete']    = "Haus wurde erfolgreich erstellt.",

    ['HousePurchased'] = "Dein Haus wurde gekauft für $%d",
    ['HouseEarning']   = ", du hast $%d an dem Verkauf verdient."
  }
}

Labels = setmetatable({},{
  __index = function(self,k)
    if Config and Config.Locale and labels[Config.Locale] then
      if labels[Config.Locale][k] then
        return labels[Config.Locale][k]
      else
        return string.format("UNKNOWN LABEL: %s",tostring(k))
      end
    elseif labels['en'] then
      if labels[Config.Locale][k] then
        return labels[Config.Locale][k]
      else
        return string.format("UNKNOWN LABEL: %s",tostring(k))
      end
    else
      return string.format("UNKNOWN LABEL: %s",tostring(k))
    end
  end
})

