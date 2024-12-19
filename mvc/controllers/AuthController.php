    <?php
    require_once "./mvc/controllers/MyController.php";
    require_once "./mvc/core/redirect.php";

    class AuthController extends Controller
    {
        public $template = 'AuthController';
        var $path_dir = 'public/uploads/images/user/';

        function __construct()
        {
            $this->UserModels = $this->models('UserModels');
            $this->MyController = new MyController();
            $this->TokenLoginModels = $this->models('TokenLoginModels');
            $this->Jwtoken = $this->helper('Jwtoken');
            $this->Authorzation = $this->helper('Authorzation');
            $this->uploads =  $this->helper('uploads');
            $this->SendMail =  $this->helper('SendMail');
        }
        function index()
        {
         'auth';
        }
        function register()
        {
            $errors = [];
            if ($_SERVER['REQUEST_METHOD'] == 'POST') {

                if (strlen($_POST['fullname']) < 5) {
                    $errors['fullname'] = 'Họ tên phải có ít nhất 5 ký tự';
                }
                if (strlen($_POST['password']) < 6) {
                    $errors['password'] = 'Mật khẩu phải có ít nhất 6 ký tự';
                }
                if (($_POST['retype-password']) !== ($_POST['password'])) {
                    $errors['retype-password'] = 'Mật khẩu xác nhận không trùng khớp';
                }

                $counts = $this->UserModels->select_array('*', ['email' => trim($_POST['email'])]);
                if (count($counts) > 0) {
                    $errors['email'] = 'Email đã tồn tại';
                }

                if (empty($errors)) {
                    $activeToken = sha1(uniqid() . time());
                    $dataInsert = [
                        'fullname' => filter_input(INPUT_POST, 'fullname', FILTER_SANITIZE_FULL_SPECIAL_CHARS),
                        'phone_number' => filter_input(INPUT_POST, 'phone_number', FILTER_SANITIZE_FULL_SPECIAL_CHARS),
                        'email' => filter_input(INPUT_POST, 'email', FILTER_SANITIZE_EMAIL),
                        'password' => password_hash(filter_input(INPUT_POST, 'password', FILTER_SANITIZE_FULL_SPECIAL_CHARS), PASSWORD_BCRYPT),
                        'activeToken' => $activeToken,
                        'created_at' => gmdate('Y-m-d H:i:s', time() + 7 * 3600),
                        'role_id' => 1,
                        'username' => filter_input(INPUT_POST, 'fullname', FILTER_SANITIZE_FULL_SPECIAL_CHARS),
                    ];

                    $result = $this->UserModels->add($dataInsert);
                    $return = json_decode($result, true);
                    if ($return) {
                        // Tạo link kích hoạt
                        $linkActive = base_url . 'auth/active?token=' . $activeToken;

                        // Thiết lập gửi mail
                        $subject = $dataInsert['fullname'] . ' vui lòng kích hoạt tài khoản!';
                        $content = 'Chào ' . $dataInsert['fullname'] . '!<br>';
                        $content .= 'Vui lòng click vào link bên dưới để kích hoạt tài khoản: <br>';
                        $content .= $linkActive . '<br>';
                        $content .= 'Trân trọng cảm ơn!';

                        // Tiến hành gửi mail
                        $sendMail = $this->SendMail->send($subject, $dataInsert['email'], $content);
                        if ($sendMail) { 
                            $redirect = new redirect('auth/register');
                            $redirect->setFlash('sucess', 'Đăng ký thành công, vui lòng kiểm tra email để kích hoạt tài khoản!');
                        } else {
                            $redirect = new redirect('auth/register');
                            $redirect->setFlash('error', 'Hệ thống gặp sự cố, vui lòng thử lại sau!');
                        }
                    }
                } else {
                    $_SESSION['errors'] = $errors;
                    $_SESSION['data'] = $_POST;
                    $redirect = new redirect('auth/register');
                    $redirect->setFlash('error', 'Đăng ký không thành công!');
                }
            } 
            $this->view('user/register/index', [
                'title'         => 'Đăng ký'
            ]);
        }

        function active() {
            $activeToken = $_GET['token'];
            if(!empty($activeToken)) {
                $tokenQuery = $this->UserModels->select_row('*', ['activeToken' => trim($activeToken)]);
                if(!empty($tokenQuery)) {
                    $userId = $tokenQuery['id'];
                    $dataUpdate = [
                        'status' => 1,
                        'activeToken' => null
                    ];
        
                    $result = $this->UserModels->update($dataUpdate, ['id' => $userId]);
                    $decodeResults = json_decode($result, true);
        
                    if($decodeResults['type'] === 'Sucessfully') {
                        $redirect = new redirect('auth/login');
                        $redirect->setFlash('sucess', 'Kích hoạt tài khoản thành công, bạn có thể đăng nhập ngay bây giờ!');
                    } else {
                        $redirect = new redirect('auth/login');
                        $redirect->setFlash('error', 'Kích hoạt tài khoản không thành công, vui lòng liên hệ quản trị viên!');
                    }
                } else {
                    $redirect = new redirect('auth/register');
                    $redirect->setFlash('error', 'Liên kết không tồn tại hoặc đã hết hạn');
                }
            } else {
                $redirect = new redirect('auth/register');
                $redirect->setFlash('error', 'Liên kết không tồn tại!');
            }

        }

        function login()
        {
            if (isset($_SESSION['user'])) {
                $verify = $this->Jwtoken->decodeToken($_SESSION['user'], KEYS);
                if ($verify != NULL && $verify != 0) {
                    $auth = $this->Authorzation->checkAuth($verify);
                    if ($auth) {
                        $redirect = new redirect('/');
                    }
                }
            }
            if ($_SERVER['REQUEST_METHOD'] == 'POST') {
                $data_post = [
                    'email' => filter_input(INPUT_POST, 'email', FILTER_SANITIZE_EMAIL),
                    'password' => filter_input(INPUT_POST, 'password', FILTER_SANITIZE_FULL_SPECIAL_CHARS)
                ];
                $data = $this->UserModels->select_row('*', [
                    'email' => trim($data_post['email']),
                    'status' => 1,
                ]);
                if ($data) {
                    if (password_verify($data_post['password'], $data['password'])) {
                        $array = [
                            'time'      => time() + 3600 * 24,
                            'keys'      => KEYS,
                            'info'      => [
                                'id'        => $data['id'],
                                'email'  => $data['email']
                            ]
                        ];
                        $jwt = $this->Jwtoken->CreateToken($array);
                        $dataInsert = [
                            'token' => $jwt,
                            'user_id' => $data['id'],
                            'created_at' => gmdate('Y-m-d H:i:s', time() + 7 * 3600)
                        ];
                        $result = $this->TokenLoginModels->add($dataInsert);
                        if ($result) {
                            $_SESSION['user'] = $jwt;
                            switch ($data['role_id']) {
                                case 1:
                                    $_SESSION['customer'] = $jwt .'customer';
                                    $redirect = new redirect('/'); 
                                    break;
                                case 2:
                                    $_SESSION['admin'] = $jwt . 'admin';
                                    $redirect = new redirect('admin/'); 
                                    break;
                                case 3:
                                    $_SESSION['employee'] = $jwt . 'employee';
                                    $redirect = new redirect('employee/'); 
                                    break;
                                case 4:
                                    $_SESSION['manager'] = $jwt . 'manager';
                                    $redirect = new redirect('manager/'); 
                                    break;
                                default:
                                    $redirect = new redirect('/'); 
                                    break;
                            }
                        } else {
                            $redirect = new redirect('auth/login');
                            $redirect->setFlash('error', 'Sai email hoặc mật khẩu!');
                        }
                    } else {
                        $redirect = new redirect('auth/login');
                        $redirect->setFlash('error', 'Sai email hoặc mật khẩu!');
                    }
                } else {
                    $redirect = new redirect('auth/login');
                    $redirect->setFlash('error', 'Tài khoản không tồn tại trong hệ thống!');
                }
            }

            $this->view('user/login/index', [
                'title'         => 'Đăng nhập'
            ]);
        }

        function logout()
        {
            if ($_SESSION['user']) {
                $token = $_SESSION['user'];
                $dataDelete = $this->TokenLoginModels->select_row('*',['token' => $token]);
                $this->TokenLoginModels->delete(['token' => $dataDelete['token']]);
                unset($_SESSION['user']);
                unset($_SESSION['customer']); 
                unset($_SESSION['employee']);
                unset($_SESSION['admin']);
                unset($_SESSION['manager']);
               
            }
            $redirect = new redirect('/');
        }

        function info()
        {
            if (isset($_SESSION['user'])) {
                $verify = $this->Jwtoken->decodeToken($_SESSION['user'], KEYS);
                if ($verify != NULL && $verify != 0) {
                    $auth = $this->Authorzation->checkAuth($verify);
                    if (!$auth) {
                        $redirect = new redirect('auth/login');
                    }
                }
            } else {
                $redirect = new redirect('auth/login');
            }
            if ($_SERVER['REQUEST_METHOD'] == 'POST') {
                // Information handle
                $errors = [];
                if (strlen($_POST['username']) < 1) {
                    $errors['username'] = 'Tên tài khoản không được để trống';
                }

                $dataUpdate = [
                    'fullname' => trim(filter_input(INPUT_POST, 'fullname', FILTER_SANITIZE_FULL_SPECIAL_CHARS)),
                    'username' => trim(filter_input(INPUT_POST, 'username', FILTER_SANITIZE_FULL_SPECIAL_CHARS)),
                    'phone_number' => filter_input(INPUT_POST, 'phone_number', FILTER_SANITIZE_FULL_SPECIAL_CHARS),
                    'email' => filter_input(INPUT_POST, 'email', FILTER_SANITIZE_EMAIL)
                ];

                if ($_FILES['avatar']['name']) {
                    $path_dir = $this->path_dir;
                    $data_upload = $this->uploads->upload($_FILES['avatar'], $path_dir, uniqid());
                    if ($data_upload['result'] == "false") {
                        $redirect = new redirect($this->template . '/' . 'index');
                        $redirect->setFlash('flash', $data_upload['message']);
                    } else {
                        $image = $data_upload['image'];
                        $thumb = $data_upload['thumb'];
                        $dataUpdate['avatar_url'] = $image;
                    }
                }
                
                if (empty($errors)) {
                    $result = $this->UserModels->update($dataUpdate, ['id' => $verify['id']]);
                    $decodeResults = json_decode($result, true);
                    if ($decodeResults['type'] === 'Sucessfully') {
                        $redirect = new redirect('auth/info');
                        $redirect->setFlash('sucess', 'Cập nhật thông tin thành công!');
                    }
                } else {
                    $_SESSION['errors'] = $errors;
                    $redirect = new redirect('auth/info');
                    $redirect->setFlash('error', 'Cập nhật thông tin không thành công!');
                }
            }


            $data = $this->MyController->indexCustomers();
            $this->view('user/info/index', [
                'title'         => 'Thông tin cá nhân',
                'page'          => 'information',
                'data'    => $data,

            ]);
        }

        function change_password()
        {
            $data = $this->MyController->indexCustomers();
            if (isset($_SESSION['user'])) {
                $verify = $this->Jwtoken->decodeToken($_SESSION['user'], KEYS);
                if ($verify != NULL && $verify != 0) {
                    $auth = $this->Authorzation->checkAuth($verify);
                    if (!$auth) {
                        $redirect = new redirect('auth/login');
                    }
                }
            } else {
                $redirect = new redirect('auth/login');
            }
            if ($_SERVER['REQUEST_METHOD'] == 'POST') {
                
                $errors = [];
                $data_post = $_POST;
                if (strlen($_POST['password']) < 6) {
                    $errors['password'] = 'Mật khẩu phải có ít nhất 6 ký tự';
                }
                if (strlen($_POST['newPassword']) < 6) {
                    $errors['newPassword'] = 'Mật khẩu mới phải có ít nhất 6 ký tự';
                }
                if (($_POST['retype-newPassword']) !== ($_POST['newPassword'])) {
                    $errors['retype-newPassword'] = 'Mật khẩu xác nhận không trùng khớp';
                }
                $rows = $this->UserModels->select_row('*', ['id' => $data['user']['id']]);
                if(empty($errors)) {
                    if (password_verify($data_post['password'], $rows['password'])) {
                        $array = [
                            'password' => password_hash(trim(filter_input(INPUT_POST, 'password', FILTER_SANITIZE_FULL_SPECIAL_CHARS)), PASSWORD_BCRYPT),
                            'updated_at' => gmdate('Y-m-d H:i:s', time() + 7 * 3600)
                        ];
                        $result = $this->UserModels->update($array, ['id' => $data['user']['id']]);
                        $decodeResults = json_decode($result, true);
                        if ($decodeResults['type'] === 'Sucessfully') {
                            $redirect = new redirect('auth/change_password');
                            $redirect->setFlash('sucess', 'Cập nhật mật khẩu thành công!');
                        }
                    } else {
                        $_SESSION['errors'] = $errors;
                        $redirect = new redirect('auth/change_password');
                        $redirect->setFlash('error', 'Mật khẩu cũ không chính xác');
                    }
                } else {
                    $_SESSION['errors'] = $errors;
                    $redirect = new redirect('auth/change_password');
                    $redirect->setFlash('error', 'Cập nhật mật khẩu không thành công!');
                }
            }
            
            $this->view('user/info/index', [
                'title' => 'Đổi mật khẩu',
                'page'  => 'changePassword',
                'data'  => $data,
            ]);
        }

        function forgot() {
            if (isset($_SESSION['user'])) {
                $verify = $this->Jwtoken->decodeToken($_SESSION['user'], KEYS);
                if ($verify != NULL && $verify != 0) {
                    $auth = $this->Authorzation->checkAuth($verify);
                    if ($auth) {
                        $redirect = new redirect('/');
                    }
                }
            }
            if ($_SERVER['REQUEST_METHOD'] == 'POST') {
                $email = trim($_POST['email']);
                $user = $this->UserModels->select_row('*', ['email' => trim($email)]);
                if(!empty($user)) {
                    $userId = $user['id'];
                    // Tạo forgot token
                    $forgotToken = sha1(uniqid().time()); 

                    $dataUpdate = [
                        'forgotToken' => $forgotToken,
                    ];

                    $result = $this->UserModels->update($dataUpdate, ['id' => $userId]);
                    $decodeResults = json_decode($result, true);
        
                    if($decodeResults['type'] === 'Sucessfully') {
                        $linkReset = base_url.'auth/reset?token='.$forgotToken;
                    
                        // Gửi email mã xác nhận
                        $subject = 'Khôi phục mật khẩu tài khoản';
                        $content = 'Chào bạn'.'<br>';
                        $content .= 'Bạn đã yêu cầu đặt lại mật khẩu tài khoản. 
                        Click vào link dưới đây để tiến hành reset mật khẩu: '.'<br>';
                        $content .= $linkReset. '<br>';
                        $content .= 'Trân trọng cảm ơn!';

                        $sendEmail = $this->SendMail->send($subject, $email, $content);
                        if($sendEmail) {
                            $redirect = new redirect('auth/forgot');
                            $redirect->setFlash('sucess', 'Vui lòng kiểm tra email để đặt lại mật khẩu của bạn.');
                        } 
                    } else {
                        $redirect = new redirect('auth/forgot');
                        $redirect->setFlash('error', 'Có lỗi xảy ra. Vui lòng thử lại!');
                    }
                } else {
                    $redirect = new redirect('auth/forgot');
                    $redirect->setFlash('error', 'Email không tồn tại trong hệ thống.');
                }
            }

            $this->view('user/forgot/index', [
                'title' => 'Quên mật khẩu'
            ]);
        }

        function reset()
        {
            $forgotToken = $_GET['token'];
            if (!empty($forgotToken)) {
                $tokenQuery =  $this->UserModels->select_row('*', ['forgotToken' => trim($forgotToken)]);
                if (!empty($tokenQuery)) {
                    $userId = $tokenQuery['id'];

                    if ($_SERVER['REQUEST_METHOD'] == 'POST') {
                        $errors = [];
                        if (strlen($_POST['newPassword']) < 6) {
                            $errors['newPassword'] = 'Mật khẩu mới phải có ít nhất 6 ký tự';
                        }
                        if (($_POST['retype-newPassword']) !== ($_POST['newPassword'])) {
                            $errors['retype-newPassword'] = 'Mật khẩu xác nhận không trùng khớp';
                        }

                        if (empty($errors)) {
                            $dataUpdate = [
                                'password' => password_hash(trim(filter_input(INPUT_POST, 'newPassword', FILTER_SANITIZE_FULL_SPECIAL_CHARS)), PASSWORD_BCRYPT),
                                
                                'updated_at' => gmdate('Y-m-d H:i:s', time() + 7 * 3600)
                            ];
                            $result = $this->UserModels->update($dataUpdate, ['id' => $userId]);
                            $decodeResults = json_decode($result, true);
                            if ($decodeResults['type'] === 'Sucessfully') {
                                $redirect = new redirect('auth/reset?&token=' . $forgotToken);
                                $redirect->setFlash('sucess', 'Thiết lập mật khẩu thành công!');
                            }
                        } else {
                            $_SESSION['errors'] = $errors;
                            $redirect = new redirect('auth/reset?&token=' . $forgotToken);
                            $redirect->setFlash('error', 'Thiết lập mật khẩu không thành công!');
                        }
                    }
                } else {
                    $redirect = new redirect('auth/forgot');
                    $redirect->setFlash('error', 'Liên kết không tồn tại!');
                }
            }
            $this->view('user/reset/index', [
                'title' => 'Thiết lập mật khẩu'
            ]);
        }
    }