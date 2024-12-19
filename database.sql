CREATE DATABASE vietcharm; 
USE vietcharm;
--Tạo trước trong phpMyAdmin, ko ghi 2 dòng trên

--Bảng thông tin người dùng (User)
CREATE TABLE users(
    id INT PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(100) DEFAULT '',
    avatar_url VARCHAR(300) DEFAULT 'public/uploads/images/user/avt-default.png',
    fullname VARCHAR(100) DEFAULT '',
    phone_number VARCHAR(10) NOT NULL,
    email VARCHAR(100) DEFAULT '',
    password VARCHAR(100) NOT NULL DEFAULT '',
    activeToken VARCHAR(100) NOT NULL DEFAULT '',
    forgotToken VARCHAR(100) NOT NULL DEFAULT '',
    created_at DATETIME,
    updated_at DATETIME,
    status TINYINT(1) DEFAULT 0,
    role_id INT
);

--Bảng phân loại user (Role) => customer 0, admin 1, employee 2, manager 3
CREATE TABLE roles(
    id INT PRIMARY KEY,
    position VARCHAR(20) NOT NULL 
);

ALTER TABLE users ADD FOREIGN KEY (role_id) REFERENCES roles (id);
INSERT INTO roles (id, position) VALUES (1, 'CUSTOMER'), (2, 'ADMIN'), (3, 'EMPLOYEE'), (4,'MANAGER');

--Tạo sẵn tài khoản admin - employee - manager (đối với khách hàng -> tự thao tác)
-- admin - psswd: admin123 
-- employee - psswd: employee123
-- managerN - psswd: managerN123
-- managerT - psswd: managerT123
-- managerB - psswd: managerB123
INSERT INTO users (fullname, phone_number, email, password, activeToken, forgotToken, created_at, updated_at, status, role_id, username, avatar_url) VALUES
('Admin', '0357151521', 'admin@gmail.com', '$2y$10$K75zlRmNEejqMx1/lyt4heniBt860lwLxuaFU7bjs1SLm29pknUAq', '', '', '2024-12-13 15:24:17', NULL, 1, 2, 'Admin', 'public/uploads/images/user/avt-default.png'),
('Employee', '0832847284', 'employee@gmail.com', '$2y$10$pSbKaXQ50/1cxBZtfHMfGOIHtKBWthpgKzLgXov4Rq5K60nVSAB4C', '', '', '2024-12-13 15:30:37', NULL, 1, 3, 'Employee', 'public/uploads/images/user/avt-default.png'),
('Manager Miền Nam', '0473847284', 'managerN@gmail.com', '$2y$10$mtMZX0fHAOfhSh3DkzGRxulflXJ9quwD3aNdvC3hQOrwWbC5gb.i2', '', '', '2024-12-13 15:31:53', NULL, 1, 4, 'ManagerN', 'public/uploads/images/user/avt-default.png'),
('Manager Miền Trung', '0836837363', 'managerT@gmail.com', '$2y$10$2qnx96ijy7RDscjFRzFNwOsNp/Tt4/85qQFQ3bQBe.wYjdcNMLHCm', '', '', '2024-12-13 15:32:56', NULL, 1, 4, 'ManagerT', 'public/uploads/images/user/avt-default.png'),
('Manager Miền Bắc', '0758374829', 'managerB@gmail.com', '$2y$10$JsPN/4/Xm9EmSI9S2r5SJuwioso1OXgRFyoZsGltuZb0UXwJ5JUD2', '', '', '2024-12-13 15:33:36', NULL, 1, 4, 'ManagerB', 'public/uploads/images/user/avt-default.png');

--Khách hàng sẵn để có đơn đặt tour 
INSERT INTO users (fullname, phone_number, email, password, activeToken, forgotToken, created_at, updated_at, status, role_id, username, avatar_url) 
VALUES
('Trần Minh Hòa', '0971234567', 'hoa.tran@gmail.com', '$2y$10$abcdEFghIjklmnopQRStuvWxYz1234567890abcdefgHIJKLmnoPQRStuv', '', '', '2024-12-14 09:00:00', NULL, 1, 1, 'tranminhhoa', 'public/uploads/images/user/avavt-default.png'),
('Nguyễn Thị Lan', '0912345678', 'lan.nguyen@gmail.com', '$2y$10$abcdEFghIjklmnopQRStuvWxYz1234567890abcdefgHIJKLmnoPQRStuv', '', '', '2024-12-14 09:15:00', NULL, 1, 1, 'nguyenthilan', 'public/uploads/images/user/avt-default.png'),
('Lê Hoàng Anh', '0934567890', 'hoanganh.le@gmail.com', '$2y$10$abcdEFghIjklmnopQRStuvWxYz1234567890abcdefgHIJKLmnoPQRStuv', '', '', '2024-12-14 09:30:00', NULL, 1, 1, 'lehoanganh', 'public/uploads/images/user/avt-default.png'),
('Phạm Văn Đức', '0945678901', 'duc.pham@gmail.com', '$2y$10$abcdEFghIjklmnopQRStuvWxYz1234567890abcdefgHIJKLmnoPQRStuv', '', '', '2024-12-14 09:45:00', NULL, 1, 1, 'phamvanduc', 'public/uploads/images/user/avt-default.png'),
('Đỗ Thị Hương', '0966789012', 'huong.do@gmail.com', '$2y$10$abcdEFghIjklmnopQRStuvWxYz1234567890abcdefgHIJKLmnoPQRStuv', '', '', '2024-12-14 10:00:00', NULL, 1, 1, 'dothihuong', 'public/uploads/images/user/avt-default.png'),
('Ngô Đức Thịnh', '0987890123', 'thinh.ngo@gmail.com', '$2y$10$abcdEFghIjklmnopQRStuvWxYz1234567890abcdefgHIJKLmnoPQRStuv', '', '', '2024-12-14 10:15:00', NULL, 1, 1, 'ngoducthinh', 'public/uploads/images/user/avt-default.png'),
('Vũ Hải Yến', '0928901234', 'yen.vu@gmail.com', '$2y$10$abcdEFghIjklmnopQRStuvWxYz1234567890abcdefgHIJKLmnoPQRStuv', '', '', '2024-12-14 10:30:00', NULL, 1, 1, 'vuhaien', 'public/uploads/images/user/avt-default.png'),
('Phan Anh Tú', '0939012345', 'tu.phan@gmail.com', '$2y$10$abcdEFghIjklmnopQRStuvWxYz1234567890abcdefgHIJKLmnoPQRStuv', '', '', '2024-12-14 10:45:00', NULL, 1, 1, 'phananhtu', 'public/uploads/images/user/avt-default.png'),
('Bùi Minh Ngọc', '0950123456', 'ngoc.bui@gmail.com', '$2y$10$abcdEFghIjklmnopQRStuvWxYz1234567890abcdefgHIJKLmnoPQRStuv', '', '', '2024-12-14 11:00:00', NULL, 1, 1, 'buiminhngoc', 'public/uploads/images/user/avt-default.png'),
('Trịnh Thùy Linh', '0971234568', 'linh.trinh@gmail.com', '$2y$10$abcdEFghIjklmnopQRStuvWxYz1234567890abcdefgHIJKLmnoPQRStuv', '', '', '2024-12-14 11:15:00', NULL, 1, 1, 'trinhthuylinh', 'public/uploads/images/user/avt-default.png');

--Bảng lưu token đăng nhập (TokenLogin)
CREATE TABLE tokenlogin(
    id int PRIMARY KEY AUTO_INCREMENT,
    token varchar(255) UNIQUE NOT NULL,
    user_id int,
    FOREIGN KEY (user_id) REFERENCES users(id),
    created_at DATETIME
);

--Bảng danh mục tour (Category)
CREATE TABLE categories(
    id INT PRIMARY KEY AUTO_INCREMENT,
    name varchar(100) NOT NULL DEFAULT '' COMMENT 'Tên danh mục: Miền Nam, Miền Bắc, Miền Trung'
);

INSERT INTO categories (id, name) VALUES (1, 'Miền Nam'), (2, 'Miền Bắc'), (3, 'Miền Trung'), (4, 'Đặc biệt');

--Bảng chứa thông tin cơ bản của tour/combo
CREATE TABLE tours (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(350) COMMENT 'Tên tour',
    price FLOAT NOT NULL CHECK (price >= 0),
    destination VARCHAR(200) DEFAULT '',
    pick_up VARCHAR(200) DEFAULT '',
    duration VARCHAR(100),
    itinerary VARCHAR(300), -- có thể bỏ cột hành trình này ở chỗ ngày 1 2 3 nếu ko xử lý logic được thì để mặc định
    date_start DATETIME NOT NULL,
    thumbnail VARCHAR(300) DEFAULT '' COMMENT 'Ảnh preview tour/combo',
    description LONGTEXT DEFAULT '', -- có thẻ bỏ cột này ở chỗ ăn uống, đối tượng,... nếu ko xử lý logic được thì để mặc định
    created_at DATETIME,
    updated_at DATETIME,
    category_id INT,
    FOREIGN KEY (category_id) REFERENCES categories(id)
);

