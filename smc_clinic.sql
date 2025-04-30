-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Apr 30, 2025 at 09:00 AM
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

--
-- Dumping data for table `appointments`
--

INSERT INTO `appointments` (`appointment_id`, `patient_id`, `Reason`, `appointmentDate`, `appointmentTime`, `remarks`, `Status`) VALUES
(1, 1, 'DRPH ALL-STAR', '2025-05-05', '10:30:00', 'Condragulations', 'Done'),
(2, 5, 'Hi maam', '2025-05-05', '10:35:00', 'loren ipsum som dolor', 'Accepted'),
(3, 1, 'shremmmmpppp', '2025-05-07', '11:56:00', 'DELEE ko kay walaii Shremmpp', 'Rejected');

-- --------------------------------------------------------

--
-- Table structure for table `clinic_status`
--

CREATE TABLE `clinic_status` (
  `id` int(11) NOT NULL,
  `status` enum('open','closed') NOT NULL,
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `clinic_status`
--

INSERT INTO `clinic_status` (`id`, `status`, `updated_at`) VALUES
(1, 'open', '2025-04-30 06:51:19');

-- --------------------------------------------------------

--
-- Table structure for table `nurse`
--

CREATE TABLE `nurse` (
  `nurse_id` int(11) NOT NULL,
  `id_number` char(8) NOT NULL,
  `firstName` varchar(50) NOT NULL,
  `middleName` varchar(50) NOT NULL,
  `lastName` varchar(50) NOT NULL,
  `password` varchar(16) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `nurse`
--

INSERT INTO `nurse` (`nurse_id`, `id_number`, `firstName`, `middleName`, `lastName`, `password`) VALUES
(1, 'N21-0345', 'Sangonomiya Marie Lissandra', 'Salaguinto', 'Kokomi', 'glorytome123');

-- --------------------------------------------------------

--
-- Table structure for table `patient`
--

CREATE TABLE `patient` (
  `patient_id` int(11) NOT NULL,
  `id_number` char(8) NOT NULL,
  `firstName` varchar(50) NOT NULL,
  `middleName` varchar(50) NOT NULL,
  `lastName` varchar(50) NOT NULL,
  `email` varchar(100) NOT NULL,
  `contact_number` char(11) NOT NULL,
  `password` varchar(16) NOT NULL,
  `role` enum('Student','Staff','','') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `patient`
--

INSERT INTO `patient` (`patient_id`, `id_number`, `firstName`, `middleName`, `lastName`, `email`, `contact_number`, `password`, `role`) VALUES
(1, 'C21-3482', 'Marina', 'Batumbakal', 'Summers', 'marinabatumbakal.summers@my.smciligan.edu.ph', '09557826735', 'alammoyanmarina', 'Student'),
(2, 'C24-1198', 'Precious Paula', 'Meanowe', 'Nicole', 'preciouspaulameanowe.nicole@my.smciligan.edu.ph', '09556565332', '12312023', 'Student'),
(3, 'C20-5674', 'Esnyr John', 'Linyar', 'Manalo', 'esnyrjohnlinyar.manalo@my.smciligan.edu.ph', '09268021678', 'bigWinnerPBB2025', 'Student'),
(4, 'C25-0039', 'Raiden', 'Munisipyo', 'Shogun', 'raidenmunisipyo.shogun@my.smciligan.edu.ph', '09661198546', 'forInazuma', 'Student'),
(5, 'S24-0593', 'Loren', 'Ipsum', 'Dolor', 'lorenipsum.dolor@my.smciligan.edu.ph', '0965789782', '1234567890', 'Staff'),
(6, 'S22-4857', 'Ada', 'Johannson', 'Lovelace', 'adajohannson.lovelace@my.smciligan.edu.ph', '09251908654', 'September251605', 'Staff');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `appointments`
--
ALTER TABLE `appointments`
  ADD PRIMARY KEY (`appointment_id`),
  ADD KEY `fk_patient_id` (`patient_id`);

--
-- Indexes for table `clinic_status`
--
ALTER TABLE `clinic_status`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `nurse`
--
ALTER TABLE `nurse`
  ADD PRIMARY KEY (`nurse_id`);

--
-- Indexes for table `patient`
--
ALTER TABLE `patient`
  ADD PRIMARY KEY (`patient_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `appointments`
--
ALTER TABLE `appointments`
  MODIFY `appointment_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `clinic_status`
--
ALTER TABLE `clinic_status`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `nurse`
--
ALTER TABLE `nurse`
  MODIFY `nurse_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `patient`
--
ALTER TABLE `patient`
  MODIFY `patient_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `appointments`
--
ALTER TABLE `appointments`
  ADD CONSTRAINT `fk_patient_id` FOREIGN KEY (`patient_id`) REFERENCES `patient` (`patient_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
