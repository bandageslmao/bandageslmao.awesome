const bgms = [
  "supersponge",
  "CosmicEternity",
  "MetallicMadness",
  "BreakFree",
  "FeelTheFury",
  "WackyWorkbench",
  "DEADORALIVE",
  "PizzaDeluxe",
  "StardustSpeedway",
  "WWN",
  "TropicalCrust",
  "CrackedEmpire",
  "FriendsNoMore",
    "Blimey!",
    "Metropolis",
    "mii",
    "Spongetastic!",
    "wii party",
    "lies"
];
audio = document.createElement("audio");
document.body.appendChild(audio);
audio.controls = false;
activateautoplay = document.createElement("button");
activateautoplay.hidden = true;
activateautoplay.textContent =
  "Hey! your autoplay's off! click me to turn it on!";
activateautoplay.onclick = () => {
  audio.play();
  activateautoplay.hidden = true;
};
document.body.appendChild(activateautoplay);

function randomizer() {
  if (Math.random() < 0.1) {
    audio.src = "Audio/Nullsad.ogg";
    audio.volume = 1;
    audio.play().catch((err) => {
      activateautoplay.hidden = false;
      console.error("audio failed womp", err);
    });
    tbs();
  } else {
    const bgm =
      "Audio/" + bgms[Math.floor(Math.random() * bgms.length)] + ".mp3";
    audio.src = bgm;
    audio.volume = 0.5;
    audio.play().catch((err) => {
      activateautoplay.hidden = false;
      console.error("audio failed womp", err);
    });
    if (bgm === "Audio/FeelTheFury.mp3") {
      thatprimalrage();
    }
    if (bgm === "Audio/BreakFree.mp3") {
      brokenfree();
    }
  }
}
randomizer();

audio.addEventListener("ended", function () {
  randomizer();
});
