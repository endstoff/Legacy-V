$(document).ready(function(){
  window.addEventListener('message', function( event ) { 
    
    if (event.data.action == 'open') {        
      $('.container').css('display', event.data.openB ? 'inline-block' : 'none')
      $('.container2').css('display', event.data.openB ? 'inline-block' : 'none')
      $('.sub-container').css('display', 'none')
    } else if (event.data.action == 'add') {     
      AddItem(event.data.identifier, event.data.item, event.data.count, event.data.name, event.data.label, event.data.rare, event.data.can_remove, event.data.url, event.data.useable);
    } else if (event.data.action == 'addK') { 
      AddKItem(event.data.identifier, event.data.item, event.data.count, event.data.name, event.data.label, event.data.rare, event.data.can_remove, event.data.url, event.data.useable);
    } else if (event.data.action == 'reset') {
      const inv = document.getElementById("invcontainer");
      inv.innerHTML = '';
      const inv2 = document.getElementById("invcontainer2");
      inv2.innerHTML = '';

      $('.inv-head-btn p').text('');
    } else if (event.data.action == 'updatemax') {        
      $("#amount").attr('max', (parseInt($('.selected').attr('data-count')) - event.data.max));
      $('.selected').attr('data-count', (parseInt($('.selected').attr('data-count')) - event.data.max))
      
      $('.inv-head-btn p').text((parseInt($('.selected').attr('data-count')) - event.data.max) + 'x');

      if ((parseInt($('.selected').attr('data-count')) - event.data.max) <= 0) {
        $('.selected').remove();
      }
    } else if (event.data.action == 'updatecash') {
      $('.inv-head-btn p').text(event.data.nmoney + 'x');
    }
  });

  function AddItem(identifier, item, count, name, label, rare, can_remove, url, useable) { 
    if (count <= 0) {
      return
    }
                 
    $('#invcontainer').append(
      `
      <div class="inv-cont-elem2" onclick="select(this);" data-currentplace="self" style="background-image: url(` + url + `);" data-itype="item" data-identifier="` + identifier + `" data-item="` + item + `" data-count="` + count + `" data-name="` + name + `" data-label="` + label + `" data-rare="` + rare + `" data-can_remove="` + can_remove + `" data-url="` + url + `" data-useable=` + useable + `>

      </div>      
      `
    );
  }

  function AddKItem(identifier, item, count, name, label, rare, can_remove, url, useable) { 
    if (count <= 0) {
      return
    }
                 
    $('#invcontainer2').append(
      `
      <div class="inv-cont-elem" onclick="select2(this);" data-currentplace="trunk" style="background-image: url(` + url + `);" data-itype="item" data-identifier="` + identifier + `" data-item="` + item + `" data-count="` + count + `" data-name="` + name + `" data-label="` + label + `" data-rare="` + rare + `" data-can_remove="` + can_remove + `" data-url="` + url + `" data-useable=` + useable + `>

      </div>      
      `
    );
  }

  $( "#close" ).click(function() {
    $('.container').css('display', 'none');
    $.post('http://ps_carinventory/escape', JSON.stringify({}));
  });  

  $( "#refresh" ).click(function() {      
    $.post('http://ps_carinventory/refreshK', JSON.stringify({}));
  }); 

  $( "#close2" ).click(function() {
    $('.container').css('display', 'none');
    $.post('http://ps_carinventory/escape', JSON.stringify({}));
  });  

  $( "#refresh2" ).click(function() {      
    $.post('http://ps_carinventory/refresh', JSON.stringify({}));
  });
});

$(document).keyup(function(e) {
if (e.key === "Escape") {
  $('.container').css('display', 'none');
  $.post('http://ps_carinventory/escape', JSON.stringify({}));
}
});

function use() {
var cCount = 0

if ($("#amount").val() > $('.selected').attr("data-count")) {
  cCount = $('.selected').attr("data-count")
} else {
  cCount = $("#amount").val()
}  

$('.selected').attr("data-count", ($('.selected').attr("data-count") - cCount))
$('#amount').attr("max", $('.selected').attr("data-count"))

$.post('http://ps_carinventory/transfer', JSON.stringify({
    currentplace: $('.selected').attr("data-currentplace"),
    item: $('.selected').attr("data-name"),
    count: cCount,
}));
}

function select(elem) {
$('.inv-cont-elem').removeClass('selected');
$('.inv-cont-elem2').removeClass('selected');
$(elem).addClass('selected');
$('.sub-container').css('display', 'block');

$('.inv-head-btn p').text($(elem).attr('data-count') + 'x');

$('#amount').attr('max', $(elem).attr('data-count'));
$("#amount").val(1);

if ($(elem).attr('data-useable') == 'true' && $(elem).attr('data-itype') == 'item') {
  $('#use').show();
} else {
  $('#use').hide();
}
}

function select2(elem) {
$('.inv-cont-elem').removeClass('selected');
$('.inv-cont-elem2').removeClass('selected');
$(elem).addClass('selected');
$('.sub-container').css('display', 'block');

$('.inv-head-btn2 p').text($(elem).attr('data-count') + 'x');

$('#amount').attr('max', $(elem).attr('data-count'));
$("#amount").val(1);
}