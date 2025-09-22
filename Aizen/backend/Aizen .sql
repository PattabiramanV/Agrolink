-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Sep 22, 2025 at 02:41 PM
-- Server version: 10.6.22-MariaDB-0ubuntu0.22.04.1
-- PHP Version: 8.1.33

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `Aizen`
--

-- --------------------------------------------------------

--
-- Table structure for table `cart`
--

CREATE TABLE `cart` (
  `id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `cart`
--

INSERT INTO `cart` (`id`, `user_id`, `created_at`, `updated_at`) VALUES
(1, 1, '2024-07-25 07:18:07', '2024-07-25 07:18:07'),
(2, 2, '2024-07-25 07:25:26', '2024-07-25 07:25:26'),
(3, 3, '2024-07-25 08:19:24', '2024-07-25 08:19:24'),
(4, 6, '2025-09-20 07:57:29', '2025-09-20 07:57:29'),
(5, 7, '2025-09-21 10:09:12', '2025-09-21 10:09:12'),
(6, 8, '2025-09-22 06:08:51', '2025-09-22 06:08:51'),
(7, 9, '2025-09-22 07:10:13', '2025-09-22 07:10:13');

-- --------------------------------------------------------

--
-- Table structure for table `cart_item`
--

CREATE TABLE `cart_item` (
  `cart_item_id` int(11) NOT NULL,
  `cart_id` int(11) DEFAULT NULL,
  `product_id` int(11) DEFAULT NULL,
  `quantity` int(11) DEFAULT NULL,
  `price` decimal(10,2) DEFAULT NULL,
  `strikeout_price` decimal(10,2) DEFAULT NULL,
  `total` decimal(10,2) DEFAULT NULL,
  `added_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `categories`
--

CREATE TABLE `categories` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `description` text DEFAULT NULL,
  `image` varchar(255) DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `is_popular` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `categories`
--

INSERT INTO `categories` (`id`, `name`, `description`, `image`, `is_active`, `is_popular`, `created_at`, `updated_at`) VALUES
(1, 'Fruits', NULL, 'fruits.jpeg', 1, 0, '2024-07-24 05:39:08', '2025-09-20 05:52:28'),
(2, 'Vegetables', NULL, 'vegetables.jpeg', 1, 0, '2024-07-24 05:39:16', '2025-09-20 05:51:28'),
(3, 'Spices', NULL, 'spices.jpeg', 1, 0, '2024-07-24 06:00:58', '2025-09-20 05:52:55'),
(4, 'Dry Fruits', NULL, 'dryfruits.jpg', 1, 0, '2024-07-25 10:48:47', '2025-09-20 05:53:12');

-- --------------------------------------------------------

--
-- Table structure for table `cities`
--

CREATE TABLE `cities` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `state_id` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `cities`
--

INSERT INTO `cities` (`id`, `name`, `state_id`, `created_at`, `updated_at`) VALUES
(1, 'Chennai ', 1, '2024-07-24 05:38:42', '2024-07-24 05:38:42');

-- --------------------------------------------------------

--
-- Table structure for table `countries`
--

CREATE TABLE `countries` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `countries`
--

INSERT INTO `countries` (`id`, `name`, `created_at`, `updated_at`) VALUES
(1, 'India', '2024-07-24 05:37:25', '2024-07-24 05:37:25'),
(2, 'China', '2024-07-25 10:15:34', '2024-07-25 10:15:34');

-- --------------------------------------------------------

--
-- Table structure for table `orders`
--

CREATE TABLE `orders` (
  `id` int(11) NOT NULL,
  `shipping_name` varchar(255) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `house_detail` varchar(255) NOT NULL,
  `area_town` varchar(255) NOT NULL,
  `zipcode` varchar(20) NOT NULL,
  `phone_no` varchar(20) NOT NULL,
  `country_id` int(11) DEFAULT NULL,
  `state_id` int(11) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `total` decimal(10,2) NOT NULL DEFAULT 0.00,
  `payment_method` varchar(50) NOT NULL,
  `status` varchar(50) NOT NULL DEFAULT 'pending'
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `orders`
--

INSERT INTO `orders` (`id`, `shipping_name`, `user_id`, `house_detail`, `area_town`, `zipcode`, `phone_no`, `country_id`, `state_id`, `created_at`, `updated_at`, `total`, `payment_method`, `status`) VALUES
(1, 'Carl Arnold', NULL, 'Odit sint ea ut cons', 'Recusandae Enim inc', '86938', '37', 1, 1, '2024-07-25 04:25:30', '2024-07-25 04:25:30', 0.00, '', 'pending'),
(2, 'Dean Blanchard', NULL, 'Ea explicabo Omnis ', 'Illum corrupti ius', '84575', '84', 1, 1, '2024-07-25 04:39:22', '2024-07-25 04:39:22', 0.00, '', 'pending'),
(3, 'Mohammad Woodward', NULL, 'Qui rem cum ullam pr', 'Quae incididunt quis', '80060', '2', 1, 1, '2024-07-25 04:42:55', '2024-07-25 04:42:55', 0.00, '', 'pending'),
(4, 'Zena Terry', NULL, 'In optio in et poss', 'Ab eu laborum velit ', '15676', '9', 1, 1, '2024-07-25 04:47:08', '2024-07-25 04:47:08', 0.00, '', 'pending'),
(5, 'Magee Sullivan', NULL, 'Minima est aspernatu', 'Error tempore et re', '26668', '4', 1, 1, '2024-07-25 04:47:44', '2024-07-25 04:47:44', 0.00, '', 'pending'),
(6, 'Magee Sullivan', NULL, 'Minima est aspernatu', 'Error tempore et re', '26668', '4', 1, 1, '2024-07-25 04:48:44', '2024-07-25 04:48:44', 0.00, '', 'pending'),
(7, 'Scarlet Higgins', NULL, 'Nostrum et voluptate', 'Exercitation dolor e', '44387', '88', 1, 1, '2024-07-25 05:59:42', '2024-07-25 05:59:42', 0.00, '', 'pending'),
(8, 'Raya Knox', NULL, 'Eum consequuntur adi', 'Dolor aut est simili', '60122', '12345', 1, 1, '2024-07-25 06:15:20', '2024-07-25 06:15:20', 0.00, '', 'pending'),
(9, 'Naomi Weaver', NULL, 'Debitis voluptas occ', 'Ullamco enim iure re', '58441', '134567', 1, 1, '2024-07-25 06:38:42', '2024-07-25 06:38:42', 0.00, '', 'pending'),
(10, 'Ezekiel Cruz', NULL, 'Omnis dignissimos au', 'Est recusandae Aliq', '78217', '1234', 1, 1, '2024-07-25 06:46:41', '2024-07-25 06:46:41', 0.00, '', 'pending'),
(11, 'Kasper Lambert', NULL, 'Excepturi in magnam ', 'Animi laborum expli', '45120', '12345', 1, 1, '2024-07-25 06:47:57', '2024-07-25 06:47:57', 0.00, '', 'pending'),
(12, 'Vanna Guerra', NULL, 'Maiores quibusdam nu', 'Laborum libero eu ni', '67815', '1234', 1, 1, '2024-07-25 06:49:29', '2024-07-25 06:49:29', 0.00, '', 'pending'),
(13, 'Vanna Guerra', NULL, 'Maiores quibusdam nu', 'Laborum libero eu ni', '67815', '1234', 1, 1, '2024-07-25 06:51:56', '2024-07-25 06:51:56', 0.00, '', 'pending'),
(14, 'Chava Knowles', NULL, 'Magni aut unde dolor', 'Earum ut iusto moles', '35172', '1234', 1, 1, '2024-07-25 06:52:22', '2024-07-25 06:52:22', 0.00, '', 'pending'),
(15, 'Edward Stephens', NULL, 'Debitis est omnis am', 'Fugit voluptate sol', '52526', '1345', 1, 1, '2024-07-25 07:07:39', '2024-07-25 07:07:39', 0.00, '', 'pending'),
(16, 'Noelani Fuller', NULL, 'Eius voluptatibus ve', 'Sed ea obcaecati exc', '99861', '1209876543', 1, 1, '2024-07-25 08:13:35', '2024-07-25 08:13:35', 0.00, '', 'pending'),
(17, 'Nell Glass', NULL, 'Culpa aut aut ut od', 'Voluptatem amet ten', '83063', '765432', 1, 1, '2024-07-25 08:15:09', '2024-07-25 08:15:09', 0.00, '', 'pending'),
(18, 'Nero Lara', NULL, 'Qui ab dolorem cillu', 'Sed minima irure aut', '72772', '12345', 1, 1, '2024-07-25 08:27:05', '2024-07-25 08:27:05', 0.00, '', 'pending'),
(19, 'Nero Lara', NULL, 'Qui ab dolorem cillu', 'Sed minima irure aut', '72772', '12345', 1, 1, '2024-07-25 08:27:07', '2024-07-25 08:27:07', 0.00, '', 'pending'),
(20, 'Nero Lara', NULL, 'Qui ab dolorem cillu', 'Sed minima irure aut', '72772', '12345', 1, 1, '2024-07-25 08:27:08', '2024-07-25 08:27:08', 0.00, '', 'pending'),
(21, 'Nero Lara', NULL, 'Qui ab dolorem cillu', 'Sed minima irure aut', '72772', '12345', 1, 1, '2024-07-25 08:27:08', '2024-07-25 08:27:08', 0.00, '', 'pending'),
(22, 'Nero Lara', NULL, 'Qui ab dolorem cillu', 'Sed minima irure aut', '72772', '12345', 1, 1, '2024-07-25 08:27:08', '2024-07-25 08:27:08', 0.00, '', 'pending'),
(23, 'Nero Lara', NULL, 'Qui ab dolorem cillu', 'Sed minima irure aut', '72772', '12345', 1, 1, '2024-07-25 08:27:08', '2024-07-25 08:27:08', 0.00, '', 'pending'),
(24, 'Nero Lara', NULL, 'Qui ab dolorem cillu', 'Sed minima irure aut', '72772', '12345', 1, 1, '2024-07-25 08:27:09', '2024-07-25 08:27:09', 0.00, '', 'pending'),
(25, 'Nero Lara', NULL, 'Qui ab dolorem cillu', 'Sed minima irure aut', '72772', '12345', 1, 1, '2024-07-25 08:27:09', '2024-07-25 08:27:09', 0.00, '', 'pending'),
(26, 'Nero Lara', NULL, 'Qui ab dolorem cillu', 'Sed minima irure aut', '72772', '12345', 1, 1, '2024-07-25 08:27:09', '2024-07-25 08:27:09', 0.00, '', 'pending'),
(27, 'Nero Lara', NULL, 'Qui ab dolorem cillu', 'Sed minima irure aut', '72772', '12345', 1, 1, '2024-07-25 08:27:09', '2024-07-25 08:27:09', 0.00, '', 'pending'),
(28, 'Nero Lara', NULL, 'Qui ab dolorem cillu', 'Sed minima irure aut', '72772', '12345', 1, 1, '2024-07-25 08:27:09', '2024-07-25 08:27:09', 0.00, '', 'pending'),
(29, 'Keane Atkins', NULL, 'Velit voluptate dolo', 'Doloremque recusanda', '64538', '1234', 1, 1, '2024-07-25 08:31:10', '2024-07-25 08:31:10', 0.00, '', 'pending'),
(31, 'Rae Chavez', NULL, 'Ut ea reprehenderit', 'Similique delectus ', '17968', '1234567', 1, 1, '2024-07-25 08:44:45', '2024-07-25 08:44:45', 0.00, '', 'pending'),
(32, 'Rae Chavez', NULL, 'Ut ea reprehenderit', 'Similique delectus ', '17968', '1234567', 1, 1, '2024-07-25 08:47:01', '2024-07-25 08:47:01', 0.00, '', 'pending'),
(33, 'Rae Chavez', NULL, 'Ut ea reprehenderit', 'Similique delectus ', '17968', '1234567', 1, 1, '2024-07-25 08:49:15', '2024-07-25 08:49:15', 0.00, '', 'pending'),
(34, 'Rae Chavez', NULL, 'Ut ea reprehenderit', 'Similique delectus ', '17968', '1234567', 1, 1, '2024-07-25 08:50:50', '2024-07-25 08:50:50', 0.00, '', 'pending'),
(35, 'Rae Chavez', NULL, 'Ut ea reprehenderit', 'Similique delectus ', '17968', '1234567', 1, 1, '2024-07-25 08:50:52', '2024-07-25 08:50:52', 0.00, '', 'pending'),
(36, 'Rae Chavez', NULL, 'Ut ea reprehenderit', 'Similique delectus ', '17968', '1234567', 1, 1, '2024-07-25 08:51:13', '2024-07-25 08:51:13', 0.00, '', 'pending'),
(37, 'Rae Chavez', NULL, 'Ut ea reprehenderit', 'Similique delectus ', '17968', '1234567', 1, 1, '2024-07-25 08:51:38', '2024-07-25 08:51:38', 0.00, '', 'pending'),
(38, 'Rae Chavez', NULL, 'Ut ea reprehenderit', 'Similique delectus ', '17968', '1234567', 1, 1, '2024-07-25 08:52:03', '2024-07-25 08:52:03', 0.00, '', 'pending'),
(39, 'Rae Chavez', NULL, 'Ut ea reprehenderit', 'Similique delectus ', '17968', '1234567', 1, 1, '2024-07-25 08:54:02', '2024-07-25 08:54:02', 0.00, '', 'pending'),
(40, 'Rae Chavez', NULL, 'Ut ea reprehenderit', 'Similique delectus ', '17968', '1234567', 1, 1, '2024-07-25 08:55:06', '2024-07-25 08:55:06', 0.00, '', 'pending'),
(41, 'Rae Chavez', NULL, 'Ut ea reprehenderit', 'Similique delectus ', '17968', '1234567', 1, 1, '2024-07-25 08:55:14', '2024-07-25 08:55:14', 0.00, '', 'pending'),
(42, 'Rae Chavez', NULL, 'Ut ea reprehenderit', 'Similique delectus ', '17968', '1234567', 1, 1, '2024-07-25 08:55:15', '2024-07-25 08:55:15', 0.00, '', 'pending'),
(43, 'Rae Chavez', NULL, 'Ut ea reprehenderit', 'Similique delectus ', '17968', '1234567', 1, 1, '2024-07-25 08:56:53', '2024-07-25 08:56:53', 0.00, '', 'pending'),
(44, 'Rae Chavez', NULL, 'Ut ea reprehenderit', 'Similique delectus ', '17968', '1234567', 1, 1, '2024-07-25 08:57:20', '2024-07-25 08:57:20', 0.00, '', 'pending'),
(45, 'Rae Chavez', NULL, 'Ut ea reprehenderit', 'Similique delectus ', '17968', '1234567', 1, 1, '2024-07-25 08:57:24', '2024-07-25 08:57:24', 0.00, '', 'pending'),
(46, 'Rae Chavez', NULL, 'Ut ea reprehenderit', 'Similique delectus ', '17968', '1234567', 1, 1, '2024-07-25 08:57:25', '2024-07-25 08:57:25', 0.00, '', 'pending'),
(47, 'Rae Chavez', NULL, 'Ut ea reprehenderit', 'Similique delectus ', '17968', '1234567', 1, 1, '2024-07-25 08:57:25', '2024-07-25 08:57:25', 0.00, '', 'pending'),
(48, 'Rae Chavez', NULL, 'Ut ea reprehenderit', 'Similique delectus ', '17968', '1234567', 1, 1, '2024-07-25 09:00:50', '2024-07-25 09:00:50', 0.00, '', 'pending'),
(49, 'Rae Chavez', NULL, 'Ut ea reprehenderit', 'Similique delectus ', '17968', '1234567', 1, 1, '2024-07-25 09:01:16', '2024-07-25 09:01:16', 0.00, '', 'pending'),
(50, 'Rae Chavez', NULL, 'Ut ea reprehenderit', 'Similique delectus ', '17968', '1234567', 1, 1, '2024-07-25 09:02:50', '2024-07-25 09:02:50', 0.00, '', 'pending'),
(51, 'Rae Chavez', NULL, 'Ut ea reprehenderit', 'Similique delectus ', '17968', '1234567', 1, 1, '2024-07-25 09:04:53', '2024-07-25 09:04:53', 0.00, '', 'pending'),
(52, 'Rae Chavez', NULL, 'Ut ea reprehenderit', 'Similique delectus ', '17968', '1234567', 1, 1, '2024-07-25 09:08:05', '2024-07-25 09:08:05', 0.00, '', 'pending'),
(53, 'Rae Chavez', NULL, 'Ut ea reprehenderit', 'Similique delectus ', '17968', '1234567', 1, 1, '2024-07-25 09:08:26', '2024-07-25 09:08:26', 0.00, '', 'pending'),
(54, 'Steven Finch', NULL, 'Est ad eos consequun', 'Lorem dolorum aperia', '21237', '098765', 1, 1, '2024-07-25 09:13:54', '2024-07-25 09:13:54', 0.00, '', 'pending'),
(55, 'Amethyst Mills', NULL, 'Aut velit incididunt', 'Quia tenetur natus m', '36445', '+1 (234) 103-5795', 1, 1, '2024-07-25 09:15:06', '2024-07-25 09:15:06', 0.00, '', 'pending'),
(56, 'Scarlet Powell', 6, 'Corrupti ex occaeca', '1', '93281', '+1 (437) 942-6506', 1, 1, '2025-09-20 16:02:35', '2025-09-20 16:02:35', 61.00, 'cod', 'pending'),
(57, 'Scarlet Powell', 6, 'Corrupti ex occaeca', '1', '93281', '+1 (437) 942-6506', 1, 1, '2025-09-20 16:02:40', '2025-09-20 16:02:40', 61.00, 'cod', 'pending'),
(58, 'Scarlet Powell', 6, 'Corrupti ex occaeca', '1', '93281', '+1 (437) 942-6506', 1, 1, '2025-09-20 16:02:46', '2025-09-20 16:02:46', 61.00, 'cod', 'pending'),
(59, 'Scarlet Powell', 6, 'Corrupti ex occaeca', '1', '93281', '+1 (437) 942-6506', 1, 1, '2025-09-20 16:05:18', '2025-09-20 16:05:18', 61.00, 'cod', 'pending'),
(60, 'Scarlet Powell', 6, 'Corrupti ex occaeca', '1', '93281', '+1 (437) 942-6506', 1, 1, '2025-09-20 16:05:19', '2025-09-20 16:05:19', 61.00, 'cod', 'pending'),
(61, 'Scarlet Powell', 6, 'Corrupti ex occaeca', '1', '93281', '+1 (437) 942-6506', 1, 1, '2025-09-20 16:05:21', '2025-09-20 16:05:21', 61.00, 'cod', 'pending'),
(62, 'Scarlet Powell', 6, 'Corrupti ex occaeca', '1', '93281', '+1 (437) 942-6506', 1, 1, '2025-09-20 16:05:21', '2025-09-20 16:05:21', 61.00, 'cod', 'pending'),
(63, 'Scarlet Powell', 6, 'Corrupti ex occaeca', '1', '93281', '+1 (437) 942-6506', 1, 1, '2025-09-20 16:05:24', '2025-09-20 16:05:24', 61.00, 'cod', 'pending'),
(64, 'Scarlet Powell', 6, 'Corrupti ex occaeca', '1', '93281', '+1 (437) 942-6506', 1, 1, '2025-09-20 16:05:24', '2025-09-20 16:05:24', 61.00, 'cod', 'pending'),
(65, 'Scarlet Powell', 6, 'Corrupti ex occaeca', '1', '93281', '+1 (437) 942-6506', 1, 1, '2025-09-20 16:07:00', '2025-09-20 16:07:00', 61.00, 'cod', 'pending'),
(66, 'Lydia Velazquez', 6, 'Officia voluptatem ', '1', '34615', '+1 (122) 252-1728', 1, 1, '2025-09-20 16:12:29', '2025-09-20 16:12:29', 61.00, 'cod', 'pending'),
(67, 'Pattabi Raman V', 9, '1/25B, Middle street', '1', '607 107', '09361120513', 1, 1, '2025-09-22 07:11:06', '2025-09-22 07:11:06', 243.00, 'cod', 'pending'),
(68, 'Pattabiraman V', 9, '1/25B', '1', '607 107', '9361120512', 1, 1, '2025-09-22 07:35:45', '2025-09-22 07:35:45', 81.98, 'cod', 'pending');

-- --------------------------------------------------------

--
-- Table structure for table `order_items`
--

CREATE TABLE `order_items` (
  `id` int(11) NOT NULL,
  `order_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `quantity` int(11) NOT NULL,
  `price` decimal(10,2) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `order_items`
--

INSERT INTO `order_items` (`id`, `order_id`, `product_id`, `quantity`, `price`, `created_at`) VALUES
(1, 65, 27, 1, 61.00, '2025-09-20 16:07:00'),
(2, 66, 27, 1, 61.00, '2025-09-20 16:12:29'),
(3, 67, 12, 3, 81.00, '2025-09-22 07:11:06'),
(4, 68, 5, 2, 40.99, '2025-09-22 07:35:45');

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

CREATE TABLE `products` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `short_description` varchar(255) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `is_popular` tinyint(1) NOT NULL DEFAULT 0,
  `actual_price` decimal(10,2) NOT NULL,
  `selling_price` decimal(10,2) NOT NULL,
  `quantity` decimal(10,2) NOT NULL,
  `unit` varchar(50) NOT NULL,
  `category_id` int(11) NOT NULL,
  `subcategory_id` int(11) NOT NULL,
  `store_id` int(11) NOT NULL,
  `seller_id` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `images` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`id`, `name`, `short_description`, `description`, `is_active`, `is_popular`, `actual_price`, `selling_price`, `quantity`, `unit`, `category_id`, `subcategory_id`, `store_id`, `seller_id`, `created_at`, `updated_at`, `images`) VALUES
(2, 'Apple Pink Lady', 'An apple contains 4% of the recommended daily vitamin', 'An apple contains 4% of the recommended daily vitamin and mineral intake of Vitamin C. They slow down cell aging and reduce blood vessel permeability. Pink Lady apples contain 80% water. One of the fibers present in apples, pectin, increases the condition of gut flora.', 1, 0, 185.00, 156.00, 0.00, '2 pieces', 1, 1, 2, 2, '2024-07-24 00:59:17', '2025-09-22 06:08:27', 'plpApple.jpeg'),
(3, 'Apple Granny Smith', 'Green apples contain a compound called pectin', 'Green apples contain a compound called pectin, a fiber source that works as a prebiotic to promote the growth of healthy bacteria in your gut. The pectin found in green apples can help you break down foods more efficiently. The high fiber content in green apples can have other impacts on your digestive health as well.', 1, 0, 186.00, 157.00, 20.00, '2 pieces', 1, 1, 1, 2, '2024-07-24 01:03:25', '2024-07-24 01:03:25', 'plpGreenapple.jpeg'),
(5, 'Banana Poovan', ' Poovan bananas are luscious', 'Poovan bananas are luscious, creamy, flavourful, and versatile short and round bananas. Their lovely yellow colour is a quality indicator. Benefits: contains potassium, which is known to help avoid kidney stones and promote appropriate bone growth.', 1, 0, 68.00, 40.99, 20.00, '500 g', 1, 3, 1, 1, '2024-07-24 04:51:44', '2024-07-24 04:51:44', 'plpBanana.jpeg'),
(6, 'Onion', 'Onions are high in nutrients', 'Onions are high in nutrients and have been linked to a variety of health benefits such as enhanced heart health, better blood sugar control, and greater bone density.', 1, 0, 75.00, 48.99, 30.00, '1 Kg', 2, 2, 1, 1, '2024-07-24 05:21:30', '2024-07-24 05:21:30', 'plpOnion.jpeg'),
(7, 'Sambar Onion (Chinna Vengayam)', 'Onions are high in nutrients', 'Onions are high in nutrients and have been linked to a variety of health benefits such as enhanced heart health, better blood sugar control, and greater bone density.', 1, 0, 52.00, 38.98, 20.00, '250 g', 2, 2, 1, 1, '2024-07-24 05:24:49', '2024-07-24 05:24:49', 'plpSmallonion.jpeg'),
(8, 'Tomato Hybrid', 'Tomatoes are the most abundant source of the antioxidant lycopene', 'Tomatoes are the most abundant source of the antioxidant lycopene, which has been linked to a variety of health advantages, including a lower risk of heart disease and cancer. Tomatoes are low in calories and high in nutrients such as vitamin C and potassium. They\'re also high in antioxidants, including lycopene, which gives tomatoes their distinctive color and has been linked to a variety of health advantages, including a lower risk of heart disease and certain cancers.', 1, 0, 122.00, 59.00, 9.99, '500 g', 2, 46, 1, 1, '2024-07-24 05:50:33', '2024-07-24 05:50:33', 'plpTomato.jpeg'),
(9, 'Tomato Country', 'The tomato is the edible berry of the Tomato plant.', 'The tomato is the edible berry of the Tomato plant. Contains vitamin C, K. Contains lycopene, an antioxidant that reduces the risk of cancer and heart-diseases. Can be consumed in diverse ways, raw or cooked, in many dishes, sauces, salads, and drinks. While tomatoes are fruits they are commonly used culinarily as a vegetable ingredient or side dish.', 1, 0, 103.00, 61.00, 40.00, '500 g', 2, 46, 1, 1, '2024-07-24 05:52:16', '2024-07-24 05:52:39', 'plpTomato.jpeg'),
(10, 'Papaya', 'Papayas contain high levels of antioxidants vitamin', 'Papayas contain high levels of antioxidants vitamin a, vitamin c, and vitamin e. Diets high in antioxidants may reduce the risk of heart disease. The antioxidants prevent the oxidation of cholesterol. When cholesterol oxidizes, itâ€™s more likely to create blockages that lead to heart disease.', 1, 0, 129.00, 84.00, 10.00, '1 pc (Approx. 750g - 1 kg)', 1, 31, 1, 1, '2024-07-24 05:56:50', '2024-07-24 05:56:50', 'plpPapaya.jpeg'),
(11, 'Mustard Seeds', 'Add a zesty flavor to your dishes with Daily Good Mustard/RaiSmall', 'Add a zesty flavor to your dishes with Daily Good Mustard/RaiSmall, premium quality mustard seeds prized for their unique taste and aroma. Whether used in pickles, relishes, or salad dressings, these versatile seeds add a distinctive flavor and a pleasant heat to a wide range of recipes. Packed with essential oils and antioxidants, Daily Good Mustard/RaiSmall is a flavorful and nutritious addition to any kitchen pantry. Experience the richness and versatility of mustard seeds with Daily Good Mustard/RaiSmall.', 1, 0, 40.00, 37.00, 7.00, '1 Packet (Approx 100g )', 3, 29, 1, 1, '2024-07-24 05:59:40', '2024-07-24 05:59:40', 'plpMustard.jpeg'),
(12, 'Grapes Red Globe Indian', 'Red globes grapes have the biggest round red berries of any red grape variety.', 'Red globes grapes have the biggest round red berries of any red grape variety. Red globes are well-known for their big berry size and long shelf life. Sweet and crisp, ideal for salads and fresh eating.', 1, 0, 125.00, 81.00, 10.00, '250 g', 1, 20, 1, 1, '2024-07-24 06:06:50', '2024-07-24 06:06:50', 'plpGrapes.jpeg'),
(13, 'Black Pepper', 'Popular Essentials Black Pepper', 'Popular Essentials Black Pepper - Enhance the flavor of your favorite dishes with Popular Essentials Black Pepper. Made from premium quality peppercorns, this versatile spice adds a bold and spicy kick to soups, stews, marinades, and more. Enjoy the distinctive aroma and taste of freshly ground black pepper.', 1, 0, 145.00, 114.00, 10.00, '100 g', 3, 33, 1, 1, '2024-07-24 22:59:41', '2024-07-24 22:59:41', 'plpPeper.jpeg'),
(14, 'Green Chilli', 'Green chilies are a frequent vegetable', 'Green chilies are a frequent vegetable used in Indian cuisine because of its fiery flavor. Green chilies are scientifically referred to as Capsicum frutescens. Green chilies get their spiciness from a substance called capsaicin.', 1, 0, 28.00, 20.00, 30.00, '100g', 3, 21, 1, 1, '2024-07-24 23:02:06', '2024-07-24 23:02:06', 'plpGreen Chili.jpeg'),
(15, 'Green Chilli Gundu', ' Green chilies are a frequent vegetable', 'Green chilies are a frequent vegetable used in Indian cuisine because of its fiery flavor. Green chilies are scientifically referred to as Capsicum frutescens. Green chilies get their spiciness from a substance called capsaicin.', 1, 0, 80.00, 50.00, 20.00, '200 g', 2, 21, 1, 1, '2024-07-24 23:04:10', '2024-07-24 23:05:15', 'plpGreenchilligundu.jpeg'),
(16, 'Mango Raw', 'Raw mango is high in acid, vitamins, and minerals', 'Raw mango is high in acid, vitamins, and minerals. These fruits are commonly used to make traditional items like as pickles, chutney, dried slices, powder, green mango beverage, and so on. The institute created a partially fermented low alcohol beverage from raw mango fruits.', 1, 0, 72.00, 47.00, 10.00, '1 pc (Approx. 150g - 250g)', 1, 27, 1, 1, '2024-07-24 23:10:21', '2024-07-24 23:10:21', 'plpMongoraw.jpeg'),
(17, 'Mango Neelam', 'This is a seasonal product with natural spots', ' This is a seasonal product with natural spots. The image is only for reference purpose. It aids in the battle against cancer, heart disease, and eye difficulties. Keeps you hydrated, quenches your thirst, and increases your energy and immunity.', 1, 0, 298.00, 195.00, 20.00, '3 pcs', 1, 27, 1, 1, '2024-07-24 23:11:40', '2024-07-24 23:11:40', 'plpMango.jpeg'),
(18, 'Aachi Turmeric Powder', 'Aachi Turmeric Powder/Haldi is a dazzling yellow spice ', 'Aachi Turmeric Powder/Haldi is a dazzling yellow spice powder that is prepared from dry Turmeric Rhizomes. It is useful for its color, cosmetic, flavor and medical properties. Curcumin is the main active ingredient in turmeric. It has powerful anti-inflammatory effects and is a very strong antioxidant. Linked to improved brain function and a Lowers risk of brain diseases. Very good for skin and provides natural remedy for sore throat, cough and cold.', 1, 0, 42.00, 35.00, 20.00, '100 g', 3, 48, 1, 1, '2024-07-24 23:18:29', '2024-07-24 23:18:29', 'Turmeric-Powder-and-Whole.jpeg'),
(19, 'Eastern Turmeric Powder', 'Turmeric (Curcumin longa) is known as golden spice.', 'Turmeric (Curcumin longa) is known as golden spice. it contains natural \'CURCUMIN\', the active ingredient in turmeric supplements, have Anti-inflammatory, Antioxidant, Antibacterial, Antiviral and Anti-parasitic activity.', 1, 0, 185.00, 157.00, 10.00, '500 g', 3, 48, 1, 1, '2024-07-24 23:21:52', '2024-07-24 23:21:52', 'turmeric.jpg'),
(20, 'Aachi Chilli Powder', 'Aachi Chilli Powder Chillies are extremely crucial for several world cuisine', 'Aachi Chilli Powder Chillies are extremely crucial for several world cuisine, especially Indian food where no dish is complete without a little sprinkle of chilli powder. Experience the hotness and deliciousness of South Indian Aachi Chilli Powder and treat your friends and family with a sumptuous taste. This chilli powder is made from handpicked chillies that provide a unique experience of aroma and taste.', 1, 0, 84.00, 65.00, 30.00, '200 g', 3, 21, 1, 1, '2024-07-24 23:25:05', '2024-07-24 23:25:05', 'red-chilli-powder.jpeg'),
(21, 'Aashirvaad Spices Green Chilli Powder', ' Aashirvaad ensures that only superior quality ingredients reach your kitchen', ' Aashirvaad ensures that only superior quality ingredients reach your kitchen, and Aashirvaad Chilli Powder stays true to that word. Aashirvaad Chilli Powder has been made with love in India using a 4-step advantage process to ensure that only a high-quality product reaches your kitchen. With no added flavours and colours, Aashirvaad Chilli Powder is so potent that even a tiny quantity enhances the colour and taste of the dish.', 1, 0, 50.00, 45.00, 40.00, '100g', 3, 21, 1, 1, '2024-07-24 23:28:11', '2024-07-24 23:28:11', 'green-chilli-powder.jpg'),
(22, 'Safe Harvest Red Chilli Long', 'Safe Harvest Red Chilli Safe Harvest is a nation-wide movement of farmers', 'Safe Harvest Red Chilli Safe Harvest is a nation-wide movement of farmers who believe in natural sustainable farming practices without depending on synthetic pesticides, By Choosing Safe Harvest, you choose healthy wholesome and delicious food for your family. Not just that you are helping maintain a healthy envirnoment while contributing to the lives of these farmers.', 1, 0, 85.00, 68.00, 40.00, '100 g', 3, 21, 1, 1, '2024-07-24 23:33:25', '2024-07-24 23:33:25', 'red-chilli-500x500.jpeg'),
(23, 'Coconut', 'Coconut is high in fibre and low in carbs', 'Coconut is high in fibre and low in carbs, so it helps control blood sugar levels in our bodies. Coconut meat and water contain numerous antioxidants that fight against factors causing cell damage. The antioxidant also reduces the risk of many diseases such as cancer.', 1, 0, 58.00, 42.00, 20.00, '1 pc (Approx. 450g - 600g)', 1, 14, 1, 1, '2024-07-25 00:43:43', '2024-07-25 00:43:43', 'plpCoconut.jpeg'),
(24, 'Watermelon', 'Can be eaten fresh', 'Can be eaten fresh- scoop them up with ice creams or in fruit salads.Spice up your watermelon with a tinge of mint leaves.', 1, 0, 111.00, 61.00, 20.00, '1 Piece (Apporx., 1.75 to 2.2KG)', 1, 47, 1, 1, '2024-07-25 00:50:33', '2024-07-25 00:50:33', 'plpWatermelon.jpeg'),
(25, 'Coconut Small', 'Can be eaten fresh', 'Can be eaten fresh- scoop them up with ice creams or in fruit salads.Spice up your watermelon with a tinge of mint leaves.', 1, 0, 92.00, 50.00, 20.00, '2 pcs', 1, 14, 1, 1, '2024-07-25 00:51:58', '2024-07-25 00:51:58', 'plpCoconut.jpeg'),
(26, 'Radish', 'Radishes are root vegetables that belong to the cruciferae or mustard family.', 'Radishes are root vegetables that belong to the Cruciferae or mustard family, which also includes broccoli, cauliflower, cabbage, and kale. Known for their distinctive peppery flavor and crisp texture, radishes are a versatile ingredient in many cuisines around the world.', 1, 0, 63.00, 42.00, 50.00, '500 g', 2, 37, 1, 1, '2024-07-25 01:02:38', '2024-07-25 01:02:38', 'plpRadish.jpeg'),
(27, 'Potato Agra', 'Potatoes are high in vitamin C', 'Potatoes are high in vitamin C, an antioxidant.Potassium, an electrolyte that helps our heart, muscles, and nervous system, is another important mineral in potatoes.The fiber, potassium, vitamin C, and vitamin B6 content of potatoes, together with their absence of cholesterol, all promote heart health. The fiber content of potatoes is high. Fiber reduces the total quantity of cholesterol in the blood, lowering the risk of heart disease.', 1, 0, 80.00, 61.00, 30.00, '1 kg', 2, 35, 1, 1, '2024-07-25 01:04:53', '2024-07-25 01:04:53', 'plpPotato.jpeg'),
(28, 'Sweet Potato', 'Sweet potato benefits both your eyes and your immune system', 'Sweet potato benefits both your eyes and your immune system, which is your body\'s protection against infections. It is also beneficial to your reproductive system as well as organs such as your heart and kidneys.', 1, 0, 94.00, 62.00, 40.00, '500 g', 2, 35, 1, 1, '2024-07-25 01:07:31', '2024-07-25 01:07:31', 'SweetPotato.jpeg'),
(29, 'Baby Potato', 'Potatoes are high in vitamin C, an antioxidant', 'Potatoes are high in vitamin C, an antioxidant.Potassium, an electrolyte that helps our heart, muscles, and nervous system, is another important mineral in potatoes.The fiber, potassium, vitamin C, and vitamin B6 content of potatoes, together with their absence of cholesterol, all promote heart health. The fiber content of potatoes is high. Fiber reduces the total quantity of cholesterol in the blood, lowering the risk of heart disease.', 1, 0, 74.00, 47.00, 25.00, '500 g', 2, 35, 1, 1, '2024-07-25 01:11:12', '2024-07-25 01:11:12', 'plpPotato.jpeg');

-- --------------------------------------------------------

--
-- Table structure for table `requests`
--

CREATE TABLE `requests` (
  `id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `request_details` text DEFAULT NULL,
  `status` tinyint(1) DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `roles`
--

CREATE TABLE `roles` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `roles`
--

INSERT INTO `roles` (`id`, `name`, `created_at`, `updated_at`) VALUES
(1, 'Admin', '2024-07-24 05:33:39', '2024-07-24 05:33:39'),
(2, 'Seller', '2024-07-24 05:33:39', '2024-07-24 05:33:39'),
(3, 'User', '2024-07-24 05:33:50', '2024-07-24 05:33:50');

-- --------------------------------------------------------

--
-- Table structure for table `states`
--

CREATE TABLE `states` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `country_id` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `states`
--

INSERT INTO `states` (`id`, `name`, `country_id`, `created_at`, `updated_at`) VALUES
(1, 'Tamil Nadu', 1, '2024-07-24 05:37:40', '2024-07-24 05:37:40'),
(3, 'Kerala', 1, '2024-07-26 10:51:52', '2024-07-26 10:51:52'),
(4, 'Maharastra', 1, '2024-07-26 11:19:36', '2024-07-26 11:19:36');

-- --------------------------------------------------------

--
-- Table structure for table `stores`
--

CREATE TABLE `stores` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `address_line1` varchar(255) NOT NULL,
  `address_line2` varchar(255) DEFAULT NULL,
  `address_line3` varchar(255) DEFAULT NULL,
  `city_id` int(11) NOT NULL,
  `state_id` int(11) NOT NULL,
  `pincode` varchar(10) NOT NULL,
  `country_id` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `stores`
--

INSERT INTO `stores` (`id`, `name`, `address_line1`, `address_line2`, `address_line3`, `city_id`, `state_id`, `pincode`, `country_id`, `created_at`, `updated_at`) VALUES
(1, 'Anna Nagar', 'L76A L Block, 21st Street', 'Anna Nagar', 'Anna Nagar East', 1, 1, '600102', 1, '2024-07-24 06:22:41', '2024-07-24 06:22:41'),
(2, 'Vandaloor', 'S1, Second floor, Daffodils apartment, Plot no 29, Vallalar 4th st,', 'Saraswathi Nagar, Otteri exten, Vandalur', '', 1, 1, '600048', 1, '2024-07-25 01:31:04', '2024-07-25 01:31:04'),
(3, 'Koyambed', 'S1, Second floor, Daffodils apartment, Plot no 29, Vallalar 4th st,', 'Saraswathi Nagar, Otteri exten, Vandalur', '', 1, 1, '600048', 1, '2024-07-25 10:42:39', '2024-07-25 10:42:39'),
(4, 'Anna Nagar', 'S1, Second floor, Daffodils apartment, Plot no 29, Vallalar 4th st,', 'Saraswathi Nagar, Otteri exten, Vandalur', '', 1, 1, '600048', 1, '2024-07-26 11:02:19', '2024-07-26 11:02:19'),
(5, 'Vilupuram', 'S1, Second floor, Daffodils apartment, Plot no 29, Vallalar 4th st,', 'Saraswathi Nagar, Otteri exten, Vandalur', 'Dignissimos quae sit', 1, 1, '600048', 1, '2024-07-26 11:20:41', '2025-09-22 06:13:18');

-- --------------------------------------------------------

--
-- Table structure for table `subcategories`
--

CREATE TABLE `subcategories` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `description` text DEFAULT NULL,
  `category_id` int(11) NOT NULL,
  `images` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`images`)),
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `is_popular` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `subcategories`
--

INSERT INTO `subcategories` (`id`, `name`, `description`, `category_id`, `images`, `is_active`, `is_popular`, `created_at`, `updated_at`) VALUES
(1, 'Apple', NULL, 1, NULL, 1, 0, '2024-07-24 05:39:55', '2024-07-24 05:39:55'),
(2, 'Onion', NULL, 2, NULL, 1, 0, '2024-07-24 05:51:40', '2024-07-24 05:51:40'),
(3, 'Banana', NULL, 1, NULL, 1, 0, '2024-07-24 05:51:47', '2024-07-24 05:51:47'),
(4, 'Avocoda', NULL, 1, NULL, 1, 0, '2024-07-24 05:52:13', '2024-07-24 05:52:13'),
(5, 'Beetroot', NULL, 2, NULL, 1, 0, '2024-07-24 05:52:35', '2024-07-24 05:52:35'),
(6, 'Bitterguard', NULL, 2, NULL, 1, 0, '2024-07-24 05:52:58', '2024-07-24 05:52:58'),
(7, 'Blueberry', NULL, 1, NULL, 1, 0, '2024-07-24 05:53:24', '2024-07-24 05:53:24'),
(8, 'Bottleguard', NULL, 2, NULL, 1, 0, '2024-07-24 05:53:59', '2024-07-24 05:53:59'),
(9, 'Broccoli', NULL, 2, NULL, 1, 0, '2024-07-24 05:54:31', '2024-07-24 05:54:31'),
(10, 'Cabbage', NULL, 2, NULL, 1, 0, '2024-07-24 05:55:10', '2024-07-24 05:55:10'),
(11, 'Califlower', NULL, 2, NULL, 1, 0, '2024-07-24 05:55:27', '2024-07-24 05:55:27'),
(12, 'Capsicum', NULL, 2, NULL, 1, 0, '2024-07-24 05:55:41', '2024-07-24 05:55:41'),
(13, 'Carrot', NULL, 2, NULL, 1, 0, '2024-07-24 05:55:50', '2024-07-24 05:55:50'),
(14, 'Coconut', NULL, 1, NULL, 1, 0, '2024-07-24 05:56:58', '2024-07-24 05:56:58'),
(15, 'Coriander', NULL, 2, NULL, 1, 0, '2024-07-24 05:57:17', '2024-07-24 05:57:17'),
(16, 'Cucumber', NULL, 2, NULL, 1, 0, '2024-07-24 05:57:30', '2024-07-24 05:57:30'),
(17, 'Curryleaves', NULL, 2, NULL, 1, 0, '2024-07-24 05:57:47', '2024-07-24 05:57:47'),
(18, 'Dragonfruit', NULL, 1, NULL, 1, 0, '2024-07-24 05:58:03', '2024-07-24 05:58:20'),
(19, 'Ginger', NULL, 3, NULL, 1, 0, '2024-07-24 06:01:16', '2024-07-24 06:01:16'),
(20, 'Grapes', NULL, 1, NULL, 1, 0, '2024-07-24 06:01:28', '2024-07-24 06:01:28'),
(21, 'Chilli', NULL, 2, NULL, 1, 0, '2024-07-24 06:02:26', '2024-07-25 08:34:03'),
(22, 'Guava', NULL, 1, NULL, 1, 0, '2024-07-24 06:03:01', '2024-07-24 06:03:01'),
(23, 'Kiwifruit', NULL, 1, NULL, 1, 0, '2024-07-24 06:03:18', '2024-07-24 06:03:18'),
(24, 'Lemon', NULL, 1, NULL, 1, 0, '2024-07-24 06:03:33', '2024-07-24 06:03:33'),
(25, 'Lemongrass', NULL, 2, NULL, 1, 0, '2024-07-24 06:03:45', '2024-07-24 06:03:45'),
(26, 'Longan Fruit', NULL, 1, NULL, 1, 0, '2024-07-24 06:04:27', '2024-07-24 06:04:27'),
(27, 'Mango', NULL, 1, NULL, 1, 0, '2024-07-24 06:04:37', '2024-07-24 06:04:37'),
(28, 'Mint Leaves', NULL, 2, NULL, 1, 0, '2024-07-24 06:05:39', '2024-07-24 06:06:22'),
(29, 'Mustard Seeds', NULL, 3, NULL, 1, 0, '2024-07-24 06:07:18', '2024-07-24 06:07:18'),
(30, 'Orange', NULL, 1, NULL, 1, 0, '2024-07-24 06:08:04', '2024-07-24 06:08:04'),
(31, 'Papaya', NULL, 1, NULL, 1, 0, '2024-07-24 06:08:12', '2024-07-24 06:08:12'),
(32, 'Pear Fruit', NULL, 1, NULL, 1, 0, '2024-07-24 06:08:30', '2024-07-24 06:08:30'),
(33, 'Pepper', NULL, 3, NULL, 1, 0, '2024-07-24 06:08:56', '2024-07-24 06:08:56'),
(34, 'Pomegranate', NULL, 1, NULL, 1, 0, '2024-07-24 06:09:52', '2024-07-24 06:09:52'),
(35, 'Potato', NULL, 2, NULL, 1, 0, '2024-07-24 06:10:07', '2024-07-24 06:10:07'),
(36, 'Pumpkin', NULL, 1, NULL, 1, 0, '2024-07-24 06:10:30', '2024-07-24 06:10:30'),
(37, 'Radish', NULL, 2, NULL, 1, 0, '2024-07-24 06:10:57', '2024-07-24 06:10:57'),
(38, 'Ridgeguard', NULL, 2, NULL, 1, 0, '2024-07-24 06:11:14', '2024-07-24 06:11:14'),
(39, 'Sapodilla', NULL, 1, NULL, 1, 0, '2024-07-24 06:12:53', '2024-07-24 06:12:53'),
(40, 'Snakeguard', NULL, 2, NULL, 1, 0, '2024-07-24 06:13:15', '2024-07-24 06:13:15'),
(41, 'Spinach', NULL, 2, NULL, 1, 0, '2024-07-24 06:13:27', '2024-07-24 06:13:27'),
(42, 'Spring Onion', NULL, 2, NULL, 1, 0, '2024-07-24 06:13:53', '2024-07-24 06:13:53'),
(43, 'Strawberry', NULL, 1, NULL, 1, 0, '2024-07-24 06:14:11', '2024-07-24 06:14:11'),
(44, 'Tendil', NULL, 2, NULL, 1, 0, '2024-07-24 06:14:28', '2024-07-24 06:14:28'),
(45, 'Thyme', NULL, 2, NULL, 1, 0, '2024-07-24 06:14:39', '2024-07-24 06:14:39'),
(46, 'Tomato', NULL, 2, NULL, 1, 0, '2024-07-24 06:14:50', '2024-07-24 06:14:50'),
(47, 'Watermelon', NULL, 1, NULL, 1, 0, '2024-07-24 06:15:05', '2024-07-24 06:15:05'),
(48, 'Turmeric', NULL, 3, NULL, 1, 0, '2024-07-25 08:35:06', '2024-07-25 08:35:06');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `password_hash` varchar(255) NOT NULL,
  `role_id` int(11) NOT NULL,
  `is_verified` tinyint(1) DEFAULT 0,
  `verified_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `google_id` varchar(255) DEFAULT NULL,
  `avatar` varchar(255) DEFAULT NULL,
  `address_line1` varchar(255) DEFAULT NULL,
  `address_line2` varchar(255) DEFAULT NULL,
  `address_line3` varchar(255) DEFAULT NULL,
  `city_id` int(11) DEFAULT NULL,
  `state_id` int(11) DEFAULT NULL,
  `country_id` int(11) DEFAULT NULL,
  `mobile_no` varchar(20) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `password_hash`, `role_id`, `is_verified`, `verified_at`, `google_id`, `avatar`, `address_line1`, `address_line2`, `address_line3`, `city_id`, `state_id`, `country_id`, `mobile_no`, `created_at`, `updated_at`) VALUES
(1, 'Aizen Admin', 'aizendckap@gmail.com', '$2y$10$6dY2LQEnefkQrTrW0.CrneMViYJMpoyq1nICiBx1yB262/lAQXzK6', 1, 1, '2024-07-24 05:41:33', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2024-07-24 05:40:56', '2024-07-24 05:41:33'),
(2, 'Aki Hirotaka', 'akilashwarranpdckap@gmail.com', '$2y$10$mebkpS2xkU3CVYHht7KHfOaturBvCpTO6oaeAuRlp4zwykkkMuw5y', 2, 1, '2024-07-24 05:43:25', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2024-07-24 05:43:03', '2024-07-24 05:43:25'),
(3, 'Dreamy Way', 'vigneshcdckap@gmail.com', '$2y$10$4e4o38KCL43k6eUx1wGAVeuMCuqN7wksSZ2viJeQfBqtB4.tptVCq', 3, 1, '2024-07-24 05:44:22', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2024-07-24 05:44:22', '2024-07-24 05:44:22'),
(4, 'akash', 'akashs@dckap.com', '$2y$10$PchhpDcQ/4anAdoCC.zfSu8yokAON8emsfD4dh9IG7Vy4mifvHtlq', 3, 1, '2024-07-25 11:50:08', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2024-07-25 11:50:08', '2024-07-25 11:50:08'),
(5, 'Daniel Todd', 'jyhuzub@mailinator.com', '$2y$10$pL4zckHhV447Ft6NvtiJtusoyVfvG7o2iUiaVz4RyS.G/Wh1fFy/K', 3, 1, '2025-09-20 07:07:23', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-09-20 07:07:23', '2025-09-20 07:07:23'),
(6, 'Pattabiraman Veeraragavan', 'pattabiramanv@gmail.com', '', 3, 1, '2025-09-21 10:41:27', '106143667783486917355', '6.JPG', NULL, NULL, NULL, NULL, NULL, NULL, '9361120513', '2025-09-20 07:07:57', '2025-09-21 10:41:27'),
(7, 'Pattabiraman V', 'pattabiramanv@dckap.com', '$2y$10$Ld1xUhp2a0Kmpuexwpl.aOcqe5G8/YBzxk2FAXEhPR/aKf63DbweC', 3, 1, '2025-09-21 10:02:13', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-09-21 10:02:13', '2025-09-21 10:02:13'),
(8, 'Pattabiraman V', 'pattabiramanvdckap@gmail.com', '$2y$10$KKFLEN3TkJvb8xY1zzGmEedEDMPzt.EoS3mEyUZ9Cx2Xx1Lhi5y0e', 1, 1, '2025-09-22 06:05:39', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-09-21 10:19:23', '2025-09-22 06:05:39'),
(9, 'Pattabi Raman V', 'pattabiramanveera@gmail.com', '$2y$10$CdFEpuQkRoPQVQyEB35tLubtnZrcfdNHUu8mLa2LnFWmQY4xqbQeC', 3, 1, '2025-09-22 07:12:48', NULL, NULL, '1/25B, middle street', 'Vilupuram', NULL, NULL, NULL, NULL, '9361120513', '2025-09-22 07:09:40', '2025-09-22 07:12:48'),
(10, 'Pattabi Raman V', 'veenav@dckap.com', '$2y$10$KOR3KoL9sPqLEQIfZKPixOrcsP/xSJIaj8Rtjt7Lxx.SId69MUs5y', 3, 1, '2025-09-22 07:37:31', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-09-22 07:37:31', '2025-09-22 07:37:31');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `cart`
--
ALTER TABLE `cart`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `cart_item`
--
ALTER TABLE `cart_item`
  ADD PRIMARY KEY (`cart_item_id`),
  ADD KEY `cart_id` (`cart_id`),
  ADD KEY `product_id` (`product_id`);

--
-- Indexes for table `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `cities`
--
ALTER TABLE `cities`
  ADD PRIMARY KEY (`id`),
  ADD KEY `state_id` (`state_id`);

--
-- Indexes for table `countries`
--
ALTER TABLE `countries`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`id`),
  ADD KEY `state_id` (`state_id`),
  ADD KEY `country_id` (`country_id`),
  ADD KEY `fk_orders_user` (`user_id`);

