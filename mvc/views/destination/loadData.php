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
                <a href="/quan-ly-tour/product/detail/<?=$value['slug']?>" class="detail-btn">Xem chi tiết</a>
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