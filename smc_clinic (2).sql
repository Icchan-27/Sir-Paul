-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Apr 30, 2025 at 05:56 AM
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
-- Table structure for table `appointments`
--

CREATE TABLE `appointments` (
  `appointment_id` int(11) NOT NULL,
  `patient_id` int(11) NOT NULL,
  `Reason` text NOT NULL,
  `appointmentDate` date NOT NULL,
  `appointmentTime` time NOT NULL,
  `remarks` text NOT NULL,
  `Status` enum('Pending','Accepted','Rejected','Done') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `inventory`
--

CREATE TABLE `inventory` (
  `inventory_id` int(11) NOT NULL,
  `medicine_name` varchar(55) NOT NULL,
  `stockremaining` int(255) NOT NULL,
  `totalstock` int(255) NOT NULL,
  `status` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=armscii8 COLLATE=armscii8_general_ci;

--
-- Dumping data for table `inventory`
--

INSERT INTO `inventory` (`inventory_id`, `medicine_name`, `stockremaining`, `totalstock`, `status`) VALUES
(1, 'Biogesic', 11781, 12705, 'Available'),
(3, 'KISS MO LANG', 98, 357, 'Available'),
(4, 'MAAM SIR DI NAKO OY', 153, 153, 'Available'),
(5, 'TAMA NA GURP NI OY', 1111, 1111, 'Available'),
(6, 'Mefinamic', 100, 357, 'Available');

-- --------------------------------------------------------

--
-- Table structure for table `medicine`
--

CREATE TABLE `medicine` (
  `medicine_id` int(11) NOT NULL,
  `patient_id` int(11) NOT NULL,
  `medicine_name` varchar(50) NOT NULL,
  `quantity` int(11) NOT NULL,
  `reason` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `medicine`
--

INSERT INTO `medicine` (`medicine_id`, `patient_id`, `medicine_name`, `quantity`, `reason`) VALUES
(14, 8, 'Mefinamic', 143, 'ambot sad'),
(15, 8, 'Mefinamic', 91, 'gasakit'),
(16, 8, 'KISS MO LANG', 143, 'gasakit'),
(17, 8, 'Mefinamic', 12, 'gasakit'),
(18, 8, 'Mefinamic', 11, 'yawa ka'),
(19, 8, 'KISS MO LANG', 12, 'ambot sad'),
(20, 8, 'KISS MO LANG', 12, 'gasakit'),
(21, 8, 'KISS MO LANG', 12, 'gasakit'),
(22, 8, 'KISS MO LANG', 12, 'gasakit'),
(23, 8, 'KISS MO LANG', 12, 'migana na siyaaaa'),
(24, 8, 'Biogesic', 60, 'ambot sad'),
(25, 8, 'Biogesic', 564, 'mugana na siya peps');

-- --------------------------------------------------------

--
-- Table structure for table `nurse`
--

CREATE TABLE `nurse` (
  `nurse_id` int(11) NOT NULL,
  `id_number` varchar(8) NOT NULL,
  `firstName` varchar(35) NOT NULL,
  `middleName` varchar(35) NOT NULL,
  `lastName` varchar(35) NOT NULL,
  `password` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `nurse`
--

INSERT INTO `nurse` (`nurse_id`, `id_number`, `firstName`, `middleName`, `lastName`, `password`) VALUES
(2, 'admin', 'Maria Alonah', 'A.', 'Chan', '1234'),
(3, 'N23-0101', 'Lee', 'Min', 'Ho', '1234'),
(4, 'N21-0345', 'Sangonomiya Marie Lissandra', 'Salaguinto', 'Kokomi', 'glorytome123');

-- --------------------------------------------------------

--
-- Table structure for table `patient`
--

CREATE TABLE `patient` (
  `patient_id` int(11) NOT NULL,
  `id_number` varchar(50) NOT NULL,
  `firstName` varchar(100) NOT NULL,
  `middleName` varchar(100) NOT NULL,
  `lastName` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `contact_number` varchar(50) NOT NULL,
  `password` varchar(255) NOT NULL,
  `role` enum('student','staff') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `patient`
--

INSERT INTO `patient` (`patient_id`, `id_number`, `firstName`, `middleName`, `lastName`, `email`, `contact_number`, `password`, `role`) VALUES
(8, 'user', 'John', '', 'Doe', 'john.doe@example.com', '0987654321', '1234', 'student'),
(9, 'C21-3482', 'Marina', 'Batumbakal', 'Summers', 'marinabatumbakal.summers@my.smciligan.edu.ph', '09557826735', 'alammoyanmarina', 'student'),
(10, 'C24-1198', 'Ensyr John', 'Liberty', 'Manalo', 'esnyrjohnliberty.manalo@my.smciligan.edu.ph', '0926741850', '0123456789', 'student'),
(11, 'C20-5674', 'Loren', 'Ipsum', 'Dolor', 'lorenipsum.dolor@my.smciligan.edu.ph', '09553205105', 'DontH@t3mh13', 'student'),
(12, 'C25-0039', 'Miss', 'Jade', 'So', 'missjade.so@my.smciligan.edu.ph', '09918261391', 'weareonewithin', 'student'),
(13, 'C22-8401', 'Raiden', 'Marie', 'Shogun', 'raidenmarie.shogun@my.smciligan.edu.ph', '09268021580', 'September12021', 'student'),
(14, 'S24-0593', 'Ru', 'De Guzman', 'Paul', 'rudeguzman.paul@my.smciligan.edu.ph', '09556565332', '12312023', 'staff'),
(15, 'S22-4857', 'Ada', 'Fontaine', 'Lovelace', 'adafontaine.lovelace@my.smciligan.edu.ph', '09754337912', 'Womanispower1815', 'staff'),
(16, 'S21-7624', 'William Jones', 'Dumbledore', 'Shakespeare', 'williamjonesdumbledore.shakespeare@my.smciligan.edu.ph', '09715521904', 'April_23', 'staff');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `appointments`
--
ALTER TABLE `appointments`
  ADD PRIMARY KEY (`appointment_id`);

--
-- Indexes for table `inventory`
--
ALTER TABLE `inventory`
  ADD PRIMARY KEY (`inventory_id`);

--
-- Indexes for table `medicine`
--
ALTER TABLE `medicine`
  ADD PRIMARY KEY (`medicine_id`),
  ADD KEY `fk_patient_id` (`patient_id`);

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
-- AUTO_INCREMENT for table `appointments`
--
ALTER TABLE `appointments`
  MODIFY `appointment_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `inventory`
--
ALTER TABLE `inventory`
  MODIFY `inventory_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `medicine`
--
ALTER TABLE `medicine`
  MODIFY `medicine_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=26;

--
-- AUTO_INCREMENT for table `nurse`
--
ALTER TABLE `nurse`
  MODIFY `nurse_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `patient`
--
ALTER TABLE `patient`
  MODIFY `patient_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `medicine`
--
ALTER TABLE `medicine`
  ADD CONSTRAINT `fk_patient_id` FOREIGN KEY (`patient_id`) REFERENCES `patient` (`patient_id`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
