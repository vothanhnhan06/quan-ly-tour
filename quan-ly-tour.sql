CREATE DATABASE vietcharm;
USE vietcharm;
--Khách hàng khi muốn mua hàng => phải đăng ký tài khoản => bảng users
CREATE TABLE users(
    id INT PRIMARY KEY AUTO_INCREMENT,
    fullname VARCHAR(100) DEFAULT '',
    phone_number VARCHAR(10) NOT NULL,
    email VARCHAR(100) DEFAULT '',
    password VARCHAR(100) NOT NULL DEFAULT '',
    activeToken VARCHAR(100) NOT NULL DEFAULT '',
    forgotToken VARCHAR(100) NOT NULL DEFAULT '',
    created_at DATETIME,
    updated_at DATETIME,
    status TINYINT(1) DEFAULT 0,
    role_id INT,
);

--Bảng phân loại user (Role) => customer 0 , admin 1, employee 2, manager 3
CREATE TABLE roles(
    id INT PRIMARY KEY,
    position VARCHAR(20) NOT NULL 
);
ALTER TABLE users ADD FOREIGN KEY (role_id) REFERENCES roles (id);

CREATE TABLE tokenlogin(
    id int PRIMARY KEY AUTO_INCREMENT,
    token varchar(255) UNIQUE NOT NULL,
    user_id int,
    FOREIGN KEY (user_id) REFERENCES users(id)
);

--Bảng danh mục tour (Category)
CREATE TABLE categories(
    id INT PRIMARY KEY AUTO_INCREMENT,
    name varchar(100) NOT NULL DEFAULT '' COMMENT 'Tên danh mục: Miền Nam, Miền Bắc, Miền Trung'
);

--Bảng chứa thông tin cơ bản của tour/combo
CREATE TABLE tours (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(350) COMMENT 'Tên tour',
    price FLOAT NOT NULL CHECK (price >= 0),
    destination VARCHAR(200) DEFAULT '',
    pick_up VARCHAR(200) DEFAULT '',
    duration VARCHAR(100) CHECK,
    itinerary VARCHAR(300),
    date_start DATETIME NOT NULL,
    thumbnail VARCHAR(300) DEFAULT '' COMMENT 'Ảnh preview tour/combo',
    description LONGTEXT DEFAULT '',
    created_at DATETIME,
    updated_at DATETIME,
    category_id INT,
    FOREIGN KEY (category_id) REFERENCES categories(id)
);

--Bảng lưu ảnh của tour/combo
CREATE TABLE tour_images (
    id INT PRIMARY KEY AUTO_INCREMENT,
    tour_id INT,
    FOREIGN KEY (tour_id) REFERENCES tours(id),
    CONSTRAINT fk_product_images_tour_id 
                FOREIGN KEY (tour_id) 
                REFERENCES tours(id) ON DELETE CASCADE,
    image_url VARCHAR(300) 
);

--Các bảng về dịch vụ khác(Services)
CREATE TABLE service_categories(
    id INT PRIMARY KEY AUTO_INCREMENT,
    name varchar(100) NOT NULL 
);

CREATE TABLE services(
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    price FLOAT NOT NULL CHECK (price >= 0),
    service_category_id INT,
    FOREIGN KEY (service_category_id) REFERENCES service_categories(id)
)

--Đặt tour - orders
CREATE TABLE orders(
    id INT PRIMARY KEY AUTO_INCREMENT,
    user_id int,
    FOREIGN KEY (user_id) REFERENCES users(id),
    fullname VARCHAR(100) DEFAULT '',
    gender ENUM('Male', 'Female', 'Other') NOT NULL
    birthday DATETIME,
    email VARCHAR(100) DEFAULT '',
    phone_number VARCHAR(20) NOT NULL,
    address VARCHAR(200) NOT NULL,
    number_of_adults INT NOT NULL,
    number_of_children INT NOT NULL,
    order_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    status ENUM('pending', 'completed', 'cancelled'),
    total_money FLOAT CHECK(total_money >= 0),
    --xóa 1 đơn hàng => xóa mềm => thêm trường active
    active TINYINT(1) DEFAULT 1
);

CREATE TABLE order_details(
    id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT,
    FOREIGN KEY (order_id) REFERENCES orders (id),
    tour_id INT,
    FOREIGN KEY (tour_id) REFERENCES tour(id),
    tour_price FLOAT CHECK(price >= 0),
    service_id INT,
    FOREIGN KEY (service_id) REFERENCES services(id),
    service_price FLOAT CHECK(price >= 0),
    number_of_service INT CHECK(number_of_products > 0),
    total_money_service FLOAT CHECK(total_money >= 0),
);

--Bảng chứa thông tin đánh giá của khách hàng
CREATE TABLE reviews(
    id INT PRIMARY KEY AUTO_INCREMENT,
    user_id int,
    FOREIGN KEY (user_id) REFERENCES users(id),
    tour_id INT,
    FOREIGN KEY (tour_id) REFERENCES tours(id),
    rating INT CHECK(rating >= 0 AND rating <= 5),
    note LONGTEXT DEFAULT '',
)