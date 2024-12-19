<?php
require_once "./mvc/controllers/MyController.php";
require_once "./mvc/core/redirect.php";

class OrdersController extends Controller
{
    public $ordersData;
    var $template = 'employee/orders';
    const limit = 6;
    const type = 1;
    function __construct()
    {
        $this->MyController = new MyController();
        $this->OrderModels = $this->models('OrderModels');
        $this->Jwtoken = $this->helper('Jwtoken');
        $this->Authorzation = $this->helper('Authorzation');
        $this->Functions =  $this->helper('Functions');
        $this->SendMail            =  $this->helper('SendMail');

    }

    public function index()
    {
        $ordersData = [];
        $searchTerm = "";
        
        $rows = $this->OrderModels->select_array('*');
        $limit = self::limit;
        $page = 1;
        $total_rows = count($rows);
        $total_page = ceil($total_rows / $limit);
        $start = ($page - 1) * $limit;
        if ($total_rows > 0) {
            $ordersData = $this->OrderModels->select_array_join_table('orders.*, tours.name as name',NULL,'order_date desc',
            $start,$limit,
            'tours','orders.tour_id = tours.id', 'LEFT'
        );
    }
        $button_pagination = $this->Functions->pagination($total_page,$page);   

        if (isset($_GET['search']) && !empty(trim($_GET['search']))) {
            $searchTerm = trim($_GET['search']);
            $ordersData = $this->OrderModels->search_array_join_table('*, tours.name as name', ['id','tours.name', 'status', 'fullname', 'email', 'phone_number'], $searchTerm, NULL, 'order_date desc',
            $start,$limit,
            'tours','orders.tour_id = tours.id', 'LEFT'
        );
        } else {
            $ordersData = $this->OrderModels->select_array_join_table('orders.*, tours.name as name',NULL,'order_date desc',
            $start,$limit,
            'tours','orders.tour_id = tours.id', 'LEFT'
        );   
    }       
        $data = [
            'page' => 'orders',
            'title' => 'Danh sách đơn hàng', 
            'ordersData' => $ordersData,
            'button_pagination' => $button_pagination,
            'searchTerm' => $searchTerm
        ];
        $this->view('employee/index', $data);
    }

    function updateOrder() {
        if ($_SERVER['REQUEST_METHOD'] == 'POST') {
            $errors = [];
            // $order_id = $_POST['edit'];
            
            $dataUpdate = [
                'fullname' => trim($_POST['fullname']),
                'phone_number' => trim($_POST['phone_number']),
                'email' => trim($_POST['email']),
                'gender' => trim($_POST['gender']),
                'address' => trim($_POST['address']),
                'number_of_people' => trim($_POST['number_of_people']),
            ];
            
            if (empty($dataUpdate['fullname']) || empty($dataUpdate['phone_number']) || empty($dataUpdate['email']
            || empty($dataUpdate['gender']) || empty($dataUpdate['address'])
            || empty($dataUpdate['number_of_people']))) {
                $errors[] = "Vui lòng nhập đầy đủ thông tin.";
            }

            if (empty($errors)) {
                $result = $this->OrderModels->update($dataUpdate, ['id' => $order_id]);
                $decodeResults = json_decode($result, true);

                if ($decodeResults['type'] === 'Successfully') {
                    $redirect =  new redirect('employee/orders');
                    $redirect->setFlash('success', 'Cập nhật thông tin thành công!');
                } else {
                    $redirect = new redirect('employee/orders');
                    $redirect->setFlash('error', 'Có lỗi xảy ra khi cập nhật thông tin.');
                }
            } else {
                // Lưu lỗi vào session để hiển thị lại
                $_SESSION['errors'] = $errors;
                $redirect = new redirect('employee/orders');
                $redirect->setFlash('error', implode(', ', $errors));
            }
        } 

        $data = [
            'page' => 'orders',
            'title' => 'Danh sách đơn hàng', 
        ];
        $this->view('employee/index', $data); 
    }
    function pagination_page(){
        $rows = $this->OrderModels->select_array('*');
        $limit = self::limit;
        $page = $_POST['page']?$_POST['page']:1;
        $total_rows = count($rows);
        $total_page = ceil($total_rows / $limit);
        $start = ($page - 1) * $limit;
        if ($total_rows > 0) {
            $ordersData = $this->OrderModels->select_array_join_table('orders.*, tours.name as name',NULL,'order_date desc',
            $start,$limit,
            'tours','orders.tour_id = tours.id', 'LEFT'
           );
        }
        $button_pagination = $this->Functions->pagination($total_page,$page); 
        $data = [
            'page' => 'customer',
            'title' => 'Danh sách đơn hàng',
            'ordersData' => $ordersData,
            'button_pagination' => $button_pagination,
        ];
        $this->view('employee/orders', $data);
    }

    function confirm() {
        if ($_SERVER['REQUEST_METHOD'] === 'POST') {
            $id = $_POST['id'] ?? null;
            if ($id) {
                $data = $this->OrderModels->select_row('*', ['id' => trim($id)]);
                $updated = $this->OrderModels->update(['status' => 'completed'], ['id' => $id]);
                $decodeResults = json_decode($updated, true);
    
                if ($decodeResults['type'] === 'Sucessfully') {
                    $link = base_url .'employee/orders/invoice?invoice_id=' . $id;

                    $subject = 'Xác nhận đơn hàng';
                    $content = 'Kính gửi quý khách hàng,'.'<br>';
                    $content = 'VietCharm xin trân trọng cảm ơn Quý khách hàng đã tin dùng dịch vụ của chúng tôi.'.'<br>';
                    $content = 'VietCharm xin gửi hoá đơn đến quý khách với thông tin chi tiết như sau:'.'<br>';
                    $content .= 'Số hoá đơn :'. $id .'<br>';   
                    $content .= 'Tổng tiền: '. $data['total_money'] .'<br>';   
                    $content .= 'Quý khách vui lòng truy cập link bên dưới để xem và kiểm tra hoá đơn gốc:' .'<br>'; 
                    $content .= $link .'<br>'; 
                    $content .= 'Chúc quý khách có một chuyến đi đáng nhớ!' .'<br>'; 
                    $content .= 'Trân trọng cảm ơn!';

                    $sendEmail = $this->SendMail->send($subject, $data['email'], $content);
                    if($sendEmail) {
                        echo json_encode(['success' => true]);
                    } 
                } else {
                    echo json_encode(['success' => false]);
                }
            } else {
                echo json_encode(['success' => false, 'message' => 'ID không hợp lệ']);
            }
        }
    }
    
    function invoice() {
        $invoice_id = $_GET['invoice_id']?? null;
        if ($invoice_id) {
            $invoiceData = $this->OrderModels->select_array_join_multi_table('orders.*, order_details.*, tours.name as tourName, tours.date_start as tourDateStart, tours.duration as tourDuration, services.name as serviceName', ['orders.id' => trim($invoice_id)], 'order_details.id desc',
        NULL, NULL, 
        [
            ['order_details','orders.id = order_details.order_id','LEFT'],
            ['tours','tours.id = order_details.tour_id','LEFT'],
            ['services','services.id = order_details.service_id','LEFT']
         ]);
        } else {
            $redirect = new redirect('employee/orders');
            $redirect->setFlash('error', 'Mã đơn đặt tour không hợp lệ');
        }
            $data = [
                'title' => 'Hoá đơn đặt tour',
                'invoiceData' => $invoiceData,
            ];
            $this->view('employee/invoice', $data);
    
    }

    function exportPDF() {
        
    }
}
