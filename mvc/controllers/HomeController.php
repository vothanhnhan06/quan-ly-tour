<?php
require_once 'MyController.php';
require_once "./mvc/core/redirect.php";

class HomeController extends Controller
{
    public $MyModels;
    public $TourModels;
    public $CategoryModels;

    function __construct()
        {
            $this->MyModels = $this->models('MyModels');
            $this->TourModels = $this->models('TourModels');
            $this->CategoryModels=$this->models('CategoryModels');
            $this->MyController = new MyController();
        }
    public function index()
    {
        $data= $this->MyController->indexCustomers();
        $tours = $this->TourModels->select_array('*', NULL, NULL, NULL, 4);
        $tours_db = $this->TourModels->select_array('*', ['category_id'=>4], NULL, NULL, 6);
        $data = [
            'page' => 'user/home/index',
            'title' => 'Trang chủ',
            'data' => $data,
            'tours' => $tours,
            'tours_db' => $tours_db
        ];
        $this->view('user/index', $data);
    }
}