-- phpMyAdmin SQL Dump
-- version 4.8.3
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Mar 30, 2021 at 10:34 AM
-- Server version: 10.1.36-MariaDB
-- PHP Version: 5.6.38

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `spp`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_siswa` ()  NO SQL
BEGIN
	SELECT `tbl_siswa`.*, `tbl_kelas`.`nama_kelas`, `tbl_spp`.`tahun`
                FROM `tbl_siswa` JOIN `tbl_kelas`
                ON `tbl_siswa`.`id_kelas` = `tbl_kelas`.`id_kelas`
                JOIN `tbl_spp` ON `tbl_siswa` .`id_spp` = `tbl_spp`.`id_spp` ORDER BY `tbl_siswa`.`NISN`, `tbl_siswa`.`id_kelas` ASC;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `kelas_get` ()  NO SQL
BEGIN
	SELECT `tbl_kelas`.*, `tbl_jurusan`.`jurusan` FROM `tbl_kelas` JOIN `tbl_jurusan` ON `tbl_kelas`.`id_jurusan` = `tbl_jurusan`.`id_jurusan` ORDER BY `tbl_kelas`.`id_jurusan` ASC;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `level_get` (IN `level` INT)  NO SQL
BEGIN
	SELECT * FROM tbl_level WHERE level = id_level;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `login_check` (IN `user` VARCHAR(100), IN `pass` VARCHAR(225))  NO SQL
BEGIN
	SELECT * FROM tbl_petugas WHERE user = username AND pass = password_petugas;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `siswa_check` (IN `user` VARCHAR(10), IN `pass` VARCHAR(225))  NO SQL
BEGIN
	SELECT * FROM tbl_siswa WHERE user = nisn AND pass = nis;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `tbl_jurusan`
--

CREATE TABLE `tbl_jurusan` (
  `ID_JURUSAN` int(11) NOT NULL,
  `JURUSAN` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `tbl_jurusan`
--

INSERT INTO `tbl_jurusan` (`ID_JURUSAN`, `JURUSAN`) VALUES
(1, 'Rekayasa Perangkat Lunak'),
(2, 'Teknik Jaringan Dan Komputer'),
(3, 'Multimedia 2');

-- --------------------------------------------------------

--
-- Table structure for table `tbl_kelas`
--

CREATE TABLE `tbl_kelas` (
  `ID_KELAS` int(11) NOT NULL,
  `ID_JURUSAN` int(11) DEFAULT NULL,
  `NAMA_KELAS` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `tbl_kelas`
--

INSERT INTO `tbl_kelas` (`ID_KELAS`, `ID_JURUSAN`, `NAMA_KELAS`) VALUES
(1, 1, 'XII RPL 2'),
(2, 2, 'XII TKJ 2'),
(3, 3, 'XII MM');

-- --------------------------------------------------------

--
-- Table structure for table `tbl_level`
--

CREATE TABLE `tbl_level` (
  `ID_LEVEL` int(11) NOT NULL,
  `LEVEL` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `tbl_level`
--

INSERT INTO `tbl_level` (`ID_LEVEL`, `LEVEL`) VALUES
(1, 'Admin'),
(2, 'Petugas'),
(3, 'Siswa');

-- --------------------------------------------------------

--
-- Table structure for table `tbl_log`
--

CREATE TABLE `tbl_log` (
  `log_id` int(11) NOT NULL,
  `log_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `log_user` varchar(50) NOT NULL,
  `log_tipe` varchar(50) NOT NULL,
  `log_aksi` varchar(50) NOT NULL,
  `log_assign_to` varchar(50) NOT NULL,
  `log_assign_type` enum('petugas','siswa','spp','kelas','jurusan','transaksi','cetak') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `tbl_log`
--

