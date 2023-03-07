-- phpMyAdmin SQL Dump
-- version 4.8.5
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Waktu pembuatan: 06 Mar 2023 pada 10.19
-- Versi server: 10.1.38-MariaDB
-- Versi PHP: 5.6.40

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
-- Prosedur
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
-- Struktur dari tabel `tbl_jurusan`
--

CREATE TABLE `tbl_jurusan` (
  `ID_JURUSAN` int(11) NOT NULL,
  `jurusan` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data untuk tabel `tbl_jurusan`
--

INSERT INTO `tbl_jurusan` (`ID_JURUSAN`, `jurusan`) VALUES
(2, 'Teknik Jaringan Dan Komputer'),
(4, 'Agribisnis Tanaman Pangan dan Holtikultura'),
(6, 'Teknik Kendaraan Ringan'),
(13, 'Rekayasa Perangkat Lunak'),
(14, 'Multimedia');

-- --------------------------------------------------------

--
-- Struktur dari tabel `tbl_kelas`
--

CREATE TABLE `tbl_kelas` (
  `ID_KELAS` int(11) NOT NULL,
  `ID_JURUSAN` int(11) DEFAULT NULL,
  `NAMA_KELAS` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data untuk tabel `tbl_kelas`
--

INSERT INTO `tbl_kelas` (`ID_KELAS`, `ID_JURUSAN`, `NAMA_KELAS`) VALUES
(3, 13, 'XII RPL '),
(4, 2, 'XII TKJ '),
(5, 6, 'XII TKR');

-- --------------------------------------------------------

--
-- Struktur dari tabel `tbl_level`
--

CREATE TABLE `tbl_level` (
  `ID_LEVEL` int(11) NOT NULL,
  `LEVEL` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data untuk tabel `tbl_level`
--

INSERT INTO `tbl_level` (`ID_LEVEL`, `LEVEL`) VALUES
(1, 'Admin'),
(2, 'Petugas'),
(3, 'Siswa');

-- --------------------------------------------------------

--
-- Struktur dari tabel `tbl_log`
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
-- Dumping data untuk tabel `tbl_log`
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
(106, '2021-03-30 08:27:59', 'Administrator', 'cetak', 'Mencetak Struk pembayaran', '', ''),
(107, '2021-03-31 01:42:19', 'Administrator', 'petugas', 'Mengedit data petugas', '', ''),
(108, '2021-03-31 01:44:10', 'Administrator', 'petugas', 'Menambah data petugas', '', ''),
(109, '2021-03-31 01:44:38', 'Administrator', 'petugas', 'Merubah password petugas', '', ''),
(110, '2021-03-31 01:45:02', 'Administrator', 'petugas', 'Merubah password petugas', '', ''),
(111, '2021-03-31 01:45:22', 'Administrator', 'petugas', 'Menghapus data petugas', '', ''),
(112, '2021-03-31 01:50:31', 'Administrator', 'petugas', 'Menambah data petugas', '', ''),
(113, '2021-03-31 01:51:02', 'Administrator', 'petugas', 'Merubah password petugas', '', ''),
(114, '2021-03-31 01:58:53', 'Administrator', 'siswa', 'Menambah data siswa', '', ''),
(115, '2021-03-31 02:02:04', 'Administrator', 'pembayaran', 'Menambah data transaksi pembayaran', '', ''),
(116, '2021-03-31 02:05:01', 'Administrator', 'pembayaran', 'Menghapus data transaksi pembayaran', '', ''),
(117, '2021-03-31 02:29:02', 'Administrator', 'siswa', 'Menghapus data siswa', '', ''),
(118, '2021-03-31 02:29:04', 'Administrator', 'siswa', 'Menghapus data siswa', '', ''),
(119, '2021-03-31 02:30:47', 'Administrator', 'siswa', 'Menghapus data siswa', '', ''),
(120, '2021-03-31 02:30:50', 'Administrator', 'siswa', 'Menghapus data siswa', '', ''),
(121, '2021-03-31 02:30:52', 'Administrator', 'siswa', 'Menghapus data siswa', '', ''),
(122, '2021-03-31 02:39:33', 'Administrator', 'siswa', 'Menambah data siswa', '', ''),
(123, '2021-03-31 03:12:44', 'Administrator', 'cetak', 'Mencetak Struk pembayaran', '', ''),
(124, '2021-03-31 03:24:59', 'Administrator', 'cetak', 'Mencetak laporan data petugas', '', ''),
(125, '2021-04-03 04:14:04', 'Administrator', 'petugas', 'Merubah password petugas', '', ''),
(126, '2021-04-03 04:15:02', 'Administrator', 'petugas', 'Merubah password petugas', '', ''),
(127, '2021-04-03 05:10:18', 'Administrator', 'siswa', 'Mengedit data siswa', '', ''),
(128, '2021-04-03 05:14:37', 'Administrator', 'jurusan', 'Mengedit data jurusan', '', ''),
(129, '2021-04-03 05:14:53', 'Administrator', 'jurusan', 'Menambah data jurusan', '', ''),
(130, '2021-04-03 05:16:30', 'Administrator', 'jurusan', 'Menambah data jurusan', '', ''),
(131, '2021-04-03 05:17:02', 'Administrator', 'jurusan', 'Menambah data jurusan', '', ''),
(132, '2021-04-03 05:17:19', 'Administrator', 'jurusan', 'Menambah data jurusan', '', ''),
(133, '2021-04-04 02:55:58', 'Administrator', 'petugas', 'Menambah data petugas', '', ''),
(134, '2021-04-04 03:02:17', 'Administrator', 'siswa', 'Mengedit data siswa', '', ''),
(135, '2021-04-04 03:09:25', 'Administrator', 'siswa', 'Menambah data siswa', '', ''),
(136, '2021-04-04 03:13:01', 'Administrator', 'siswa', 'Menambah data siswa', '', ''),
(137, '2021-04-04 03:22:55', 'Administrator', 'spp', 'Mengedit data spp', '', ''),
(138, '2021-04-04 03:32:53', 'Administrator', 'spp', 'Menambah data spp', '', ''),
(139, '2021-04-04 03:37:28', 'Administrator', 'kelas', 'Mengedit data kelas', '', ''),
(140, '2021-04-04 03:40:26', 'Administrator', 'kelas', 'Menambah data kelas', '', ''),
(141, '2021-04-04 03:46:17', 'Administrator', 'jurusan', 'Menghapus data jurusan', '', ''),
(142, '2021-04-04 03:46:54', 'Administrator', 'jurusan', 'Mengedit data jurusan', '', ''),
(143, '2021-04-04 03:47:30', 'Administrator', 'jurusan', 'Mengedit data jurusan', '', ''),
(144, '2021-04-04 03:48:41', 'Administrator', 'jurusan', 'Menambah data jurusan', '', ''),
(145, '2021-04-04 04:41:10', 'Administrator', 'pembayaran', 'Menambah data transaksi pembayaran', '', ''),
(146, '2021-04-04 04:41:23', 'Administrator', 'cetak', 'Mencetak Struk pembayaran', '', ''),
(147, '2021-04-04 09:20:38', 'Administrator', 'cetak', 'Mencetak laporan data petugas', '', ''),
(148, '2021-04-04 09:28:27', 'Administrator', 'cetak', 'Mencetak laporan data transaksi pembayaran', '', ''),
(149, '2021-04-05 13:23:12', 'Administrator', 'cetak', 'Mencetak Struk pembayaran', '', ''),
(150, '2021-04-05 13:31:41', 'Administrator', 'siswa', 'Menghapus data siswa', '', ''),
(151, '2021-04-05 13:48:51', 'Administrator', 'cetak', 'Mencetak laporan data petugas', '', ''),
(152, '2021-04-06 03:55:55', 'Administrator', 'jurusan', 'Menambah data jurusan', '', ''),
(153, '2021-04-06 03:56:00', 'Administrator', 'jurusan', 'Menghapus data jurusan', '', ''),
(154, '2021-04-06 05:17:59', 'Administrator', 'jurusan', 'Menambah data jurusan', '', ''),
(155, '2021-04-06 05:19:07', 'Administrator', 'jurusan', 'Menghapus data jurusan', '', ''),
(156, '2021-04-06 07:24:12', 'Administrator', 'jurusan', 'Menambah data jurusan', '', ''),
(157, '2021-04-07 06:54:55', 'Administrator', 'pembayaran', 'Menambah data transaksi pembayaran', '', ''),
(158, '2021-04-07 06:55:38', 'Administrator', 'cetak', 'Mencetak Struk pembayaran', '', ''),
(159, '2021-04-07 06:57:29', 'Administrator', 'kelas', 'Menghapus data kelas', '', ''),
(160, '2021-04-07 07:39:13', 'Administrator', 'cetak', 'Mencetak laporan data petugas', '', ''),
(161, '2021-04-07 08:05:38', 'Administrator', 'siswa', 'Menambah data siswa', '', ''),
(162, '2021-04-07 08:05:59', 'Administrator', 'siswa', 'Menghapus data siswa', '', ''),
(163, '2021-04-07 08:06:56', 'Administrator', 'siswa', 'Menambah data siswa', '', ''),
(164, '2021-04-07 08:07:09', 'Administrator', 'siswa', 'Menghapus data siswa', '', ''),
(165, '2021-04-07 08:07:51', 'Administrator', 'siswa', 'Menambah data siswa', '', ''),
(166, '2021-04-07 08:08:21', 'Administrator', 'siswa', 'Menghapus data siswa', '', ''),
(167, '2021-04-07 08:30:28', 'Administrator', 'pembayaran', 'Menambah data transaksi pembayaran', '', ''),
(168, '2021-04-07 08:30:35', 'Administrator', 'cetak', 'Mencetak Struk pembayaran', '', ''),
(169, '2021-04-07 08:30:46', 'Administrator', 'pembayaran', 'Menghapus data transaksi pembayaran', '', ''),
(170, '2021-04-08 01:07:05', 'Administrator', 'siswa', 'Mengedit data siswa', '', ''),
(171, '2021-04-08 01:08:10', 'Administrator', 'siswa', 'Mengedit data siswa', '', ''),
(172, '2021-04-08 01:10:56', 'Administrator', 'kelas', 'Menambah data kelas', '', ''),
(173, '2021-04-08 01:11:09', 'Administrator', 'kelas', 'Mengedit data kelas', '', ''),
(174, '2021-04-08 01:11:22', 'Administrator', 'kelas', 'Mengedit data kelas', '', ''),
(175, '2021-04-08 01:11:34', 'Administrator', 'kelas', 'Mengedit data kelas', '', ''),
(176, '2021-04-08 01:12:14', 'Administrator', 'kelas', 'Menambah data kelas', '', ''),
(177, '2021-04-08 01:12:28', 'Administrator', 'kelas', 'Menambah data kelas', '', ''),
(178, '2021-04-08 01:13:03', 'Administrator', 'siswa', 'Mengedit data siswa', '', ''),
(179, '2021-04-08 01:14:57', 'Administrator', 'siswa', 'Menambah data siswa', '', ''),
(180, '2021-04-08 01:16:59', 'Administrator', 'siswa', 'Menambah data siswa', '', ''),
(181, '2021-04-08 01:17:18', 'Administrator', 'kelas', 'Menghapus data kelas', '', ''),
(182, '2021-04-08 01:18:25', 'Administrator', 'spp', 'Mengedit data spp', '', ''),
(183, '2021-04-08 01:18:47', 'Administrator', 'spp', 'Mengedit data spp', '', ''),
(184, '2021-04-08 01:19:18', 'Administrator', 'spp', 'Menghapus data spp', '', ''),
(185, '2021-04-08 01:19:33', 'Administrator', 'spp', 'Menghapus data spp', '', ''),
(186, '2021-04-08 01:19:48', 'Administrator', 'spp', 'Mengedit data spp', '', ''),
(187, '2021-04-08 01:20:01', 'Administrator', 'spp', 'Mengedit data spp', '', ''),
(188, '2021-04-08 01:23:42', 'Administrator', 'spp', 'Menambah data spp', '', ''),
(189, '2021-04-08 01:24:08', 'Administrator', 'spp', 'Mengedit data spp', '', ''),
(190, '2021-04-08 01:24:43', 'Administrator', 'spp', 'Mengedit data spp', '', ''),
(191, '2021-04-08 01:24:56', 'Administrator', 'spp', 'Mengedit data spp', '', ''),
(192, '2021-04-08 01:25:10', 'Administrator', 'spp', 'Mengedit data spp', '', ''),
(193, '2021-04-08 01:25:39', 'Administrator', 'jurusan', 'Menghapus data jurusan', '', ''),
(194, '2021-04-08 01:30:49', 'Administrator', 'petugas', 'Mengedit data petugas', '', ''),
(195, '2021-04-08 01:31:24', 'Administrator', 'petugas', 'Mengedit data petugas', '', ''),
(196, '2021-04-08 01:32:01', 'Administrator', 'petugas', 'Mengedit data petugas', '', ''),
(197, '2021-04-08 01:35:25', 'Administrator', 'pembayaran', 'Menghapus data transaksi pembayaran', '', ''),
(198, '2021-04-08 01:39:03', 'Administrator', 'siswa', 'Mengedit data siswa', '', ''),
(199, '2021-04-08 01:39:37', 'Administrator', 'pembayaran', 'Menambah data transaksi pembayaran', '', ''),
(200, '2021-04-08 01:39:39', 'Administrator', 'pembayaran', 'Menambah data transaksi pembayaran', '', ''),
(201, '2021-04-08 01:39:42', 'Administrator', 'pembayaran', 'Menambah data transaksi pembayaran', '', ''),
(202, '2021-04-08 01:39:49', 'Administrator', 'pembayaran', 'Menambah data transaksi pembayaran', '', ''),
(203, '2021-04-08 01:40:34', 'Administrator', 'pembayaran', 'Menambah data transaksi pembayaran', '', ''),
(204, '2021-04-08 01:40:37', 'Administrator', 'pembayaran', 'Menambah data transaksi pembayaran', '', ''),
(205, '2021-04-09 01:43:56', 'Administrator', 'petugas', 'Menambah data petugas', '', ''),
(206, '2021-04-09 03:40:01', 'Administrator', 'spp', 'Mengedit data spp', '', ''),
(207, '2021-04-09 03:40:15', 'Administrator', 'spp', 'Mengedit data spp', '', ''),
(208, '2021-04-09 03:40:27', 'Administrator', 'spp', 'Mengedit data spp', '', ''),
(209, '2021-04-09 03:40:38', 'Administrator', 'spp', 'Mengedit data spp', '', ''),
(210, '2021-04-09 03:41:10', 'Administrator', 'spp', 'Mengedit data spp', '', ''),
(211, '2023-01-25 10:59:42', 'Administrator', 'petugas', 'Menghapus data petugas', '', ''),
(212, '2023-01-25 11:00:10', 'Administrator', 'petugas', 'Menghapus data petugas', '', ''),
(213, '2023-01-25 11:27:35', 'Administrator', 'petugas', 'Mengedit data petugas', '', ''),
(214, '2023-01-25 11:28:07', 'Administrator', 'petugas', 'Mengedit data petugas', '', ''),
(215, '2023-01-25 11:38:37', 'Administrator', 'petugas', 'Menambah data petugas', '', ''),
(216, '2023-01-25 11:39:36', 'Administrator', 'siswa', 'Mengedit data siswa', '', ''),
(217, '2023-01-25 11:40:21', 'Administrator', 'spp', 'Mengedit data spp', '', ''),
(218, '2023-01-25 11:40:52', 'Administrator', 'kelas', 'Mengedit data kelas', '', ''),
(219, '2023-01-25 11:41:26', 'Administrator', 'jurusan', 'Mengedit data jurusan', '', ''),
(220, '2023-01-25 11:41:46', 'Administrator', 'jurusan', 'Mengedit data jurusan', '', ''),
(221, '2023-01-27 06:13:56', 'Administrator', 'siswa', 'Mengedit data siswa', '', ''),
(222, '2023-01-27 06:14:20', 'Administrator', 'siswa', 'Mengedit data siswa', '', ''),
(223, '2023-01-27 06:14:44', 'Administrator', 'siswa', 'Mengedit data siswa', '', ''),
(224, '2023-01-27 06:15:02', 'Administrator', 'siswa', 'Mengedit data siswa', '', ''),
(225, '2023-01-30 05:01:52', 'Administrator', 'kelas', 'Mengedit data kelas', '', ''),
(226, '2023-01-30 05:02:37', 'Administrator', 'kelas', 'Menambah data kelas', '', ''),
(227, '2023-01-30 07:00:33', 'Administrator', 'siswa', 'Menghapus data siswa', '', ''),
(228, '2023-01-30 07:00:51', 'Administrator', 'siswa', 'Mengedit data siswa', '', ''),
(229, '2023-01-30 07:01:26', 'Administrator', 'siswa', 'Mengedit data siswa', '', ''),
(230, '2023-01-30 07:02:07', 'Administrator', 'spp', 'Mengedit data spp', '', ''),
(231, '2023-02-01 07:17:40', 'Administrator', 'cetak', 'Mencetak laporan data petugas', '', ''),
(232, '2023-02-01 07:20:26', 'Administrator', 'cetak', 'Mencetak laporan data petugas', '', ''),
(233, '2023-02-01 07:22:53', 'Administrator', 'cetak', 'Mencetak laporan data petugas', '', ''),
(234, '2023-02-01 07:29:24', 'Administrator', 'cetak', 'Mencetak laporan data petugas', '', ''),
(235, '2023-02-01 07:31:53', 'Administrator', 'cetak', 'Mencetak laporan data petugas', '', ''),
(236, '2023-02-01 07:40:57', 'Administrator', 'petugas', 'Menghapus data petugas', '', ''),
(237, '2023-02-01 07:41:12', 'Administrator', 'siswa', 'Menghapus data siswa', '', ''),
(238, '2023-02-01 07:41:35', 'Administrator', 'siswa', 'Mengedit data siswa', '', ''),
(239, '2023-02-01 08:05:59', 'Administrator', 'cetak', 'Mencetak laporan data petugas', '', ''),
(240, '2023-02-03 00:54:24', 'Administrator', 'cetak', 'Mencetak laporan data petugas', '', ''),
(241, '2023-02-03 00:54:34', 'Administrator', 'cetak', 'Mencetak laporan data petugas', '', ''),
(242, '2023-02-03 00:54:36', 'Administrator', 'cetak', 'Mencetak laporan data petugas', '', ''),
(243, '2023-02-03 00:54:39', 'Administrator', 'cetak', 'Mencetak laporan data petugas', '', ''),
(244, '2023-02-03 00:57:04', 'Administrator', 'pembayaran', 'Menambah data transaksi pembayaran', '', ''),
(245, '2023-02-03 00:57:12', 'Administrator', 'pembayaran', 'Menambah data transaksi pembayaran', '', ''),
(246, '2023-02-03 00:58:32', 'Administrator', 'pembayaran', 'Menambah data transaksi pembayaran', '', ''),
(247, '2023-02-03 00:58:49', 'Administrator', 'pembayaran', 'Menghapus data transaksi pembayaran', '', ''),
(248, '2023-02-03 00:58:54', 'Administrator', 'pembayaran', 'Menambah data transaksi pembayaran', '', ''),
(249, '2023-02-03 00:58:56', 'Administrator', 'cetak', 'Mencetak Struk pembayaran', '', ''),
(250, '2023-02-03 01:24:13', 'Administrator', 'spp', 'Menambah data spp', '', ''),
(251, '2023-02-03 01:25:02', 'Administrator', 'spp', 'Mengedit data spp', '', ''),
(252, '2023-02-03 01:25:25', 'Administrator', 'spp', 'Menghapus data spp', '', ''),
(253, '2023-02-03 02:05:55', 'Administrator', 'cetak', 'Mencetak laporan data petugas', '', ''),
(254, '2023-02-03 02:11:48', 'Administrator', 'jurusan', 'Menambah data jurusan', '', ''),
(255, '2023-02-03 02:11:58', 'Administrator', 'jurusan', 'Menghapus data jurusan', '', ''),
(256, '2023-02-03 07:44:37', 'Administrator', 'pembayaran', 'Menambah data transaksi pembayaran', '', ''),
(257, '2023-02-06 04:32:53', 'Administrator', 'cetak', 'Mencetak laporan data petugas', '', ''),
(258, '2023-02-06 05:35:42', 'Administrator', 'cetak', 'Mencetak laporan data petugas', '', ''),
(259, '2023-02-06 06:03:05', 'Administrator', 'cetak', 'Mencetak laporan data petugas', '', ''),
(260, '2023-02-06 07:10:50', 'Administrator', 'cetak', 'Mencetak laporan data petugas', '', ''),
(261, '2023-02-06 07:16:45', 'Administrator', 'cetak', 'Mencetak Struk pembayaran', '', ''),
(262, '2023-02-06 07:16:52', 'Administrator', 'cetak', 'Mencetak laporan data petugas', '', ''),
(263, '2023-02-06 07:18:04', 'Administrator', 'cetak', 'Mencetak Struk pembayaran', '', ''),
(264, '2023-02-08 00:11:55', 'Administrator', 'cetak', 'Mencetak laporan data petugas', '', ''),
(265, '2023-02-08 00:53:15', 'Administrator', 'spp', 'Menghapus data spp', '', ''),
(266, '2023-02-08 00:53:22', 'Administrator', 'spp', 'Menghapus data spp', '', ''),
(267, '2023-02-08 00:53:46', 'Administrator', 'spp', 'Menambah data spp', '', ''),
(268, '2023-02-08 00:54:08', 'Administrator', 'spp', 'Mengedit data spp', '', ''),
(269, '2023-02-08 00:54:18', 'Administrator', 'spp', 'Menghapus data spp', '', ''),
(270, '2023-02-08 00:55:17', 'Administrator', 'spp', 'Mengedit data spp', '', ''),
(271, '2023-02-08 00:55:47', 'Administrator', 'kelas', 'Mengedit data kelas', '', ''),
(272, '2023-02-08 00:55:53', 'Administrator', 'kelas', 'Menghapus data kelas', '', ''),
(273, '2023-02-08 00:56:00', 'Administrator', 'kelas', 'Mengedit data kelas', '', ''),
(274, '2023-02-08 00:56:04', 'Administrator', 'kelas', 'Menghapus data kelas', '', ''),
(275, '2023-02-08 00:56:11', 'Administrator', 'kelas', 'Mengedit data kelas', '', ''),
(276, '2023-02-08 00:56:15', 'Administrator', 'kelas', 'Menghapus data kelas', '', ''),
(277, '2023-02-08 00:57:24', 'Administrator', 'spp', 'Mengedit data spp', '', ''),
(278, '2023-02-08 00:57:44', 'Administrator', 'kelas', 'Mengedit data kelas', '', ''),
(279, '2023-02-08 00:57:50', 'Administrator', 'kelas', 'Mengedit data kelas', '', ''),
(280, '2023-02-08 00:57:57', 'Administrator', 'kelas', 'Mengedit data kelas', '', ''),
(281, '2023-02-08 01:00:32', 'Administrator', 'siswa', 'Menambah data siswa', '', ''),
(282, '2023-02-08 01:02:10', 'Administrator', 'siswa', 'Menambah data siswa', '', ''),
(283, '2023-02-08 01:04:11', 'Administrator', 'siswa', 'Menambah data siswa', '', ''),
(284, '2023-02-08 01:05:37', 'Administrator', 'pembayaran', 'Menambah data transaksi pembayaran', '', ''),
(285, '2023-02-08 01:05:40', 'Administrator', 'pembayaran', 'Menambah data transaksi pembayaran', '', ''),
(286, '2023-02-08 01:05:42', 'Administrator', 'pembayaran', 'Menambah data transaksi pembayaran', '', ''),
(287, '2023-02-08 01:05:44', 'Administrator', 'pembayaran', 'Menambah data transaksi pembayaran', '', ''),
(288, '2023-02-08 01:11:29', 'Administrator', 'petugas', 'Menghapus data petugas', '', ''),
(289, '2023-02-08 01:11:31', 'Administrator', 'petugas', 'Menghapus data petugas', '', ''),
(290, '2023-02-08 01:12:11', 'Administrator', 'petugas', 'Menambah data petugas', '', ''),
(291, '2023-02-10 01:15:30', 'Administrator', 'pembayaran', 'Menambah data transaksi pembayaran', '', ''),
(292, '2023-02-10 01:15:35', 'Administrator', 'cetak', 'Mencetak Struk pembayaran', '', ''),
(293, '2023-02-10 01:16:09', 'Administrator', 'cetak', 'Mencetak laporan data transaksi pembayaran', '', ''),
(294, '2023-02-10 01:16:56', 'Administrator', 'cetak', 'Mencetak laporan data transaksi pembayaran', '', ''),
(295, '2023-02-10 01:29:59', 'Administrator', 'cetak', 'Mencetak Struk pembayaran', '', ''),
(296, '2023-02-10 01:35:24', 'Administrator', 'cetak', 'Mencetak laporan data transaksi pembayaran', '', ''),
(297, '2023-02-10 01:36:26', 'Administrator', 'cetak', 'Mencetak laporan data transaksi pembayaran', '', ''),
(298, '2023-02-10 01:36:59', 'Administrator', 'cetak', 'Mencetak laporan data transaksi pembayaran', '', ''),
(299, '2023-02-10 01:38:15', 'Administrator', 'cetak', 'Mencetak laporan data transaksi pembayaran', '', ''),
(300, '2023-02-10 01:38:30', 'Administrator', 'cetak', 'Mencetak Struk pembayaran', '', ''),
(301, '2023-02-10 01:38:41', 'Administrator', 'cetak', 'Mencetak laporan data petugas', '', ''),
(302, '2023-02-10 01:38:53', 'Administrator', 'cetak', 'Mencetak laporan data transaksi pembayaran', '', ''),
(303, '2023-02-13 04:49:51', 'Administrator', 'siswa', 'Mengedit data siswa', '', ''),
(304, '2023-02-13 04:59:31', 'Umi Kulsum', 'pembayaran', 'Menambah data transaksi pembayaran', '', ''),
(305, '2023-02-13 04:59:34', 'Umi Kulsum', 'cetak', 'Mencetak Struk pembayaran', '', ''),
(306, '2023-02-13 09:21:05', 'Administrator', 'cetak', 'Mencetak laporan data transaksi pembayaran', '', ''),
(307, '2023-02-15 06:40:01', 'Administrator', 'cetak', 'Mencetak laporan data petugas', '', ''),
(308, '2023-02-22 00:11:46', 'Administrator', 'petugas', 'Merubah password petugas', '', ''),
(309, '2023-02-22 00:12:56', 'Administrator', 'cetak', 'Mencetak laporan data petugas', '', ''),
(310, '2023-02-22 00:14:03', 'Administrator', 'cetak', 'Mencetak Struk pembayaran', '', ''),
(311, '2023-02-22 01:20:25', 'Administrator', 'petugas', 'Menambah data petugas', '', ''),
(312, '2023-02-22 01:22:02', 'Administrator', 'petugas', 'Menghapus data petugas', '', ''),
(313, '2023-02-22 01:53:30', 'Administrator', 'siswa', 'Menambah data siswa', '', ''),
(314, '2023-02-22 01:53:37', 'Administrator', 'siswa', 'Menghapus data siswa', '', ''),
(315, '2023-02-22 02:14:18', 'Administrator', 'cetak', 'Mencetak laporan data petugas', '', ''),
(316, '2023-02-22 02:27:54', 'Administrator', 'cetak', 'Mencetak Struk pembayaran', '', ''),
(317, '2023-02-22 04:52:39', 'Administrator', 'cetak', 'Mencetak laporan data petugas', '', ''),
(318, '2023-02-24 00:23:58', 'Administrator', 'petugas', 'Menambah data petugas', '', ''),
(319, '2023-02-25 07:23:57', 'Administrator', 'spp', 'Menghapus data spp', '', ''),
(320, '2023-02-25 07:53:27', 'Administrator', 'jurusan', 'Menghapus data jurusan', '', ''),
(321, '2023-02-25 08:15:23', 'Administrator', 'jurusan', 'Menghapus data jurusan', '', ''),
(322, '2023-02-27 07:31:43', 'Administrator', 'jurusan', 'Menghapus data jurusan', '', ''),
(323, '2023-02-27 07:40:33', 'Administrator', 'jurusan', 'Menambah data jurusan', '', ''),
(324, '2023-02-27 07:41:45', 'Administrator', 'jurusan', 'Menambah data jurusan', '', ''),
(325, '2023-02-27 07:41:56', 'Administrator', 'jurusan', 'Menghapus data jurusan', '', ''),
(326, '2023-02-27 07:41:59', 'Administrator', 'jurusan', 'Menambah data jurusan', '', ''),
(327, '2023-02-27 07:42:02', 'Administrator', 'jurusan', 'Menghapus data jurusan', '', ''),
(328, '2023-02-27 07:42:03', 'Administrator', 'jurusan', 'Menghapus data jurusan', '', ''),
(329, '2023-02-27 07:43:37', 'Administrator', 'jurusan', 'Menambah data jurusan', '', ''),
(330, '2023-02-27 07:43:43', 'Administrator', 'jurusan', 'Menambah data jurusan', '', ''),
(331, '2023-02-27 07:43:46', 'Administrator', 'jurusan', 'Menghapus data jurusan', '', ''),
(332, '2023-02-27 07:43:49', 'Administrator', 'jurusan', 'Menghapus data jurusan', '', ''),
(333, '2023-02-27 07:50:16', 'Administrator', 'jurusan', 'Menambah data jurusan', '', ''),
(334, '2023-02-27 07:50:52', 'Administrator', 'jurusan', 'Menambah data jurusan', '', ''),
(335, '2023-02-27 07:55:07', 'Administrator', 'jurusan', 'Menghapus data jurusan', '', ''),
(336, '2023-02-27 07:55:17', 'Administrator', 'jurusan', 'Menghapus data jurusan', '', ''),
(337, '2023-03-01 00:13:19', 'Administrator', 'siswa', 'Menambah data siswa', '', ''),
(338, '2023-03-01 00:23:50', 'Administrator', 'kelas', 'Menambah data kelas', '', ''),
(339, '2023-03-01 00:23:59', 'Administrator', 'kelas', 'Mengedit data kelas', '', ''),
(340, '2023-03-01 00:24:19', 'Administrator', 'siswa', 'Mengedit data siswa', '', ''),
(341, '2023-03-01 00:25:25', 'Administrator', 'siswa', 'Menambah data siswa', '', ''),
(342, '2023-03-01 00:25:52', 'Administrator', 'jurusan', 'Menambah data jurusan', '', ''),
(343, '2023-03-01 00:26:08', 'Administrator', 'jurusan', 'Menghapus data jurusan', '', ''),
(344, '2023-03-01 08:02:22', 'Administrator', 'petugas', 'Menambah data petugas', '', ''),
(345, '2023-03-01 08:02:29', 'Administrator', 'petugas', 'Mengedit data petugas', '', ''),
(346, '2023-03-01 08:03:37', 'Administrator', 'spp', 'Menambah data spp', '', ''),
(347, '2023-03-01 08:03:41', 'Administrator', 'spp', 'Menghapus data spp', '', ''),
(348, '2023-03-01 08:14:04', 'Administrator', 'siswa', 'Menghapus data siswa', '', ''),
(349, '2023-03-01 08:14:13', 'Administrator', 'spp', 'Menghapus data spp', '', ''),
(350, '2023-03-01 08:14:33', 'Administrator', 'spp', 'Menambah data spp', '', ''),
(351, '2023-03-01 08:15:40', 'Administrator', 'siswa', 'Menambah data siswa', '', ''),
(352, '2023-03-01 08:15:56', 'Administrator', 'kelas', 'Menghapus data kelas', '', ''),
(353, '2023-03-01 08:16:04', 'Administrator', 'kelas', 'Menambah data kelas', '', ''),
(354, '2023-03-01 08:16:21', 'Administrator', 'jurusan', 'Menambah data jurusan', '', ''),
(355, '2023-03-01 08:16:30', 'Administrator', 'jurusan', 'Menghapus data jurusan', '', ''),
(356, '2023-03-03 00:14:39', 'Administrator', 'petugas', 'Menghapus data petugas', '', ''),
(357, '2023-03-03 00:15:22', 'Administrator', 'petugas', 'Menambah data petugas', '', ''),
(358, '2023-03-03 01:41:40', 'Administrator', 'petugas', 'Menghapus data petugas', '', ''),
(359, '2023-03-03 01:41:47', 'Administrator', 'petugas', 'Menghapus data petugas', '', ''),
(360, '2023-03-03 01:42:13', 'Administrator', 'petugas', 'Menambah data petugas', '', ''),
(361, '2023-03-03 01:42:42', 'Administrator', 'jurusan', 'Menambah data jurusan', '', ''),
(362, '2023-03-03 01:42:52', 'Administrator', 'kelas', 'Menambah data kelas', '', ''),
(363, '2023-03-03 01:43:11', 'Administrator', 'spp', 'Menambah data spp', '', ''),
(364, '2023-03-03 01:43:45', 'Administrator', 'siswa', 'Menambah data siswa', '', ''),
(365, '2023-03-03 01:44:16', 'Administrator', 'petugas', 'Menambah data petugas', '', ''),
(366, '2023-03-03 01:44:28', 'Administrator', 'petugas', 'Menghapus data petugas', '', ''),
(367, '2023-03-03 01:47:28', 'Administrator', 'siswa', 'Menghapus data siswa', '', ''),
(368, '2023-03-03 01:47:34', 'Administrator', 'spp', 'Menghapus data spp', '', ''),
(369, '2023-03-03 01:47:42', 'Administrator', 'kelas', 'Menghapus data kelas', '', ''),
(370, '2023-03-03 01:47:56', 'Administrator', 'jurusan', 'Menghapus data jurusan', '', ''),
(371, '2023-03-03 01:48:39', 'Administrator', 'siswa', 'Menambah data siswa', '', ''),
(372, '2023-03-03 01:48:58', 'Administrator', 'pembayaran', 'Menambah data transaksi pembayaran', '', ''),
(373, '2023-03-03 01:49:03', 'Administrator', 'pembayaran', 'Menambah data transaksi pembayaran', '', ''),
(374, '2023-03-03 01:49:07', 'Administrator', 'cetak', 'Mencetak Struk pembayaran', '', ''),
(375, '2023-03-03 01:49:18', 'Administrator', 'cetak', 'Mencetak Struk pembayaran', '', ''),
(376, '2023-03-03 01:49:21', 'Administrator', 'cetak', 'Mencetak Struk pembayaran', '', ''),
(377, '2023-03-03 01:49:39', 'Administrator', 'cetak', 'Mencetak laporan data petugas', '', ''),
(378, '2023-03-03 01:49:49', 'Administrator', 'cetak', 'Mencetak laporan data transaksi pembayaran', '', ''),
(379, '2023-03-03 03:54:52', 'Administrator', 'pembayaran', 'Menambah data transaksi pembayaran', '', ''),
(380, '2023-03-03 03:55:35', 'Administrator', 'cetak', 'Mencetak laporan data petugas', '', ''),
(381, '2023-03-06 04:38:18', 'Administrator', 'petugas', 'Mengedit data petugas', '', ''),
(382, '2023-03-06 04:38:49', 'Administrator', 'petugas', 'Merubah password petugas', '', ''),
(383, '2023-03-06 05:36:17', 'Umi Kulsum', 'cetak', 'Mencetak laporan data petugas', '', ''),
(384, '2023-03-06 05:39:27', 'petugas', 'cetak', 'Mencetak laporan data petugas', '', ''),
(385, '2023-03-06 05:42:08', 'Administrator', 'petugas', 'Menambah data petugas', '', ''),
(386, '2023-03-06 05:42:21', 'Administrator', 'petugas', 'Menghapus data petugas', '', ''),
(387, '2023-03-06 06:27:17', 'Administrator', 'petugas', 'Menambah data petugas', '', ''),
(388, '2023-03-06 06:52:54', 'Administrator', 'petugas', 'Menghapus data petugas', '', ''),
(389, '2023-03-06 06:58:29', 'Administrator', 'petugas', 'Menambah data petugas', '', ''),
(390, '2023-03-06 07:14:36', 'Administrator', 'spp', 'Menambah data spp', '', ''),
(391, '2023-03-06 07:20:04', 'Administrator', 'kelas', 'Menambah data kelas', '', ''),
(392, '2023-03-06 07:26:19', 'Administrator', 'jurusan', 'Menambah data jurusan', '', ''),
(393, '2023-03-06 07:30:03', 'Administrator', 'pembayaran', 'Menambah data transaksi pembayaran', '', ''),
(394, '2023-03-06 07:32:05', 'Administrator', 'cetak', 'Mencetak Struk pembayaran', '', ''),
(395, '2023-03-06 07:35:21', 'Administrator', 'cetak', 'Mencetak laporan data petugas', '', ''),
(396, '2023-03-06 07:38:20', 'Administrator', 'cetak', 'Mencetak laporan data transaksi pembayaran', '', '');

-- --------------------------------------------------------

--
-- Struktur dari tabel `tbl_pembayaran`
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
-- Dumping data untuk tabel `tbl_pembayaran`
--

INSERT INTO `tbl_pembayaran` (`ID_PEMBAYARAN`, `ID_PETUGAS`, `NISN`, `TGL_BAYAR`, `JATUH_TEMPO`, `BULAN_DIBAYAR`, `TAHUN_DIBAYAR`, `ID_SPP`, `JUMLAH_BAYAR`, `KET`) VALUES
(1, 1, '1234567890', '2023-03-03', '2017-08-20', 'Agustus', '2017', 8, 150000, 'LUNAS'),
(2, 1, '1234567890', '2023-03-03', '2017-09-20', 'September', '2017', 8, 150000, 'LUNAS'),
(3, 1, '1234567890', '2023-03-06', '2017-10-20', 'Oktober', '2017', 8, 150000, 'LUNAS'),
(4, 1, '1234567890', NULL, '2017-11-20', 'November', '2017', 8, 150000, ''),
(5, 1, '1234567890', NULL, '2017-12-20', 'Desember', '2017', 8, 150000, ''),
(6, 1, '1234567890', NULL, '2018-01-20', 'Januari', '2018', 8, 150000, ''),
(7, 1, '1234567890', NULL, '2018-02-20', 'Februari', '2018', 8, 150000, ''),
(8, 1, '1234567890', NULL, '2018-03-20', 'Maret', '2018', 8, 150000, ''),
(9, 1, '1234567890', NULL, '2018-04-20', 'April', '2018', 8, 150000, ''),
(10, 1, '1234567890', NULL, '2018-05-20', 'Mei', '2018', 8, 150000, ''),
(11, 1, '1234567890', NULL, '2018-06-20', 'Juni', '2018', 8, 150000, ''),
(12, 1, '1234567890', NULL, '2018-07-20', 'Juli', '2018', 8, 150000, ''),
(25, 1, '0987654321', '2023-03-03', '2017-09-22', 'September', '2017', 10, 150000, 'LUNAS'),
(26, 1, '0987654321', NULL, '2017-10-22', 'Oktober', '2017', 10, 150000, ''),
(27, 1, '0987654321', NULL, '2017-11-22', 'November', '2017', 10, 150000, ''),
(28, 1, '0987654321', NULL, '2017-12-22', 'Desember', '2017', 10, 150000, ''),
(29, 1, '0987654321', NULL, '2018-01-22', 'Januari', '2018', 10, 150000, ''),
(30, 1, '0987654321', NULL, '2018-02-22', 'Februari', '2018', 10, 150000, ''),
(31, 1, '0987654321', NULL, '2018-03-22', 'Maret', '2018', 10, 150000, ''),
(32, 1, '0987654321', NULL, '2018-04-22', 'April', '2018', 10, 150000, ''),
(33, 1, '0987654321', NULL, '2018-05-22', 'Mei', '2018', 10, 150000, ''),
(34, 1, '0987654321', NULL, '2018-06-22', 'Juni', '2018', 10, 150000, ''),
(35, 1, '0987654321', NULL, '2018-07-22', 'Juli', '2018', 10, 150000, ''),
(36, 1, '0987654321', NULL, '2018-08-22', 'Agustus', '2018', 10, 150000, '');

-- --------------------------------------------------------

--
-- Struktur dari tabel `tbl_petugas`
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
-- Dumping data untuk tabel `tbl_petugas`
--

INSERT INTO `tbl_petugas` (`ID_PETUGAS`, `ID_LEVEL`, `USERNAME`, `PASSWORD_PETUGAS`, `NAMA_PETUGAS`, `DESKRIPSI`) VALUES
(1, 1, 'admin', '0c56cfffc19f0770c9095d3993fb6a88', 'Administrator', 'sayaumii'),
(24, 2, 'petugas', '3baaf37f3bd0aae1d2b9787434334777', 'petugas', '12345umi'),
(27, 2, 'petugas2', '25d55ad283aa400af464c76d713c07ad', 'Bella Rosy', '12345678');

-- --------------------------------------------------------

--
-- Struktur dari tabel `tbl_siswa`
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
-- Dumping data untuk tabel `tbl_siswa`
--

INSERT INTO `tbl_siswa` (`NISN`, `ID_KELAS`, `ID_SPP`, `NIS`, `NAMA`, `ALAMAT`, `NO_TELP`, `TIMESTAMP`) VALUES
('0987654321', 4, 10, '87654321', 'Asmaul Khasanah', 'Semboro', '0858563034129', '2023-03-03 01:48:39'),
('1234567890', 3, 8, '12345678', 'Umi Kulsum', 'Besuki', '0858563034126', '2023-03-01 00:24:19');

-- --------------------------------------------------------

--
-- Struktur dari tabel `tbl_spp`
--

CREATE TABLE `tbl_spp` (
  `ID_SPP` int(11) NOT NULL,
  `TAHUN` varchar(16) DEFAULT NULL,
  `NOMINAL` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data untuk tabel `tbl_spp`
--

INSERT INTO `tbl_spp` (`ID_SPP`, `TAHUN`, `NOMINAL`) VALUES
(8, '2022/2023', 150000),
(10, '2020/2021', 150000),
(11, '2023/2024', 150000);

--
-- Indexes for dumped tables
--

--
-- Indeks untuk tabel `tbl_jurusan`
--
ALTER TABLE `tbl_jurusan`
  ADD PRIMARY KEY (`ID_JURUSAN`);

--
-- Indeks untuk tabel `tbl_kelas`
--
ALTER TABLE `tbl_kelas`
  ADD PRIMARY KEY (`ID_KELAS`),
  ADD KEY `FK_JURUSAN` (`ID_JURUSAN`);

--
-- Indeks untuk tabel `tbl_level`
--
ALTER TABLE `tbl_level`
  ADD PRIMARY KEY (`ID_LEVEL`);

--
-- Indeks untuk tabel `tbl_log`
--
ALTER TABLE `tbl_log`
  ADD PRIMARY KEY (`log_id`);

--
-- Indeks untuk tabel `tbl_pembayaran`
--
ALTER TABLE `tbl_pembayaran`
  ADD PRIMARY KEY (`ID_PEMBAYARAN`),
  ADD KEY `FK_PETUGAS` (`ID_PETUGAS`),
  ADD KEY `FK_SISWA` (`NISN`);

--
-- Indeks untuk tabel `tbl_petugas`
--
ALTER TABLE `tbl_petugas`
  ADD PRIMARY KEY (`ID_PETUGAS`),
  ADD KEY `FK_LEVEL` (`ID_LEVEL`);

--
-- Indeks untuk tabel `tbl_siswa`
--
ALTER TABLE `tbl_siswa`
  ADD PRIMARY KEY (`NISN`),
  ADD KEY `FK_KELAS` (`ID_KELAS`),
  ADD KEY `FK_SPP` (`ID_SPP`);

--
-- Indeks untuk tabel `tbl_spp`
--
ALTER TABLE `tbl_spp`
  ADD PRIMARY KEY (`ID_SPP`);

--
-- AUTO_INCREMENT untuk tabel yang dibuang
--

--
-- AUTO_INCREMENT untuk tabel `tbl_jurusan`
--
ALTER TABLE `tbl_jurusan`
  MODIFY `ID_JURUSAN` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT untuk tabel `tbl_kelas`
--
ALTER TABLE `tbl_kelas`
  MODIFY `ID_KELAS` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT untuk tabel `tbl_level`
--
ALTER TABLE `tbl_level`
  MODIFY `ID_LEVEL` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT untuk tabel `tbl_log`
--
ALTER TABLE `tbl_log`
  MODIFY `log_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=397;

--
-- AUTO_INCREMENT untuk tabel `tbl_pembayaran`
--
ALTER TABLE `tbl_pembayaran`
  MODIFY `ID_PEMBAYARAN` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=37;

--
-- AUTO_INCREMENT untuk tabel `tbl_petugas`
--
ALTER TABLE `tbl_petugas`
  MODIFY `ID_PETUGAS` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=28;

--
-- AUTO_INCREMENT untuk tabel `tbl_spp`
--
ALTER TABLE `tbl_spp`
  MODIFY `ID_SPP` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- Ketidakleluasaan untuk tabel pelimpahan (Dumped Tables)
--

--
-- Ketidakleluasaan untuk tabel `tbl_kelas`
--
ALTER TABLE `tbl_kelas`
  ADD CONSTRAINT `FK_JURUSAN` FOREIGN KEY (`ID_JURUSAN`) REFERENCES `tbl_jurusan` (`ID_JURUSAN`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ketidakleluasaan untuk tabel `tbl_pembayaran`
--
ALTER TABLE `tbl_pembayaran`
  ADD CONSTRAINT `FK_PETUGAS` FOREIGN KEY (`ID_PETUGAS`) REFERENCES `tbl_petugas` (`ID_PETUGAS`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `FK_SISWA` FOREIGN KEY (`NISN`) REFERENCES `tbl_siswa` (`NISN`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ketidakleluasaan untuk tabel `tbl_petugas`
--
ALTER TABLE `tbl_petugas`
  ADD CONSTRAINT `FK_LEVEL` FOREIGN KEY (`ID_LEVEL`) REFERENCES `tbl_level` (`ID_LEVEL`);

--
-- Ketidakleluasaan untuk tabel `tbl_siswa`
--
ALTER TABLE `tbl_siswa`
  ADD CONSTRAINT `FK_KELAS` FOREIGN KEY (`ID_KELAS`) REFERENCES `tbl_kelas` (`ID_KELAS`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_SPP` FOREIGN KEY (`ID_SPP`) REFERENCES `tbl_spp` (`ID_SPP`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
