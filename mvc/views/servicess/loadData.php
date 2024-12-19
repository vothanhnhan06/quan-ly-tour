<?php 
    $category = isset($_POST['category']) ? $_POST['category'] : '';
    $data = isset($_POST['datas']) ? $_POST['datas'] : '';
    
    if ($category =='xemay') { ?>
<div id="xemay" class="product-grid">
    <?php foreach($data as $value) {
            if($value['service_category_id'] == 1) { ?>
    <div class="product-card">
        <img src="/quan-ly-tour/<?=$value['image_url']?>" alt="Xe máy" class="product-img">
        <div class="product-info">
            <p style="color: black;"><?=$value['name']?></p>
            <p><?= number_format($value['price'])?> VNĐ</p>
            <div class="product-controls">
                <button class="quantity-btn text">-</button>
                <input type="text" value="0" class="quantity-input">
                <button class="quantity-btn text">+</button>
            </div>
            <button class="add-to-cart-btn">Thêm vào giỏ hàng</button>
        </div>
    </div>
    <?php } 
    } ?>
</div>
<?php }

else if ($category =='camtrai'){?>
<div class="product-grid">
    <?php foreach($data as $value) {?>
    <?php if($value['service_category_id'] == 3) { ?>
    <div class="product-card">
        <img src="/quan-ly-tour/<?=$value['image_url']?>" alt="Lều trại" class="product-img"
            style="width: 210px; height: 212px;">
        <div class="product-info">
            <p style="color: black;"><?=$value['name']?></p>
            <p><?= number_format($value['price'])?> VNĐ</p>
            <div class="product-controls">
                <button class="quantity-btn text">-</button>
                <input type="text" value="0" class="quantity-input">
                <button class="quantity-btn text">+</button>
            </div>
            <button class="add-to-cart-btn">Thêm vào giỏ hàng</button>
        </div>
    </div>
    <?php } }?>
</div>
<?php }
else if ($category =='oto'){?>
<div class="product-grid">
    <?php foreach($data as $value) {?>
    <?php if($value['service_category_id'] == 2) { ?>
    <div class="product-card">
        <img src="/quan-ly-tour/<?=$value['image_url']?>" alt="Ô tô" class="product-img"
            style="width: 210px;height: 212px;">
        <div class="product-info">
            <p style="color: black;"><?=$value['name']?></p>
            <p><?= number_format($value['price'])?> VNĐ</p>
            <div class="product-controls">
                <button class="quantity-btn text">-</button>
                <input type="text" value="0" class="quantity-input">
                <button class="quantity-btn text">+</button>
            </div>
            <button class="add-to-cart-btn">Thêm vào giỏ hàng</button>
        </div>

    </div>
    <?php }?>
    <?php }?>
</div>
<?php }?>