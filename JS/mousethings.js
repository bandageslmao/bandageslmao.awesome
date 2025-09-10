function bump() {
  const bumper = new Audio("Audio/bumper.mp3");
  bumper.play();
}
function splat() {
  const splatsound = new Audio("Audio/splat.mp3");
  splatsound.play();
  splatsound.volume = 0.3;
}
function denied() {
  const denied = new Audio("Audio/denied.mp3");
  denied.play();
  denied.volume = 0.3;
}
function click() {
  const csound = new Audio("Audio/clicksound.mp3");
  csound.play();
  csound.volume = 0.3;
}