--Bảng lưu ảnh của tour/combo
--Nếu như sử dụng 1 ảnh trong chi tiết thì ko cần sử dụng bảng này -> sẽ xoá sau
CREATE TABLE tour_images (
    id INT PRIMARY KEY AUTO_INCREMENT,
    tour_id INT,
    FOREIGN KEY (tour_id) REFERENCES tours(id),
    CONSTRAINT fk_images_tour_id 
                FOREIGN KEY (tour_id) 
                REFERENCES tours(id) ON DELETE CASCADE,
    image_url VARCHAR(300) 
);

-- để load hình ảnh lên -> định dạng /tenweb/urltrongcsdl vd: /vietcharm/public/uploads/images/tours/mui-ne.jpg
--Tour miền Nam
INSERT INTO tours (name, price, destination, pick_up, duration, itinerary, date_start, thumbnail, description, created_at, updated_at, category_id)
VALUES
    ('Mũi Né: Khám phá Bãi Rạng - Đồi Cát Bay', 2500000, 'Mũi Né', 'Hồ Chí Minh', '2 Ngày 1 Đêm', 
     'Ngày 1: Hồ Chí Minh - Mũi Né, ăn trưa tại nhà hàng, tham quan Bãi Rạng, Đồi Cát Bay; 
     Ngày 2: Ăn sáng tại khách sạn, tham quan các địa danh khác, ăn trưa tại nhà hàng, trở về Hồ Chí Minh, ăn tối tại nhà hàng.',
     '2024-01-10 07:00:00', 'public/uploads/images/tours/mui-ne.jpg', 
     'Ẩm thực: Đặc sản biển, Bánh canh; Đối tượng thích hợp: Gia đình, Cặp đôi, Bạn bè; Thời gian lý tưởng: Mùa hè; Khuyến mãi: Giảm 15% cho nhóm từ 4 người trở lên.',
     '2024-12-13 08:00:00', NULL, 1),

    ('Phú Quốc: Khám phá Đảo Ngọc', 3500000, 'Phú Quốc', 'Hồ Chí Minh', '3 Ngày 2 Đêm', 
     'Ngày 1: Hồ Chí Minh - Phú Quốc, ăn trưa tại nhà hàng, tham quan Dinh Cậu, Bãi Sao; 
     Ngày 2: Tham quan Vinpearl Safari, ăn trưa tại nhà hàng, tham quan các đảo nhỏ; 
     Ngày 3: Ăn sáng tại khách sạn, tham quan và ăn trưa tại nhà hàng, trở về Hồ Chí Minh, ăn tối tại nhà hàng.',
     '2024-01-12 06:00:00', 'public/uploads/images/tours/phu-quoc.jpg', 
     'Ẩm thực: Hải sản tươi ngon, Đặc sản Phú Quốc; Đối tượng thích hợp: Gia đình, Cặp đôi, Du khách khám phá thiên nhiên; Thời gian lý tưởng: Mùa hè; Khuyến mãi: Giảm 20% cho khách đặt trước.',
     '2024-12-13 09:30:00', NULL, 1),

    ('Vũng Tàu: Tham quan Bãi Trước - Bãi Sau', 1500000, 'Vũng Tàu', 'Hồ Chí Minh', '1 Ngày', 
     'Buổi sáng: Hồ Chí Minh - Vũng Tàu, ăn trưa tại nhà hàng; Buổi chiều: Tham quan Bãi Trước, Bãi Sau, ăn tối tại nhà hàng và trở về Hồ Chí Minh.',
     '2024-01-15 07:30:00', 'public/uploads/images/tours/vung-tau.jpg', 
     'Ẩm thực: Hải sản tươi sống, Món ăn miền biển; Đối tượng thích hợp: Gia đình, Bạn bè; Thời gian lý tưởng: Mùa hè; Khuyến mãi: Giảm 10% cho nhóm từ 5 người trở lên.',
     '2024-12-13 10:15:00', NULL, 1),

    ('Cần Thơ: Chợ Nổi - Làng Du Lịch Mỹ Khánh', 2000000, 'Cần Thơ', 'Hồ Chí Minh', '2 Ngày 1 Đêm', 
     'Ngày 1: Hồ Chí Minh - Cần Thơ, ăn trưa tại nhà hàng, tham quan chợ nổi Cái Răng, Làng Du Lịch Mỹ Khánh; 
     Ngày 2: Ăn sáng tại khách sạn, tham quan các địa danh khác, ăn trưa tại nhà hàng, trở về Hồ Chí Minh, ăn tối tại nhà hàng.',
     '2024-01-18 06:30:00', 'public/uploads/images/tours/can-tho.jpg', 
     'Ẩm thực: Đặc sản miền Tây, Món ăn từ cá, tôm; Đối tượng thích hợp: Gia đình, Bạn bè, Du khách yêu thích thiên nhiên; Thời gian lý tưởng: Mùa xuân và mùa hè; Khuyến mãi: Giảm 15% cho khách đặt trước.',
     '2024-12-13 11:00:00', NULL, 1),

    ('Đà Lạt: Hồ Xuân Hương - Thác Datanla', 2800000, 'Đà Lạt', 'Hồ Chí Minh', '2 Ngày 1 Đêm', 
     'Ngày 1: Hồ Chí Minh - Đà Lạt, ăn trưa tại nhà hàng, tham quan Hồ Xuân Hương, Thác Datanla; 
     Ngày 2: Ăn sáng tại khách sạn, tham quan các điểm du lịch khác, ăn trưa tại nhà hàng, trở về Hồ Chí Minh, ăn tối tại nhà hàng.',
     '2024-01-25 07:00:00', 'public/uploads/images/tours/da-lat.jpg', 
     'Ẩm thực: Đặc sản Đà Lạt, Mứt dâu, Bánh tráng nướng; Đối tượng thích hợp: Gia đình, Cặp đôi, Bạn bè; Thời gian lý tưởng: Mùa xuân và mùa thu; Khuyến mãi: Giảm 10% cho nhóm từ 4 người trở lên.',
     '2024-12-13 12:30:00', NULL, 1),

    ('Tây Ninh: Núi Bà Đen - Chùa Linh Sơn', 1200000, 'Tây Ninh', 'Hồ Chí Minh', '1 Ngày', 
     'Buổi sáng: Hồ Chí Minh - Tây Ninh, ăn trưa tại nhà hàng, tham quan Núi Bà Đen, Chùa Linh Sơn; 
     Buổi chiều: Tham quan các điểm du lịch, ăn tối tại nhà hàng và trở về Hồ Chí Minh.',
     '2024-02-05 06:00:00', 'public/uploads/images/tours/tay-ninh.jpg', 
     'Ẩm thực: Đặc sản miền Đông Nam Bộ, Các món từ thịt bò; Đối tượng thích hợp: Gia đình, Bạn bè, Du khách yêu thích văn hóa; Thời gian lý tưởng: Mùa xuân và mùa hè; Khuyến mãi: Giảm 10% cho nhóm từ 5 người.',
     '2024-12-13 14:30:00', NULL, 1),

    ('Bến Tre: Vườn Dừa - Chùa Vĩnh Tràng', 1800000, 'Bến Tre', 'Hồ Chí Minh', '2 Ngày 1 Đêm', 
     'Ngày 1: Hồ Chí Minh - Bến Tre, ăn trưa tại nhà hàng, tham quan vườn dừa, Chùa Vĩnh Tràng; 
     Ngày 2: Ăn sáng tại khách sạn, tham quan các điểm du lịch khác, ăn trưa tại nhà hàng, trở về Hồ Chí Minh, ăn tối tại nhà hàng.',
     '2024-02-10 07:30:00', 'public/uploads/images/tours/ben-tre.jpg', 
     'Ẩm thực: Món ăn từ dừa, đặc sản miền Tây; Đối tượng thích hợp: Gia đình, Bạn bè; Thời gian lý tưởng: Mùa xuân và mùa hè; Khuyến mãi: Giảm 5% cho khách đăng ký trước 30 ngày.',
     '2024-12-13 15:00:00', NULL, 1),

    ('Cà Mau: Mũi Cà Mau - Rừng U Minh', 2200000, 'Cà Mau', 'Hồ Chí Minh', '2 Ngày 1 Đêm', 
     'Ngày 1: Hồ Chí Minh - Cà Mau, ăn trưa tại nhà hàng, tham quan Mũi Cà Mau, Rừng U Minh; 
     Ngày 2: Ăn sáng tại khách sạn, tham quan các điểm du lịch khác, ăn trưa tại nhà hàng, trở về Hồ Chí Minh, ăn tối tại nhà hàng.',
     '2024-02-20 07:00:00', 'public/uploads/images/tours/ca-mau.jpg', 
     'Ẩm thực: Đặc sản biển, các món ăn từ cá, tôm; Đối tượng thích hợp: Gia đình, Bạn bè, Du khách yêu thích thiên nhiên; Thời gian lý tưởng: Mùa thu và mùa xuân; Khuyến mãi: Giảm 10% cho khách đăng ký trước.',
     '2024-12-13 16:00:00', NULL, 1),

    ('Rạch Giá: Khu Du Lịch Phú Quốc', 3000000, 'Rạch Giá', 'Hồ Chí Minh', '3 Ngày 2 Đêm', 
     'Ngày 1: Hồ Chí Minh - Rạch Giá, ăn trưa tại nhà hàng, tham quan Khu Du Lịch Phú Quốc; 
     Ngày 2: Tham quan các điểm du lịch, ăn trưa tại nhà hàng, tham quan các đảo nhỏ; 
     Ngày 3: Ăn sáng tại khách sạn, tham quan và ăn trưa tại nhà hàng, trở về Hồ Chí Minh, ăn tối tại nhà hàng.',
     '2024-02-22 06:30:00', 'public/uploads/images/tours/rach-gia.jpg', 
     'Ẩm thực: Hải sản tươi ngon, các món ăn địa phương; Đối tượng thích hợp: Gia đình, Cặp đôi, Bạn bè; Thời gian lý tưởng: Mùa hè; Khuyến mãi: Giảm 20% cho khách đăng ký trước.',
     '2024-12-13 17:00:00', NULL, 1),

    ('Long An: Đồng Tháp Mười - Chùa Vĩnh Nguyên', 1600000, 'Long An', 'Hồ Chí Minh', '2 Ngày 1 Đêm', 
     'Ngày 1: Hồ Chí Minh - Long An, ăn trưa tại nhà hàng, tham quan Đồng Tháp Mười, Chùa Vĩnh Nguyên; 
     Ngày 2: Ăn sáng tại khách sạn, tham quan các điểm du lịch, ăn trưa tại nhà hàng, trở về Hồ Chí Minh, ăn tối tại nhà hàng.',
     '2024-03-01 07:00:00', 'public/uploads/images/tours/long-an.jpg', 
     'Ẩm thực: Đặc sản miền Tây, Món ăn từ gạo, cá; Đối tượng thích hợp: Gia đình, Bạn bè, Du khách yêu thích thiên nhiên; Thời gian lý tưởng: Mùa xuân và mùa thu; Khuyến mãi: Giảm 10% cho nhóm từ 5 người.',
     '2024-12-13 18:00:00', NULL, 1),

    ('Tiền Giang: Vườn Cây - Chùa Vĩnh Tràng', 1500000, 'Tiền Giang', 'Hồ Chí Minh', '1 Ngày', 
     'Buổi sáng: Hồ Chí Minh - Tiền Giang, ăn trưa tại nhà hàng, tham quan vườn cây, Chùa Vĩnh Tràng; 
     Buổi chiều: Tham quan các điểm du lịch, ăn tối tại nhà hàng và trở về Hồ Chí Minh.',
     '2024-03-05 07:30:00', 'public/uploads/images/tours/tien-giang.jpg', 
     'Ẩm thực: Món ăn đặc sản miền Tây, các món ăn từ gạo; Đối tượng thích hợp: Gia đình, Bạn bè, Du khách yêu thích khám phá; Thời gian lý tưởng: Mùa xuân và mùa hè; Khuyến mãi: Giảm 10% cho nhóm từ 4 người.',
     '2024-12-13 19:30:00', NULL, 1);

