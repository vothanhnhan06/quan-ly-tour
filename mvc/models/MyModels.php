<?php 
class MyModels extends Database {
    function select_array($data = '*',
    $where = NULL,
    $orderby = NULL,
    $start = NULL,
    $limit = NULL,
    $fields_in = NULL,
    $array_where_in = NULL,
    $fields_not_in = NULL,
    $array_where_not_in = NULL
    ) {
        $sql ="SELECT $data FROM $this->table";
        if (isset($where) && $where != NULL) {
            $fields = array_keys($where);
            $fields_list = implode("", $fields);
            $values = array_values($where);
            $isFields = true;
            $stringWhere = 'where';
            $string_Caculator = '=';
            for ($i=0; $i < count($fields); $i++) { 
                preg_match('/<=|>=|<|>|!=/',$fields[$i],$matches,PREG_OFFSET_CAPTURE);
                if ($matches != null) {
                   $string_Caculator = $matches[0][0];
                }
                if (!$isFields) {
                  $sql .= " and ";
                  $stringWhere = '';
                }
               $isFields = false;
               $sql .= "  ".$stringWhere." ".preg_replace('/<=|>=|<|>|!=/','',$fields[$i])." ".$string_Caculator." ? ";
            }
            if ($fields_in != NULL && $array_where_in != NULL) {
                $sql .= ' '.$this->where_in($fields_in,$array_where_in,true).' ';
            }
            if ($fields_not_in != NULL && $array_where_not_in != NULL) {
                $sql .= ' '.$this->where_not_in($fields_not_in,$array_where_not_in,true).' ';
            }
            if ($orderby !='' && $orderby != NULL) {
                $sql .= " ORDER BY ".$orderby."";
            }
            if ($limit != NULL) {
                $sql .= " LIMIT ".$start." , ".$limit."";
            }
            $query = $this->conn->prepare($sql);
            $query->execute($values);
        }
        else{
            if ($orderby !='' && $orderby != NULL) {
                $sql .= " ORDER BY ".$orderby."";
            }
            if ($limit != NULL) {
                $sql .= " LIMIT ".$start." , ".$limit."";
            }
            $query = $this->conn->prepare($sql);
            $query->execute();
        }
        
        return $query->fetchAll(PDO::FETCH_ASSOC);
    }
    function add($data = NULL, $unique_column = NULL){
        // Kiểm tra xem có dữ liệu không
        if ($data === NULL) {
            return json_encode(
                array(
                    'type'      => 'Fail',
                    'Message'   => 'No data provided',
                )
            );
        }

        // Kiểm tra cột duy nhất cần kiểm tra trùng lặp
        if ($unique_column === NULL) {
            return json_encode(
                array(
                    'type'      => 'Fail',
                    'Message'   => 'No unique column specified',
                )
            );
        }

        // Kiểm tra trùng lặp
        $check_query = "SELECT COUNT(*) as count FROM ".$this->table." WHERE ".$unique_column." = ?";
        $stmt = $this->conn->prepare($check_query);
        $stmt->execute(array($data[$unique_column]));
        $row = $stmt->fetch(PDO::FETCH_ASSOC);

        // Kiểm tra nếu dữ liệu đã tồn tại
        if ($row && $row['count'] > 0) {
            return json_encode(
                array(
                    'type'      => 'Fail',
                    'Message'   => 'Data already exists',
                )
            );
        }

        // Xử lý dữ liệu ảnh thumbnail nếu có
        if (isset($_FILES['thumbnail']) && $_FILES['thumbnail']['error'] === 0) {
            $thumbnailPath = $this->processThumbnail($_FILES['thumbnail']);
            if ($thumbnailPath) {
                $data['thumbnail'] = $thumbnailPath;  // Lưu đường dẫn ảnh vào dữ liệu
            } else {
                return json_encode(
                    array(
                        'type'      => 'Fail',
                        'Message'   => 'Failed to upload thumbnail',
                    )
                );
            }
        }


        $fields = array_keys($data);
        $fields_list = implode(",",$fields);
        $values = array_values($data);
        $qr = str_repeat("?,", count($fields) - 1) . "?"; 
        $sql = "INSERT INTO `".$this->table."`(".$fields_list.") VALUES ($qr)";
        $query = $this->conn->prepare($sql);
        if ($query->execute($values)) {
            $lastInsertId = $this->conn->lastInsertId();  // Lấy ID của bản ghi vừa thêm

            // Nếu có ảnh thumbnail, thêm vào bảng tour_images (hoặc bảng tương ứng)
            if (isset($data['thumbnail']) && !empty($data['thumbnail'])) {
                $this->addThumbnailToImages($lastInsertId, $data['thumbnail']);
            }

            return json_encode(
                array(
                    'type'      => 'Sucessfully',
                    'Message'   => 'Insert data sucessfully',
                    'id'        => $this->conn->lastInsertId()
                )
            );
        }
        else{
            return json_encode(
                array(
                    'type'      => 'Fail',
                    'Message'   => 'Insert data fail',
                )
            );
        }
    }

