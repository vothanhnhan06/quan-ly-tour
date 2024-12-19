<?php
require_once "./mvc/core/redirect.php";
require "./mvc/views/user/include/header.php";
$redirect = new redirect();
if (isset($_SESSION['errors'])) {
    $errors = $_SESSION['errors'];
}

?>
<style>
        .navbar-link:hover { color: var(--bright-navy-blue); }
        .stars {
            font-size: 2rem;
            cursor: pointer;
        }

        .star {
            color: gray;
            transition: color 0.3s ease;
            color: rgb(252, 252, 111)
        }
        
    </style>
<main>
    <article>
        <div id="account-information" class="account-container">
            <!-- Sidebar -->
            <div class="info-sidebar">
                <div class="header-info">
                    <img src="<?php echo isset($data['user']['avatar_url']) ? '/quan-ly-tour/' . $data['user']['avatar_url'] : '/quan-ly-tour/public/uploads/images/user/avt-default.png' ?>" alt="User Avatar" class="avatar-large">
                    <h3>Tên tài khoản</h3>
                </div>
                <ul class="menu">
                    <li><a href="info">Quản lý thông tin</a></li>
                    <li><a href="change_password">Đổi mật khẩu</a></li>
                    <li><a href="orders">Đơn mua</a></li>
                    <li><a href="voucher">Khuyến mãi</a></li>
                    <li><a href="love">Yêu thích</a></li>
                </ul>
            </div>

            <div class="info-content">
                <?php require_once './mvc/views/user/info/' . $page . '.php'; ?>
            </div>
    </article>
</main>

<script src="/quan-ly-tour/public/assets/js/info.js"></script>
<script>
    

   
 
    
    //Hiển thị đánh giá
    document.querySelectorAll('[href="#reviewtour"]').forEach(function(element) {
        element.addEventListener("click", function() {
            document.getElementById("review-modal").style.display = "block";
        });
    });
    document.getElementById("close-btn-review").addEventListener("click", function() {
        document.getElementById("review-modal").style.display = "none";
    });
    document.querySelectorAll('.cancel-btn').forEach(function(element) {
        element.addEventListener("click", function() {
            document.getElementById("review-modal").style.display = "none";
            document.getElementById("popup-cancel").style.display = "none";
        });
    });
    //Cảm ơn đánh giá
    document.getElementById('.submit-btn').forEach(function(element) {
        element.addEventListener("click", function() {
            document.getElementById("review-modal").style.display = "none";
            document.getElementById("popup-thankyou").style.display = "block";
            
        });
    });
    document.getElementById("confirm-btn-thankyou").addEventListener("click", function() {
        document.getElementById("canceltour").style.display = "none";
        document.getElementById("popup-thankyou").style.display = "none";
    });
    document.getElementById("close-btn-thankyou").addEventListener("click", function() {
        document.getElementById("popup-thankyou").style.display = "none";
    });
    document.getElementById("cancel-button").addEventListener("click", function() {
        document.getElementById("popup-cancel").style.display = "block";
    });
    document.getElementById("confirm").addEventListener("click", function() {
        document.getElementById("popup-cancel").style.display = "none";
        document.getElementById("canceltour").style.display = "block";
    });
</script>
<!-- Hiệu ứng đánh giá sao -->
<script>
    const stars = document.querySelectorAll('.star');
    const reviewModal = document.querySelector('.review-modal');

    let currentRating = 0;
    stars.forEach((star, index) => {
        star.addEventListener('mouseover', () => {
            highlightStars(index + 1);
        });
        star.addEventListener('mouseout', () => {
            highlightStars(currentRating);
        });

        star.addEventListener('click', () => {
            currentRating = index + 1;
            highlightStars(currentRating);
        });
    });


    function highlightStars(rating) {
        stars.forEach((star, index) => {
            if (index < rating) {
                star.style.color = 'rgb(252, 215, 30)';
            } else {
                star.style.color = 'gray';
            }
        });
    }
</script>
</body>

</html>

<?php unset($_SESSION['errors']);
require "./mvc/views/user/include/footer.php";
?>