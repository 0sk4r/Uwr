function skrypt(color) {
    var div = document.getElementById("sidebar");
    var element = document.createElement("div");
    var content = document.getElementById("content");
    element.style.height = "100px";
    element.style.width = "100px";

    switch (color) {
        case 'czerwony':
            var link = document.getElementById("czerwony");
            element.style.background = "red";
            break;
        case 'czarny':
            var link = document.getElementById("czarny");
            element.style.background = "black";
            break;
        case 'brazowy':
            var link = document.getElementById("brazowy");
            element.style.background = "brown";
            break;

    }

    div.innerHTML = div.innerHTML + link.innerHTML;
    content.appendChild(element);
}

        #menu {
            border: 5px solid blue;
        }
        
        #content {
            border: 5px solid yellow;
        }
        
        #sidebar {
            border: 5px solid green;
        }

            <div id="menu">
        <a href="Czerwony" id="czerwony" onclick="skrypt('czerwony')" target="_blank">Czerwony</a>
        <a href="Czarny" id="czarny" onclick="skrypt('czarny')" target="_blank">Czarny</a>
        <a href="Brązowy" id="brazowy" onclick="skrypt('brazowy')" target="_blank">Brazowy</a>
    </div>

        <div id="sidebar"></div>    