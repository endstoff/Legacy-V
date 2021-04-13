var personData = [];
var avaliableTypes = [];
var audioPlayer = null;
var lastSelected = null;
var selectedArea = null;
var selfOpened = false;

var slowHBInterval;
var normalHBInterval;
var highHBInterval;

var messages = {};

$(document).ready(function () {
    $('[data-toggle="tooltip"]').tooltip();
});

$(".appBodyPart").click(function () {
    loadBodyPart($(this).attr("data-part"));
});

var hbPlayer = null;

window.onload = function (e) {
    window.addEventListener('message', function (event) {
        if (event.data.type == "languageInit") {
            messages = JSON.parse(event.data.messageData);
            translateContainer();
        }

        if (event.data.type == "enableui") {
            document.getElementById("appContainer").style.display = event.data.enable ? "block" : "none";
        }

        if (event.data.type == "personData") {
            personData = JSON.parse(event.data.jsonString);
            selfOpened = false;
            $("#nameSpan").text(personData.menuTitle);

            _internalInit();
        }

        if (event.data.type == "selfOpened") {
            selfOpened = event.data.state;
        }

        if (event.data.type == "heartbeat") {

            if (hbPlayer != null) {
                hbPlayer.pause();
            }

            hbPlayer = new Audio("./sounds/" + event.data.hbType + ".wav");
            hbPlayer.volume = 0.25;
            hbPlayer.play();
        }

        if (event.data.type == "checkU") {
            document.getElementById("uScreen").style.display = event.data.enable ? "block" : "none";
        }

        if (event.data.type == 'runPainEffect') {
            runPainEffect(event.data.percent);
        }

        if (event.data.type == 'deactivatePainEffect') {
            deactivePainEffect();
        }

        if (event.data.type == 'bloodEffect') {
            doBloodScreen(event.data.state);
        }

        if (event.data.type == 'informedEMS') {
            this.console.log(event.data.state);
            if (event.data.state) {
                $("#informEMS").fadeIn("fast");
            } else {
                $("#informEMS").fadeOut("fast");
            }
        }

        if (event.data.type == "resetTimer") {
            TIME_LIMIT = 1;
            timeLeft = 0;
            timePassed = 0;

            clearInterval(timerInterval);
        }

        if (event.data.type == "setTimer") {
            TIME_LIMIT = TIME_LIMIT + event.data.time;
            timeLeft = timeLeft + event.data.time;

            document.getElementById("app").innerHTML = `
<div class="base-timer">
  <svg class="base-timer__svg" viewBox="0 0 100 100" xmlns="http://www.w3.org/2000/svg">
    <g class="base-timer__circle">
      <circle class="base-timer__path-elapsed" cx="50" cy="50" r="45"></circle>
      <path
        id="base-timer-path-remaining"
        stroke-dasharray="283"
        class="base-timer__path-remaining ${remainingPathColor}"
        d="
          M 50, 50
          m -45, 0
          a 45,45 0 1,0 90,0
          a 45,45 0 1,0 -90,0
        "
      ></path>
    </g>
  </svg>
  <span id="base-timer-label" class="base-timer__label">${formatTime(
                timeLeft
            )}</span>
</div>
`;

            clearInterval(timerInterval);
            startTimer();
        }

        if (event.data.transactionType == "playSound") {

            if (audioPlayer != null) {
                audioPlayer.pause();
            }

            audioPlayer = new Audio("./sounds/" + event.data.transactionFile + ".ogg");
            audioPlayer.volume = event.data.transactionVolume;
            audioPlayer.play();

        }
    });
}

if (!String.format) {
    String.format = function (format) {
        var args = Array.prototype.slice.call(arguments, 1);
        return format.replace(/{(\d+)}/g, function (match, number) {
            return typeof args[number] != 'undefined'
                ? args[number]
                : match
                ;
        });
    };
}