--Tour miền Bắc
INSERT INTO tours (name, price, destination, pick_up, duration, itinerary, date_start, thumbnail, description, created_at, updated_at, category_id)
VALUES
    ('Hạ Long: Tham quan Vịnh Hạ Long', 3500000, 'Hạ Long', 'Hà Nội', '3 Ngày 2 Đêm', 
     'Ngày 1: Hà Nội - Hạ Long, ăn trưa tại nhà hàng địa phương, tham quan Vịnh Hạ Long; 
     Ngày 2: Tham quan vịnh, ăn trưa trên tàu, tiếp tục tham quan các đảo; 
     Ngày 3: Ăn sáng tại khách sạn, tham quan và ăn trưa tại nhà hàng địa phương, trở về Hà Nội, ăn tối tại nhà hàng ở Hà Nội.', 
     '2024-01-15 08:00:00', 'public/uploads/images/tours/ha-long.jpg', 
     'Ẩm thực: Buffet sáng, Theo thực đơn, Đặc sản địa phương; Đối tượng thích hợp: Cặp đôi, Gia đình nhiều thế hệ, Thanh niên; Thời gian lý tưởng: Mùa hè; Khuyến mãi: Giảm 20% cho các khách hàng đặt trước.', 
     '2024-12-13 10:00:00', NULL, 2),
    
    ('Sa Pa: Khám phá Fansipan', 2500000, 'Sa Pa', 'Hà Nội', '2 Ngày 1 Đêm', 
     'Ngày 1: Hà Nội - Sa Pa, ăn trưa tại nhà hàng địa phương, tham quan Fansipan; 
     Ngày 2: Tham quan Fansipan, ăn trưa tại nhà hàng, trở về Hà Nội, ăn tối tại nhà hàng trên đường về.', 
     '2024-01-20 06:00:00', 'public/uploads/images/tours/sapa.png', 
     'Ẩm thực: Đặc sản vùng cao; Đối tượng: Gia đình, Thanh niên; Thời gian lý tưởng: Mùa đông; Khuyến mãi: Giảm 10% cho nhóm từ 4 người trở lên.',
     '2024-12-13 10:00:00', NULL, 2),

    ('Mộc Châu: Đồi chè - thác Dải Yếm', 2200000, 'Mộc Châu', 'Hà Nội', '2 Ngày 1 Đêm', 
     'Ngày 1: Hà Nội - Mộc Châu, ăn trưa tại nhà hàng, tham quan đồi chè, thác Dải Yếm; 
     Ngày 2: Ăn sáng tại khách sạn, tham quan các bản làng, ăn trưa tại nhà hàng, trở về Hà Nội, ăn tối tại nhà hàng ở Hà Nội.',
     '2024-02-05 07:00:00', 'public/uploads/images/tours/moc-chau.jpg', 
     'Ẩm thực: Đặc sản vùng núi; Đối tượng thích hợp: Gia đình, Bạn bè; Thời gian lý tưởng: Mùa xuân và mùa thu; Khuyến mãi: Giảm giá 15% cho nhóm từ 4 người trở lên.',
     '2024-12-13 10:00:00', NULL, 2),
    
    ('Ninh Bình: Tràng An - Bái Đính', 1200000, 'Ninh Bình', 'Hà Nội', '1 Ngày', 
     'Buổi sáng: Hà Nội - Tràng An, ăn trưa tại nhà hàng; Buổi chiều: Tham quan chùa Bái Đính, ăn tối tại nhà hàng và trở về Hà Nội, ăn tối tại nhà hàng ở Hà Nội.',
     '2024-01-10 07:30:00', 'public/uploads/images/tours/ninh-binh.jpg', 
     'Ẩm thực: Món đặc sản Ninh Bình; Đối tượng thích hợp: Gia đình, Bạn bè; Thời gian lý tưởng: Mùa xuân; Khuyến mãi: Giảm 10% cho nhóm từ 5 người trở lên.',
     '2024-12-13 10:00:00', NULL, 2),
    
    ('Hà Giang: Đồng Văn - Lũng Cú', 3000000, 'Hà Giang', 'Hà Nội', '3 Ngày 2 Đêm', 
     'Ngày 1: Hà Nội - Hà Giang, ăn trưa tại nhà hàng, tham quan các địa danh; 
     Ngày 2: Tham quan Đồng Văn, ăn trưa tại nhà hàng, tham quan cột cờ Lũng Cú, ăn tối tại nhà hàng; 
     Ngày 3: Ăn sáng tại khách sạn, tham quan và ăn trưa tại nhà hàng, trở về Hà Nội, ăn tối tại nhà hàng ở Hà Nội.',
     '2024-01-22 06:00:00', 'public/uploads/images/tours/ha-giang.jpg', 
     'Ẩm thực: Đặc sản dân tộc vùng cao, như bánh cuốn, thịt trâu gác bếp; Đối tượng thích hợp: Phượt thủ, Gia đình; Thời gian lý tưởng: Mùa xuân và mùa thu; Khuyến mãi: Giảm 5% cho khách đăng ký trước 30 ngày.',
     '2024-12-13 10:00:00', NULL, 2),
    
    ('Mai Châu: Bản Làng - Thác', 1500000, 'Mai Châu', 'Hà Nội', '2 Ngày 1 Đêm', 
     'Ngày 1: Hà Nội - Mai Châu, ăn trưa tại nhà hàng, tham quan bản làng, thác; 
     Ngày 2: Ăn sáng tại khách sạn, tham quan các điểm du lịch, ăn trưa tại nhà hàng, trở về Hà Nội, ăn tối tại nhà hàng ở Hà Nội.',
     '2024-03-10 08:00:00', 'public/uploads/images/tours/mai-chau.jpg', 
     'Ẩm thực: Thực đơn đặc trưng dân tộc Thái; Đối tượng thích hợp: Cặp đôi, Gia đình; Thời gian lý tưởng: Mùa hè và mùa thu; Khuyến mãi: Giảm 10% cho khách đặt sớm.',
     '2024-12-13 10:00:00', NULL, 2),
    
    ('Tam Đảo: Chùa Tây Thiên - Thác Bạc', 1800000, 'Tam Đảo', 'Hà Nội', '1 Ngày', 
     'Buổi sáng: Hà Nội - Tam Đảo, ăn trưa tại nhà hàng; Buổi chiều: Tham quan chùa Tây Thiên, thác Bạc, ăn tối tại nhà hàng và trở về Hà Nội, ăn tối tại nhà hàng ở Hà Nội.',
     '2024-01-15 07:00:00', 'public/uploads/images/tours/tam-dao.jpeg', 
     'Ẩm thực: Món ăn đặc sản Tam Đảo; Đối tượng thích hợp: Gia đình, Bạn bè; Thời gian lý tưởng: Mùa xuân và mùa hè; Khuyến mãi: Giảm 10% cho các đoàn nhóm.',
     '2024-12-13 10:00:00', NULL, 2),
    
    ('Cát Bà: Vịnh Lan Hạ - Đảo Khỉ', 3200000, 'Cát Bà', 'Hà Nội', '3 Ngày 2 Đêm', 
     'Ngày 1: Hà Nội - Cát Bà, ăn trưa tại nhà hàng, tham quan vịnh Lan Hạ; 
     Ngày 2: Tham quan Đảo Khỉ, ăn trưa tại nhà hàng, tiếp tục tham quan các đảo; 
     Ngày 3: Ăn sáng tại khách sạn, tham quan và ăn trưa tại nhà hàng, trở về Hà Nội, ăn tối tại nhà hàng ở Hà Nội.',
     '2024-04-05 08:00:00', 'public/uploads/images/tours/cat-ba.jpg', 
     'Ẩm thực: Hải sản tươi ngon, đặc sản Cát Bà; Đối tượng thích hợp: Gia đình, Bạn bè, Cặp đôi; Thời gian lý tưởng: Mùa hè; Khuyến mãi: Giảm 10% cho các khách đặt sớm.',
     '2024-12-13 10:00:00', NULL, 2),
    
    ('Yên Bái: Ruộng Bậc Thang - Mù Cang Chải', 2700000, 'Yên Bái', 'Hà Nội', '2 Ngày 1 Đêm', 
     'Ngày 1: Hà Nội - Yên Bái, ăn trưa tại nhà hàng, tham quan ruộng bậc thang Mù Cang Chải; 
     Ngày 2: Ăn sáng tại khách sạn, tham quan các điểm du lịch, ăn trưa tại nhà hàng, trở về Hà Nội, ăn tối tại nhà hàng ở Hà Nội.',
     '2024-02-18 06:30:00', 'public/uploads/images/tours/yen-bai.jpg', 
     'Ẩm thực: Đặc sản vùng núi Tây Bắc; Đối tượng thích hợp: Phượt thủ, Gia đình; Thời gian lý tưởng: Mùa thu; Khuyến mãi: Giảm 10% cho nhóm từ 4 người trở lên.',
     '2024-12-13 10:00:00', NULL, 2),
    
    ('Hòa Bình: Suối Nước Nóng Kim Bôi', 2000000, 'Hòa Bình', 'Hà Nội', '2 Ngày 1 Đêm', 
     'Ngày 1: Hà Nội - Hòa Bình, ăn trưa tại nhà hàng, tham quan suối nước nóng Kim Bôi; 
     Ngày 2: Ăn sáng tại khách sạn, thư giãn tại suối nước nóng, ăn trưa tại nhà hàng, trở về Hà Nội, ăn tối tại nhà hàng ở Hà Nội.',
     '2024-02-25 07:00:00', 'public/uploads/images/tours/hoa-binh.jpg', 
     'Ẩm thực: Đặc sản Hòa Bình, các món ăn từ thịt trâu, cá suối; Đối tượng thích hợp: Người yêu thiên nhiên, Gia đình, Cặp đôi; Thời gian lý tưởng: Mùa xuân và mùa thu; Khuyến mãi: Giảm 20% cho các khách hàng đặt trước.',
     '2024-12-13 10:00:00', NULL, 2),
    
    ('Thái Nguyên: Bảo Tàng Trà - Đồi Chè', 1000000, 'Thái Nguyên', 'Hà Nội', '1 Ngày', 
     'Buổi sáng: Hà Nội - Thái Nguyên, ăn trưa tại nhà hàng; Buổi chiều: Tham quan Bảo tàng Trà, đồi chè, ăn tối tại nhà hàng và trở về Hà Nội, ăn tối tại nhà hàng ở Hà Nội.',
     '2024-03-12 07:00:00', 'public/uploads/images/tours/thai-nguyen.jpg', 
     'Tìm hiểu về văn hóa trà và tham quan các đồi chè; Khuyến mãi: Giảm 10% cho nhóm từ 5 người trở lên.',
     '2024-12-13 10:00:00', NULL, 2);

