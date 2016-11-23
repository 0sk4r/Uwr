function skrypt() {
    var div = document.getElementById("sidebar");
    var link = document.getElementById("czerwony");
    var element = document.createElement("div");
    var content = document.getElementById("content");
    element.style.height = "100px";
    element.style.width = "100px";
    element.style.background = "red";
    div.innerHTML = div.innerHTML + link.innerHTML;
    content.appendChild(element);
}