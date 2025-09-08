function visit(){
    if (localStorage.getItem("Visit!") !== "True"){
        snd = new Audio("Audio/achieve1.mp3")
        snd.play()
        localStorage.setItem("Visit!", "True")
        alert("Achievement Unlocked: Visit! \n Hello!")
    }
}
function noscoped(){
    if (localStorage.getItem("GETNOSCOPEDDD") !== "True"){
        snd = new Audio("Audio/getnoscoped.mp3")
        snd.play()
        snd.volume = 0.5
        localStorage.setItem("GETNOSCOPEDDD", "True")
        alert("Achievement Unlocked: 360NOSCOPEEEE \n GETNOSCOPEDDD: Click a button!")
    }
}
function reset(){
    localStorage.removeItem("GETNOSCOPEDDD")
    localStorage.removeItem("Visit!")
}