--Tour miền Trung
INSERT INTO tours (name, price, destination, pick_up, duration, itinerary, date_start, thumbnail, description, created_at, updated_at, category_id)
VALUES
    ('Huế: Tham quan Kinh Thành Huế', 3000000, 'Huế', 'Đà Nẵng', '2 Ngày 1 Đêm', 
     'Ngày 1: Đà Nẵng - Huế, ăn trưa tại nhà hàng, tham quan Kinh Thành Huế, Đại Nội; 
     Ngày 2: Ăn sáng tại khách sạn, tham quan chùa Thiên Mụ, ăn trưa tại nhà hàng, trở về Đà Nẵng, ăn tối tại nhà hàng.',
     '2024-02-01 08:00:00', 'public/uploads/images/tours/hue.jpg', 
     'Ẩm thực: Đặc sản Huế, Bánh bèo, Bánh cuốn; Đối tượng thích hợp: Gia đình, Cặp đôi, Du khách yêu thích lịch sử; Thời gian lý tưởng: Mùa xuân, mùa hè; Khuyến mãi: Giảm 10% cho nhóm từ 5 người.',
     '2024-12-13 09:00:00', NULL, 3),

    ('Đà Nẵng: Ngũ Hành Sơn - Bà Nà Hills', 2500000, 'Đà Nẵng', 'Hà Nội', '2 Ngày 1 Đêm', 
     'Ngày 1: Hà Nội - Đà Nẵng, ăn trưa tại nhà hàng, tham quan Ngũ Hành Sơn, Bà Nà Hills; 
     Ngày 2: Ăn sáng tại khách sạn, tham quan các điểm du lịch khác, ăn trưa tại nhà hàng, trở về Hà Nội, ăn tối tại nhà hàng.',
     '2024-02-05 07:30:00', 'public/uploads/images/tours/da-nang.png', 
     'Ẩm thực: Mì Quảng, Bánh tráng cuốn thịt heo; Đối tượng thích hợp: Gia đình, Bạn bè, Du khách thích khám phá thiên nhiên; Thời gian lý tưởng: Mùa hè, mùa thu; Khuyến mãi: Giảm 15% cho khách đặt trước.',
     '2024-12-13 10:15:00', NULL, 3),

    ('Quảng Nam: Hội An - Mỹ Sơn', 2800000, 'Quảng Nam', 'Đà Nẵng', '3 Ngày 2 Đêm', 
     'Ngày 1: Đà Nẵng - Hội An, ăn trưa tại nhà hàng, tham quan Phố cổ Hội An; 
     Ngày 2: Tham quan Thánh địa Mỹ Sơn, ăn trưa tại nhà hàng, tiếp tục tham quan các điểm du lịch khác; 
     Ngày 3: Ăn sáng tại khách sạn, tham quan và ăn trưa tại nhà hàng, trở về Đà Nẵng.',
     '2024-02-10 06:30:00', 'public/uploads/images/tours/quang-nam.jpg', 
     'Ẩm thực: Cao Lầu, Hoành Thánh, Bánh Đập; Đối tượng thích hợp: Gia đình, Cặp đôi, Du khách yêu thích văn hóa; Thời gian lý tưởng: Mùa xuân, mùa hè; Khuyến mãi: Giảm 10% cho nhóm từ 4 người.',
     '2024-12-13 11:30:00', NULL, 3),

    ('Nha Trang: Vinpearl Land - Tháp Bà Ponagar', 3500000, 'Nha Trang', 'Hà Nội', '3 Ngày 2 Đêm', 
     'Ngày 1: Hà Nội - Nha Trang, ăn trưa tại nhà hàng, tham quan Vinpearl Land, Tháp Bà Ponagar; 
     Ngày 2: Tham quan các điểm du lịch, ăn trưa tại nhà hàng, tham quan đảo Hòn Mun; 
     Ngày 3: Ăn sáng tại khách sạn, tham quan và ăn trưa tại nhà hàng, trở về Hà Nội.',
     '2024-02-15 07:00:00', 'public/uploads/images/tours/nha-trang.jpg', 
     'Ẩm thực: Hải sản tươi ngon, Món ăn đặc trưng Nha Trang; Đối tượng thích hợp: Gia đình, Cặp đôi, Bạn bè; Thời gian lý tưởng: Mùa hè; Khuyến mãi: Giảm 20% cho khách đặt trước.',
     '2024-12-13 12:00:00', NULL, 3),

    ('Quảng Bình: Phong Nha - Kẻ Bàng', 3200000, 'Quảng Bình', 'Hà Nội', '3 Ngày 2 Đêm', 
     'Ngày 1: Hà Nội - Quảng Bình, ăn trưa tại nhà hàng, tham quan Động Phong Nha; 
     Ngày 2: Tham quan Động Sơn Đoòng, ăn trưa tại nhà hàng, tham quan Vườn Quốc Gia Phong Nha-Kẻ Bàng; 
     Ngày 3: Ăn sáng tại khách sạn, tham quan các điểm du lịch, ăn trưa tại nhà hàng, trở về Hà Nội.',
     '2024-02-20 06:45:00', 'public/uploads/images/tours/quang-binh.jpeg', 
     'Ẩm thực: Món ăn Quảng Bình, Hải sản tươi ngon; Đối tượng thích hợp: Gia đình, Bạn bè, Du khách yêu thích thiên nhiên; Thời gian lý tưởng: Mùa xuân, mùa thu; Khuyến mãi: Giảm 15% cho khách đăng ký trước.',
     '2024-12-13 13:15:00', NULL, 3),

    ('Quảng Trị: Cửa Tùng - Hồ Con Rùa', 2200000, 'Quảng Trị', 'Đà Nẵng', '2 Ngày 1 Đêm', 
     'Ngày 1: Đà Nẵng - Quảng Trị, ăn trưa tại nhà hàng, tham quan Cửa Tùng, Hồ Con Rùa; 
     Ngày 2: Ăn sáng tại khách sạn, tham quan các điểm du lịch khác, ăn trưa tại nhà hàng, trở về Đà Nẵng.',
     '2024-02-25 08:00:00', 'public/uploads/images/tours/quang-tri.jpg', 
     'Ẩm thực: Đặc sản Quảng Trị, Món ăn dân dã miền Trung; Đối tượng thích hợp: Gia đình, Bạn bè, Du khách yêu thích lịch sử; Thời gian lý tưởng: Mùa xuân, mùa thu; Khuyến mãi: Giảm 10% cho nhóm từ 3 người.',
     '2024-12-13 14:00:00', NULL, 3),

    ('Bình Định: Kỳ Co - Eo Gió', 2400000, 'Bình Định', 'Đà Nẵng', '2 Ngày 1 Đêm', 
     'Ngày 1: Đà Nẵng - Bình Định, ăn trưa tại nhà hàng, tham quan Kỳ Co, Eo Gió; 
     Ngày 2: Ăn sáng tại khách sạn, tham quan các điểm du lịch khác, ăn trưa tại nhà hàng, trở về Đà Nẵng.',
     '2024-03-01 06:30:00', 'public/uploads/images/tours/binh-dinh.jpg', 
     'Ẩm thực: Bánh xèo, Mỳ Quảng, Hải sản tươi sống; Đối tượng thích hợp: Gia đình, Cặp đôi, Bạn bè; Thời gian lý tưởng: Mùa hè; Khuyến mãi: Giảm 15% cho khách đặt nhóm.',
     '2024-12-13 15:00:00', NULL, 3),

    ('Kon Tum: Rừng Tràm - Đồi Chè', 2600000, 'Kon Tum', 'Đà Nẵng', '3 Ngày 2 Đêm', 
     'Ngày 1: Đà Nẵng - Kon Tum, ăn trưa tại nhà hàng, tham quan Rừng Tràm; 
     Ngày 2: Tham quan Đồi Chè, tham quan các làng dân tộc; 
     Ngày 3: Ăn sáng tại khách sạn, tham quan các điểm du lịch khác, ăn trưa tại nhà hàng, trở về Đà Nẵng.',
     '2024-03-05 07:15:00', 'public/uploads/images/tours/kon-tum.jpg', 
     'Ẩm thực: Món ăn miền Tây, Đặc sản Kon Tum; Đối tượng thích hợp: Gia đình, Du khách yêu thích khám phá thiên nhiên; Thời gian lý tưởng: Mùa thu, mùa xuân; Khuyến mãi: Giảm 10% cho nhóm từ 4 người.',
     '2024-12-13 16:00:00', NULL, 3),

    ('Thanh Hóa: Sầm Sơn - Cửa Lò', 2700000, 'Thanh Hóa', 'Hà Nội', '3 Ngày 2 Đêm', 
     'Ngày 1: Hà Nội - Thanh Hóa, ăn trưa tại nhà hàng, tham quan Sầm Sơn, biển Cửa Lò; 
     Ngày 2: Tham quan các điểm du lịch, ăn trưa tại nhà hàng, tiếp tục tham quan biển; 
     Ngày 3: Ăn sáng tại khách sạn, tham quan các điểm du lịch khác, ăn trưa tại nhà hàng, trở về Hà Nội.',
     '2024-03-10 09:00:00', 'public/uploads/images/tours/thanh-hoa.jpg', 
     'Ẩm thực: Hải sản, Đặc sản biển; Đối tượng thích hợp: Gia đình, Bạn bè, Du khách yêu thích biển; Thời gian lý tưởng: Mùa hè; Khuyến mãi: Giảm 10% cho nhóm từ 5 người.',
     '2024-12-13 17:30:00', NULL, 3),

    ('Quảng Ngãi: Lý Sơn - Núi Thiên Ấn', 3300000, 'Quảng Ngãi', 'Hồ Chí Minh', '3 Ngày 2 Đêm', 
     'Ngày 1: Hồ Chí Minh - Quảng Ngãi, ăn trưa tại nhà hàng, tham quan đảo Lý Sơn; 
     Ngày 2: Tham quan Núi Thiên Ấn, ăn trưa tại nhà hàng, tham quan các đảo nhỏ khác; 
     Ngày 3: Ăn sáng tại khách sạn, tham quan và ăn trưa tại nhà hàng, trở về Hồ Chí Minh.',
     '2024-03-15 08:30:00', 'public/uploads/images/tours/quang-ngai.jpg', 
     'Ẩm thực: Hải sản Lý Sơn, Đặc sản Quảng Ngãi; Đối tượng thích hợp: Gia đình, Bạn bè, Du khách yêu thích thiên nhiên; Thời gian lý tưởng: Mùa xuân, mùa hè; Khuyến mãi: Giảm 15% cho khách đặt trước.',
     '2024-12-13 18:00:00', NULL, 3),

    ('Phú Yên: Ghềnh Đá Đĩa - Bãi Xép', 3200000, 'Phú Yên', 'Hà Nội', '2 Ngày 1 Đêm', 
     'Ngày 1: Hà Nội - Phú Yên, ăn trưa tại nhà hàng, tham quan Ghềnh Đá Đĩa, Bãi Xép; 
     Ngày 2: Ăn sáng tại khách sạn, tham quan các điểm du lịch khác, ăn trưa tại nhà hàng, trở về Hà Nội.',
     '2024-03-20 07:00:00', 'public/uploads/images/tours/phu-yen.jpg', 
     'Ẩm thực: Hải sản tươi sống, Bánh hỏi; Đối tượng thích hợp: Gia đình, Bạn bè, Du khách yêu thích khám phá thiên nhiên; Thời gian lý tưởng: Mùa hè, mùa thu; Khuyến mãi: Giảm 10% cho khách đặt nhóm.',
     '2024-12-13 18:30:00', NULL, 3),

    ('Gia Lai: Hồ T’nưng - Núi Hàm Rồng', 3100000, 'Gia Lai', 'Đà Nẵng', '3 Ngày 2 Đêm', 
     'Ngày 1: Đà Nẵng - Gia Lai, ăn trưa tại nhà hàng, tham quan Hồ T’nưng, Núi Hàm Rồng; 
     Ngày 2: Tham quan các thác nước, ăn trưa tại nhà hàng, tiếp tục khám phá thiên nhiên; 
     Ngày 3: Ăn sáng tại khách sạn, tham quan và ăn trưa tại nhà hàng, trở về Đà Nẵng.',
     '2024-03-25 08:00:00', 'public/uploads/images/tours/gia-lai.jpeg', 
     'Ẩm thực: Món ăn Gia Lai, đặc sản Tây Nguyên; Đối tượng thích hợp: Gia đình, Bạn bè, Du khách yêu thích thiên nhiên; Thời gian lý tưởng: Mùa xuân, mùa hè; Khuyến mãi: Giảm 15% cho khách đặt nhóm.',
     '2024-12-13 19:00:00', NULL, 3);

