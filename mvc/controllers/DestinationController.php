<?php
require_once 'MyController.php';
require_once "./mvc/core/redirect.php";
class DestinationController extends Controller{
    public $TourModels;
    const limit = 5;
    function __construct(){
        $this->TourModels = $this->models('TourModels');
        $this->Functions =  $this->helper('Functions');
    }
    function index($id){
        $tour = $this->TourModels->select_array_join_table('categories.describe as des,categories.name as cate_name,tours.id AS id_tour,tours.name as tour_name,slug,price,destination,pick_up,duration,itinerary,date_start,thumbnail,description,created_at,updated_at,category_id',['category_id'=>$id],NULL,NULL,NULL,'categories','category_id=categories.id','INNER');
        
        $limit=self::limit;
        $page =1;
        $total_row=count($tour);
        $total_page=ceil($total_row/$limit);
        $start=($page-1)*$limit;
        $datas = [];
        if($total_row>0){
            $datas =$this->TourModels->select_array_join_table('categories.describe as des,categories.name as cate_name,tours.id AS id_tour,tours.name as tour_name,slug,price,destination,pick_up,duration,itinerary,date_start,thumbnail,description,created_at,updated_at,category_id',['category_id'=>$id],NULL,$start,$limit,'categories','category_id=categories.id','INNER');
        }
        $button_pagination=$this->Functions->pagination($total_page,$page);

        $data = [
            'page' => 'destination/index',
            'tour' => $datas,
            'button_pagination' => $button_pagination
        ];

        $this->view('user/index', $data);
    }
   
}