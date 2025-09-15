ac1 = document.getElementById("ac1");
ac2 = document.getElementById("ac2");
ac3 = document.getElementById("ac3");
ac4 = document.getElementById("ac4");
ac5 = document.getElementById("ac5");
ac6 = document.getElementById("ac6");
ac7 = document.getElementById("ac7");
ac8 = document.getElementById("ac8");
ac9 = document.getElementById("banana")


if (localStorage.getItem("Visit!") !== "True") {
  ac1.textContent = "Visit! - Locked";
} else {
  ac1.textContent = "Visit! - Unlocked";
}

if (localStorage.getItem("GETNOSCOPEDDD") !== "True") {
  ac2.textContent = "GETNOSCOPEDDD - Locked";
} else {
  ac2.textContent = "GETNOSCOPEDDD - Unlocked";
}

if (localStorage.getItem("FeelTheFury") !== "True") {
  ac3.textContent = "That Primal Rage - Locked";
} else {
  ac3.textContent = "That Primal Rage - Unlocked";
}

if (localStorage.getItem("BreakFree") !== "True") {
  ac4.textContent = "Broken Free - Locked";
} else {
  ac4.textContent = "Broken Free - Unlocked";
}

if (localStorage.getItem("creepypasta") !== "True") {
  ac5.textContent = "Creepy-Pasta - Locked";
} else {
  ac5.textContent = "Creepy-Pasta - Unlocked";
}

if (localStorage.getItem("NullVoid") !== "True") {
  ac6.textContent = "Here I Am. - Locked";
} else {
  ac6.textContent = "Here I Am. - Unlocked";
}

if (localStorage.getItem("Oh, Hi!") !== "True") {
    ac7.textContent = "Oh, Hi! - Locked";
}
    else {
        ac7.textContent = "Oh, Hi! - Unlocked";
    }

if (localStorage.getItem("Banana = :rage:") !== "True") {
    ac9.textContent = "Banana = 😡 - Locked"
}
else{
  ac9.textContent = "Banana = 😡 - Unlocked"
}


if (
  localStorage.getItem("Visit!") === "True" &&
  localStorage.getItem("GETNOSCOPEDDD") === "True" &&
  localStorage.getItem("FeelTheFury") === "True" &&
  localStorage.getItem("BreakFree") === "True" &&
  localStorage.getItem("Oh, Hi!") === "True" &&
  localStorage.getItem("NullVoid") === "True" &&
  localStorage.getItem("Banana = 😡") === "True"
) {
  ac8.textContent = "Completionist - Unlocked";
  completesound = new Audio("Audio/youwin.mp3")
  completesound.volume = 1
  completesound.play()
}else{
  ac8.textContent = "Completionist - Locked";
}