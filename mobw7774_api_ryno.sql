-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Jul 12, 2024 at 02:56 AM
-- Server version: 10.3.39-MariaDB-cll-lve
-- PHP Version: 8.1.28

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `mobw7774_api_ryno`
--

-- --------------------------------------------------------

--
-- Table structure for table `categories`
--

CREATE TABLE `categories` (
  `id` int(11) NOT NULL,
  `name` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `categories`
--

INSERT INTO `categories` (`id`, `name`) VALUES
(1, 'Sarapan'),
(2, 'Makan Malam'),
(3, 'Makan Siang'),
(4, 'Cemilan'),
(5, 'Minuman');

-- --------------------------------------------------------

--
-- Table structure for table `recipes`
--

CREATE TABLE `recipes` (
  `id` int(11) NOT NULL,
  `title` varchar(100) NOT NULL,
  `description` text DEFAULT NULL,
  `category_id` int(11) DEFAULT NULL,
  `image_url` varchar(255) DEFAULT NULL,
  `details` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `recipes`
--

INSERT INTO `recipes` (`id`, `title`, `description`, `category_id`, `image_url`, `details`) VALUES
(1, 'Bubur Ayam', 'Bubur ayam adalah makanan yang cocok untuk sarapan.', 1, 'https://asset.kompas.com/crops/btj22rekM1BWGnffmdQnoCt5ezk=/0x10:1000x677/750x500/data/photo/2021/07/29/61019f07ef1ac.jpg', '1/4 kg paha ayam (pakai yg ada tulang supaya kaldunya terasa)\n2 butir telur rebus\nBubur nasi (nasi direbus bersama air dan garam/kaldu jamur) sesuai selera bs tambahkan potongan daunbawang'),
(2, 'Sate Ayam Madura', 'Sate Ayam yang berasal dari Kota Madura', 2, 'https://img-global.cpcdn.com/recipes/a6ca9f36b02b089b/640x640sq70/photo.webp', NULL),
(10, 'Nasi Goreng Rumahan', 'Nasi goreng yang enak dan sederhana bisa kamu praktikkan di rumah. Selain itu, bagi kamu anak kos, juga bisa menerapkan cara membuat nasi goreng ini karena tidak membutuhkan terlalu banyak bahan-bahan.', 1, 'https://asset.kompas.com/crops/EMJVbKL9l13Bl9NX4kEFy3-C_Ik=/3x0:700x465/750x500/data/photo/2020/07/14/5f0d8f67961aa.jpg', '- Air- Bawang merah goreng (opsional)- Sedikit garam- 1 gelas beras putih- 1 bungkus Bumbu nasi goreng instan- Topping sesuai selera Sosis, bakso, ayam, telur, sayuran (bebas)');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `username` varchar(50) NOT NULL,
  `password` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `username`, `password`) VALUES
(1, 'ryno', '12345'),
(2, 'udin', '$2y$10$uPS1nJvNwfCaNFqjyBqxQ.60R7.P.YkO/oZkH.LG3LH16rqNBKBy6'),
(3, 'udean', '$2y$10$ZsoQdi0jpEoEqG0yk7uhue8oFeq4cFoRGSC9Mi60fHtN9L7YkZPku'),
(4, 'dean', '$2y$10$9a2rvSzMOgcyCyI6vqqFIuUMnMOcptN6J.kQf2wtD9hlYEvC8Xp3K'),
(5, 'user', '$2y$10$pbAuqFT.JBj75sX0kWs9N.vdEHQf/e4G2PcrHS/vccQSwXUtqsWbm'),
(6, 'testing', '$2y$10$0ql.FqdeEmTsKV/gRsgQP.p37HX5bRUQXGHFo04/fJikh3zwr9a6e');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `recipes`
--
ALTER TABLE `recipes`
  ADD PRIMARY KEY (`id`),
  ADD KEY `category_id` (`category_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `categories`
--
ALTER TABLE `categories`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `recipes`
--
ALTER TABLE `recipes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `recipes`
--
ALTER TABLE `recipes`
  ADD CONSTRAINT `recipes_ibfk_1` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
