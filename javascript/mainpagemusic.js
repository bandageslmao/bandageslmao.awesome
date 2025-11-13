var muted = false
var songs = ["buildyourowngame.mp3","crossroadtimes.mp3","happydayinrobloxhq.mp3","mule.mp3","noobalert.mp3","robloxtheme.mp3"]
var selectedsong = Math.floor(Math.random()* songs.length)
var song = new Audio
song.src = "/music/pagespecific/home/" + songs[selectedsong]
song.volume = 0.5
song.loop = true
function autoplayenabler(){
    const button = document.createElement('button')
    button.textContent = "hi, click me to turn on the autoplay!"
    const bigbox = document.getElementById('bigbox')
    bigbox.appendChild(button)
    button.onclick = function() { song.play() }
}
song.play().catch(Error => {
    autoplayenabler()
})
const musicbutton = document.getElementById('mute-unmute')
musicbutton.onclick = function muteandunmute(){
    if (muted === false){
        muted = true
        song.pause()
    }else{
        muted = false
        song.play()
    }
}