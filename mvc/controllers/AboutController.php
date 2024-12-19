<?php
require_once 'MyController.php';
require_once "./mvc/core/redirect.php";

class AboutController extends Controller
{

    function __construct()
        {
            
            $this->MyController = new MyController();
        }
    public function index()
    {
        $data= $this->MyController->indexCustomers();
        $data = [
            'page' => 'user/about/index',
            'title' => 'Giới thiệu',
            'data' => $data
        ];
        $this->view('user/index', $data);
    }
}