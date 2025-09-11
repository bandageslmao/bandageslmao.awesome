const mequot = document.createElement("p");
mequot.style.fontFamily = "minecraft";
mequot.style.color = "yellow";
mequot.className = "Quote";
mequot.style.animation = "pulsate 5s ease-in-out infinite";
mequot.style.textAlign = "center";
const bodiv = document.getElementById("body");
document.body.appendChild(mequot);
bodiv.appendChild(mequot);
const quotes = [
  "Made with Webstorm!",
  "do you want to play an underguater game with me?",
  "Are you ready kids?",
  "feal",
  "Risking my life for these friends ive found!",
  "Better than chezzkids!",
  "i like hotdogs - bandageslmao",
  "Builderman 4 Prez!",
  "Jarate!",
  "Lets do this texas style - Bandageslmao",
  "grounded sim please come back i need you grounded sim",
  "Also Try Phighting!",
  "loader ror2 my beloved",
  "Also Try TBS on minecraft!",
  "i <3 my riends",
  "Lets Chat! how are you feeling?",
  "You better get ready to die!",
  "dm the owner about PA, it'll be funny.",
  "THE.PAST.IS.NOT.A.SAFE.HAVEN",
  "Ready for round 2?",
  "Way past cool!",
  "My name is Pace!",
  "We Love You!",
  "kayloo, how dare you go to bandageslmao.awesome. Thats it, you are ungrounded ungrounded ungrounded",
  "put me back in 12th grade, put me back in 12th grade, put me back in 12th grade",
  '"I HATE CACTI" - ANGRY GREG',
];
const randquote = Math.floor(Math.random() * quotes.length);
mequot.textContent = quotes[randquote];
