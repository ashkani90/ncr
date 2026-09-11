-- phpMyAdmin SQL Dump
-- version 4.9.0.1
-- https://www.phpmyadmin.net/
--
-- Host: sql210.infinityfree.com
-- Generation Time: Sep 11, 2026 at 09:40 AM
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
  `invoice_image` varchar(255) DEFAULT NULL,
  `part_code` varchar(50) NOT NULL,
  `part_name` varchar(100) NOT NULL,
  `quantity` int(11) NOT NULL,
  `unit` varchar(20) DEFAULT 'pcs',
  `return_reason` varchar(100) DEFAULT NULL,
  `return_reason_description` mediumtext DEFAULT NULL,
  `part_image` varchar(255) DEFAULT NULL,
  `request_type` varchar(50) DEFAULT NULL,
  `claim_quantity` int(11) DEFAULT 0,
  `priority` varchar(20) DEFAULT 'medium',
  `claim_stage` int(11) DEFAULT 1,
  `ceo_status` varchar(20) DEFAULT 'pending',
  `ceo_approved_date` date DEFAULT NULL,
  `ceo_notes` mediumtext DEFAULT NULL,
  `supplier_status` varchar(20) DEFAULT 'pending',
  `supplier_response_date` date DEFAULT NULL,
  `supplier_approved` tinyint(1) DEFAULT 0,
  `supplier_replacement_date` date DEFAULT NULL,
  `supplier_cost_amount` decimal(15,2) DEFAULT 0.00,
  `supplier_notes` mediumtext DEFAULT NULL,
  `corrective_action_number` varchar(50) DEFAULT NULL,
  `action_result` mediumtext DEFAULT NULL,
  `warehouse_status` varchar(20) DEFAULT 'pending',
  `replacement_received_date` date DEFAULT NULL,
  `replacement_quantity` int(11) DEFAULT 0,
  `warehouse_notes` mediumtext DEFAULT NULL,
  `final_status` varchar(20) DEFAULT 'open',
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `claims`
--

INSERT INTO `claims` (`id`, `claim_number`, `claim_date`, `ncr_number`, `supplier_name`, `supplier_contact`, `order_date`, `invoice_number`, `invoice_image`, `part_code`, `part_name`, `quantity`, `unit`, `return_reason`, `return_reason_description`, `part_image`, `request_type`, `claim_quantity`, `priority`, `claim_stage`, `ceo_status`, `ceo_approved_date`, `ceo_notes`, `supplier_status`, `supplier_response_date`, `supplier_approved`, `supplier_replacement_date`, `supplier_cost_amount`, `supplier_notes`, `corrective_action_number`, `action_result`, `warehouse_status`, `replacement_received_date`, `replacement_quantity`, `warehouse_notes`, `final_status`, `created_at`, `updated_at`) VALUES
(1, 'CLM-2026-0001', '2026-08-06', 'NCR-2026-0001', '??????????? ????? ????? ?????', '09123456789', '2026-07-25', 'INV-2026-0456', NULL, 'PM-1024', '??????? SKF 6205', 48, '???', '?????', '????? ??????? ?? ??? ????? ?? ???? ????', NULL, '????? ?? ????? ????', 2, 'high', 1, 'approved', '2026-08-07', '????? ???? ???? ???.', 'approved', '2026-08-09', 1, '2026-08-20', '0.00', '???? ??????? ????? ??????.', 'CA-2026-0001', '??????????? ????? ???.', 'pending', NULL, 0, NULL, 'in_progress', '2026-08-26 03:09:52', '2026-08-26 03:09:52');

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
  `standard_ref` varchar(100) DEFAULT NULL,
  `batch_number` varchar(50) DEFAULT NULL,
  `immediate_action` varchar(50) DEFAULT NULL,
  `severity` varchar(20) DEFAULT NULL,
  `quality_notes` mediumtext DEFAULT NULL,
  `analysis_method` varchar(50) DEFAULT NULL,
  `fishbone_checks` mediumtext DEFAULT NULL,
  `fishbone_other` varchar(100) DEFAULT NULL,
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
  `created_by` varchar(100) DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `ncrs`
