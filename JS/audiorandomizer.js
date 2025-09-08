const bgms = ["supersponge","CosmicEternity","MetallicMadness"]
audio = document.createElement("audio")
document.body.appendChild(audio)
audio.controls = false

function randomizer(){
    audio.src = "Audio/" + bgms[Math.floor(Math.random() * bgms.length)] + ".mp3"
    audio.play().catch((err) => {
        alert("you cant get audio because autoplay lalalala")
        })
}
randomizer()

audio.addEventListener("ended",function (){
    randomizer()
})