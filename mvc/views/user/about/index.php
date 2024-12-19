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
    <link rel="stylesheet" href="/quan-ly-tour/public/assets/css/user/footer.css">
    <link rel="stylesheet" href="/quan-ly-tour/public/assets/css/user/about.css">
    <!-- google font  -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;500;600&display=swap" rel="stylesheet">
</head>

<body id="top">
    <!-- header section  -->
    <nav id="header" class="navbar navbar-expand-lg navbar-light bg-light header">
        <a href="/quan-ly-tour/">
            <img src="/quan-ly-tour/public/uploads/images/logo-white.png" alt="Logo" class="logo"
                style="width: 160px; margin-left: 60px; height: auto; margin-top: -20px;">
            <img src="/quan-ly-tour/public/uploads/images/logo-blue.png" alt="Logo" class="logo2"
                style="width: 160px; height: auto; margin-left: 60px; margin-top: -20px; display: none;">
        </a>

        <div class="container">
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav"
                aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse navbar-header" id="navbarNav">
                <ul class="navbar-nav ms-auto navbar-list">
                    <li class="nav-item"><a href="/quan-ly-tour" class="navbar-link change-color">Trang chủ</a></li>
                    <li class="nav-item"><a href="./" class="navbar-link change-color active-header">Giới thiệu</a></li>
                    <li class="nav-item dropdown">
                        <div class="dropdown-des">
                            <a href="#destination" class="navbar-link change-color desdrop dropdown-toggle"
                                id="navbarDropdown" data-bs-toggle="dropdown" aria-expanded="false">Điểm đến</a>
                            <ul class="dropdown-menu dropdown-content" aria-labelledby="navbarDropdown">
                                <li><a class="dropdown-item" href="/quan-ly-tour/destination/index/2">Miền Bắc</a></li>
                                <li><a class="dropdown-item" href="/quan-ly-tour/destination/index/3">Miền Trung</a>
                                </li>
                                <li><a class="dropdown-item" href="/quan-ly-tour/destination/index/1">Miền Nam</a></li>
                            </ul>
                        </div>
                    </li>
                    <li class="nav-item"><a href="tour.html" class="navbar-link change-color">Tour</a></li>
                    <li class="nav-item"><a href="lienHe.html" class="navbar-link change-color">Liên hệ</a></li>
                    <?php if (isset($_SESSION['user'])) { ?>
                    <li class="nav-item">
                        <div id="user-profile" class="user-profile">
                            <div class="user-account"><img src="
                                <?php echo isset($data['user']['avatar_url']) ? '/quan-ly-tour/' . $data['user']['avatar_url'] : '/quan-ly-tour/public/uploads/images/user/avt-default.png' ?>
                                " alt="Avatar" class="user-image">
                                <button id="user-name"><i class="fa-solid fa-caret-down"></i></button>
                            </div>
                            <div class="user-options">
                                <a href="../auth/info">
                                    <i class="fas fa-cog"></i>
                                    Quản lý thông tin
                                </a>
                                <a href="../auth/change_password">
                                    <i class="fa-solid fa-key"></i>
                                    Đổi mật khẩu
                                </a>
                                <a href="../auth/orders">
                                    <i class="fa-solid fa-file-invoice-dollar"></i>
                                    Đơn mua
                                </a>
                                <a href="../auth/logout">
                                    <i class="fas fa-sign-out-alt"></i>
                                    Đăng xuất
                                </a>
                            </div>
                        </div>
                    </li>
                    <?php } else { ?>
                    <li class="nav-item"><a href="/quan-ly-tour/auth/login" class="btn btn-primary">Đăng nhập</a></li>
                    <?php } ?>
                </ul>
            </div>
        </div>
    </nav>

    <main>
        <article>
            <!-- hero  -->
            <section id="about">
                <section class="hero" id="home">
                    <div class="container">

                        <h2 class="h1 hero-title">
                            Giới thiệu
                        </h2>

                    </div>
                </section>


                <div class="about-container">
                    <div class="section">
                        <div class="text-container">
                            <h2>Về chúng tôi</h2>
                            <p>Chào mừng bạn đến với VietCharm, nơi mang đến cho bạn những trải nghiệm du lịch đáng nhớ
                                và phong phú nhất! Với đam mê và nhiều năm kinh nghiệm trong lĩnh vực du lịch, chúng tôi
                                tự hào là đối tác đáng tin cậy của hàng ngàn du khách trên khắp thế giới.</p>
                        </div>
                        <div class="image-container">
                            <img src="/quan-ly-tour/public/uploads/images/office.jpg" alt="Về chúng tôi">
                        </div>
                    </div>

                    <div class="section">
                        <div class="image-container">
                            <img src="/quan-ly-tour/public/uploads/images/mission.jpg" alt="Sứ mệnh">
                        </div>
                        <div class="text-container">
                            <h2>Sứ mệnh của chúng tôi</h2>
                            <p>Chúng tôi không chỉ cung cấp các tour du lịch, mà còn mong muốn mang đến những hành trình
                                khám phá, kết nối văn hóa và trải nghiệm chân thực tại mỗi điểm đến. Sứ mệnh của chúng
                                tôi là tạo nên những chuyến đi ý nghĩa, giúp du khách thư giãn, học hỏi và lưu giữ những
                                kỷ niệm khó quên.</p>
                        </div>
                    </div>

                    <div class="section">
                        <div class="text-container">
                            <h2>Dịch vụ của chúng tôi</h2>
                            <p>Từ các tour khám phá thiên nhiên hoang dã, đến các hành trình văn hóa đậm chất địa
                                phương, chúng tôi cung cấp đa dạng các loại hình tour du lịch phù hợp với mọi nhu cầu.
                                Bạn có thể chọn các gói du lịch trọn gói, tour cá nhân hoá, hoặc những chuyến phiêu lưu
                                mạo hiểm dành riêng cho người yêu thích khám phá.</p>
                        </div>
                        <div class="image-container">
                            <img src="/quan-ly-tour/public/uploads/images/service.jpg" alt="Dịch vụ">
                        </div>
                    </div>

                    <div class="section">
                        <div class="image-container">
                            <img src="/quan-ly-tour/public/uploads/images/commitment.jpg" alt="Cam kết chất lượng">
                        </div>
                        <div class="text-container">
                            <h2>Cam kết chất lượng</h2>
                            <p>Chúng tôi cam kết mang đến dịch vụ du lịch an toàn, tiện lợi và chất lượng cao với mức
                                giá hợp lý nhất. Đội ngũ hướng dẫn viên giàu kinh nghiệm và am hiểu sẽ đồng hành cùng
                                bạn trong suốt chuyến đi, mang lại những khoảnh khắc đáng nhớ nhất.</p>
                        </div>
                    </div>
                </div>
            </section>