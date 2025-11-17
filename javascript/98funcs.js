        function fadein() {
            var dizzy = new Audio
            dizzy.src = "../windowsxpassets/dizzy.mp3"
            dizzy.play()
            dizzy.onerror = function () {
                window.alert("TURN ON YOUR AUTOPLAY OMG BRO")
            }
            dizzy.volume = 0.6
            setInterval(() => {
                dizzy.volume = 0.7
            }, 5000);
            setInterval(() => {
                dizzy.volume = 0.8
            }, 5000);
            setInterval(() => {
                dizzy.volume = 0.9
            }, 5000);
            setInterval(() => {
                localStorage.setItem("Visited", true)
                dizzy.volume = 1
            }, 5000);
            setInterval(() => {
                window.location.href = "../index.html"
            }, 4800);
        }

        function transmission(){
            var ringtone = new Audio
            ringtone.src = "../windowsxpassets/ringing.mp3"
            ringtone.loop = true
            setInterval(() => {
                ringtone.play()
            }, 2000);
        }