    // Xử lý ảnh thumbnail
    private function processThumbnail($file)
    {
        // Kiểm tra loại file (chỉ cho phép ảnh)
        $allowed_types = ['image/jpeg', 'image/png'];
        $file_type = $file['type'];

        if (in_array($file_type, $allowed_types)) {
            // Tạo đường dẫn lưu ảnh
            $upload_dir = "uploads/thumbnails/";
            $file_name = time() . "_" . basename($file['name']);
            $target_file = $upload_dir . $file_name;

            // Di chuyển ảnh vào thư mục lưu trữ
            if (move_uploaded_file($file['tmp_name'], $target_file)) {
                return $target_file;  // Trả về đường dẫn ảnh
            } else {
                return false;
            }
        } else {
            return false;
        }
    }

    // Thêm ảnh vào bảng tour_images (hoặc bảng liên quan)
    private function addThumbnailToImages($tourId, $thumbnailPath)
    {
        // Câu lệnh thêm ảnh vào bảng tour_images
        $sql = "INSERT INTO `tour_images` (`tour_id`, `image_url`) VALUES (?, ?)";
        $stmt = $this->conn->prepare($sql);
        $stmt->execute([$tourId, $thumbnailPath]);
    }

    function update($data = NULL,$where = NULL){
        if ($data != NULL && $where != NULL) {
            $fields = array_keys($data);
            $values = array_values($data);
            $where_array = array_keys($where);
            $value_where = array_values($where);
            $sql ="UPDATE $this->table SET ";
            $isFields = true;
            $isFields_where = true;
            $stringWhere = 'where';
            $string_Caculator = '=';
            for ($i=0; $i < count($fields); $i++) { 
                if (!$isFields) {
                    $sql .= ", ";
                }
                $isFields = false;
                $sql .= "".$fields[$i]." =?";
            }
            for ($i=0; $i < count($where_array); $i++) {
                preg_match('/<=|>=|<|>/',$where_array[$i],$matches,PREG_OFFSET_CAPTURE);
                if ($matches != null) {
                    $string_Caculator = $matches[0][0];
                   
                } 
                if (!$isFields_where) {
                  $sql .= " and ";
                  $stringWhere = '';
                }
               $isFields_where = false;
               $sql .= "  ".$stringWhere." ".preg_replace('/<=|>=|<|>/','',$where_array[$i])." ".$string_Caculator." '".$value_where[$i]."'";
            }
            $query = $this->conn->prepare($sql);
            if ($query->execute($values)) {
                return json_encode(
                    array(
                        'type'      => 'Sucessfully',
                        'Message'   => 'Update data sucessfully',
                    )
                );
            }
            else{
                return json_encode(
                    array(
                        'type'      => 'Fail',
                        'Message'   => 'Update data fail',
                    )
                );
            }
        }
    }

    function delete($where = NULL) {
        $sql = "DELETE FROM  $this->table ";
        if ($where != NULL) {
        $where_array = array_keys($where);
        $value_where = array_values($where);
        $isFields_where = true;
        $stringWhere = 'where';
        $string_Caculator = '=';
            $where_array = array_keys($where);
            $value_where = array_values($where);
            $isFields_where = true;
            $stringWhere = 'where';
            for ($i=0; $i < count($where_array); $i++) { 
                preg_match('/<=|>=|<|>/',$where_array[$i],$matches,PREG_OFFSET_CAPTURE);
                if ($matches != null) {
                    $string_Caculator = $matches[0][0];
                }
                
                if (!$isFields_where) {
                    $sql .= " and ";
                    $stringWhere = '';
                }
                $isFields_where = false;
                $sql .= "" .$stringWhere." ".preg_replace('/<=|>=|<|>/','',$where_array[$i])." ".$string_Caculator." ?";//-
                $sql .= "  ".$stringWhere." ".preg_replace('/<=|>=|<|>/','',$where_array[$i])." ".$string_Caculator." ?";//+
            }
            $query = $this->conn->prepare($sql);
            if ($query->execute($value_where)) {
                return json_encode(
                    array(
                        'type'      => 'Sucessfully',
                        'Message'   => 'Delete data sucessfully',
                    )
                );
            }
            else{
                return json_encode(
                    array(
                        'type'      => 'Fail',
                        'Message'   => 'Delete data fail',
                    )
                );
            }
        }
    }

