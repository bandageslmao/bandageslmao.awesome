banners = [
  "peoplebanner.png",
  "futbol.png",
  "ocean.png",
  "2006.png",
  "christmas.png",
  "city.png",
];
randbanner = banners[Math.floor(Math.random() * banners.length)];
imageofbanner = document.getElementById("Banner");
imageofbanner.src = "Images/" + randbanner;
