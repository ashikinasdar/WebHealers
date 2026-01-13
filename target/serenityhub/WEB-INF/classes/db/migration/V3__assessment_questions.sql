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
-- Table structure for table `assessment_questions`
--

CREATE TABLE `assessment_questions` (
  `assessment_question_id` int(11) NOT NULL,
  `assessment_type_id` int(11) NOT NULL,
  `question_text` text NOT NULL,
  `category` varchar(50) DEFAULT NULL,
  `display_order` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `assessment_questions`
--

INSERT INTO `assessment_questions` (`assessment_question_id`, `assessment_type_id`, `question_text`, `category`, `display_order`) VALUES
(1, 1, 'I found it hard to wind down', 'STRESS', 1),
(2, 1, 'I was aware of dryness of my mouth', 'ANXIETY', 2),
(3, 1, 'I couldn\'t seem to experience any positive feeling at all', 'DEPRESSION', 3),
(4, 1, 'I experienced breathing difficulty (e.g. excessively rapid breathing, breathlessness)', 'ANXIETY', 4),
(5, 1, 'I found it difficult to work up the initiative to do things', 'DEPRESSION', 5),
(6, 1, 'I tended to over-react to situations', 'STRESS', 6),
(7, 1, 'I experienced trembling (e.g. in the hands)', 'ANXIETY', 7),
(8, 1, 'I felt that I was using a lot of nervous energy', 'STRESS', 8),
(9, 1, 'I was worried about situations in which I might panic and make a fool of myself', 'ANXIETY', 9),
(10, 1, 'I felt that I had nothing to look forward to', 'DEPRESSION', 10),
(11, 1, 'I found myself getting agitated', 'STRESS', 11),
(12, 1, 'I found it difficult to relax', 'STRESS', 12),
(13, 1, 'I felt down-hearted and blue', 'DEPRESSION', 13),
(14, 1, 'I was intolerant of anything that kept me from getting on with what I was doing', 'STRESS', 14),
(15, 1, 'I felt I was close to panic', 'ANXIETY', 15),
(16, 1, 'I was unable to become enthusiastic about anything', 'DEPRESSION', 16),
(17, 1, 'I felt I wasn\'t worth much as a person', 'DEPRESSION', 17),
(18, 1, 'I felt that I was rather touchy', 'STRESS', 18),
(19, 1, 'I was aware of the action of my heart in the absence of physical exertion', 'ANXIETY', 19),
(20, 1, 'I felt scared without any good reason', 'ANXIETY', 20),
(21, 1, 'I felt that life was meaningless', 'DEPRESSION', 21),
(22, 2, 'Little interest or pleasure in doing things', 'DEPRESSION', 1),
(23, 2, 'Feeling down, depressed, or hopeless', 'DEPRESSION', 2),
(24, 2, 'Trouble falling or staying asleep, or sleeping too much', 'DEPRESSION', 3),
(25, 2, 'Feeling tired or having little energy', 'DEPRESSION', 4),
(26, 2, 'Poor appetite or overeating', 'DEPRESSION', 5),
(27, 2, 'Feeling bad about yourself or that you are a failure', 'DEPRESSION', 6),
(28, 2, 'Trouble concentrating on things', 'DEPRESSION', 7),
(29, 2, 'Moving or speaking slowly, or being fidgety or restless', 'DEPRESSION', 8),
(30, 2, 'Thoughts that you would be better off dead', 'DEPRESSION', 9),
(31, 3, 'Feeling nervous, anxious, or on edge', 'ANXIETY', 1),
(32, 3, 'Not being able to stop or control worrying', 'ANXIETY', 2),
(33, 3, 'Worrying too much about different things', 'ANXIETY', 3),
(34, 3, 'Trouble relaxing', 'ANXIETY', 4),
(35, 3, 'Being so restless that it is hard to sit still', 'ANXIETY', 5),
(36, 3, 'Becoming easily annoyed or irritable', 'ANXIETY', 6),
(37, 3, 'Feeling afraid, as if something awful might happen', 'ANXIETY', 7);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `assessment_questions`
--
ALTER TABLE `assessment_questions`
  ADD PRIMARY KEY (`assessment_question_id`),
  ADD KEY `assessment_type_id` (`assessment_type_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `assessment_questions`
--
ALTER TABLE `assessment_questions`
  MODIFY `assessment_question_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=38;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `assessment_questions`
--
ALTER TABLE `assessment_questions`
  ADD CONSTRAINT `assessment_questions_ibfk_1` FOREIGN KEY (`assessment_type_id`) REFERENCES `assessment_types` (`assessment_type_id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