    function select_row($data='*',$where){
        $sql ="SELECT $data FROM $this->table ";
        if ($where != NULL) {
            $where_array = array_keys($where);
            $value_where = array_values($where);
            $isFields_where = true;
            $stringWhere = 'where';
            for ($i=0; $i < count($where_array); $i++) { 
                if (!$isFields_where) {
                    $sql .= " and ";
                    $stringWhere = '';
                }
                $isFields_where = false;
                $sql .= "" .$stringWhere." ".$where_array[$i]." = ?";
            }
            $query = $this->conn->prepare($sql);
            $query->execute($value_where);
            return $query->fetch(PDO::FETCH_ASSOC);
        }
    }
    function select_max_fields($data = '',$where = NULL){
       if ($data != '') {
           $sql = "SELECT MAX(".$data.") as sort FROM $this->table ";
       }
       if ($where != NULL) {
            $where_array = array_keys($where);
            $value_where = array_values($where);
            $isFields_where = true;
            $stringWhere = 'where';
            for ($i=0; $i < count($where_array); $i++) { 
                if (!$isFields_where) {
                    $sql .= " and ";
                    $stringWhere = '';
                }
                $isFields_where = false;
                $sql .= "" .$stringWhere." ".$where_array[$i]." = ?";
            }
            $query = $this->conn->prepare($sql);
            $query->execute($value_where);
        }
        $query = $this->conn->prepare($sql);
        $query->execute();
        return $query->fetch(PDO::FETCH_ASSOC);
    }
    function query($query){
        $sql = $query;
        $query = $this->conn->prepare($sql);
        $query->execute();
        return $query->fetchAll(PDO::FETCH_ASSOC);
    }