--

INSERT INTO `ncrs` (`id`, `ncr_number`, `status`, `current_step`, `report_date`, `reporter_name`, `reporter_position`, `reporter_department`, `location_found`, `inspection_number`, `work_station`, `skeleton_process`, `sheet_metal_process`, `fiber_process`, `painting_process`, `product_type`, `bus_model`, `car_model`, `truck_model`, `minibus_model`, `tractor_model`, `part_code`, `part_name`, `quantity`, `unit`, `description`, `standard_ref`, `batch_number`, `immediate_action`, `severity`, `quality_notes`, `analysis_method`, `fishbone_checks`, `fishbone_other`, `why1`, `why2`, `why3`, `why4`, `why5`, `analysis_conclusion`, `quality_checker`, `quality_check_date`, `confirmation`, `reject_reason`, `disposition_type`, `rework_responsible`, `rework_deadline`, `rework_action_number`, `concession_number`, `hold_reason`, `claim_number`, `purchase_number`, `corrective_action`, `corrective_number`, `cft_committee`, `cft_date`, `effectiveness`, `ineffective_action_number`, `monitoring_date`, `monitoring_responsible`, `monitoring_notes`, `final_status`, `closure_date`, `closure_by`, `step1_completed`, `step2_completed`, `step3_completed`, `step4_completed`, `step1_locked`, `step2_locked`, `step3_locked`, `step4_locked`, `step1_submitted_at`, `step2_submitted_at`, `step3_submitted_at`, `step4_submitted_at`, `created_by`, `created_at`, `updated_at`) VALUES
(20, 'NCR-2026-0008', 'closed', 3, '2026-09-08', 'مجید طاهری', 'کارشناس تولید', 'تولید', 'محصول نهایی', NULL, NULL, NULL, NULL, NULL, NULL, 'کامیونت', NULL, NULL, NULL, NULL, NULL, 'T-8003-56', 'ورق بدنه کامیونت', 12, 'کیلوگرم', 'ترک‌های متعدد و خوردگی شدید در ورق بدنه کامیونت پس از رنگ‌آمیزی', NULL, NULL, 'قرنطینه', 'بحرانی', NULL, 'fishbone', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'کیفیت نامناسب ورق و خطا در فرآیند رنگ‌آمیزی', NULL, NULL, 'yes', NULL, 'scrap', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'yes', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 1, 1, 0, 1, 1, 1, 0, NULL, NULL, NULL, NULL, 'مجید طاهری', '2026-09-08 13:10:00', '2026-09-07 05:55:30'),
(19, 'NCR-2026-0007', 'step2_submitted', 2, '2026-09-07', 'حسین نوری', 'مدیر فنی', 'مهندسی', 'حین تولید', NULL, NULL, NULL, NULL, NULL, NULL, 'اتوبوس', NULL, NULL, NULL, NULL, NULL, 'B-7010-34', 'سیستم روشنایی اتوبوس VIP', 20, 'عدد', 'چراغ‌های LED دارای نوسان و روشنایی نامناسب در اتوبوس 27 نفره VIP', NULL, NULL, 'توقف تولید', 'عمده', NULL, '5why', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'کمبود موجودی قطعه با کیفیت در انبار و نیاز به خرید فوری', NULL, NULL, 'yes', NULL, 'purchase', NULL, NULL, NULL, NULL, NULL, NULL, 'PO-2026-089', 'yes', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 1, 0, 0, 1, 1, 0, 0, NULL, NULL, NULL, NULL, 'حسین نوری', '2026-09-07 10:00:00', '2026-09-07 05:55:30'),
(18, 'NCR-2026-0006', 'step2_submitted', 2, '2026-09-06', 'مریم عسگری', 'سرپرست کیفیت', 'کنترل کیفیت', 'ورودی', NULL, NULL, NULL, NULL, NULL, NULL, 'سواری', NULL, NULL, NULL, NULL, NULL, 'C-6009-08', 'سنسور پارک وویا فری', 15, 'عدد', 'سنسورهای پارک دریافتی دارای خطای اندازه‌گیری و عدم تطابق با مشخصات فنی', NULL, NULL, 'قرنطینه', 'عمده', NULL, 'fishbone', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'علت اصلی: عدم کنترل کیفیت توسط تأمین‌کننده در فرآیند تولید سنسور', NULL, NULL, 'yes', NULL, 'claim', NULL, NULL, NULL, NULL, NULL, 'CLM-2026-001', NULL, 'no', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 1, 0, 0, 1, 1, 0, 0, NULL, NULL, NULL, NULL, 'مریم عسگری', '2026-09-06 08:45:00', '2026-09-07 05:55:30'),
(17, 'NCR-2026-0005', 'closed', 3, '2026-09-05', 'احمد رضایی', 'کارشناس کیفیت', 'کنترل کیفیت', 'خدمات پس از فروش', NULL, NULL, NULL, NULL, NULL, NULL, 'کشنده', NULL, NULL, NULL, NULL, NULL, 'TR-5001-22', 'آینه بغل کشنده', 8, 'عدد', 'لرزش و شل بودن آینه بغل در کشنده‌های مدل مان', NULL, NULL, 'علامت گذاری', 'جزئی', NULL, '5why', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'بررسی نشان داد مشکل ناشی از نصب نادرست توسط کاربر نهایی است', NULL, NULL, 'no', 'عدم انطباق تأیید نشد. مشکل از نصب کاربر نهایی بوده است.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 1, 1, 0, 1, 1, 1, 0, NULL, NULL, NULL, NULL, 'احمد رضایی', '2026-09-05 14:20:00', '2026-09-07 05:55:30'),
(16, 'NCR-2026-0004', 'draft', 1, '2026-09-04', 'سارا حسینی', 'کارشناس مهندسی', 'مهندسی', 'حین تولید', NULL, NULL, NULL, NULL, NULL, NULL, 'مینی بوس', NULL, NULL, NULL, NULL, NULL, 'M-4002-03', 'سیستم تهویه مینی‌بوس', 3, 'عدد', 'صدای غیرعادی در سیستم تهویه مینی‌بوس هیوندای هنگام تست نهایی', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, NULL, NULL, 'سارا حسینی', '2026-09-04 11:30:00', '2026-09-07 05:55:30'),
(15, 'NCR-2026-0003', 'step1_submitted', 1, '2026-09-03', 'علی احمدی', 'کارشناس انبار', 'انبار', 'ورودی', NULL, NULL, NULL, NULL, NULL, NULL, 'کامیونت', NULL, NULL, NULL, NULL, NULL, 'T-3008-07', 'سیستم ترمز کامیونت فوتون', 10, 'عدد', 'قطعات سیستم ترمز دارای زنگ زدگی و خوردگی در بدو ورود به انبار', 'ISO-9001-2023', 'BATCH-456-09', 'قرنطینه', 'بحرانی', 'احتمالاً مشکل در بسته‌بندی و شرایط حمل و نقل', 'fishbone', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 0, 0, 0, 1, 0, 0, 0, NULL, NULL, NULL, NULL, 'علی احمدی', '2026-09-03 09:00:00', '2026-09-07 05:55:30'),
(14, 'NCR-2026-0002', 'step3_submitted', 3, '2026-09-02', 'محمد کریمی', 'سرپرست تولید', 'تولید', 'محصول نهایی', NULL, NULL, NULL, NULL, NULL, NULL, 'سواری', NULL, NULL, NULL, NULL, NULL, 'C-2005-12', 'سپر جلو آرکانا', 2, 'عدد', 'ترک خوردگی و تغییر رنگ در سپر جلو خودرو آرکانا در خط تکمیل نهایی', NULL, NULL, 'جداسازی', 'جزئی', NULL, '5why', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'علت ریشه‌ای: دمای قالب نامناسب و زمان پخت ناکافی', NULL, NULL, 'yes', NULL, 'concession', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'no', NULL, NULL, NULL, 'pending', NULL, NULL, NULL, NULL, 'open', NULL, NULL, 1, 1, 1, 0, 1, 1, 1, 0, NULL, NULL, NULL, NULL, 'محمد کریمی', '2026-09-02 10:15:00', '2026-09-07 05:55:30'),
(13, 'NCR-2026-0001', 'closed', 4, '2026-09-01', 'رضا محمدی', 'کارشناس کنترل کیفیت', 'کنترل کیفیت', 'حین تولید', NULL, NULL, NULL, NULL, NULL, NULL, 'اتوبوس', NULL, NULL, NULL, NULL, NULL, 'B-1001-45', 'پنل درب اتوبوس', 5, 'عدد', 'ترک در پنل درب اتوبوس مدل 55 نفره در ایستگاه اسکلت مشاهده شد', NULL, NULL, 'قرنطینه', 'عمده', NULL, 'fishbone', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'علت اصلی: نقص در فرآیند جوشکاری و کیفیت پایین ورق فولادی', NULL, NULL, 'yes', NULL, 'rework', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'yes', NULL, NULL, NULL, 'yes', NULL, NULL, NULL, NULL, 'closed', NULL, NULL, 1, 1, 1, 1, 1, 1, 1, 1, NULL, NULL, NULL, NULL, 'رضا محمدی', '2026-09-01 08:30:00', '2026-09-07 05:55:30'),
(21, 'NCR-2026-0009', 'step2_submitted', 2, '2026-09-09', 'زهرا قاسمی', 'سرپرست انبار', 'انبار', 'انبار', NULL, NULL, NULL, NULL, NULL, NULL, 'مینی بوس', NULL, NULL, NULL, NULL, NULL, 'M-9004-12', 'درب عقب مینی‌بوس', 6, 'عدد', 'انحراف در ابعاد درب عقب مینی‌بوس نسبت به نقشه استاندارد', NULL, NULL, 'جداسازی', 'جزئی', NULL, '5why', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'عدم تطابق قالب تولید با نقشه‌های مهندسی', NULL, NULL, 'yes', NULL, 'hold', NULL, NULL, NULL, NULL, 'در انتظار بررسی مجدد نقشه‌ها توسط مهندسی', NULL, NULL, 'no', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 1, 0, 0, 1, 1, 0, 0, NULL, NULL, NULL, NULL, 'زهرا قاسمی', '2026-09-09 09:30:00', '2026-09-07 05:55:30'),
(22, 'NCR-2026-0010', 'closed', 4, '2026-09-10', 'نادر صفری', 'مدیر کیفیت', 'کنترل کیفیت', 'حین تولید', NULL, NULL, NULL, NULL, NULL, NULL, 'سواری', NULL, NULL, NULL, NULL, NULL, 'C-0011-78', 'سیستم تهویه ام‌هیرو', 4, 'عدد', 'صدای غیرعادی و عملکرد نامناسب سیستم تهویه در خودروهای ام‌هیرو', NULL, NULL, 'قرنطینه', 'عمده', NULL, 'fishbone', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'نقص در طراحی پلنوم و کیفیت مواد اولیه', NULL, NULL, 'yes', NULL, 'rework', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'yes', NULL, NULL, NULL, 'no', 'CA-2026-056', NULL, NULL, NULL, 'open', NULL, NULL, 1, 1, 1, 1, 1, 1, 1, 1, NULL, NULL, NULL, NULL, 'نادر صفری', '2026-09-10 11:00:00', '2026-09-07 05:55:30'),
(23, 'NCR-2026-0011', 'step2_submitted', 2, '2026-09-11', 'علیرضا موسوی', 'کارشناس فنی', 'مهندسی', 'حین تولید', NULL, NULL, NULL, NULL, NULL, NULL, 'اتوبوس', NULL, NULL, NULL, NULL, NULL, 'B-0012-99', 'سیستم تعلیق اتوبوس 44 نفره', 8, 'عدد', 'سایش غیرعادی در فنرهای سیستم تعلیق در اتوبوس 44 نفره', NULL, NULL, 'توقف تولید', 'عمده', NULL, '5why', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'کیفیت نامناسب فنرهای تأمین‌شده و خطا در تنظیمات سیستم تعلیق', NULL, NULL, 'yes', NULL, 'rework', 'احمد نعمتی', '2026-09-25', 'CA-2026-078', NULL, NULL, NULL, NULL, 'yes', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 1, 0, 0, 1, 1, 0, 0, NULL, NULL, NULL, NULL, 'علیرضا موسوی', '2026-09-11 08:00:00', '2026-09-07 05:55:30'),
(24, 'NCR-2026-0012', 'step2_submitted', 2, '2026-09-12', 'مهدی کاظمی', 'کارشناس کیفیت', 'کنترل کیفیت', 'محصول نهایی', NULL, NULL, NULL, NULL, NULL, NULL, 'کشنده', NULL, NULL, NULL, NULL, NULL, 'TR-0013-45', 'گیربکس کشنده ایویکو', 3, 'عدد', 'صدای غیرعادی در گیربکس کشنده ایویکو در تست نهایی', NULL, NULL, 'قرنطینه', 'عمده', NULL, 'fishbone', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'خطا در فرآیند مونتاژ و تنظیمات گیربکس در کارخانه', NULL, NULL, 'yes', NULL, 'concession', NULL, NULL, NULL, 'CON-2026-003', NULL, NULL, NULL, 'no', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 1, 0, 0, 1, 1, 0, 0, NULL, NULL, NULL, NULL, 'مهدی کاظمی', '2026-09-12 14:00:00', '2026-09-07 05:55:30');

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
  `is_read` tinyint(1) DEFAULT 0,
  `created_at` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `notifications`
--

INSERT INTO `notifications` (`id`, `user_id`, `title`, `message`, `type`, `link`, `is_read`, `created_at`) VALUES
(1, 1, 'NCR ???? ??? ??', 'NCR-2026-0001 ???? ???? ????? ??? ??', 'info', 'ncr-detail.html?number=NCR-2026-0001', 0, '2026-08-01 10:30:00'),
(2, 2, '????? ????? ???? ????', 'NCR-2026-0002 ???? ?? ????? ????? ????', 'warning', 'ncr-detail.html?number=NCR-2026-0002', 0, '2026-08-05 14:15:00'),
(3, 3, '???? ???? ??', '???? CLM-2026-0001 ???? ???? ??????? ???? ??', 'success', 'claim-form.html?number=CLM-2026-0001', 0, '2026-08-06 11:20:00'),
(4, 1, '????? ??? ????? ????', '????? SH-2026-0001 ???? ???? ??????? ??? ??', 'danger', 'shortage-form.html?number=SH-2026-0001', 0, '2026-08-03 13:45:00');

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
  `claim_number` varchar(50) DEFAULT NULL,
  `documents` mediumtext DEFAULT NULL,
  `supervisor_status` varchar(20) DEFAULT 'pending',
  `supervisor_approved_date` date DEFAULT NULL,
  `supervisor_notes` mediumtext DEFAULT NULL,
  `finance_status` varchar(20) DEFAULT 'pending',
  `finance_approved_date` date DEFAULT NULL,
  `finance_notes` mediumtext DEFAULT NULL,
  `procurement_status` varchar(20) DEFAULT 'pending',
  `procurement_notes` mediumtext DEFAULT NULL,
  `po_number` varchar(50) DEFAULT NULL,
  `supplier_name` varchar(100) DEFAULT NULL,
  `order_date` date DEFAULT NULL,
  `final_status` varchar(20) DEFAULT 'pending',
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `purchase_requests`
--

INSERT INTO `purchase_requests` (`id`, `pr_number`, `request_date`, `requester_name`, `requester_department`, `part_code`, `part_name`, `quantity`, `unit`, `urgency`, `required_date`, `budget_estimate`, `reason`, `ncr_number`, `claim_number`, `documents`, `supervisor_status`, `supervisor_approved_date`, `supervisor_notes`, `finance_status`, `finance_approved_date`, `finance_notes`, `procurement_status`, `procurement_notes`, `po_number`, `supplier_name`, `order_date`, `final_status`, `created_at`, `updated_at`) VALUES
(1, 'PR-2026-0001', '2026-08-08', '??? ?????', '?????', 'PM-2056', '???? ???????? ??? A', 200, '???', 'high', '2026-08-30', '15000000.00', '????? ???? ?? ???? ??? ?????? ? ??????', 'NCR-2026-0002', NULL, NULL, 'approved', '2026-08-09', '????? ??????.', 'approved', '2026-08-10', '????? ????? ??.', 'in_progress', NULL, 'PO-2026-0045', '??????????? ????? ??????? ????', '2026-08-12', 'in_progress', '2026-08-26 03:09:52', '2026-08-26 03:09:52');

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
  `part_image` varchar(255) DEFAULT NULL,
  `batch_number` varchar(50) DEFAULT NULL,
  `requested_qty` int(11) DEFAULT 0,
  `sent_qty` int(11) DEFAULT 0,
  `shortage_qty` int(11) DEFAULT 0,
  `unit` varchar(20) DEFAULT 'pcs',
  `documents` mediumtext DEFAULT NULL,
  `description` mediumtext DEFAULT NULL,
  `ceo_status` varchar(20) DEFAULT 'pending',
  `ceo_approved_date` date DEFAULT NULL,
  `ceo_notes` mediumtext DEFAULT NULL,
  `supplier_status` varchar(20) DEFAULT 'pending',
  `supplier_response_date` date DEFAULT NULL,
  `supplier_approved` tinyint(1) DEFAULT 0,
  `supplier_replacement_date` date DEFAULT NULL,
  `supplier_cost_amount` decimal(15,2) DEFAULT 0.00,
  `supplier_notes` mediumtext DEFAULT NULL,
  `corrective_action_number` varchar(50) DEFAULT NULL,
  `action_result` mediumtext DEFAULT NULL,
  `warehouse_status` varchar(20) DEFAULT 'pending',
  `replacement_received_date` date DEFAULT NULL,
  `replacement_quantity` int(11) DEFAULT 0,
  `warehouse_notes` mediumtext DEFAULT NULL,
  `final_status` varchar(20) DEFAULT 'open',
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `shortages`
--

INSERT INTO `shortages` (`id`, `shortage_number`, `report_date`, `reporter_name`, `reporter_department`, `subject`, `part_code`, `part_name`, `part_image`, `batch_number`, `requested_qty`, `sent_qty`, `shortage_qty`, `unit`, `documents`, `description`, `ceo_status`, `ceo_approved_date`, `ceo_notes`, `supplier_status`, `supplier_response_date`, `supplier_approved`, `supplier_replacement_date`, `supplier_cost_amount`, `supplier_notes`, `corrective_action_number`, `action_result`, `warehouse_status`, `replacement_received_date`, `replacement_quantity`, `warehouse_notes`, `final_status`, `created_at`, `updated_at`) VALUES
(1, 'SH-2026-0001', '2026-08-03', '???? ?????', '?????', '??? ?????? 2 ??? ???????', 'PM-1024', '??????? SKF 6205', NULL, NULL, 50, 48, 2, '???', NULL, '?? ?????? ??????? 2 ??? ??????? ???? ?????.', 'approved', '2026-08-04', '????? ??? ????? ????.', 'approved', '2026-08-05', 1, '2026-08-15', '0.00', '???? ??????? ????? ??????.', 'CA-2026-0001', '??????????? ????? ???.', 'pending', NULL, 0, NULL, 'in_progress', '2026-08-26 03:09:52', '2026-08-26 03:09:52');

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
(1, 'language', 'fa', '2026-08-26 03:09:52'),
(2, 'timezone', 'Asia/Tehran', '2026-08-26 03:09:52'),
(3, 'date_format', 'fa', '2026-08-26 03:09:52'),
(4, 'theme', 'light', '2026-08-26 03:09:52'),
(5, 'ncr_auto_numbering', 'yearly', '2026-08-26 03:09:52'),
(6, 'default_priority', 'medium', '2026-08-26 03:09:52'),
(7, 'default_due_date', '30', '2026-08-26 03:09:52');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
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

INSERT INTO `users` (`id`, `username`, `password`, `full_name`, `email`, `role`, `department`, `avatar`, `language`, `created_at`, `last_login`) VALUES
(1, 'admin', 'admin123', 'محمد پورسان', 'admin@ncr-system.com', 'admin', '??????', NULL, 'fa', '2026-08-26 03:09:52', '2026-09-11 05:50:12'),
(2, 'quality', 'quality123', '??? ?????', 'quality@ncr-system.com', 'quality', '????? ?????', NULL, 'fa', '2026-08-26 03:09:52', '2026-09-11 06:37:14'),
(3, 'production', 'prod123', '???? ?????', 'production@ncr-system.com', 'production', '?????', NULL, 'fa', '2026-08-26 03:09:52', NULL),
(4, 'purchasing', 'purch123', '???? ?????', 'purchasing@ncr-system.com', 'purchasing', '????', NULL, 'fa', '2026-08-26 03:09:52', NULL),
(5, 'warehouse', 'ware123', '???? ?????', 'warehouse@ncr-system.com', 'warehouse', '?????', NULL, 'fa', '2026-08-26 03:09:52', NULL),
(6, 'engineering', 'eng123', '???? ?????', 'engineering@ncr-system.com', 'engineering', '??????', NULL, 'fa', '2026-08-26 03:09:52', NULL),
(7, 'ceo', 'ceo123', '????????', 'ceo@ncr-system.com', 'ceo', '??????', NULL, 'fa', '2026-08-26 03:09:52', NULL);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `claims`
--
ALTER TABLE `claims`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `claim_number` (`claim_number`),
  ADD KEY `idx_claim_number` (`claim_number`),
  ADD KEY `idx_ncr_number` (`ncr_number`);

--
-- Indexes for table `ncrs`
--
ALTER TABLE `ncrs`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `ncr_number` (`ncr_number`);

--
-- Indexes for table `notifications`
--
ALTER TABLE `notifications`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_user_read` (`user_id`,`is_read`);

--
-- Indexes for table `purchase_requests`
--
ALTER TABLE `purchase_requests`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `pr_number` (`pr_number`),
  ADD KEY `idx_pr_number` (`pr_number`);

--
-- Indexes for table `shortages`
--
ALTER TABLE `shortages`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `shortage_number` (`shortage_number`),
  ADD KEY `idx_shortage_number` (`shortage_number`);

--
-- Indexes for table `system_settings`
--
ALTER TABLE `system_settings`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `setting_key` (`setting_key`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `claims`
--
ALTER TABLE `claims`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `ncrs`
--
ALTER TABLE `ncrs`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;

--
-- AUTO_INCREMENT for table `notifications`
--
ALTER TABLE `notifications`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `purchase_requests`
--
ALTER TABLE `purchase_requests`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `shortages`
--
ALTER TABLE `shortages`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `system_settings`
--
ALTER TABLE `system_settings`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