function loadBodyPart(bodyPart) {
    selectedArea = bodyPart;
    switch (bodyPart) {
        case "head":
            $(".bodyPart").text(_localeType("head"));

            $("#bodyInjuries").html("");

            avaliableTypes = [];
            avaliableTypes.push("checkPerson", "boneBreak");

            _checkTypes();
            $("#useTourniquet").hide();
            $("#removeTourniquet").hide();

            if (personData.bloodParts.head > 0 && !personData.appliedTourniquets.hasOwnProperty("head")) {
                switch (personData.bloodParts.head) {
                    case 1:
                        $("#bodyInjuries").append("<li style='color: red; font-weight: 900;'>" + _localeType("active_bleeding_weak") + "</li>");
                        break;

                    case 2:
                        $("#bodyInjuries").append("<li style='color: red; font-weight: 900;'>" + _localeType("active_bleeding_average") + "</li>");
                        break;

                    case 3:
                        $("#bodyInjuries").append("<li style='color: red; font-weight: 900;'>" + _localeType("active_bleeding_strong") + "</li>");
                        break;
                }
            }

            if (personData.victimBloodLevel < 2.5 && personData.victimBloodLevel > 2.0) {
                $("#bodyInjuries").append("<li style='color: red; font-weight: 700'>" + _localeType("lost_blood_little") + "</li>");
            }

            if (personData.victimBloodLevel < 2.0 && personData.victimBloodLevel > 1.5) {
                $("#bodyInjuries").append("<li style='color: red; font-weight: 700'>" + _localeType("lost_blood_huge") + "</li>");
            }

            if (personData.victimBloodLevel < 1.5 && personData.victimBloodLevel > 1.0) {
                $("#bodyInjuries").append("<li style='color: red; font-weight: 700'>" + _localeType("lost_blood_huge") + "</li>");
            }

            if (personData.victimBloodLevel < 1.0) {
                $("#bodyInjuries").append("<li style='color: red; font-weight: 700'>" + _localeType("lost_blood_fatal") + "</li>");
            }

            if (personData.victimPain > 0) {
                $("#bodyInjuries").append("<li>" + _localeType("active_pain") + "</li>");
            }

            if (personData.recievingBloodInfusion > 0) {
                $("#bodyInjuries").append("<li style='color: #42b9f5; font-weight: 700'>" + _localeType("active_blood_infusion", personData.recievingBloodInfusion) + "</li>");
            }

            if (personData.bodyPartDamage.head > 0) {
                if (personData.bodyPartDamage.head >= 1) {
                    $("#bodyInjuries").append("<li><br></li>");
                    $("#bodyInjuries").append("<li>" + _localeType("slight_concussion") + "</li>");
                }

                if (personData.bodyPartDamage.head >= 2) {
                    $("#bodyInjuries").append("<li>" + _localeType("moderately_large_head_laceration") + "</li>");
                }

                if (personData.bodyPartDamage.head == 3) {
                    $("#bodyInjuries").append("<li>" + _localeType("large_open_lacerated_wound") + " </li>");
                }

                if (personData.bodyPartDamage.head == 4) {
                    $("#bodyInjuries").append("<li>" + _localeType("severe_burns") + "</li>");
                }
            } else if (personData.needSewed.head > 0) {
                $("#bodyInjuries").append("<li><br></li>");
                $("#bodyInjuries").append("<li>" + _localeType("suturing_required") + "</li>");
            } else {
                if (personData.victimPain > 0) {
                    $("#bodyInjuries").append("<li><br></li>");
                }
                $("#bodyInjuries").append("<li>" + _localeType("no_injuries_at_bodypart") + "</li>");
            }

            break;

        case "left_arm":
            $(".bodyPart").text(_localeType("left_arm"));

            $("#bodyInjuries").html("");

            avaliableTypes = [];
            avaliableTypes.push("checkPerson", "boneBreak", "syringes", "infusions");

            _checkTypes();
            $("#removeTourniquet").hide();
            $("#useTourniquet").hide();

            if (personData.bloodParts.left_arm > 0 && !personData.appliedTourniquets.hasOwnProperty("left_arm")) {
                switch (personData.bloodParts.left_arm) {
                    case 1:
                        $("#bodyInjuries").append("<li style='color: red; font-weight: 900;'>" + _localeType("active_bleeding_weak") + "</li>");
                        break;

                    case 2:
                        $("#bodyInjuries").append("<li style='color: red; font-weight: 900;'>" + _localeType("active_bleeding_average") + "</li>");
                        break;

                    case 3:
                        $("#bodyInjuries").append("<li style='color: red; font-weight: 900;'>" + _localeType("active_bleeding_strong") + "</li>");
                        break;
                }
            }

            if (personData.appliedTourniquets.hasOwnProperty("left_arm")) {
                $("#bodyInjuries").append("<li style='color: #f4be33; font-weight: 900;'>" + _localeType("tourniquet_is_applied") + "</li>");
                $("#useTourniquet").text(_localeType("remove_tourniquet"));
                $("#removeTourniquet").show();
            } else {
                $("#useTourniquet").show();
            }

            $("#useTourniquet").text(_localeType("useTourniquet"));

            if (personData.victimBloodLevel < 2.5 && personData.victimBloodLevel > 2.0) {
                $("#bodyInjuries").append("<li style='color: red; font-weight: 700'>" + _localeType("lost_blood_little") + "</li>");
            }

            if (personData.victimBloodLevel < 2.0 && personData.victimBloodLevel > 1.5) {
                $("#bodyInjuries").append("<li style='color: red; font-weight: 700'>" + _localeType("lost_blood_huge") + "</li>");
            }

            if (personData.victimBloodLevel < 1.5 && personData.victimBloodLevel > 1.0) {
                $("#bodyInjuries").append("<li style='color: red; font-weight: 700'>" + _localeType("lost_blood_huge") + "</li>");
            }

            if (personData.victimBloodLevel < 1.0) {
                $("#bodyInjuries").append("<li style='color: red; font-weight: 700'>" + _localeType("lost_blood_fatal") + "</li>");
            }

            if (personData.victimPain > 0) {
                $("#bodyInjuries").append("<li>" + _localeType("active_pain") + "</li>");
            }

            if (personData.recievingBloodInfusion > 0) {
                $("#bodyInjuries").append("<li style='color: #42b9f5; font-weight: 700'>" + _localeType("active_blood_infusion", personData.recievingBloodInfusion) + "</li>");
            }

            if (personData.bodyPartDamage.left_arm > 0) {
                if (personData.bodyPartDamage.left_arm >= 1) {
                    $("#bodyInjuries").append("<li><br></li>");
                    $("#bodyInjuries").append("<li>" + _localeType("small_abrasion") + "</li>");
                }

                if (personData.bodyPartDamage.left_arm >= 2) {
                    $("#bodyInjuries").append("<li>" + _localeType("large_laceration") + "</li>");
                }

                if (personData.bodyPartDamage.left_arm == 3) {
                    $("#bodyInjuries").append("<li>" + _localeType("large_cut") + "</li>");
                }

                if (personData.bodyPartDamage.left_arm == 4) {
                    $("#bodyInjuries").append("<li>" + _localeType("severe_burns") + "</li>");
                }
            } else if (personData.needSewed.left_arm > 0) {
                $("#bodyInjuries").append("<li><br></li>");
                $("#bodyInjuries").append("<li>" + _localeType("suturing_required") + "</li>");
            } else {
                if (personData.victimPain > 0) {
                    $("#bodyInjuries").append("<li><br></li>");
                }
                $("#bodyInjuries").append("<li>" + _localeType("no_injuries_at_bodypart") + "</li>");
            }
            break;

        case "right_arm":
            $(".bodyPart").text(_localeType("right_arm"));

            $("#bodyInjuries").html("");
            avaliableTypes = [];
            avaliableTypes.push("checkPerson", "boneBreak", "syringes", "infusions");

            _checkTypes();
            $("#removeTourniquet").hide();
            $("#useTourniquet").hide();

            if (personData.bloodParts.right_arm > 0 && !personData.appliedTourniquets.hasOwnProperty("right_arm")) {
                switch (personData.bloodParts.right_arm) {
                    case 1:
                        $("#bodyInjuries").append("<li style='color: red; font-weight: 900;'>" + _localeType("active_bleeding_weak") + "</li>");
                        break;

                    case 2:
                        $("#bodyInjuries").append("<li style='color: red; font-weight: 900;'>" + _localeType("active_bleeding_average") + "</li>");
                        break;

                    case 3:
                        $("#bodyInjuries").append("<li style='color: red; font-weight: 900;'>" + _localeType("active_bleeding_strong") + "</li>");
                        break;
                }
            }

            if (personData.appliedTourniquets.hasOwnProperty("right_arm")) {
                $("#bodyInjuries").append("<li style='color: #f4be33; font-weight: 900;'>" + _localeType("tourniquet_is_applied") + "</li>");
                $("#removeTourniquet").show();
            } else {
                $("#useTourniquet").show();
            }

            if (personData.victimBloodLevel < 2.5 && personData.victimBloodLevel > 2.0) {
                $("#bodyInjuries").append("<li style='color: red; font-weight: 700'>" + _localeType("lost_blood_little") + "</li>");
            }

            if (personData.victimBloodLevel < 2.0 && personData.victimBloodLevel > 1.5) {
                $("#bodyInjuries").append("<li style='color: red; font-weight: 700'>" + _localeType("lost_blood_huge") + "</li>");
            }

            if (personData.victimBloodLevel < 1.5 && personData.victimBloodLevel > 1.0) {
                $("#bodyInjuries").append("<li style='color: red; font-weight: 700'>" + _localeType("lost_blood_huge") + "</li>");
            }

            if (personData.victimBloodLevel < 1.0) {
                $("#bodyInjuries").append("<li style='color: red; font-weight: 700'>" + _localeType("lost_blood_fatal") + "</li>");
            }

            if (personData.victimPain > 0) {
                $("#bodyInjuries").append("<li>" + _localeType("active_pain") + "</li>");
            }

            if (personData.recievingBloodInfusion > 0) {
                $("#bodyInjuries").append("<li style='color: #42b9f5; font-weight: 700'>" + _localeType("active_blood_infusion", personData.recievingBloodInfusion) + "</li>");
            }

            if (personData.bodyPartDamage.right_arm > 0) {
                if (personData.bodyPartDamage.right_arm >= 1) {
                    $("#bodyInjuries").append("<li><br></li>");
                    $("#bodyInjuries").append("<li>" + _localeType("small_abrasion") + "</li>");
                }

                if (personData.bodyPartDamage.right_arm >= 2) {
                    $("#bodyInjuries").append("<li>" + _localeType("large_laceration") + "</li>");
                }

                if (personData.bodyPartDamage.right_arm == 3) {
                    $("#bodyInjuries").append("<li>" + _localeType("large_cut") + "</li>");
                }

                if (personData.bodyPartDamage.right_arm == 4) {
                    $("#bodyInjuries").append("<li>" + _localeType("severe_burns") + "</li>");
                }
            } else if (personData.needSewed.right_arm > 0) {
                $("#bodyInjuries").append("<li><br></li>");
                $("#bodyInjuries").append("<li>" + _localeType("suturing_required") + "</li>");
            } else {
                if (personData.victimPain > 0) {
                    $("#bodyInjuries").append("<li><br></li>");
                }
                $("#bodyInjuries").append("<li>" + _localeType("no_injuries_at_bodypart") + "</li>");
            }
            break;

        case "torso":
            $(".bodyPart").text(_localeType("torso"));

            $("#bodyInjuries").html("");
            avaliableTypes = [];
            avaliableTypes.push("lifeSaver", "rip", "boneBreak");

            _checkTypes();
            $("#removeTourniquet").hide();
            $("#useTourniquet").hide();

            if (personData.bloodParts.torso > 0) {
                switch (personData.bloodParts.torso) {
                    case 1:
                        $("#bodyInjuries").append("<li style='color: red; font-weight: 900;'>" + _localeType("active_bleeding_weak") + "</li>");
                        break;

                    case 2:
                        $("#bodyInjuries").append("<li style='color: red; font-weight: 900;'>" + _localeType("active_bleeding_average") + "</li>");
                        break;

                    case 3:
                        $("#bodyInjuries").append("<li style='color: red; font-weight: 900;'>" + _localeType("active_bleeding_strong") + "</li>");
                        break;
                }
            }

            if (personData.victimBloodLevel < 2.5 && personData.victimBloodLevel > 2.0) {
                $("#bodyInjuries").append("<li style='color: red; font-weight: 700'>" + _localeType("lost_blood_little") + "</li>");
            }

            if (personData.victimBloodLevel < 2.0 && personData.victimBloodLevel > 1.5) {
                $("#bodyInjuries").append("<li style='color: red; font-weight: 700'>" + _localeType("lost_blood_huge") + "</li>");
            }

            if (personData.victimBloodLevel < 1.5 && personData.victimBloodLevel > 1.0) {
                $("#bodyInjuries").append("<li style='color: red; font-weight: 700'>" + _localeType("lost_blood_huge") + "</li>");
            }

            if (personData.victimBloodLevel < 1.0) {
                $("#bodyInjuries").append("<li style='color: red; font-weight: 700'>" + _localeType("lost_blood_fatal") + "</li>");
            }

            if (personData.victimPain > 0) {
                $("#bodyInjuries").append("<li>" + _localeType("active_pain") + "</li>");
            }

            if (personData.recievingBloodInfusion > 0) {
                $("#bodyInjuries").append("<li style='color: #42b9f5; font-weight: 700'>" + _localeType("active_blood_infusion", personData.recievingBloodInfusion) + "</li>");
            }

            if (personData.bodyPartDamage.torso > 0) {
                if (personData.bodyPartDamage.torso >= 1) {
                    $("#bodyInjuries").append("<li><br></li>");
                    $("#bodyInjuries").append("<li>" + _localeType("open_tear_wound") + "</li>");
                }

                if (personData.bodyPartDamage.torso >= 2) {
                    $("#bodyInjuries").append("<li>" + _localeType("slight_bruise") + "</li>");
                }

                if (personData.bodyPartDamage.torso == 3) {
                    $("#bodyInjuries").append("<li>" + _localeType("open_stab_wound") + "</li>");
                }

                if (personData.bodyPartDamage.torso == 4) {
                    $("#bodyInjuries").append("<li>" + _localeType("severe_burns") + "</li>");
                }
            } else if (personData.needSewed.torso > 0) {
                $("#bodyInjuries").append("<li><br></li>");
                $("#bodyInjuries").append("<li>" + _localeType("suturing_required") + "</li>");
            } else {
                if (personData.victimPain > 0) {
                    $("#bodyInjuries").append("<li><br></li>");
                }
                $("#bodyInjuries").append("<li>" + _localeType("no_injuries_at_bodypart") + "</li>");
            }
            break;

        case "right_leg":
            $(".bodyPart").text(_localeType("right_leg"));

            $("#bodyInjuries").html("");
            avaliableTypes = [];
            avaliableTypes.push("boneBreak", "syringes");

            _checkTypes();
            $("#removeTourniquet").hide();
            $("#useTourniquet").hide();

            if (personData.bloodParts.right_leg > 0 && !personData.appliedTourniquets.hasOwnProperty("right_leg")) {
                switch (personData.bloodParts.right_leg) {
                    case 1:
                        $("#bodyInjuries").append("<li style='color: red; font-weight: 900;'>" + _localeType("active_bleeding_weak") + "</li>");
                        break;

                    case 2:
                        $("#bodyInjuries").append("<li style='color: red; font-weight: 900;'>" + _localeType("active_bleeding_average") + "</li>");
                        break;

                    case 3:
                        $("#bodyInjuries").append("<li style='color: red; font-weight: 900;'>" + _localeType("active_bleeding_strong") + "</li>");
                        break;
                }
            }

            if (personData.appliedTourniquets.hasOwnProperty("right_leg")) {
                $("#bodyInjuries").append("<li style='color: #f4be33; font-weight: 900;'>" + _localeType("tourniquet_is_applied") + "</li>");
                $("#useTourniquet").text(_localeType("remove_tourniquet"));
                $("#removeTourniquet").show();
            } else {
                $("#useTourniquet").show();
            }

            $("#useTourniquet").text(_localeType("useTourniquet"));

            if (personData.victimBloodLevel < 2.5 && personData.victimBloodLevel > 2.0) {
                $("#bodyInjuries").append("<li style='color: red; font-weight: 700'>" + _localeType("lost_blood_little") + "</li>");
            }

            if (personData.victimBloodLevel < 2.0 && personData.victimBloodLevel > 1.5) {
                $("#bodyInjuries").append("<li style='color: red; font-weight: 700'>" + _localeType("lost_blood_huge") + "</li>");
            }

            if (personData.victimBloodLevel < 1.5 && personData.victimBloodLevel > 1.0) {
                $("#bodyInjuries").append("<li style='color: red; font-weight: 700'>" + _localeType("lost_blood_huge") + "</li>");
            }

            if (personData.victimBloodLevel < 1.0) {
                $("#bodyInjuries").append("<li style='color: red; font-weight: 700'>" + _localeType("lost_blood_fatal") + "</li>");
            }

            if (personData.victimPain > 0) {
                $("#bodyInjuries").append("<li>" + _localeType("active_pain") + "</li>");
            }

            if (personData.recievingBloodInfusion > 0) {
                $("#bodyInjuries").append("<li style='color: #42b9f5; font-weight: 700'>" + _localeType("active_blood_infusion", personData.recievingBloodInfusion) + "</li>");
            }

            if (personData.bodyPartDamage.right_leg > 0) {
                if (personData.bodyPartDamage.right_leg >= 1) {
                    $("#bodyInjuries").append("<li><br></li>");
                    $("#bodyInjuries").append("<li>" + _localeType("small_abrasion") + "</li>");
                }

                if (personData.bodyPartDamage.right_leg >= 2) {
                    $("#bodyInjuries").append("<li>" + _localeType("large_laceration") + "</li>");
                }

                if (personData.bodyPartDamage.right_leg == 3) {
                    $("#bodyInjuries").append("<li>" + _localeType("large_cut") + "</li>");
                }

                if (personData.bodyPartDamage.right_leg == 4) {
                    $("#bodyInjuries").append("<li>" + _localeType("severe_burns") + "</li>");
                }
            } else if (personData.needSewed.right_leg > 0) {
                $("#bodyInjuries").append("<li><br></li>");
                $("#bodyInjuries").append("<li>" + _localeType("suturing_required") + "</li>");
            } else {
                if (personData.victimPain > 0) {
                    $("#bodyInjuries").append("<li><br></li>");
                }
                $("#bodyInjuries").append("<li>" + _localeType("no_injuries_at_bodypart") + "</li>");
            }

            break;

        case "left_leg":
            $(".bodyPart").text(_localeType("left_leg"));

            $("#bodyInjuries").html("");
            avaliableTypes = [];
            avaliableTypes.push("boneBreak", "syringes");

            _checkTypes();
            $("#removeTourniquet").hide();
            $("#useTourniquet").hide();

            if (personData.bloodParts.left_leg > 0 && !personData.appliedTourniquets.hasOwnProperty("left_leg")) {
                switch (personData.bloodParts.left_leg) {
                    case 1:
                        $("#bodyInjuries").append("<li style='color: red; font-weight: 900;'>" + _localeType("active_bleeding_weak") + "</li>");
                        break;

                    case 2:
                        $("#bodyInjuries").append("<li style='color: red; font-weight: 900;'>" + _localeType("active_bleeding_average") + "</li>");
                        break;

                    case 3:
                        $("#bodyInjuries").append("<li style='color: red; font-weight: 900;'>" + _localeType("active_bleeding_strong") + "</li>");
                        break;
                }
            }

            if (personData.appliedTourniquets.hasOwnProperty("left_leg")) {
                $("#bodyInjuries").append("<li style='color: #f4be33; font-weight: 900;'>" + _localeType("tourniquet_is_applied") + "</li>");
                $("#useTourniquet").text(_localeType("remove_tourniquet"));
                $("#removeTourniquet").show();
            } else {
                $("#useTourniquet").show();
            }

            if (personData.victimBloodLevel < 2.5 && personData.victimBloodLevel > 2.0) {
                $("#bodyInjuries").append("<li style='color: red; font-weight: 700'>" + _localeType("lost_blood_little") + "</li>");
            }

            if (personData.victimBloodLevel < 2.0 && personData.victimBloodLevel > 1.5) {
                $("#bodyInjuries").append("<li style='color: red; font-weight: 700'>" + _localeType("lost_blood_huge") + "</li>");
            }

            if (personData.victimBloodLevel < 1.5 && personData.victimBloodLevel > 1.0) {
                $("#bodyInjuries").append("<li style='color: red; font-weight: 700'>" + _localeType("lost_blood_huge") + "</li>");
            }

            if (personData.victimBloodLevel < 1.0) {
                $("#bodyInjuries").append("<li style='color: red; font-weight: 700'>" + _localeType("lost_blood_fatal") + "</li>");
            }

            if (personData.victimPain > 0) {
                $("#bodyInjuries").append("<li>" + _localeType("active_pain") + "</li>");
            }

            if (personData.recievingBloodInfusion > 0) {
                $("#bodyInjuries").append("<li style='color: #42b9f5; font-weight: 700'>" + _localeType("active_blood_infusion", personData.recievingBloodInfusion) + "</li>");
            }

            if (personData.bodyPartDamage.left_leg > 0) {
                if (personData.bodyPartDamage.left_leg >= 1) {
                    $("#bodyInjuries").append("<li><br></li>");
                    $("#bodyInjuries").append("<li>" + _localeType("small_abrasion") + "</li>");
                }

                if (personData.bodyPartDamage.left_leg >= 2) {
                    $("#bodyInjuries").append("<li>" + _localeType("large_laceration") + "</li>");
                }

                if (personData.bodyPartDamage.left_leg == 3) {
                    $("#bodyInjuries").append("<li>" + _localeType("large_cut") + "</li>");
                }

                if (personData.bodyPartDamage.left_leg == 4) {
                    $("#bodyInjuries").append("<li>" + _localeType("severe_burns") + "</li>");
                }
            } else if (personData.needSewed.left_leg > 0) {
                $("#bodyInjuries").append("<li><br></li>");
                $("#bodyInjuries").append("<li>" + _localeType("suturing_required") + "</li>");
            } else {
                if (personData.victimPain > 0) {
                    $("#bodyInjuries").append("<li><br></li>");
                }

                $("#bodyInjuries").append("<li>" + _localeType("no_injuries_at_bodypart") + "</li>");
            }
            break;
    }
}

