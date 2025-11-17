const day = new Date
const months = ["January","February","March","April","May","June","July","August","September","October","November","December"]
var banner = document.getElementById('banner')
var currentmonth = months[day.getMonth()]
if (currentmonth === "October"){
    banner.src = "images/halloweenbanner.webp"
}
if (currentmonth === "December"){
    banner.src = "images/halloweenbanner.webp"
}