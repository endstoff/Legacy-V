$(function () {
  window.onload = (e) => {
    window.addEventListener("message", (event) => {
      var item = event.data;
      if (item !== undefined && item.type === "police") {
        document.getElementById("notifications").innerHTML +=
          '<div class="notification" style="border-left: 5px #36b5ff solid;"><div class="notification-title"><p id="notfication-title-content">' +
          item.title +
          '</p></div><div class="notification-message"><p id="notfication-message-content">' +
          item.message +
          "</p></div></div>";
        $(".notification").delay(5000).fadeOut("slow");
      } else if (item !== undefined && item.type === "server") {
        document.getElementById("notifications").innerHTML +=
          '<div class="notification" style="border-left: 5px #ff3d3d solid;"><div class="notification-title"><p id="notfication-title-content">' +
          item.title +
          '</p></div><div class="notification-message"><p id="notfication-message-content">' +
          item.message +
          "</p></div></div>";
        $(".notification").delay(5000).fadeOut("slow");
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
