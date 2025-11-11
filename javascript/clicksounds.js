function click(){
    var snap = new Audio();
    snap.src = "./sfx/snap.wav";
    snap.play();
}

function hover(){
    var button = new Audio();
    button.src = "./sfx/electronicpingshort.wav";
    button.play();
}

document.addEventListener('click', function(event) {
    click();
});
