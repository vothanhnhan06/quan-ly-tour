<?php
class Authorzation extends Controller
{
    public $UserModels;
    function __construct()
    {
        $this->UserModels = $this->models('UserModels');
    }
    function checkAuth($array)
    {
        $id = $array['id'];
        $email = $array['email'];
        // echo $email;
        $checkUS = $this->UserModels->select_array('*', ['id' => $id, 'email' => $email]);
        if ($checkUS != NULL && count($checkUS) > 0) {
            return true;
        } else {
            return false;
        }
    }
}
