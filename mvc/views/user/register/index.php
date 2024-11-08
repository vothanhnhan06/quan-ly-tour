<?php
    require_once "./mvc/core/redirect.php";
    require_once "./mvc/core/constant.php";
    $redirect = new redirect();
?>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <title><?= $title ?></title>
</head>

<body>
    <div class="row">
        <div class="col-4" style="margin: 20px auto">
            <h2 class="text-center text-uppercase"><?= $title ?></h2>
            <?php if(isset($_SESSION['flash'])){?>
                        <p style="color: red;"><?= $redirect->setFlash('flash');  ?></p>
                        <?php } ?>
                        <?php if(isset($_SESSION['errors'])){?>
                        <p  style="color: red;"><?= $redirect->setFlash('errors');  ?></p>
                        <?php } ?>
            <form action="register" method="post">
                <div class="form-group mg-form">
                    <label for="">Họ tên</label><br />
                    <input name="fullname" type="text" class="form-cotrol" placeholder="Họ tên">
                </div>

                <div class="form-group mg-form">
                    <label for="">Email</label><br />
                    <input name="email" type="email" class="form-cotrol" placeholder="Địa chỉ email">
                </div>

                <div class="form-group mg-form">
                    <label for="">Số điện thoại</label><br />
                    <input name="phone" type="phone" class="form-cotrol" placeholder="Số điện thoại">
                </div>

                <div class="form-group mg-form">
                    <label for="">Mật khẩu</label><br />
                    <input name="password" type="password" class="form-cotrol" placeholder="Mật khẩu">
                </div>

                <div class="form-group mg-form">
                    <label for="">Nhập lại mật khẩu</label><br />
                    <input name="retype-password" type="password" class="form-cotrol" placeholder="Nhập lại mật khẩu">
                </div>
                <button type="submit" class="btn btn-primary btn-block mg-btn"><Data>Đăng ký</Data></button>
                <hr>
                <p class="text-center"><a href="login">Đăng nhập</a></p>
            </form>
        </div>
    </div>
</body>

</html>