$(".appHealType i").click(function () {
    if ($(this).attr("data-disabled") == "true")
        return;

    if (lastSelected != null)
        lastSelected.attr("data-selected", "false");

    lastSelected = $(this);
    $(this).attr("data-selected", "true");

    _switchButtons();

    if (selfOpened) {
        _disableSelfOptions();
    }
});

function _switchButtons() {
    $('.appButton').each(function (i, obj) {
        if (!$(obj).hasClass("hidden"))
            $(obj).addClass("hidden");

        if ($(obj).attr("data-type") == lastSelected.attr("data-type")) {
            $(obj).removeClass("hidden");
        }
    });
}

function _disableSelfOptions() {
    $('.appButton').each(function (i, obj) {
        if ($(obj).attr("data-type") == 'lifeSaver' || $(obj).attr("data-type") == 'infusions' || $(obj).attr("data-type") == 'carry') {
            $(obj).addClass("hidden");
        }
    });
}

function _internalInit() {
    var damageName = "";

    $(".bodyPart").text("");
    $("#bodyInjuries").html("");

    $('.appHealType i').each(function (i, obj) {
        if ($(obj).attr("data-disabled") == "false")
            $(obj).attr("data-disabled", "true");
    });

    $('.appHealType i').each(function (i, obj) {
        if ($(obj).attr("data-selected") == "true")
            $(obj).attr("data-selected", "false");
    });

    $('.appButton').each(function (i, obj) {
        if (!$(obj).hasClass("hidden"))
            $(obj).addClass("hidden");
    });

    Object.keys(personData.bodyPartDamage).forEach(function (key) {
        if (personData.appliedTourniquets.hasOwnProperty(key)) {
            $("#" + $("#" + key).attr("data-tName")).show();
        } else {
            $("#" + $("#" + key).attr("data-tName")).hide();
        }

        if (personData.bodyPartDamage[key] > 0) {
            if (personData.bodyPartDamage[key] >= 1) {
                damageName = "light";
            }

            if (personData.bodyPartDamage[key] >= 2) {
                damageName = "medium";
            }

            if (personData.bodyPartDamage[key] == 3) {
                damageName = "heavy";
            }

            if (personData.bodyPartDamage[key] == 4) {
                damageName = "burned";
            }

            document.getElementById(key).setAttribute("data-damage", damageName);
        } else if (personData.needSewed[key] > 0) {
            if (personData.needSewed[key] == 1) {
                damageName = "sewed";
            }

            document.getElementById(key).setAttribute("data-damage", damageName);
        } else {
            document.getElementById(key).setAttribute("data-damage", "none");
        }
    });

    $("#activityLog").html("");
    var newObject = reverseObject(personData.logs);

    Object.keys(newObject).forEach(function (key) {
        $("#activityLog").append("<li>" + _localeType(newObject[key].logType) + newObject[key].logTime + "</li>");
    });
}

