var Points = localStorage.getItem("Points")
if (localStorage.getItem("Visited") ===! true){
    window.location.href = "./firsttime.html"
    localStorage.setItem("Points",0)
}

function texttest(){
    const addition = document.createElement('h1')
    addition.style.textAlign = 'center'
    var animation = addition.animate(
        [
            { transform: 'translateY(500%)'},
            { transform: 'translateY(-10%)'},
            { transform: 'translateY(-10%)'},
            { transform: 'translateY(-10%)'},
            { transform: 'translateY(-10%)'},
            { transform: 'translateY(-10%)'},
            { transform: 'translateY(125%)'}
        ],
        {
            duration: 3000,
            iterations: 1
        }
    )
    document.body.appendChild(addition)
    addition.style.fontFamily = ""
    addition.style.zIndex = '10'
    addition.textContent = "YTPS: " + Points
    animation.addEventListener('finish',function(){
        addition.remove()
    })
}

function gainpoints(amnt){
    const pointsound = new Audio
    pointsound.src = "./sfx/gainpoints.mp3"
    pointsound.volume = 1
    pointsound.play()
    localStorage.setItem("Points",parseInt(Points) + amnt)
}