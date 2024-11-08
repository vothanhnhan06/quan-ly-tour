    <?php
    require_once "./mvc/controllers/MyController.php";
    require_once "./mvc/core/redirect.php";

    class AuthController extends Controller
    {
        public $template = 'AuthController';
        public $UserModels;

        function __construct()
        {
            $this->UserModels = $this->models('UserModels');
            $this->Jwtoken = $this->helper('Jwtoken');
            $this->Authorzation = $this->helper('Authorzation');
        }
        function index()
        {
        'auth';
        }
        function register()
        {
            if ($_SERVER['REQUEST_METHOD'] == 'POST') {
                $data_post                  = $_POST;
                $counts                     = $this->UserModels->select_array('*', ['email' => trim($data_post['email'])]);
                $data_post['created_at']    = gmdate('Y-m-d H:i:s', time() + 7 * 3600);
                $password                   = password_hash($data_post['password'], PASSWORD_BCRYPT);
                $data_post['password']      = $password;
                unset($data_post['retype-password']);

                if (count($counts) > 0) {
                    $redirect = new redirect('auth/register');
                    $redirect->setFlash('errors', 'Tài khoản đã tồn tại!');
                } else {
                    $result = $this->UserModels->add($data_post);
                    $return = json_decode($result, true);
                    if ($return['type'] == "Sucessfully") {
                        $redirect = new redirect('auth/register');
                        $redirect->setFlash('flash', 'Đăng ký thành công.!');
                    }   
                }
            }
        $this->view('user/register/index', [
            'title'         => 'Đăng ký'
        ]);
    }
    function login()
    {
        if (isset($_SESSION['user'])) {
            echo $_SESSION['user'];
            $verify = $this->Jwtoken->decodeToken($_SESSION['user'], KEYS);
            if ($verify != NULL && $verify != 0) {
                $auth = $this->Authorzation->checkAuth($verify);
                if ($auth) {
                    $redirect = new redirect('/');
                }
            }
        }
        if ($_SERVER['REQUEST_METHOD'] == 'POST') {
            $data_post  = $_POST;
            $data      = $this->UserModels->select_row('*', ['email' => trim($data_post['email'])]);
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
                    $_SESSION['user'] = $jwt;
                    $redirect = new redirect('/');
                } else {
                    $redirect = new redirect('auth/login');
                    $redirect->setFlash('errors', 'Sai mật khẩu hoặc tài khoản!');
                }
            } else {
                $redirect = new redirect('auth/login');
                $redirect->setFlash('errors', 'Sai mật khẩu hoặc tài khoản!');
            }
        }
        $this->view('user/login/index', [
            'title'         => 'Đăng nhập'
        ]);
    }
    function logout()
    {
        if ($_SESSION['user']) {
            unset($_SESSION['user']);
        }
        $redirect = new redirect('/');
    }
    function info()
    {
        if (isset($_SESSION['user'])) {
            $verify = $this->Jwtoken->decodeToken($_SESSION['user'], KEYS);
            if ($verify != NULL && $verify != 0) {
                $auth = $this->Authorzation->checkAuthUser($verify);
                if (!$auth) {
                    $redirect = new redirect('auth/login');
                }
            }
        } else {
            $redirect = new redirect('auth/login');
        }
        if ($_SERVER['REQUEST_METHOD'] == 'POST') {
            $data_post = $_POST;
            $array = [
                'name'          => $data_post['name'],
                'email'         => $data_post['email'],
                'phoneNumber'   => $data_post['phonenumber'],
                'address'       => json_encode($data_post['address'], true),
            ];
            $result = $this->UserModels->update($array, ['id' => $verify['id']]);
            $decodeResults = json_decode($result, true);
            if ($decodeResults['type'] === 'sucessfully') {
                $redirect = new redirect('auth/info');
                $redirect->setFlash('flash', 'Cập nhật thành công!');
            }
        }

        $this->view('user/info/index', [
            'title'         => 'Thông tin cá nhân',
            'page'          => 'information'
        ]);
    }
    // function changePassWord()
    // {
    //     if (isset($_SESSION['user'])) {
    //         $verify = $this->Jwtoken->decodeToken($_SESSION['user'], KEYS);
    //         if ($verify != NULL && $verify != 0) {
    //             $auth = $this->Authorzation->checkAuthUser($verify);
    //             if (!$auth) {
    //                 $redirect = new redirect('auth/login');
    //             }
    //         }
    //     } else {
    //         $redirect = new redirect('auth/login');
    //     }
    //     if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    //         $data_post = $_POST;
    //         $rows = $this->UserModels->select_row('*', ['id' => $data_index['user']['id']]);
    //         if (password_verify($data_post['password'], $rows['password'])) {
    //             $array = [
    //                 'password'      => password_hash(trim($data_post['newPassword']), PASSWORD_BCRYPT),
    //                 'password_text' => trim($data_post['newPassword']),
    //                 'updated_at'    => gmdate('Y-m-d H:i:s', time() + 7 * 3600)
    //             ];
    //             $result = $this->UserModels->update($array, ['id' => $data_index['user']['id']]);
    //             $decodeResults = json_decode($result, true);
    //             if ($decodeResults['type'] === 'sucessFully') {
    //                 $redirect = new redirect('doi-mat-khau.html');
    //                 $redirect->setFlash('flash', 'Cập nhật thành công!');
    //             }
    //         } else {
    //             $redirect = new redirect('doi-mat-khau.html');
    //             $redirect->setFlash('errors', 'Mật khẩu cũ không chính xác');
    //         }
    //     }
        
    //     $this->view('user/info/index', [
    //         'title'         => 'Đổi mật khẩu',
    //         'page'          => 'changePassword'
    //     ]);
    // }
}
