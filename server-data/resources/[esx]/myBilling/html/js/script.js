$(() => {

    let senderPlayer = null
    let playerIdentifier = null 
    let sharedAccountName = null
    let reason = null
    let price = null

    $('#background').hide();
    $('#background_en').hide();
    window.addEventListener('message', function(event) {
        let v = event.data
        if (v.money != null & v.reason != null){
            $('#background').show();
            $('#moneyAmount').text(v.money + '$')
            $('#reasonMsg').text(v.reason)
            $('#headline').text(v.title)
            $('#moneyTitle').text(v.priceTitle)
            $('#reasonTitle').text(v.reasonTitle)
            $('#sign').text(v.signTitle)
            $('#accept').text(v.acceptTitle)

            senderPlayer = v.senderPlayer
            playerIdentifier = v.playerIdentifier
            sharedAccountName = v.sharedAccountName
            reason = v.reason
            price = v.money
        }
    });

    $('#accept').click(() => {
        $.post('http://myBilling/accept', JSON.stringify({
            senderPlayer: senderPlayer,
            playerIdentifier: playerIdentifier,
            sharedAccountName: sharedAccountName, 
            label: reason, 
            amount: price
        }));
        $('#background').hide();
    });
    
    $('#denied').click(() => {
        $.post('http://myBilling/denied', JSON.stringify({
			senderPlayer: senderPlayer,
            playerIdentifier: playerIdentifier,
            sharedAccountName: sharedAccountName, 
            label: reason, 
            amount: price
		}));
        $('#background').hide();
    });
});