function performMethod(methodType) {
    switch (methodType) {
        case "checkPulse":
            $.post('http://visn_are/enable', false);
            $.post('http://visn_are/checkPulse', JSON.stringify({
                source: personData.source,
                personData: personData,
                bodyPart: selectedArea,
            }));
            break;

        case "useBandage":
            $.post('http://visn_are/enable', false);
            $.post('http://visn_are/useBandage', JSON.stringify({
                source: personData.source,
                bandageType: 'bandage',
                bandageArea: selectedArea,
                personData: personData,
            }));
            break;

        case "useElasticBandage":
            $.post('http://visn_are/enable', false);
            $.post('http://visn_are/useBandage', JSON.stringify({
                source: personData.source,
                bandageType: 'elasticBandage',
                bandageArea: selectedArea,
                personData: personData,
            }));
            break;

        case "useQuickClot":
            $.post('http://visn_are/enable', false);
            $.post('http://visn_are/useBandage', JSON.stringify({
                source: personData.source,
                bandageType: 'quickClot',
                bandageArea: selectedArea,
                personData: personData,
            }));
            break;

        case "usePackingBandage":
            $.post('http://visn_are/enable', false);
            $.post('http://visn_are/useBandage', JSON.stringify({
                source: personData.source,
                bandageType: 'packingBandage',
                bandageArea: selectedArea,
                personData: personData,
            }));
            break;

        case "useAtropin":
            $.post('http://visn_are/enable', false);
            $.post('http://visn_are/useLiquid', JSON.stringify({
                source: personData.source,
                liquidType: 'atropine',
                bodyPart: selectedArea,
                personData: personData,
            }));
            break;

        case "useMorphin":
            $.post('http://visn_are/enable', false);
            $.post('http://visn_are/useLiquid', JSON.stringify({
                source: personData.source,
                liquidType: 'morphin',
                bodyPart: selectedArea,
                personData: personData,
            }));
            break;

        case "useEpinephrin":
            $.post('http://visn_are/enable', false);
            $.post('http://visn_are/useLiquid', JSON.stringify({
                source: personData.source,
                liquidType: 'epinephrine',
                bodyPart: selectedArea,
                personData: personData,
            }));
            break;

        case "useSurgicalKit":
            $.post('http://visn_are/enable', false);
            $.post('http://visn_are/useSurgicalKit', JSON.stringify({
                source: personData.source,
                bandageArea: selectedArea,
                personData: personData,
            }));
            break;

        case "removeTourniquet":
            $.post('http://visn_are/enable', false);
            $.post('http://visn_are/removeTourniquet', JSON.stringify({
                source: personData.source,
                bodyPart: selectedArea,
                personData: personData,
            }));
            break;

        case "useTourniquet":
            $.post('http://visn_are/enable', false);
            $.post('http://visn_are/useTourniquet', JSON.stringify({
                source: personData.source,
                bodyPart: selectedArea,
                personData: personData,
            }));
            break;

        case "useBodybag":
            $.post('http://visn_are/enable', false);
            $.post('http://visn_are/useBodybag', JSON.stringify({
                source: personData.source,
                personData: personData,
            }));
            break;

        case "useCPR":
            $.post('http://visn_are/enable', false);
            $.post('http://visn_are/useCPR', JSON.stringify({
                source: personData.source,
                personData: personData,
            }));
            break;

        case "useDefibrilator":
            $.post('http://visn_are/enable', false);
            $.post('http://visn_are/useDefibrilator', JSON.stringify({
                source: personData.source,
                personData: personData,
            }));
            break;

        case "infusionBlood100":
            $.post('http://visn_are/enable', false);
            $.post('http://visn_are/giveInfusion', JSON.stringify({
                source: personData.source,
                giveAmount: 100,
                giveType: 'blood',
                personData: personData,
            }));
            break;

        case "infusionBlood250":
            $.post('http://visn_are/enable', false);
            $.post('http://visn_are/giveInfusion', JSON.stringify({
                source: personData.source,
                giveAmount: 250,
                giveType: 'blood',
                personData: personData,
            }));
            break;

        case "infusionBlood500":
            $.post('http://visn_are/enable', false);
            $.post('http://visn_are/giveInfusion', JSON.stringify({
                source: personData.source,
                giveAmount: 500,
                giveType: 'blood',
                personData: personData,
            }));
            break;

        case "infusionBlood1000":
            $.post('http://visn_are/enable', false);
            $.post('http://visn_are/giveInfusion', JSON.stringify({
                source: personData.source,
                giveAmount: 1000,
                giveType: 'blood',
                personData: personData,
            }));
            break;

        case "resync":
            $.post('http://visn_are/requestResync', JSON.stringify({
                source: personData.source,
                personData: personData,
            }));
            break;

        case "tryPutInVehicle":
            $.post('http://visn_are/enable', false);
            $.post('http://visn_are/tryPutInVehicle', JSON.stringify({
                source: personData.source,
                personData: personData,
            }));
            break;

        case "useEmergencyReviveKit":
            $.post('http://visn_are/enable', false);
            $.post('http://visn_are/useEmergencyReviveKit', JSON.stringify({
                source: personData.source,
                personData: personData,
            }));
            break;

        case "tryPullOutVehicle":
            $.post('http://visn_are/enable', false);
            $.post('http://visn_are/tryPullOutVehicle', JSON.stringify({
                source: personData.source,
                personData: personData,
            }));
            break;

        case "tryCarry":
            $.post('http://visn_are/enable', false);
            $.post('http://visn_are/tryCarry', JSON.stringify({
                source: personData.source,
                personData: personData,
            }));
            break;

        case "checkBloodPressure":
            $.post('http://visn_are/enable', false);
            $.post('http://visn_are/checkBloodPressure', JSON.stringify({
                source: personData.source,
                personData: personData,
                bodyPart: selectedArea,
            }));
            break;

        case "usePainkillers":
            $.post('http://visn_are/enable', false);
            $.post('http://visn_are/usePainkillers', JSON.stringify({
                source: personData.source,
                bodyPart: selectedArea,
            }));
            break;

        case "checkPerson":
            $.post('http://visn_are/enable', false);
            $.post('http://visn_are/checkPerson', JSON.stringify({
                source: personData.source,
                personData: personData,
            }));
            break;

        case "checkBloodVolume":
            $.post('http://visn_are/enable', false);
            $.post('http://visn_are/checkBloodVolume', JSON.stringify({
                source: personData.source,
                personData: personData,
            }));
            break;
    }
}

