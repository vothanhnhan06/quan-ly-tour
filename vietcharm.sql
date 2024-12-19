-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Máy chủ: 127.0.0.1
-- Thời gian đã tạo: Th12 16, 2024 lúc 06:40 PM
-- Phiên bản máy phục vụ: 10.4.32-MariaDB
-- Phiên bản PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Cơ sở dữ liệu: `vietcharm`
--

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `categories`
--

CREATE TABLE `categories` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL DEFAULT '' COMMENT 'Tên danh mục: Miền Nam, Miền Bắc, Miền Trung'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `categories`
--

INSERT INTO `categories` (`id`, `name`) VALUES
(1, 'Miền Nam'),
(2, 'Miền Bắc'),
(3, 'Miền Trung'),
(4, 'Đặc biệt');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `orders`
--

CREATE TABLE `orders` (
  `id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `tour_id` int(11) DEFAULT NULL,
  `fullname` varchar(100) DEFAULT '',
  `gender` enum('Male','Female','Other') NOT NULL,
  `birthday` datetime DEFAULT NULL,
  `email` varchar(100) DEFAULT '',
  `phone_number` varchar(20) NOT NULL,
  `address` varchar(200) NOT NULL,
  `number_of_people` int(11) NOT NULL,
  `order_date` datetime DEFAULT current_timestamp(),
  `status` enum('pending','completed','cancelled') DEFAULT NULL,
  `total_money` float NOT NULL CHECK (`total_money` >= 0),
  `active` tinyint(1) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `orders`
--

INSERT INTO `orders` (`id`, `user_id`, `tour_id`, `fullname`, `gender`, `birthday`, `email`, `phone_number`, `address`, `number_of_people`, `order_date`, `status`, `total_money`, `active`) VALUES
(1, 6, 2, 'Trần Minh Hòa', 'Male', '1985-05-15 00:00:00', 'tranminhhoa@gmail.com', '0357111123', 'Quận 1, TP. Hồ Chí Minh', 2, '2024-10-01 08:00:00', 'completed', 5500000, 1),
(2, 7, 4, 'Nguyễn Thị Lan', 'Female', '1990-08-22 00:00:00', 'nguyenlan@gmail.com', '0357222234', 'Quận 3, TP. Hồ Chí Minh', 4, '2024-10-02 10:00:00', 'completed', 7500000, 1),
(3, 8, 6, 'Lê Hoàng Anh', 'Male', '1988-12-05 00:00:00', 'hoanganh@gmail.com', '0357333345', 'Quận 7, TP. Hồ Chí Minh', 1, '2024-10-08 09:00:00', 'pending', 4000000, 1),
(4, 9, 8, 'Phạm Văn Đức', 'Male', '1982-03-19 00:00:00', 'phamduc@gmail.com', '0357444456', 'Quận 5, TP. Hồ Chí Minh', 3, '2024-11-04 14:00:00', 'cancelled', 8500000, 1),
(5, 10, 10, 'Đỗ Thị Hương', 'Female', '1995-06-30 00:00:00', 'huongdo@gmail.com', '0357555567', 'Quận 10, TP. Hồ Chí Minh', 5, '2024-11-05 16:00:00', 'completed', 12500000, 1),
(6, 11, 12, 'Ngô Đức Thịnh', 'Male', '1980-09-25 00:00:00', 'ngothinh@gmail.com', '0357666678', 'Quận Bình Thạnh, TP. Hồ Chí Minh', 2, '2024-11-06 08:00:00', 'pending', 6500000, 1),
(7, 12, 14, 'Vũ Hải Yến', 'Female', '1989-11-11 00:00:00', 'yenhai@gmail.com', '0357777789', 'Quận Gò Vấp, TP. Hồ Chí Minh', 4, '2024-11-07 11:00:00', 'completed', 9500000, 1),
(8, 13, 16, 'Phan Anh Tú', 'Male', '1992-02-28 00:00:00', 'tuanh@gmail.com', '0357888890', 'Quận Phú Nhuận, TP. Hồ Chí Minh', 3, '2024-12-08 13:00:00', 'completed', 8500000, 1),
(9, 14, 18, 'Bùi Minh Ngọc', 'Female', '1997-04-18 00:00:00', 'nhupham0311044@gmail.com', '0357999911', 'Quận Tân Bình, TP. Hồ Chí Minh', 1, '2024-12-09 15:00:00', 'completed', 5000000, 1),
(10, 15, 20, 'Trịnh Thùy Linh', 'Female', '1993-07-07 00:00:00', 'linhthuy@gmail.com', '0357111012', 'Quận 12, TP. Hồ Chí Minh', 2, '2024-12-10 09:30:00', 'completed', 6000000, 1);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `order_details`
--

CREATE TABLE `order_details` (
  `id` int(11) NOT NULL,
  `order_id` int(11) DEFAULT NULL,
  `tour_id` int(11) DEFAULT NULL,
  `tour_price` float NOT NULL CHECK (`tour_price` >= 0),
  `number_of_people` int(11) NOT NULL CHECK (`number_of_people` > 0),
  `total_money_tour` float DEFAULT NULL CHECK (`total_money_tour` >= 0),
  `service_id` int(11) DEFAULT NULL,
  `service_price` float NOT NULL CHECK (`service_price` >= 0),
  `number_of_services` int(11) NOT NULL CHECK (`number_of_services` > 0),
  `total_money_service` float DEFAULT NULL CHECK (`total_money_service` >= 0)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `order_details`
--

INSERT INTO `order_details` (`id`, `order_id`, `tour_id`, `tour_price`, `number_of_people`, `total_money_tour`, `service_id`, `service_price`, `number_of_services`, `total_money_service`) VALUES
(21, 1, 2, 2000000, 2, 4000000, 3, 500000, 3, 1500000),
(22, 2, 4, 3000000, 4, 6000000, 5, 750000, 2, 1500000),
(23, 3, 6, 3500000, 1, 3500000, 6, 500000, 1, 500000),
(24, 4, 8, 2500000, 3, 7500000, 7, 250000, 2, 1000000),
(25, 5, 10, 2000000, 5, 10000000, 8, 500000, 5, 2500000),
(26, 6, 12, 3000000, 2, 6000000, 9, 250000, 2, 500000),
(27, 7, 14, 2000000, 4, 8000000, 10, 375000, 4, 1500000),
(28, 8, 16, 2500000, 3, 7500000, 11, 250000, 4, 1000000),
(29, 9, 18, 4000000, 1, 4000000, 12, 1000000, 1, 1000000),
(30, 10, 20, 2000000, 2, 4000000, 13, 1000000, 2, 2000000);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `reviews`
--

CREATE TABLE `reviews` (
  `id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `tour_id` int(11) DEFAULT NULL,
  `rating` int(11) DEFAULT NULL CHECK (`rating` >= 0 and `rating` <= 5),
  `note` longtext DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `reviews`
--

INSERT INTO `reviews` (`id`, `user_id`, `tour_id`, `rating`, `note`) VALUES
(1, 6, 2, 5, 'Chuyến đi tuyệt vời, rất đáng giá! Hướng dẫn viên rất nhiệt tình và chuyên nghiệp.'),
(2, 7, 4, 4, 'Chuyến đi tốt, nhưng dịch vụ có thể cải thiện thêm chút nữa.'),
(3, 8, 6, 3, 'Chuyến đi bình thường, không có gì đặc biệt như mong đợi.'),
(4, 9, 8, 5, 'Chuyến đi tuyệt vời! Mọi thứ đều hoàn hảo từ đầu đến cuối.'),
(5, 10, 10, 2, 'Không đáng giá so với giá tiền. Rất thất vọng với chuyến đi này.'),
(6, 11, 12, 4, 'Chuyến đi tốt, nhưng đồ ăn chỉ ở mức trung bình thôi.'),
(7, 12, 14, 5, 'Trải nghiệm xuất sắc! Tôi sẽ quay lại nếu có dịp.'),
(8, 13, 16, 3, 'Chuyến đi cũng ổn, nhưng không có gì đặc sắc như mình mong đợi.'),
(9, 14, 18, 4, 'Chuyến đi khá hay, nhưng hướng dẫn viên hơi trễ và không có nhiều sự giải thích.'),
(10, 15, 20, 5, 'Đây là chuyến đi tuyệt vời nhất tôi từng tham gia! Mọi thứ đều hoàn hảo, từ phong cảnh đến dịch vụ.');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `roles`
--

CREATE TABLE `roles` (
  `id` int(11) NOT NULL,
  `position` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `roles`
--

INSERT INTO `roles` (`id`, `position`) VALUES
(1, 'CUSTOMER'),
(2, 'ADMIN'),
(3, 'EMPLOYEE'),
(4, 'MANAGER');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `services`
--

CREATE TABLE `services` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `image_url` varchar(255) NOT NULL,
  `price` float NOT NULL CHECK (`price` >= 0),
  `service_category_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `services`
--

INSERT INTO `services` (`id`, `name`, `image_url`, `price`, `service_category_id`) VALUES
(1, 'Honda Wave Alpha', 'public/uploads/images/services/honda_wave_alpha.jpg', 700000, 1),
(2, 'Yamaha Exciter 150', 'public/uploads/images/services/yamaha_exciter_150.jpg', 1500000, 1),
(3, 'Honda Air Blade', 'public/uploads/images/services/honda_air_blade.jpg', 1200000, 1),
(4, 'Honda SH 125i', 'public/uploads/images/services/honda_sh_125i.jpg', 1500000, 1),
(5, 'Suzuki GSX-R150', 'public/uploads/images/services/suzuki_gsx_r150.jpg', 1350000, 1),
(6, 'Honda CBR 150R', 'public/uploads/images/services/honda_cbr_150r.jpg', 1300000, 1),
(7, 'Piaggio Liberty 125', 'public/uploads/images/services/piaggio_liberty_125.jpg', 1250000, 1),
(8, 'Vision bản thể thao', 'public/uploads/images/services/vision-the-thao.png', 1400000, 1),
(9, 'Vision 2024', 'public/uploads/images/services/vision-2024.jpg', 1600000, 1),
(10, 'Vespa Primavera 150', 'public/uploads/images/services/vespa_primavera_150.jpg', 1500000, 1),
(11, 'Toyota Vios 2024', 'public/uploads/images/services/toyota_vios_2024.jpg', 2500000, 2),
(12, 'Hyundai Accent', 'public/uploads/images/services/hyundai_accent.jpg', 2300000, 2),
(13, 'Mazda 3', 'public/uploads/images/services/mazda_3.jpg', 2800000, 2),
(14, 'Honda City', 'public/uploads/images/services/honda_city.jpg', 2400000, 2),
(15, 'Kia Cerato', 'public/uploads/images/services/kia_cerato.jpg', 2600000, 2),
(16, 'VinFast VF 8', 'public/uploads/images/services/vinfast_vf8.jpg', 3200000, 2),
(17, 'Ford Ranger Wildtrak', 'public/uploads/images/services/ford_ranger_wildtrak.jpg', 3500000, 2),
(18, 'Toyota Fortuner', 'public/uploads/images/services/toyota_fortuner.jpg', 4000000, 2),
(19, 'Mercedes-Benz C-Class', 'public/uploads/images/services/mercedes_c_class.jpg', 5000000, 2),
(20, 'BMW 5 Series', 'public/uploads/images/services/bmw_5_series.jpg', 5500000, 2),
(21, 'Combo Lều 2 Người', 'public/uploads/images/services/combo_leu_2_nguoi.jpg', 500000, 3),
(22, 'Combo Lều 4 Người', 'public/uploads/images/services/combo_leu_4_nguoi.jpg', 800000, 3),
(23, 'Combo Lều Gia Đình 6 Người', 'public/uploads/images/services/combo_leu_gia_dinh_6_nguoi.jpg', 1200000, 3),
(24, 'Combo Lều Siêu Nhẹ 1 Người', 'public/uploads/images/services/combo_leu_sieu_nhe_1_nguoi.jpg', 400000, 3),
(25, 'Combo Lều Glamping Sang Trọng', 'public/uploads/images/services/combo_leu_glamping.jpg', 2000000, 3),
(26, 'Combo Lều Chống Nước Cao Cấp', 'public/uploads/images/services/combo_leu_chong_nuoc.jpg', 900000, 3),
(27, 'Combo Lều Dã Ngoại + Túi Ngủ', 'public/uploads/images/services/combo_leu_va_tui_ngu.jpg', 750000, 3),
(28, 'Combo Lều Địa Hình Khó', 'public/uploads/images/services/combo_leu_dia_hinh_kho.jpg', 1500000, 3),
(29, 'Combo Dụng Cụ Cắm Trại Cao Cấp', 'public/uploads/images/services/combo_dung_cu_cam_trai.jpg', 2500000, 3),
(30, 'Combo Cắm Trại Trọn Gói', 'public/uploads/images/services/combo_cam_trai_tron_goi.jpg', 3000000, 3);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `service_categories`
--

CREATE TABLE `service_categories` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `service_categories`
--

INSERT INTO `service_categories` (`id`, `name`) VALUES
(1, 'Xe máy'),
(2, 'Ô tô'),
(3, 'Combo cắm trại');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `tokenlogin`
--

CREATE TABLE `tokenlogin` (
  `id` int(11) NOT NULL,
  `token` varchar(255) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `tokenlogin`
--

INSERT INTO `tokenlogin` (`id`, `token`, `user_id`, `created_at`) VALUES
(1, 'eyJ0eXBlIjoiand0IiwidGltZSI6MTczNDQyNzE2Mn0.eyJpZCI6MSwiZW1haWwiOiJhZG1pbkBnbWFpbC5jb20ifQ.e3e226998954e96fe3053b4ccdc9ea09a7f4b98ef98daddc20e17994db28ec8d', 1, '2024-12-16 16:19:22');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `tours`
--

CREATE TABLE `tours` (
  `id` int(11) NOT NULL,
  `name` varchar(350) DEFAULT NULL COMMENT 'Tên tour',
  `price` float NOT NULL CHECK (`price` >= 0),
  `destination` varchar(200) DEFAULT '',
  `pick_up` varchar(200) DEFAULT '',
  `duration` varchar(100) DEFAULT NULL,
  `itinerary` varchar(300) DEFAULT NULL,
  `date_start` datetime NOT NULL,
  `thumbnail` varchar(300) DEFAULT '' COMMENT 'Ảnh preview tour/combo',
  `description` longtext DEFAULT '',
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `category_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `tours`
--

INSERT INTO `tours` (`id`, `name`, `price`, `destination`, `pick_up`, `duration`, `itinerary`, `date_start`, `thumbnail`, `description`, `created_at`, `updated_at`, `category_id`) VALUES
(1, 'Mũi Né: Khám phá Bãi Rạng - Đồi Cát Bay', 2500000, 'Mũi Né', 'Hồ Chí Minh', '2 Ngày 1 Đêm', 'Ngày 1: Hồ Chí Minh - Mũi Né, ăn trưa tại nhà hàng, tham quan Bãi Rạng, Đồi Cát Bay; \r\n     Ngày 2: Ăn sáng tại khách sạn, tham quan các địa danh khác, ăn trưa tại nhà hàng, trở về Hồ Chí Minh, ăn tối tại nhà hàng.', '2024-01-10 07:00:00', 'public/uploads/images/tours/mui-ne.jpg', 'Ẩm thực: Đặc sản biển, Bánh canh; Đối tượng thích hợp: Gia đình, Cặp đôi, Bạn bè; Thời gian lý tưởng: Mùa hè; Khuyến mãi: Giảm 15% cho nhóm từ 4 người trở lên.', '2024-12-13 08:00:00', NULL, 1),
(2, 'Phú Quốc: Khám phá Đảo Ngọc', 3500000, 'Phú Quốc', 'Hồ Chí Minh', '3 Ngày 2 Đêm', 'Ngày 1: Hồ Chí Minh - Phú Quốc, ăn trưa tại nhà hàng, tham quan Dinh Cậu, Bãi Sao; \r\n     Ngày 2: Tham quan Vinpearl Safari, ăn trưa tại nhà hàng, tham quan các đảo nhỏ; \r\n     Ngày 3: Ăn sáng tại khách sạn, tham quan và ăn trưa tại nhà hàng, trở về Hồ Chí Minh, ăn tối tại nhà hàng.', '2024-01-12 06:00:00', 'public/uploads/images/tours/phu-quoc.jpg', 'Ẩm thực: Hải sản tươi ngon, Đặc sản Phú Quốc; Đối tượng thích hợp: Gia đình, Cặp đôi, Du khách khám phá thiên nhiên; Thời gian lý tưởng: Mùa hè; Khuyến mãi: Giảm 20% cho khách đặt trước.', '2024-12-13 09:30:00', NULL, 1),
(3, 'Vũng Tàu: Tham quan Bãi Trước - Bãi Sau', 1500000, 'Vũng Tàu', 'Hồ Chí Minh', '1 Ngày', 'Buổi sáng: Hồ Chí Minh - Vũng Tàu, ăn trưa tại nhà hàng; Buổi chiều: Tham quan Bãi Trước, Bãi Sau, ăn tối tại nhà hàng và trở về Hồ Chí Minh.', '2024-01-15 07:30:00', 'public/uploads/images/tours/vung-tau.jpg', 'Ẩm thực: Hải sản tươi sống, Món ăn miền biển; Đối tượng thích hợp: Gia đình, Bạn bè; Thời gian lý tưởng: Mùa hè; Khuyến mãi: Giảm 10% cho nhóm từ 5 người trở lên.', '2024-12-13 10:15:00', NULL, 1),
(4, 'Cần Thơ: Chợ Nổi - Làng Du Lịch Mỹ Khánh', 2000000, 'Cần Thơ', 'Hồ Chí Minh', '2 Ngày 1 Đêm', 'Ngày 1: Hồ Chí Minh - Cần Thơ, ăn trưa tại nhà hàng, tham quan chợ nổi Cái Răng, Làng Du Lịch Mỹ Khánh; \r\n     Ngày 2: Ăn sáng tại khách sạn, tham quan các địa danh khác, ăn trưa tại nhà hàng, trở về Hồ Chí Minh, ăn tối tại nhà hàng.', '2024-01-18 06:30:00', 'public/uploads/images/tours/can-tho.jpg', 'Ẩm thực: Đặc sản miền Tây, Món ăn từ cá, tôm; Đối tượng thích hợp: Gia đình, Bạn bè, Du khách yêu thích thiên nhiên; Thời gian lý tưởng: Mùa xuân và mùa hè; Khuyến mãi: Giảm 15% cho khách đặt trước.', '2024-12-13 11:00:00', NULL, 1),
(5, 'Đà Lạt: Hồ Xuân Hương - Thác Datanla', 2800000, 'Đà Lạt', 'Hồ Chí Minh', '2 Ngày 1 Đêm', 'Ngày 1: Hồ Chí Minh - Đà Lạt, ăn trưa tại nhà hàng, tham quan Hồ Xuân Hương, Thác Datanla; \r\n     Ngày 2: Ăn sáng tại khách sạn, tham quan các điểm du lịch khác, ăn trưa tại nhà hàng, trở về Hồ Chí Minh, ăn tối tại nhà hàng.', '2024-01-25 07:00:00', 'public/uploads/images/tours/da-lat.jpg', 'Ẩm thực: Đặc sản Đà Lạt, Mứt dâu, Bánh tráng nướng; Đối tượng thích hợp: Gia đình, Cặp đôi, Bạn bè; Thời gian lý tưởng: Mùa xuân và mùa thu; Khuyến mãi: Giảm 10% cho nhóm từ 4 người trở lên.', '2024-12-13 12:30:00', NULL, 1),
(6, 'Tây Ninh: Núi Bà Đen - Chùa Linh Sơn', 1200000, 'Tây Ninh', 'Hồ Chí Minh', '1 Ngày', 'Buổi sáng: Hồ Chí Minh - Tây Ninh, ăn trưa tại nhà hàng, tham quan Núi Bà Đen, Chùa Linh Sơn; \r\n     Buổi chiều: Tham quan các điểm du lịch, ăn tối tại nhà hàng và trở về Hồ Chí Minh.', '2024-02-05 06:00:00', 'public/uploads/images/tours/tay-ninh.jpg', 'Ẩm thực: Đặc sản miền Đông Nam Bộ, Các món từ thịt bò; Đối tượng thích hợp: Gia đình, Bạn bè, Du khách yêu thích văn hóa; Thời gian lý tưởng: Mùa xuân và mùa hè; Khuyến mãi: Giảm 10% cho nhóm từ 5 người.', '2024-12-13 14:30:00', NULL, 1),
(7, 'Bến Tre: Vườn Dừa - Chùa Vĩnh Tràng', 1800000, 'Bến Tre', 'Hồ Chí Minh', '2 Ngày 1 Đêm', 'Ngày 1: Hồ Chí Minh - Bến Tre, ăn trưa tại nhà hàng, tham quan vườn dừa, Chùa Vĩnh Tràng; \r\n     Ngày 2: Ăn sáng tại khách sạn, tham quan các điểm du lịch khác, ăn trưa tại nhà hàng, trở về Hồ Chí Minh, ăn tối tại nhà hàng.', '2024-02-10 07:30:00', 'public/uploads/images/tours/ben-tre.jpg', 'Ẩm thực: Món ăn từ dừa, đặc sản miền Tây; Đối tượng thích hợp: Gia đình, Bạn bè; Thời gian lý tưởng: Mùa xuân và mùa hè; Khuyến mãi: Giảm 5% cho khách đăng ký trước 30 ngày.', '2024-12-13 15:00:00', NULL, 1),
(8, 'Cà Mau: Mũi Cà Mau - Rừng U Minh', 2200000, 'Cà Mau', 'Hồ Chí Minh', '2 Ngày 1 Đêm', 'Ngày 1: Hồ Chí Minh - Cà Mau, ăn trưa tại nhà hàng, tham quan Mũi Cà Mau, Rừng U Minh; \r\n     Ngày 2: Ăn sáng tại khách sạn, tham quan các điểm du lịch khác, ăn trưa tại nhà hàng, trở về Hồ Chí Minh, ăn tối tại nhà hàng.', '2024-02-20 07:00:00', 'public/uploads/images/tours/ca-mau.jpg', 'Ẩm thực: Đặc sản biển, các món ăn từ cá, tôm; Đối tượng thích hợp: Gia đình, Bạn bè, Du khách yêu thích thiên nhiên; Thời gian lý tưởng: Mùa thu và mùa xuân; Khuyến mãi: Giảm 10% cho khách đăng ký trước.', '2024-12-13 16:00:00', NULL, 1),
(9, 'Rạch Giá: Khu Du Lịch Phú Quốc', 3000000, 'Rạch Giá', 'Hồ Chí Minh', '3 Ngày 2 Đêm', 'Ngày 1: Hồ Chí Minh - Rạch Giá, ăn trưa tại nhà hàng, tham quan Khu Du Lịch Phú Quốc; \r\n     Ngày 2: Tham quan các điểm du lịch, ăn trưa tại nhà hàng, tham quan các đảo nhỏ; \r\n     Ngày 3: Ăn sáng tại khách sạn, tham quan và ăn trưa tại nhà hàng, trở về Hồ Chí Minh, ăn tối tại nhà hàng.', '2024-02-22 06:30:00', 'public/uploads/images/tours/rach-gia.jpg', 'Ẩm thực: Hải sản tươi ngon, các món ăn địa phương; Đối tượng thích hợp: Gia đình, Cặp đôi, Bạn bè; Thời gian lý tưởng: Mùa hè; Khuyến mãi: Giảm 20% cho khách đăng ký trước.', '2024-12-13 17:00:00', NULL, 1),
(10, 'Long An: Đồng Tháp Mười - Chùa Vĩnh Nguyên', 1600000, 'Long An', 'Hồ Chí Minh', '2 Ngày 1 Đêm', 'Ngày 1: Hồ Chí Minh - Long An, ăn trưa tại nhà hàng, tham quan Đồng Tháp Mười, Chùa Vĩnh Nguyên; \r\n     Ngày 2: Ăn sáng tại khách sạn, tham quan các điểm du lịch, ăn trưa tại nhà hàng, trở về Hồ Chí Minh, ăn tối tại nhà hàng.', '2024-03-01 07:00:00', 'public/uploads/images/tours/long-an.jpg', 'Ẩm thực: Đặc sản miền Tây, Món ăn từ gạo, cá; Đối tượng thích hợp: Gia đình, Bạn bè, Du khách yêu thích thiên nhiên; Thời gian lý tưởng: Mùa xuân và mùa thu; Khuyến mãi: Giảm 10% cho nhóm từ 5 người.', '2024-12-13 18:00:00', NULL, 1),
(11, 'Tiền Giang: Vườn Cây - Chùa Vĩnh Tràng', 1500000, 'Tiền Giang', 'Hồ Chí Minh', '1 Ngày', 'Buổi sáng: Hồ Chí Minh - Tiền Giang, ăn trưa tại nhà hàng, tham quan vườn cây, Chùa Vĩnh Tràng; \r\n     Buổi chiều: Tham quan các điểm du lịch, ăn tối tại nhà hàng và trở về Hồ Chí Minh.', '2024-03-05 07:30:00', 'public/uploads/images/tours/tien-giang.jpg', 'Ẩm thực: Món ăn đặc sản miền Tây, các món ăn từ gạo; Đối tượng thích hợp: Gia đình, Bạn bè, Du khách yêu thích khám phá; Thời gian lý tưởng: Mùa xuân và mùa hè; Khuyến mãi: Giảm 10% cho nhóm từ 4 người.', '2024-12-13 19:30:00', NULL, 1),
(12, 'Mũi Né: Khám phá Bãi Rạng - Đồi Cát Bay', 2500000, 'Mũi Né', 'Hồ Chí Minh', '2 Ngày 1 Đêm', 'Ngày 1: Hồ Chí Minh - Mũi Né, ăn trưa tại nhà hàng, tham quan Bãi Rạng, Đồi Cát Bay; \r\n     Ngày 2: Ăn sáng tại khách sạn, tham quan các địa danh khác, ăn trưa tại nhà hàng, trở về Hồ Chí Minh, ăn tối tại nhà hàng.', '2024-01-10 07:00:00', 'public/uploads/images/tours/mui-ne.jpg', 'Ẩm thực: Đặc sản biển, Bánh canh; Đối tượng thích hợp: Gia đình, Cặp đôi, Bạn bè; Thời gian lý tưởng: Mùa hè; Khuyến mãi: Giảm 15% cho nhóm từ 4 người trở lên.', '2024-12-13 08:00:00', NULL, 1),
(13, 'Phú Quốc: Khám phá Đảo Ngọc', 3500000, 'Phú Quốc', 'Hồ Chí Minh', '3 Ngày 2 Đêm', 'Ngày 1: Hồ Chí Minh - Phú Quốc, ăn trưa tại nhà hàng, tham quan Dinh Cậu, Bãi Sao; \r\n     Ngày 2: Tham quan Vinpearl Safari, ăn trưa tại nhà hàng, tham quan các đảo nhỏ; \r\n     Ngày 3: Ăn sáng tại khách sạn, tham quan và ăn trưa tại nhà hàng, trở về Hồ Chí Minh, ăn tối tại nhà hàng.', '2024-01-12 06:00:00', 'public/uploads/images/tours/phu-quoc.jpg', 'Ẩm thực: Hải sản tươi ngon, Đặc sản Phú Quốc; Đối tượng thích hợp: Gia đình, Cặp đôi, Du khách khám phá thiên nhiên; Thời gian lý tưởng: Mùa hè; Khuyến mãi: Giảm 20% cho khách đặt trước.', '2024-12-13 09:30:00', NULL, 1),
(14, 'Vũng Tàu: Tham quan Bãi Trước - Bãi Sau', 1500000, 'Vũng Tàu', 'Hồ Chí Minh', '1 Ngày', 'Buổi sáng: Hồ Chí Minh - Vũng Tàu, ăn trưa tại nhà hàng; Buổi chiều: Tham quan Bãi Trước, Bãi Sau, ăn tối tại nhà hàng và trở về Hồ Chí Minh.', '2024-01-15 07:30:00', 'public/uploads/images/tours/vung-tau.jpg', 'Ẩm thực: Hải sản tươi sống, Món ăn miền biển; Đối tượng thích hợp: Gia đình, Bạn bè; Thời gian lý tưởng: Mùa hè; Khuyến mãi: Giảm 10% cho nhóm từ 5 người trở lên.', '2024-12-13 10:15:00', NULL, 1),
(15, 'Cần Thơ: Chợ Nổi - Làng Du Lịch Mỹ Khánh', 2000000, 'Cần Thơ', 'Hồ Chí Minh', '2 Ngày 1 Đêm', 'Ngày 1: Hồ Chí Minh - Cần Thơ, ăn trưa tại nhà hàng, tham quan chợ nổi Cái Răng, Làng Du Lịch Mỹ Khánh; \r\n     Ngày 2: Ăn sáng tại khách sạn, tham quan các địa danh khác, ăn trưa tại nhà hàng, trở về Hồ Chí Minh, ăn tối tại nhà hàng.', '2024-01-18 06:30:00', 'public/uploads/images/tours/can-tho.jpg', 'Ẩm thực: Đặc sản miền Tây, Món ăn từ cá, tôm; Đối tượng thích hợp: Gia đình, Bạn bè, Du khách yêu thích thiên nhiên; Thời gian lý tưởng: Mùa xuân và mùa hè; Khuyến mãi: Giảm 15% cho khách đặt trước.', '2024-12-13 11:00:00', NULL, 1),
(16, 'Đà Lạt: Hồ Xuân Hương - Thác Datanla', 2800000, 'Đà Lạt', 'Hồ Chí Minh', '2 Ngày 1 Đêm', 'Ngày 1: Hồ Chí Minh - Đà Lạt, ăn trưa tại nhà hàng, tham quan Hồ Xuân Hương, Thác Datanla; \r\n     Ngày 2: Ăn sáng tại khách sạn, tham quan các điểm du lịch khác, ăn trưa tại nhà hàng, trở về Hồ Chí Minh, ăn tối tại nhà hàng.', '2024-01-25 07:00:00', 'public/uploads/images/tours/da-lat.jpg', 'Ẩm thực: Đặc sản Đà Lạt, Mứt dâu, Bánh tráng nướng; Đối tượng thích hợp: Gia đình, Cặp đôi, Bạn bè; Thời gian lý tưởng: Mùa xuân và mùa thu; Khuyến mãi: Giảm 10% cho nhóm từ 4 người trở lên.', '2024-12-13 12:30:00', NULL, 1),
(17, 'Tây Ninh: Núi Bà Đen - Chùa Linh Sơn', 1200000, 'Tây Ninh', 'Hồ Chí Minh', '1 Ngày', 'Buổi sáng: Hồ Chí Minh - Tây Ninh, ăn trưa tại nhà hàng, tham quan Núi Bà Đen, Chùa Linh Sơn; \r\n     Buổi chiều: Tham quan các điểm du lịch, ăn tối tại nhà hàng và trở về Hồ Chí Minh.', '2024-02-05 06:00:00', 'public/uploads/images/tours/tay-ninh.jpg', 'Ẩm thực: Đặc sản miền Đông Nam Bộ, Các món từ thịt bò; Đối tượng thích hợp: Gia đình, Bạn bè, Du khách yêu thích văn hóa; Thời gian lý tưởng: Mùa xuân và mùa hè; Khuyến mãi: Giảm 10% cho nhóm từ 5 người.', '2024-12-13 14:30:00', NULL, 1),
(18, 'Bến Tre: Vườn Dừa - Chùa Vĩnh Tràng', 1800000, 'Bến Tre', 'Hồ Chí Minh', '2 Ngày 1 Đêm', 'Ngày 1: Hồ Chí Minh - Bến Tre, ăn trưa tại nhà hàng, tham quan vườn dừa, Chùa Vĩnh Tràng; \r\n     Ngày 2: Ăn sáng tại khách sạn, tham quan các điểm du lịch khác, ăn trưa tại nhà hàng, trở về Hồ Chí Minh, ăn tối tại nhà hàng.', '2024-02-10 07:30:00', 'public/uploads/images/tours/ben-tre.jpg', 'Ẩm thực: Món ăn từ dừa, đặc sản miền Tây; Đối tượng thích hợp: Gia đình, Bạn bè; Thời gian lý tưởng: Mùa xuân và mùa hè; Khuyến mãi: Giảm 5% cho khách đăng ký trước 30 ngày.', '2024-12-13 15:00:00', NULL, 1),
(19, 'Cà Mau: Mũi Cà Mau - Rừng U Minh', 2200000, 'Cà Mau', 'Hồ Chí Minh', '2 Ngày 1 Đêm', 'Ngày 1: Hồ Chí Minh - Cà Mau, ăn trưa tại nhà hàng, tham quan Mũi Cà Mau, Rừng U Minh; \r\n     Ngày 2: Ăn sáng tại khách sạn, tham quan các điểm du lịch khác, ăn trưa tại nhà hàng, trở về Hồ Chí Minh, ăn tối tại nhà hàng.', '2024-02-20 07:00:00', 'public/uploads/images/tours/ca-mau.jpg', 'Ẩm thực: Đặc sản biển, các món ăn từ cá, tôm; Đối tượng thích hợp: Gia đình, Bạn bè, Du khách yêu thích thiên nhiên; Thời gian lý tưởng: Mùa thu và mùa xuân; Khuyến mãi: Giảm 10% cho khách đăng ký trước.', '2024-12-13 16:00:00', NULL, 1),
(20, 'Rạch Giá: Khu Du Lịch Phú Quốc', 3000000, 'Rạch Giá', 'Hồ Chí Minh', '3 Ngày 2 Đêm', 'Ngày 1: Hồ Chí Minh - Rạch Giá, ăn trưa tại nhà hàng, tham quan Khu Du Lịch Phú Quốc; \r\n     Ngày 2: Tham quan các điểm du lịch, ăn trưa tại nhà hàng, tham quan các đảo nhỏ; \r\n     Ngày 3: Ăn sáng tại khách sạn, tham quan và ăn trưa tại nhà hàng, trở về Hồ Chí Minh, ăn tối tại nhà hàng.', '2024-02-22 06:30:00', 'public/uploads/images/tours/rach-gia.jpg', 'Ẩm thực: Hải sản tươi ngon, các món ăn địa phương; Đối tượng thích hợp: Gia đình, Cặp đôi, Bạn bè; Thời gian lý tưởng: Mùa hè; Khuyến mãi: Giảm 20% cho khách đăng ký trước.', '2024-12-13 17:00:00', NULL, 1),
(21, 'Long An: Đồng Tháp Mười - Chùa Vĩnh Nguyên', 1600000, 'Long An', 'Hồ Chí Minh', '2 Ngày 1 Đêm', 'Ngày 1: Hồ Chí Minh - Long An, ăn trưa tại nhà hàng, tham quan Đồng Tháp Mười, Chùa Vĩnh Nguyên; \r\n     Ngày 2: Ăn sáng tại khách sạn, tham quan các điểm du lịch, ăn trưa tại nhà hàng, trở về Hồ Chí Minh, ăn tối tại nhà hàng.', '2024-03-01 07:00:00', 'public/uploads/images/tours/long-an.jpg', 'Ẩm thực: Đặc sản miền Tây, Món ăn từ gạo, cá; Đối tượng thích hợp: Gia đình, Bạn bè, Du khách yêu thích thiên nhiên; Thời gian lý tưởng: Mùa xuân và mùa thu; Khuyến mãi: Giảm 10% cho nhóm từ 5 người.', '2024-12-13 18:00:00', NULL, 1),
(22, 'Tiền Giang: Vườn Cây - Chùa Vĩnh Tràng', 1500000, 'Tiền Giang', 'Hồ Chí Minh', '1 Ngày', 'Buổi sáng: Hồ Chí Minh - Tiền Giang, ăn trưa tại nhà hàng, tham quan vườn cây, Chùa Vĩnh Tràng; \r\n     Buổi chiều: Tham quan các điểm du lịch, ăn tối tại nhà hàng và trở về Hồ Chí Minh.', '2024-03-05 07:30:00', 'public/uploads/images/tours/tien-giang.jpg', 'Ẩm thực: Món ăn đặc sản miền Tây, các món ăn từ gạo; Đối tượng thích hợp: Gia đình, Bạn bè, Du khách yêu thích khám phá; Thời gian lý tưởng: Mùa xuân và mùa hè; Khuyến mãi: Giảm 10% cho nhóm từ 4 người.', '2024-12-13 19:30:00', NULL, 1),
(23, 'Hạ Long: Tham quan Vịnh Hạ Long', 3500000, 'Hạ Long', 'Hà Nội', '3 Ngày 2 Đêm', 'Ngày 1: Hà Nội - Hạ Long, ăn trưa tại nhà hàng địa phương, tham quan Vịnh Hạ Long; \r\n     Ngày 2: Tham quan vịnh, ăn trưa trên tàu, tiếp tục tham quan các đảo; \r\n     Ngày 3: Ăn sáng tại khách sạn, tham quan và ăn trưa tại nhà hàng địa phương, trở về Hà Nội, ăn tối tại nhà hàng ở Hà Nội.', '2024-01-15 08:00:00', 'public/uploads/images/tours/ha-long.jpg', 'Ẩm thực: Buffet sáng, Theo thực đơn, Đặc sản địa phương; Đối tượng thích hợp: Cặp đôi, Gia đình nhiều thế hệ, Thanh niên; Thời gian lý tưởng: Mùa hè; Khuyến mãi: Giảm 20% cho các khách hàng đặt trước.', '2024-12-13 10:00:00', NULL, 2),
(24, 'Sa Pa: Khám phá Fansipan', 2500000, 'Sa Pa', 'Hà Nội', '2 Ngày 1 Đêm', 'Ngày 1: Hà Nội - Sa Pa, ăn trưa tại nhà hàng địa phương, tham quan Fansipan; \r\n     Ngày 2: Tham quan Fansipan, ăn trưa tại nhà hàng, trở về Hà Nội, ăn tối tại nhà hàng trên đường về.', '2024-01-20 06:00:00', 'public/uploads/images/tours/sapa.png', 'Ẩm thực: Đặc sản vùng cao; Đối tượng: Gia đình, Thanh niên; Thời gian lý tưởng: Mùa đông; Khuyến mãi: Giảm 10% cho nhóm từ 4 người trở lên.', '2024-12-13 10:00:00', NULL, 2),
(25, 'Mộc Châu: Đồi chè - thác Dải Yếm', 2200000, 'Mộc Châu', 'Hà Nội', '2 Ngày 1 Đêm', 'Ngày 1: Hà Nội - Mộc Châu, ăn trưa tại nhà hàng, tham quan đồi chè, thác Dải Yếm; \r\n     Ngày 2: Ăn sáng tại khách sạn, tham quan các bản làng, ăn trưa tại nhà hàng, trở về Hà Nội, ăn tối tại nhà hàng ở Hà Nội.', '2024-02-05 07:00:00', 'public/uploads/images/tours/moc-chau.jpg', 'Ẩm thực: Đặc sản vùng núi; Đối tượng thích hợp: Gia đình, Bạn bè; Thời gian lý tưởng: Mùa xuân và mùa thu; Khuyến mãi: Giảm giá 15% cho nhóm từ 4 người trở lên.', '2024-12-13 10:00:00', NULL, 2),
(26, 'Ninh Bình: Tràng An - Bái Đính', 1200000, 'Ninh Bình', 'Hà Nội', '1 Ngày', 'Buổi sáng: Hà Nội - Tràng An, ăn trưa tại nhà hàng; Buổi chiều: Tham quan chùa Bái Đính, ăn tối tại nhà hàng và trở về Hà Nội, ăn tối tại nhà hàng ở Hà Nội.', '2024-01-10 07:30:00', 'public/uploads/images/tours/ninh-binh.jpg', 'Ẩm thực: Món đặc sản Ninh Bình; Đối tượng thích hợp: Gia đình, Bạn bè; Thời gian lý tưởng: Mùa xuân; Khuyến mãi: Giảm 10% cho nhóm từ 5 người trở lên.', '2024-12-13 10:00:00', NULL, 2),
(27, 'Hà Giang: Đồng Văn - Lũng Cú', 3000000, 'Hà Giang', 'Hà Nội', '3 Ngày 2 Đêm', 'Ngày 1: Hà Nội - Hà Giang, ăn trưa tại nhà hàng, tham quan các địa danh; \r\n     Ngày 2: Tham quan Đồng Văn, ăn trưa tại nhà hàng, tham quan cột cờ Lũng Cú, ăn tối tại nhà hàng; \r\n     Ngày 3: Ăn sáng tại khách sạn, tham quan và ăn trưa tại nhà hàng, trở về Hà Nội, ăn tối tại nhà hàng ở Hà Nội.', '2024-01-22 06:00:00', 'public/uploads/images/tours/ha-giang.jpg', 'Ẩm thực: Đặc sản dân tộc vùng cao, như bánh cuốn, thịt trâu gác bếp; Đối tượng thích hợp: Phượt thủ, Gia đình; Thời gian lý tưởng: Mùa xuân và mùa thu; Khuyến mãi: Giảm 5% cho khách đăng ký trước 30 ngày.', '2024-12-13 10:00:00', NULL, 2),
(28, 'Mai Châu: Bản Làng - Thác', 1500000, 'Mai Châu', 'Hà Nội', '2 Ngày 1 Đêm', 'Ngày 1: Hà Nội - Mai Châu, ăn trưa tại nhà hàng, tham quan bản làng, thác; \r\n     Ngày 2: Ăn sáng tại khách sạn, tham quan các điểm du lịch, ăn trưa tại nhà hàng, trở về Hà Nội, ăn tối tại nhà hàng ở Hà Nội.', '2024-03-10 08:00:00', 'public/uploads/images/tours/mai-chau.jpg', 'Ẩm thực: Thực đơn đặc trưng dân tộc Thái; Đối tượng thích hợp: Cặp đôi, Gia đình; Thời gian lý tưởng: Mùa hè và mùa thu; Khuyến mãi: Giảm 10% cho khách đặt sớm.', '2024-12-13 10:00:00', NULL, 2),
(29, 'Tam Đảo: Chùa Tây Thiên - Thác Bạc', 1800000, 'Tam Đảo', 'Hà Nội', '1 Ngày', 'Buổi sáng: Hà Nội - Tam Đảo, ăn trưa tại nhà hàng; Buổi chiều: Tham quan chùa Tây Thiên, thác Bạc, ăn tối tại nhà hàng và trở về Hà Nội, ăn tối tại nhà hàng ở Hà Nội.', '2024-01-15 07:00:00', 'public/uploads/images/tours/tam-dao.jpeg', 'Ẩm thực: Món ăn đặc sản Tam Đảo; Đối tượng thích hợp: Gia đình, Bạn bè; Thời gian lý tưởng: Mùa xuân và mùa hè; Khuyến mãi: Giảm 10% cho các đoàn nhóm.', '2024-12-13 10:00:00', NULL, 2),
(30, 'Cát Bà: Vịnh Lan Hạ - Đảo Khỉ', 3200000, 'Cát Bà', 'Hà Nội', '3 Ngày 2 Đêm', 'Ngày 1: Hà Nội - Cát Bà, ăn trưa tại nhà hàng, tham quan vịnh Lan Hạ; \r\n     Ngày 2: Tham quan Đảo Khỉ, ăn trưa tại nhà hàng, tiếp tục tham quan các đảo; \r\n     Ngày 3: Ăn sáng tại khách sạn, tham quan và ăn trưa tại nhà hàng, trở về Hà Nội, ăn tối tại nhà hàng ở Hà Nội.', '2024-04-05 08:00:00', 'public/uploads/images/tours/cat-ba.jpg', 'Ẩm thực: Hải sản tươi ngon, đặc sản Cát Bà; Đối tượng thích hợp: Gia đình, Bạn bè, Cặp đôi; Thời gian lý tưởng: Mùa hè; Khuyến mãi: Giảm 10% cho các khách đặt sớm.', '2024-12-13 10:00:00', NULL, 2),
(31, 'Yên Bái: Ruộng Bậc Thang - Mù Cang Chải', 2700000, 'Yên Bái', 'Hà Nội', '2 Ngày 1 Đêm', 'Ngày 1: Hà Nội - Yên Bái, ăn trưa tại nhà hàng, tham quan ruộng bậc thang Mù Cang Chải; \r\n     Ngày 2: Ăn sáng tại khách sạn, tham quan các điểm du lịch, ăn trưa tại nhà hàng, trở về Hà Nội, ăn tối tại nhà hàng ở Hà Nội.', '2024-02-18 06:30:00', 'public/uploads/images/tours/yen-bai.jpg', 'Ẩm thực: Đặc sản vùng núi Tây Bắc; Đối tượng thích hợp: Phượt thủ, Gia đình; Thời gian lý tưởng: Mùa thu; Khuyến mãi: Giảm 10% cho nhóm từ 4 người trở lên.', '2024-12-13 10:00:00', NULL, 2),
(32, 'Hòa Bình: Suối Nước Nóng Kim Bôi', 2000000, 'Hòa Bình', 'Hà Nội', '2 Ngày 1 Đêm', 'Ngày 1: Hà Nội - Hòa Bình, ăn trưa tại nhà hàng, tham quan suối nước nóng Kim Bôi; \r\n     Ngày 2: Ăn sáng tại khách sạn, thư giãn tại suối nước nóng, ăn trưa tại nhà hàng, trở về Hà Nội, ăn tối tại nhà hàng ở Hà Nội.', '2024-02-25 07:00:00', 'public/uploads/images/tours/hoa-binh.jpg', 'Ẩm thực: Đặc sản Hòa Bình, các món ăn từ thịt trâu, cá suối; Đối tượng thích hợp: Người yêu thiên nhiên, Gia đình, Cặp đôi; Thời gian lý tưởng: Mùa xuân và mùa thu; Khuyến mãi: Giảm 20% cho các khách hàng đặt trước.', '2024-12-13 10:00:00', NULL, 2),
(33, 'Thái Nguyên: Bảo Tàng Trà - Đồi Chè', 1000000, 'Thái Nguyên', 'Hà Nội', '1 Ngày', 'Buổi sáng: Hà Nội - Thái Nguyên, ăn trưa tại nhà hàng; Buổi chiều: Tham quan Bảo tàng Trà, đồi chè, ăn tối tại nhà hàng và trở về Hà Nội, ăn tối tại nhà hàng ở Hà Nội.', '2024-03-12 07:00:00', 'public/uploads/images/tours/thai-nguyen.jpg', 'Tìm hiểu về văn hóa trà và tham quan các đồi chè; Khuyến mãi: Giảm 10% cho nhóm từ 5 người trở lên.', '2024-12-13 10:00:00', NULL, 2),
(34, 'Huế: Tham quan Kinh Thành Huế', 3000000, 'Huế', 'Đà Nẵng', '2 Ngày 1 Đêm', 'Ngày 1: Đà Nẵng - Huế, ăn trưa tại nhà hàng, tham quan Kinh Thành Huế, Đại Nội; \r\n     Ngày 2: Ăn sáng tại khách sạn, tham quan chùa Thiên Mụ, ăn trưa tại nhà hàng, trở về Đà Nẵng, ăn tối tại nhà hàng.', '2024-02-01 08:00:00', 'public/uploads/images/tours/hue.jpg', 'Ẩm thực: Đặc sản Huế, Bánh bèo, Bánh cuốn; Đối tượng thích hợp: Gia đình, Cặp đôi, Du khách yêu thích lịch sử; Thời gian lý tưởng: Mùa xuân, mùa hè; Khuyến mãi: Giảm 10% cho nhóm từ 5 người.', '2024-12-13 09:00:00', NULL, 3),
(35, 'Đà Nẵng: Ngũ Hành Sơn - Bà Nà Hills', 2500000, 'Đà Nẵng', 'Hà Nội', '2 Ngày 1 Đêm', 'Ngày 1: Hà Nội - Đà Nẵng, ăn trưa tại nhà hàng, tham quan Ngũ Hành Sơn, Bà Nà Hills; \r\n     Ngày 2: Ăn sáng tại khách sạn, tham quan các điểm du lịch khác, ăn trưa tại nhà hàng, trở về Hà Nội, ăn tối tại nhà hàng.', '2024-02-05 07:30:00', 'public/uploads/images/tours/da-nang.png', 'Ẩm thực: Mì Quảng, Bánh tráng cuốn thịt heo; Đối tượng thích hợp: Gia đình, Bạn bè, Du khách thích khám phá thiên nhiên; Thời gian lý tưởng: Mùa hè, mùa thu; Khuyến mãi: Giảm 15% cho khách đặt trước.', '2024-12-13 10:15:00', NULL, 3),
(36, 'Quảng Nam: Hội An - Mỹ Sơn', 2800000, 'Quảng Nam', 'Đà Nẵng', '3 Ngày 2 Đêm', 'Ngày 1: Đà Nẵng - Hội An, ăn trưa tại nhà hàng, tham quan Phố cổ Hội An; \r\n     Ngày 2: Tham quan Thánh địa Mỹ Sơn, ăn trưa tại nhà hàng, tiếp tục tham quan các điểm du lịch khác; \r\n     Ngày 3: Ăn sáng tại khách sạn, tham quan và ăn trưa tại nhà hàng, trở về Đà Nẵng.', '2024-02-10 06:30:00', 'public/uploads/images/tours/quang-nam.jpg', 'Ẩm thực: Cao Lầu, Hoành Thánh, Bánh Đập; Đối tượng thích hợp: Gia đình, Cặp đôi, Du khách yêu thích văn hóa; Thời gian lý tưởng: Mùa xuân, mùa hè; Khuyến mãi: Giảm 10% cho nhóm từ 4 người.', '2024-12-13 11:30:00', NULL, 3),
(37, 'Nha Trang: Vinpearl Land - Tháp Bà Ponagar', 3500000, 'Nha Trang', 'Hà Nội', '3 Ngày 2 Đêm', 'Ngày 1: Hà Nội - Nha Trang, ăn trưa tại nhà hàng, tham quan Vinpearl Land, Tháp Bà Ponagar; \r\n     Ngày 2: Tham quan các điểm du lịch, ăn trưa tại nhà hàng, tham quan đảo Hòn Mun; \r\n     Ngày 3: Ăn sáng tại khách sạn, tham quan và ăn trưa tại nhà hàng, trở về Hà Nội.', '2024-02-15 07:00:00', 'public/uploads/images/tours/nha-trang.jpg', 'Ẩm thực: Hải sản tươi ngon, Món ăn đặc trưng Nha Trang; Đối tượng thích hợp: Gia đình, Cặp đôi, Bạn bè; Thời gian lý tưởng: Mùa hè; Khuyến mãi: Giảm 20% cho khách đặt trước.', '2024-12-13 12:00:00', NULL, 3),
(38, 'Quảng Bình: Phong Nha - Kẻ Bàng', 3200000, 'Quảng Bình', 'Hà Nội', '3 Ngày 2 Đêm', 'Ngày 1: Hà Nội - Quảng Bình, ăn trưa tại nhà hàng, tham quan Động Phong Nha; \r\n     Ngày 2: Tham quan Động Sơn Đoòng, ăn trưa tại nhà hàng, tham quan Vườn Quốc Gia Phong Nha-Kẻ Bàng; \r\n     Ngày 3: Ăn sáng tại khách sạn, tham quan các điểm du lịch, ăn trưa tại nhà hàng, trở về Hà Nội.', '2024-02-20 06:45:00', 'public/uploads/images/tours/quang-binh.jpeg', 'Ẩm thực: Món ăn Quảng Bình, Hải sản tươi ngon; Đối tượng thích hợp: Gia đình, Bạn bè, Du khách yêu thích thiên nhiên; Thời gian lý tưởng: Mùa xuân, mùa thu; Khuyến mãi: Giảm 15% cho khách đăng ký trước.', '2024-12-13 13:15:00', NULL, 3),
(39, 'Quảng Trị: Cửa Tùng - Hồ Con Rùa', 2200000, 'Quảng Trị', 'Đà Nẵng', '2 Ngày 1 Đêm', 'Ngày 1: Đà Nẵng - Quảng Trị, ăn trưa tại nhà hàng, tham quan Cửa Tùng, Hồ Con Rùa; \r\n     Ngày 2: Ăn sáng tại khách sạn, tham quan các điểm du lịch khác, ăn trưa tại nhà hàng, trở về Đà Nẵng.', '2024-02-25 08:00:00', 'public/uploads/images/tours/quang-tri.jpg', 'Ẩm thực: Đặc sản Quảng Trị, Món ăn dân dã miền Trung; Đối tượng thích hợp: Gia đình, Bạn bè, Du khách yêu thích lịch sử; Thời gian lý tưởng: Mùa xuân, mùa thu; Khuyến mãi: Giảm 10% cho nhóm từ 3 người.', '2024-12-13 14:00:00', NULL, 3),
(40, 'Bình Định: Kỳ Co - Eo Gió', 2400000, 'Bình Định', 'Đà Nẵng', '2 Ngày 1 Đêm', 'Ngày 1: Đà Nẵng - Bình Định, ăn trưa tại nhà hàng, tham quan Kỳ Co, Eo Gió; \r\n     Ngày 2: Ăn sáng tại khách sạn, tham quan các điểm du lịch khác, ăn trưa tại nhà hàng, trở về Đà Nẵng.', '2024-03-01 06:30:00', 'public/uploads/images/tours/binh-dinh.jpg', 'Ẩm thực: Bánh xèo, Mỳ Quảng, Hải sản tươi sống; Đối tượng thích hợp: Gia đình, Cặp đôi, Bạn bè; Thời gian lý tưởng: Mùa hè; Khuyến mãi: Giảm 15% cho khách đặt nhóm.', '2024-12-13 15:00:00', NULL, 3),
(41, 'Kon Tum: Rừng Tràm - Đồi Chè', 2600000, 'Kon Tum', 'Đà Nẵng', '3 Ngày 2 Đêm', 'Ngày 1: Đà Nẵng - Kon Tum, ăn trưa tại nhà hàng, tham quan Rừng Tràm; \r\n     Ngày 2: Tham quan Đồi Chè, tham quan các làng dân tộc; \r\n     Ngày 3: Ăn sáng tại khách sạn, tham quan các điểm du lịch khác, ăn trưa tại nhà hàng, trở về Đà Nẵng.', '2024-03-05 07:15:00', 'public/uploads/images/tours/kon-tum.jpg', 'Ẩm thực: Món ăn miền Tây, Đặc sản Kon Tum; Đối tượng thích hợp: Gia đình, Du khách yêu thích khám phá thiên nhiên; Thời gian lý tưởng: Mùa thu, mùa xuân; Khuyến mãi: Giảm 10% cho nhóm từ 4 người.', '2024-12-13 16:00:00', NULL, 3),
(42, 'Thanh Hóa: Sầm Sơn - Cửa Lò', 2700000, 'Thanh Hóa', 'Hà Nội', '3 Ngày 2 Đêm', 'Ngày 1: Hà Nội - Thanh Hóa, ăn trưa tại nhà hàng, tham quan Sầm Sơn, biển Cửa Lò; \r\n     Ngày 2: Tham quan các điểm du lịch, ăn trưa tại nhà hàng, tiếp tục tham quan biển; \r\n     Ngày 3: Ăn sáng tại khách sạn, tham quan các điểm du lịch khác, ăn trưa tại nhà hàng, trở về Hà Nội.', '2024-03-10 09:00:00', 'public/uploads/images/tours/thanh-hoa.jpg', 'Ẩm thực: Hải sản, Đặc sản biển; Đối tượng thích hợp: Gia đình, Bạn bè, Du khách yêu thích biển; Thời gian lý tưởng: Mùa hè; Khuyến mãi: Giảm 10% cho nhóm từ 5 người.', '2024-12-13 17:30:00', NULL, 3),
(43, 'Quảng Ngãi: Lý Sơn - Núi Thiên Ấn', 3300000, 'Quảng Ngãi', 'Hồ Chí Minh', '3 Ngày 2 Đêm', 'Ngày 1: Hồ Chí Minh - Quảng Ngãi, ăn trưa tại nhà hàng, tham quan đảo Lý Sơn; \r\n     Ngày 2: Tham quan Núi Thiên Ấn, ăn trưa tại nhà hàng, tham quan các đảo nhỏ khác; \r\n     Ngày 3: Ăn sáng tại khách sạn, tham quan và ăn trưa tại nhà hàng, trở về Hồ Chí Minh.', '2024-03-15 08:30:00', 'public/uploads/images/tours/quang-ngai.jpg', 'Ẩm thực: Hải sản Lý Sơn, Đặc sản Quảng Ngãi; Đối tượng thích hợp: Gia đình, Bạn bè, Du khách yêu thích thiên nhiên; Thời gian lý tưởng: Mùa xuân, mùa hè; Khuyến mãi: Giảm 15% cho khách đặt trước.', '2024-12-13 18:00:00', NULL, 3),
(44, 'Phú Yên: Ghềnh Đá Đĩa - Bãi Xép', 3200000, 'Phú Yên', 'Hà Nội', '2 Ngày 1 Đêm', 'Ngày 1: Hà Nội - Phú Yên, ăn trưa tại nhà hàng, tham quan Ghềnh Đá Đĩa, Bãi Xép; \r\n     Ngày 2: Ăn sáng tại khách sạn, tham quan các điểm du lịch khác, ăn trưa tại nhà hàng, trở về Hà Nội.', '2024-03-20 07:00:00', 'public/uploads/images/tours/phu-yen.jpg', 'Ẩm thực: Hải sản tươi sống, Bánh hỏi; Đối tượng thích hợp: Gia đình, Bạn bè, Du khách yêu thích khám phá thiên nhiên; Thời gian lý tưởng: Mùa hè, mùa thu; Khuyến mãi: Giảm 10% cho khách đặt nhóm.', '2024-12-13 18:30:00', NULL, 3),
(45, 'Gia Lai: Hồ T’nưng - Núi Hàm Rồng', 3100000, 'Gia Lai', 'Đà Nẵng', '3 Ngày 2 Đêm', 'Ngày 1: Đà Nẵng - Gia Lai, ăn trưa tại nhà hàng, tham quan Hồ T’nưng, Núi Hàm Rồng; \r\n     Ngày 2: Tham quan các thác nước, ăn trưa tại nhà hàng, tiếp tục khám phá thiên nhiên; \r\n     Ngày 3: Ăn sáng tại khách sạn, tham quan và ăn trưa tại nhà hàng, trở về Đà Nẵng.', '2024-03-25 08:00:00', 'public/uploads/images/tours/gia-lai.jpeg', 'Ẩm thực: Món ăn Gia Lai, đặc sản Tây Nguyên; Đối tượng thích hợp: Gia đình, Bạn bè, Du khách yêu thích thiên nhiên; Thời gian lý tưởng: Mùa xuân, mùa hè; Khuyến mãi: Giảm 15% cho khách đặt nhóm.', '2024-12-13 19:00:00', NULL, 3),
(46, 'Hà Nội - Đà Nẵng - Hội An', 4000000, 'Hà Nội, Đà Nẵng, Hội An', 'Hà Nội', '4 Ngày 3 Đêm', 'Ngày 1: Hà Nội - Đà Nẵng, tham quan Ngũ Hành Sơn và bãi biển Mỹ Khê, ăn trưa tại nhà hàng; \r\n     Ngày 2: Tham quan Bà Nà Hills, ăn trưa trên đỉnh núi, tham quan Hội An vào buổi chiều, ăn tối tại nhà hàng Hội An; \r\n     Ngày 3: Tham quan phố cổ Hội An, ăn trưa tại nhà hàng, tham quan các làng nghề t', '2024-01-20 08:00:00', 'public/uploads/images/tours/hanoi-da-nang-hoi-an.jpg', 'Ẩm thực: Mì Quảng, Cao Lầu, Phở, Đặc sản miền Trung; Đối tượng thích hợp: Gia đình, Cặp đôi, Du khách yêu thích di sản và lịch sử; Thời gian lý tưởng: Mùa xuân, Mùa thu; Khuyến mãi: Giảm 15% cho nhóm từ 5 người.', '2024-12-13 08:00:00', NULL, 4),
(47, 'Hồ Chí Minh - Nha Trang - Đà Lạt', 4500000, 'Hồ Chí Minh, Nha Trang, Đà Lạt', 'Hồ Chí Minh', '5 Ngày 4 Đêm', 'Ngày 1: Hồ Chí Minh - Nha Trang, tham quan Vinpearl Land, ăn trưa tại nhà hàng; \r\n     Ngày 2: Tham quan đảo Hòn Mun, ăn trưa tại nhà hàng trên đảo; \r\n     Ngày 3: Di chuyển từ Nha Trang đến Đà Lạt, tham quan Thung Lũng Tình Yêu, ăn trưa tại nhà hàng Đà Lạt; \r\n     Ngày 4: Tham quan hồ Xuân Hương, ă', '2024-02-15 09:00:00', 'public/uploads/images/tours/ho-chi-minh-nha-trang-da-lat.jpg', 'Ẩm thực: Hải sản tươi sống, Bánh căn, Bánh tráng nướng, Đặc sản Đà Lạt; Đối tượng thích hợp: Gia đình, Bạn bè, Du khách yêu thích biển và núi; Thời gian lý tưởng: Mùa xuân, Mùa hè; Khuyến mãi: Giảm 10% cho khách nhóm từ 6 người.', '2024-12-13 09:00:00', NULL, 4),
(48, 'Hà Nội - Phú Quốc', 5000000, 'Hà Nội, Phú Quốc', 'Hà Nội', '4 Ngày 3 Đêm', 'Ngày 1: Hà Nội - Phú Quốc, tham quan Vinpearl Safari, ăn trưa tại nhà hàng; \r\n     Ngày 2: Tham quan đảo Ngọc, ăn trưa tại nhà hàng trên đảo; \r\n     Ngày 3: Tham quan các bãi biển Phú Quốc, ăn trưa tại nhà hàng, tham quan chợ Dương Đông; \r\n     Ngày 4: Trở về Hà Nội, ăn trưa tại nhà hàng ở Hà Nội.', '2024-03-10 08:00:00', 'public/uploads/images/tours/ha-noi-phu-quoc.jpg', 'Ẩm thực: Hải sản Phú Quốc, Đặc sản địa phương, Món ăn Việt Nam; Đối tượng thích hợp: Cặp đôi, Gia đình, Du khách yêu thích nghỉ dưỡng và biển; Thời gian lý tưởng: Mùa hè, Mùa thu; Khuyến mãi: Giảm 20% cho khách đặt sớm.', '2024-12-13 10:00:00', NULL, 4),
(49, 'Hà Nội - Cần Thơ', 3700000, 'Hà Nội, Cần Thơ', 'Hà Nội', '3 Ngày 2 Đêm', 'Ngày 1: Hà Nội - Cần Thơ, tham quan chợ nổi Cái Răng, ăn trưa tại nhà hàng; \r\n     Ngày 2: Tham quan vườn trái cây, ăn trưa tại nhà hàng, tham quan các làng nghề miền Tây; \r\n     Ngày 3: Trở về Hà Nội, ăn trưa tại nhà hàng tại Hà Nội.', '2024-03-15 07:30:00', 'public/uploads/images/tours/ha-noi-can-tho.jpg', 'Ẩm thực: Đặc sản miền Tây, Cơm gà, Gỏi cuốn, Bánh xèo; Đối tượng thích hợp: Gia đình, Bạn bè, Du khách yêu thích khám phá miền sông nước; Thời gian lý tưởng: Mùa xuân, Mùa hè; Khuyến mãi: Giảm 15% cho nhóm từ 4 người.', '2024-12-13 11:00:00', NULL, 4),
(50, 'Đà Nẵng - Hà Nội', 4200000, 'Đà Nẵng, Hà Nội', 'Đà Nẵng', '3 Ngày 2 Đêm', 'Ngày 1: Đà Nẵng - Hà Nội, tham quan Hồ Gươm và phố cổ, ăn trưa tại nhà hàng; \r\n     Ngày 2: Tham quan các di tích lịch sử Hà Nội, ăn trưa tại nhà hàng, tham quan chùa Một Cột, Hoàng thành Thăng Long; \r\n     Ngày 3: Tự do tham quan, ăn trưa tại nhà hàng, trở về Đà Nẵng.', '2024-04-01 08:00:00', 'public/uploads/images/tours/da-nang-ha-noi.jpg', 'Ẩm thực: Phở, Bánh cuốn, Đặc sản Hà Nội; Đối tượng thích hợp: Du khách yêu thích lịch sử và di sản văn hóa; Thời gian lý tưởng: Mùa thu, Mùa xuân; Khuyến mãi: Giảm 20% cho khách đăng ký nhóm từ 5 người.', '2024-12-13 12:00:00', NULL, 4),
(51, 'Hà Nội - Ninh Bình - Sapa', 4700000, 'Hà Nội, Ninh Bình, Sapa', 'Hà Nội', '5 Ngày 4 Đêm', 'Ngày 1: Hà Nội - Ninh Bình, tham quan Tam Cốc, ăn trưa tại nhà hàng; \r\n     Ngày 2: Tham quan Tràng An, ăn trưa tại nhà hàng, tham quan chùa Bái Đính; \r\n     Ngày 3: Di chuyển từ Ninh Bình đến Sapa, tham quan Thác Bạc, ăn trưa tại nhà hàng Sapa; \r\n     Ngày 4: Tham quan bản Cát Cát, ăn trưa tại nhà ', '2024-04-10 08:00:00', 'public/uploads/images/tours/ha-noi-ninh-binh-sapa.jpg', 'Ẩm thực: Cơm cháy Ninh Bình, Lẩu cá Sapa, Đặc sản địa phương; Đối tượng thích hợp: Du khách yêu thích thiên nhiên, gia đình, nhóm bạn; Thời gian lý tưởng: Mùa xuân, Mùa thu; Khuyến mãi: Giảm 10% cho khách đặt trước.', '2024-12-13 13:00:00', NULL, 4),
(52, 'Đà Nẵng - Phú Yên - Nha Trang', 4800000, 'Đà Nẵng, Phú Yên, Nha Trang', 'Đà Nẵng', '4 Ngày 3 Đêm', 'Ngày 1: Đà Nẵng - Phú Yên, tham quan Ghềnh Đá Đĩa, ăn trưa tại nhà hàng; \r\n     Ngày 2: Tham quan bãi Xép và bãi Môn, ăn trưa tại nhà hàng; \r\n     Ngày 3: Di chuyển từ Phú Yên đến Nha Trang, tham quan Hòn Mun, ăn trưa trên đảo; \r\n     Ngày 4: Tham quan Vinpearl Nha Trang, ăn trưa tại nhà hàng, tham ', '2024-05-05 09:00:00', 'public/uploads/images/tours/da-nang-phu-yen-nha-trang.jpg', 'Ẩm thực: Hải sản, Bánh căn, Phở, Đặc sản miền Trung; Đối tượng thích hợp: Gia đình, Bạn bè, Du khách yêu thích biển và đảo; Thời gian lý tưởng: Mùa hè, Mùa thu; Khuyến mãi: Giảm 15% cho nhóm từ 4 người.', '2024-12-13 14:00:00', NULL, 4),
(53, 'Hà Nội - Hạ Long - Sapa', 5200000, 'Hà Nội, Hạ Long, Sapa', 'Hà Nội', '5 Ngày 4 Đêm', 'Ngày 1: Hà Nội - Hạ Long, tham quan Vịnh Hạ Long, ăn trưa trên tàu; \r\n     Ngày 2: Tham quan các đảo và hang động, ăn trưa tại nhà hàng trên đảo; \r\n     Ngày 3: Di chuyển từ Hạ Long đến Sapa, tham quan bản Cát Cát, ăn trưa tại nhà hàng Sapa; \r\n     Ngày 4: Tham quan đỉnh Fansipan, ăn trưa tại nhà hà', '2024-06-01 10:00:00', 'public/uploads/images/tours/ha-noi-ha-long-sapa.jpg', 'Ẩm thực: Phở, Lẩu cá Sapa, Đặc sản Hạ Long, Bánh cuốn Hà Nội; Đối tượng thích hợp: Du khách yêu thích thiên nhiên, lịch sử và di sản; Thời gian lý tưởng: Mùa xuân, Mùa thu; Khuyến mãi: Giảm 20% cho khách đăng ký sớm.', '2024-12-13 15:00:00', NULL, 4),
(54, 'Hồ Chí Minh - Vũng Tàu - Phan Thiết', 4500000, 'Hồ Chí Minh, Vũng Tàu, Phan Thiết', 'Hồ Chí Minh', '4 Ngày 3 Đêm', 'Ngày 1: Hồ Chí Minh - Vũng Tàu, tham quan bãi biển, ăn trưa tại nhà hàng; \r\n     Ngày 2: Tham quan khu du lịch Hồ Mây, ăn trưa tại nhà hàng, tham quan Chùa Nghinh Phong; \r\n     Ngày 3: Di chuyển từ Vũng Tàu đến Phan Thiết, tham quan bãi biển Mũi Né, ăn trưa tại nhà hàng; \r\n     Ngày 4: Tham quan thá', '2024-07-10 08:30:00', 'public/uploads/images/tours/ho-chi-minh-vung-tau-phan-thiet.jpg', 'Ẩm thực: Hải sản Vũng Tàu, Bánh canh, Đặc sản Phan Thiết; Đối tượng thích hợp: Gia đình, Du khách yêu thích biển và nghỉ dưỡng; Thời gian lý tưởng: Mùa hè, Mùa thu; Khuyến mãi: Giảm 10% cho khách nhóm từ 5 người.', '2024-12-13 16:00:00', NULL, 4),
(55, 'Đà Lạt - Hồ Chí Minh', 4600000, 'Đà Lạt, Hồ Chí Minh', 'Đà Lạt', '3 Ngày 2 Đêm', 'Ngày 1: Đà Lạt - Hồ Chí Minh, tham quan Đền Hùng, ăn trưa tại nhà hàng; \r\n     Ngày 2: Tham quan Nhà thờ Đức Bà, chợ Bến Thành, ăn trưa tại nhà hàng; \r\n     Ngày 3: Tham quan Dinh Độc Lập, ăn trưa tại nhà hàng, trở về Đà Lạt.', '2024-08-05 08:00:00', 'public/uploads/images/tours/da-lat-ho-chi-minh.jpg', 'Ẩm thực: Cơm tấm, Phở, Bánh xèo; Đối tượng thích hợp: Du khách yêu thích khám phá, gia đình, bạn bè; Thời gian lý tưởng: Mùa xuân, Mùa hè; Khuyến mãi: Giảm 15% cho khách nhóm từ 4 người.', '2024-12-13 17:00:00', NULL, 4),
(56, 'Nha Trang - Đà Lạt', 4300000, 'Nha Trang, Đà Lạt', 'Nha Trang', '3 Ngày 2 Đêm', 'Ngày 1: Nha Trang - Đà Lạt, tham quan Thác Pongour, ăn trưa tại nhà hàng; \r\n     Ngày 2: Tham quan Hồ Xuân Hương, vườn hoa Đà Lạt, ăn trưa tại nhà hàng Đà Lạt; \r\n     Ngày 3: Tham quan Dinh Bảo Đại, ăn trưa tại nhà hàng, trở về Nha Trang.', '2024-09-01 08:00:00', 'public/uploads/images/tours/nha-trang-da-lat.jpg', 'Ẩm thực: Bánh căn, Lẩu thả, Đặc sản Đà Lạt; Đối tượng thích hợp: Gia đình, Du khách yêu thích nghỉ dưỡng và khám phá thiên nhiên; Thời gian lý tưởng: Mùa xuân, Mùa thu; Khuyến mãi: Giảm 10% cho nhóm từ 3 người.', '2024-12-13 18:00:00', NULL, 4),
(57, 'Hà Nội - Huế - Phú Quốc', 4900000, 'Hà Nội, Huế, Phú Quốc', 'Hà Nội', '5 Ngày 4 Đêm', 'Ngày 1: Hà Nội - Huế, tham quan Đại Nội, ăn trưa tại nhà hàng; \r\n     Ngày 2: Tham quan lăng Tự Đức, ăn trưa tại nhà hàng, tham quan chùa Thiên Mụ; \r\n     Ngày 3: Di chuyển từ Huế đến Phú Quốc, tham quan Vinpearl Safari, ăn trưa tại nhà hàng; \r\n     Ngày 4: Tham quan các bãi biển Phú Quốc, ăn trưa t', '2024-10-01 09:00:00', 'public/uploads/images/tours/ha-noi-hue-phu-quoc.jpg', 'Ẩm thực: Bánh bèo Huế, Hải sản Phú Quốc, Đặc sản Hà Nội; Đối tượng thích hợp: Du khách yêu thích lịch sử, biển đảo và nghỉ dưỡng; Thời gian lý tưởng: Mùa hè, Mùa thu; Khuyến mãi: Giảm 20% cho khách đặt tour sớm.', '2024-12-13 19:00:00', NULL, 4);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `tour_images`
--

CREATE TABLE `tour_images` (
  `id` int(11) NOT NULL,
  `tour_id` int(11) DEFAULT NULL,
  `image_url` varchar(300) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `username` varchar(100) DEFAULT '',
  `avatar_url` varchar(300) DEFAULT 'public/uploads/images/user/avt-default.png',
  `fullname` varchar(100) DEFAULT '',
  `phone_number` varchar(10) NOT NULL,
  `email` varchar(100) DEFAULT '',
  `password` varchar(100) NOT NULL DEFAULT '',
  `activeToken` varchar(100) NOT NULL DEFAULT '',
  `forgotToken` varchar(100) NOT NULL DEFAULT '',
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `status` tinyint(1) DEFAULT 0,
  `role_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `users`
--

INSERT INTO `users` (`id`, `username`, `avatar_url`, `fullname`, `phone_number`, `email`, `password`, `activeToken`, `forgotToken`, `created_at`, `updated_at`, `status`, `role_id`) VALUES
(1, 'Admin', 'public/uploads/images/user/avt-default.png', 'Admin', '0357151521', 'admin@gmail.com', '$2y$10$K75zlRmNEejqMx1/lyt4heniBt860lwLxuaFU7bjs1SLm29pknUAq', '', '', '2024-12-13 15:24:17', NULL, 1, 2),
(2, 'Employee', 'public/uploads/images/user/avt-default.png', 'Employee', '0832847284', 'employee@gmail.com', '$2y$10$pSbKaXQ50/1cxBZtfHMfGOIHtKBWthpgKzLgXov4Rq5K60nVSAB4C', '', '', '2024-12-13 15:30:37', NULL, 1, 3),
(3, 'ManagerN', 'public/uploads/images/user/avt-default.png', 'Manager Miền Nam', '0473847284', 'managerN@gmail.com', '$2y$10$mtMZX0fHAOfhSh3DkzGRxulflXJ9quwD3aNdvC3hQOrwWbC5gb.i2', '', '', '2024-12-13 15:31:53', NULL, 1, 4),
(4, 'ManagerT', 'public/uploads/images/user/avt-default.png', 'Manager Miền Trung', '0836837363', 'managerT@gmail.com', '$2y$10$2qnx96ijy7RDscjFRzFNwOsNp/Tt4/85qQFQ3bQBe.wYjdcNMLHCm', '', '', '2024-12-13 15:32:56', NULL, 1, 4),
(5, 'ManagerB', 'public/uploads/images/user/avt-default.png', 'Manager Miền Bắc', '0758374829', 'managerB@gmail.com', '$2y$10$JsPN/4/Xm9EmSI9S2r5SJuwioso1OXgRFyoZsGltuZb0UXwJ5JUD2', '', '', '2024-12-13 15:33:36', NULL, 1, 4),
(6, 'tranminhhoa', 'public/uploads/images/user/avavt-default.png', 'Trần Minh Hòa', '0971234567', 'hoa.tran@gmail.com', '$2y$10$abcdEFghIjklmnopQRStuvWxYz1234567890abcdefgHIJKLmnoPQRStuv', '', '', '2024-12-14 09:00:00', NULL, 1, 1),
(7, 'nguyenthilan', 'public/uploads/images/user/avt-default.png', 'Nguyễn Thị Lan', '0912345678', 'lan.nguyen@gmail.com', '$2y$10$abcdEFghIjklmnopQRStuvWxYz1234567890abcdefgHIJKLmnoPQRStuv', '', '', '2024-12-14 09:15:00', NULL, 1, 1),
(8, 'lehoanganh', 'public/uploads/images/user/avt-default.png', 'Lê Hoàng Anh', '0934567890', 'hoanganh.le@gmail.com', '$2y$10$abcdEFghIjklmnopQRStuvWxYz1234567890abcdefgHIJKLmnoPQRStuv', '', '', '2024-12-14 09:30:00', NULL, 1, 1),
(9, 'phamvanduc', 'public/uploads/images/user/avt-default.png', 'Phạm Văn Đức', '0945678901', 'duc.pham@gmail.com', '$2y$10$abcdEFghIjklmnopQRStuvWxYz1234567890abcdefgHIJKLmnoPQRStuv', '', '', '2024-12-14 09:45:00', NULL, 1, 1),
(10, 'dothihuong', 'public/uploads/images/user/avt-default.png', 'Đỗ Thị Hương', '0966789012', 'huong.do@gmail.com', '$2y$10$abcdEFghIjklmnopQRStuvWxYz1234567890abcdefgHIJKLmnoPQRStuv', '', '', '2024-12-14 10:00:00', NULL, 1, 1),
(11, 'ngoducthinh', 'public/uploads/images/user/avt-default.png', 'Ngô Đức Thịnh', '0987890123', 'thinh.ngo@gmail.com', '$2y$10$abcdEFghIjklmnopQRStuvWxYz1234567890abcdefgHIJKLmnoPQRStuv', '', '', '2024-12-14 10:15:00', NULL, 1, 1),
(12, 'vuhaien', 'public/uploads/images/user/avt-default.png', 'Vũ Hải Yến', '0928901234', 'yen.vu@gmail.com', '$2y$10$abcdEFghIjklmnopQRStuvWxYz1234567890abcdefgHIJKLmnoPQRStuv', '', '', '2024-12-14 10:30:00', NULL, 1, 1),
(13, 'phananhtu', 'public/uploads/images/user/avt-default.png', 'Phan Anh Tú', '0939012345', 'tu.phan@gmail.com', '$2y$10$abcdEFghIjklmnopQRStuvWxYz1234567890abcdefgHIJKLmnoPQRStuv', '', '', '2024-12-14 10:45:00', NULL, 1, 1),
(14, 'buiminhngoc', 'public/uploads/images/user/avt-default.png', 'Bùi Minh Ngọc', '0950123456', 'ngoc.bui@gmail.com', '$2y$10$abcdEFghIjklmnopQRStuvWxYz1234567890abcdefgHIJKLmnoPQRStuv', '', '', '2024-12-14 11:00:00', NULL, 1, 1),
(15, 'trinhthuylinh', 'public/uploads/images/user/avt-default.png', 'Trịnh Thùy Linh', '0971234568', 'linh.trinh@gmail.com', '$2y$10$abcdEFghIjklmnopQRStuvWxYz1234567890abcdefgHIJKLmnoPQRStuv', '', '', '2024-12-14 11:15:00', NULL, 1, 1);

--
-- Chỉ mục cho các bảng đã đổ
--

--
-- Chỉ mục cho bảng `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`id`);

--
-- Chỉ mục cho bảng `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `tour_id` (`tour_id`);

--
-- Chỉ mục cho bảng `order_details`
--
ALTER TABLE `order_details`
  ADD PRIMARY KEY (`id`),
  ADD KEY `order_id` (`order_id`),
  ADD KEY `tour_id` (`tour_id`),
  ADD KEY `service_id` (`service_id`);

--
-- Chỉ mục cho bảng `reviews`
--
ALTER TABLE `reviews`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `tour_id` (`tour_id`);

--
-- Chỉ mục cho bảng `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`id`);

--
-- Chỉ mục cho bảng `services`
--
ALTER TABLE `services`
  ADD PRIMARY KEY (`id`),
  ADD KEY `service_category_id` (`service_category_id`);

--
-- Chỉ mục cho bảng `service_categories`
--
ALTER TABLE `service_categories`
  ADD PRIMARY KEY (`id`);

--
-- Chỉ mục cho bảng `tokenlogin`
--
ALTER TABLE `tokenlogin`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `token` (`token`),
  ADD KEY `user_id` (`user_id`);

--
-- Chỉ mục cho bảng `tours`
--
ALTER TABLE `tours`
  ADD PRIMARY KEY (`id`),
  ADD KEY `category_id` (`category_id`);

--
-- Chỉ mục cho bảng `tour_images`
--
ALTER TABLE `tour_images`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_images_tour_id` (`tour_id`);

--
-- Chỉ mục cho bảng `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD KEY `role_id` (`role_id`);

--
-- AUTO_INCREMENT cho các bảng đã đổ
--

--
-- AUTO_INCREMENT cho bảng `categories`
--
ALTER TABLE `categories`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT cho bảng `orders`
--
ALTER TABLE `orders`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT cho bảng `order_details`
--
ALTER TABLE `order_details`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=31;

--
-- AUTO_INCREMENT cho bảng `reviews`
--
ALTER TABLE `reviews`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT cho bảng `services`
--
ALTER TABLE `services`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=31;

--
-- AUTO_INCREMENT cho bảng `service_categories`
--
ALTER TABLE `service_categories`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT cho bảng `tokenlogin`
--
ALTER TABLE `tokenlogin`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT cho bảng `tours`
--
ALTER TABLE `tours`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=58;

--
-- AUTO_INCREMENT cho bảng `tour_images`
--
ALTER TABLE `tour_images`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT cho bảng `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- Các ràng buộc cho các bảng đã đổ
--

--
-- Các ràng buộc cho bảng `orders`
--
ALTER TABLE `orders`
  ADD CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `orders_ibfk_2` FOREIGN KEY (`tour_id`) REFERENCES `tours` (`id`);

--
-- Các ràng buộc cho bảng `order_details`
--
ALTER TABLE `order_details`
  ADD CONSTRAINT `order_details_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`),
  ADD CONSTRAINT `order_details_ibfk_2` FOREIGN KEY (`tour_id`) REFERENCES `tours` (`id`),
  ADD CONSTRAINT `order_details_ibfk_3` FOREIGN KEY (`service_id`) REFERENCES `services` (`id`);

--
-- Các ràng buộc cho bảng `reviews`
--
ALTER TABLE `reviews`
  ADD CONSTRAINT `reviews_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `reviews_ibfk_2` FOREIGN KEY (`tour_id`) REFERENCES `tours` (`id`);

--
-- Các ràng buộc cho bảng `services`
--
ALTER TABLE `services`
  ADD CONSTRAINT `services_ibfk_1` FOREIGN KEY (`service_category_id`) REFERENCES `service_categories` (`id`);

--
-- Các ràng buộc cho bảng `tokenlogin`
--
ALTER TABLE `tokenlogin`
  ADD CONSTRAINT `tokenlogin_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- Các ràng buộc cho bảng `tours`
--
ALTER TABLE `tours`
  ADD CONSTRAINT `tours_ibfk_1` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`);

--
-- Các ràng buộc cho bảng `tour_images`
--
ALTER TABLE `tour_images`
  ADD CONSTRAINT `fk_images_tour_id` FOREIGN KEY (`tour_id`) REFERENCES `tours` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `tour_images_ibfk_1` FOREIGN KEY (`tour_id`) REFERENCES `tours` (`id`);

--
-- Các ràng buộc cho bảng `users`
--
ALTER TABLE `users`
  ADD CONSTRAINT `users_ibfk_1` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
