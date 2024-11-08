<?php 
class MyController extends Controller{
    public $UserModels;
    public $Jwtoken;
    function __construct(){
        $this->UserModels       =  $this->models('UserModels');
        $this->Jwtoken             =  $this->helper('Jwtoken');
    }
   
    function getUsers(){
        if(isset($_SESSION['user'])){
            $verify = $this->Jwtoken->decodeToken($_SESSION['user'],KEYS);
            $user  = $this->UserModels->select_row('*',['id' => trim($verify['id'])]);
            if($verify  !== null){
                return [
                    'id'            => $user['id'],
                    'fullname'          => $user['fullname'],
                    'phone'   => $user['phone'],
                    'email'         => $user['email'],
                ];
            }
        }
        else
        {
            return false;
        }

    }
}