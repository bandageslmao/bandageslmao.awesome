UI = document.createElement("div")
UI.hidden = false
UI.position.fixed()
achieveicon = document.createElement("img")
UI.appendChild(achieveicon)

function visit(){
    if (localStorage.getItem("Visit!") !== "True"){
        snd = new Audio("Audio/achieve1.mp3")
        snd.play()
        localStorage.setItem("Visit!", "True")
        achieveicon.src = "Images/old-roblox-banners-v0-ioau0u85om7b1.png"
    }
}
function noscoped(){
    if (localStorage.getItem("GETNOSCOPEDDD") !== "True"){
        snd = new Audio("Audio/getnoscoped.mp3")
        snd.play()
        snd.volume = 0.5
        localStorage.setItem("GETNOSCOPEDDD", "True")
    }
}
function reset(){
    localStorage.removeItem("GETNOSCOPEDDD")
    localStorage.removeItem("Visit!")
}