$(document).keyup(function (e) {
    if (e.keyCode === 27)
        $.post('http://visn_are/enable', false);   // esc
});

var slowHeartbeat;
var normalHeartbeat;
var highHeartbeat;

//normalHBInterval = setInterval(startHB("normal"), 1068);

$("#painScreen").fadeOut("fast");
$("#bloodScreen").fadeOut("fast");
var isIn = false;

function doBloodScreen(state) {
    if (state)
        $("#bloodScreen").fadeIn("fast");
    else
        $("#bloodScreen").fadeOut("fast");
}

function deactivePainEffect() {
    isIn = false;
    $("#painScreen").css("background", "radial-gradient(circle, rgba(0,0,0,0) 0%, rgba(255,255,255,0.0) 0%)");
    $("#painScreen").fadeOut("fast");
}

function runPainEffect(percent) {
    if (isIn) {
        $("#painScreen").css("background", "radial-gradient(circle, rgba(0,0,0,0) 0%, rgba(255,255,255,0.75) " + percent + "%)")
        $("#painScreen").fadeOut("fast");
    } else {
        $("#painScreen").css("background", "radial-gradient(circle, rgba(0,0,0,0) 0%, rgba(255,255,255,0.75) " + percent + "%)")
        $("#painScreen").fadeIn("fast");
    }

    isIn = !isIn;
}

