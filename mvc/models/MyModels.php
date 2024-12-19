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
        $sql = "SELECT $data FROM $this->table";
        
        $values = [];
        $conditions = [];

        // Xử lý điều kiện WHERE
        if ($where != NULL) {
            foreach ($where as $field => $value) {
                preg_match('/<=|>=|<|>|!=/', $field, $matches, PREG_OFFSET_CAPTURE);
                $operator = '=';
                if ($matches) {
                    $operator = $matches[0][0];
                    $field = preg_replace('/<=|>=|<|>|!=/', '', $field);
                }
                $conditions[] = "$field $operator ?";
                $values[] = $value;
            }
        }

        // Xử lý điều kiện IN
        if ($fields_in != NULL && $array_where_in != NULL) {
            $conditions[] = $this->where_in($fields_in, $array_where_in, true);
        }

        // Xử lý điều kiện NOT IN
        if ($fields_not_in != NULL && $array_where_not_in != NULL) {
            $conditions[] = $this->where_not_in($fields_not_in, $array_where_not_in, true);
        }

        // Kết hợp các điều kiện
        if ($conditions) {
            $sql .= ' WHERE ' . implode(' AND ', $conditions);
        }

        // Xử lý sắp xếp
        if ($orderby != NULL) {
            $sql .= " ORDER BY $orderby";
        }

        // Xử lý giới hạn 
        if ($limit !== NULL) { 
            if ($start !== NULL && $start >= 0) 
            { 
                $sql .= " LIMIT $start, $limit"; 
            } else {
                 $sql .= " LIMIT $limit"; 
            } 
        }

        // Chuẩn bị và thực thi truy vấn
        $query = $this->conn->prepare($sql);
        $query->execute($values);

        return $query->fetchAll(PDO::FETCH_ASSOC);
    }
    function add($data = NULL){
        $fields = array_keys($data);
        $fields_list = implode(",",$fields);
        $values = array_values($data);
        $qr = str_repeat("?,", count($fields) - 1) . "?"; 
        $sql = "INSERT INTO `".$this->table."`(".$fields_list.") VALUES ($qr)";
        $query = $this->conn->prepare($sql);
        if ($query->execute($values)) {
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
        $sql = "DELETE FROM $this->table ";
        if ($where != NULL) {
            $where_array = array_keys($where);
            $value_where = array_values($where);
            $isFields_where = true;
            $stringWhere = 'where';
            $string_Caculator = '=';
    
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
                $sql .= " ".$stringWhere." ".preg_replace('/<=|>=|<|>/','',$where_array[$i])." ".$string_Caculator." ?";
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

    public function search_array($data = '*', 
    $searchFields = [], 
    $searchTerm = '', 
    $orderby = NULL, 
    $start = NULL, 
    $limit = NULL) {
        $sql = "SELECT $data FROM $this->table";
        $values = [];
    
        if (!empty($searchTerm) && !empty($searchFields)) {
            $conditions = [];
            foreach ($searchFields as $field) {
                $conditions[] = "$field LIKE ?";
                $values[] = '%' . $searchTerm . '%';  
            }
            
            $sql .= " WHERE " . implode(' OR ', $conditions);
        }
    
        if ($orderby != NULL) {
            $sql .= " ORDER BY $orderby";
        }
        if ($limit != NULL) {
            $sql .= " LIMIT $start, $limit";
        }
    
        $query = $this->conn->prepare($sql); 
        $query->execute($values);
        return $query->fetchAll(PDO::FETCH_ASSOC);
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

    function search_array_join_table(
        $data = '*',
        $search_fields = [], 
        $search_value = '', 
        $where = NULL,
        $orderby = NULL,
        $start = NULL,
        $limit = NULL,
        $table_join = NULL,
        $query_join = NULL,
        $type_join = NULL
    ) {
        $sql = "SELECT $data FROM $this->table";
    
        // Thêm JOIN nếu có
        if ($table_join != NULL && $query_join != NULL && $type_join != NULL) {
            $sql .= ' ' . $this->join_table($table_join, $query_join, $type_join) . ' ';
        }
    
        $conditions = [];
        $values = [];
    
        // Nếu có điều kiện `WHERE`
        if ($where != NULL) {
            foreach ($where as $field => $value) {
                // Thêm tiền tố bảng vào cột
                $conditions[] = "{$this->table}.$field = ?";
                $values[] = $value;
            }
        }
    
        // Thêm điều kiện tìm kiếm với tên bảng khác (ví dụ: tours.name)
        if (!empty($search_fields) && $search_value !== '') {
            $search_conditions = [];
            foreach ($search_fields as $field) {
                // Kiểm tra xem cột tìm kiếm có thuộc bảng khác không (ví dụ tours.name)
                if (strpos($field, '.') !== false) {
                    // Nếu có, giữ nguyên tên bảng và cột (e.g., tours.name)
                    $search_conditions[] = "$field LIKE ?";
                } else {
                    // Nếu không, mặc định tìm kiếm trong bảng chính
                    $search_conditions[] = "{$this->table}.$field LIKE ?";
                }
                $values[] = "%$search_value%";
            }
            // Kết hợp các điều kiện tìm kiếm bằng OR
            $conditions[] = '(' . implode(' OR ', $search_conditions) . ')';
        }
    
        // Kết hợp các điều kiện WHERE
        if (!empty($conditions)) {
            $sql .= " WHERE " . implode(' AND ', $conditions);
        }
    
        // Thêm ORDER BY nếu có
        if ($orderby != '' && $orderby != NULL) {
            $sql .= " ORDER BY $orderby";
        }
    
        // Thêm LIMIT nếu có (phân trang)
        if ($limit != NULL) {
            $sql .= " LIMIT $start, $limit";
        }
    
        // Chuẩn bị và thực thi câu lệnh
        $query = $this->conn->prepare($sql);
        $query->execute($values);
    
        return $query->fetchAll(PDO::FETCH_ASSOC);
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