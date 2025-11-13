var Points = localStorage.getItem("Points")
if (localStorage.getItem("Visited") === true){
    window.location.href = "./firsttime.html"
    localStorage.setItem("Points",0)
}

function texttest(){
}

function gainpoints(amnt){
    const pointsound = new Audio
    pointsound.src = "./sfx/gainpoints.mp3"
    pointsound.volume = 1
    pointsound.play()
    localStorage.setItem("Points",parseInt(Points) + amnt)
}

function deduction(amnt){
    if (parseInt(Points) > 0){
        localStorage.setItem("Points",parseInt(Points)- amnt)
    }else{
        console.log('debt')
    }
}

if (parseInt(Points) < 0){
    localStorage.setItem("Points",0)
}