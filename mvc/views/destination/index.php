<?php 
require_once ('./mvc/views/user/include/header.php')
?>
<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>

<main>
    <article>
        <!-- Trang Tour Miền Trung-->
        <section id="mienTrungModal">
            <section class="page-Central" id="home">
                <section class="content">

                    <h1><?=$tour[0]['cate_name']?></h1>
                    <p><?=$tour[0]['des']?></p>
                </section>
            </section>

            <div class="dstour">

                <div class="filter">
                    <h2>Bộ lọc tìm kiếm</h2>
                    <hr style="width: 100%; border-top: 1px solid white; margin-bottom: 10px;">
                    <form>
                        <label for="budget">Ngân sách</label>
                        <div class="budget-options">
                            <button type="button" class="budget-btn" data-value="under5">Dưới 5 triệu</button>
                            <button type="button" class="budget-btn" data-value="5to10">Từ 5 - 10 triệu</button>
                            <button type="button" class="budget-btn" data-value="10to20">Từ 10 - 20 triệu</button>
                            <button type="button" class="budget-btn" data-value="over20">Trên 20 triệu</button>
                        </div>

                        <label for="departure">Điểm khởi hành</label>
                        <input type="text" id="departure" placeholder="Nhập điểm khởi hành">

                        <label for="destination">Điểm đến</label>
                        <input type="text" id="destination" placeholder="Nhập điểm đến">

                        <div class="date-group">
                            <label for="date">Ngày đi</label>
                            <input type="date" id="date">
                        </div>

                        <button type="submit" class="filter-btn">Lọc</button>
                    </form>
                </div>

                <!-- Kết quả tìm kiếm -->
                <div class="search-results page_MT">
                    <div class="page-header">
                        <label for="">Chúng tôi tìm thấy</label><input type="text" id="number-tour"
                            style="width: 40px; text-align: center; "><label for="">cho quý khách</label>
                        <div><label for="" style="margin-right: 10px; margin-left: 100px; ">Sắp xếp theo:</label>
                            <select id="combobox-sapxep">
                                <option value="option1">Tất cả</option>
                                <option value="option2">Giá từ cao đến thấp</option>
                                <option value="option3">Giá từ thấp đến cao</option>
                            </select>
                        </div>
                    </div>
                    <hr style="margin-top: 10px; margin-bottom: 20px;">
                    <section id="loadData">
                        <?php if(isset($data['tour']) && ($data['tour'])!=NULL){ ?>
                        <?php foreach(($data['tour']) as $value){?>
                        <div class="result-item">
                            <img src="/quan-ly-tour/<?=$value['thumbnail']?>" alt="Cao Bằng" class="result-image">
                            <div class="result-details">
                                <h3><?=$value['tour_name']?></h3>
                                <div><i class="fa-solid fa-location-dot"></i>
                                    <p>Khởi hành: <?=$value['pick_up']?></p>
                                </div>
                                <?php
                                // Giả sử $details['date_start'] chứa ngày tháng ban đầu
                                $dateString = $value['date_start'];
                                $date = new DateTime($dateString);
                                $formattedDate = $date->format('d-m-Y');  // Định dạng ngày thành 'd-m-Y'
                                ?>
                                <div><i class="fa-solid fa-calendar-days"></i>
                                    <p>Ngày khởi hành: <?= $formattedDate ?></p>
                                </div>
                                <div><i class="fa-solid fa-clock"></i>
                                    <p>Thời gian: <?=$value['duration']?></p>
                                </div>
                                <div class="price-and-button">
                                    <p class="price">Giá từ: <?=number_format($value['price'])?>VNĐ</p>
                                    <a href="/quan-ly-tour/product/detail/<?=$value['slug']?>" class="detail-btn">Xem
                                        chi tiết</a>
                                </div>
                            </div>
                        </div>

                        <?php }?>
                        <?php }?>
                    </section>
                    <ul class="pagination" style="display: flex">
                        <?=$data['button_pagination'];?>
                    </ul>
                    <script>
                    $(document).ready(function() {
                        let data;
                        let page = 1;
                        $('.pagination li a.page-link').click(function() {
                            page = $(this).attr('num-page')
                            data = {
                                page: page
                            }
                            callback('destination/index/<?=$tour[0]['category_id']?>', data);
                        })

                        function callback(url, data) {
                            $.ajax({
                                url: url,
                                method: "POST",
                                data: data,
                                success: function(response) {
                                    $('#loadData').html(response);
                                },
                            })
                        }
                    });
                    </script>
                </div>
            </div>
        </section>