<div id="doiMK" class="account-info">
    <h2>Đổi mật khẩu</h2>
    <?php if (isset($_SESSION['error'])) { ?>
        <p class="error-message"><?= $redirect->setFlash('error');  ?></p>
    <?php } ?>
    <?php if (isset($_SESSION['sucess'])) { ?>
        <!-- Thông báo đổi mật khẩu thành công -->
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
                    <p>Đổi mật khẩu thành công!</p>
                </div>
                <div class="popup-footer">
                    <button id="confirm-btn" class="confirm-btn">Đã hiểu</button>
                </div>
            </div>
        </div>
    <?php }
    unset($_SESSION['sucess']) ?>
    <form action="" method="post">
        <div class="form-tt">
            <div class="form-mk">
                <label for="password">Mật khẩu cũ</label>
                <div class="change-psw">
                    <input id="password" type="password" name="password" class="form-control" required="">

                    <button type="button" onclick="togglePassword('password', this)">
                        <i class="fa-regular fa-eye-slash"></i>
                    </button>
                </div>
                <p class="error-text"><?= !empty($errors['password']) ? $errors['password'] : ''; ?></p>

                <label for="username">Mật khẩu mới</label>
                <div class="change-psw">
                    <input id="newPassword" type="password" name="newPassword" class="form-control" required="">

                    <button type="button" onclick="togglePassword('newPassword', this)">
                        <i class="fa-regular fa-eye-slash"></i>
                    </button>
                </div>
                <p class="error-text"><?= !empty($errors['newPassword']) ? $errors['newPassword'] : ''; ?></p>

                <label for="email">Nhập lại mật khẩu</label>
                <div class="change-psw">
                    <input id="retype-newPassword" type="password" name="retype-newPassword" class="form-control" required="">

                    <button type="button" onclick="togglePassword('retype-newPassword', this)">
                        <i class="fa-regular fa-eye-slash"></i>
                    </button>
                </div>
                <p class="error-text"><?= !empty($errors['retype-newPassword']) ? $errors['retype-newPassword'] : ''; ?></p>
            </div>

            <button type="submit" id="save-btn" class="save-btn">Lưu</button>
        </div>
    </form>
</div>


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


    // Xử lý thông báo thay đổi mật khẩu 
    document.getElementById("close-btn").addEventListener("click", function() {
        document.getElementById("popup").style.display = "none";
    });

    document.getElementById("confirm-btn").addEventListener("click", function() {
        document.getElementById("popup").style.display = "none";
    });
</script>