--
-- Indexes for table `order_items`
--
ALTER TABLE `order_items`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_order_items_order_id` (`order_id`),
  ADD KEY `idx_order_items_product_id` (`product_id`);

--
-- Indexes for table `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`id`),
  ADD KEY `category_id` (`category_id`),
  ADD KEY `subcategory_id` (`subcategory_id`),
  ADD KEY `store_id` (`store_id`),
  ADD KEY `seller_id` (`seller_id`),
  ADD KEY `images` (`images`);

--
-- Indexes for table `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `states`
--
ALTER TABLE `states`
  ADD PRIMARY KEY (`id`),
  ADD KEY `country_id` (`country_id`);

--
-- Indexes for table `stores`
--
ALTER TABLE `stores`
  ADD PRIMARY KEY (`id`),
  ADD KEY `city_id` (`city_id`),
  ADD KEY `state_id` (`state_id`),
  ADD KEY `country_id` (`country_id`);

--
-- Indexes for table `subcategories`
--
ALTER TABLE `subcategories`
  ADD PRIMARY KEY (`id`),
  ADD KEY `category_id` (`category_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`),
  ADD KEY `role_id` (`role_id`),
  ADD KEY `city_id` (`city_id`),
  ADD KEY `state_id` (`state_id`),
  ADD KEY `country_id` (`country_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `cart`
