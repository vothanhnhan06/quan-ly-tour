<?php
require './mvc/views/user/include/header.php';
require_once "./mvc/core/redirect.php";
require_once "./mvc/core/constant.php";
$redirect = new redirect();
$errors = isset($_SESSION['errors']) ? $_SESSION['errors'] : [];
$data = isset($_SESSION['data']) ? $_SESSION['data'] : [];
?>


<section class="">
    <div class="login-container">
        <div class="login-box" id="loginsection">
            <h1 style="font-size: 30px;">Đăng ký</h1>
            <?php if (isset($_SESSION['error'])) { ?>
                <p class="error-message"><?= $redirect->setFlash('error'); ?></p>
            <?php } ?>

            <?php if (isset($_SESSION['sucess'])) { ?>
                <div id="popup" class="popup">
                    <div class="popup-content">
                        <div class="popup-header">
                            <h3>Thông báo</h3>
                            <span id="close-btn" class="close-btn">&times;</span>
                        </div>
                        <div class="popup-body">
                            <div class="icon-success">
                                &#10004;
                            </div>
                            <p>Bạn đã đăng ký tài khoản thành công. Vui lòng kiểm tra email để kích hoạt tài khoản!</p>
                        </div>
                        <div class="popup-footer">
                            <button id="confirm-btn" class="confirm-btn">Đã hiểu</button>
                        </div>
                    </div>
                </div>
            <?php }
            unset($_SESSION['sucess']); ?>

            <form action="register" method="post">
                <div class="input-group">
                    <label class="title-login" for="fullname">Họ và tên <label class="required">(*)</label></label>
                    <input name="fullname" type="text" placeholder="Nhập họ và tên" id="username"
                        value="<?php
                                echo !empty($data['fullname']) ? $data['fullname'] : '';
                                ?>"
                        required>
                    <p class="error-text"><?= !empty($errors['fullname']) ? $errors['fullname'] : ''; ?></p>
                </div>
                <div class="input-group">
                    <label class="title-login" for="phone_number">Số điện thoại <label class="required">(*)</label></label>
                    <input name="phone_number" type="tel" pattern="[0]{1}[0-9]{9}" placeholder="Nhập số điện thoại" id="username"
                        value="<?php
                                echo !empty($data['phone_number']) ? $data['phone_number'] : '';
                                ?>"
                        required>
                </div>
                <div class="input-group">
                    <label class="title-login" for="email">Email <label class="required">(*)</label></label>
                    <input name="email" type="text" placeholder="Nhập email" id="username"
                        value="<?php
                                echo !empty($data['email']) ? $data['email'] : '';
                                ?>"
                        required>
                    <p class="error-text"><?= !empty($errors['email']) ? $errors['email'] : ''; ?></p>
                </div>
                <div class="input-group">
                    <label class="title-login" for="password">Mật khẩu <label class="required">(*)</label></label>
                    <div class="change-psw">
                        <input name="password" type="password" id="new-password" placeholder="Nhập mật khẩu" required>
                        <button type="button" onclick="togglePassword('new-password', this)">
                            <i class="fa-regular fa-eye-slash"></i>
                        </button>
                    </div>
                    <p class="error-text"><?= !empty($errors['password']) ? $errors['password'] : ''; ?></p>
                </div>
                <div class="input-group">
                    <label class="title-login" for="password">Nhập lại mật khẩu <label class="required">(*)</label></label>
                    <div class="change-psw">
                        <input name="retype-password" type="password" id="confirm-password" placeholder="Nhập lại mật khẩu" required>
                        <button type="button" onclick="togglePassword('confirm-password', this)">
                            <i class="fa-regular fa-eye-slash"></i>
                        </button>
                    </div>
                    <p class="error-text"><?= !empty($errors['retype-password']) ? $errors['retype-password'] : ''; ?></p>
                </div>
                <button type="submit" id="login-btn" class="signup-btn" onclick="showPopup()">Đăng ký</button>
                <div class="options dk">
                    <label for="">Bạn đã có tài khoản?</label><a href="login" style="color: var(--bright-navy-blue); text-decoration: underline;">Đăng nhập</a>
                </div>
            </form>
        </div>
    </div>
</section>

<!-- custom js link  -->
<script>
    function togglePassword(id, button) {
        const input = document.getElementById(id);
        const eyeIcon = button.querySelector('.fa-regular');

        if (input.type === 'password') {
            input.type = 'text'; // 
            eyeIcon.classList.remove('fa-eye-slash');
            eyeIcon.classList.add('fa-eye');
        } else {
            input.type = 'password';
            eyeIcon.classList.remove('fa-eye');
            eyeIcon.classList.add('fa-eye-slash');
        }
    }

    document.getElementById("close-btn").addEventListener("click", function() {
        document.getElementById("popup").style.display = "none";
        window.location.href = "login";
    });

    document.getElementById("confirm-btn").addEventListener("click", function() {
        document.getElementById("popup").style.display = "none";
        window.location.href = "login";
    });
</script>


<!-- ionicon link  -->
<script type="module" src="https://unpkg.com/ionicons@5.5.2/dist/ionicons/ionicons.esm.js"></script>
<script nomodule src="https://unpkg.com/ionicons@5.5.2/dist/ionicons/ionicons.js"></script>
</body>

<?php
unset($_SESSION['errors']);
unset($_SESSION['data']);
require './mvc/views/user/include/footer.php'
?>