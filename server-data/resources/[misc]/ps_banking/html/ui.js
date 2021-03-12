var account_clicked;
var payout_head_collapsed = false;
var send_head_collapsed = false;
var cash = 1;

$(document).ready(function(){
    window.addEventListener('message', function( event ) {      
      if (event.data.action == 'open') {
        $('.container').css('display', 'block');
        cash = event.data.cash
        $('#label-cash').text(cash)
        $('#cash-to-bank').attr('max', cash)
        
        $.post('http://ps_banking/pagerequest_accounts', JSON.stringify({}));
      } else if (event.data.action == 'account') {
        $('.inner-container-head p').text("Meine Konten");
        const accounts = document.getElementById("konten");
        accounts.innerHTML = '';
        const accounts2 = document.getElementById("payout-konten");
        accounts2.innerHTML = '';
        const accounts3 = document.getElementById("send-konten");
        accounts3.innerHTML = '';
        $('#active-accs').css('display', 'block');
        $('#active-send').css('display', 'none');
        $('#active-deposit').css('display', 'none');
        $('#active-logs').css('display', 'none');
        for (let index = 0; index < event.data.accounts.length; index++) {         
          const singleAcc = event.data.accounts[index];

          var defaultK = false;
          if (singleAcc.defaultk == 1) {
            defaultK = true
          }                

          addBankKonto(singleAcc.label, singleAcc.money, singleAcc.bank_nummer, defaultK);
          addSendBankKonto(singleAcc.label, singleAcc.money, singleAcc.bank_nummer)
        }
      } else if (event.data.action == 'pagerequest_account') {
        $('#active-accs').css('display', 'block');
        $('#active-send').css('display', 'none');
        $('#active-deposit').css('display', 'none');
        $('#active-logs').css('display', 'none');

        $('#konten').css('display', 'block');
        $('#sendm').css('display', 'none');
        $('#senden').css('display', 'none');
        $('#log').css('display', 'none');

        $('.inner-container-head p').text("Meine Konten");
        const accounts = document.getElementById("konten");
        accounts.innerHTML = '';

        for (let index = 0; index < event.data.accounts.length; index++) {
          const singleAcc = event.data.accounts[index];   
          var defaultK = false;
          if (singleAcc.defaultk == 1) {
            defaultK = true
          }   
          addBankKonto(singleAcc.label, singleAcc.money, singleAcc.bank_nummer, defaultK);
        }
      } else {
        $('.container').css('display', 'none');
      }
    });

    $(document).keyup(function(e) {
      if (e.key === "Escape") {
        $('.container').css('display', 'none');
          $.post('http://ps_banking/escape', JSON.stringify({}));
      }
    });

    $(document).on('click', '.rename-btn', function() {
      var konto = $(this).attr('data-nummer');    
      var display = $(this).attr('data-label');
      account_clicked = konto;

      $('.inner-dialog-head').text("Label ändern");
      const dialog = document.getElementById("dialog-content");
      dialog.innerHTML = '';
      $('#dialog-content').append(
        `
        <div class="inner-dialog-content-box">
        `+ konto + `
        </div>

        <div class="inner-dialog-content-box">
          `+ display + `
        </div>

        <div class="inner-dialog-content-box" id="new-label" contenteditable="true">
                        
        </div>
        `
      );

      const footer = document.getElementById("dialog-footer");
      footer.innerHTML = '';
      $('#dialog-footer').append(`
      <div class="inner-dialog-footer-btn margin-dialog-left float-left" id="label-change">
        Übernehmen
      </div>
      <div class="inner-dialog-footer-btn margin-dialog-right float-right" id="label-cancel">
        Abbrechen
      </div>
      `);

      $('.inner-dialog').fadeIn();  
      $('.inner-dialog').css('display', 'block');
    });
    
    $(document).on('click', '#label-change', function() {
      $.post('http://ps_banking/change_account', JSON.stringify({
        id: account_clicked,
        label: $('#new-label').text()
      }));

      $('#label-' + account_clicked).text($('#new-label').text());
      account_clicked = null

      $('.inner-dialog').fadeOut();  
      $('.inner-dialog').css('display', 'none');
    });

    $(document).on('click', '#label-cancel', function() {
      account_clicked = null

      $('.inner-dialog').fadeOut();  
      $('.inner-dialog').css('display', 'none');
    });

    $(document).on('click', '.inner-container-content-list-send-dropdown-head', function() {
      payout_head_collapsed = !payout_head_collapsed;

      $('.inner-container-content-list-send-main').css('display', 'none')

      if (payout_head_collapsed) {
        $('.inner-container-content-list-send-dropdown-content').css('display', 'block')
      } else {
        $('.inner-container-content-list-send-dropdown-content').css('display', 'none')
      }
      
    });

    $(document).on('click', '.inner-container-content-list-send-dropdown-head2', function() {
      send_head_collapsed = !send_head_collapsed;

      $('.inner-container-content-list-send-main').css('display', 'none')

      if (send_head_collapsed) {
        $('.inner-container-content-list-send-dropdown-content2').css('display', 'block')
        $('.inner-container-content-list-send-main-col2').css('display', 'none')
      } else {
        $('.inner-container-content-list-send-dropdown-content2').css('display', 'none')
      }   
    });

    $(document).on('click', '.inner-container-content-list-send-dropdown-content-elem', function() {
      $('.inner-container-content-list-send-dropdown-content').css('display', 'none');
      $('.inner-container-content-list-send-dropdown-head').text($(this).text());
      account_clicked = $(this).attr("data-nummer")
      $('.inner-container-content-list-send-main').css('display', 'block');
      $('#cash-to-bank').attr("max", cash); 
      $('#bank-to-cash').attr("max", $(this).attr('data-maxm'))   
      $('#label-cash').text(cash)  
      $('#label-bank').text($(this).attr('data-maxm'))  
    });

    $(document).on('click', '.inner-container-content-list-send-dropdown-content-elem2', function() {
      $('.inner-container-content-list-send-dropdown-content2').css('display', 'none');
      $('.inner-container-content-list-send-dropdown-head2').text($(this).text());
      account_clicked = $(this).attr("data-nummer")
      $('.inner-container-content-list-send-main-col2').css('display', 'block')
      $('#transfer-money').attr('min', 1);
      $('#transfer-money').attr('max', $(this).attr('data-maxm'))
      $('#transfer-own').text($(this).attr("data-nummer"));
    });

    $(document).on('click', '#transfer-do', function() {
      var value = $('#transfer-money').val();
      var max = $('#transfer-money').attr('max')

      if (value > max) {
        value = max
      }

      $('#transfer-do').attr('max', (max - value))
  
      $('#transfer-do').html('<i class="fas fa-check-circle margin-top-transfer"></i>')
      setTimeout(() => { 
        $('#transfer-do').html('Bestätigen') 
      }, 2500);

      $.post('http://ps_banking/transfer_money', JSON.stringify({
        self: account_clicked,
        target: $('#transfer-target').text(),
        money: value
      }));
      $.post('http://ps_banking/refresh', JSON.stringify({}));
    });

    $(document).on('click', '#aufladen-btn', function() { // Cash -> Bank
      var moneys = $('#cash-to-bank').val();
      var xM = parseInt(moneys);

      if (parseInt(moneys) > cash) {
        xM = cash
      }

      $('#label-cash').text(cash - xM)
      $('#cash-to-bank').val(0);

      $('#label-bank').text(parseInt($('#bank-to-cash').attr('max')) + xM);   
      $('#bank-to-cash').attr('max', parseInt($('#bank-to-cash').attr('max')) + xM) 
      
      $.post('http://ps_banking/aufladen', JSON.stringify({money: xM, bank: account_clicked}));
      $.post('http://ps_banking/refresh', JSON.stringify({}));
    });

    $(document).on('click', '#abbuchen-btn', function() { // Bank -> Cash
      var moneys = $('#bank-to-cash').val();
      var max = $('#bank-to-cash').attr("max")
      var xM = parseInt(moneys)

      if (parseInt(moneys) > max) {
        xM = max
      }

      $('#label-bank').text(max - xM)
      $('#bank-to-cash').val(0);

      $('#label-cash').text(parseInt($('#cash-to-bank').attr('max')) + xM);   
      $('#cash-to-bank').attr('max', parseInt($('#cash-to-bank').attr('max')) + xM)  

      $.post('http://ps_banking/abbuchen', JSON.stringify({money: xM, bank: account_clicked}));
      $.post('http://ps_banking/refresh', JSON.stringify({}));
    });

    $(document).on('click', '#accs', function() {
      $.post('http://ps_banking/pagerequest_accounts', JSON.stringify({}));
      $('.inner-dialog').css('display', 'none')
    });

    $(document).on('click', '#send', function() {
      $('#active-accs').css('display', 'none');
      $('#active-send').css('display', 'block');
      $('#active-deposit').css('display', 'none');
      $('#active-logs').css('display', 'none');

      $('.inner-dialog').css('display', 'none')
      $('.inner-container-head p').text("Geld Verwaltung");

      $('#konten').css('display', 'none');
      $('#sendm').css('display', 'block');
      $('#senden').css('display', 'none');
      $('#log').css('display', 'none');   
      
      $('.inner-container-content-list-send-main').css('display', 'none');
    });

    $('[contenteditable]').on('paste', function(e) {
      e.preventDefault();
      var text = '';
      if (e.clipboardData || e.originalEvent.clipboardData) {
        text = (e.originalEvent || e).clipboardData.getData('text/plain');
      } else if (window.clipboardData) {
        text = window.clipboardData.getData('Text');
      }
      if (document.queryCommandSupported('insertText')) {
        document.execCommand('insertText', false, text);
      } else {
        document.execCommand('paste', false, text);
      }
  });

    $(document).on('click', '#deposit', function() {
      $('#active-accs').css('display', 'none');
      $('#active-send').css('display', 'none');
      $('#active-deposit').css('display', 'block');
      $('#active-logs').css('display', 'none');

      $('.inner-dialog').css('display', 'none')
      $('.inner-container-content-list-send-main-col2').css('display', 'none')

      $('#konten').css('display', 'none');
      $('#sendm').css('display', 'none');
      $('#senden').css('display', 'block');
      $('#log').css('display', 'none');
    });

    $(document).on('click', '#logs', function() {
      $('#active-accs').css('display', 'none');
      $('#active-send').css('display', 'none');
      $('#active-deposit').css('display', 'none');
      $('#active-logs').css('display', 'block');

      $('.inner-dialog').css('display', 'none')

      $('#konten').css('display', 'none');
      $('#sendm').css('display', 'none');
      $('#senden').css('display', 'none');
      $('#log').css('display', 'block');
    });

    $(document).on('click', '.konto-default-btn', function() {
      $.post('http://ps_banking/setDefault', JSON.stringify({bank: $(this).attr("data-konto")}));
      $('*').removeClass('default-konto')
      $(this).addClass('default-konto')
    });
});

