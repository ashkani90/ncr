-- phpMyAdmin SQL Dump
-- version 4.9.0.1
-- https://www.phpmyadmin.net/
--
-- Host: sql210.infinityfree.com
-- Generation Time: Nov 01, 2026 at 01:37 AM
-- Server version: 11.4.13-MariaDB
-- PHP Version: 7.2.22

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `if0_42715068_ncr_system`
--

-- --------------------------------------------------------

--
-- Table structure for table `claims`
--

CREATE TABLE `claims` (
  `id` int(11) NOT NULL,
  `claim_number` varchar(50) NOT NULL,
  `claim_date` date NOT NULL,
  `ncr_number` varchar(50) DEFAULT NULL,
  `supplier_name` varchar(100) NOT NULL,
  `supplier_contact` varchar(50) DEFAULT NULL,
  `order_date` date DEFAULT NULL,
  `invoice_number` varchar(50) DEFAULT NULL,
  `part_code` varchar(50) NOT NULL,
  `part_name` varchar(100) NOT NULL,
  `quantity` int(11) NOT NULL,
  `unit` varchar(20) DEFAULT 'pcs',
  `return_reason` varchar(100) DEFAULT NULL,
  `return_reason_description` mediumtext DEFAULT NULL,
  `request_type` varchar(50) DEFAULT NULL,
  `claim_quantity` int(11) DEFAULT 0,
  `priority` varchar(20) DEFAULT 'medium',
  `claim_stage` int(11) DEFAULT 1,
  `ceo_status` varchar(20) DEFAULT 'pending',
  `supplier_status` varchar(20) DEFAULT 'pending',
  `final_status` varchar(20) DEFAULT 'open',
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `claims`
--

INSERT INTO `claims` (`id`, `claim_number`, `claim_date`, `ncr_number`, `supplier_name`, `supplier_contact`, `order_date`, `invoice_number`, `part_code`, `part_name`, `quantity`, `unit`, `return_reason`, `return_reason_description`, `request_type`, `claim_quantity`, `priority`, `claim_stage`, `ceo_status`, `supplier_status`, `final_status`, `created_at`, `updated_at`) VALUES
(1, 'CLM-2026-0001', '2026-09-01', 'NCR-2026-0013', 'تأمین‌کننده پارس یدک', '09121111111', '2026-08-20', 'INV-2026-1001', 'C-3001-01', 'کلاچ خودرو تیبا', 10, 'عدد', 'نشتی', 'نشتی روغن از کلاچ', 'مرجوعی', 2, 'high', 1, 'pending', 'pending', 'open', '2026-09-11 18:35:24', '2026-09-11 18:35:24'),
(2, 'CLM-2026-0002', '2026-09-02', 'NCR-2026-0014', 'تأمین‌کننده ایران ترمز', '09122222222', '2026-08-21', 'INV-2026-1002', 'B-4002-02', 'سیستم ترمز اتوبوس', 5, 'عدد', 'خرابی', 'افت فشار سیستم ترمز', 'مرجوعی', 5, 'critical', 2, 'approved', 'approved', 'in_progress', '2026-09-11 18:35:24', '2026-09-11 18:35:24'),
(3, 'CLM-2026-0003', '2026-09-03', 'NCR-2026-0015', 'تأمین‌کننده گیربکس سازان', '09123333333', '2026-08-22', 'INV-2026-1003', 'T-5003-03', 'گیربکس کامیونت', 3, 'عدد', 'صدای غیرعادی', 'صدای غیرعادی گیربکس', 'تعویض', 3, 'high', 2, 'approved', 'pending', 'in_progress', '2026-09-11 18:35:24', '2026-09-11 18:35:24'),
(4, 'CLM-2026-0004', '2026-09-04', 'NCR-2026-0016', 'تأمین‌کننده قالب سازان', '09124444444', '2026-08-23', 'INV-2026-1004', 'M-6004-04', 'درب مینی‌بوس', 8, 'عدد', 'انحراف ابعاد', 'انحراف ابعاد درب', 'اصلاح', 8, 'medium', 1, 'pending', 'pending', 'open', '2026-09-11 18:35:24', '2026-09-11 18:35:24'),
(5, 'CLM-2026-0005', '2026-09-05', 'NCR-2026-0017', 'تأمین‌کننده لنت پارس', '09125555555', '2026-08-24', 'INV-2026-1005', 'TR-7005-05', 'ترمز کشنده', 2, 'عدد', 'خرابی زودرس', 'خرابی زودرس لنت ترمز', 'مرجوعی', 2, 'critical', 3, 'approved', 'approved', 'closed', '2026-09-11 18:35:24', '2026-09-11 18:35:24'),
(6, 'CLM-2026-0006', '2026-09-06', 'NCR-2026-0018', 'تأمین‌کننده رادیاتور', '09126666666', '2026-08-25', 'INV-2026-1006', 'C-8006-06', 'رادیاتور خودرو', 12, 'عدد', 'نشتی', 'نشتی رادیاتور', 'تعویض', 12, 'medium', 1, 'pending', 'pending', 'open', '2026-09-11 18:35:24', '2026-09-11 18:35:24'),
(7, 'CLM-2026-0007', '2026-09-07', 'NCR-2026-0019', 'تأمین‌کننده صندلی سازان', '09127777777', '2026-08-26', 'INV-2026-1007', 'B-9007-07', 'صندلی اتوبوس', 20, 'عدد', 'پارگی', 'پارگی پارچه صندلی', 'مرجوعی', 20, 'low', 2, 'approved', 'approved', 'in_progress', '2026-09-11 18:35:24', '2026-09-11 18:35:24'),
(8, 'CLM-2026-0008', '2026-09-08', 'NCR-2026-0020', 'تأمین‌کننده فنر سازان', '09128888888', '2026-08-27', 'INV-2026-1008', 'T-1008-08', 'سیستم تعلیق کامیونت', 6, 'عدد', 'شکستگی', 'شکستگی فنر تعلیق', 'مرجوعی', 6, 'critical', 3, 'approved', 'approved', 'in_progress', '2026-09-11 18:35:24', '2026-09-11 18:35:24'),
(9, 'CLM-2026-0009', '2026-09-09', 'NCR-2026-0021', 'تأمین‌کننده تهویه سازان', '09129999999', '2026-08-28', 'INV-2026-1009', 'M-2009-09', 'سیستم تهویه', 4, 'عدد', 'عملکرد ضعیف', 'عملکرد ضعیف تهویه', 'اصلاح', 4, 'high', 2, 'approved', 'pending', 'in_progress', '2026-09-11 18:35:24', '2026-09-11 18:35:24'),
(10, 'CLM-2026-0010', '2026-09-10', 'NCR-2026-0022', 'تأمین‌کننده برق خودرو', '09120000000', '2026-08-29', 'INV-2026-1010', 'TR-3010-10', 'سیستم برق کشنده', 1, 'عدد', 'اتصال کوتاه', 'اتصال کوتاه سیستم برق', 'مرجوعی', 1, 'critical', 3, 'approved', 'approved', 'closed', '2026-09-11 18:35:24', '2026-09-11 18:35:24'),
(11, 'CLM-2026-0011', '2026-09-11', 'NCR-2026-0023', 'تأمین‌کننده یدک خودرو', '09121112222', '2026-08-30', 'INV-2026-1011', 'C-4011-11', 'درب خودرو', 7, 'عدد', 'لقی', 'لقی درب خودرو', 'اصلاح', 7, 'medium', 1, 'pending', 'pending', 'open', '2026-09-11 18:35:24', '2026-09-11 18:35:24'),
(12, 'CLM-2026-0012', '2026-09-12', 'NCR-2026-0024', 'تأمین‌کننده شیشه ایران', '09122223333', '2026-08-31', 'INV-2026-1012', 'B-5012-12', 'شیشه اتوبوس', 15, 'عدد', 'خش', 'خش در شیشه', 'مرجوعی', 15, 'high', 1, 'pending', 'pending', 'open', '2026-09-11 18:35:24', '2026-09-11 18:35:24'),
(13, 'CLM-2026-0013', '2026-09-13', 'NCR-2026-0025', 'تأمین‌کننده رنگ پارس', '09123334444', '2026-09-01', 'INV-2026-1013', 'T-6013-13', 'کاپوت کامیونت', 9, 'عدد', 'تغییر رنگ', 'تغییر رنگ کاپوت', 'اصلاح', 9, 'medium', 2, 'approved', 'approved', 'in_progress', '2026-09-11 18:35:24', '2026-09-11 18:35:24'),
(14, 'CLM-2026-0014', '2026-09-14', 'NCR-2026-0026', 'تأمین‌کننده چراغ سازان', '09124445555', '2026-09-02', 'INV-2026-1014', 'M-7014-14', 'چراغ مینی‌بوس', 11, 'عدد', 'سوختن', 'سوختن زودرس چراغ', 'مرجوعی', 11, 'high', 2, 'approved', 'pending', 'in_progress', '2026-09-11 18:35:24', '2026-09-11 18:35:24'),
(15, 'CLM-2026-0015', '2026-09-15', 'NCR-2026-0027', 'تأمین‌کننده کولر سازان', '09125556666', '2026-09-03', 'INV-2026-1015', 'C-8015-15', 'کولر خودرو', 3, 'عدد', 'عملکرد ضعیف', 'عملکرد ضعیف کولر', 'مرجوعی', 3, 'high', 3, 'approved', 'approved', 'closed', '2026-09-11 18:35:24', '2026-09-11 18:35:24');

-- --------------------------------------------------------

--
-- Table structure for table `ncrs`
--

CREATE TABLE `ncrs` (
  `id` int(11) NOT NULL,
  `ncr_number` varchar(50) NOT NULL,
  `status` varchar(30) DEFAULT 'draft',
  `current_step` int(11) DEFAULT 1,
  `report_date` date DEFAULT NULL,
  `reporter_name` varchar(100) DEFAULT NULL,
  `reporter_position` varchar(100) DEFAULT NULL,
  `reporter_department` varchar(50) DEFAULT NULL,
  `location_found` varchar(50) DEFAULT NULL,
  `inspection_number` varchar(50) DEFAULT NULL,
  `work_station` varchar(50) DEFAULT NULL,
  `skeleton_process` varchar(100) DEFAULT NULL,
  `sheet_metal_process` varchar(100) DEFAULT NULL,
  `fiber_process` varchar(100) DEFAULT NULL,
  `painting_process` varchar(100) DEFAULT NULL,
  `product_type` varchar(50) DEFAULT NULL,
  `bus_model` varchar(50) DEFAULT NULL,
  `car_model` varchar(50) DEFAULT NULL,
  `truck_model` varchar(50) DEFAULT NULL,
  `minibus_model` varchar(50) DEFAULT NULL,
  `tractor_model` varchar(50) DEFAULT NULL,
  `part_code` varchar(50) DEFAULT NULL,
  `part_name` varchar(200) DEFAULT NULL,
  `quantity` int(11) DEFAULT NULL,
  `unit` varchar(20) DEFAULT NULL,
  `description` mediumtext DEFAULT NULL,
  `documents` mediumtext DEFAULT NULL,
  `standard_ref` varchar(100) DEFAULT NULL,
  `batch_number` varchar(50) DEFAULT NULL,
  `immediate_action` varchar(50) DEFAULT NULL,
  `severity` varchar(20) DEFAULT NULL,
  `quality_notes` mediumtext DEFAULT NULL,
  `analysis_method` varchar(50) DEFAULT NULL,
  `fishbone_checks` mediumtext DEFAULT NULL,
  `fishbone_other` longtext DEFAULT NULL,
  `why1` mediumtext DEFAULT NULL,
  `why2` mediumtext DEFAULT NULL,
  `why3` mediumtext DEFAULT NULL,
  `why4` mediumtext DEFAULT NULL,
  `why5` mediumtext DEFAULT NULL,
  `analysis_conclusion` mediumtext DEFAULT NULL,
  `quality_checker` varchar(100) DEFAULT NULL,
  `quality_check_date` date DEFAULT NULL,
  `confirmation` varchar(10) DEFAULT NULL,
  `reject_reason` mediumtext DEFAULT NULL,
  `disposition_type` varchar(50) DEFAULT NULL,
  `rework_responsible` varchar(100) DEFAULT NULL,
  `rework_deadline` date DEFAULT NULL,
  `rework_action_number` varchar(50) DEFAULT NULL,
  `concession_number` varchar(50) DEFAULT NULL,
  `hold_reason` varchar(200) DEFAULT NULL,
  `claim_number` varchar(50) DEFAULT NULL,
  `purchase_number` varchar(50) DEFAULT NULL,
  `corrective_action` varchar(10) DEFAULT NULL,
  `corrective_number` varchar(50) DEFAULT NULL,
  `cft_committee` varchar(200) DEFAULT NULL,
  `cft_date` date DEFAULT NULL,
  `effectiveness` varchar(10) DEFAULT NULL,
  `ineffective_action_number` varchar(50) DEFAULT NULL,
  `monitoring_date` date DEFAULT NULL,
  `monitoring_responsible` varchar(100) DEFAULT NULL,
  `monitoring_notes` mediumtext DEFAULT NULL,
  `final_status` varchar(20) DEFAULT NULL,
  `closure_date` date DEFAULT NULL,
  `closure_by` varchar(100) DEFAULT NULL,
  `step1_completed` tinyint(1) DEFAULT 0,
  `step2_completed` tinyint(1) DEFAULT 0,
  `step3_completed` tinyint(1) DEFAULT 0,
  `step4_completed` tinyint(1) DEFAULT 0,
  `step1_locked` tinyint(1) DEFAULT 0,
  `step2_locked` tinyint(1) DEFAULT 0,
  `step3_locked` tinyint(1) DEFAULT 0,
  `step4_locked` tinyint(1) DEFAULT 0,
  `step1_submitted_at` datetime DEFAULT NULL,
  `step2_submitted_at` datetime DEFAULT NULL,
  `step3_submitted_at` datetime DEFAULT NULL,
  `step4_submitted_at` datetime DEFAULT NULL,
  `assigned_role` varchar(50) DEFAULT NULL,
  `created_by` varchar(100) DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `part_image` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `ncrs`
--

INSERT INTO `ncrs` (`id`, `ncr_number`, `status`, `current_step`, `report_date`, `reporter_name`, `reporter_position`, `reporter_department`, `location_found`, `inspection_number`, `work_station`, `skeleton_process`, `sheet_metal_process`, `fiber_process`, `painting_process`, `product_type`, `bus_model`, `car_model`, `truck_model`, `minibus_model`, `tractor_model`, `part_code`, `part_name`, `quantity`, `unit`, `description`, `documents`, `standard_ref`, `batch_number`, `immediate_action`, `severity`, `quality_notes`, `analysis_method`, `fishbone_checks`, `fishbone_other`, `why1`, `why2`, `why3`, `why4`, `why5`, `analysis_conclusion`, `quality_checker`, `quality_check_date`, `confirmation`, `reject_reason`, `disposition_type`, `rework_responsible`, `rework_deadline`, `rework_action_number`, `concession_number`, `hold_reason`, `claim_number`, `purchase_number`, `corrective_action`, `corrective_number`, `cft_committee`, `cft_date`, `effectiveness`, `ineffective_action_number`, `monitoring_date`, `monitoring_responsible`, `monitoring_notes`, `final_status`, `closure_date`, `closure_by`, `step1_completed`, `step2_completed`, `step3_completed`, `step4_completed`, `step1_locked`, `step2_locked`, `step3_locked`, `step4_locked`, `step1_submitted_at`, `step2_submitted_at`, `step3_submitted_at`, `step4_submitted_at`, `assigned_role`, `created_by`, `created_at`, `updated_at`, `part_image`) VALUES
(9, 'NCR-2026-0001', 'step2_submitted', 4, '2026-09-21', 'admin', 'admin', 'تولید', 'ورودی', 'INSP-2025-836', '', '', '', '', '', 'اتوبوس', '27 نفره VIP', '', '', '', '', '123456', 'senns', 1, 'عدد', '1111111111111111111111111111', '[{\"name\":\"DNS.png\",\"path\":\"uploads/NCR-2026-0001/1790019044_0_DNS.png\",\"size\":3892,\"type\":\"png\",\"uploaded_at\":\"2026-09-21 15:30:44\"}]', '1', '', 'قرنطینه', 'بحرانی', '11111111', 'fishbone', '[\"measurement\"]', '{\"measurement\":[\"1111111\"]}', NULL, NULL, NULL, NULL, NULL, '1111111111', 'فاطمه محمدی', '2026-09-21', 'yes', NULL, 'rework', 'wwwwwwww', '2026-09-21', NULL, NULL, NULL, NULL, NULL, 'no', NULL, 'مدیریت - دکتر کامران اسدی', '2026-09-21', 'yes', NULL, '2026-09-28', NULL, NULL, '', NULL, '', 1, 1, 1, 0, 0, 0, 0, 0, '2026-09-21 19:30:46', '2026-09-21 19:44:23', '2026-09-21 19:47:26', NULL, 'quality', 'محمد پورسان', '2026-09-21 12:30:44', '2026-09-28 10:19:36', NULL),
(10, 'NCR-2026-0002', 'step2_submitted', 2, '2026-09-21', 'admin', 'admin', 'تولید', 'ورودی', 'INSP-2025-836', '', '', '', '', '', 'مینی بوس', '', '', '', 'سایر', '', '123456', 'senns', 2, 'عدد', '2222222222222', '', '1', '', 'قرنطینه', 'بحرانی', '111111111111111111111', 'fishbone', '[\"environment\",\"measurement\"]', '{\"environment\":[\"1111111111111111111111111111111111111111111111111111111111111111111\"],\"measurement\":[\"222222222222222222222222222222222222222222222222222222222\"]}', NULL, NULL, NULL, NULL, NULL, '122222222222222222222222222222222222111111111111', 'مدیر کیفیت', '2026-09-27', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 1, 0, 0, 0, 0, 0, 0, '2026-09-21 19:31:26', '2026-09-27 17:18:40', NULL, NULL, 'cft', 'محمد پورسان', '2026-09-21 12:31:23', '2026-09-27 10:18:37', NULL),
(11, 'NCR-2026-0003', 'closed', 4, '2026-09-21', 'admin', 'admin', 'تولید', 'محصول نهایی', '', '', '', '', '', '', 'کشنده', '', '', '', '', 'ایویکو', '123456', 'senns', 1, 'عدد', '33333333333', '[{\"name\":\"سناریو لیست عدم انطباق.docx\",\"path\":\"uploads/NCR-2026-0003/1790019218_0__________________________________________.docx\",\"size\":22467,\"type\":\"docx\",\"uploaded_at\":\"2026-09-21 15:33:38\"}]', '1', '', 'جداسازی', 'بحرانی', '111111111111111111111', '5why', '[]', '{}', '1', '11', '111', '1111', '11111', '11111111111111111111111111111111111', 'محمد پورسان', '2026-09-27', 'yes', NULL, 'rework', 'ali', '2026-09-27', NULL, NULL, NULL, NULL, NULL, 'no', NULL, 'مدیریت - محمد پورسان', '2026-09-27', 'yes', NULL, '2026-09-28', 'Mohammad Poursan Dalir', 'ddddddddddddddddddddddddd', 'closed', '2026-09-28', 'مدیر کیفیت', 1, 1, 1, 1, 0, 0, 0, 0, '2026-09-21 19:33:38', '2026-09-27 13:22:07', '2026-09-27 13:40:30', '2026-09-28 07:12:09', NULL, 'محمد پورسان', '2026-09-21 12:33:36', '2026-09-28 00:12:09', NULL),
(12, 'NCR-2026-0004', 'step1_submitted', 1, '2026-09-21', 'admin', 'admin', 'کنترل کیفیت', 'ورودی', 'INSP-2025-836', '', '', '', '', '', 'مینی بوس', '', '', '', 'سایر', '', '123456', 'senns', 4, 'عدد', '444444444444444444444444', '[{\"name\":\"نت.pdf\",\"path\":\"uploads/NCR-2026-0004/1790019254_0_____.pdf\",\"size\":68260,\"type\":\"pdf\",\"uploaded_at\":\"2026-09-21 15:34:14\"}]', NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 0, 0, 0, 0, 0, 0, 0, '2026-09-21 19:34:11', NULL, NULL, NULL, NULL, 'محمد پورسان', '2026-09-21 12:34:09', '2026-09-21 12:34:15', NULL),
(13, 'NCR-2026-0005', 'step2_submitted', 2, '2026-09-21', 'production', 'production', 'تولید', 'ورودی', 'INSP-2025-836', '', '', '', '', '', 'کشنده', '', '', '', '', 'سایر', '123456', 'senns', 1, 'عدد', '111111111111111', '[{\"name\":\"DNS.png\",\"path\":\"uploads/NCR-2026-0005/1790019309_0_DNS.png\",\"size\":3892,\"type\":\"png\",\"uploaded_at\":\"2026-09-21 15:35:09\"}]', '2', '', 'جداسازی', 'بحرانی', '2222222', '5why', '[]', '{}', '222222222', '222222222', '222222222', NULL, NULL, '222222222222', 'فاطمه محمدی', '2026-09-21', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 1, 0, 0, 0, 0, 0, 0, '2026-09-21 19:35:11', '2026-09-21 19:45:03', NULL, NULL, 'cft', 'حسن احمدی', '2026-09-21 12:35:08', '2026-09-21 12:45:01', NULL),
(14, 'NCR-2026-0006', 'step1_submitted', 1, '2026-09-21', 'production', 'production', 'تولید', 'حین تولید', '', 'تزئینات', '', '', '', '', 'مینی بوس', '', '', '', 'هیوندای', '', '123456', 'senns', 2, 'عدد', '222222222222222222222', '', NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 0, 0, 0, 0, 0, 0, 0, '2026-09-21 19:35:39', NULL, NULL, NULL, NULL, 'حسن احمدی', '2026-09-21 12:35:37', '2026-09-21 12:35:37', NULL),
(15, 'NCR-2026-0007', 'step1_submitted', 1, '2026-09-21', 'production', 'production', 'تولید', 'حین تولید', '', 'اسکلت', 'فرآیند آماده سازی بدنه راست (سمت کمک راننده)', '', '', '', 'اتوبوس', '27 نفره VIP', '', '', '', '', '123456', 'senns', 3, 'عدد', '3333333333333333333333333', '[{\"name\":\"سناریو لیست عدم انطباق.docx\",\"path\":\"uploads/NCR-2026-0007/1790019403_0__________________________________________.docx\",\"size\":22467,\"type\":\"docx\",\"uploaded_at\":\"2026-09-21 15:36:43\"}]', NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 0, 0, 0, 0, 0, 0, 0, '2026-09-21 19:36:43', NULL, NULL, NULL, NULL, 'حسن احمدی', '2026-09-21 12:36:41', '2026-09-21 12:36:44', NULL),
(16, 'NCR-2026-0008', 'step1_submitted', 1, '2026-09-21', 'production', 'production', 'تولید', 'حین تولید', '', 'اسکلت', 'فرآیند نصب بدنه راست به شاسی', '', '', '', 'اتوبوس', '27 نفره VIP', '', '', '', '', '123456', 'senns', 4, 'عدد', '444444444444444444444', '[{\"name\":\"SoroushMotor_Logo.png\",\"path\":\"uploads/NCR-2026-0008/1790019436_0_SoroushMotor_Logo.png\",\"size\":40730,\"type\":\"png\",\"uploaded_at\":\"2026-09-21 15:37:16\"}]', NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 0, 0, 0, 0, 0, 0, 0, '2026-09-21 19:37:17', NULL, NULL, NULL, NULL, 'حسن احمدی', '2026-09-21 12:37:15', '2026-09-21 12:37:17', NULL),
(17, 'NCR-2026-0009', 'step2_submitted', 2, '2026-09-21', 'quality', 'quality', 'کنترل کیفیت', 'ورودی', 'INSP-2025-836', '', '', '', '', '', 'اتوبوس', '27 نفره VIP', '', '', '', '', '123456', 'senns', 1, 'عدد', '1111111111111111111111111', '[{\"name\":\"Detection and identification of subcutaneous defects using ultrasonic waves in reflective test.pdf\",\"path\":\"uploads/NCR-2026-0009/1790019489_0_Detection_and_identification_of_subcutaneous_defects_using_ultrasonic_waves_in_reflective_test.pdf\",\"size\":881636,\"type\":\"pdf\",\"uploaded_at\":\"2026-09-21 15:38:09\"}]', '3', '', 'جداسازی', 'عمده', '333333333333', 'fishbone', '[\"machine\",\"method\",\"material\"]', '{\"machine\":[\"3333333\",\"333333\"],\"method\":[\"3333333333\"],\"material\":[\"3333333\"]}', NULL, NULL, NULL, NULL, NULL, '333333333333333', 'فاطمه محمدی', '2026-09-21', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 1, 0, 0, 0, 0, 0, 0, '2026-09-21 19:38:03', '2026-09-21 19:45:58', NULL, NULL, 'cft', 'فاطمه محمدی', '2026-09-21 12:38:01', '2026-09-21 12:45:56', NULL),
(18, 'NCR-2026-0010', 'step1_submitted', 1, '2026-09-21', 'quality', 'quality', 'کنترل کیفیت', 'حین تولید', '', 'اسکلت', 'فرآیند آماده سازی بدنه راست (سمت کمک راننده)', '', '', '', 'اتوبوس', '27 نفره VIP', '', '', '', '', '123456', 'senns', 2, 'عدد', '22222222222222222222222', '[{\"name\":\"DNS.png\",\"path\":\"uploads/NCR-2026-0010/1790019527_0_DNS.png\",\"size\":3892,\"type\":\"png\",\"uploaded_at\":\"2026-09-21 15:38:47\"}]', NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 0, 0, 0, 0, 0, 0, 0, '2026-09-21 19:38:47', NULL, NULL, NULL, NULL, 'فاطمه محمدی', '2026-09-21 12:38:45', '2026-09-21 12:38:48', NULL),
(19, 'NCR-2026-0011', 'step1_submitted', 1, '2026-09-23', 'quality', 'quality', 'کنترل کیفیت', 'حین تولید', '', 'نصب فایبرگلاس', '', '', 'فرآیند نصب سپر جلو', '', 'سواری', '', 'آرکانا', '', '', '', '123456', 'senns', 3, 'عدد', '333333333333333333333', '[{\"name\":\"نت.pdf\",\"path\":\"uploads/NCR-2026-0011/1790019563_0_____.pdf\",\"size\":68260,\"type\":\"pdf\",\"uploaded_at\":\"2026-09-21 15:39:23\"}]', NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 0, 0, 0, 0, 0, 0, 0, '2026-09-23 07:27:16', NULL, NULL, NULL, NULL, 'فاطمه محمدی', '2026-09-21 12:39:21', '2026-09-23 00:27:17', '{\"name\":\"BUS-0.jpg.jpg\",\"size\":577460,\"type\":\"image/jpeg\",\"path\":\"uploads/part_images/part_NCR-2026-0011_1790148437.jpg\",\"url\":\"https://ncr.page.gd/uploads/part_images/part_NCR-2026-0011_1790148437.jpg\",\"uploaded_at\":\"2026-09-23 03:27:17\"}'),
(20, 'NCR-2026-0012', 'step1_submitted', 1, '2026-09-21', 'quality', 'quality', 'کنترل کیفیت', 'حین تولید', '', 'تزئینات', '', '', '', '', 'کشنده', '', '', '', '', 'ایویکو', '123456', 'senns', 4, 'عدد', '44444444444444444444444444444', '[{\"name\":\"سناریو لیست عدم انطباق.docx\",\"path\":\"uploads/NCR-2026-0012/1790019597_0__________________________________________.docx\",\"size\":22467,\"type\":\"docx\",\"uploaded_at\":\"2026-09-21 15:39:57\"}]', NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 0, 0, 0, 0, 0, 0, 0, '2026-09-21 19:39:59', NULL, NULL, NULL, NULL, 'فاطمه محمدی', '2026-09-21 12:39:56', '2026-09-21 12:39:58', NULL),
(21, 'NCR-2026-0013', 'closed', 4, '2026-09-21', 'ceo', 'ceo', 'مدیریت', 'ورودی', 'INSP-2025-836', '', '', '', '', '', 'اتوبوس', '27 نفره VIP', '', '', '', '', '123456', 'senns', 1, 'عدد', '1111111111111111111', '[{\"name\":\"Detection and identification of subcutaneous defects using ultrasonic waves in reflective test.pdf\",\"path\":\"uploads/NCR-2026-0013/1790019654_0_Detection_and_identification_of_subcutaneous_defects_using_ultrasonic_waves_in_reflective_test.pdf\",\"size\":881636,\"type\":\"pdf\",\"uploaded_at\":\"2026-09-21 15:40:54\"}]', '4', '', 'جداسازی', 'بحرانی', '4', 'سایر', '[]', '{}', NULL, NULL, NULL, NULL, NULL, '444444444444444', 'فاطمه محمدی', '2026-09-21', 'yes', NULL, 'concession', NULL, '2026-09-21', NULL, '112', NULL, NULL, NULL, 'no', NULL, 'مدیریت - دکتر کامران اسدی', '2026-09-21', 'yes', NULL, '2026-09-22', 'dddddddddddddd', 'dddddddddddddd', 'closed', '2026-09-22', 'فاطمه محمدی', 1, 1, 1, 1, 0, 0, 0, 0, '2026-09-21 19:40:49', '2026-09-21 19:46:22', '2026-09-21 19:47:49', '2026-09-22 09:31:38', NULL, 'دکتر کامران اسدی', '2026-09-21 12:40:46', '2026-09-22 02:31:38', NULL),
(22, 'NCR-2026-0014', 'step1_submitted', 1, '2026-09-22', 'ceo', 'ceo', 'مدیریت', 'حین تولید', '', 'تزئینات', '', '', '', '', 'مینی بوس', '', '', '', 'هیوندای', '', '123456', 'senns', 2, 'عدد', '22222222222222222222222', '[]', NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 0, 0, 0, 0, 0, 0, 0, '2026-09-22 13:40:55', NULL, NULL, NULL, NULL, 'دکتر کامران اسدی', '2026-09-21 12:41:20', '2026-09-22 06:40:56', NULL),
(23, 'NCR-2026-0015', 'step1_submitted', 1, '2026-09-21', 'ceo', 'ceo', 'مدیریت', 'حین تولید', '', 'ورقکوبی', '', 'فرآیند نصب ورق بدنه راست', '', '', 'سواری', '', 'آرکانا', '', '', '', '123456', 'senns', 3, 'عدد', '333333333333333333333333333333', '[{\"name\":\"نت.pdf\",\"path\":\"uploads/NCR-2026-0015/1790019745_0_____.pdf\",\"size\":68260,\"type\":\"pdf\",\"uploaded_at\":\"2026-09-21 15:42:25\"}]', NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 0, 0, 0, 0, 0, 0, 0, '2026-09-21 19:42:24', NULL, NULL, NULL, NULL, 'دکتر کامران اسدی', '2026-09-21 12:42:22', '2026-09-21 12:42:26', NULL),
(24, 'NCR-2026-0016', 'step1_submitted', 1, '2026-09-21', 'ceo', 'ceo', 'مدیریت', 'محصول نهایی', '', '', '', '', '', '', 'کشنده', '', '', '', '', 'ایویکو', '123456', 'senns', 4, 'عدد', '444444444444444444444444', '[{\"name\":\"سناریو لیست عدم انطباق.docx\",\"path\":\"uploads/NCR-2026-0016/1790019769_0__________________________________________.docx\",\"size\":22467,\"type\":\"docx\",\"uploaded_at\":\"2026-09-21 15:42:49\"}]', NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 0, 0, 0, 0, 0, 0, 0, '2026-09-21 19:42:49', NULL, NULL, NULL, NULL, 'دکتر کامران اسدی', '2026-09-21 12:42:47', '2026-09-21 12:42:50', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `notifications`
--

CREATE TABLE `notifications` (
  `id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `title` varchar(255) NOT NULL,
  `message` mediumtext NOT NULL,
  `type` varchar(20) DEFAULT 'info',
  `link` varchar(255) DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `notifications`
--

INSERT INTO `notifications` (`id`, `user_id`, `title`, `message`, `type`, `link`, `created_at`) VALUES
(132, 1, '🔔 NCR جدید نیاز به بررسی دارد', 'NCR NCR-2026-0001 توسط admin ثبت شده است.', 'warning', 'new-ncr.html?number=NCR-2026-0001', '2026-09-21 12:30:44'),
(133, 2, '🔔 NCR جدید نیاز به بررسی دارد', 'NCR NCR-2026-0001 توسط admin ثبت شده است.', 'warning', 'new-ncr.html?number=NCR-2026-0001', '2026-09-21 12:30:44'),
(134, 3, '🔔 NCR جدید نیاز به بررسی دارد', 'NCR NCR-2026-0001 توسط admin ثبت شده است.', 'warning', 'new-ncr.html?number=NCR-2026-0001', '2026-09-21 12:30:44'),
(135, 1, '🔔 NCR جدید نیاز به بررسی دارد', 'NCR NCR-2026-0002 توسط admin ثبت شده است.', 'warning', 'new-ncr.html?number=NCR-2026-0002', '2026-09-21 12:31:24'),
(136, 2, '🔔 NCR جدید نیاز به بررسی دارد', 'NCR NCR-2026-0002 توسط admin ثبت شده است.', 'warning', 'new-ncr.html?number=NCR-2026-0002', '2026-09-21 12:31:24'),
(137, 3, '🔔 NCR جدید نیاز به بررسی دارد', 'NCR NCR-2026-0002 توسط admin ثبت شده است.', 'warning', 'new-ncr.html?number=NCR-2026-0002', '2026-09-21 12:31:24'),
(138, 1, '🔔 NCR جدید نیاز به بررسی دارد', 'NCR NCR-2026-0003 توسط admin ثبت شده است.', 'warning', 'new-ncr.html?number=NCR-2026-0003', '2026-09-21 12:33:37'),
(139, 2, '🔔 NCR جدید نیاز به بررسی دارد', 'NCR NCR-2026-0003 توسط admin ثبت شده است.', 'warning', 'new-ncr.html?number=NCR-2026-0003', '2026-09-21 12:33:37'),
(140, 3, '🔔 NCR جدید نیاز به بررسی دارد', 'NCR NCR-2026-0003 توسط admin ثبت شده است.', 'warning', 'new-ncr.html?number=NCR-2026-0003', '2026-09-21 12:33:37'),
(141, 1, '🔔 NCR جدید نیاز به بررسی دارد', 'NCR NCR-2026-0004 توسط admin ثبت شده است.', 'warning', 'new-ncr.html?number=NCR-2026-0004', '2026-09-21 12:34:10'),
(142, 2, '🔔 NCR جدید نیاز به بررسی دارد', 'NCR NCR-2026-0004 توسط admin ثبت شده است.', 'warning', 'new-ncr.html?number=NCR-2026-0004', '2026-09-21 12:34:11'),
(143, 3, '🔔 NCR جدید نیاز به بررسی دارد', 'NCR NCR-2026-0004 توسط admin ثبت شده است.', 'warning', 'new-ncr.html?number=NCR-2026-0004', '2026-09-21 12:34:11'),
(144, 1, '🔔 NCR جدید نیاز به بررسی دارد', 'NCR NCR-2026-0005 توسط production ثبت شده است.', 'warning', 'new-ncr.html?number=NCR-2026-0005', '2026-09-21 12:35:09'),
(145, 2, '🔔 NCR جدید نیاز به بررسی دارد', 'NCR NCR-2026-0005 توسط production ثبت شده است.', 'warning', 'new-ncr.html?number=NCR-2026-0005', '2026-09-21 12:35:09'),
(146, 3, '🔔 NCR جدید نیاز به بررسی دارد', 'NCR NCR-2026-0005 توسط production ثبت شده است.', 'warning', 'new-ncr.html?number=NCR-2026-0005', '2026-09-21 12:35:09'),
(147, 1, '🔔 NCR جدید نیاز به بررسی دارد', 'NCR NCR-2026-0006 توسط production ثبت شده است.', 'warning', 'new-ncr.html?number=NCR-2026-0006', '2026-09-21 12:35:38'),
(148, 2, '🔔 NCR جدید نیاز به بررسی دارد', 'NCR NCR-2026-0006 توسط production ثبت شده است.', 'warning', 'new-ncr.html?number=NCR-2026-0006', '2026-09-21 12:35:39'),
(149, 3, '🔔 NCR جدید نیاز به بررسی دارد', 'NCR NCR-2026-0006 توسط production ثبت شده است.', 'warning', 'new-ncr.html?number=NCR-2026-0006', '2026-09-21 12:35:39'),
(150, 1, '🔔 NCR جدید نیاز به بررسی دارد', 'NCR NCR-2026-0007 توسط production ثبت شده است.', 'warning', 'new-ncr.html?number=NCR-2026-0007', '2026-09-21 12:36:41'),
(151, 2, '🔔 NCR جدید نیاز به بررسی دارد', 'NCR NCR-2026-0007 توسط production ثبت شده است.', 'warning', 'new-ncr.html?number=NCR-2026-0007', '2026-09-21 12:36:42'),
(152, 3, '🔔 NCR جدید نیاز به بررسی دارد', 'NCR NCR-2026-0007 توسط production ثبت شده است.', 'warning', 'new-ncr.html?number=NCR-2026-0007', '2026-09-21 12:36:42'),
(153, 1, '🔔 NCR جدید نیاز به بررسی دارد', 'NCR NCR-2026-0008 توسط production ثبت شده است.', 'warning', 'new-ncr.html?number=NCR-2026-0008', '2026-09-21 12:37:15'),
(154, 2, '🔔 NCR جدید نیاز به بررسی دارد', 'NCR NCR-2026-0008 توسط production ثبت شده است.', 'warning', 'new-ncr.html?number=NCR-2026-0008', '2026-09-21 12:37:15'),
(155, 3, '🔔 NCR جدید نیاز به بررسی دارد', 'NCR NCR-2026-0008 توسط production ثبت شده است.', 'warning', 'new-ncr.html?number=NCR-2026-0008', '2026-09-21 12:37:16'),
(156, 1, '🔔 NCR جدید نیاز به بررسی دارد', 'NCR NCR-2026-0009 توسط quality ثبت شده است.', 'warning', 'new-ncr.html?number=NCR-2026-0009', '2026-09-21 12:38:01'),
(157, 2, '🔔 NCR جدید نیاز به بررسی دارد', 'NCR NCR-2026-0009 توسط quality ثبت شده است.', 'warning', 'new-ncr.html?number=NCR-2026-0009', '2026-09-21 12:38:02'),
(158, 3, '🔔 NCR جدید نیاز به بررسی دارد', 'NCR NCR-2026-0009 توسط quality ثبت شده است.', 'warning', 'new-ncr.html?number=NCR-2026-0009', '2026-09-21 12:38:02'),
(159, 1, '🔔 NCR جدید نیاز به بررسی دارد', 'NCR NCR-2026-0010 توسط quality ثبت شده است.', 'warning', 'new-ncr.html?number=NCR-2026-0010', '2026-09-21 12:38:46'),
(160, 2, '🔔 NCR جدید نیاز به بررسی دارد', 'NCR NCR-2026-0010 توسط quality ثبت شده است.', 'warning', 'new-ncr.html?number=NCR-2026-0010', '2026-09-21 12:38:47'),
(161, 3, '🔔 NCR جدید نیاز به بررسی دارد', 'NCR NCR-2026-0010 توسط quality ثبت شده است.', 'warning', 'new-ncr.html?number=NCR-2026-0010', '2026-09-21 12:38:47'),
(162, 1, '🔔 NCR جدید نیاز به بررسی دارد', 'NCR NCR-2026-0011 توسط quality ثبت شده است.', 'warning', 'new-ncr.html?number=NCR-2026-0011', '2026-09-21 12:39:21'),
(163, 2, '🔔 NCR جدید نیاز به بررسی دارد', 'NCR NCR-2026-0011 توسط quality ثبت شده است.', 'warning', 'new-ncr.html?number=NCR-2026-0011', '2026-09-21 12:39:22'),
(164, 3, '🔔 NCR جدید نیاز به بررسی دارد', 'NCR NCR-2026-0011 توسط quality ثبت شده است.', 'warning', 'new-ncr.html?number=NCR-2026-0011', '2026-09-21 12:39:22'),
(165, 1, '🔔 NCR جدید نیاز به بررسی دارد', 'NCR NCR-2026-0012 توسط quality ثبت شده است.', 'warning', 'new-ncr.html?number=NCR-2026-0012', '2026-09-21 12:39:57'),
(166, 2, '🔔 NCR جدید نیاز به بررسی دارد', 'NCR NCR-2026-0012 توسط quality ثبت شده است.', 'warning', 'new-ncr.html?number=NCR-2026-0012', '2026-09-21 12:39:57'),
(167, 3, '🔔 NCR جدید نیاز به بررسی دارد', 'NCR NCR-2026-0012 توسط quality ثبت شده است.', 'warning', 'new-ncr.html?number=NCR-2026-0012', '2026-09-21 12:39:57'),
(168, 1, '🔔 NCR جدید نیاز به بررسی دارد', 'NCR NCR-2026-0013 توسط ceo ثبت شده است.', 'warning', 'new-ncr.html?number=NCR-2026-0013', '2026-09-21 12:40:47'),
(169, 2, '🔔 NCR جدید نیاز به بررسی دارد', 'NCR NCR-2026-0013 توسط ceo ثبت شده است.', 'warning', 'new-ncr.html?number=NCR-2026-0013', '2026-09-21 12:40:47'),
(170, 3, '🔔 NCR جدید نیاز به بررسی دارد', 'NCR NCR-2026-0013 توسط ceo ثبت شده است.', 'warning', 'new-ncr.html?number=NCR-2026-0013', '2026-09-21 12:40:47'),
(171, 1, '🔔 NCR جدید نیاز به بررسی دارد', 'NCR NCR-2026-0014 توسط ceo ثبت شده است.', 'warning', 'new-ncr.html?number=NCR-2026-0014', '2026-09-21 12:41:21'),
(172, 2, '🔔 NCR جدید نیاز به بررسی دارد', 'NCR NCR-2026-0014 توسط ceo ثبت شده است.', 'warning', 'new-ncr.html?number=NCR-2026-0014', '2026-09-21 12:41:22'),
(173, 3, '🔔 NCR جدید نیاز به بررسی دارد', 'NCR NCR-2026-0014 توسط ceo ثبت شده است.', 'warning', 'new-ncr.html?number=NCR-2026-0014', '2026-09-21 12:41:22'),
(174, 1, '🔔 NCR جدید نیاز به بررسی دارد', 'NCR NCR-2026-0015 توسط ceo ثبت شده است.', 'warning', 'new-ncr.html?number=NCR-2026-0015', '2026-09-21 12:42:23'),
(175, 2, '🔔 NCR جدید نیاز به بررسی دارد', 'NCR NCR-2026-0015 توسط ceo ثبت شده است.', 'warning', 'new-ncr.html?number=NCR-2026-0015', '2026-09-21 12:42:23'),
(176, 3, '🔔 NCR جدید نیاز به بررسی دارد', 'NCR NCR-2026-0015 توسط ceo ثبت شده است.', 'warning', 'new-ncr.html?number=NCR-2026-0015', '2026-09-21 12:42:24'),
(177, 1, '🔔 NCR جدید نیاز به بررسی دارد', 'NCR NCR-2026-0016 توسط ceo ثبت شده است.', 'warning', 'new-ncr.html?number=NCR-2026-0016', '2026-09-21 12:42:48'),
(178, 2, '🔔 NCR جدید نیاز به بررسی دارد', 'NCR NCR-2026-0016 توسط ceo ثبت شده است.', 'warning', 'new-ncr.html?number=NCR-2026-0016', '2026-09-21 12:42:49'),
(179, 3, '🔔 NCR جدید نیاز به بررسی دارد', 'NCR NCR-2026-0016 توسط ceo ثبت شده است.', 'warning', 'new-ncr.html?number=NCR-2026-0016', '2026-09-21 12:42:49'),
(180, 1, '🔍 NCR نیاز به تعیین تکلیف دارد', 'NCR NCR-2026-0001 پس از تحلیل ریشه‌ای، نیاز به تعیین تکلیف دارد.', 'info', 'new-ncr.html?number=NCR-2026-0001', '2026-09-21 12:44:21'),
(181, 8, '🔍 NCR نیاز به تعیین تکلیف دارد', 'NCR NCR-2026-0001 پس از تحلیل ریشه‌ای، نیاز به تعیین تکلیف دارد.', 'info', 'new-ncr.html?number=NCR-2026-0001', '2026-09-21 12:44:21'),
(182, 9, '🔍 NCR نیاز به تعیین تکلیف دارد', 'NCR NCR-2026-0001 پس از تحلیل ریشه‌ای، نیاز به تعیین تکلیف دارد.', 'info', 'new-ncr.html?number=NCR-2026-0001', '2026-09-21 12:44:21'),
(183, 10, '🔍 NCR نیاز به تعیین تکلیف دارد', 'NCR NCR-2026-0001 پس از تحلیل ریشه‌ای، نیاز به تعیین تکلیف دارد.', 'info', 'new-ncr.html?number=NCR-2026-0001', '2026-09-21 12:44:22'),
(184, 1, '🔍 NCR نیاز به تعیین تکلیف دارد', 'NCR NCR-2026-0005 پس از تحلیل ریشه‌ای، نیاز به تعیین تکلیف دارد.', 'info', 'new-ncr.html?number=NCR-2026-0005', '2026-09-21 12:45:01'),
(185, 8, '🔍 NCR نیاز به تعیین تکلیف دارد', 'NCR NCR-2026-0005 پس از تحلیل ریشه‌ای، نیاز به تعیین تکلیف دارد.', 'info', 'new-ncr.html?number=NCR-2026-0005', '2026-09-21 12:45:02'),
(186, 9, '🔍 NCR نیاز به تعیین تکلیف دارد', 'NCR NCR-2026-0005 پس از تحلیل ریشه‌ای، نیاز به تعیین تکلیف دارد.', 'info', 'new-ncr.html?number=NCR-2026-0005', '2026-09-21 12:45:02'),
(187, 10, '🔍 NCR نیاز به تعیین تکلیف دارد', 'NCR NCR-2026-0005 پس از تحلیل ریشه‌ای، نیاز به تعیین تکلیف دارد.', 'info', 'new-ncr.html?number=NCR-2026-0005', '2026-09-21 12:45:02'),
(188, 1, '🔍 NCR نیاز به تعیین تکلیف دارد', 'NCR NCR-2026-0009 پس از تحلیل ریشه‌ای، نیاز به تعیین تکلیف دارد.', 'info', 'new-ncr.html?number=NCR-2026-0009', '2026-09-21 12:45:56'),
(189, 8, '🔍 NCR نیاز به تعیین تکلیف دارد', 'NCR NCR-2026-0009 پس از تحلیل ریشه‌ای، نیاز به تعیین تکلیف دارد.', 'info', 'new-ncr.html?number=NCR-2026-0009', '2026-09-21 12:45:56'),
(190, 9, '🔍 NCR نیاز به تعیین تکلیف دارد', 'NCR NCR-2026-0009 پس از تحلیل ریشه‌ای، نیاز به تعیین تکلیف دارد.', 'info', 'new-ncr.html?number=NCR-2026-0009', '2026-09-21 12:45:57'),
(191, 10, '🔍 NCR نیاز به تعیین تکلیف دارد', 'NCR NCR-2026-0009 پس از تحلیل ریشه‌ای، نیاز به تعیین تکلیف دارد.', 'info', 'new-ncr.html?number=NCR-2026-0009', '2026-09-21 12:45:57'),
(192, 1, '🔍 NCR نیاز به تعیین تکلیف دارد', 'NCR NCR-2026-0013 پس از تحلیل ریشه‌ای، نیاز به تعیین تکلیف دارد.', 'info', 'new-ncr.html?number=NCR-2026-0013', '2026-09-21 12:46:20'),
(193, 8, '🔍 NCR نیاز به تعیین تکلیف دارد', 'NCR NCR-2026-0013 پس از تحلیل ریشه‌ای، نیاز به تعیین تکلیف دارد.', 'info', 'new-ncr.html?number=NCR-2026-0013', '2026-09-21 12:46:20'),
(194, 9, '🔍 NCR نیاز به تعیین تکلیف دارد', 'NCR NCR-2026-0013 پس از تحلیل ریشه‌ای، نیاز به تعیین تکلیف دارد.', 'info', 'new-ncr.html?number=NCR-2026-0013', '2026-09-21 12:46:20'),
(195, 10, '🔍 NCR نیاز به تعیین تکلیف دارد', 'NCR NCR-2026-0013 پس از تحلیل ریشه‌ای، نیاز به تعیین تکلیف دارد.', 'info', 'new-ncr.html?number=NCR-2026-0013', '2026-09-21 12:46:20'),
(196, NULL, '📊 NCR نیاز به پایش دارد', 'NCR NCR-2026-0001 پس از تعیین تکلیف، نیاز به پایش اثربخشی دارد.', 'info', 'new-ncr.html?number=NCR-2026-0001', '2026-09-21 12:47:24'),
(197, NULL, '📊 NCR نیاز به پایش دارد', 'NCR NCR-2026-0013 پس از تعیین تکلیف، نیاز به پایش اثربخشی دارد.', 'info', 'new-ncr.html?number=NCR-2026-0013', '2026-09-21 12:47:47'),
(198, NULL, '✅ NCR بسته شد', 'NCR NCR-2026-0013 با موفقیت به پایان رسید و بسته شد.', 'success', 'ncr-detail.html?number=NCR-2026-0013', '2026-09-22 02:31:38'),
(199, 1, '🔔 NCR جدید نیاز به بررسی دارد', 'NCR NCR-2026-0011 توسط quality ثبت شده است.', 'warning', 'new-ncr.html?number=NCR-2026-0011', '2026-09-22 04:53:28'),
(200, 2, '🔔 NCR جدید نیاز به بررسی دارد', 'NCR NCR-2026-0011 توسط quality ثبت شده است.', 'warning', 'new-ncr.html?number=NCR-2026-0011', '2026-09-22 04:53:29'),
(201, 3, '🔔 NCR جدید نیاز به بررسی دارد', 'NCR NCR-2026-0011 توسط quality ثبت شده است.', 'warning', 'new-ncr.html?number=NCR-2026-0011', '2026-09-22 04:53:29'),
(202, 1, '🔔 NCR جدید نیاز به بررسی دارد', 'NCR NCR-2026-0011 توسط quality ثبت شده است.', 'warning', 'new-ncr.html?number=NCR-2026-0011', '2026-09-22 04:55:44'),
(203, 2, '🔔 NCR جدید نیاز به بررسی دارد', 'NCR NCR-2026-0011 توسط quality ثبت شده است.', 'warning', 'new-ncr.html?number=NCR-2026-0011', '2026-09-22 04:55:44'),
(204, 3, '🔔 NCR جدید نیاز به بررسی دارد', 'NCR NCR-2026-0011 توسط quality ثبت شده است.', 'warning', 'new-ncr.html?number=NCR-2026-0011', '2026-09-22 04:55:44'),
(205, 1, '🔔 NCR جدید نیاز به بررسی دارد', 'NCR NCR-2026-0014 توسط ceo ثبت شده است.', 'warning', 'new-ncr.html?number=NCR-2026-0014', '2026-09-22 06:40:56'),
(206, 2, '🔔 NCR جدید نیاز به بررسی دارد', 'NCR NCR-2026-0014 توسط ceo ثبت شده است.', 'warning', 'new-ncr.html?number=NCR-2026-0014', '2026-09-22 06:40:57'),
(207, 3, '🔔 NCR جدید نیاز به بررسی دارد', 'NCR NCR-2026-0014 توسط ceo ثبت شده است.', 'warning', 'new-ncr.html?number=NCR-2026-0014', '2026-09-22 06:40:57'),
(208, 1, '🔔 NCR جدید نیاز به بررسی دارد', 'NCR NCR-2026-0011 توسط quality ثبت شده است.', 'warning', 'new-ncr.html?number=NCR-2026-0011', '2026-09-23 00:27:18'),
(209, 2, '🔔 NCR جدید نیاز به بررسی دارد', 'NCR NCR-2026-0011 توسط quality ثبت شده است.', 'warning', 'new-ncr.html?number=NCR-2026-0011', '2026-09-23 00:27:18'),
(210, 3, '🔔 NCR جدید نیاز به بررسی دارد', 'NCR NCR-2026-0011 توسط quality ثبت شده است.', 'warning', 'new-ncr.html?number=NCR-2026-0011', '2026-09-23 00:27:18'),
(211, 1, '🔍 NCR نیاز به تعیین تکلیف دارد', 'NCR NCR-2026-0002 پس از تحلیل ریشه‌ای، نیاز به تعیین تکلیف دارد.', 'info', 'new-ncr.html?number=NCR-2026-0002', '2026-09-23 06:27:44'),
(212, 8, '🔍 NCR نیاز به تعیین تکلیف دارد', 'NCR NCR-2026-0002 پس از تحلیل ریشه‌ای، نیاز به تعیین تکلیف دارد.', 'info', 'new-ncr.html?number=NCR-2026-0002', '2026-09-23 06:27:44'),
(213, 9, '🔍 NCR نیاز به تعیین تکلیف دارد', 'NCR NCR-2026-0002 پس از تحلیل ریشه‌ای، نیاز به تعیین تکلیف دارد.', 'info', 'new-ncr.html?number=NCR-2026-0002', '2026-09-23 06:27:44'),
(214, 10, '🔍 NCR نیاز به تعیین تکلیف دارد', 'NCR NCR-2026-0002 پس از تحلیل ریشه‌ای، نیاز به تعیین تکلیف دارد.', 'info', 'new-ncr.html?number=NCR-2026-0002', '2026-09-23 06:27:44'),
(215, 1, '🔍 NCR نیاز به تعیین تکلیف دارد', 'NCR NCR-2026-0003 پس از تحلیل ریشه‌ای، نیاز به تعیین تکلیف دارد.', 'info', 'new-ncr.html?number=NCR-2026-0003', '2026-09-27 06:22:06'),
(216, 8, '🔍 NCR نیاز به تعیین تکلیف دارد', 'NCR NCR-2026-0003 پس از تحلیل ریشه‌ای، نیاز به تعیین تکلیف دارد.', 'info', 'new-ncr.html?number=NCR-2026-0003', '2026-09-27 06:22:06'),
(217, 9, '🔍 NCR نیاز به تعیین تکلیف دارد', 'NCR NCR-2026-0003 پس از تحلیل ریشه‌ای، نیاز به تعیین تکلیف دارد.', 'info', 'new-ncr.html?number=NCR-2026-0003', '2026-09-27 06:22:06'),
(218, 10, '🔍 NCR نیاز به تعیین تکلیف دارد', 'NCR NCR-2026-0003 پس از تحلیل ریشه‌ای، نیاز به تعیین تکلیف دارد.', 'info', 'new-ncr.html?number=NCR-2026-0003', '2026-09-27 06:22:06'),
(219, NULL, '📋 فرم اقدام اصلاحی جدید', 'فرم اقدام اصلاحی CA-2026-0001 با 1 اقدام برای NCR - ثبت شد.', 'info', 'corrective-action.html?ca=CA-2026-0001', '2026-09-27 06:36:47'),
(220, NULL, '📊 NCR نیاز به پایش دارد', 'NCR NCR-2026-0003 پس از تعیین تکلیف، نیاز به پایش اثربخشی دارد.', 'info', 'new-ncr.html?number=NCR-2026-0003', '2026-09-27 06:38:02'),
(221, NULL, '📊 NCR نیاز به پایش دارد', 'NCR NCR-2026-0003 پس از تعیین تکلیف، نیاز به پایش اثربخشی دارد.', 'info', 'new-ncr.html?number=NCR-2026-0003', '2026-09-27 06:40:29'),
(222, NULL, '✅ NCR بسته شد', 'NCR NCR-2026-0003 با موفقیت به پایان رسید و بسته شد.', 'success', 'ncr-detail.html?number=NCR-2026-0003', '2026-09-27 06:41:21'),
(223, 1, '🔍 NCR نیاز به تعیین تکلیف دارد', 'NCR NCR-2026-0002 پس از تحلیل ریشه‌ای، نیاز به تعیین تکلیف دارد.', 'info', 'new-ncr.html?number=NCR-2026-0002', '2026-09-27 10:18:38'),
(224, 8, '🔍 NCR نیاز به تعیین تکلیف دارد', 'NCR NCR-2026-0002 پس از تحلیل ریشه‌ای، نیاز به تعیین تکلیف دارد.', 'info', 'new-ncr.html?number=NCR-2026-0002', '2026-09-27 10:18:38'),
(225, 9, '🔍 NCR نیاز به تعیین تکلیف دارد', 'NCR NCR-2026-0002 پس از تحلیل ریشه‌ای، نیاز به تعیین تکلیف دارد.', 'info', 'new-ncr.html?number=NCR-2026-0002', '2026-09-27 10:18:38'),
(226, 10, '🔍 NCR نیاز به تعیین تکلیف دارد', 'NCR NCR-2026-0002 پس از تحلیل ریشه‌ای، نیاز به تعیین تکلیف دارد.', 'info', 'new-ncr.html?number=NCR-2026-0002', '2026-09-27 10:18:38'),
(227, NULL, '📊 پایش NCR به‌روزرسانی شد', 'NCR NCR-2026-0001 - اطلاعات پایش ذخیره شد. وضعیت نهایی: باز', 'info', 'new-ncr.html?number=NCR-2026-0001', '2026-09-27 23:02:32'),
(228, NULL, '✅ NCR بسته شد', 'NCR NCR-2026-0001 با موفقیت به پایان رسید و بسته شد.', 'success', 'ncr-detail.html?number=NCR-2026-0001', '2026-09-27 23:02:57'),
(229, NULL, '✅ NCR بسته شد', 'NCR NCR-2026-0003 با موفقیت به پایان رسید و بسته شد.', 'success', 'ncr-detail.html?number=NCR-2026-0003', '2026-09-28 00:12:09');

-- --------------------------------------------------------

--
-- Table structure for table `notification_reads`
--

CREATE TABLE `notification_reads` (
  `id` int(11) NOT NULL,
  `notification_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `is_read` tinyint(1) DEFAULT 0,
  `read_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `notification_reads`
--

INSERT INTO `notification_reads` (`id`, `notification_id`, `user_id`, `is_read`, `read_at`) VALUES
(124, 132, 1, 0, NULL),
(125, 133, 2, 1, '2026-09-21 12:43:58'),
(126, 134, 3, 0, NULL),
(127, 135, 1, 0, NULL),
(128, 136, 2, 1, '2026-09-22 03:24:21'),
(129, 137, 3, 0, NULL),
(130, 138, 1, 0, NULL),
(131, 139, 2, 1, '2026-09-22 04:05:25'),
(132, 140, 3, 0, NULL),
(133, 141, 1, 0, NULL),
(134, 142, 2, 0, NULL),
(135, 143, 3, 0, NULL),
(136, 144, 1, 0, NULL),
(137, 145, 2, 1, '2026-09-21 12:44:36'),
(138, 146, 3, 0, NULL),
(139, 147, 1, 0, NULL),
(140, 148, 2, 0, NULL),
(141, 149, 3, 0, NULL),
(142, 150, 1, 0, NULL),
(143, 151, 2, 0, NULL),
(144, 152, 3, 0, NULL),
(145, 153, 1, 0, NULL),
(146, 154, 2, 0, NULL),
(147, 155, 3, 0, NULL),
(148, 156, 1, 0, NULL),
(149, 157, 2, 1, '2026-09-21 12:45:14'),
(150, 158, 3, 0, NULL),
(151, 159, 1, 0, NULL),
(152, 160, 2, 0, NULL),
(153, 161, 3, 0, NULL),
(154, 162, 1, 0, NULL),
(155, 163, 2, 0, NULL),
(156, 164, 3, 0, NULL),
(157, 165, 1, 0, NULL),
(158, 166, 2, 0, NULL),
(159, 167, 3, 0, NULL),
(160, 168, 1, 0, NULL),
(161, 169, 2, 1, '2026-09-21 12:46:05'),
(162, 170, 3, 0, NULL),
(163, 171, 1, 0, NULL),
(164, 172, 2, 0, NULL),
(165, 173, 3, 0, NULL),
(166, 174, 1, 0, NULL),
(167, 175, 2, 0, NULL),
(168, 176, 3, 0, NULL),
(169, 177, 1, 0, NULL),
(170, 178, 2, 0, NULL),
(171, 179, 3, 0, NULL),
(173, 180, 1, 0, NULL),
(174, 181, 8, 0, NULL),
(175, 182, 9, 0, NULL),
(176, 183, 10, 1, '2026-09-21 12:47:11'),
(178, 184, 1, 0, NULL),
(179, 185, 8, 0, NULL),
(180, 186, 9, 0, NULL),
(181, 187, 10, 0, NULL),
(183, 188, 1, 0, NULL),
(184, 189, 8, 0, NULL),
(185, 190, 9, 0, NULL),
(186, 191, 10, 0, NULL),
(188, 192, 1, 0, NULL),
(189, 193, 8, 0, NULL),
(190, 194, 9, 0, NULL),
(191, 195, 10, 1, '2026-09-21 12:47:36'),
(196, 199, 1, 0, NULL),
(197, 200, 2, 1, '2026-09-22 04:54:52'),
(198, 201, 3, 0, NULL),
(200, 202, 1, 0, NULL),
(201, 203, 2, 0, NULL),
(202, 204, 3, 0, NULL),
(203, 205, 1, 0, NULL),
(204, 206, 2, 0, NULL),
(205, 207, 3, 0, NULL),
(206, 208, 1, 0, NULL),
(207, 209, 2, 1, '2026-09-23 00:27:26'),
(208, 210, 3, 0, NULL),
(210, 211, 1, 0, NULL),
(211, 212, 8, 0, NULL),
(212, 213, 9, 0, NULL),
(213, 214, 10, 0, NULL),
(214, 215, 1, 0, NULL),
(215, 216, 8, 0, NULL),
(216, 217, 9, 0, NULL),
(217, 218, 10, 0, NULL),
(218, 223, 1, 0, NULL),
(219, 224, 8, 0, NULL),
(220, 225, 9, 0, NULL),
(221, 226, 10, 0, NULL),
(222, 229, 11, 0, NULL),
(223, 228, 11, 0, NULL),
(224, 219, 11, 1, '2026-10-28 05:13:52');

-- --------------------------------------------------------

--
-- Table structure for table `organizations`
--

CREATE TABLE `organizations` (
  `id` int(11) NOT NULL,
  `name` varchar(200) NOT NULL,
  `subtitle` varchar(200) DEFAULT NULL,
  `subtitle2` varchar(200) DEFAULT NULL,
  `logo_path` varchar(500) DEFAULT NULL,
  `form_code` varchar(50) DEFAULT 'FM-CA01/00',
  `is_active` tinyint(1) DEFAULT 1,
  `created_at` timestamp NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `organizations`
--

INSERT INTO `organizations` (`id`, `name`, `subtitle`, `subtitle2`, `logo_path`, `form_code`, `is_active`, `created_at`) VALUES
(1, 'شرکت سروش موتور مبنا', 'تولیدکننده انواع خودرو', '(سهامی خاص)', 'uploads/logo.png', 'FM-CA01/00', 1, '2026-09-29 12:41:05');

-- --------------------------------------------------------

--
-- Table structure for table `organization_settings`
--

CREATE TABLE `organization_settings` (
  `id` int(11) NOT NULL,
  `setting_key` varchar(100) NOT NULL COMMENT 'کلید تنظیم',
  `setting_value` text DEFAULT NULL COMMENT 'مقدار تنظیم',
  `setting_type` varchar(30) DEFAULT 'text' COMMENT 'text|image|html|number',
  `description` varchar(255) DEFAULT NULL COMMENT 'توضیح',
  `updated_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `organization_settings`
--

INSERT INTO `organization_settings` (`id`, `setting_key`, `setting_value`, `setting_type`, `description`, `updated_at`) VALUES
(1, 'company_name', 'شرکت سروش موتور مبنا', 'text', 'نام کامل شرکت', '2026-09-29 12:41:05'),
(2, 'company_subtitle', 'تولیدکننده انواع خودرو', 'text', 'زیرعنوان شرکت', '2026-09-29 12:41:05'),
(3, 'company_subtitle2', '(سهامی خاص)', 'text', 'زیرعنوان دوم', '2026-09-29 12:41:05'),
(4, 'company_logo', '/uploads/logo.png', 'image', 'مسیر لوگو', '2026-09-30 09:40:58'),
(5, 'company_logo_alt', 'لوگوی شرکت', 'text', 'متن جایگزین لوگو', '2026-09-29 12:41:05'),
(6, 'form_code', 'FM-CA01/00', 'text', 'کد فرم', '2026-09-29 12:41:05'),
(7, 'form_title', 'فرم اقدام اصلاحی و بهبود (CA / CAR)', 'text', 'عنوان فرم', '2026-09-29 12:41:05'),
(8, 'form_standard', 'مطابق بند 10.2 استاندارد ISO 9001:2015 و بند 10.2.3 IATF', 'text', 'مرجع استاندارد', '2026-09-29 12:41:05'),
(9, 'header_show_logo', '1', 'number', 'نمایش لوگو (0/1)', '2026-09-29 12:41:05'),
(10, 'header_show_form_code', '1', 'number', 'نمایش کد فرم (0/1)', '2026-09-29 12:41:05'),
(11, 'header_show_date', '1', 'number', 'نمایش تاریخ ایجاد (0/1)', '2026-09-29 12:41:05');

-- --------------------------------------------------------

--
-- Table structure for table `permissions`
--

CREATE TABLE `permissions` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `code` varchar(100) NOT NULL,
  `resource` varchar(50) DEFAULT NULL,
  `action` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `permissions`
--

INSERT INTO `permissions` (`id`, `name`, `code`, `resource`, `action`) VALUES
(1, 'مشاهده لیست NCRها', 'ncr.list', 'ncr', 'view'),
(2, 'ایجاد NCR جدید', 'ncr.create', 'ncr', 'create'),
(3, 'ویرایش پیش‌نویس NCR', 'ncr.edit_draft', 'ncr', 'edit'),
(4, 'ارسال به کنترل کیفیت', 'ncr.submit_quality', 'ncr', 'edit'),
(5, 'تأیید مرحله ۲ NCR', 'ncr.approve_step2', 'ncr', 'approve'),
(6, 'تأیید مرحله ۳ NCR', 'ncr.approve_step3', 'ncr', 'approve'),
(7, 'بستن NCR', 'ncr.close', 'ncr', 'close'),
(8, 'مشاهده Claimها', 'claim.list', 'claim', 'view'),
(9, 'ایجاد Claim', 'claim.create', 'claim', 'create'),
(10, 'تأیید CEO برای Claim', 'claim.ceo_approve', 'claim', 'approve'),
(11, 'مشاهده Shortageها', 'shortage.list', 'shortage', 'view'),
(12, 'ایجاد Shortage', 'shortage.create', 'shortage', 'create'),
(13, 'تأیید درخواست خرید', 'pr.approve', 'purchase', 'approve'),
(14, 'مدیریت کاربران', 'user.manage', 'user', 'manage'),
(15, 'مشاهده گزارشات', 'report.view', 'report', 'view');

-- --------------------------------------------------------

--
-- Table structure for table `purchase_requests`
--

CREATE TABLE `purchase_requests` (
  `id` int(11) NOT NULL,
  `pr_number` varchar(50) NOT NULL,
  `request_date` date NOT NULL,
  `requester_name` varchar(100) NOT NULL,
  `requester_department` varchar(100) DEFAULT NULL,
  `part_code` varchar(50) NOT NULL,
  `part_name` varchar(100) NOT NULL,
  `quantity` int(11) NOT NULL,
  `unit` varchar(20) DEFAULT 'pcs',
  `urgency` varchar(20) DEFAULT 'normal',
  `required_date` date DEFAULT NULL,
  `budget_estimate` decimal(15,2) DEFAULT 0.00,
  `reason` mediumtext DEFAULT NULL,
  `ncr_number` varchar(50) DEFAULT NULL,
  `supervisor_status` varchar(20) DEFAULT 'pending',
  `finance_status` varchar(20) DEFAULT 'pending',
  `procurement_status` varchar(20) DEFAULT 'pending',
  `po_number` varchar(50) DEFAULT NULL,
  `supplier_name` varchar(100) DEFAULT NULL,
  `final_status` varchar(20) DEFAULT 'pending',
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `purchase_requests`
--

INSERT INTO `purchase_requests` (`id`, `pr_number`, `request_date`, `requester_name`, `requester_department`, `part_code`, `part_name`, `quantity`, `unit`, `urgency`, `required_date`, `budget_estimate`, `reason`, `ncr_number`, `supervisor_status`, `finance_status`, `procurement_status`, `po_number`, `supplier_name`, `final_status`, `created_at`, `updated_at`) VALUES
(1, 'PR-2026-0001', '2026-09-01', 'علی رضایی', 'تولید', 'PM-3001', 'بلبرینگ SKF 6206', 100, 'عدد', 'high', '2026-09-20', '20000000.00', 'کمبود بلبرینگ خط تولید', 'NCR-2026-0013', 'approved', 'approved', 'in_progress', 'PO-2026-1001', 'تأمین‌کننده پارس یدک', 'in_progress', '2026-09-11 18:35:24', '2026-09-11 18:35:24'),
(2, 'PR-2026-0002', '2026-09-02', 'فاطمه محمدی', 'تولید', 'PM-3002', 'واشر مسی', 200, 'عدد', 'normal', '2026-09-25', '5000000.00', 'کمبود واشر مسی', 'NCR-2026-0014', 'approved', 'pending', 'pending', NULL, NULL, 'pending', '2026-09-11 18:35:24', '2026-09-11 18:35:24'),
(3, 'PR-2026-0003', '2026-09-03', 'زهرا کریمی', 'انبار', 'PM-3003', 'پیچ M8', 500, 'عدد', 'low', '2026-09-30', '3000000.00', 'کمبود پیچ M8', NULL, 'pending', 'pending', 'pending', NULL, NULL, 'pending', '2026-09-11 18:35:24', '2026-09-11 18:35:24'),
(4, 'PR-2026-0004', '2026-09-04', 'حسن احمدی', 'تولید', 'PM-3004', 'مهره M10', 300, 'عدد', 'normal', '2026-09-28', '4000000.00', 'کمبود مهره M10', NULL, 'approved', 'approved', 'in_progress', 'PO-2026-1002', 'تأمین‌کننده ایران پیچ', 'in_progress', '2026-09-11 18:35:24', '2026-09-11 18:35:24'),
(5, 'PR-2026-0005', '2026-09-05', 'مهدی نوری', 'تولید', 'PM-3005', 'ورق فولادی', 50, 'کیلوگرم', 'high', '2026-09-18', '15000000.00', 'کمبود ورق فولادی', 'NCR-2026-0015', 'approved', 'approved', 'completed', 'PO-2026-1003', 'تأمین‌کننده فولاد پارس', 'completed', '2026-09-11 18:35:24', '2026-09-11 18:35:24'),
(6, 'PR-2026-0006', '2026-09-06', 'سعید مرادی', 'خرید', 'PM-3006', 'لاستیک صنعتی', 20, 'عدد', 'normal', '2026-09-27', '8000000.00', 'کمبود لاستیک صنعتی', NULL, 'approved', 'pending', 'pending', NULL, NULL, 'pending', '2026-09-11 18:35:24', '2026-09-11 18:35:24'),
(7, 'PR-2026-0007', '2026-09-07', 'نرگس سلطانی', 'انبار', 'PM-3007', 'رنگ صنعتی', 100, 'لیتر', 'high', '2026-09-22', '12000000.00', 'کمبود رنگ صنعتی', 'NCR-2026-0016', 'pending', 'pending', 'pending', NULL, NULL, 'pending', '2026-09-11 18:35:24', '2026-09-11 18:35:24'),
(8, 'PR-2026-0008', '2026-09-08', 'امیر حسینی', 'مهندسی', 'PM-3008', 'سیم مسی', 200, 'متر', 'normal', '2026-09-29', '6000000.00', 'کمبود سیم مسی', NULL, 'approved', 'approved', 'in_progress', 'PO-2026-1004', 'تأمین‌کننده برق صنعتی', 'in_progress', '2026-09-11 18:35:24', '2026-09-11 18:35:24'),
(9, 'PR-2026-0009', '2026-09-09', 'پریسا رحیمی', 'مهندسی', 'PM-3009', 'سنسور دما', 50, 'عدد', 'high', '2026-09-21', '25000000.00', 'کمبود سنسور دما', 'NCR-2026-0017', 'approved', 'approved', 'completed', 'PO-2026-1005', 'تأمین‌کننده سنسور', 'completed', '2026-09-11 18:35:24', '2026-09-11 18:35:24'),
(10, 'PR-2026-0010', '2026-09-10', 'کامران اسدی', 'مدیریت', 'PM-3010', 'قطعه یدکی', 30, 'عدد', 'critical', '2026-09-15', '50000000.00', 'کمبود قطعه یدکی', 'NCR-2026-0018', 'approved', 'approved', 'in_progress', 'PO-2026-1006', 'تأمین‌کننده یدکی پارس', 'in_progress', '2026-09-11 18:35:24', '2026-09-11 18:35:24'),
(11, 'PR-2026-0011', '2026-09-11', 'رضا قاسمی', 'تولید', 'PM-3011', 'بلبرینگ NSK', 80, 'عدد', 'high', '2026-09-24', '18000000.00', 'کمبود بلبرینگ NSK', NULL, 'pending', 'pending', 'pending', NULL, NULL, 'pending', '2026-09-11 18:35:24', '2026-09-11 18:35:24'),
(12, 'PR-2026-0012', '2026-09-12', 'لیلا اکبری', 'کنترل کیفیت', 'PM-3012', 'واشر لاستیکی', 150, 'عدد', 'normal', '2026-09-26', '4500000.00', 'کمبود واشر لاستیکی', NULL, 'approved', 'approved', 'in_progress', 'PO-2026-1007', 'تأمین‌کننده لاستیک', 'in_progress', '2026-09-11 18:35:24', '2026-09-11 18:35:24'),
(13, 'PR-2026-0013', '2026-09-13', 'علی رضایی', 'تولید', 'PM-3013', 'پیچ M12', 400, 'عدد', 'low', '2026-10-01', '3500000.00', 'کمبود پیچ M12', NULL, 'approved', 'pending', 'pending', NULL, NULL, 'pending', '2026-09-11 18:35:24', '2026-09-11 18:35:24'),
(14, 'PR-2026-0014', '2026-09-14', 'فاطمه محمدی', 'تولید', 'PM-3014', 'مهره M14', 250, 'عدد', 'normal', '2026-09-30', '4200000.00', 'کمبود مهره M14', NULL, 'pending', 'pending', 'pending', NULL, NULL, 'pending', '2026-09-11 18:35:24', '2026-09-11 18:35:24'),
(15, 'PR-2026-0015', '2026-09-15', 'زهرا کریمی', 'انبار', 'PM-3015', 'ورق آلومینیوم', 40, 'کیلوگرم', 'high', '2026-09-23', '22000000.00', 'کمبود ورق آلومینیوم', 'NCR-2026-0019', 'approved', 'approved', 'in_progress', 'PO-2026-1008', 'تأمین‌کننده آلومینیوم', 'in_progress', '2026-09-11 18:35:24', '2026-09-11 18:35:24');

-- --------------------------------------------------------

--
-- Table structure for table `roles`
--

CREATE TABLE `roles` (
  `id` int(11) NOT NULL,
  `name` varchar(50) NOT NULL,
  `description` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `roles`
--

INSERT INTO `roles` (`id`, `name`, `description`) VALUES
(1, 'admin', 'مدیر سیستم با دسترسی کامل'),
(2, 'quality', 'کارشناس کنترل کیفیت'),
(3, 'production', 'کارشناس تولید'),
(4, 'purchasing', 'کارشناس خرید'),
(5, 'warehouse', 'کارشناس انبار'),
(6, 'engineering', 'کارشناس مهندسی'),
(7, 'ceo', 'مدیرعامل'),
(8, 'supervisor', 'سرپرست خط تولید'),
(9, 'inspector', 'بازرس کیفیت'),
(10, 'cft_member', 'عضو کمیته CFT'),
(11, 'auditor', 'ممیز داخلی'),
(12, 'viewer', 'فقط مشاهده');

-- --------------------------------------------------------

--
-- Table structure for table `role_permissions`
--

CREATE TABLE `role_permissions` (
  `role_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `role_permissions`
--

INSERT INTO `role_permissions` (`role_id`, `permission_id`) VALUES
(1, 1),
(2, 1),
(3, 1),
(4, 1),
(5, 1),
(6, 1),
(7, 1),
(8, 1),
(9, 1),
(10, 1),
(11, 1),
(12, 1),
(1, 2),
(2, 2),
(3, 2),
(8, 2),
(1, 3),
(2, 3),
(3, 3),
(8, 3),
(1, 4),
(2, 4),
(3, 4),
(8, 4),
(9, 4),
(1, 5),
(2, 5),
(9, 5),
(1, 6),
(2, 6),
(1, 7),
(2, 7),
(1, 8),
(2, 8),
(3, 8),
(4, 8),
(5, 8),
(6, 8),
(7, 8),
(1, 9),
(2, 9),
(1, 10),
(2, 10),
(7, 10),
(1, 11),
(3, 11),
(4, 11),
(5, 11),
(7, 11),
(1, 12),
(5, 12),
(1, 13),
(4, 13),
(7, 13),
(1, 14),
(1, 15),
(2, 15),
(3, 15),
(4, 15),
(5, 15),
(6, 15),
(7, 15),
(8, 15),
(9, 15),
(10, 15),
(11, 15),
(12, 15);

-- --------------------------------------------------------

--
-- Table structure for table `shortages`
--

CREATE TABLE `shortages` (
  `id` int(11) NOT NULL,
  `shortage_number` varchar(50) NOT NULL,
  `report_date` date NOT NULL,
  `reporter_name` varchar(100) NOT NULL,
  `reporter_department` varchar(100) DEFAULT NULL,
  `subject` varchar(255) NOT NULL,
  `part_code` varchar(50) NOT NULL,
  `part_name` varchar(100) NOT NULL,
  `requested_qty` int(11) DEFAULT 0,
  `sent_qty` int(11) DEFAULT 0,
  `shortage_qty` int(11) DEFAULT 0,
  `unit` varchar(20) DEFAULT 'pcs',
  `description` mediumtext DEFAULT NULL,
  `ceo_status` varchar(20) DEFAULT 'pending',
  `supplier_status` varchar(20) DEFAULT 'pending',
  `final_status` varchar(20) DEFAULT 'open',
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `shortages`
--

INSERT INTO `shortages` (`id`, `shortage_number`, `report_date`, `reporter_name`, `reporter_department`, `subject`, `part_code`, `part_name`, `requested_qty`, `sent_qty`, `shortage_qty`, `unit`, `description`, `ceo_status`, `supplier_status`, `final_status`, `created_at`, `updated_at`) VALUES
(1, 'SH-2026-0001', '2026-09-01', 'علی رضایی', 'تولید', 'کمبود بلبرینگ خط ۲', 'PM-2001', 'بلبرینگ SKF 6206', 100, 95, 5, 'عدد', 'کمبود ۵ عدد بلبرینگ خط ۲', 'approved', 'approved', 'in_progress', '2026-09-11 18:35:24', '2026-09-11 18:35:24'),
(2, 'SH-2026-0002', '2026-09-02', 'فاطمه محمدی', 'تولید', 'کمبود واشر خط ۳', 'PM-2002', 'واشر مسی', 200, 180, 20, 'عدد', 'کمبود ۲۰ عدد واشر مسی', 'approved', 'pending', 'in_progress', '2026-09-11 18:35:24', '2026-09-11 18:35:24'),
(3, 'SH-2026-0003', '2026-09-03', 'زهرا کریمی', 'انبار', 'کمبود پیچ خط ۱', 'PM-2003', 'پیچ M8', 500, 480, 20, 'عدد', 'کمبود ۲۰ عدد پیچ M8', 'pending', 'pending', 'open', '2026-09-11 18:35:24', '2026-09-11 18:35:24'),
(4, 'SH-2026-0004', '2026-09-04', 'حسن احمدی', 'تولید', 'کمبود مهره خط ۴', 'PM-2004', 'مهره M10', 300, 290, 10, 'عدد', 'کمبود ۱۰ عدد مهره M10', 'approved', 'approved', 'in_progress', '2026-09-11 18:35:24', '2026-09-11 18:35:24'),
(5, 'SH-2026-0005', '2026-09-05', 'مهدی نوری', 'تولید', 'کمبود ورق خط ۵', 'PM-2005', 'ورق فولادی', 50, 45, 5, 'کیلوگرم', 'کمبود ۵ کیلوگرم ورق', 'approved', 'approved', 'closed', '2026-09-11 18:35:24', '2026-09-11 18:35:24'),
(6, 'SH-2026-0006', '2026-09-06', 'سعید مرادی', 'خرید', 'کمبود لاستیک خط ۶', 'PM-2006', 'لاستیک صنعتی', 20, 18, 2, 'عدد', 'کمبود ۲ عدد لاستیک صنعتی', 'approved', 'pending', 'in_progress', '2026-09-11 18:35:24', '2026-09-11 18:35:24'),
(7, 'SH-2026-0007', '2026-09-07', 'نرگس سلطانی', 'انبار', 'کمبود رنگ خط ۷', 'PM-2007', 'رنگ صنعتی', 100, 90, 10, 'لیتر', 'کمبود ۱۰ لیتر رنگ صنعتی', 'pending', 'pending', 'open', '2026-09-11 18:35:24', '2026-09-11 18:35:24'),
(8, 'SH-2026-0008', '2026-09-08', 'امیر حسینی', 'مهندسی', 'کمبود سیم خط ۸', 'PM-2008', 'سیم مسی', 200, 190, 10, 'متر', 'کمبود ۱۰ متر سیم مسی', 'approved', 'approved', 'in_progress', '2026-09-11 18:35:24', '2026-09-11 18:35:24'),
(9, 'SH-2026-0009', '2026-09-09', 'پریسا رحیمی', 'مهندسی', 'کمبود سنسور خط ۹', 'PM-2009', 'سنسور دما', 50, 48, 2, 'عدد', 'کمبود ۲ عدد سنسور دما', 'approved', 'approved', 'closed', '2026-09-11 18:35:24', '2026-09-11 18:35:24'),
(10, 'SH-2026-0010', '2026-09-10', 'کامران اسدی', 'مدیریت', 'کمبود قطعه خط ۱۰', 'PM-2010', 'قطعه یدکی', 30, 28, 2, 'عدد', 'کمبود ۲ عدد قطعه یدکی', 'approved', 'pending', 'in_progress', '2026-09-11 18:35:24', '2026-09-11 18:35:24'),
(11, 'SH-2026-0011', '2026-09-11', 'رضا قاسمی', 'تولید', 'کمبود بلبرینگ خط ۱۱', 'PM-2011', 'بلبرینگ NSK', 80, 75, 5, 'عدد', 'کمبود ۵ عدد بلبرینگ NSK', 'pending', 'pending', 'open', '2026-09-11 18:35:24', '2026-09-11 18:35:24'),
(12, 'SH-2026-0012', '2026-09-12', 'لیلا اکبری', 'کنترل کیفیت', 'کمبود واشر خط ۱۲', 'PM-2012', 'واشر لاستیکی', 150, 140, 10, 'عدد', 'کمبود ۱۰ عدد واشر لاستیکی', 'approved', 'approved', 'in_progress', '2026-09-11 18:35:24', '2026-09-11 18:35:24'),
(13, 'SH-2026-0013', '2026-09-13', 'علی رضایی', 'تولید', 'کمبود پیچ خط ۱۳', 'PM-2013', 'پیچ M12', 400, 380, 20, 'عدد', 'کمبود ۲۰ عدد پیچ M12', 'approved', 'approved', 'closed', '2026-09-11 18:35:24', '2026-09-11 18:35:24'),
(14, 'SH-2026-0014', '2026-09-14', 'فاطمه محمدی', 'تولید', 'کمبود مهره خط ۱۴', 'PM-2014', 'مهره M14', 250, 240, 10, 'عدد', 'کمبود ۱۰ عدد مهره M14', 'pending', 'pending', 'open', '2026-09-11 18:35:24', '2026-09-11 18:35:24'),
(15, 'SH-2026-0015', '2026-09-15', 'زهرا کریمی', 'انبار', 'کمبود ورق خط ۱۵', 'PM-2015', 'ورق آلومینیوم', 40, 36, 4, 'کیلوگرم', 'کمبود ۴ کیلوگرم ورق', 'approved', 'approved', 'in_progress', '2026-09-11 18:35:24', '2026-09-11 18:35:24');

-- --------------------------------------------------------

--
-- Table structure for table `system_settings`
--

CREATE TABLE `system_settings` (
  `id` int(11) NOT NULL,
  `setting_key` varchar(100) NOT NULL,
  `setting_value` mediumtext DEFAULT NULL,
  `updated_at` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `system_settings`
--

INSERT INTO `system_settings` (`id`, `setting_key`, `setting_value`, `updated_at`) VALUES
(1, 'company_name', 'شرکت خودروسازی پارس', '2026-09-11 18:35:25'),
(2, 'company_logo', 'logo.png', '2026-09-11 18:35:25'),
(3, 'default_language', 'fa', '2026-09-11 18:35:25'),
(4, 'default_theme', 'light', '2026-09-11 18:35:25'),
(5, 'ncr_prefix', 'NCR', '2026-09-11 18:35:25'),
(6, 'claim_prefix', 'CLM', '2026-09-11 18:35:25'),
(7, 'shortage_prefix', 'SH', '2026-09-11 18:35:25'),
(8, 'pr_prefix', 'PR', '2026-09-11 18:35:25'),
(9, 'max_file_size', '5242880', '2026-09-11 18:35:25'),
(10, 'allowed_extensions', 'jpg,png,pdf,docx', '2026-09-11 18:35:25'),
(11, 'email_notifications', '1', '2026-09-11 18:35:25'),
(12, 'sms_notifications', '0', '2026-09-11 18:35:25'),
(13, 'backup_frequency', 'daily', '2026-09-11 18:35:25'),
(14, 'session_timeout', '3600', '2026-09-11 18:35:25'),
(15, 'items_per_page', '20', '2026-09-11 18:35:25');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `username` varchar(50) NOT NULL,
  `password` varchar(255) NOT NULL,
  `full_name` varchar(100) NOT NULL,
  `email` varchar(100) DEFAULT NULL,
  `role` varchar(50) NOT NULL,
  `department` varchar(100) DEFAULT NULL,
  `avatar` varchar(255) DEFAULT NULL,
  `language` varchar(10) DEFAULT 'fa',
  `created_at` datetime DEFAULT current_timestamp(),
  `last_login` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `user_id`, `username`, `password`, `full_name`, `email`, `role`, `department`, `avatar`, `language`, `created_at`, `last_login`) VALUES
(1, 1001, 'admin', 'admin123', 'محمد پورسان', 'admin@ncr-system.com', 'admin', 'مدیریت', NULL, 'fa', '2026-09-11 18:35:24', '2026-10-30 21:39:41'),
(2, 1002, 'quality', 'quality123', 'فاطمه محمدی', 'quality@ncr-system.com', 'quality', 'کنترل کیفیت', NULL, 'fa', '2026-09-11 18:35:24', '2026-09-27 09:43:42'),
(3, 1003, 'quality2', 'quality123', 'زهرا کریمی', 'quality2@ncr-system.com', 'quality', 'کنترل کیفیت', NULL, 'fa', '2026-09-11 18:35:24', NULL),
(4, 1004, 'production', 'prod123', 'حسن احمدی', 'production@ncr-system.com', 'production', 'تولید', NULL, 'fa', '2026-09-11 18:35:24', '2026-10-28 05:49:58'),
(5, 1005, 'production2', 'prod123', 'مهدی نوری', 'production2@ncr-system.com', 'production', 'تولید', NULL, 'fa', '2026-09-11 18:35:24', NULL),
(6, 1006, 'purchasing', 'purch123', 'سعید مرادی', 'purchasing@ncr-system.com', 'purchasing', 'خرید', NULL, 'fa', '2026-09-11 18:35:24', NULL),
(7, 1007, 'warehouse', 'ware123', 'نرگس سلطانی', 'warehouse@ncr-system.com', 'warehouse', 'انبار', NULL, 'fa', '2026-09-11 18:35:24', NULL),
(8, 1008, 'engineering', 'eng123', 'امیر حسینی', 'engineering@ncr-system.com', 'engineering', 'مهندسی', NULL, 'fa', '2026-09-11 18:35:24', '2026-09-16 05:15:23'),
(9, 1009, 'engineering2', 'eng123', 'پریسا رحیمی', 'engineering2@ncr-system.com', 'engineering', 'مهندسی', NULL, 'fa', '2026-09-11 18:35:24', NULL),
(10, 1010, 'ceo', 'ceo123', 'دکتر کامران اسدی', 'ceo@ncr-system.com', 'ceo', 'مدیریت', NULL, 'fa', '2026-09-11 18:35:24', '2026-09-27 10:19:12'),
(11, 1011, 'supervisor', 'super123', 'رضا قاسمی', 'supervisor@ncr-system.com', 'supervisor', 'تولید', NULL, 'fa', '2026-09-11 18:35:24', '2026-10-28 05:50:47'),
(12, 1012, 'inspector', 'insp123', 'لیلا اکبری', 'inspector@ncr-system.com', 'inspector', 'کنترل کیفیت', NULL, 'fa', '2026-09-11 18:35:24', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `user_roles`
--

CREATE TABLE `user_roles` (
  `user_id` int(11) NOT NULL,
  `role_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `user_roles`
--

INSERT INTO `user_roles` (`user_id`, `role_id`) VALUES
(1001, 1),
(1002, 2),
(1003, 2),
(1004, 3),
(1005, 3),
(1006, 4),
(1007, 5),
(1008, 6),
(1009, 6),
(1010, 7),
(1011, 8),
(1012, 9);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `claims`
--
ALTER TABLE `claims`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uk_claim_number` (`claim_number`),
  ADD KEY `idx_ncr_number` (`ncr_number`);

--
-- Indexes for table `ncrs`
--
ALTER TABLE `ncrs`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uk_ncr_number` (`ncr_number`),
  ADD KEY `idx_status` (`status`),
  ADD KEY `idx_report_date` (`report_date`);

--
-- Indexes for table `notifications`
--
ALTER TABLE `notifications`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_user_id` (`user_id`);

--
-- Indexes for table `notification_reads`
--
ALTER TABLE `notification_reads`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uk_notification_user` (`notification_id`,`user_id`),
  ADD KEY `idx_user_read` (`user_id`,`is_read`);

--
-- Indexes for table `organizations`
--
ALTER TABLE `organizations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `organization_settings`
--
ALTER TABLE `organization_settings`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `setting_key` (`setting_key`),
  ADD KEY `idx_key` (`setting_key`);

--
-- Indexes for table `permissions`
--
ALTER TABLE `permissions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uk_code` (`code`);

--
-- Indexes for table `purchase_requests`
--
ALTER TABLE `purchase_requests`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uk_pr_number` (`pr_number`);

--
-- Indexes for table `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uk_name` (`name`);

--
-- Indexes for table `role_permissions`
--
ALTER TABLE `role_permissions`
  ADD PRIMARY KEY (`role_id`,`permission_id`),
  ADD KEY `idx_permission_id` (`permission_id`);

--
-- Indexes for table `shortages`
--
ALTER TABLE `shortages`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uk_shortage_number` (`shortage_number`);

--
-- Indexes for table `system_settings`
--
ALTER TABLE `system_settings`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uk_setting_key` (`setting_key`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uk_user_id` (`user_id`),
  ADD UNIQUE KEY `uk_username` (`username`);

--
-- Indexes for table `user_roles`
--
ALTER TABLE `user_roles`
  ADD PRIMARY KEY (`user_id`,`role_id`),
  ADD KEY `idx_role_id` (`role_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `claims`
--
ALTER TABLE `claims`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `ncrs`
--
ALTER TABLE `ncrs`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;

--
-- AUTO_INCREMENT for table `notifications`
--
ALTER TABLE `notifications`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=230;

--
-- AUTO_INCREMENT for table `notification_reads`
--
ALTER TABLE `notification_reads`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=225;

--
-- AUTO_INCREMENT for table `organizations`
--
ALTER TABLE `organizations`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `organization_settings`
--
ALTER TABLE `organization_settings`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `permissions`
--
ALTER TABLE `permissions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `purchase_requests`
--
ALTER TABLE `purchase_requests`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `roles`
--
ALTER TABLE `roles`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `shortages`
--
ALTER TABLE `shortages`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `system_settings`
--
ALTER TABLE `system_settings`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `notifications`
--
ALTER TABLE `notifications`
  ADD CONSTRAINT `fk_notif_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `notification_reads`
--
ALTER TABLE `notification_reads`
  ADD CONSTRAINT `fk_nr_notif` FOREIGN KEY (`notification_id`) REFERENCES `notifications` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_nr_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `role_permissions`
--
ALTER TABLE `role_permissions`
  ADD CONSTRAINT `fk_rp_perm` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_rp_role` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `user_roles`
--
ALTER TABLE `user_roles`
  ADD CONSTRAINT `fk_ur_role` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_ur_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
