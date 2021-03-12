$(document).ready(function(){
    window.addEventListener('message', function(event) {
        var data = event.data;

        if (data.action == 'add') {
            AddNotification(data.text);
        }
    });
});

function AddNotification(text) {   
    var $elem = $(
        `<div class="notification">
            <div class="head"></div>
            <p>` + text + `</p>
        </div>`
        );
    
        $('.notifications').prepend($elem).fadeIn();
    
        setTimeout(function() {
            $elem.fadeOut("slow");
        }, 10000);
}