INSERT INTO `tbl_log` (`log_id`, `log_time`, `log_user`, `log_tipe`, `log_aksi`, `log_assign_to`, `log_assign_type`) VALUES
(9, '2020-02-23 13:07:42', 'Administrator', 'petugas', 'menambah data petugas', '', ''),
(10, '2020-02-23 13:08:06', 'Administrator', 'petugas', 'menambah data petugas', '', ''),
(11, '2020-02-23 13:15:11', 'Administrator', 'petugas', 'Menghapus data petugas', '', ''),
(12, '2020-02-23 13:15:16', 'Administrator', 'petugas', 'Menghapus data petugas', '', ''),
(13, '2020-02-23 13:15:19', 'Administrator', 'petugas', 'Menghapus data petugas', '', ''),
(14, '2020-02-23 13:15:27', 'Administrator', 'petugas', 'Mengedit data petugas', '', ''),
(15, '2020-02-23 14:06:44', 'Administrator', 'jurusan', 'Menambah data jurusan', '', ''),
(16, '2020-02-23 14:07:22', 'Administrator', 'kelas', 'Menambah data kelas', '', ''),
(17, '2020-02-23 14:07:36', 'Administrator', 'kelas', 'Mengedit data kelas', '', ''),
(18, '2020-02-23 14:08:13', 'Administrator', 'spp', 'Menambah data spp', '', ''),
(19, '2020-02-24 12:38:04', 'Administrator', 'pembayaran', 'Menambah data transaksi pembayaran', '', ''),
(20, '2020-02-24 12:44:24', 'Petugas', 'pembayaran', 'Menambah data transaksi pembayaran', '', ''),
(21, '2020-02-25 12:00:19', 'Administrator', 'siswa', 'Mengedit data siswa', '', ''),
(22, '2020-02-26 10:52:37', 'Administrator', 'siswa', 'Menghapus data siswa', '', ''),
(23, '2020-02-26 10:54:51', 'Administrator', 'siswa', 'Menghapus data siswa', '', ''),
(24, '2020-02-26 10:55:23', 'Administrator', 'siswa', 'Menambah data siswa', '', ''),
(25, '2020-02-26 10:56:25', 'Administrator', 'siswa', 'Menghapus data siswa', '', ''),
(26, '2020-02-26 10:58:30', 'Administrator', 'siswa', 'Menambah data siswa', '', ''),
(27, '2020-02-26 11:01:44', 'Administrator', 'siswa', 'Menghapus data siswa', '', ''),
(28, '2020-02-26 11:02:05', 'Administrator', 'siswa', 'Menambah data siswa', '', ''),
(29, '2020-02-26 11:41:33', 'Administrator', 'siswa', 'Menghapus data siswa', '', ''),
(30, '2020-02-26 11:41:37', 'Administrator', 'siswa', 'Menghapus data siswa', '', ''),
(31, '2020-02-26 11:41:41', 'Administrator', 'siswa', 'Menghapus data siswa', '', ''),
(32, '2020-02-26 11:43:40', 'Administrator', 'siswa', 'Menghapus data siswa', '', ''),
(33, '2020-02-26 12:03:14', 'Administrator', 'siswa', 'Menghapus data siswa', '', ''),
(34, '2020-02-26 12:07:03', 'Administrator', 'siswa', 'Menghapus data siswa', '', ''),
(35, '2020-02-26 12:07:53', 'Administrator', 'siswa', 'Menambah data siswa', '', ''),
(36, '2020-02-26 15:22:58', 'Administrator', 'siswa', 'Menghapus data siswa', '', ''),
(37, '2020-02-26 15:23:43', 'Administrator', 'siswa', 'Menambah data siswa', '', ''),
(38, '2020-02-26 15:33:49', 'Administrator', 'siswa', 'Menghapus data siswa', '', ''),
(39, '2020-02-26 15:35:29', 'Administrator', 'siswa', 'Menambah data siswa', '', ''),
(40, '2020-02-26 16:26:12', 'Administrator', 'pembayaran', 'Menambah data transaksi pembayaran', '', ''),
(41, '2020-02-26 16:30:38', 'Administrator', 'pembayaran', 'Menambah data transaksi pembayaran', '', ''),
(42, '2020-02-26 16:36:52', 'Administrator', 'pembayaran', 'Menambah data transaksi pembayaran', '', ''),
(43, '2020-02-26 16:37:34', 'Administrator', 'pembayaran', 'Menghapus data transaksi pembayaran', '', ''),
(44, '2020-02-26 16:39:35', 'Petugas', 'pembayaran', 'Menambah data transaksi pembayaran', '', ''),
(45, '2020-02-26 17:21:22', 'Petugas', 'pembayaran', 'Menambah data transaksi pembayaran', '', ''),
(46, '2020-02-27 12:05:28', 'Administrator', 'pembayaran', 'Menambah data transaksi pembayaran', '', ''),
(47, '2020-02-27 12:05:50', 'Administrator', 'pembayaran', 'Menambah data transaksi pembayaran', '', ''),
(48, '2020-02-27 12:56:21', 'Administrator', 'petugas', 'Merubah password petugas', '', ''),
(49, '2020-02-28 06:53:56', 'Administrator', 'petugas', 'Menghapus data petugas', '', ''),
(50, '2020-02-28 07:16:29', 'Administrator', 'cetak', 'Mencetak laporan data petugas', '', ''),
(51, '2020-02-28 07:29:44', 'Administrator', 'petugas', 'Menambah data petugas', '', ''),
(52, '2020-02-28 07:30:56', 'Administrator', 'petugas', 'Menghapus data petugas', '', ''),
(53, '2020-02-28 07:31:15', 'Administrator', 'petugas', 'Menambah data petugas', '', ''),
(54, '2020-02-28 07:50:13', 'Administrator', 'cetak', 'Mencetak laporan data siswa', '', ''),
(55, '2020-02-28 08:29:01', 'Administrator', 'cetak', 'Mencetak laporan data petugas', '', ''),
(56, '2020-02-28 08:30:11', 'Administrator', 'cetak', 'Mencetak laporan data petugas', '', ''),
(57, '2020-02-28 08:31:13', 'Administrator', 'cetak', 'Mencetak laporan data petugas', '', ''),
(58, '2020-02-28 08:31:34', 'Administrator', 'cetak', 'Mencetak laporan data siswa', '', ''),
(59, '2020-02-28 08:32:08', 'Administrator', 'cetak', 'Mencetak laporan data transaksi pembayaran', '', ''),
(60, '2020-02-28 08:35:07', 'Administrator', 'cetak', 'Mencetak laporan data siswa', '', ''),
(61, '2020-02-28 08:35:20', 'Administrator', 'cetak', 'Mencetak laporan data siswa', '', ''),
(62, '2020-02-28 08:35:34', 'Administrator', 'cetak', 'Mencetak laporan data siswa', '', ''),
(63, '2020-02-28 08:36:10', 'Administrator', 'cetak', 'Mencetak laporan data siswa', '', ''),
(64, '2020-02-28 08:36:21', 'Administrator', 'cetak', 'Mencetak laporan data petugas', '', ''),
(65, '2020-02-28 08:36:37', 'Administrator', 'cetak', 'Mencetak laporan data petugas', '', ''),
(66, '2020-02-28 08:37:18', 'Administrator', 'cetak', 'Mencetak laporan data transaksi pembayaran', '', ''),
(67, '2020-02-28 08:37:33', 'Administrator', 'cetak', 'Mencetak laporan data petugas', '', ''),
(68, '2020-02-28 08:38:12', 'Administrator', 'cetak', 'Mencetak laporan data transaksi pembayaran', '', ''),
(69, '2020-02-28 08:38:18', 'Administrator', 'cetak', 'Mencetak laporan data petugas', '', ''),
(70, '2020-02-28 09:21:03', 'Administrator', 'siswa', 'Menambah data siswa', '', ''),
(71, '2020-02-28 09:21:34', 'Administrator', 'siswa', 'Menghapus data siswa', '', ''),
(72, '2021-02-03 03:36:47', 'Administrator', 'cetak', 'Mencetak Struk pembayaran', '', ''),
(73, '2021-02-03 13:16:38', 'Sri Adi Cahyono', 'cetak', 'Mencetak Struk pembayaran', '', ''),
(74, '2021-02-04 08:54:38', 'Administrator', 'pembayaran', 'Menambah data transaksi pembayaran', '', ''),
(75, '2021-02-04 23:38:14', 'Administrator', 'siswa', 'Mengedit data siswa', '', ''),
(76, '2021-02-09 00:50:40', 'Administrator', 'cetak', 'Mencetak Struk pembayaran', '', ''),
(77, '2021-02-11 07:34:04', 'Administrator', 'spp', 'Menambah data spp', '', ''),
(78, '2021-02-12 02:43:04', 'Administrator', 'jurusan', 'Menambah data jurusan', '', ''),
(79, '2021-02-12 02:45:48', 'Administrator', 'kelas', 'Menambah data kelas', '', ''),
(80, '2021-02-13 11:50:52', 'Administrator', 'spp', 'Menambah data spp', '', ''),
(81, '2021-02-14 11:33:38', 'Administrator', 'petugas', 'Menambah data petugas', '', ''),
(82, '2021-02-17 12:52:24', 'Administrator', 'jurusan', 'Mengedit data jurusan', '', ''),
(83, '2021-02-18 08:07:15', 'Miranti Aprilia', 'siswa', 'Menambah data siswa', '', ''),
(84, '2021-02-18 08:08:26', 'Miranti Aprilia', 'pembayaran', 'Menambah data transaksi pembayaran', '', ''),
(85, '2021-02-18 08:08:39', 'Miranti Aprilia', 'cetak', 'Mencetak Struk pembayaran', '', ''),
(86, '2021-02-19 00:55:58', 'Miranti Aprilia', 'siswa', 'Mengedit data siswa', '', ''),
(87, '2021-02-19 02:16:06', 'Miranti Aprilia', 'siswa', 'Mengedit data siswa', '', ''),
(88, '2021-02-19 03:47:51', 'Miranti Aprilia', 'spp', 'Menambah data spp', '', ''),
(89, '2021-02-26 01:47:34', 'Miranti Aprilia', 'siswa', 'Menambah data siswa', '', ''),
(90, '2021-02-26 01:48:00', 'Miranti Aprilia', 'siswa', 'Mengedit data siswa', '', ''),
(91, '2021-02-26 07:13:43', 'Miranti Aprilia', 'siswa', 'Menambah data siswa', '', ''),
(92, '2021-03-11 11:12:11', 'Miranti Aprilia', 'cetak', 'Mencetak Struk pembayaran', '', ''),
(93, '2021-03-12 07:24:25', 'Miranti', 'cetak', 'Mencetak Struk pembayaran', '', ''),
(94, '2021-03-14 12:50:52', 'Miranti Aprilia', 'pembayaran', 'Menambah data transaksi pembayaran', '', ''),
(95, '2021-03-16 11:57:03', 'Miranti Aprilia', 'petugas', 'Menambah data petugas', '', ''),
(96, '2021-03-16 11:57:13', 'Miranti Aprilia', 'petugas', 'Mengedit data petugas', '', ''),
(97, '2021-03-16 11:57:30', 'Miranti Aprilia', 'petugas', 'Mengedit data petugas', '', ''),
(98, '2021-03-21 04:47:06', 'Miranti Aprilia', 'spp', 'Mengedit data spp', '', ''),
(99, '2021-03-30 08:08:09', 'Administrator', 'petugas', 'Menghapus data petugas', '', ''),
(100, '2021-03-30 08:08:21', 'Administrator', 'siswa', 'Menghapus data siswa', '', ''),
(101, '2021-03-30 08:24:44', 'Administrator', 'siswa', 'Menghapus data siswa', '', ''),
(102, '2021-03-30 08:24:56', 'Administrator', 'cetak', 'Mencetak laporan data petugas', '', ''),
(103, '2021-03-30 08:25:56', 'Administrator', 'cetak', 'Mencetak laporan data petugas', '', ''),
(104, '2021-03-30 08:26:14', 'Administrator', 'cetak', 'Mencetak laporan data petugas', '', ''),
(105, '2021-03-30 08:26:39', 'Administrator', 'cetak', 'Mencetak laporan data petugas', '', ''),
(106, '2021-03-30 08:27:59', 'Administrator', 'cetak', 'Mencetak Struk pembayaran', '', '');

