var oldElementId = "";
var uDashboard = document.getElementById("uDashboard");
var ownerInfo = document.getElementById("ownerInfo");
var aDashboard = document.getElementById("aDashboard");
var safeAdministration = document.getElementById("safeAdmin");
var buyStationPage = document.getElementById("buyStationPage");
var sellStationPage = document.getElementById("sellStationPage");
var loader = document.getElementById("loader");

var toastContainer = document.getElementById("toastContainer");
var toastTextContainer = document.getElementById("toastMessage");
var currentToastId = null;

var ownerIdentifier = "";
var isAdmin = false;
var currentID = 0;
var currentPrice = 0;

function selectElement(elementId) {
  if (oldElementId != elementId && oldElementId != "") {
    document.getElementById(oldElementId).style.border = '0';
    document.getElementById(oldElementId).style.color = '#494b54';
    document.getElementById(oldElementId).style.fontSize = '14px';
  }

  document.getElementById(elementId).style.borderLeft = '5px solid #ffa800';
  document.getElementById(elementId).style.color = '#f1f1f1';
  document.getElementById(elementId).style.fontSize = '14.2px';
  oldElementId = elementId;

  switch (elementId) {
    case "userDashboard":
      showLoader(uDashboard);
      break;

    case "ownerInformation":
      showLoader(ownerInfo);
      break;

    case "adminDashboard":
      showLoader(aDashboard);
      break;

    case "safeAdministration":
      showLoader(safeAdministration);
      break;

    case "buyStation":
      showLoader(buyStationPage);
      break;

    case "sellStation":
      showLoader(sellStationPage);
      break;
  }
}

function showElement(elementId) {
  hideAllElements();

  elementId.style.display = "block";
}

function hideElement(elementId) {
  elementId.style.display = "none";
}

function hideAllElements() {
  uDashboard.style.display = "none";
  ownerInfo.style.display = "none";
  aDashboard.style.display = "none";
  safeAdministration.style.display = "none";
  buyStationPage.style.display = "none";
  sellStationPage.style.display = "none";
}

function showLoader(afterElement) {
  hideAllElements();
  loader.style.display = "block";

  setTimeout(function () {
    loader.style.display = "none";
    showElement(afterElement);
  }, Math.floor(Math.random() * 500) + 250);
}

function saveSettings() {
  var stationPPL = document.getElementById('pricePerLiter2');
  var gasNameInput = document.getElementById('gasName');
  var buyMessageInput = document.getElementById('buyMessage');

  createToast("Die Einstellungen wurden erfolgreich gespeichert.", "COLOR_SUCCESS");

  $.post('https://dw_business/updateStation', JSON.stringify({
    id: currentID,
    owner: ownerIdentifier,
    name: gasNameInput.value,
    ppl: stationPPL.value,
    bmi: buyMessageInput.value
  }));

  setTimeout(function () {
    $.post('https://dw_business/enable', false);

    $.post('https://dw_business/reload', JSON.stringify({
      id: currentID
    }));
  }, 500);
}

// Toast

function createToast(message, color) {
  while (!currentToastId) {
    var currentToastId = toastContainer.id = "toast-" + makeString(6);
    toastContainer.style.display = "block";
    toastTextContainer.textContent = message;

    switch (color) {
      case "COLOR_SUCCESS":
        toastContainer.style.backgroundColor = "#0e9e32";
        break;

      case "COLOR_INFO":
        toastContainer.style.backgroundColor = "#0394fc";
        break;

      case "COLOR_WARNING":
        toastContainer.style.backgroundColor = "#fca903";
        break;

      case "COLOR_ERROR":
        toastContainer.style.backgroundColor = "#d40d0d";
        break;

      default:
        toastContainer.style.backgroundColor = "#fff";
        break;
    }

    setTimeout(function () {
      hideToast(currentToastId);
    }, 10000);
  }
}

function hideToast(toastId) {
  if (toastId != null) {
    if (document.getElementById(toastId) != null) {
      document.getElementById(toastId).style.display = "none";
      currentToastId = false;
    }
  }
}

function buyStation() {
  $.post('https://dw_business/buyStation', JSON.stringify({
    id: currentID,
    price: currentPrice
  }));

  setTimeout(function () {
    $.post('https://dw_business/enable', false);

    $.post('https://dw_business/reload', JSON.stringify({
      id: currentID
    }));
  }, 500);
}

function sellStation() {
  $.post('https://dw_business/sellStation', JSON.stringify({
    id: currentID,
    price: currentPrice
  }));

  $.post('https://dw_business/enable', false);

  $.post('https://dw_business/reload', JSON.stringify({
    id: currentID
  }));
}