--Tour đặc biệt
INSERT INTO tours (name, price, destination, pick_up, duration, itinerary, date_start, thumbnail, description, created_at, updated_at, category_id)
VALUES
    ('Hà Nội - Đà Nẵng - Hội An', 4000000, 'Hà Nội, Đà Nẵng, Hội An', 'Hà Nội', '4 Ngày 3 Đêm', 
     'Ngày 1: Hà Nội - Đà Nẵng, tham quan Ngũ Hành Sơn và bãi biển Mỹ Khê, ăn trưa tại nhà hàng; 
     Ngày 2: Tham quan Bà Nà Hills, ăn trưa trên đỉnh núi, tham quan Hội An vào buổi chiều, ăn tối tại nhà hàng Hội An; 
     Ngày 3: Tham quan phố cổ Hội An, ăn trưa tại nhà hàng, tham quan các làng nghề truyền thống; 
     Ngày 4: Trở về Hà Nội, ăn trưa tại nhà hàng trên đường về, tham quan một số điểm nổi bật ở Hà Nội.', 
     '2024-01-20 08:00:00', 'public/uploads/images/tours/hanoi-da-nang-hoi-an.jpg', 
     'Ẩm thực: Mì Quảng, Cao Lầu, Phở, Đặc sản miền Trung; Đối tượng thích hợp: Gia đình, Cặp đôi, Du khách yêu thích di sản và lịch sử; Thời gian lý tưởng: Mùa xuân, Mùa thu; Khuyến mãi: Giảm 15% cho nhóm từ 5 người.', 
     '2024-12-13 08:00:00', NULL, 4),

    ('Hồ Chí Minh - Nha Trang - Đà Lạt', 4500000, 'Hồ Chí Minh, Nha Trang, Đà Lạt', 'Hồ Chí Minh', '5 Ngày 4 Đêm', 
     'Ngày 1: Hồ Chí Minh - Nha Trang, tham quan Vinpearl Land, ăn trưa tại nhà hàng; 
     Ngày 2: Tham quan đảo Hòn Mun, ăn trưa tại nhà hàng trên đảo; 
     Ngày 3: Di chuyển từ Nha Trang đến Đà Lạt, tham quan Thung Lũng Tình Yêu, ăn trưa tại nhà hàng Đà Lạt; 
     Ngày 4: Tham quan hồ Xuân Hương, ăn trưa tại nhà hàng, tham quan các vườn hoa Đà Lạt; 
     Ngày 5: Trở về Hồ Chí Minh, ăn trưa tại nhà hàng trên đường về, tham quan chợ Bến Thành.', 
     '2024-02-15 09:00:00', 'public/uploads/images/tours/ho-chi-minh-nha-trang-da-lat.jpg', 
     'Ẩm thực: Hải sản tươi sống, Bánh căn, Bánh tráng nướng, Đặc sản Đà Lạt; Đối tượng thích hợp: Gia đình, Bạn bè, Du khách yêu thích biển và núi; Thời gian lý tưởng: Mùa xuân, Mùa hè; Khuyến mãi: Giảm 10% cho khách nhóm từ 6 người.', 
     '2024-12-13 09:00:00', NULL, 4),

    ('Hà Nội - Phú Quốc', 5000000, 'Hà Nội, Phú Quốc', 'Hà Nội', '4 Ngày 3 Đêm', 
     'Ngày 1: Hà Nội - Phú Quốc, tham quan Vinpearl Safari, ăn trưa tại nhà hàng; 
     Ngày 2: Tham quan đảo Ngọc, ăn trưa tại nhà hàng trên đảo; 
     Ngày 3: Tham quan các bãi biển Phú Quốc, ăn trưa tại nhà hàng, tham quan chợ Dương Đông; 
     Ngày 4: Trở về Hà Nội, ăn trưa tại nhà hàng ở Hà Nội.', 
     '2024-03-10 08:00:00', 'public/uploads/images/tours/ha-noi-phu-quoc.jpg', 
     'Ẩm thực: Hải sản Phú Quốc, Đặc sản địa phương, Món ăn Việt Nam; Đối tượng thích hợp: Cặp đôi, Gia đình, Du khách yêu thích nghỉ dưỡng và biển; Thời gian lý tưởng: Mùa hè, Mùa thu; Khuyến mãi: Giảm 20% cho khách đặt sớm.', 
     '2024-12-13 10:00:00', NULL, 4),

    ('Hà Nội - Cần Thơ', 3700000, 'Hà Nội, Cần Thơ', 'Hà Nội', '3 Ngày 2 Đêm', 
     'Ngày 1: Hà Nội - Cần Thơ, tham quan chợ nổi Cái Răng, ăn trưa tại nhà hàng; 
     Ngày 2: Tham quan vườn trái cây, ăn trưa tại nhà hàng, tham quan các làng nghề miền Tây; 
     Ngày 3: Trở về Hà Nội, ăn trưa tại nhà hàng tại Hà Nội.', 
     '2024-03-15 07:30:00', 'public/uploads/images/tours/ha-noi-can-tho.jpg', 
     'Ẩm thực: Đặc sản miền Tây, Cơm gà, Gỏi cuốn, Bánh xèo; Đối tượng thích hợp: Gia đình, Bạn bè, Du khách yêu thích khám phá miền sông nước; Thời gian lý tưởng: Mùa xuân, Mùa hè; Khuyến mãi: Giảm 15% cho nhóm từ 4 người.', 
     '2024-12-13 11:00:00', NULL, 4),

    ('Đà Nẵng - Hà Nội', 4200000, 'Đà Nẵng, Hà Nội', 'Đà Nẵng', '3 Ngày 2 Đêm', 
     'Ngày 1: Đà Nẵng - Hà Nội, tham quan Hồ Gươm và phố cổ, ăn trưa tại nhà hàng; 
     Ngày 2: Tham quan các di tích lịch sử Hà Nội, ăn trưa tại nhà hàng, tham quan chùa Một Cột, Hoàng thành Thăng Long; 
     Ngày 3: Tự do tham quan, ăn trưa tại nhà hàng, trở về Đà Nẵng.', 
     '2024-04-01 08:00:00', 'public/uploads/images/tours/da-nang-ha-noi.jpg', 
     'Ẩm thực: Phở, Bánh cuốn, Đặc sản Hà Nội; Đối tượng thích hợp: Du khách yêu thích lịch sử và di sản văn hóa; Thời gian lý tưởng: Mùa thu, Mùa xuân; Khuyến mãi: Giảm 20% cho khách đăng ký nhóm từ 5 người.', 
     '2024-12-13 12:00:00', NULL, 4),
    
    ('Hà Nội - Ninh Bình - Sapa', 4700000, 'Hà Nội, Ninh Bình, Sapa', 'Hà Nội', '5 Ngày 4 Đêm', 
     'Ngày 1: Hà Nội - Ninh Bình, tham quan Tam Cốc, ăn trưa tại nhà hàng; 
     Ngày 2: Tham quan Tràng An, ăn trưa tại nhà hàng, tham quan chùa Bái Đính; 
     Ngày 3: Di chuyển từ Ninh Bình đến Sapa, tham quan Thác Bạc, ăn trưa tại nhà hàng Sapa; 
     Ngày 4: Tham quan bản Cát Cát, ăn trưa tại nhà hàng, tham quan đỉnh Fansipan; 
     Ngày 5: Trở về Hà Nội, ăn trưa tại nhà hàng tại Hà Nội.',
     '2024-04-10 08:00:00', 'public/uploads/images/tours/ha-noi-ninh-binh-sapa.jpg', 
     'Ẩm thực: Cơm cháy Ninh Bình, Lẩu cá Sapa, Đặc sản địa phương; Đối tượng thích hợp: Du khách yêu thích thiên nhiên, gia đình, nhóm bạn; Thời gian lý tưởng: Mùa xuân, Mùa thu; Khuyến mãi: Giảm 10% cho khách đặt trước.',
     '2024-12-13 13:00:00', NULL, 4),

    ('Đà Nẵng - Phú Yên - Nha Trang', 4800000, 'Đà Nẵng, Phú Yên, Nha Trang', 'Đà Nẵng', '4 Ngày 3 Đêm', 
     'Ngày 1: Đà Nẵng - Phú Yên, tham quan Ghềnh Đá Đĩa, ăn trưa tại nhà hàng; 
     Ngày 2: Tham quan bãi Xép và bãi Môn, ăn trưa tại nhà hàng; 
     Ngày 3: Di chuyển từ Phú Yên đến Nha Trang, tham quan Hòn Mun, ăn trưa trên đảo; 
     Ngày 4: Tham quan Vinpearl Nha Trang, ăn trưa tại nhà hàng, tham quan chợ Đầm, trở về Đà Nẵng.',
     '2024-05-05 09:00:00', 'public/uploads/images/tours/da-nang-phu-yen-nha-trang.jpg', 
     'Ẩm thực: Hải sản, Bánh căn, Phở, Đặc sản miền Trung; Đối tượng thích hợp: Gia đình, Bạn bè, Du khách yêu thích biển và đảo; Thời gian lý tưởng: Mùa hè, Mùa thu; Khuyến mãi: Giảm 15% cho nhóm từ 4 người.',
     '2024-12-13 14:00:00', NULL, 4),

    ('Hà Nội - Hạ Long - Sapa', 5200000, 'Hà Nội, Hạ Long, Sapa', 'Hà Nội', '5 Ngày 4 Đêm', 
     'Ngày 1: Hà Nội - Hạ Long, tham quan Vịnh Hạ Long, ăn trưa trên tàu; 
     Ngày 2: Tham quan các đảo và hang động, ăn trưa tại nhà hàng trên đảo; 
     Ngày 3: Di chuyển từ Hạ Long đến Sapa, tham quan bản Cát Cát, ăn trưa tại nhà hàng Sapa; 
     Ngày 4: Tham quan đỉnh Fansipan, ăn trưa tại nhà hàng, tham quan Thác Bạc; 
     Ngày 5: Trở về Hà Nội, ăn trưa tại nhà hàng tại Hà Nội.',
     '2024-06-01 10:00:00', 'public/uploads/images/tours/ha-noi-ha-long-sapa.jpg', 
     'Ẩm thực: Phở, Lẩu cá Sapa, Đặc sản Hạ Long, Bánh cuốn Hà Nội; Đối tượng thích hợp: Du khách yêu thích thiên nhiên, lịch sử và di sản; Thời gian lý tưởng: Mùa xuân, Mùa thu; Khuyến mãi: Giảm 20% cho khách đăng ký sớm.',
     '2024-12-13 15:00:00', NULL, 4),

    ('Hồ Chí Minh - Vũng Tàu - Phan Thiết', 4500000, 'Hồ Chí Minh, Vũng Tàu, Phan Thiết', 'Hồ Chí Minh', '4 Ngày 3 Đêm', 
     'Ngày 1: Hồ Chí Minh - Vũng Tàu, tham quan bãi biển, ăn trưa tại nhà hàng; 
     Ngày 2: Tham quan khu du lịch Hồ Mây, ăn trưa tại nhà hàng, tham quan Chùa Nghinh Phong; 
     Ngày 3: Di chuyển từ Vũng Tàu đến Phan Thiết, tham quan bãi biển Mũi Né, ăn trưa tại nhà hàng; 
     Ngày 4: Tham quan tháp Chàm Po Sah Inư, ăn trưa tại nhà hàng, trở về Hồ Chí Minh.',
     '2024-07-10 08:30:00', 'public/uploads/images/tours/ho-chi-minh-vung-tau-phan-thiet.jpg', 
     'Ẩm thực: Hải sản Vũng Tàu, Bánh canh, Đặc sản Phan Thiết; Đối tượng thích hợp: Gia đình, Du khách yêu thích biển và nghỉ dưỡng; Thời gian lý tưởng: Mùa hè, Mùa thu; Khuyến mãi: Giảm 10% cho khách nhóm từ 5 người.',
     '2024-12-13 16:00:00', NULL, 4),

    ('Đà Lạt - Hồ Chí Minh', 4600000, 'Đà Lạt, Hồ Chí Minh', 'Đà Lạt', '3 Ngày 2 Đêm', 
     'Ngày 1: Đà Lạt - Hồ Chí Minh, tham quan Đền Hùng, ăn trưa tại nhà hàng; 
     Ngày 2: Tham quan Nhà thờ Đức Bà, chợ Bến Thành, ăn trưa tại nhà hàng; 
     Ngày 3: Tham quan Dinh Độc Lập, ăn trưa tại nhà hàng, trở về Đà Lạt.',
     '2024-08-05 08:00:00', 'public/uploads/images/tours/da-lat-ho-chi-minh.jpg', 
     'Ẩm thực: Cơm tấm, Phở, Bánh xèo; Đối tượng thích hợp: Du khách yêu thích khám phá, gia đình, bạn bè; Thời gian lý tưởng: Mùa xuân, Mùa hè; Khuyến mãi: Giảm 15% cho khách nhóm từ 4 người.',
     '2024-12-13 17:00:00', NULL, 4),

    ('Nha Trang - Đà Lạt', 4300000, 'Nha Trang, Đà Lạt', 'Nha Trang', '3 Ngày 2 Đêm', 
     'Ngày 1: Nha Trang - Đà Lạt, tham quan Thác Pongour, ăn trưa tại nhà hàng; 
     Ngày 2: Tham quan Hồ Xuân Hương, vườn hoa Đà Lạt, ăn trưa tại nhà hàng Đà Lạt; 
     Ngày 3: Tham quan Dinh Bảo Đại, ăn trưa tại nhà hàng, trở về Nha Trang.',
     '2024-09-01 08:00:00', 'public/uploads/images/tours/nha-trang-da-lat.jpg', 
     'Ẩm thực: Bánh căn, Lẩu thả, Đặc sản Đà Lạt; Đối tượng thích hợp: Gia đình, Du khách yêu thích nghỉ dưỡng và khám phá thiên nhiên; Thời gian lý tưởng: Mùa xuân, Mùa thu; Khuyến mãi: Giảm 10% cho nhóm từ 3 người.',
     '2024-12-13 18:00:00', NULL, 4),

    ('Hà Nội - Huế - Phú Quốc', 4900000, 'Hà Nội, Huế, Phú Quốc', 'Hà Nội', '5 Ngày 4 Đêm', 
     'Ngày 1: Hà Nội - Huế, tham quan Đại Nội, ăn trưa tại nhà hàng; 
     Ngày 2: Tham quan lăng Tự Đức, ăn trưa tại nhà hàng, tham quan chùa Thiên Mụ; 
     Ngày 3: Di chuyển từ Huế đến Phú Quốc, tham quan Vinpearl Safari, ăn trưa tại nhà hàng; 
     Ngày 4: Tham quan các bãi biển Phú Quốc, ăn trưa tại nhà hàng; 
     Ngày 5: Tham quan chợ Dương Đông, trở về Hà Nội, ăn tối tại nhà hàng Hà Nội.',
     '2024-10-01 09:00:00', 'public/uploads/images/tours/ha-noi-hue-phu-quoc.jpg', 
     'Ẩm thực: Bánh bèo Huế, Hải sản Phú Quốc, Đặc sản Hà Nội; Đối tượng thích hợp: Du khách yêu thích lịch sử, biển đảo và nghỉ dưỡng; Thời gian lý tưởng: Mùa hè, Mùa thu; Khuyến mãi: Giảm 20% cho khách đặt tour sớm.',
     '2024-12-13 19:00:00', NULL, 4);

