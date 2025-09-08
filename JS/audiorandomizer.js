const bgms = ["supersponge","CosmicEternity","MetallicMadness"]
audio = document.createElement("audio")
document.body.appendChild(audio)
audio.controls = false
audio.volume = 0.5
activateautoplay = document.createElement("button")
activateautoplay.hidden = true
activateautoplay.textContent = "Hey! your autoplay's off! click me to turn it on!"
activateautoplay.onclick = () => {
    audio.play()
    activateautoplay.hidden = true
}
document.body.appendChild(activateautoplay)

function randomizer(){
    audio.src = "Audio/" + bgms[Math.floor(Math.random() * bgms.length)] + ".mp3"
    audio.play().catch((err) => {
        activateautoplay.hidden = false
    })
}
randomizer()

audio.addEventListener("ended",function (){
    randomizer()
})