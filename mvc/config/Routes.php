<?php 
require_once "./mvc/controllers/TourController.php";

class Routes {
    var $array = [];

    // Phương thức để thêm route
    public static function addRoute($url, $controllerAction) {
        global $Routes;
        $Routes[] = ['url' => $url, 'controllerAction' => $controllerAction];
    }

    function handleUrl($url){
       global $Routes;
       $returnUrl = ltrim($url,'/');

        if (is_array($url)) {
            // Nếu $url là mảng, chuyển thành chuỗi
            $url = implode('/', $url);
        }

       if (isset($Routes))
       {
            $folder = $this->readFolder('mvc/controllers');
            $strpos = $this->checkUrl($returnUrl,$folder);
            foreach($Routes as $key => $val){
                // $paramer = explode('/',$val);
                // $urlArray = explode('/', ltrim($url,'/'));
                // $explode_ursl_arr = explode('.',$returnUrl);
                $paramer = explode('/', $val['controllerAction']); // Đảm bảo rằng $val['controllerAction'] là chuỗi
                $urlArray = explode('/', ltrim($url, '/')); // Đảm bảo $url là chuỗi tại đây
                
                // Kiểm tra nếu $returnUrl là chuỗi
                $explode_url_arr = (is_string($returnUrl)) ? explode('.', $returnUrl) : [];

                if ($strpos === 0  && $url !== '/'  && !isset($explode_url_arr[1])) {
                    $regex = $this->convertRegex($key);
                    if (!empty($regex)) {
                        if (preg_match($regex,$returnUrl))
                        {
                            unset($paramer[count($paramer) - 1]);
                            $explode_url = explode('/',$returnUrl);
                            $returnUrl = preg_replace('~'.$regex.'~is',$val, $explode_url[count($explode_url) - 1]);
                            $strip = '';
                            foreach($paramer as $value){
                            $strip .= $value.'/';
                            }
                            $ltrim = trim($strip,'/');
                            $strip = $strip.$returnUrl;
                            $returnUrl = $strip;
                        }
                    }
                   
                }
                else{
                    if (preg_match('~'.$key.'~is',$url))
                    {
                        $returnUrl = preg_replace('~'.$key.'~is',$url,$val);
                    }
                }
            }
       }
       return $returnUrl;
    }
    function checkUrl($url, $folder = NULL){
        $trim = ltrim($url,'/');
        $countArray = explode('/',$trim);
        $counts = 0;
        $urlString = '';
        foreach($folder as $key => $value){
            foreach($countArray as $val){
                $urlString .= $val.'/';
                $filecheck = trim($urlString,'/');
                if (file_exists('mvc/controllers/'.$filecheck.'.php'))
                {
                    $counts = 1;
                    break;
                }
            }
        }
        return $counts;
    }
    function convertRegex($string){
        if (preg_match('(:any)', $string)) {
            return '/([A-Za-z0-9]+)/';
        }
        else if(preg_match('(:num)', $string)){
            return  '/^[0-9]+$/i';
        }
    }
    function readFolder($folder_ = NULL){
        if (is_dir($folder_)) {
            $folder = glob($folder_.'/*');
            foreach($folder as $value){
                if (is_dir($value)) {
                    $this->readFolder($value);
                }
                else
                {
                   array_push($this->array, explode('.',$value)[0]);
                }
            }
        }
        return $this->array;
    }
}
// Định nghĩa các route cho Tour
Routes::addRoute('/tour/add', 'TourController/add');   // Route cho thêm tour
Routes::addRoute('/tour/edit/(:num)', 'TourController/edit/$1'); // Route cho sửa tour, với tham số là ID
Routes::addRoute('/tour/delete/(:num)', 'TourController/delete/$1'); // Route cho xóa tour, với tham số là ID
Routes::addRoute('/tours', 'TourController/index'); 
?>