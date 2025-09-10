const events = ["creepypasta"];

function creepypasta() {
  const button = document.createElement("button");
  const image = document.createElement("img");
  image.src = "Images/Creepy_Pasta.png";
  button.appendChild(image);
  document.body.appendChild(button);
}

function randomevent() {
  const event = events[Math.floor(Math.random() * events.length)];
  event();
}
