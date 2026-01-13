-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jan 13, 2026 at 06:03 AM
-- Server version: 10.4.28-MariaDB
-- PHP Version: 8.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `serenityhub`
--

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `user_id` int(11) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password_hash` varchar(255) NOT NULL,
  `full_name` varchar(100) NOT NULL,
  `user_type` enum('STUDENT','COUNSELOR','ADMIN') NOT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `is_active` tinyint(1) DEFAULT 1,
  `last_login` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`user_id`, `email`, `password_hash`, `full_name`, `user_type`, `phone`, `created_at`, `updated_at`, `is_active`, `last_login`) VALUES
(2, 'ainazafirah@graduate.utm.my', '$2a$10$PC/cjY4P9P4J4G7l.IvbEePWidal5UAkomDjUWxdBkmyo0iXt184W', 'AINA ZAFIRAH BINTI AHMAD MUZAMIR', 'STUDENT', '0128759113', '2026-01-11 15:17:19', '2026-01-13 04:28:11', 1, '2026-01-13 04:28:11'),
(4, 'romlahabdullah@utm.my', '$2a$10$RK1ox1x6uEfdVBKrkBx6Suqw3WU0KbaH8itOBqde34QZpFY.E/3je', 'DR. ROMLAH ABDULLAH', 'COUNSELOR', '0195701859', '2026-01-11 18:35:21', '2026-01-13 04:24:16', 1, '2026-01-13 04:24:16'),
(5, 'systemadmin@utm.my', '$2a$10$AVWWiW5vR8a9BMnRK1K4oeOFzUBrYU1Qt7WzzkXj8DT6eeiHMX1Gi', 'SYSTEM ADMIN', 'ADMIN', '0194806911', '2026-01-11 18:36:49', '2026-01-13 04:29:26', 1, '2026-01-13 04:29:26'),
(6, 'nuraifainsyirah@graduate.utm.my', '$2a$10$QJXCA.FO.L57jO9971Nc8.DOyskdTS3ZuuOQLcj2U7Vh7jyWtTfhm', 'NUR AIFA INSYIRAH BINTI HAIRUL AZMI', 'STUDENT', '01172601046', '2026-01-11 18:42:30', '2026-01-12 15:12:32', 1, '2026-01-12 15:12:32'),
(7, 'alianatasha@graduate.utm.my', '$2a$10$aRQtwbofpdVMhIKBKWCFqOL9L4xVLq/xSw1Tu4aYrXQxDryrWUeFq', 'ALIA NATASHA BINTI MOHD HAFIZAR', 'STUDENT', '0138937422', '2026-01-11 18:43:32', '2026-01-12 15:17:42', 1, '2026-01-12 15:17:42'),
(8, 'aisyahhanim@utm.my', '$2a$10$LnZttX1fknzRNaLLU/rIBeyFOwS8oxFUoe7YBa0s/BPwExNyFm5hO', 'DR. AISYAH NUR HANIM', 'COUNSELOR', '012-345 6789', '2026-01-11 18:54:37', '2026-01-12 14:45:42', 1, '2026-01-12 14:45:42'),
(9, 'farhaniskandar@utm.my', '$2a$10$DIuBR/K8/8771e25oc01DOpgn889UAsFWhC68VEpphocvkJzNizAu', 'DR. FARHAN ISKANDAR', 'COUNSELOR', '016-678 9012', '2026-01-11 19:00:35', '2026-01-13 01:07:41', 1, '2026-01-13 01:07:41');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`user_id`),
  ADD UNIQUE KEY `email` (`email`),
  ADD KEY `idx_email` (`email`),
  ADD KEY `idx_user_type` (`user_type`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `user_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
