

document.addEventListener("DOMContentLoaded", function() {

    //CHUYỂN ĐỔI GIỮA CÁC SECTION//
    //const header = document.queryAllSelector("header"); // Lấy phần tử header


const header = document.getElementById('header'); // Lấy header
const navbarLinks = document.querySelectorAll('.navbar-link.change-color');
const activeLink = document.querySelector('.navbar-link.active-header');
const logo = document.querySelector('.logo');
const logoScroll = document.querySelector('.logo2');

// Lấy màu sắc ban đầu của header
let originalHeaderColor = header.style.backgroundColor = 'transparent';
let originalHeaderShadow = getComputedStyle(header).boxShadow;

// Sự kiện lắng nghe scroll
window.addEventListener('scroll', function () {
    if (window.scrollY > 50) {
        // Khi cuộn xuống
        header.style.backgroundColor = 'white';
        header.style.boxShadow = '0px 4px 6px rgba(0, 0, 0, 0.3)';
        header.classList.add('scrolled');

        logoScroll.style.display = 'block';
        logo.style.display = 'none';

        navbarLinks.forEach(link => {
            link.style.color = 'black'; // Đổi màu chữ navbar thành đen
        });
        if (activeLink) {
            activeLink.style.color = 'rgb(0, 225, 255)'; // Giữ màu cho link active
        }
    } else {
        // Khi cuộn về đầu trang
        header.style.backgroundColor = originalHeaderColor;
        header.style.boxShadow = originalHeaderShadow;

        logoScroll.style.display = 'none';
        logo.style.display = 'block';

        navbarLinks.forEach(link => {
            link.style.color = 'white'; // Quay lại màu chữ ban đầu
        });

        if (activeLink) {
            activeLink.style.color = 'rgb(0, 225, 255)'; // Giữ màu cho link active
        }
    }
});     
});
    /*SLIDER*/
    let slideIndex = 1;
    showSlides(slideIndex);

    function plusSlides(n) {
    showSlides(slideIndex += n);
    }

    function currentSlide(n) {
    showSlides(slideIndex = n);
    }

    function showSlides(n) {
    let i;
    let slides = document.getElementsByClassName("Slide");
    let dots = document.getElementsByClassName("dot");
    if (n > slides.length) 
    {
            slideIndex = 1
    }    
    if (n < 1) 
    {
        slideIndex = slides.length
    }
    for (i = 0; i < slides.length; i++) 
    {
        slides[i].style.display = "none";  
    }
    for (i = 0; i < dots.length; i++) 
    {
        dots[i].className = dots[i].className.replace("active-slide", "");
    }
    slides[slideIndex-1].style.display = "block";  
    dots[slideIndex-1].className += " active-slide";
    }

  