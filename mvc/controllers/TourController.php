<?php
require_once './mvc/models/TourModel.php';
class TourController extends Controller
{
    protected $tourModel;
    public $Jwtoken;

    public function __construct()
    {
        $this->tourModel = new TourModel();
        $this->Jwtoken             =  $this->helper('Jwtoken');
    }

    public function add()
    {
        if ($_SERVER['REQUEST_METHOD'] === 'POST') {
            $data = json_decode(file_get_contents("php://input"), true);

            if ($data) {
                //var_dump($data);
                $response = $this->tourModel->add($data, 'name');
                echo $response;
                // // Redirect to avoid duplicate POST requests
                // header("Location: /success-page");
                // exit();
            } else {
                echo json_encode([
                    'type' => 'Fail',
                    'message' => 'Invalid input data'
                ]);
            }
        }
    }

    public function index()
    {
        if ($_SERVER['REQUEST_METHOD'] === 'GET') {
            $tours = $this->tourModel->select_row('name', ['id' => 3]);
            echo json_encode($tours, JSON_UNESCAPED_UNICODE);
        }
    }

    public function update()
    {
        if ($_SERVER['REQUEST_METHOD'] === 'PUT') {
            $data = json_decode(file_get_contents("php://input"), true);

            if ($data) {
                $response = $this->tourModel->update($data);
                echo $response;
            } else {
                echo json_encode([
                    'type' => 'Fail',
                    'message' => 'Invalid input data'
                ]);
            }
        }
    }

    public function delete()
    {
        if ($_SERVER['REQUEST_METHOD'] === 'DELETE') {
            $data = json_decode(file_get_contents("php://input"), true);

            if ($data) {
                $response = $this->tourModel->delete($data);
                echo $response;
            } else {
                echo json_encode([
                    'type' => 'Fail',
                    'message' => 'Invalid input data'
                ]);
            }
        }
    }
}
?>


