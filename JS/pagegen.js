const randoms = ["cats.html","talktoyourself.html","pajeet'spage.html","AOclicker.html"]
function generate(){
    page = randoms[Math.floor(Math.random() * randoms.length)];
    window.location.href = "randoms/" + page;
}