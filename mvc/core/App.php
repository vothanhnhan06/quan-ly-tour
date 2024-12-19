<?php

class App
{
    protected $controller = "HomeController";
    protected $action = "index";
    protected $params = [];
    protected $Routes__;

    function __construct()
{
    $array = $this->urlProcess(); // Chuyển URL thành mảng
    $subFolder = ''; // Thư mục con
    $controllerName = ''; // Tên controller
    $actionName = ''; // Tên action

    // Bước 1: Xử lý thư mục con
    if (isset($array[0]) && is_dir("./mvc/controllers/" . $array[0])) {
        $subFolder = $array[0]; // Lấy tên thư mục con
        unset($array[0]); // Xóa phần tử khỏi mảng URL
        $array = array_values($array); // Reset mảng URL
    }

    // Bước 2: Xử lý controller
    if (isset($array[0])) {
        $controllerName = $this->toCamelCase($array[0]); // Lấy tên controller
        unset($array[0]); // Xóa phần tử khỏi mảng URL
        $array = array_values($array); // Reset mảng URL
    } else {
        $controllerName = $this->controller; // Controller mặc định
    }

    // Đường dẫn file controller
    $controllerPath = !empty($subFolder)
        ? "./mvc/controllers/$subFolder/" . $controllerName . ".php"
        : "./mvc/controllers/" . $controllerName . ".php";

    // Bước 3: Kiểm tra và load controller
    if (file_exists($controllerPath)) {
        require_once $controllerPath;
        if (class_exists($controllerName)) {
            $this->controller = new $controllerName();
        } else {
            die("Controller class `$controllerName` không tồn tại.");
        }
    } else {
        die("File controller `$controllerPath` không tồn tại.");
    }

    // Bước 4: Xử lý action
    if (isset($array[0])) {
        $actionName = $array[0]; // Lấy tên action
        unset($array[0]); // Xóa phần tử khỏi mảng URL
        $array = array_values($array); // Reset mảng URL
    } else {
        $actionName = $this->action; // Action mặc định
    }

    // Kiểm tra action
    if (method_exists($this->controller, $actionName)) {
        $this->action = $actionName;
    } else {
        die("Action `$actionName` không tồn tại trong controller `$controllerName`.");
    }

    // Bước 5: Gán params
    $this->params = $array;

    // Bước 6: Gọi controller, action và truyền params
    call_user_func_array([$this->controller, $this->action], $this->params);
}


    



    function getUrl()
    {
        if (isset($_SERVER['PATH_INFO'])) {
            $url = $_SERVER['PATH_INFO'];
        } else {
            $url = '/';
        }
        return $url;
    }
    function urlProcess()
    {
        $this->Routes__ = new Routes();
        $returnUrl = $this->Routes__->handleUrl($this->getUrl());
        return explode("/", filter_var(trim($returnUrl, "/")));
    }

    function toCamelCase($string)
    {
        $string = strtolower($string);
        return ucfirst($string) . "Controller";
    }
}
