function creepypasta() {
  const button = document.createElement("button");
  button.style.position = "relative"
  button.style.bottom = "-50000px"
  button.style.scale = "25%"
  const image = document.createElement("img");
  image.src = "Images/Creepy_Pasta.png";
  button.appendChild(image);
  document.body.appendChild(button);
  button.onclick = function(){
    creepypastafunc()
  }
}

if (Math.random() < 0.0054){
  creepypasta()
}