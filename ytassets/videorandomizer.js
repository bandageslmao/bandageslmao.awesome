var videoplayer = document.getElementById('myVideo')
const from = document.getElementById('channeltext')
var played = false
const videos = ["eggman.mp4","hexlescream.mp4","ithurts.mp4","juggle.mp4","lebron.mp4","neighbor.mp4","slenderman vs morty.mp4","speedangry.mp4","superspeed64.mp4","diddybludonthecalculator.mov","geeked.mov","gomer.mp4","kayloo.mp4","lugi.mp4","max.mp4","packgod.mp4","sahur.mp4","truthhurts.mp4","whereisdiddy.mp4"]
var vidnumber = Math.floor(Math.random()* videos.length)
var vid2play = videos[vidnumber]
videoplayer.src = "../Videos/" + vid2play
videoplayer.addEventListener("ended", function(){
    if (played === false){
        gainpoints(25)
        played = true
    }else{
        var nomore = new Audio
        nomore.src = "../sfx/nomore.mp3"
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
if (vid2play === "diddybludonthecalculator.mov" || vid2play === "geeked.mov"){
    from.textContent = "funnygreenorange"
}
if (vid2play === "gomer.mp4"){
    from.textContent = "Homer Simpson"
}
if (vid2play === "kayloo.mp4"){
    from.textContent = "Kayloo Anderson"
}
if (vid2play === "lugi.mp4"){
    from.textContent = "Luigi & Co"
}
if (vid2play === "max.mp4"){
    from.textContent = "Max Design Pro"
}
if (vid2play === "packgod.mp4"){
    from.textContent = "Annoying Orange"
}
if (vid2play === "sahur.mp4"){
    from.textContent = "Triple T Sahur"
}
if (vid2play === "truthhurts.mp4"){
    from.textContent = "ZexenElectric"
}
if (vid2play === "whereisdiddy.mp4"){
    from.textContent = "the diddy blud files"
}