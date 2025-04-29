-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Apr 28, 2025 at 04:24 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `smc_clinic`
--

-- --------------------------------------------------------

--
-- Table structure for table `nurse`
--

CREATE TABLE `nurse` (
  `nurse_id` int(11) NOT NULL,
  `firstName` varchar(50) NOT NULL,
  `middleName` varchar(50) NOT NULL,
  `lastName` varchar(50) NOT NULL,
  `id_number` char(8) NOT NULL,
  `password` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `nurse`
--

INSERT INTO `nurse` (`nurse_id`, `firstName`, `middleName`, `lastName`, `id_number`, `password`) VALUES
(1, 'Lee', 'Min', 'Ho', 'N23-0101', '1234'),
(2, 'Sangonomiya Marie Lissandra', 'Salaguinto', 'Kokomi', 'N21-0345', 'glorytome123');

-- --------------------------------------------------------

--
-- Table structure for table `patient`
--

CREATE TABLE `patient` (
  `patient_id` int(11) NOT NULL,
  `id_number` char(8) NOT NULL,
  `firstName` varchar(100) NOT NULL,
  `middleName` varchar(100) NOT NULL,
  `lastName` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `contact_number` char(11) NOT NULL,
  `password` varchar(16) NOT NULL,
  `role` enum('student','staff') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `patient`
--

INSERT INTO `patient` (`patient_id`, `id_number`, `firstName`, `middleName`, `lastName`, `email`, `contact_number`, `password`, `role`) VALUES
(1, 'C21-3482', 'Marina', 'Batumbakal', 'Summers', 'marinabatumbakal.summers@my.smciligan.edu.ph', '09557826735', 'alammoyanmarina', 'student'),
(2, 'C24-1198', 'Ensyr John', 'Liberty', 'Manalo', 'esnyrjohnliberty.manalo@my.smciligan.edu.ph', '0926741850', '0123456789', 'student'),
(3, 'C20-5674', 'Loren', 'Ipsum', 'Dolor', 'lorenipsum.dolor@my.smciligan.edu.ph', '09553205105', 'DontH@t3mh13', 'student'),
(4, 'C25-0039', 'Miss', 'Jade', 'So', 'missjade.so@my.smciligan.edu.ph', '09918261391', 'weareonewithin', 'student'),
(5, 'C22-8401', 'Raiden', 'Marie', 'Shogun', 'raidenmarie.shogun@my.smciligan.edu.ph', '09268021580', 'September12021', 'student'),
(6, 'S24-0593', 'Ru', 'De Guzman', 'Paul', 'rudeguzman.paul@my.smciligan.edu.ph', '09556565332', '12312023', 'staff'),
(7, 'S22-4857', 'Ada', 'Fontaine', 'Lovelace', 'adafontaine.lovelace@my.smciligan.edu.ph', '09754337912', 'Womanispower1815', 'staff'),
(8, 'S21-7624', 'William Jones', 'Dumbledore', 'Shakespeare', 'williamjonesdumbledore.shakespeare@my.smciligan.edu.ph', '09715521904', 'April_23', 'staff');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `nurse`
--
ALTER TABLE `nurse`
  ADD PRIMARY KEY (`nurse_id`);

--
-- Indexes for table `patient`
--
ALTER TABLE `patient`
  ADD PRIMARY KEY (`patient_id`),
  ADD UNIQUE KEY `id_number` (`id_number`),
  ADD UNIQUE KEY `email` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `nurse`
--
ALTER TABLE `nurse`
  MODIFY `nurse_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `patient`
--
ALTER TABLE `patient`
  MODIFY `patient_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