--Các bảng về dịch vụ khác(Services)
CREATE TABLE service_categories(
    id INT PRIMARY KEY AUTO_INCREMENT,
    name varchar(100) NOT NULL 
);

INSERT INTO service_categories(id, name) VALUES (1, 'Xe máy'), (2, 'Ô tô'), (3, 'Combo cắm trại');


CREATE TABLE services(
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    image_url VARCHAR(255) NOT NULL,
    price FLOAT NOT NULL CHECK (price >= 0),
    service_category_id INT,
    FOREIGN KEY (service_category_id) REFERENCES service_categories(id)
);

-- Xe máy
INSERT INTO services (name, image_url, price, service_category_id)
VALUES
    ('Honda Wave Alpha', 'public/uploads/images/services/honda_wave_alpha.jpg', 700000, 1),
    ('Yamaha Exciter 150', 'public/uploads/images/services/yamaha_exciter_150.jpg', 1500000, 1),
    ('Honda Air Blade', 'public/uploads/images/services/honda_air_blade.jpg', 1200000, 1),
    ('Honda SH 125i', 'public/uploads/images/services/honda_sh_125i.jpg', 1500000, 1),
    ('Suzuki GSX-R150', 'public/uploads/images/services/suzuki_gsx_r150.jpg', 1350000, 1),
    ('Honda CBR 150R', 'public/uploads/images/services/honda_cbr_150r.jpg', 1300000, 1),
    ('Piaggio Liberty 125', 'public/uploads/images/services/piaggio_liberty_125.jpg', 1250000, 1),
    ('Vision bản thể thao', 'public/uploads/images/services/vision-the-thao.png', 1400000, 1),
    ('Vision 2024', 'public/uploads/images/services/vision-2024.jpg', 1600000, 1),
    ('Vespa Primavera 150', 'public/uploads/images/services/vespa_primavera_150.jpg', 1500000, 1);

