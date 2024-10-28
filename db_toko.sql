-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Oct 28, 2024 at 08:28 AM
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
-- Database: `db_toko`
--

-- --------------------------------------------------------

--
-- Table structure for table `tb_barang`
--

CREATE TABLE `tb_barang` (
  `id` int(255) NOT NULL,
  `nama` varchar(255) NOT NULL,
  `merk` varchar(255) NOT NULL,
  `stok` int(255) NOT NULL,
  `harga` int(255) NOT NULL,
  `tgl_masuk` date NOT NULL,
  `exp` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tb_barang`
--

INSERT INTO `tb_barang` (`id`, `nama`, `merk`, `stok`, `harga`, `tgl_masuk`, `exp`) VALUES
(1, 'Chocolate 13gr', 'Diary Milk', 96, 12000, '2024-10-15', '2024-10-15');

-- --------------------------------------------------------

--
-- Table structure for table `tb_faktur`
--

CREATE TABLE `tb_faktur` (
  `id_faktur` varchar(255) NOT NULL,
  `id` int(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tb_faktur`
--

INSERT INTO `tb_faktur` (`id_faktur`, `id`) VALUES
('F20241028-001', 7),
('F20241028-002', 8);

--
-- Triggers `tb_faktur`
--
DELIMITER $$
CREATE TRIGGER `set_status_barang` AFTER INSERT ON `tb_faktur` FOR EACH ROW BEGIN
    UPDATE tb_sales
    SET status_pembayaran = 'dibayar'
    WHERE kode_faktur = NEW.id_faktur;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `tb_sales`
--

CREATE TABLE `tb_sales` (
  `id_sales` int(11) NOT NULL,
  `kode_faktur` varchar(255) NOT NULL,
  `id_barang` int(255) NOT NULL,
  `nama_barang` varchar(255) NOT NULL,
  `harga_barang` int(255) NOT NULL,
  `jumlah` int(255) NOT NULL,
  `total` int(255) NOT NULL,
  `status_pembayaran` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tb_sales`
--

INSERT INTO `tb_sales` (`id_sales`, `kode_faktur`, `id_barang`, `nama_barang`, `harga_barang`, `jumlah`, `total`, `status_pembayaran`) VALUES
(33, 'F20241028-002', 1, 'Chocolate 13gr', 12000, 2, 24000, 'dibayar'),
(34, 'F20241028-002', 1, 'Chocolate 13gr', 12000, 2, 24000, 'dibayar');

--
-- Triggers `tb_sales`
--
DELIMITER $$
CREATE TRIGGER `kurangi stok` AFTER INSERT ON `tb_sales` FOR EACH ROW BEGIN
    UPDATE tb_barang
    SET stok = stok - NEW.jumlah
    WHERE id = NEW.id_barang;
END
$$
DELIMITER ;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `tb_barang`
--
ALTER TABLE `tb_barang`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tb_faktur`
--
ALTER TABLE `tb_faktur`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tb_sales`
--
ALTER TABLE `tb_sales`
  ADD PRIMARY KEY (`id_sales`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `tb_faktur`
--
ALTER TABLE `tb_faktur`
  MODIFY `id` int(255) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `tb_sales`
--
ALTER TABLE `tb_sales`
  MODIFY `id_sales` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=35;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
