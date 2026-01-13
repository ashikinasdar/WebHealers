-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jan 13, 2026 at 05:54 AM
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
-- Table structure for table `assessment_types`
--

CREATE TABLE `assessment_types` (
  `assessment_type_id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `description` text DEFAULT NULL,
  `total_questions` int(11) DEFAULT NULL,
  `scoring_method` text DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `assessment_types`
--

INSERT INTO `assessment_types` (`assessment_type_id`, `name`, `description`, `total_questions`, `scoring_method`, `is_active`) VALUES
(1, 'DASS-21', 'Depression Anxiety Stress Scales - 21 items', 21, 'Sum scores for each subscale: Depression (items 3,5,10,13,16,17,21), Anxiety (items 2,4,7,9,15,19,20), Stress (items 1,6,8,11,12,14,18). Multiply each sum by 2.', 1),
(2, 'PHQ-9', 'Patient Health Questionnaire - 9 Items', 9, 'Sum scores', 1),
(3, 'GAD-7', 'Generalized Anxiety Disorder - 7 Items', 7, 'Sum scores', 1);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `assessment_types`
--
ALTER TABLE `assessment_types`
  ADD PRIMARY KEY (`assessment_type_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `assessment_types`
--
ALTER TABLE `assessment_types`
  MODIFY `assessment_type_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
