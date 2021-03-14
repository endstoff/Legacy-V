//////////////////////////////////////////
// Discord Whitelist, NOT made by Astra //
//////////////////////////////////////////

/// Config Area ///

var whitelistRoles = [ // Roles by ID that are whitelisted.
    "792530615513251841"
]

var blacklistRoles = [ // Roles by Id that are blacklisted.
    "333908428995035137"
]

var notWhitelistedMessage = "Du bist nicht gewhitelisted! Dieser Server Verlangt eine Discord Verifizierung! https://discord.gg/c7WABYqa9K "
var noGuildMessage = "Du bist nicht Mitglied des Legacy-V Discord."
var blacklistMessage = "Du bist auf diesem Server geblacklisted!"
var debugMode = false

/// Code ///
on('playerConnecting', (name, setKickReason, deferrals) => {
    let src = global.source;
    deferrals.defer()

    setTimeout(() => {
        deferrals.update(`Moin ${name}. Deine Discord ID wird mit unserer Whitelist abgeglichen.`)

        let identifierDiscord = null;

        for (let i = 0; i < GetNumPlayerIdentifiers(src); i++) {
            const identifier = GetPlayerIdentifier(src, i);

            if (identifier.includes('discord:')) {
                identifierDiscord = identifier;
            }
        }
        setTimeout(() => {
            if(identifierDiscord) {
                exports['discordroles']['isRolePresent'](src, blacklistRoles, function(hasRole, roles) {
                    if(hasRole) {
                        deferrals.done(blacklistMessage);
                        if(debugMode) console.log(`^5[DiscordWhitelist]^7 '${name}' mit der ID '${identifierDiscord.replace('discord:', '')}' ist vom Joinen geblacklisted.`)
                    }
                })
                exports['discordroles']['isRolePresent'](src, whitelistRoles, function(hasRole, roles) {
                    if(!roles) {
                        deferrals.done(noGuildMessage)
                        if(debugMode) console.log(`^5[DiscordWhitelist]^7 '${name}' mit der ID '${identifierDiscord.replace('discord:', '')}' konnte nicht auf dem Discord gefunden wurden und wurde der Zugriff verwährt.`)
                    }
                    if(hasRole) {
                        deferrals.done()
                        if(debugMode) console.log(`^5[DiscordWhitelist]^7 '${name}' mit der ID '${identifierDiscord.replace('discord:', '')}' wurde der Zugang erteilt und hat die Whitelist abgeschlossen.`)
                    } else {
                        deferrals.done(notWhitelistedMessage)
                        if(debugMode) console.log(`^5[DiscordWhitelist]^7 '${name}' mit der ID '${identifierDiscord.replace('discord:', '')}' ist nicht whitelisted.`)
                    }
                })
            } else {
                deferrals.done(`Discord wurde nicht erkannt. Bitte stelle sicher dass Discord läuft und installiert ist. Folge dem link für eine Fehler suche - docs.faxes.zone/docs/debugging-discord`)
                if(debugMode) console.log(`^5[DiscordWhitelist]^7 '${name}' wurde dem Zugang verwährt da eine Discord ID nicht gefunden wurde.`)
            }
        }, 0)
    }, 0)
})