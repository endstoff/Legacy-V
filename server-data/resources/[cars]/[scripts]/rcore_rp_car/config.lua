Config = {
    License = '30add251a623b91e52bceb70fd71f2ba', -- Insert your rcore license
    
    --[[
        -- To use custom notifications, implement client event handler, example:
        AddEventHandler('teb_rp_car:noMoreSpareError', function()
            print('There is no spare in the trunk')
        end)
    ]]
    CustomNotifications = false,

    Duration = 30000,
    SpareCount = 1,
    BurstTreshold = 10.0,

    Keys = {
        TAKE_FROM_TRUNK = {code = 38, label = 'INPUT_PICKUP'},
        FIX_TIRE = {code = 38, label = 'INPUT_PICKUP'},
        DROP_TIRE = {code = 38, label = 'INPUT_PICKUP'},
        CANCEL = {code = 23, label = 'INPUT_ENTER'},
    },

    Text = {
        FIXING_TIRE = 'Reifen reparieren...',
        NO_MORE_SPARES = 'Du hast keine Ersatzreifen mehr in deinem Kofferraum.',
        TAKE_SPARE = 'Ersatzreifen nehmen',
        FIX = 'Reparieren',
        DROP_SPARE = 'Ersatzreifen fallen lassen',
        CANCEL = 'Abbrechen',
    }
}