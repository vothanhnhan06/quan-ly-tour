<?php 
class MyController extends Controller {
    function __construct(){
        $this->UserModels       =  $this->models('UserModels');
        $this->Jwtoken             =  $this->helper('Jwtoken');
    }

    function indexCustomers(){
        $data['user']           = $this->getUsers();   
        return $data;
    }

    function getUsers()
    {
        if (isset($_SESSION['user'])) {
            $verify = $this->Jwtoken->decodeToken($_SESSION['user'], KEYS);
            $user  = $this->UserModels->select_row('*', ['id' => trim($verify['id'])]);
            if ($verify  !== null) {
                return [
                    'id'  => $user['id'],
                    'fullname' => $user['fullname'],
                    'phone_number' => $user['phone_number'],
                    'email' => $user['email'],
                    'username' => $user['username'],
                    'avatar_url' => $user['avatar_url']
                ];
            }
        } else {
            return false;
        }
    }
}