-- Ô tô
INSERT INTO services (name, image_url, price, service_category_id)
VALUES
    ('Toyota Vios 2024', 'public/uploads/images/services/toyota_vios_2024.jpg', 2500000, 2),
    ('Hyundai Accent', 'public/uploads/images/services/hyundai_accent.jpg', 2300000, 2),
    ('Mazda 3', 'public/uploads/images/services/mazda_3.jpg', 2800000, 2),
    ('Honda City', 'public/uploads/images/services/honda_city.jpg', 2400000, 2),
    ('Kia Cerato', 'public/uploads/images/services/kia_cerato.jpg', 2600000, 2),
    ('VinFast VF 8', 'public/uploads/images/services/vinfast_vf8.jpg', 3200000, 2),
    ('Ford Ranger Wildtrak', 'public/uploads/images/services/ford_ranger_wildtrak.jpg', 3500000, 2),
    ('Toyota Fortuner', 'public/uploads/images/services/toyota_fortuner.jpg', 4000000, 2),
    ('Mercedes-Benz C-Class', 'public/uploads/images/services/mercedes_c_class.jpg', 5000000, 2),
    ('BMW 5 Series', 'public/uploads/images/services/bmw_5_series.jpg', 5500000, 2);


-- Combo cắm trại
INSERT INTO services (name, image_url, price, service_category_id)
VALUES
    ('Combo Lều 2 Người', 'public/uploads/images/services/combo_leu_2_nguoi.jpg', 500000, 3),
    ('Combo Lều 4 Người', 'public/uploads/images/services/combo_leu_4_nguoi.jpg', 800000, 3),
    ('Combo Lều Gia Đình 6 Người', 'public/uploads/images/services/combo_leu_gia_dinh_6_nguoi.jpg', 1200000, 3),
    ('Combo Lều Siêu Nhẹ 1 Người', 'public/uploads/images/services/combo_leu_sieu_nhe_1_nguoi.jpg', 400000, 3),
    ('Combo Lều Glamping Sang Trọng', 'public/uploads/images/services/combo_leu_glamping.jpg', 2000000, 3),
    ('Combo Lều Chống Nước Cao Cấp', 'public/uploads/images/services/combo_leu_chong_nuoc.jpg', 900000, 3),
    ('Combo Lều Dã Ngoại + Túi Ngủ', 'public/uploads/images/services/combo_leu_va_tui_ngu.jpg', 750000, 3),
    ('Combo Lều Địa Hình Khó', 'public/uploads/images/services/combo_leu_dia_hinh_kho.jpg', 1500000, 3),
    ('Combo Dụng Cụ Cắm Trại Cao Cấp', 'public/uploads/images/services/combo_dung_cu_cam_trai.jpg', 2500000, 3),
    ('Combo Cắm Trại Trọn Gói', 'public/uploads/images/services/combo_cam_trai_tron_goi.jpg', 3000000, 3);


