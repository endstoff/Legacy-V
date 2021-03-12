$(document).ready(function () {

    window.addEventListener("message", function (event) {
        if (event.data.displayhud == true) {
            $('body').show();
			set_speedometer({type: 'kmh', value: event.data.speed});
            set_speedometer({type: 'liter', value: event.data.tank});
            set_speedometer({type: 'km', value: '5,71'});
        };

        if (event.data.displayhud == false) {

            $("body").hide();
			set_speedometer({type: 'kmh', value: 0});
            set_speedometer({type: 'liter', value: 0});
            set_speedometer({type: 'km', value: 0});
        };
        if (event.data.action == "sendFuel") {

set_tank_content({type: 'tank_name', value: event.data.name});
set_tank_content({type: 'tank_money', value: event.data.money});
set_tank_content({type: 'tank_liter', value: event.data.liter});
dle_sliede_in();
        };
    });
});


function dle_sliede_in() {
    $('.dle_speedometer').addClass('slideIn2');
    setTimeout(function(){
        $('.dle_slide').addClass('slideIn');
    }, 500);
    setTimeout(function(){
        $('.dle_slide').addClass('slideOut');
        setTimeout(function(){
            $('.dle_speedometer').addClass('slideOut2');

            setTimeout(function () {
                $('.dle_slide').removeClass('slideIn').removeClass('slideOut');
                $('.dle_speedometer').removeClass('slideIn2').removeClass('slideOut2');
            }, 500)
        }, 500);
    }, 5000);
}

function set_tank_content(data) {
    switch (data.type) {
        case 'tank_name':
            $('#' + data.type).text(data.value);
            break;
        case 'tank_money':
            $('#' + data.type).text(data.value + ' $/L');
            break;
        case 'tank_liter':
            $('#' + data.type).text(data.value + ' L');
            break;
    }
}

function set_speedometer(data) {
    switch (data.type) {
        case 'kmh':
            $('#' + data.type).text(data.value + ' KM/H');
            break;
        case 'liter':
            $('#' + data.type).text(data.value + ' L');
            break;
        case 'km':
            $('#' + data.type).text(data.value + ' km');
            break;
    }
}

//set_tank_content({type: 'tank_name', value: 'Clyde Champion und Salamanca'});
//set_tank_content({type: 'tank_money', value: '20'});
//set_tank_content({type: 'tank_liter', value: '3000'});

//set_speedometer({type: 'kmh', value: '220'});
//set_speedometer({type: 'liter', value: '75'});
//set_speedometer({type: 'km', value: '4500,71'});