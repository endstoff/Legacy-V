Strings = {
    -- blips
    ["purchasable_house"] = "Purchasable house",
    ["owned_house"] = "Owned house",
    ["access_house"] = "House you have a key to",
    ["purchased_house"] = "Someone's house",

    ["purchasable_apartment"] = "Purchasable apartment",
    ["owned_apartment"] = "Owned apartment",
    ["access_apartment"] = "Apartment you have a key to",
    ["purchased_apartment"] = "Someone's apartment",

    ["ikea"] = "IKEA",
    ["robbery"] = "Robbery",

    -- text for buttons
    ["buy_house"] = "Press ~INPUT_CONTEXT~ to purchase ~b~%s~s~ for ~g~$%s~s~.",
    ["enter"] = "Press ~INPUT_CONTEXT~ to enter the building.",
    ["door"] = "Press ~INPUT_CONTEXT~ to open the door menu (%s)",
    ["enter_ikea"] = "Press ~INPUT_CONTEXT~ to enter IKEA.\nPress   ~INPUT_DETONATE~to sell your furniture.",
    ["furnishing"] = "Item: %s\nSpeed: %s ~INPUT_COVER~ ~INPUT_TALK~\nUse ~INPUT_WEAPON_WHEEL_PREV~ ~INPUT_WEAPON_WHEEL_NEXT~ to move the furniture up/down\nUse ~INPUT_ATTACK~ ~INPUT_AIM~ to rotate the object\nUse ~INPUT_CELLPHONE_LEFT~ ~INPUT_CELLPHONE_RIGHT~ ~INPUT_CELLPHONE_UP~ ~INPUT_CELLPHONE_DOWN~ to move the object\nPress ~INPUT_DETONATE~ to teleport the object to you\nPress ~INPUT_FRONTEND_RDOWN~ to confirm.\nPress ~INPUT_FRONTEND_RRIGHT~ to cancel.",
    ["access_storage"] = "Press ~INPUT_DETONATE~ to access the storage.",
    ["press_manage"] = "\nPress ~INPUT_DETONATE~ to manage this house",
    ["enter_garage"] = "Press ~INPUT_CONTEXT~ to enter the garage.",
    ["store_garage"] = "Press ~INPUT_CONTEXT~ to store the vehicle.",
    ["breach_door"] = "\nPress ~INPUT_DETONATE~ to breach the door.",
    ["lockpick_door"] = "\nPress ~INPUT_DETONATE~ to lockpick the door.",
    ["pole_dance"] = "Press ~INPUT_CONTEXT~ to pole dance",
    ["stop_dancing"] = "Press ~INPUT_VEH_DUCK~ to stop dancing",
    ["lap_dance"] = "Press ~INPUT_CONTEXT~ to lap dance\nPress   ~INPUT_VEH_EXIT~to sit",
    ["storage_wardrobe"] = "Storage or wardrobe",
    ["storage_option"] = "Open storage",
    ["wardrobe_option"] = "Open wardrobe",
    ["select_outfit"] = "Select an outfit",
    ["lockpicking"] = "When the lock slows down, you are close to the right position.\nLockpicks left: %s\n\nUse ~INPUT_CELLPHONE_LEFT~ ~INPUT_CELLPHONE_RIGHT~ to turn the lock\n~INPUT_FRONTEND_RDOWN~ unlock\n~INPUT_FRONTEND_RRIGHT~ Cancel",

    -- ikea
    ["viewing_furniture"] = "Browsing ~r~%s~s~.\nUse ~INPUT_REPLAY_BACK~ ~INPUT_REPLAY_ADVANCE~ to change item.\nUse ~INPUT_REPLAY_FFWD~ ~INPUT_REPLAY_REWIND~ to change category.\nUse ~INPUT_MOVE_LEFT_ONLY~ ~INPUT_MOVE_RIGHT_ONLY~ to rotate the object.\nUse ~INPUT_MOVE_UP_ONLY~ ~INPUT_MOVE_DOWN_ONLY~ to zoom.%s\nPress ~INPUT_FRONTEND_RDOWN~ to buy ~b~%s~s~ for ~g~$%s~s~.\nPress ~INPUT_FRONTEND_RRIGHT~ to exit IKEA.",
    ["confirm_purchase"] = "Purchase ~b~%s~s~ for ~g~$%s~s~?\n\n~INPUT_FRONTEND_RDOWN~ Purchase\n~INPUT_FRONTEND_RRIGHT~ Cancel",
    ["purchased"] = "Purchased %s for ~g~$%s~s~.",
    ["storage"] = "\nYou can store stuff in this item.",

    -- locked state
    ["locked"] = "Locked",
    ["unlocked"] = "Unlocked",
    
    -- text for menus 
    ["house_key"] = "House key",
    ["door_menu"] = "Door menu",
    ["toggle_lock"] = "Lock / unlock",
    ["exit"] = "Exit",
    ["furnish"] = "Furnish",
    ["put_furniture"] = "Place furniture",
    ["manage_furniture"] = "Manage furniture",
    ["amount_furniture"] = "x%s %s",
    ["confirm_house_purchase"] = "Purchase %s for <span style='color:lime'>$%s</span>",
    ["are_you_sure"] = "Purchase %s?",
    ["remove_furniture"] = "Remove %s?",
    ["inventory"] = "Storage",
    ["inventory_weapons"] = "Storage - weapons",
    ["inventory_items"] = "Storage - items",
    ["black_money"] = "Black money: <span style='color:red'>$%s</span>",
    ["cash"] = "Cash: <span style='color:lime'>$%s</span>",
    ["put"] = "Deposit item",
    ["get"] = "Withdraw item",
    ["deposit"] = "Deposit",
    ["withdraw"] = "Withdraw",
    ["weapons"] = "Weapons",
    ["items"] = "Items",
    ["amount_of"] = "Amount of %s?",
    ["make_key_copy"] = "Make a copy of your key",
    ["resell_house"] = "Sell the house back for <span style='color:lime'>$%s</span>",
    ["kick_someone_out"] = "Kick someone out",
    ["kick_out?"] = "Kick out %s?",
    ["kick_out"] = "Kick out %s",
    ["preview"] = "Preview possible interiors",
    ["previewing"] = "~h~Previewing interiors\n\n~h~~s~You will get one of these when buying the property.\nPreviewing interior %s out of %s possible.\nUse ~INPUT_CELLPHONE_LEFT~ ~INPUT_CELLPHONE_RIGHT~ to preview other interiors\nPress ~INPUT_FRONTEND_RRIGHT~ to stop previewing.",
    ["transfer_house"] = "Transfer ownership",
    ["transfer_property"] = "Transfer property to %s?",
    ["none_nearby"] = "There's nobody nearby",
    ["yes"] = "Yes",
    ["no"] = "No",

    -- text for notifications
    ["no_spawn"] = "Couldn't find a location for the house/apartment.\n\nTell your server owner to add more locations.",
    ["error_locked"] = "Couldn't enter the house/apartment - the door is locked.",
    ["not_near_door"] = "You are not nearby the door and can therefore not lock / unlock it.",
    ["must_be_number"] = "You must enter a number.",
    ["dont_have"] = "You don't have that much.",
    ["not_enough"] = "There's not enough in the storage.",
    ["cant_carry"] = "You can't carry that much.", 
    ["has_items"] = "This object has items in it, and you can therefore not remove it. Make sure to empty the storage!",
    ["someone_in_house_cant_sell"] = "Someone is in the house - you can't sell it now!",
    ["cant_own_more"] = "You can't own more properties.",
    ["no_lockpicks"] = "You don't have any lockpicks.",
    ["robbery_progress"] = "ALERT!! Someone is robbing a house! Check your GPS!",
    ["you_got_kicked"] = "You got kicked out from the home.",
    ["house_spawned_transfer"] = "Someone is inside, you can not transfer the property.",
    ["nolonger_nearby"] = "The player is no longer nearby.",

    -- text for loading
    ["purchasing"] = "Purchasing",
    ["removing_furniture"] = "Removing furniture",
    ["loading_object"] = "Loading object",
    ["loading_storage"] = "Loading storage",

    -- other
    ["rotation"] = "Rotation: %s",
    ["not_enough_cops"] = "There are not enough police online!",
}