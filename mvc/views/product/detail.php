<?php 
require_once ('./mvc/views/user/include/header.php')
?>
<main>
    <article>
        <!-- Trang Tour Miền ...-->
        <div id="chitiet-tour">
            <div class="chitiet-tour">
                <h4>
                    <label class="mienbac-chitiet">
                        <a
                            href="/quan-ly-tour/destination/index/<?=$category[0]['cate_id']?>"><?=$category[0]['name']?></a>
                        >
                        <a href=""><strong><?= $details['name']?></strong></a>
                    </label>
                </h4>
                <h3>Thông tin chi tiết về chuyến đi</h3>

                <div class="chitiet-general">
                    <div>
                        <div class="slideshow-container">

                            <div class="Slide fade">
                                <div class="numbertext">1 / 3</div>
                                <img src="./public/upload/images/tours/sliderB1.jpg" style="width:100%; height: 400px;">
                                <div class="text-slide">Chùa Phật Tích Trúc Lâm</div>
                            </div>

                            <div class="Slide fade s1">
                                <div class="numbertext">2 / 3</div>
                                <img src="./public/upload/images/tours/sliderB2.jpg" style="width:100%; height: 400px;">
                                <div class="text-slide">Thác Bản Giốc</div>
                            </div>

                            <div class="Slide fade s2">
                                <div class="numbertext">3 / 3</div>
                                <img src="./public/upload/images/tours/lang-da-khuoi-ky.jpg"
                                    style="width:100%; height: 400px;">
                                <div class="text-slide">Làng đá cổ Khuổi Kỵ</div>
                            </div>
                            <a class="prev-slide" onclick="plusSlides(-1)">❮</a>
                            <a class="next-slide" onclick="plusSlides(1)">❯</a>
                        </div>
                        <br>
                        <div style="text-align:center">
                            <span class="dot" onclick="currentSlide(1)"></span>
                            <span class="dot" onclick="currentSlide(2)"></span>
                            <span class="dot" onclick="currentSlide(3)"></span>
                        </div>
                        <ul class="chuyendi-chitiet">
                            <?php
                                // Chuỗi ban đầu
                                $infoString = $details['description'];
                                
                                // Loại bỏ các từ khóa không cần thiết
                                $keywords = ["Ẩm thực: ", "Đối tượng thích hợp: ", "Thời gian lý tưởng: ", "Khuyến mãi: "];
                                foreach ($keywords as $keyword) {
                                    $infoString = str_replace($keyword, '', $infoString);
                                }
                                
                                // Tách chuỗi thành mảng bằng dấu phân cách ";"
                                $infoArray = explode(';', $infoString);
                                
                                // Lấy các chuỗi riêng lẻ từ mảng và loại bỏ khoảng trắng thừa
                                $amThuc = trim($infoArray[0]);  // "Đặc sản biển, Bánh canh"
                                $doiTuongThichHop = trim($infoArray[1]);  // "Gia đình, Cặp đôi, Bạn bè"
                                $thoiGianLyTuong = trim($infoArray[2]);  // "Mùa hè"
                                $khuyenMai = trim($infoArray[3]);  // "Giảm 15% cho nhóm từ 4 người trở lên"
                             ?>
                            <div class="column1">
                                <li><strong>Ẩm thực</strong><?=$amThuc?></li>
                                <li><strong>Đối tượng thích hợp</strong><?=$doiTuongThichHop?>
                                </li>
                            </div>
                            <div class="column2">
                                <li><strong>Thời gian lý tưởng</strong><?=$thoiGianLyTuong?></li>
                                <li><strong>Khuyến mãi</strong><?=$khuyenMai?></li>
                            </div>
                        </ul>
                        <h3>Lịch trình</h3>
                        <?php
                        // Chuỗi mô tả lịch trình ban đầu
                        $itinerary =$details['itinerary'];

                        // Sử dụng preg_split để tách chuỗi thành các phần dựa trên cụm từ "Ngày" và giữ lại các cụm từ "Ngày"
                        $itineraryParts = preg_split("/(Ngày \d+:)/", $itinerary, -1, PREG_SPLIT_DELIM_CAPTURE | PREG_SPLIT_NO_EMPTY);

                        // Tạo mảng để lưu trữ các ngày riêng biệt và tiêu đề
                        $days = [];
                        for ($i = 0; $i < count($itineraryParts); $i += 2) {
                            $dayTitle = trim($itineraryParts[$i]);
                            $dayContent = trim($itineraryParts[$i + 1]);

                            // Tách tiêu đề và nội dung
                            preg_match("/(.*?):(.*)/", $dayContent, $matches);
                            if (count($matches) > 2) {
                                $daySubtitle = trim($matches[1]);
                                $dayDetails = trim($matches[2]);
                                $days[] = [
                                    'title' => $dayTitle,
                                    'subtitle' => $daySubtitle,
                                    'details' => $dayDetails
                                ];
                            }
                        }
                        // Hiển thị kết quả
                        foreach ($days as $day) {
                        ?>

                        <div class="schedule">
                            <div class="day">
                                <div class="day-header">
                                    <div>
                                        <strong><?=htmlspecialchars($day['title'])?></strong><strong><?=htmlspecialchars($day['subtitle'])?></strong>
                                    </div>
                                    <div><span class="dropdown-icon">▼</span></div>
                                </div>
                                <div class="day-content">
                                    <p>
                                        <?=htmlspecialchars($day['details'])?>
                                    </p>
                                </div>
                            </div>
                        </div>
                        <?php }?>
                        <h3>Đánh giá của khách hàng</h3>
                        <div class="review-section">
                            <!-- Đánh giá 1 -->
                            <?php 
                            foreach ($reviews as $value){
                            ?>
                            <div class="review">
                                <div class="review-header">
                                    <div class="user-avatar"></div>
                                    <div class="user-info">
                                        <p class="username">anguyengiaba236</p>
                                        <?php
                                        // Hàm để hiển thị số lượng ngôi sao
                                        function displayStars($rating) {
                                            $stars = '';
                                            for ($i = 0; $i < $rating; $i++) {
                                                $stars .= '⭐';
                                            }
                                            return $stars;
                                        }
                                        ?>
                                        <div class="stars"><?=displayStars($value['rating']) ?></div>
                                    </div>
                                </div>
                                <div class="review-content">
                                    <p class="review-date" style="display: flex;">28/05/2024 09:29 | <span> Phân
                                            loại: Miền Bắc</span></p>
                                    <!--CHƯA XỬ LÝ-->
                                    <p class="review-service" style="display: flex;"><span>Dịch vụ:</span> Tốt</p>
                                    <p class="review-care" style="display: flex;"><span>Chăm sóc khách hàng:</span>
                                        Chu đáo và nhiệt tình</p>
                                    <p class="review-message"><?=$value['note']?></p>
                                </div>
                            </div>
                            <?php }?>
                        </div>

                    </div>
                    <div class="right-section right-detail-tour">
                        <h3 style="text-align: left;margin-top: 20px;margin-left: 20px;margin-right: 10px;">
                            <?= $details['name']?></h3>
                        <div>
                            <li><i style="color: var(--bright-navy-blue);" class="fa-solid fa-location-dot"></i>Khởi
                                hành: <?=$details['pick_up']?></li>
                            <?php
                            // Giả sử $details['date_start'] chứa ngày tháng ban đầu
                            $dateString = $details['date_start'];
                            $date = new DateTime($dateString);
                            $formattedDate = $date->format('d-m-Y');  // Định dạng ngày thành 'd-m-Y'
                            ?>
                            <li>
                                <i style="color: var(--bright-navy-blue);" class="fa-solid fa-calendar-days"></i>Ngày
                                khởi hành:
                                <?= $formattedDate ?>
                            </li>
                            <li><i style="color: var(--bright-navy-blue);" class="fa-solid fa-clock"></i>Thời gian:
                                <?=$details['duration']?></li>
                            <li class="price-from">Giá từ: <?=number_format($details['price'])?> VND / người</li>
                        </div>
                        <?php
                        if (isset($_SESSION['user'])){?>
                        <a href="/quan-ly-tour/product/buy/<?=$details['slug']?>" class="chi-tiet-btn xemngay"
                            style="margin-top: 45px;">ĐẶT NGAY</a>
                        <?php }
                        else{ ?>
                        <a href="/quan-ly-tour/auth/login" class="chi-tiet-btn xemngay" style="margin-top: 45px;">
                            ĐẶT NGAY</a>
                        <?php }?>

                    </div>
                </div>
            </div>
        </div>
    </article>
</main>