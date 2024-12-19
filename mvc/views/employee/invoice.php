<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><?=$title?></title>
    <link rel="stylesheet" href="/quan-ly-tour/public/assets/css/employee/invoice.css">
</head>

<body>
    <?php 
    foreach ($invoiceData as $invoice): ?>
        <div class="invoice-container">
        <header>
            <h1>HÓA ĐƠN ĐẶT TOUR DU LỊCH</h1>
            <p>Ngày lập hóa đơn: <?= $invoice['order_date']?></p>
        </header>
        
        <section class="customer-info">
            <h2>Thông Tin Khách Hàng</h2>
            <p><strong>Tên khách hàng:</strong> <?=$invoice['fullname']?></p>
            <p><strong>Số điện thoại:</strong> <?=$invoice['phone_number']?></p>
            <p><strong>Email:</strong> <?=$invoice['email']?></p>
            <p><strong>Địa chỉ:</strong> <?=$invoice['address']?></p>
        </section>

        <section class="tour-info">
            <h2>Thông Tin Tour</h2>
            <p><strong>Tên Tour:</strong> <?=$invoice['tourName']?></p>
            <p><strong>Ngày khởi hành:</strong> <?=$invoice['tourDateStart']?></p>
            <p><strong>Số ngày:</strong> <?=$invoice['tourDuration']?></p>
            <p><strong>Số người:</strong> <?=$invoice['number_of_people']?> người</p>
            <p><strong>Giá tour:</strong> <?=$invoice['tour_price']?>/người</p>
            <p><strong>Thành tiền:</strong> <?=$invoice['total_money_tour']?></p>
        </section>

        <section class="services-info">
            <h2>Dịch Vụ Thuê Thêm</h2>
            <table>
                <thead>
                    <tr>
                        <th>Dịch Vụ</th>
                        <th>Đơn Giá (VNĐ)</th>
                        <th>Số Lượng</th>
                        <th>Thành Tiền (VNĐ)</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td><?=$invoice['serviceName']?></td>
                        <td><?=$invoice['service_price']?></td>
                        <td><?=$invoice['number_of_services']?></td>
                        <td><?=$invoice['total_money_service']?></td>
                    </tr>   
                </tbody>
            </table>
        </section>

        <footer>
            <p class="total">Tổng cộng:<strong> <?=$invoice['total_money']?></strong></p>
            <p>Cảm ơn quý khách đã sử dụng dịch vụ của chúng tôi!</p>
        </footer>
    </div>
    
    <?php endforeach;?>
</body>
</html>