    function select_array_where_not_in($data = '*',$where = NULL,$fields_not_in = NULL,$array_where_not_in = NULL,$orderby = NULL,$start = NULL,$limit = NULL){
        $sql ="SELECT $data FROM $this->table";
        if (isset($where) && $where != NULL) {
            $fields = array_keys($where);
            $fields_list = implode("",$fields);
            $values = array_values($where);
            $isFields = true;
            $stringWhere = 'where';
            for ($i=0; $i < count($fields); $i++) { 
                if (!$isFields) {
                  $sql .= " and ";
                  $stringWhere = '';
                }
               $isFields = false;
               $sql .= "  ".$stringWhere." ".$fields[$i]." = ? ";
            }
            if ($fields_not_in != NULL && $array_where_not_in != NULL) {
                $sql .= ' '.$this->where_not_in($fields_not_in,$array_where_not_in,true).' ';
            }
            if ($limit != NULL) {
                $sql .= " LIMIT ".$start." , ".$limit."";
            }
            if ($orderby !='' && $orderby != NULL) {
                $sql .= " ORDER BY ".$orderby."";
            }
            $query = $this->conn->prepare($sql);
            $query->execute($values);
        }
        else{
            if ($fields_not_in != NULL && $array_where_not_in != NULL) {
                $sql .= ' '.$this->where_not_in($fields_not_in,$array_where_not_in).' ';
            }
            if ($orderby !='' && $orderby != NULL) {
                $sql .= " ORDER BY ".$orderby."";
            }
            if ($limit != NULL) {
                $sql .= " LIMIT ".$start." , ".$limit."";
            }
            $query = $this->conn->prepare($sql);
            $query->execute();
        }
        return $query->fetchAll(PDO::FETCH_ASSOC);
    }
    // JOIN TABLE
    function select_array_join_table($data = '*',
        $where = NULL,
        $orderby = NULL,
        $start = NULL,
        $limit = NULL,
        $table_join = NULL,
        $query_join = NULL,
        $type_join  = NULL
        ){
        $sql ="SELECT $data FROM $this->table";
        if (isset($where) && $where != NULL) {
            $fields = array_keys($where);
            $fields_list = implode("",$fields);
            $values = array_values($where);
            $isFields = true;
            if ($table_join != NULL && $query_join != NULL && $type_join != NULL) {
                $sql .= ' '.$this->join_table($table_join,$query_join,$type_join).' ';
            }
            $stringWhere = 'where';
            for ($i=0; $i < count($fields); $i++) { 
                if (!$isFields) {
                  $sql .= " and ";
                  $stringWhere = '';
                }
               $isFields = false;
               $sql .= "  ".$stringWhere." ".$fields[$i]." = ? ";
            }
            if ($limit != NULL) {
                $sql .= " LIMIT ".$start." , ".$limit."";
            }
            if ($orderby !='' && $orderby != NULL) {
                $sql .= " ORDER BY ".$orderby."";
            }
            $query = $this->conn->prepare($sql);
            $query->execute($values);
        }
        else{
            if ($table_join != NULL && $query_join != NULL && $type_join != NULL) {
                $sql .= ' '.$this->join_table($table_join,$query_join,$type_join).' ';
            }
            if ($orderby !='' && $orderby != NULL) {
                $sql .= " ORDER BY ".$orderby."";
            }
            if ($limit != NULL) {
                $sql .= " LIMIT ".$start." , ".$limit."";
            }
            $query = $this->conn->prepare($sql);
            $query->execute();
        }
        return $query->fetchAll(PDO::FETCH_ASSOC);
    }
    function addMultiple($data){
        if ($data != NULL){
                $fields = array_keys($data[0]);
                $fields_list = implode(",",$fields);
                $qr = str_repeat("?,", count($fields) - 1);
                $sql = "INSERT INTO `".$this->table."` (".$fields_list.") VALUES";
                $values = [];
                foreach($data as $key => $val){
                    $fields_for = array_keys($val);
                    $fields_list_for = implode(",",$fields_for);
                    $qr_for = str_repeat("?,", count($fields_for) - 1);
                    if (count($data) - 1 > $key) {
                        $sql .= " (${qr_for}?),";
                    }
                    else
                    {
                        $sql .= " (${qr_for}?) ";
                    }
                    $values = array_merge($values, array_values($val));
                }
        
                $query = $this->conn->prepare($sql);
                if ($query->execute($values)) {
                    return 
                    array(
                        'type'      => 'sucessFully',
                        'Message'   => 'Insert data sucessfully',
                    );
                }
                else{
                    return 
                    array(
                        'type'      => 'fail',
                        'Message'   => 'Insert data fail',
                    );
                }
        }
    }
     function select_array_join_multi_table($data = '*',
        $where = NULL,
        $orderby = NULL,
        $start = NULL,
        $limit = NULL,
        $joinTable = []
        ){
      
        $sql ="SELECT $data FROM $this->table";
        if (isset($where) && $where != NULL) {
            $fields = array_keys($where);
            $fields_list = implode("",$fields);
            $values = array_values($where);
            $isFields = true;
            foreach ($joinTable as $key => $value) {
               $sql .= ' '.$this->join_table(trim($value[0]),trim($value[1]),trim($value[2])).' ';
            }
           
            $stringWhere = 'where';
            for ($i=0; $i < count($fields); $i++) { 
                if (!$isFields) {
                  $sql .= " and ";
                  $stringWhere = '';
                }
               $isFields = false;
               $sql .= "  ".$stringWhere." ".$fields[$i]." = ? ";
            }
            if ($limit != NULL) {
                $sql .= " LIMIT ".$start." , ".$limit."";
            }
            if ($orderby !='' && $orderby != NULL) {
                $sql .= " ORDER BY ".$orderby."";
            }
            $query = $this->conn->prepare($sql);
            $query->execute($values);
        }
        else{
             foreach ($joinTable as $key => $value) {
               $sql .= ' '.$this->join_table(trim($value[0]),trim($value[1]),trim($value[2])).' ';
            }
            if ($orderby !='' && $orderby != NULL) {
                $sql .= " ORDER BY ".$orderby."";
            }
            if ($limit != NULL) {
                $sql .= " LIMIT ".$start." , ".$limit."";
            }
            $query = $this->conn->prepare($sql);
            $query->execute();
        }
        return $query->fetchAll(PDO::FETCH_ASSOC);
    }
}