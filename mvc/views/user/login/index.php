<?php
    require_once "./mvc/core/redirect.php";
    require_once "./mvc/core/constant.php";
    $redirect = new redirect();
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Login</title>
</head>
<body>
    <div class="row">
        <div class="col-4" style="margin: 20px auto">
            <h2 class="text-center text-uppercase">Đăng nhập</h2>
            <?php if(isset($_SESSION['flash'])){?>
                        <p style="color: red;"><?= $redirect->setFlash('flash');  ?></p>
                        <?php } ?>
                        <?php if(isset($_SESSION['errors'])){?>
                        <p  style="color: red;"><?= $redirect->setFlash('errors');  ?></p>
                        <?php } ?>
            <form action="" method="post">
                <div class="form-group mg-form">
                    <label for="">Email</label><br />
                    <input name="email" type="email" class="form-cotrol" placeholder="Địa chỉ email">
                </div>

                <div class="form-group mg-form">
                    <label for="">Mật khẩu</label><br />
                    <input name="password" type="password" class="form-cotrol" placeholder="Mật khẩu">
                </div>

                <button type="submit" class="btn btn-primary btn-block mg-btn"><Data>Đăng nhập</Data></button>
                <hr>
                <p class="text-center"><a href="forgot">Quên mật khẩu</a></p>
                <p class="text-center"><a href="register">Đăng ký tài khoản</a></p>
            </form>
        </div>
    </div>
</body>
</html>
