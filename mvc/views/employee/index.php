<?php
require_once "./mvc/core/redirect.php";

$redirect = new redirect();
if (isset($_SESSION['errors'])) {
    $errors = $_SESSION['errors'];
}
?>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><?=$title?></title>
    <link rel="stylesheet" href="/quan-ly-tour/public/assets/css/employee/orders.css">
    <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>

</head>

<body>
    <div class="employee-container">
        <!-- <nav class="sidebar">
            <ul>
                <li><a href="./orders" class="sidebar-link">Đơn đặt tour</a></li>
                <li><a href="./customer" class="sidebar-link">Khách hàng</a></li>
            </ul>
        </nav> -->

        <div class="content">
            <div class="search-form">
                <form method="GET" action="">
                    <input type="text" class="search-input" name="search" placeholder="Tìm kiếm thông tin"
                        value="<?php echo htmlspecialchars($searchTerm); ?>">
                    <button type="submit" class="search-button">Tìm kiếm</button>
                </form>
            </div>
            <div id="loadData">
                <?php
                require_once './mvc/views/employee/' . $page . '.php';
                ?>
            </div>
        </div>
    </div>
</body>

</html>