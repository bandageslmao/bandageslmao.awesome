var Points = localStorage.getItem("Points")
if (localStorage.getItem("Visited") ===! true){
    window.location.href = "./firsttime.html"
    localStorage.setItem("Points",0)
}

function gainpoints(amnt){
    const pointsound = new Audio
    pointsound.src = "./sfx/gainpoints.mp3"
    pointsound.volume = 1
    pointsound.play()
    localStorage.setItem("Points",parseInt(Points) + amnt)
}