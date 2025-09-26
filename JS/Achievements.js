function acimg(achievement) {
  img = document.createElement("img");
  img.style.position = "fixed";
  img.style.bottom = 0;
  img.style.left = 0;
  img.style.right = 0;
  img.style.margin = "auto";
  img.style.width = 200;
  document.body.appendChild(img);
  const src = "/Achievements/" + achievement + ".png";
  img.src = src;
  setTimeout(() => {
    img.style.display = "none";
  }, 3000);
}

function noscoped() {
  if (localStorage.getItem("GETNOSCOPEDDD") !== "True") {
    snd = new Audio("Audio/getnoscoped.mp3");
    snd.play();
    snd.volume = 0.5;
    localStorage.setItem("GETNOSCOPEDDD", "True");
    acimg("noscoped");
  }
}

function thatprimalrage() {
  if (localStorage.getItem("FeelTheFury") !== "True") {
    snd = new Audio("Audio/fe.mp3");
    snd.play();
    snd.volume = 0.5;
    localStorage.setItem("FeelTheFury", "True");
    acimg("canyoufeelit");
  }
}

function brokenfree() {
  if (localStorage.getItem("BreakFree") !== "True") {
    snd = new Audio("Audio/outtahere.mp3");
    snd.play();
    snd.volume = 0.5;
    localStorage.setItem("BreakFree", "True");
    acimg("brokenfree");
  }
}

function creepypastafunc() {
  if (localStorage.getItem("creepypasta") !== "True") {
    snd = new Audio("Audio/crappypasta.mp3");
    snd.play();
    snd.volume = 0.1;
    localStorage.setItem("creepypasta", "True");
    acimg("creepypasta");
  }
}

function tbs() {
  if (localStorage.getItem("NullVoid") !== "True") {
    localStorage.setItem("NullVoid", "True");
    acimg("nullach");
  }
}

if (localStorage.getItem("Visit!") !== "True") {
  localStorage.setItem("Visit", "True");
  snd = new Audio("Audio/achieve1.mp3");
  snd.play();
  localStorage.setItem("Visit!", "True");
  acimg("visit");
}
function bald() {
  if (localStorage.getItem("Oh, Hi!") !== "True") {
    localStorage.setItem("Oh, Hi!", "True");
    snd = new Audio("Audio/bald.mp3");
    snd.play();
    acimg("baldi");
  }
}

function bananaach() {
  if (localStorage.getItem("Banana = :rage:") !== "True") {
    localStorage.setItem("Banana = :rage:", "True");
    acimg("banan");
  }
}

function reset() {
  localStorage.clear();
}
