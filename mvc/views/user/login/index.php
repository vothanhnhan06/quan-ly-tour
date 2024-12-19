<?php
require "./mvc/views/user/include/header.php";
require_once "./mvc/core/redirect.php";
require_once "./mvc/core/constant.php";
$redirect = new redirect();
?>
<main>
    <article>
        <section class="">
            <div class="login-container">
                <div class="login-box" id="loginsection">
                    <h1 style="font-size: 35px;">Chào mừng bạn đến với VietCharm!</h1>
                    <?php if (isset($_SESSION['error'])) { ?>
                        <p class="error-message"><?= $redirect->setFlash('error'); ?></p>
                    <?php } ?>
                    <form action="login" method="post">
                        <div class="input-group">
                            <label class="title-login" for="username">Email <label class="required">(*)</label></label>
                            <input name="email" type="text" placeholder="Nhập email" id="username" required>
                        </div>
                        <div class="input-group">
                            <label class="t itle-login" for="password">Mật khẩu <label class="required">(*)</label></label>
                            <div class="change-psw">
                                <input name="password" type="password" placeholder="Nhập mật khẩu" id="write-password" required>
                                <button type="button" onclick="togglePassword('write-password', this)">
                                    <i class="fa-regular fa-eye-slash"></i>
                                </button>
                            </div>
                        </div>
                        <div class="check-remember d-flex align-items-center justify-content-between">
                            <div class="form-check">
                                <label class="form-check-label" for="rememberMe">Ghi nhớ đăng nhập</label><input class="form-check-input" type="checkbox" id="rememberMe">
                            </div>
                            <a href="forgot" style="color: var(--bright-navy-blue); text-decoration: underline; margin-left: 130px;">Quên mật khẩu?</a>
                        </div><br>
                        <button type="submit" id="login-btn" class="login-btn">Đăng nhập</button>
                    </form>
                    <div class="options">
                        <label for="">Chưa có tài khoản?</label> <a href="register" style="color: var(--bright-navy-blue); text-decoration: underline;">Đăng ký ngay</a>
                    </div>
                    <div class="separator-with-text">
                        <span>Hoặc</span>
                    </div>
                    <div class="social-login">
                        <button class="social-btn facebook"><i class="fa-brands fa-facebook"></i> Đăng nhập với Facebook</button>
                        <button class="social-btn google"><i class="fa-brands fa-google"></i> Đăng nhập với Google</button>
                    </div>
                </div>
            </div>
        </section>
    </article>
</main>



<!-- custom js link  -->


<script>
    function togglePassword(id, button) {
        const input = document.getElementById(id); // Lấy input tương ứng
        const eyeIcon = button.querySelector('.fa-regular'); // Lấy biểu tượng mắt trong button được bấm

        if (input.type === 'password') {
            input.type = 'text'; // Hiển thị mật khẩu
            eyeIcon.classList.remove('fa-eye-slash'); // Xóa icon mắt có dấu gạch chéo
            eyeIcon.classList.add('fa-eye'); // Thêm icon mắt mở
        } else {
            input.type = 'password'; // Ẩn mật khẩu
            eyeIcon.classList.remove('fa-eye'); // Xóa icon mắt mở
            eyeIcon.classList.add('fa-eye-slash'); // Thêm icon mắt có dấu gạch chéo
        }
    }
    document.querySelector('[href="#doimatkhau"]').addEventListener("click", function() {
        document.getElementById("popup").style.display = "flex";
    });
    document.getElementById("close-btn").addEventListener("click", function() {
        document.getElementById("popup").style.display = "none";
        window.location.href = "dangNhap.html";
    });

    document.getElementById("confirm-btn").addEventListener("click", function() {
        document.getElementById("popup").style.display = "none";
        window.location.href = "dangNhap.html";
    });
</script>
<!-- ionicon link  -->
<script type="module" src="https://unpkg.com/ionicons@5.5.2/dist/ionicons/ionicons.esm.js"></script>
<script nomodule src="https://unpkg.com/ionicons@5.5.2/dist/ionicons/ionicons.js"></script>
</body>

</html>

<?php
require "./mvc/views/user/include/footer.php"
?>