function visit(){
    if (localStorage.getItem("Visit!") !== "True"){
        snd = new Audio("Audio/achieve1.mp3")
        snd.play()
        localStorage.setItem("Visit!", "True")
        img = document.createElement("img")
        img.style.position = "fixed"
        img.style.bottom = 0
        img.style.left = 0
        img.style.right = 0
        img.style.margin = "auto"
        img.style.width = 200
        document.body.appendChild(img)
        img.src = "Achievements/visit.png"
        setTimeout(() => {
            img.style.display = "none";
        }, 3000);
    }
}

function noscoped(){
    if (localStorage.getItem("GETNOSCOPEDDD") !== "True"){
        snd = new Audio("Audio/getnoscoped.mp3")
        snd.play()
        snd.volume = 0.5
        localStorage.setItem("GETNOSCOPEDDD", "True")
        img = document.createElement("img")
        img.style.position = "fixed"
        img.style.bottom = 0
        img.style.left = 0
        img.style.right = 0
        img.style.margin = "auto"
        img.style.width = 200
        document.body.appendChild(img)
        img.src = "Achievements/noscoped.png"
        setTimeout(() => {
            img.style.display = "none";
        }, 3000);
    }
}

function thatprimalrage(){
    if (localStorage.getItem("FeelTheFury") !== "True"){
        snd = new Audio("Audio/fe.mp3")
        snd.play()
        snd.volume = 0.5
        localStorage.setItem("FeelTheFury", "True")
        img = document.createElement("img")
        img.style.position = "fixed"
        img.style.bottom = 0
        img.style.left = 0
        img.style.right = 0
        img.style.margin = "auto"
        img.style.width = 200
        document.body.appendChild(img)
        img.src = "Achievements/canyoufeelit.png"
        setTimeout(() => {
            img.style.display = "none";
        }, 3000);
    }
}

function brokenfree(){
    if (localStorage.getItem("BreakFree") !== "True"){
        snd = new Audio("Audio/outtahere.mp3")
        snd.play()
        snd.volume = 0.5
        localStorage.setItem("BreakFree", "True")
        img = document.createElement("img")
        img.style.position = "fixed"
        img.style.bottom = 0
        img.style.left = 0
        img.style.right = 0
        img.style.margin = "auto"
        img.style.width = 200
        document.body.appendChild(img)
        img.src = "Achievements/brokenfree.png"
        setTimeout(() => {
            img.style.display = "none";
        }, 3000);
    }
}

function creepypasta(){
    if (localStorage.getItem("creepypasta") !== "True"){
        snd = new Audio("Audio/crappypasta.mp3")
        snd.play()
        snd.volume = 0.1
        localStorage.setItem("creepypasta", "True")
        img = document.createElement("img")
        img.style.position = "fixed"
        img.style.bottom = 0
        img.style.left = 0
        img.style.right = 0
        img.style.margin = "auto"
        img.style.width = 200
        document.body.appendChild(img)
        img.src = "Achievements/creepypasta"
        setTimeout(() => {
            img.style.display = "none";
        }, 3000);
    }
}

function reset(){
    localStorage.removeItem("GETNOSCOPEDDD")
    localStorage.removeItem("Visit!")
    localStorage.removeItem("FeelTheFury")
    localStorage.removeItem("BreakFree")
    localStorage.removeItem("creepypasta")
}
