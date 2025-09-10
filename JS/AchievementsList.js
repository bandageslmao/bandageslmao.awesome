if (localStorage.getItem("Visit!") !== "True") {
  ac1 = document.getElementById("ac1");
  ac1.textContent = "Visit! - Locked";
} else {
  ac1.textContent = "Visit! - Unlocked";
}

if (localStorage.getItem("GETNOSCOPEDDD") !== "True") {
  ac = document.getElementById("ac2");
  ac2.textContent = "GETNOSCOPEDDD - Locked";
} else {
  ac2.textContent = "GETNOSCOPEDDD - Unlocked";
}

if (localStorage.getItem("FeelTheFury") !== "True") {
  ac3 = document.getElementById("ac3");
  ac3.textContent = "That Primal Rage - Locked";
} else {
  ac3.textContent = "That Primal Rage - Unlocked";
}

if (localStorage.getItem("BreakFree") !== "True") {
  ac4 = document.getElementById("ac4");
  ac4.textContent = "Broken Free - Locked";
} else {
  ac4.textContent = "Broken Free - Unlocked";
}

if (localStorage.getItem("creepypasta") !== "True") {
  ac5 = document.getElementById("ac5");
  ac5.textContent = "Creepy-Pasta - Locked";
} else {
  ac5.textContent = "Creepy-Pasta - Unlocked";
}

if (localStorage.getItem("NullVoid") !== "True") {
  ac6 = document.getElementById("ac6");
  ac6.textContent = "Here I Am. - Locked";
} else {
  ac6.textContent = "Here I Am. - Unlocked";
}
