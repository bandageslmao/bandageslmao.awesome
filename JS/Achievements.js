if (localStorage.getItem("Visit!") !== "True"){
    localStorage.setItem("Visit!", "True")
    alert("Achievement Unlocked: Visit! \n Hello!")
    snd = new Audio("Audio/achieve1.mp3")
    snd.play()
}
