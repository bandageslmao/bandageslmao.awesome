const UI = document.createElement("div")
const achievename = document.createElement("h4")
const achievereq = document.createElement("p")
const achieveicon = document.createElement("img")
UI.appendChild(achieveicon)
UI.appendChild(achievename)
UI.appendChild(achievereq)
document.body.appendChild(UI)

function visit(){
    if (localStorage.getItem("Visit!") !== "True"){
        snd = new Audio("Audio/achieve1.mp3")
        snd.play()
        localStorage.setItem("Visit!", "True")
        achieveicon.src = "Images/old-roblox-banners-v0-ioau0u85om7b1.png"
        achievename.textContent = "Visit!"
        alert("Achievement Get: Visit!")
    }
}

function noscoped(){
    if (localStorage.getItem("GETNOSCOPEDDD") !== "True"){
        snd = new Audio("Audio/getnoscoped.mp3")
        snd.play()
        snd.volume = 0.5
        localStorage.setItem("GETNOSCOPEDDD", "True")
        achievename.textContent = "GETNOSCOPEDDD"
        alert("Achievement Get: GETNOSCOPEDDD")
    }
}

function thatprimalrage(){
        if (localStorage.getItem("FeelTheFury") !== "True"){
        snd = new Audio("Audio/fe.mp3")
        snd.play()
        snd.volume = 0.5
        localStorage.setItem("FeelTheFury", "True")
        achievename.textContent = "That Primal Rage"
        alert("Achievement Get: That Primal Rage")
    }
}

function brokenfree(){
    if (localStorage.getItem("BreakFree") !== "True"){
        snd = new Audio("Audio/outtahere.mp3")
        snd.play()
        snd.volume = 0.5
        localStorage.setItem("BreakFree", "True")
        achievename.textContent = "Broken Free"
        alert("Achievement Get: Broken Free")
    }
}

function creepypasta(){
    if (localStorage.getItem("creepypasta") !== "True"){
        snd = new Audio("Audio/crappypasta.mp3")
        snd.play()
        snd.volume = 0.1
        localStorage.setItem("creepypasta", "True")
        achievename.textContent = "Ooh, very scary."
        alert("Achievement Get: Ooh, Very Scary.")
    }
}

function reset(){
    localStorage.removeItem("GETNOSCOPEDDD")
    localStorage.removeItem("Visit!")
    localStorage.removeItem("FeelTheFury")
    localStorage.removeItem("BreakFree")
    localStorage.removeItem("creepypasta")
}
