if (!localStorage.getItem("Points")){
    localStorage.setItem("Points",0)
}
if (!localStorage.setItem("Visited")){
    window.location.href = "pages/firsttime.html"
}
var Points = localStorage.getItem("Points")

function gainpoints(amnt) {
    localStorage.setItem("Points", parseInt(Points)+ amnt)
    const cooldiv = document.createElement('div')
    document.body.appendChild(cooldiv)
    const jpeg = new Image
    jpeg.style.width = "150px"
    jpeg.style.height = "150px"
    jpeg.style.float = "Left"
    jpeg.src = "../images/pointdecal.png"
    cooldiv.appendChild(jpeg)
    const awarded = document.createElement('h4')
    awarded.style.color = "White"
    awarded.style.fontFamily = 'Comic Sans MS'
    awarded.textContent = "You Have Been Awarded " + amnt + " Player Points! Hooray!"
    cooldiv.appendChild(awarded)
    cooldiv.style.width = "300px"
    cooldiv.style.height = "150px"
    cooldiv.style.backgroundColor = "rgba(0,0,0,0.5)"
    cooldiv.style.position = "fixed"
    cooldiv.style.bottom = "0"
    cooldiv.style.right = "0"
    cooldiv.animate(
        [
            { transform: 'translateX(100%)' },
            { transform: 'translateX(0px)' }
        ],
        {
            duration: 200,
            iterations: 1
        }
    )
    setTimeout(() => {
        cooldiv.animate(
            [
                { transform: 'translateX(0px)' },
                { transform: 'translateX(100%)' }
            ],
            {
                duration: 200,
                iterations: 1
            }
        )
    }, 5000);
    setTimeout(() => {
        cooldiv.remove()
    }, 5190);
}

function deduction(amnt) {
    if (parseInt(Points) > 0) {
        localStorage.setItem("Points", parseInt(Points) - amnt)
    } else {
        console.log('debt')
    }
}

if (parseInt(Points) < 0) {
    localStorage.setItem("Points", 0)
}