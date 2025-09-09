const UI = document.createElement("div")
const achievename = document.createElement("h4")
const achievereq = document.createElement("p")
const achieveicon = document.createElement("img")
UI.appendChild(achieveicon)
UI.appendChild(achievename)
UI.appendChild(achievereq)
document.body.appendChild(UI)

function showAchievement() {
    const popup = document.createElement('div');
    popup.className = 'achievement-popup';

    popup.innerHTML = `
      <img src="https://via.placeholder.com/64" alt="Achievement Icon">
      <div class="achievement-text">
        <div class="achievement-title">Achievement Unlocked!</div>
        <div class="achievement-desc">You read your first creepypasta.</div>
      </div>
    `;

    document.body.appendChild(popup);

    // Trigger animation
    setTimeout(() => {
        popup.classList.add('show');
    }, 100);

    // Auto-remove after 5 seconds
    setTimeout(() => {
        popup.classList.remove('show');
        setTimeout(() => popup.remove(), 500); // Wait for transition to finish
    }, 5000);
}

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
