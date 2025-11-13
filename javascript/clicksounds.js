function click(){
    var snap = new Audio();
    snap.src = "./sfx/snap.wav";
    snap.volume = 0.5
    snap.play();
}

function hover(){
    var button = new Audio();
    button.src = "./sfx/electronicpingshort.wav";
    button.play();
}

function leave(){
    var button = new Audio();
    button.src = "./sfx/Kerplunk.wav"
    button.play()
}

document.addEventListener('click', function(event) {
    click();
});

document.addEventListener('DOMContentLoaded', function() {
    var links = document.querySelectorAll('a')
    var buttons = document.querySelectorAll('button')
    links.forEach(link => {
        link.addEventListener('mouseover', hover)
        link.addEventListener('mouseleave', leave)
    })
    buttons.forEach(button => {
        button.addEventListener('mouseover', hover)
        button.addEventListener('mouseleave', leave)
    })
})