--Đặt tour - orders
CREATE TABLE orders(
    id INT PRIMARY KEY AUTO_INCREMENT,
    user_id int,
    FOREIGN KEY (user_id) REFERENCES users(id),
    tour_id INT,
    FOREIGN KEY (tour_id) REFERENCES tours (id),
    fullname VARCHAR(100) DEFAULT '',
    gender ENUM('Male', 'Female', 'Other') NOT NULL,
    birthday DATETIME,
    email VARCHAR(100) DEFAULT '',
    phone_number VARCHAR(20) NOT NULL,
    address VARCHAR(200) NOT NULL,
    number_of_people INT NOT NULL,
    order_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    status ENUM('pending', 'completed', 'cancelled'),
    total_money FLOAT NOT NULL CHECK (total_money >= 0), --tổng giá tour và dịch vụ(nếu có)
    --xóa 1 đơn hàng => xóa mềm => thêm trường active
    active TINYINT(1) DEFAULT 1
);

CREATE TABLE order_details (
    id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT,
    tour_id INT,
    tour_price FLOAT NOT NULL CHECK (tour_price >= 0),
    number_of_people INT NOT NULL CHECK (number_of_people > 0),
    total_money_tour FLOAT CHECK (total_money_tour >= 0),
    service_id INT,
    service_price FLOAT NOT NULL CHECK (service_price >= 0),
    number_of_services INT NOT NULL CHECK (number_of_services > 0),
    total_money_service FLOAT CHECK (total_money_service >= 0),
    FOREIGN KEY (order_id) REFERENCES orders (id),
    FOREIGN KEY (tour_id) REFERENCES tours (id),
    FOREIGN KEY (service_id) REFERENCES services (id)
);


-- user_id từ 1->5 là admin,..
-- Insert into orders table
INSERT INTO orders (user_id, tour_id, fullname, gender, birthday, email, phone_number, address, number_of_people, order_date, status, total_money, active)
VALUES
    (6, 2, 'Trần Minh Hòa', 'Male', '1985-05-15', 'tranminhhoa@gmail.com', '0357111123', 'Quận 1, TP. Hồ Chí Minh', 2, '2024-10-01 08:00:00', 'completed', 5500000, 1),
    (7, 4, 'Nguyễn Thị Lan', 'Female', '1990-08-22', 'nguyenlan@gmail.com', '0357222234', 'Quận 3, TP. Hồ Chí Minh', 4, '2024-10-02 10:00:00', 'completed', 7500000, 1),
    (8, 6, 'Lê Hoàng Anh', 'Male', '1988-12-05', 'hoanganh@gmail.com', '0357333345', 'Quận 7, TP. Hồ Chí Minh', 1, '2024-10-08 09:00:00', 'pending', 4000000, 1),
    (9, 8, 'Phạm Văn Đức', 'Male', '1982-03-19', 'phamduc@gmail.com', '0357444456', 'Quận 5, TP. Hồ Chí Minh', 3, '2024-11-04 14:00:00', 'cancelled', 8500000, 1),
    (10, 10, 'Đỗ Thị Hương', 'Female', '1995-06-30', 'huongdo@gmail.com', '0357555567', 'Quận 10, TP. Hồ Chí Minh', 5, '2024-11-05 16:00:00', 'completed', 12500000, 1),
    (11, 12, 'Ngô Đức Thịnh', 'Male', '1980-09-25', 'ngothinh@gmail.com', '0357666678', 'Quận Bình Thạnh, TP. Hồ Chí Minh', 2, '2024-11-06 08:00:00', 'pending', 6500000, 1),
    (12, 14, 'Vũ Hải Yến', 'Female', '1989-11-11', 'yenhai@gmail.com', '0357777789', 'Quận Gò Vấp, TP. Hồ Chí Minh', 4, '2024-11-07 11:00:00', 'completed', 9500000, 1),
    (13, 16, 'Phan Anh Tú', 'Male', '1992-02-28', 'tuanh@gmail.com', '0357888890', 'Quận Phú Nhuận, TP. Hồ Chí Minh', 3, '2024-12-08 13:00:00', 'completed', 8500000, 1),
    (14, 18, 'Bùi Minh Ngọc', 'Female', '1997-04-18', 'ngocbui@gmail.com', '0357999911', 'Quận Tân Bình, TP. Hồ Chí Minh', 1, '2024-12-09 15:00:00', 'pending', 5000000, 1),
    (15, 20, 'Trịnh Thùy Linh', 'Female', '1993-07-07', 'linhthuy@gmail.com', '0357111012', 'Quận 12, TP. Hồ Chí Minh', 2, '2024-12-10 09:30:00', 'completed', 6000000, 1);

-- Insert into order_details table
INSERT INTO order_details (order_id, tour_id, tour_price, number_of_people, total_money_tour, service_id, service_price, number_of_services, total_money_service)
VALUES
    (1, 2, 2000000, 2, 4000000, 3, 500000, 3, 1500000),
    (2, 4, 3000000, 4, 6000000, 5, 750000, 2, 1500000), 
    (3, 6, 3500000, 1, 3500000, 6, 500000, 1, 500000),
    (4, 8, 2500000, 3, 7500000, 7, 250000, 2, 1000000), 
    (5, 10, 2000000, 5, 10000000, 8, 500000, 5, 2500000), 
    (6, 12, 3000000, 2, 6000000, 9, 250000, 2, 500000), 
    (7, 14, 2000000, 4, 8000000, 10, 375000, 4, 1500000), 
    (8, 16, 2500000, 3, 7500000, 11, 250000, 4, 1000000), 
    (9, 18, 4000000, 1, 4000000, 12, 1000000, 1, 1000000), 
    (10, 20, 2000000, 2, 4000000, 13, 1000000, 2, 2000000); 

--Bảng chứa thông tin đánh giá của khách hàng
CREATE TABLE reviews(
    id INT PRIMARY KEY AUTO_INCREMENT,
    user_id int,
    FOREIGN KEY (user_id) REFERENCES users(id),
    tour_id INT,
    FOREIGN KEY (tour_id) REFERENCES tours(id),
    rating INT CHECK(rating >= 0 AND rating <= 5),
    note LONGTEXT DEFAULT ''
)

INSERT INTO reviews (user_id, tour_id, rating, note)
VALUES
    (6, 2, 5, 'Chuyến đi tuyệt vời, rất đáng giá! Hướng dẫn viên rất nhiệt tình và chuyên nghiệp.'), -- User 6, Tour 2, 5 sao
    (7, 4, 4, 'Chuyến đi tốt, nhưng dịch vụ có thể cải thiện thêm chút nữa.'), -- User 7, Tour 4, 4 sao
    (8, 6, 3, 'Chuyến đi bình thường, không có gì đặc biệt như mong đợi.'), -- User 8, Tour 6, 3 sao
    (9, 8, 5, 'Chuyến đi tuyệt vời! Mọi thứ đều hoàn hảo từ đầu đến cuối.'), -- User 9, Tour 8, 5 sao
    (10, 10, 2, 'Không đáng giá so với giá tiền. Rất thất vọng với chuyến đi này.'), -- User 10, Tour 10, 2 sao
    (11, 12, 4, 'Chuyến đi tốt, nhưng đồ ăn chỉ ở mức trung bình thôi.'), -- User 11, Tour 12, 4 sao
    (12, 14, 5, 'Trải nghiệm xuất sắc! Tôi sẽ quay lại nếu có dịp.'), -- User 12, Tour 14, 5 sao
    (13, 16, 3, 'Chuyến đi cũng ổn, nhưng không có gì đặc sắc như mình mong đợi.'), -- User 13, Tour 16, 3 sao
    (14, 18, 4, 'Chuyến đi khá hay, nhưng hướng dẫn viên hơi trễ và không có nhiều sự giải thích.'), -- User 14, Tour 18, 4 sao
    (15, 20, 5, 'Đây là chuyến đi tuyệt vời nhất tôi từng tham gia! Mọi thứ đều hoàn hảo, từ phong cảnh đến dịch vụ.'); -- User 15, Tour 20, 5 sao
