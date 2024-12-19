<?php
require "./mvc/views/user/include/header.php";
require_once "./mvc/core/redirect.php";
require_once "./mvc/core/constant.php";
$redirect = new redirect();
if (isset($_SESSION['errors'])) {
    $errors = $_SESSION['errors'];
}
?>

<!-- Nhập lại mật khẩu -->
<section class="login-container">
    <div class="login-box" id="rewrite-pass">
        <h1>Thiết lập mật khẩu</h1>
        <?php if (isset($_SESSION['sucess'])) { ?>
            <!-- Thông báo -->
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
                        <p>Thiết lập mật khẩu mới thành công!</p>
                    </div>
                    <div class="popup-footer">
                        <button id="confirm-btn" class="confirm-btn">Đã hiểu</button>
                    </div>
                </div>
            </div>
        <?php } unset($_SESSION['sucess']) ?>

        <?php if (isset($_SESSION['error'])) { ?>
            <p class="error-message"><?= $redirect->setFlash('error'); ?></p>
        <?php } ?>
        <form action="" method="post">
            <div class="input-group">
                <label class="title-login" for="username">Mật khẩu mới <label class="required">(*)</label></label>
                <div class="change-psw">
                    <input type="password" name="newPassword" id="new-password" placeholder="Nhập mật khẩu mới" required>
                    <button type="button" onclick="togglePassword('new-password', this)">
                        <i class="fa-regular fa-eye-slash"></i>
                    </button>
                </div>
                <p class="error-text"><?= !empty($errors['newPassword']) ? $errors['newPassword'] : ''; ?></p>
            </div>
            <div class="input-group">
                <label class="title-login" for="password">Nhập lại mật khẩu <label class="required">(*)</label></label>
                <div class="change-psw">
                    <input type="password" name="retype-newPassword" id="confirm-password" placeholder="Nhập lại mật khẩu mới" required>
                    <button type="button" onclick="togglePassword('confirm-password', this)">
                        <i class="fa-regular fa-eye-slash"></i>
                    </button>
                </div>
            </div>
            <p class="error-text"><?= !empty($errors['retype-newPassword']) ? $errors['retype-newPassword'] : ''; ?></p>
            <button type="submit" id="login-btn" class="login-btn">Đổi mật khẩu</button>
        </form>

    </div>
</section>


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
<?php unset($_SESSION['errors']);
require "./mvc/views/user/include/footer.php"
?>