$(function () {
    function visible(bool) {
        if (bool) {
            $("#container").show();
        } else {
            $("#container").hide();
        }
    }
    visible(false)
    window.addEventListener("message", function(event) {
        var item = event.data;
        if (item.type === "ui") {
            if (item.status == true) {
                visible(true)
            } else {
                visible(false)
            }
        }
    })

    document.onkeyup = function (data) {
        if (data.which == 27) {
            $.post("http://panic_ui/exit", JSON.stringify({}));
            return;
        }
    }

    $("#close").click(function() {
        $.post("http://panic_ui/exit", JSON.stringify({}));
        return;
    })

    $("#submit").click(function() {
        let inputValue = $("#input").val()
        if (inputValue.length >= 100) {
            $.post("http://panic_ui/error", JSON.stringify({
                error: "Deine Eingabe hat mehr als 100 Zeichen"
            }))
            return;
        } else if (!inputValue) {
            $.post("http://panic_ui/error", JSON.stringify({
                error: "Du hast nichts eingegeben!"
            }))
            return;
        }
        $.post("https://panic_ui/main", JSON.stringify({
            text: inputValue
        }))
        return;
    })
    
})