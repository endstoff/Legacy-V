Config = {}

Config.enableCmd = false --  /radio command should be active or not (if not you have to carry the item "radio") true / false

Config.RestrictedChannels = {
  [911] = {
    ['police'] = true
  },
  [912] = { --Großschadenslage
    ['ambulance'] = true
  },
}

Config.messages = {
  ['not_on_radio'] = 'Du bist aktuell mit keinem Funkkanal verbunden.',
  ['on_radio'] = 'Aktive Funkverbindung:<span style="color:#FF0000"><b> ',
  ['joined_to_radio'] = 'Du bist dem Funkkanal <span style="color:green"><b>%s</b></span>.00 MHz beigetreten.',
  ['restricted_channel_error'] = 'Du kannst dem verschlüsselten Funkkanal <span style="color:#FF0000"><b>%s</b></span>.00 MHz nicht beitreten!',
  ['you_on_radio'] = 'Du bist bereits im <span style="color:#FF0000"><b>%s</b></span>.00 MHz Funkkanal.',
  ['you_leave'] = 'Du hast die Verbindung von Funkkanal <span style="color:#FF0000"><b>%s</b></span>.00 MHz getrennt.'
}
