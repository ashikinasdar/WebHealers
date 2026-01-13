-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jan 13, 2026 at 05:53 AM
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
-- Table structure for table `assessment_results`
--

CREATE TABLE `assessment_results` (
  `result_id` int(11) NOT NULL,
  `student_id` int(11) NOT NULL,
  `assessment_type_id` int(11) NOT NULL,
  `depression_score` int(11) DEFAULT NULL,
  `anxiety_score` int(11) DEFAULT NULL,
  `stress_score` int(11) DEFAULT NULL,
  `overall_severity` enum('NORMAL','MILD','MODERATE','SEVERE','EXTREMELY_SEVERE') DEFAULT NULL,
  `recommendations` text DEFAULT NULL,
  `attempted_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `assessment_results`
--

INSERT INTO `assessment_results` (`result_id`, `student_id`, `assessment_type_id`, `depression_score`, `anxiety_score`, `stress_score`, `overall_severity`, `recommendations`, `attempted_at`) VALUES
(1, 1, 1, 6, 4, 8, 'NORMAL', 'Based on your assessment results, your scores indicate normal levels of depression, anxiety, and stress. You are managing well overall. Continue maintaining your current self-care practices', '2026-01-10 17:32:33'),
(2, 1, 1, 12, 14, 14, 'MODERATE', 'Based on your assessment results:\n\nDepression: Your score indicates mild depression. \n\nAnxiety: Your score indicates moderate anxiety. \n\nGeneral Recommendations:\n• Consider booking an appointment with our counselors\n• Explore our learning modules on mental health\n• Practice self-care and stress management techniques\n• Connect with peers in our support forum\n', '2026-01-13 00:49:04'),
(3, 1, 2, 18, 0, 0, 'MODERATE', 'Based on your assessment results:\n\nDepression: Your score indicates moderate depression. \n\nGeneral Recommendations:\n• Consider booking an appointment with our counselors\n• Explore our learning modules on mental health\n• Practice self-care and stress management techniques\n• Connect with peers in our support forum\n', '2026-01-13 00:49:53'),
(4, 1, 3, 0, 0, 0, 'NORMAL', 'Based on your assessment results:\n\nGeneral Recommendations:\n• Consider booking an appointment with our counselors\n• Explore our learning modules on mental health\n• Practice self-care and stress management techniques\n• Connect with peers in our support forum\n', '2026-01-13 00:50:19');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `assessment_results`
--
ALTER TABLE `assessment_results`
  ADD PRIMARY KEY (`result_id`),
  ADD KEY `student_id` (`student_id`),
  ADD KEY `assessment_type_id` (`assessment_type_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `assessment_results`
--
ALTER TABLE `assessment_results`
  MODIFY `result_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `assessment_results`
--
ALTER TABLE `assessment_results`
  ADD CONSTRAINT `assessment_results_ibfk_1` FOREIGN KEY (`student_id`) REFERENCES `students` (`student_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `assessment_results_ibfk_2` FOREIGN KEY (`assessment_type_id`) REFERENCES `assessment_types` (`assessment_type_id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
