<!-- Data table -->
<form action="" method="POST">
    <table class="data-table">
        <thead>
            <tr>
                <th>Mã tour</th>
                <th>Tên tour</th>
                <th>Thông tin khác h hàng</th>
                <th>Trạng thái</th>
                <th col=3>Hành động</th>
            </tr>
        </thead>
        <tbody>
        <tbody>
            <?php
            if (!empty($ordersData)) {
                $i = 0;
                foreach ($ordersData as $data) : ?>
                    <tr>
                        <td><input type="text" name="order_id[]" value="<?php echo htmlspecialchars($data['id']); ?>" readonly></td>
                        <td><input name="tour[]" type="text" value="<?php echo htmlspecialchars($data['name']); ?>"></td>
                        <td>
                            <input name="fullname[]" type="text" value="<?php echo htmlspecialchars($data['fullname']); ?>">
                            <input name="gender[]" type="text" value="<?php echo htmlspecialchars($data['gender']); ?>">
                            <input name="birthday[]" type="text" value="<?php echo htmlspecialchars($data['birthday']); ?>">
                            <input name="email[]" type="text" value="<?php echo htmlspecialchars($data['email']); ?>">
                            <input name="phone_number[]" type="text" value="<?php echo htmlspecialchars($data['phone_number']); ?>">
                            <input name="address[]" type="text" value="<?php echo htmlspecialchars($data['address']); ?>">
                            <input name="number_of_adults[]" type="text" value="<?php echo htmlspecialchars($data['number_of_people']); ?>">
                        </td>
                        <td>
                            <?php if ($data['status'] == 'pending'): ?>
                                <span>Chờ xác nhận</span>
                            <?php elseif ($data['status'] == 'completed'): ?>
                                <span>Đã hoàn thành</span>
                            <?php else: ?>
                                <span>Đã huỷ</span>
                            <?php endif; ?>
                        </td>
                        <td class="actions">
                            <button type="submit" name="confirm" order-id='<?php echo $data['id']; ?>' value="<?php echo $data['id']; ?>" class="btn-confirm <?php if ($data['status'] == 'completed') {echo 'disabled-button'; }?>">Xác nhận</button>
                            <button type="submit" name="edit" value="<?php echo $data['id']; ?>" class="btn-edit">Chỉnh sửa</button>
                            <button type="submit" name="export" value="<?php echo $data['id']; ?>" class="btn-export">Xuất file</button>
                        </td>
                    </tr>
            <?php endforeach;
            } else {
                echo '<tr><td colspan="5">Không tìm thấy đơn hàng nào.</td></tr>';
            }
            ?>
        </tbody>
    </table>
</form>

<ul class="pagination" style="justify-content:flex-end">
    <?= $button_pagination ?>
</ul>

<script>
    $(document).ready(function() {
        let data;
        let page = 1;
        $('.pagination li a.page-link').click(function() {
            alert("Click");
            page = $(this).attr('num-page')
            data = {
                page: page
            }
            callback('orders/pagination_page', data);
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

    $(document).ready(function() {
        $('.btn-confirm').click(function() {
            const orderId = $(this).attr('order-id');

            $.ajax({
                url: 'orders/confirm',
                method: 'POST',
                data: {
                    id: orderId
                },
                success: function(response) {
                    // $('#loadData').html(response);
                },
                error: function() {
                    alert('Không thể gửi yêu cầu, vui lòng thử lại.');
                }
            });
        });
    });
</script>

