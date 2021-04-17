$(function () {
  window.onload = (e) => {
    window.addEventListener("message", (event) => {
      var item = event.data;
      if (item !== undefined && item.type === "server2") {
        document.getElementById("notifications").innerHTML +=
          '<div class="notification2" style="position: relative; border-top: 5px #fd9904solid; border-bottom: 5px #fd9904solid;"><div class="notification2-title">' +
          item.title +
          '</p><div class="notification2-title"><p id="notfication-message-content">'+
          "</p></div></div>";
        $(".notification2").delay(10000).fadeOut("slow");
          // FIB
      } else if (item !== undefined && item.type === "fib") {
          document.getElementById("notifications").innerHTML +=
            '<div class="notification4" style="border-top: 5px #6600a6 solid; border-bottom: 5px #6600a6 solid;"><div class="notification4-title">' +
            item.title +
            '</p><div class="notification4-title"><p id="notfication-message-content">'+
            "</p></div></div>";
          $(".notification4").delay(10000).fadeOut("slow");
          // Global Announce
      } else if (item !== undefined && item.type === "anc") {
        document.getElementById("notifications").innerHTML +=
          '<div class="notification-anc" style="border-top: 5px #6600a6 solid; border-bottom: 5px #6600a6 solid;"><div class="notification-anc-title">' +
          item.title +
          '</p><div class="notification-anc-title"><p id="notfication-message-content">'+
          "</p></div></div>";
        $(".notification-anc").delay(15000).fadeOut("slow");
          // Server Announce
      } else if (item !== undefined && item.type === "server") {
        document.getElementById("notifications").innerHTML +=
          '<div class="notification-biild"><div class="notification" style="border-top: 5px #6600a6 solid; border-bottom: 5px #6600a6 solid;"><div class="notification-title">' +
          item.title +
          '</p><div class="notification-title"><p id="notfication-message-content">'+
          "</p></div></div>";
        $(".notification").delay(10000).fadeOut("slow");
          // Announce Custom
      } else if (item !== undefined && item.type === "custom") {
        document.getElementById("notifications").innerHTML +=
          '<div class="notification" style="border-left: 5px ' +
          item.color +
          ' solid;"><div class="notification-title"><p id="notfication-title-content">' +
          item.title +
          '</p></div><div class="notification-message"><p id="notfication-message-content">' +
          item.message +
          "</p></div></div>";

        $(".notification").delay(5000).fadeOut("slow");
      }
    });
  };
});
