-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jan 13, 2026 at 05:56 AM
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
-- Table structure for table `counselors`
--

CREATE TABLE `counselors` (
  `counselor_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `specialization` varchar(100) DEFAULT NULL,
  `qualifications` text DEFAULT NULL,
  `bio` text DEFAULT NULL,
  `available_days` varchar(100) DEFAULT NULL,
  `profile_picture` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `counselors`
--

INSERT INTO `counselors` (`counselor_id`, `user_id`, `specialization`, `qualifications`, `bio`, `available_days`, `profile_picture`) VALUES
(1, 4, 'Stress Management', 'Master of Counseling Psychology, University of Malaya', 'Experienced counselor specializing in academic stress and time management for university students.', 'Monday, Tuesday, Friday', NULL),
(2, 8, 'Anxiety & Depression', 'Bachelor of Psychology (Hons), Master of Clinical Psychology', 'Passionate about helping students manage anxiety, depression, and emotional challenges.', 'Tuesday, Thursday', NULL),
(3, 9, 'Self-Esteem & Personal Growth', 'Bachelor of Counseling, Certified Mental Health First Aider', 'Focuses on building confidence, resilience, and emotional well-being among young adults.', 'Monday, Tuesday, Thursday', NULL);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `counselors`
--
ALTER TABLE `counselors`
  ADD PRIMARY KEY (`counselor_id`),
  ADD UNIQUE KEY `user_id` (`user_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `counselors`
--
ALTER TABLE `counselors`
  MODIFY `counselor_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `counselors`
--
ALTER TABLE `counselors`
  ADD CONSTRAINT `counselors_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
