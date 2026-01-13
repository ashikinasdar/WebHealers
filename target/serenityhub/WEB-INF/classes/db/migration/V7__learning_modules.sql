-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jan 13, 2026 at 06:00 AM
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
-- Table structure for table `learning_modules`
--

CREATE TABLE `learning_modules` (
  `module_id` int(11) NOT NULL,
  `title` varchar(200) NOT NULL,
  `category` varchar(100) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `content` text DEFAULT NULL,
  `duration_minutes` int(11) DEFAULT NULL,
  `display_order` int(11) DEFAULT NULL,
  `objectives` text DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT 1,
  `created_by` int(11) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `learning_modules`
--

INSERT INTO `learning_modules` (`module_id`, `title`, `category`, `description`, `content`, `duration_minutes`, `display_order`, `objectives`, `is_active`, `created_by`, `created_at`, `updated_at`) VALUES
(1, 'Understanding Mental Health and Well-Being', 'Mental Health', 'This module introduces the concept of mental health, explains why it is important, and helps students understand the difference between mental health and mental illness.', 'Mental health refers to a person’s emotional, psychological, and social well-being. It affects how we think, feel, and behave in daily life. Good mental health helps individuals cope with stress, perform well academically, and maintain healthy relationships.\r\n\r\nMental health is not just about the absence of mental illness. Everyone has mental health, and it can change over time depending on life experiences, stress levels, and support systems. Just like physical health, mental health requires care and attention.\r\n\r\nBy understanding mental health early, students can develop healthy coping strategies, recognize warning signs, and seek help when needed.', 5, 1, '1. Define mental health and mental well-being\r\n2. Differentiate between mental health and mental illness\r\n3. Recognize the importance of maintaining mental health', 1, 5, '2026-01-11 19:06:02', '2026-01-11 19:06:02'),
(2, 'Managing Stress in Academic Life', 'Stress Management', 'This module helps students understand academic stress and learn simple techniques to manage stress effectively.', 'Stress is a natural response to challenging situations such as exams, deadlines, and presentations. While a small amount of stress can be motivating, excessive stress can affect concentration, sleep, and overall health.\r\n\r\nCommon sources of academic stress include workload, time pressure, and fear of failure. Learning how to manage stress can improve academic performance and emotional well-being.\r\n\r\nThis module introduces practical stress management techniques such as time management, relaxation breathing, and balancing study with rest.', 10, 1, '1. Identify common sources of academic stress\r\n2. Understand the effects of stress on mental and physical health\r\n3. Practice basic stress management techniques', 1, 5, '2026-01-11 19:07:12', '2026-01-11 19:07:12'),
(3, 'Recognizing Anxiety and When to Seek Help', 'Anxiety', 'This module raises awareness about anxiety, its symptoms, and encourages students to seek help when anxiety interferes with daily life.', 'Anxiety is a feeling of worry or fear that everyone experiences from time to time. It can become a problem when it is intense, long-lasting, or affects daily activities such as studying or socializing.\r\n\r\nCommon signs of anxiety include constant worrying, difficulty concentrating, restlessness, rapid heartbeat, and sleep problems. Anxiety can be managed with the right support, coping skills, and professional guidance.\r\n\r\nUnderstanding anxiety helps reduce stigma and encourages students to seek support from trusted individuals, counselors, or mental health professionals.', 10, 1, '1. Describe what anxiety is and how it affects students\r\n2. Identify common symptoms of anxiety\r\n3. Understand when and how to seek help', 1, 5, '2026-01-11 19:08:43', '2026-01-11 19:08:43'),
(4, 'Building Healthy Relationships and Communication', 'Relationships', 'This module focuses on developing healthy communication skills and maintaining positive relationships.', 'Healthy relationships are built on respect, trust, and open communication. Good communication allows individuals to express feelings, set boundaries, and resolve conflicts effectively.\r\n\r\nStudents often face challenges in friendships, family relationships, and group work. Learning to communicate assertively—without being aggressive or passive—helps maintain emotional balance and mutual understanding.\r\n\r\nThis module emphasizes listening skills, empathy, and respectful expression of thoughts and emotions.', 5, 1, '1. Identify characteristics of healthy relationships\r\n2. Practice effective communication techniques\r\n3. Understand the importance of boundaries and respect', 1, 5, '2026-01-11 19:09:38', '2026-01-11 19:09:38'),
(5, 'Self-Care Strategies for Daily Mental Wellness', 'Self-Care', 'This module introduces simple self-care practices that students can apply in their daily routines.', 'Self-care involves activities that help maintain mental, emotional, and physical well-being. It is not selfish; rather, it is essential for managing stress and preventing burnout.\r\n\r\nExamples of self-care include getting enough sleep, eating balanced meals, staying physically active, taking breaks, and engaging in hobbies. Small daily habits can have a positive impact on mental health over time.\r\n\r\nBy practicing self-care consistently, students can improve resilience and overall quality of life.', 10, 1, '1. Define self-care and its role in mental health\r\n2. Identify practical self-care activities\r\n3. Develop a simple personal self-care plan', 1, 5, '2026-01-11 19:10:46', '2026-01-11 19:10:46');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `learning_modules`
--
ALTER TABLE `learning_modules`
  ADD PRIMARY KEY (`module_id`),
  ADD KEY `created_by` (`created_by`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `learning_modules`
--
ALTER TABLE `learning_modules`
  MODIFY `module_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `learning_modules`
--
ALTER TABLE `learning_modules`
  ADD CONSTRAINT `learning_modules_ibfk_1` FOREIGN KEY (`created_by`) REFERENCES `users` (`user_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
