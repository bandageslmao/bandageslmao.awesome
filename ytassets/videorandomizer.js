var videoplayer = document.getElementById('myVideo')
const from = document.getElementById('channeltext')
var played = false
const videos = ["eggman.mp4","hexlescream.mp4","ithurts.mp4","juggle.mp4","lebron.mp4","neighbor.mp4","slenderman vs morty.mp4","speedangry.mp4","superspeed64.mp4"]
var vidnumber = Math.floor(Math.random()* videos.length)
var vid2play = videos[vidnumber]
videoplayer.src = "./Videos/" + vid2play
videoplayer.addEventListener("ended", function(){
    if (played === false){
        gainpoints(25)
        played = true
    }else{
        var nomore = new Audio
        nomore.src = "./sfx/nomore.mp3"
        nomore.volume = 2
        nomore.play()
        console.log("nuh uh uh no more than once")
    }
})
if (vid2play === "eggman.mp4"){
    from.textContent = "Eggman Empire"
}
if (vid2play === "hexlescream.mp4" || vid2play === "ithurts.mp4" || vid2play === "juggle.mp4"){
    from.textContent = "Hi 4.0"
}
if (vid2play === "lebron.mp4"){
    from.textContent = "Lebron James"
}
if (vid2play === "speedangry.mp4" || vid2play === "superspeed64.mp4"){
    from.textContent = "IShowSpeed"
}
if (vid2play === "slenderman vs morty.mp4"){
    from.textContent = "Slenderman"
}
if (vid2play === "neighbor.mp4"){
    from.textContent = "Theodore Peterson"
}