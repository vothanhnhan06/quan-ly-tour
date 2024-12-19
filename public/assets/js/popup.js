document.addEventListener("DOMContentLoaded", function() {
    document.getElementById("login-btn").addEventListener("click", function () {
    document.getElementById("popup").style.display = "flex";

    document.getElementById("close-btn").addEventListener("click", function () {
        document.getElementById("popup").style.display = "none";
    });

    document.getElementById("confirm-btn").addEventListener("click", function () {
        document.getElementById("popup").style.display = "none";
    });
})});