-- --------------------------------------------------------

--
-- Table structure for table `tbl_pembayaran`
--

CREATE TABLE `tbl_pembayaran` (
  `ID_PEMBAYARAN` int(11) NOT NULL,
  `ID_PETUGAS` int(11) DEFAULT NULL,
  `NISN` char(10) DEFAULT NULL,
  `TGL_BAYAR` date DEFAULT NULL,
  `JATUH_TEMPO` date NOT NULL,
  `BULAN_DIBAYAR` varchar(9) DEFAULT NULL,
  `TAHUN_DIBAYAR` varchar(4) DEFAULT NULL,
  `ID_SPP` int(11) NOT NULL,
  `JUMLAH_BAYAR` int(11) NOT NULL,
  `KET` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `tbl_pembayaran`
--

INSERT INTO `tbl_pembayaran` (`ID_PEMBAYARAN`, `ID_PETUGAS`, `NISN`, `TGL_BAYAR`, `JATUH_TEMPO`, `BULAN_DIBAYAR`, `TAHUN_DIBAYAR`, `ID_SPP`, `JUMLAH_BAYAR`, `KET`) VALUES
(104, 18, '1111111111', '2021-02-18', '2017-07-20', 'Juli', '2017', 3, 150000, 'LUNAS'),
(105, 18, '1111111111', '2021-03-14', '2017-08-20', 'Agustus', '2017', 3, 150000, 'LUNAS'),
(106, 18, '1111111111', NULL, '2017-09-20', 'September', '2017', 3, 150000, ''),
(107, 18, '1111111111', NULL, '2017-10-20', 'Oktober', '2017', 3, 150000, ''),
(108, 18, '1111111111', NULL, '2017-11-20', 'November', '2017', 3, 150000, ''),
(109, 18, '1111111111', NULL, '2017-12-20', 'Desember', '2017', 3, 150000, ''),
(110, 18, '1111111111', NULL, '2018-01-20', 'Januari', '2018', 3, 150000, ''),
(111, 18, '1111111111', NULL, '2018-02-20', 'Februari', '2018', 3, 150000, ''),
(112, 18, '1111111111', NULL, '2018-03-20', 'Maret', '2018', 3, 150000, ''),
(113, 18, '1111111111', NULL, '2018-04-20', 'April', '2018', 3, 150000, ''),
(114, 18, '1111111111', NULL, '2018-05-20', 'Mei', '2018', 3, 150000, ''),
(115, 18, '1111111111', NULL, '2018-06-20', 'Juni', '2018', 3, 150000, ''),
(116, 3, '1111111111', NULL, '0000-00-00', NULL, NULL, 1, 0, ''),
(119, 18, '9876543098', NULL, '2021-07-15', 'Juli', '2021', 3, 150000, ''),
(120, 18, '9876543098', NULL, '2021-08-15', 'Agustus', '2021', 3, 150000, ''),
(121, 18, '9876543098', NULL, '2021-09-15', 'September', '2021', 3, 150000, ''),
(122, 18, '9876543098', NULL, '2021-10-15', 'Oktober', '2021', 3, 150000, ''),
(123, 18, '9876543098', NULL, '2021-11-15', 'November', '2021', 3, 150000, ''),
(124, 18, '9876543098', NULL, '2021-12-15', 'Desember', '2021', 3, 150000, ''),
(125, 18, '9876543098', NULL, '2022-01-15', 'Januari', '2022', 3, 150000, ''),
(126, 18, '9876543098', NULL, '2022-02-15', 'Februari', '2022', 3, 150000, ''),
(127, 18, '9876543098', NULL, '2022-03-15', 'Maret', '2022', 3, 150000, ''),
(128, 18, '9876543098', NULL, '2022-04-15', 'April', '2022', 3, 150000, ''),
(129, 18, '9876543098', NULL, '2022-05-15', 'Mei', '2022', 3, 150000, ''),
(130, 18, '9876543098', NULL, '2022-06-15', 'Juni', '2022', 3, 150000, ''),
(131, 18, '9876543098', NULL, '2018-07-27', 'Juli', '2018', 4, 180000, ''),
(132, 18, '9876543098', NULL, '2018-08-27', 'Agustus', '2018', 4, 180000, ''),
(133, 18, '9876543098', NULL, '2018-09-27', 'September', '2018', 4, 180000, ''),
(134, 18, '9876543098', NULL, '2018-10-27', 'Oktober', '2018', 4, 180000, ''),
(135, 18, '9876543098', NULL, '2018-11-27', 'November', '2018', 4, 180000, ''),
(136, 18, '9876543098', NULL, '2018-12-27', 'Desember', '2018', 4, 180000, ''),
(137, 18, '9876543098', NULL, '2019-01-27', 'Januari', '2019', 4, 180000, ''),
(138, 18, '9876543098', NULL, '2019-02-27', 'Februari', '2019', 4, 180000, ''),
(139, 18, '9876543098', NULL, '2019-03-27', 'Maret', '2019', 4, 180000, ''),
(140, 18, '9876543098', NULL, '2019-04-27', 'April', '2019', 4, 180000, ''),
(141, 18, '9876543098', NULL, '2019-05-27', 'Mei', '2019', 4, 180000, ''),
(142, 18, '9876543098', NULL, '2019-06-27', 'Juni', '2019', 4, 180000, '');

-- --------------------------------------------------------

--
-- Table structure for table `tbl_petugas`
--

CREATE TABLE `tbl_petugas` (
  `ID_PETUGAS` int(11) NOT NULL,
  `ID_LEVEL` int(11) DEFAULT NULL,
  `USERNAME` varchar(100) DEFAULT NULL,
  `PASSWORD_PETUGAS` varchar(225) DEFAULT NULL,
  `NAMA_PETUGAS` varchar(50) DEFAULT NULL,
  `DESKRIPSI` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `tbl_petugas`
--

INSERT INTO `tbl_petugas` (`ID_PETUGAS`, `ID_LEVEL`, `USERNAME`, `PASSWORD_PETUGAS`, `NAMA_PETUGAS`, `DESKRIPSI`) VALUES
(1, 1, 'admin', '21232f297a57a5a743894a0e4a801fc3', 'Administrator', 'admin'),
(3, 2, 'petugas', 'b53fe7751b37e40ff34d012c7774d65f', 'Petugas', 'petugas1'),
(18, 1, 'miranti', '81dc9bdb52d04dc20036dbd8313ed055', 'Miranti Aprilia', '1234'),
(19, 2, 'deri', '81dc9bdb52d04dc20036dbd8313ed055', 'Deri', '1234');

-- --------------------------------------------------------

--
-- Table structure for table `tbl_siswa`
--

CREATE TABLE `tbl_siswa` (
  `NISN` char(10) NOT NULL,
  `ID_KELAS` int(11) DEFAULT NULL,
  `ID_SPP` int(11) DEFAULT NULL,
  `NIS` char(8) DEFAULT NULL,
  `NAMA` varchar(100) DEFAULT NULL,
  `ALAMAT` text,
  `NO_TELP` varchar(13) DEFAULT NULL,
  `TIMESTAMP` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `tbl_siswa`
--

INSERT INTO `tbl_siswa` (`NISN`, `ID_KELAS`, `ID_SPP`, `NIS`, `NAMA`, `ALAMAT`, `NO_TELP`, `TIMESTAMP`) VALUES
('1111111111', 3, 3, '22222222', 'Irma Imroana', 'dddddddddddddddd', '097773664444', '2021-02-19 02:16:06'),
('456677788', 1, 4, '87654321', 'Andi', 'Jakarta', '887867665', '2021-02-26 01:47:59'),
('6789034560', 2, 4, '56789061', 'Deni', 'jawa timur', '034567898765', '2021-02-26 07:13:42'),
('777777777', 1, 4, '87654321', 'Andi', 'Jakarta', '097776556', '2021-02-21 02:42:36'),
('9876543098', 2, 3, '34567890', 'Kevin', 'kkkkkkkkkkkkkkkkkkk', '056789321456', '2021-02-26 01:47:33');

-- --------------------------------------------------------

--
-- Table structure for table `tbl_spp`
--

CREATE TABLE `tbl_spp` (
  `ID_SPP` int(11) NOT NULL,
  `TAHUN` varchar(16) DEFAULT NULL,
  `NOMINAL` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `tbl_spp`
--

INSERT INTO `tbl_spp` (`ID_SPP`, `TAHUN`, `NOMINAL`) VALUES
(1, '2018/2019', 135000),
(2, '2018/2019', 170000),
(3, '2020/2021', 150000),
(4, '2020/2021', 180000),
(5, '2003/2005', 170000);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `tbl_jurusan`
--
ALTER TABLE `tbl_jurusan`
  ADD PRIMARY KEY (`ID_JURUSAN`);

--
-- Indexes for table `tbl_kelas`
--
ALTER TABLE `tbl_kelas`
  ADD PRIMARY KEY (`ID_KELAS`),
  ADD KEY `FK_JURUSAN` (`ID_JURUSAN`);

--
-- Indexes for table `tbl_level`
--
ALTER TABLE `tbl_level`
  ADD PRIMARY KEY (`ID_LEVEL`);

--
-- Indexes for table `tbl_log`
--
ALTER TABLE `tbl_log`
  ADD PRIMARY KEY (`log_id`);

--
-- Indexes for table `tbl_pembayaran`
--
ALTER TABLE `tbl_pembayaran`
  ADD PRIMARY KEY (`ID_PEMBAYARAN`),
  ADD KEY `FK_PETUGAS` (`ID_PETUGAS`),
  ADD KEY `FK_SISWA` (`NISN`);

--
-- Indexes for table `tbl_petugas`
--
ALTER TABLE `tbl_petugas`
  ADD PRIMARY KEY (`ID_PETUGAS`),
  ADD KEY `FK_LEVEL` (`ID_LEVEL`);

--
-- Indexes for table `tbl_siswa`
--
ALTER TABLE `tbl_siswa`
  ADD PRIMARY KEY (`NISN`),
  ADD KEY `FK_KELAS` (`ID_KELAS`),
  ADD KEY `FK_SPP` (`ID_SPP`);

--
-- Indexes for table `tbl_spp`
--
ALTER TABLE `tbl_spp`
  ADD PRIMARY KEY (`ID_SPP`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `tbl_jurusan`
--
ALTER TABLE `tbl_jurusan`
  MODIFY `ID_JURUSAN` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `tbl_kelas`
--
ALTER TABLE `tbl_kelas`
  MODIFY `ID_KELAS` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `tbl_level`
--
ALTER TABLE `tbl_level`
  MODIFY `ID_LEVEL` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `tbl_log`
--
ALTER TABLE `tbl_log`
  MODIFY `log_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=107;

--
-- AUTO_INCREMENT for table `tbl_pembayaran`
--
ALTER TABLE `tbl_pembayaran`
  MODIFY `ID_PEMBAYARAN` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=143;

--
-- AUTO_INCREMENT for table `tbl_petugas`
--
ALTER TABLE `tbl_petugas`
  MODIFY `ID_PETUGAS` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- AUTO_INCREMENT for table `tbl_spp`
--
ALTER TABLE `tbl_spp`
  MODIFY `ID_SPP` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `tbl_kelas`
--
ALTER TABLE `tbl_kelas`
  ADD CONSTRAINT `FK_JURUSAN` FOREIGN KEY (`ID_JURUSAN`) REFERENCES `tbl_jurusan` (`ID_JURUSAN`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `tbl_pembayaran`
--
ALTER TABLE `tbl_pembayaran`
  ADD CONSTRAINT `FK_PETUGAS` FOREIGN KEY (`ID_PETUGAS`) REFERENCES `tbl_petugas` (`ID_PETUGAS`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `FK_SISWA` FOREIGN KEY (`NISN`) REFERENCES `tbl_siswa` (`NISN`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `tbl_petugas`
--
ALTER TABLE `tbl_petugas`
  ADD CONSTRAINT `FK_LEVEL` FOREIGN KEY (`ID_LEVEL`) REFERENCES `tbl_level` (`ID_LEVEL`);

--
-- Constraints for table `tbl_siswa`
--
ALTER TABLE `tbl_siswa`
  ADD CONSTRAINT `FK_KELAS` FOREIGN KEY (`ID_KELAS`) REFERENCES `tbl_kelas` (`ID_KELAS`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_SPP` FOREIGN KEY (`ID_SPP`) REFERENCES `tbl_spp` (`ID_SPP`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
