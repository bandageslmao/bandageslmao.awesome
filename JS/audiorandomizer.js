const bgms = ["supersponge","CosmicEternity","MetallicMadness","BreakFree","FeelTheFury","WackyWorkbench"]
audio = document.createElement("audio")
document.body.appendChild(audio)
audio.controls = false
audio.volume = 0.5
activateautoplay = document.createElement("button")
activateautoplay.hidden = true
activateautoplay.textContent = "Hey! your autoplay's off! click me to turn it on!"
activateautoplay.onclick = () => {
    visit()
    audio.play()
    activateautoplay.hidden = true
}
document.body.appendChild(activateautoplay)

function randomizer(){
    const bgm = "Audio/" + bgms[Math.floor(Math.random() * bgms.length)] + ".mp3"
    audio.src = bgm
    audio.play().catch((err) => {
        activateautoplay.hidden = false
    })
    if (bgm === "Audio/FeelTheFury.mp3"){
        thatprimalrage()
    }
    if (bgm === "Audio/BreakFree.mp3"){
        brokenfree()
    }
}
randomizer()

audio.addEventListener("ended",function (){
    randomizer()
})