function reverseObject(object) {
    var newObject = {};
    var keys = [];

    for (var key in object) {
        keys.push(key);
    }

    for (var i = keys.length - 1; i >= 0; i--) {
        var value = object[keys[i]];
        newObject[keys[i]] = value;
    }

    return newObject;
}

function _checkTypes() {
    var allTypes = ["checkPerson", "boneBreak", "syringes", "lifeSaver", "rip"];

    allTypes.forEach(type => {
        if ($("#" + type).attr("data-disabled") == "false")
            $("#" + type).attr("data-disabled", "true");
    });

    if (lastSelected != null)
        lastSelected.attr("data-selected", false);

    $('.appButton').each(function (i, obj) {
        if (!$(obj).hasClass("hidden"))
            $(obj).addClass("hidden");
    });

    avaliableTypes.forEach(type => {
        if ($("#" + type).attr("data-disabled") == "true") {
            $("#" + type).attr("data-disabled", "false");
        }
    });
}

function translateContainer() {
    $(".appHealType i").each(function () {
        $(this).tooltip('hide')
            .attr('data-original-title', _localeType($(this).attr("id")))
    });

    $(".appButton").each(function () {
        $(this).tooltip('hide')
            .attr('data-original-title', _localeType($(this).attr("id") + "_title"))
        $(this).text(_localeType($(this).attr("id")));
    });

    $(".appBodyPart").each(function () {
        $(this).tooltip('hide')
            .attr('data-original-title', _localeType($(this).attr("id")))
    });


    $("#bleedToDeathText").text(_localeType("bleed_to_death_text"));
    $("#bleedToDeathText").text(_localeType("bleed_to_death_text"));
    $("#activityHistory").text(_localeType("activityHistory"));
    $("#unconscious_text").text(_localeType("unconscious_text"));
    $("#informEMSText").text(_localeType("inform_ems_text"));

    $('[data-toggle="tooltip"]').tooltip();
}

function _localeType(/**/) {
    var args = arguments;
    if (messages[args[0]] != undefined)
        return String.format(messages[args[0]], args[1])
    else
        return "Not translated: " + args[0]
}