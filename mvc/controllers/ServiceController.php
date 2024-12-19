<?php
require_once 'MyController.php';
require_once "./mvc/core/redirect.php";
class ServiceController extends Controller{

    public $MyModels;
    public $ServiceModels;
    public $CategoryModels;

    function __construct()
    {
        $this->MyModels = $this->models('MyModels');
        $this->ServiceModels = $this->models('ServiceModels');
        $this->CategoryModels=$this->models('CategoryModels');
        $this->MyController = new MyController();
    }
    
    function loadData(){
        $data= $this->MyController->indexCustomers();
        $service = $this->ServiceModels->select_array('*');
        $data=[
            'page'=>'servicess/index',
            'service'=>$service
        ];
        $this->view('user/index', $data);
    }
    
}