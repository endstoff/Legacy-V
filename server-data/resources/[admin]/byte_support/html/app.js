setTimeout(function(){ $("#box").fadeOut(); }, 500);
$.post("http://byte_support/byte_support:callback");


window.onload = function(e) {
  window.addEventListener('message', function(event) {
    let data = event.data
    $("#box").fadeIn();
        document.getElementById("title").textContent = data.title;
        document.getElementById("description").textContent = data.message;
  })
}

$("#okbtn").click(function () {
  $("#box").fadeOut();
  $.post("http://byte_support/byte_support:callback");
  
});


$("#cancelbtn").click(function () {
  $("#box").fadeOut();
  $.post("http://byte_support/byte_support:delcode");
});