--
ALTER TABLE `cart`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `cart_item`
--
ALTER TABLE `cart_item`
  MODIFY `cart_item_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=34;

--
-- AUTO_INCREMENT for table `categories`
--
ALTER TABLE `categories`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `cities`
--
ALTER TABLE `cities`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `countries`
--
ALTER TABLE `countries`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `orders`
--
ALTER TABLE `orders`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=69;

--
-- AUTO_INCREMENT for table `order_items`
--
ALTER TABLE `order_items`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `products`
--
ALTER TABLE `products`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=33;

--
-- AUTO_INCREMENT for table `roles`
--
ALTER TABLE `roles`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `states`
--
ALTER TABLE `states`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `stores`
--
ALTER TABLE `stores`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `subcategories`
--
ALTER TABLE `subcategories`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=49;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `cart`
--
ALTER TABLE `cart`
  ADD CONSTRAINT `cart_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- Constraints for table `cart_item`
--
ALTER TABLE `cart_item`
  ADD CONSTRAINT `cart_item_ibfk_1` FOREIGN KEY (`cart_id`) REFERENCES `cart` (`id`),
  ADD CONSTRAINT `cart_item_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`);

--
-- Constraints for table `cities`
--
ALTER TABLE `cities`
  ADD CONSTRAINT `cities_ibfk_1` FOREIGN KEY (`state_id`) REFERENCES `states` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `orders`
