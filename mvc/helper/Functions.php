<?php
//file chưa xử lý
class Functions extends Controller
{
    public $CategoryModels;
    function __construct()
    {
        $this->CategoryModels = $this->models('CategoryModels');
    }

    function pagination($total_page, $page)
    {
        $page_array = [];
        if ($total_page > 5) {
            if ($page < 6) {
                for ($i = 1; $i <= 6; $i++) {
                    $page_array[] = $i;
                }
                $page_array[] = '...';
                $page_array[] = $total_page;
            } else {
                $end_limit = $total_page - 5;
                if ($page > $end_limit) {
                    $page_array[] = 1;
                    $page_array[] = '...';
                    for ($i = $end_limit; $i <= $total_page; $i++) {
                        $page_array[] = $i;
                    }
                } else {
                    $page_array[] = 1;
                    $page_array[] = '...';
                    for ($i = $page - 1; $i <= $page + 1; $i++) {
                        $page_array[] = $i;
                    }
                    $page_array[] = '...';
                    $page_array[] = $total_page;
                }
            }
        } else {
            for ($i = 1; $i <= $total_page; $i++) {
                $page_array[] = $i;
            }
        }
        $page_link = '';
        $prev_link = '';
        $next_link = '';
        if ($page_array != NULL) {
            for ($i = 0; $i < count($page_array); $i++) {
                if ($page == $page_array[$i]) {
                    $page_link .= '<li>
                        <a href="javascript:void(0)" class="page-link active disabled" num-page ="' . $page_array[$i] . '">' . $page_array[$i] . '</a>
                    </li>';
                    $prev_id = $page_array[$i] - 1;
                    if ($prev_id <= 0) {
                        $prev_link .= '<li>
                            <a href="javascript:void(0)" class="page-link disabled">Previous</a>
                        </li>';
                    } else {
                        $prev_link .= '<li>
                            <a href="javascript:void(0)" class="page-link" num-page="' . $prev_id . '">Previous</a>
                        </li>';
                    }
                    $next_id = $page_array[$i] + 1;
                    if ($next_id > $total_page) {
                        $next_link .= '<li>
                            <a href="javascript:void(0)" class="page-link disabled">Next</a>
                        </li>';
                    } else {
                        $next_link .= '<li>
                            <a href="javascript:void(0)" class="page-link" num-page="' . $next_id . '">Next</a>
                        </li>';
                    }
                } else {
                    if ($page_array[$i] == '...') {
                        $page_link .= '<li>
                            <a href="javascript:void(0)" class="page-link  disabled">...</a>
                        </li>';
                    } else {
                        $page_link .= '<li>
                            <a href="javascript:void(0)" class="page-link" num-page ="' . $page_array[$i] . '">' . $page_array[$i] . '</a>
                        </li>';
                    }
                }
            }
        }
        return $prev_link . $page_link . $next_link;
    }
    function getCate($type, $parentID = 0, $selectedID = NULL)
    {
        $menu = $this->CategoryModels->select_array('*', ['type' => $type, 'parentID' => $parentID]);
        $data = '';

        if ($menu != NULL) {
            $data .= '<select class="form-control" name="data_post[cateID]">';
            foreach ($menu as $key => $val) {
                $selected = '';

                if ($selectedID == $val['id']) {
                    $selected = 'selected';
                }
                $data .= '<option value="' . $val['id'] . '" ' . $selected . '>';
                $data .= $val['name'];
                $data .= '</option>';

                $child = $this->CategoryModels->select_array('*', ['type' => $type, 'parentID' => $val['id']]);
                if ($child != NULL) {
                    foreach ($child as $key_child => $val_Child) {
                        $selected_Child = '';
                        if ($selectedID == $val_Child['id']) {
                            $selected_Child = 'selected';
                        }
                        $data .= '<option value="' . $val_Child['id'] . '" ' . $selected_Child . '>';
                        $data .= '---------| ' . $val_Child['name'];
                        $data .= '</option>';
                    }
                }
            }
            $data .= '</select>';
        }
        return $data;
    }
    function checkingStatusOrder($number)
    {
        switch ($number) {
            case 1:
                return ['type' => '#545b62', 'text' => 'Đang xử lý'];
                break;
            case 2:
                return ['type' => '#0062cc', 'text' => 'Đã xác nhận'];
            case 3:
                return ['type' => '#ffc107', 'text' => 'Đã gửi'];
            case 4:
                return ['type' => '#1e7e34', 'text' => 'Đã hoàn thành'];
                break;
            default:
                return ['type' => '#545b62', 'text' => 'Đang xử lý'];
                break;
        }
    }
}