function payout() {

  if (document.getElementById('payoutInput').value == "") {
    createToast("Du musst einen Wert, welchen Du auszahlen möchstest, angeben.", "COLOR_ERROR")
    return;
  }

  $.post('https://dw_business/payout', JSON.stringify({
    id: currentID,
    money: parseInt(document.getElementById('payoutInput').value, 10),
  }));
}

// Util

function makeString(length) {
  var result = '';
  var characters = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
  var charactersLength = characters.length;
  for (var i = 0; i < length; i++) {
    result += characters.charAt(Math.floor(Math.random() * charactersLength));
  }
  return result;
}

// GTA - Communication

window.onload = function (e) {
  window.addEventListener('message', function (event) {
    if (event.data.type == "enableui") {
      document.getElementById('gasContainer').style.display = event.data.enable ? "block" : "none";
      isAdmin = false;
    }

    if (event.data.type == "loadStation") {
      data = [{
        stationStatus: event.data.status,
        stationCost: event.data.cost,
        stationName: event.data.name,
        stationOwner: event.data.owner,
        stationPricePerLiter: event.data.ppl,
        stationMoney: event.data.money,
        stationBuyMessage: event.data.buyMessage,
        stationFuel: event.data.fuel,
      }];

      isAdmin = event.data.isAdmin;
      ownerIdentifier = event.data.identifier;
      currentID = event.data.stationid;
      currentPrice = event.data.cost;

      this.console.log(currentID);

      if (isAdmin) {
        this.document.getElementById('adminArea').style.display = "block";
      } else {
        this.document.getElementById('adminArea').style.display = "none";
      }

      loadStationWithData(data);

      this.document.getElementById('payoutInput').value = "";
    }

    if (event.data.type == "sendToast") {
      createToast(event.data.message, event.data.color)
    }

    if (event.data.type == "updateMoneyValue") {
      this.document.getElementById('currentMoney').value = "$" + formatMoney(event.data.value);
    }
  });
}

function loadStationWithData(data) {
  var stationStatus = document.getElementById('stationStatus');
  var stationStatus2 = document.getElementById('stationStatus2');
  var stationCost = document.getElementById('stationCost');
  var stationCost3 = document.getElementById('stationCost3');
  var stationName = document.getElementById('stationName');
  var stationPPL = document.getElementById('pricePerLiter');
  var stationPPL2 = document.getElementById('pricePerLiter2');
  var stationFullRefuel = document.getElementById('fullRefuel');
  var stationFuel = document.getElementById('stationFuel');
  var ownerName = document.getElementById('ownerName');

  // Admin

  var stationMoney = document.getElementById('currentMoney');
  var gasNameInput = document.getElementById('gasName');
  var buyMessageInput = document.getElementById('buyMessage');

  switch (data[0].stationStatus) {
    case "TYPE_SELLED":
      this.document.getElementById('userArea').style.display = "block";
      this.document.getElementById('buyArea').style.display = "none";
      stationStatus.value = "verkauft";
      stationStatus2.value = "verkauft";
      selectElement('userDashboard');
      break;

    case "TYPE_FREE":
      stationStatus.value = "nicht verkauft";
      this.document.getElementById('userArea').style.display = "none";
      this.document.getElementById('buyArea').style.display = "block";
      selectElement('buyStation');
      break;
  }

  stationCost.value = "$" + data[0].stationCost / 1;
  stationCost3.value = "$" + data[0].stationCost / 2;
  stationName.innerText = data[0].stationName;

  gasNameInput.value = data[0].stationName;
  buyMessageInput.value = data[0].stationBuyMessage;

  stationPPL.value = "$" + formatMoney(data[0].stationPricePerLiter);
  stationPPL2.value = data[0].stationPricePerLiter;
  stationFullRefuel.value = "$" + formatMoney(data[0].stationPricePerLiter * 65);
  stationFuel.value = formatMoney(data[0].stationFuel) + "L";
  stationMoney.value = "$" + formatMoney(data[0].stationMoney);
  ownerName.value = data[0].stationOwner;
}

function formatMoney(number, decPlaces, decSep, thouSep) {
  decPlaces = isNaN(decPlaces = Math.abs(decPlaces)) ? 2 : decPlaces,
    decSep = typeof decSep === "undefined" ? "." : decSep;
  thouSep = typeof thouSep === "undefined" ? "," : thouSep;
  var sign = number < 0 ? "-" : "";
  var i = String(parseInt(number = Math.abs(Number(number) || 0).toFixed(decPlaces)));
  var j = (j = i.length) > 3 ? j % 3 : 0;

  return sign +
    (j ? i.substr(0, j) + thouSep : "") +
    i.substr(j).replace(/(\decSep{3})(?=\decSep)/g, "$1" + thouSep) +
    (decPlaces ? decSep + Math.abs(number - i).toFixed(decPlaces).slice(2) : "");
}

function closeMenu() {
  $.post('https://dw_business/enable', false);
}