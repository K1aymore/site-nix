

function sortList() {

    list = document.getElementById("interestsList");
    listItems = list.getElementsByTagName("LI");

    cycleTimes = Math.floor(Math.random() * (listItems.length-1)) + 1;

    loops = 0;
    while (loops < cycleTimes) {
        list.insertBefore(listItems[0], listItems[listItems.length]);
        loops++;
    }

}