document.addEventListener("DOMContentLoaded", function () {
    const menuItems = document.querySelectorAll(".menu a");
    const contentDiv = document.getElementById("content");

    const currentPath = window.location.pathname;

    menuItems.forEach(function (item) {
        if (currentPath.includes(item.getAttribute("href"))) {
            item.classList.add("active_tt");

            fetch(item.getAttribute("href"))
                .then(response => response.text()) 
                .then(data => {
                    contentDiv.innerHTML = data; 
                })
                .catch(error => {
                    console.error("Error loading content:", error);
                });
        }
    });

    menuItems.forEach(function (item) {
        item.addEventListener("click", function (event) {

            menuItems.forEach(function (el) {
                el.classList.remove("active_tt");
            });

            this.classList.add("active_tt");

            fetch(item.getAttribute("href"))
                .then(response => response.text()) 
                .then(data => {
                    contentDiv.innerHTML = data; 
                })
                .catch(error => {
                    console.error("Error loading content:", error);
                });
        });
    });
});