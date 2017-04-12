function zenter(id) {
    while (id) {
        if (id.className == "zoomable") {
            id.className = "zoomed";
            return;
        }
        id = id.parentNode;
    }
}

function zescape() {
    znodes = document.querySelectorAll(".zoomed");
    for (i = 0; i < znodes.length; i++) {
        znodes[i].className = "zoomable";
    }
}

document.onkeydown = function(evt) {
    evt = evt || window.event;
    if (evt.keyCode == 27)
        zescape();
};