--
ALTER TABLE `orders`
  ADD CONSTRAINT `fk_orders_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`state_id`) REFERENCES `states` (`id`),
  ADD CONSTRAINT `orders_ibfk_2` FOREIGN KEY (`country_id`) REFERENCES `countries` (`id`);

--
-- Constraints for table `order_items`
--
ALTER TABLE `order_items`
  ADD CONSTRAINT `fk_order_items_order` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_order_items_product` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON UPDATE CASCADE;

--
-- Constraints for table `products`
--
ALTER TABLE `products`
  ADD CONSTRAINT `products_ibfk_1` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `products_ibfk_2` FOREIGN KEY (`subcategory_id`) REFERENCES `subcategories` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `products_ibfk_3` FOREIGN KEY (`store_id`) REFERENCES `stores` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `products_ibfk_4` FOREIGN KEY (`seller_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `states`
--
ALTER TABLE `states`
  ADD CONSTRAINT `states_ibfk_1` FOREIGN KEY (`country_id`) REFERENCES `countries` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `stores`
--
ALTER TABLE `stores`
  ADD CONSTRAINT `stores_ibfk_1` FOREIGN KEY (`city_id`) REFERENCES `cities` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `stores_ibfk_2` FOREIGN KEY (`state_id`) REFERENCES `states` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `stores_ibfk_3` FOREIGN KEY (`country_id`) REFERENCES `countries` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `subcategories`
--
ALTER TABLE `subcategories`
  ADD CONSTRAINT `subcategories_ibfk_1` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `users`
--
ALTER TABLE `users`
  ADD CONSTRAINT `users_ibfk_1` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `users_ibfk_2` FOREIGN KEY (`city_id`) REFERENCES `cities` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `users_ibfk_3` FOREIGN KEY (`state_id`) REFERENCES `states` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `users_ibfk_4` FOREIGN KEY (`country_id`) REFERENCES `countries` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
