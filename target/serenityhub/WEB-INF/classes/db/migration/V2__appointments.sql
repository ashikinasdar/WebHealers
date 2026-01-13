-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jan 13, 2026 at 05:48 AM
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
-- Table structure for table `appointments`
--

CREATE TABLE `appointments` (
  `appointment_id` int(11) NOT NULL,
  `student_id` int(11) NOT NULL,
  `counselor_id` int(11) NOT NULL,
  `appointment_date` date NOT NULL,
  `appointment_time` time NOT NULL,
  `session_type` enum('IN_PERSON','ONLINE','PHONE') NOT NULL,
  `status` enum('PENDING','APPROVED','DECLINED','COMPLETED','CANCELLED') DEFAULT 'PENDING',
  `reason` text DEFAULT NULL,
  `notes` text DEFAULT NULL,
  `counselor_notes` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `appointments`
--

INSERT INTO `appointments` (`appointment_id`, `student_id`, `counselor_id`, `appointment_date`, `appointment_time`, `session_type`, `status`, `reason`, `notes`, `counselor_notes`, `created_at`, `updated_at`) VALUES
(1, 1, 1, '2026-01-19', '10:00:00', 'IN_PERSON', 'APPROVED', 'Finals are coming, I need some advice on stress management', NULL, NULL, '2026-01-12 11:02:51', '2026-01-12 15:08:13'),
(2, 2, 1, '2026-01-19', '14:00:00', 'IN_PERSON', 'PENDING', 'Just want to have a short chat before finals start', NULL, NULL, '2026-01-12 15:13:29', '2026-01-12 15:13:29'),
(3, 3, 1, '2026-01-19', '16:00:00', 'PHONE', 'PENDING', 'Wanna ask some tips for management', NULL, NULL, '2026-01-12 15:18:40', '2026-01-12 15:18:40');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `appointments`
--
ALTER TABLE `appointments`
  ADD PRIMARY KEY (`appointment_id`),
  ADD KEY `student_id` (`student_id`),
  ADD KEY `counselor_id` (`counselor_id`),
  ADD KEY `idx_date_time` (`appointment_date`,`appointment_time`),
  ADD KEY `idx_status` (`status`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `appointments`
--
ALTER TABLE `appointments`
  MODIFY `appointment_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `appointments`
--
ALTER TABLE `appointments`
  ADD CONSTRAINT `appointments_ibfk_1` FOREIGN KEY (`student_id`) REFERENCES `students` (`student_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `appointments_ibfk_2` FOREIGN KEY (`counselor_id`) REFERENCES `counselors` (`counselor_id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