function addBankKonto(konto_name, geld, konto_nummer, defaultk) {  
  $('#konten').append(
    `
    <div class="inner-container-content-konten-list-element" data-nummer="` + konto_nummer + `">
        <i class="fas fa-tags inner-container-content-konten-list-element-rename rename-btn" data-nummer="` + konto_nummer + `" data-label="` + konto_name + `"></i><i data-konto="` + konto_nummer + `" class="fas fa-check konto-default-btn ` + (defaultk ? "nondefault-konto default-konto" : "nondefault-konto") + `"></i>
        <p class="inner-container-content-konten-list-element-label" id="label-` + konto_nummer + `">` + konto_name + `</p>
        <hr class="inner-container-content-konten-list-element-hr">
        <p class="inner-container-content-konten-list-element-bilanz"><b>Bilanz</b></p>
        <p class="inner-container-content-konten-list-element-current-bilanz">$ ` + geld.toFixed(2) + `</p>
    </div>
    `
  );  
}

function addSendBankKonto(konto_name, geld, konto_nummer) {
  $('#payout-konten').append(

    `
    <div class="inner-container-content-list-send-dropdown-content-elem" data-nummer="` + konto_nummer + `" data-maxm="` + geld + `">
      ` + konto_name + `
    </div>
    `

  );

  $('#send-konten').append(

    `
    <div class="inner-container-content-list-send-dropdown-content-elem2" data-nummer="` + konto_nummer + `" data-maxm="` + geld + `">
    ` + konto_name + `
    </div>
    `

  );
}