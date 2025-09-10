const icons = ["epic.ico", "soretro.ico", "sponge.ico"];
const randicon = Math.floor(Math.random() * icons.length);
const link = document.createElement("link");
link.rel = "icon";
link.type = "image/x-icon";
link.href = "Favicons/" + icons[randicon];
document.head.appendChild(link);
