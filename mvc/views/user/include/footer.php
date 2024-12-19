<!-- Footer  -->
<footer class="footer">
    <div class="container">
        <div class="newsletter">
            <h3>ĐĂNG KÝ NHẬN BẢN TIN MỚI NHẤT</h3>
            <div class="nhapemail">
                <input type="email" placeholder="Nhập email của bạn ở đây!">
                <button>Gửi</button>
            </div>
            <h3>CHẤP NHẬN THANH TOÁN</h3>
            <div class="payment-methods">
                <div><img src="/quan-ly-tour/public/uploads/images/vimomo.png" alt="MoMo"></div>
                <div><img src="/quan-ly-tour/public/uploads/images/zalopay.png" alt="Zalo Pay"></div>
                <div><img src="/quan-ly-tour/public/uploads/images/vnpay.png" alt="VNPay"></div>
                <div><img src="/quan-ly-tour/public/uploads/images/thevisa.png" alt="VISA"></div>
            </div>
        </div>
        <div class="links">
            <h3>ĐIỂM ĐẾN</h3>
            <a href="mienBac.html">Miền Bắc</a>
            <a href="mienTrung.html">Miền Trung</a>
            <a href="mienNam.html">Miền Nam</a>
        </div>
        <div class="links">
            <h3>TOUR</h3>
            <a href="tourDacBiet.html">Tour đặc biệt</a>
            <a href="mienBac.html">Miền Bắc</a>
            <a href="mienTrung.html">Miền Trung</a>
            <a href="mienNam.html">Miền Nam</a>
        </div>
        <div class="links">
            <h3>THÔNG TIN</h3>
            <a href="gioiThieu.html">Về chúng tôi</a>
            <a href="lienHe.html">Liên hệ</a>
        </div>
    </div>
    <hr class="footer-line">
    <div class="below">
        <div class="logo">
            <img src="/quan-ly-tour/public/uploads/images/logo-white.png" alt="VietCharm Logo" class="vietcharm-logo">
            <h3>VietCharm</h3>
        </div>

        <div class="contact-info">
            <p> <i class="fa-solid fa-location-dot"></i> Đường Tạ Quang Bửu, Khu phố 6, phường Linh Trung, Thành phố Thủ Đức, Hồ Chí Minh</p>
            <div id="email-phone-fax">
                <p><i class="fa-regular fa-envelope"></i> Email: vietcham.contact@gmail.com</p>
                <p><i class="fa-solid fa-phone"></i> Phone: 0324561235</p>
                <p><i class="fa-solid fa-fax"></i> Fax: 19006067</p>
            </div>
        </div>
    </div>

</footer>
</article>
</main>



<!-- custom js link  -->
<script src="/quan-ly-tour/public/assets/js/header.js"></script>
<script src="./assets/js/phanTrangMB.js"></script>
<script src="./assets/js/phanTrangMT.js"></script>
<script src="./assets/js/phanTrangMN.js"></script>
<script src="./assets/js/phanTrangDB.js"></script>
<script src="./assets/js/tourNoiBacTrongThang.js"></script>
<script src="./assets/js/chiTietLichTrinh.js"></script>
<script>
    const userNameButton = document.getElementById('user-name');
    const userOptions = document.querySelector('.user-options');

    userNameButton.addEventListener('click', function() {
        if (userOptions.style.display === "block") {
            userOptions.style.display = "none";
        } else {
            userOptions.style.display = "block";
        }
    });
</script>
<!-- ionicon link  -->
<script type="module" src="https://unpkg.com/ionicons@5.5.2/dist/ionicons/ionicons.esm.js"></script>
<script nomodule src="https://unpkg.com/ionicons@5.5.2/dist/ionicons/ionicons.js"></script>

</body>

</html>