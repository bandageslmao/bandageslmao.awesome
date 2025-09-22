const randoms = ["cats.html"]
function generate(){
    page = randoms[Math.floor(Math.random() * randoms.length)];
    window.location.href = "randoms/" + page;
}