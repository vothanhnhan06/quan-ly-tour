<?php
    require_once "./mvc/core/redirect.php";
    require_once "./mvc/core/constant.php";
    $redirect = new redirect();
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Home</title>
</head>
<body>
    <h1>Welcome to My Website!</h1>
    <a href="auth/login">Đăng nhập</a>
    <a href="auth/register">Đăng ký</a>
    <a href="auth/logout">Đăng xuất</a>
</body>
</html>