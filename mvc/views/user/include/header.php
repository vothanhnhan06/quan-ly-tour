<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Tourly - Travel agancy</title>
    <!-- favicon -->
    <link rel="shortcut icon" href="./favicon.svg" type="image/svg+xml">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <!-- custom css link  -->
    <link rel="stylesheet" href="/quan-ly-tour/public/assets/css/user/home.css">
    <link rel="stylesheet" href="/quan-ly-tour/public/assets/css/user/login.css">
    <link rel="stylesheet" href="/quan-ly-tour/public/assets/css/user/register.css">
    <link rel="stylesheet" href="/quan-ly-tour/public/assets/css/user/footer.css">
    <link rel="stylesheet" href="/quan-ly-tour/public/assets/css/user/about.css">
    <link rel="stylesheet" href="/quan-ly-tour/public/assets/css/user/info.css">
    <link rel="stylesheet" href="/quan-ly-tour/public/assets/css/user/tourMienBac.css">
    <link rel="stylesheet" href="/quan-ly-tour/public/assets/css/user/danhSachTour.css">
    <link rel="stylesheet" href="/quan-ly-tour/public/assets/css/user/chiTiet.css">
    <link rel="stylesheet" href="/quan-ly-tour/public/assets/css/user/ttDatTour.css">
    <link rel="stylesheet" href="/quan-ly-tour/public/assets/css/user/thanhToan.css">
    <link rel="stylesheet" href="/quan-ly-tour/public/assets/css/user/thueDichVu.css">
    <link rel="stylesheet" href="/quan-ly-tour/public/assets/css/user/lienLac.css">
    <link rel="stylesheet" href="/quan-ly-tour/public/assets/css/user/qlKhachHang.css">
    <link rel="stylesheet" href="/quan-ly-tour/public/assets/css/user/qlHoaDonTour.css">
    <link rel="stylesheet" href="/quan-ly-tour/public/assets/css/user/tourDacBiet.css">

    <!--DEMO-->
    <link rel="stylesheet" href="/quan-ly-tour/public/assets/css/demo/thueDichVu.css">
    <link rel="stylesheet" href="/quan-ly-tour/public/assets/css/demo/tourMienBac.css">
    <link rel="stylesheet" href="/quan-ly-tour/public/assets/css/demo/danhSachTour.css">

    <style>
    .navbar-link:hover {
        color: var(--bright-navy-blue);
    }
    </style>
    <!-- google font  -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;500;600&display=swap" rel="stylesheet">
    <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
</head>

<body id="top">
    <nav id="header" class="navbar navbar-expand-lg navbar-light bg-light header-background">
        <a href="/quan-ly-tour/">
            <img src="/quan-ly-tour/public/uploads/images/logo-blue.png" alt="Logo" class="logo"
                style="width: 160px; height: auto; margin-left: 60px; margin-top: -20px;">
        </a>

        <div class="container">
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav"
                aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse navbar-header" id="navbarNav">
                <ul class="navbar-nav ms-auto navbar-list">
                    <li class="nav-item"><a href="/quan-ly-tour/" class="navbar-link">Trang chủ</a></li>
                    <li class="nav-item"><a href="/quan-ly-tour/about" class="navbar-link">Giới thiệu</a></li>
                    <li class="nav-item dropdown">
                        <div class="dropdown-des">
                            <a href="#destination" class="navbar-link desdrop dropdown-toggle" id="navbarDropdown"
                                data-bs-toggle="dropdown" aria-expanded="false">Điểm đến</a>
                            <ul class="dropdown-menu dropdown-content" aria-labelledby="navbarDropdown">
                                <li><a class="dropdown-item" href="/quan-ly-tour/destination/index/2">Miền Bắc</a></li>
                                <li><a class="dropdown-item" href="/quan-ly-tour/destination/index/3">Miền Trung</a>
                                </li>
                                <li><a class="dropdown-item" href="/quan-ly-tour/destination/index/1">Miền Nam</a></li>
                            </ul>
                        </div>
                    </li>
                    <li class="nav-item"><a href="tour.html" class="navbar-link">Tour</a></li>
                    <li class="nav-item"><a href="lienHe.html" class="navbar-link">Liên hệ</a></li>
                    <?php if (isset($_SESSION['user'])) { ?>
                    <li class="nav-item">
                        <div id="user-profile" class="user-profile">
                            <div class="user-account">
                                <?php $avatar = isset($data['user']['avatar_url']) ? '/quan-ly-tour/' . $data['user']['avatar_url'] : '/quan-ly-tour/public/uploads/images/user/avt-default.png' ?>

                                <img src="<?= $avatar ?>" alt="Avatar" class="user-image">
                                <button id="user-name"><i class="fa-solid fa-caret-down"></i></button>
                            </div>
                            <div class="user-options">
                                <a href="/quan-ly-tour/auth/info">
                                    <i class="fas fa-cog"></i>
                                    Quản lý thông tin
                                </a>
                                <a href="/quan-ly-tour/auth/change_password">
                                    <i class="fa-solid fa-key"></i>
                                    Đổi mật khẩu
                                </a>
                                <a href="/quan-ly-tour/auth/orders">
                                    <i class="fa-solid fa-file-invoice-dollar"></i>
                                    Đơn mua
                                </a>
                                <a href="/quan-ly-tour/auth/logout">
                                    <i class="fas fa-sign-out-alt"></i>
                                    Đăng xuất
                                </a>
                            </div>
                        </div>
                        <?php } else { ?>
                    <li class="nav-item"><a href="/quan-ly-tour/auth/login" class="btn btn-primary">Đăng nhập</a></li>
                    <?php } ?>
                    </li>
                </ul>
            </div>
        </div>
    </nav>