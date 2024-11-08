<?php
require_once 'MyController.php';
require_once "./mvc/core/redirect.php";

class HomeController extends Controller
{
    public function index()
    {
        $data = [
            'page'          => 'home/index',
            'title'        => 'Trang chủ'
        ];
        $this->view('user/index', $data);
    }
}
