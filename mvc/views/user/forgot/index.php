<?php
require "./mvc/views/user/include/header.php";
require_once "./mvc/core/redirect.php";
require_once "./mvc/core/constant.php";
$redirect = new redirect();
?>
        </section>
        <!-- Quên mật khẩu -->
        <div>
            <section class="login-container" id="rechange-passwword">
                <div class="login-box">
                    <h1>Đặt lại mật khẩu</h1>
                    <?php if (isset($_SESSION['sucess'])) { ?>
                        <p class="sucess-message"><?= $redirect->setFlash('sucess'); ?></p>
                    <?php } ?>

                    <?php if (isset($_SESSION['error'])) { ?>
                        <p class="error-message"><?= $redirect->setFlash('error'); ?></p>
                    <?php } ?>
                    <form action="forgot" method="post">
                        <div class="input-group">
                            <label class="title-login" for="username">Email <label class="required">(*)</label>
                                <input name="email" type="text" placeholder="Nhập email" id="username" required style="font-weight: 500;">
                        </div>
                        <a href="../" style="color: var(--bright-navy-blue); margin-left: 58%; margin-top: 8px; text-decoration: underline;">Quay lại trang chủ</a><br>
                        <button type="submit" id="login-btn" class="login-btn">Gửi</button>
                    </form>
                </div>
            </section>

            <?php
            require "./mvc/views/user/include/footer.php"
            ?>