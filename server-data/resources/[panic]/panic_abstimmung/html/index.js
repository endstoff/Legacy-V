$(document).ready(function () {
    function visible(bool) {
        if (bool) {
            $("#container").show();
        } else {
            $("#container").hide();
        } 
    }
    visible(false)
    window.addEventListener("message", function(event) {
        var data = event.data;

        if(data.hasOwnProperty("type")) {
            if(data.type) {
                switch(data.type.toLowerCase()) {
                    case "updatecounters": // = if(data.type === "updatecounters")
                        var votes = {
                            yes: data.yes_votes,
                            no: data.no_votes
                        };
                        Counters(votes);
                        break;
                    case "ui": // = if(data.type === "ui")
                        if (data.status == true) {
                            visible(true)
                        } else {
                            visible(false)
                        }
                        break;
                    default: break;
                }
            }
        }
    })

    document.onkeyup = function (data) {
        if (data.which == 27) {
            $.post("https://panic_abstimmung/exit", JSON.stringify({}));
            return;
        }
    }

    $("#close").click(function() {
        $.post("http://panic_abstimmung/exit", JSON.stringify({}));
        return;
    })

    $("#vote-yes").click(function() {
        $.post("http://panic_abstimmung/vote-count", JSON.stringify({}));
        $.post("http://panic_abstimmung/vote-yes", JSON.stringify({}));
        return;
    })

    $("#vote-no").click(function() {
        $.post("http://panic_abstimmung/vote-no", JSON.stringify({}));
        return;
    })

});

function Counters(saved) {
    document.getElementById("yes-votes").value = saved.yes;
    document.getElementById("no-votes").value = saved.no;
}

