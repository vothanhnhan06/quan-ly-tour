<?php

class App
{
    protected $controller = "HomeController";
    protected $action = "index";
    protected $params = [];
    protected $Routes__;

    function __construct()
    {
        $array = $this->urlProcess();
        echo '<pre>'; 
        print_r($array);
        echo '</pre>';
        $urlParam = '';
        if ($array != NULL) {
            foreach ($array as $key => $val) {
                $val = $this->toCamelCase($val);
                $urlParam .= $val . '/';
                $fileCheck = trim($urlParam, '/');
                $fileArray = explode('/', $fileCheck);

                if (!empty($fileArray[$key - 1])) {
                    unset($array[$key - 1]);
                }

                if (file_exists("./mvc/controllers/" . $fileCheck . ".php")) {
                    $urlParam = $fileCheck;
                    break;
                }
            }
        }

        $array = array_values($array);

        if ($array != NULL) {
            $controllerName = $this->toCamelCase($array[0]);
            $controllerPath = "./mvc/controllers/" . $controllerName . ".php";

            if (file_exists($controllerPath)) {
                $this->controller = $controllerName;
                require_once $controllerPath;
                if (class_exists($this->controller)) {
                    $this->controller = new $this->controller;
                    unset($array[0]);
                }
            } else {
                $this->controller = $this->controller;
                require_once "./mvc/controllers/" . $this->controller . ".php";
            }
        } else {
            require_once "./mvc/controllers/" . $this->controller . ".php";
        }

        $this->controller = new $this->controller;
        if (isset($array[1])) {
            if (method_exists($this->controller, $array[1])) {
                $this->action = $array[1];
                unset($array[1]);
            }
        }
        $this->params = $array ? array_values($array) : [];
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
