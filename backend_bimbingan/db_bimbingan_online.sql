-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Waktu pembuatan: 07 Sep 2020 pada 23.21
-- Versi server: 10.4.13-MariaDB
-- Versi PHP: 7.4.8

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+07:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `db_bimbingan_online`
--

-- --------------------------------------------------------

--
-- Struktur dari tabel `bahan_bimbingan`
--

CREATE TABLE `bahan_bimbingan` (
  `id_bahan` int(11) NOT NULL,
  `id_mahasiswa` int(11) NOT NULL,
  `id_bimbingan` int(11) NOT NULL,
  `bab` int(11) NOT NULL,
  `judul` text NOT NULL,
  `file` text NOT NULL,
  `status` varchar(15) NOT NULL DEFAULT 'Belum dibaca',
  `keterangan` text NOT NULL,
  `tgl_upload` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Struktur dari tabel `dosen`
--

CREATE TABLE `dosen` (
  `id_dosen` int(11) NOT NULL,
  `nidn_dosen` varchar(15) NOT NULL,
  `password` text NOT NULL,
  `nama_dosen` varchar(50) NOT NULL,
  `gelar` varchar(50) NOT NULL,
  `jk` varchar(15) NOT NULL,
  `jabatan` varchar(15) NOT NULL,
  `alamat` text NOT NULL,
  `nohp` varchar(15) NOT NULL,
  `status` varchar(15) NOT NULL,
  `tgl_daftar` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data untuk tabel `dosen`
--

INSERT INTO `dosen` (`id_dosen`, `nidn_dosen`, `password`, `nama_dosen`, `gelar`, `jk`, `jabatan`, `alamat`, `nohp`, `status`, `tgl_daftar`) VALUES
(1, '1234567890', '21232f297a57a5a743894a0e4a801fc3', 'Rini Sovia', 'S.Kom., M.Kom.', 'Perempuan', 'Ketua Prodi', 'Padang', '082288228822', 'Confirm', '2020-08-06 22:32:07'),
(3, '1234567899', '21232f297a57a5a743894a0e4a801fc3', 'Eka Praja', 'S.Kom., M.Kom.', 'Laki-laki', 'Dosen Tetap', 'Padang', '+6282288229856', 'Confirm', '2020-08-31 00:36:04'),
(4, '1234567898', '21232f297a57a5a743894a0e4a801fc3', 'Randi Permanan', 'S.Kom., M.Kom', 'Laki-laki', 'Dosen Tetap', 'Padang', '+6282288229856', 'Confirm', '2020-09-03 16:57:18'),
(5, '1234567897', '21232f297a57a5a743894a0e4a801fc3', 'Musli Yanto', 'S.Kom., M.Kom.', 'Laki-laki', 'Dosen Tetap', 'Padang', '+6282288229856', 'Reject', '2020-09-03 17:04:12'),
(6, '1234567896', '21232f297a57a5a743894a0e4a801fc3', 'Fauzy Wahyudi', 'S.Kom., M.Kom.', 'Laki-laki', 'Dosen Tetap', 'Padang', '+6282288229856', 'Confirm', '2020-09-03 17:05:28');

-- --------------------------------------------------------

--
-- Struktur dari tabel `info_pembimbing`
--

CREATE TABLE `info_pembimbing` (
  `id_info` int(11) NOT NULL,
  `id_dosen` int(11) NOT NULL,
  `judul` int(11) NOT NULL,
  `penjelasan` int(11) NOT NULL,
  `tgl_post` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Struktur dari tabel `jadwal_bimbingan`
--

CREATE TABLE `jadwal_bimbingan` (
  `id_bimbingan` int(11) NOT NULL,
  `id_dosen` int(11) NOT NULL,
  `jadwal_mulai` datetime NOT NULL,
  `jadwal_selesai` datetime NOT NULL,
  `status` varchar(15) NOT NULL,
  `keterangan` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Struktur dari tabel `jadwal_skripsi`
--

CREATE TABLE `jadwal_skripsi` (
  `id_jadwal_skripsi` int(11) NOT NULL,
  `tipe_jadwal` varchar(15) NOT NULL,
  `jadwal_mulai` datetime NOT NULL,
  `jadwal_selesai` datetime NOT NULL,
  `id_mahasiswa` int(11) NOT NULL,
  `penguji` text NOT NULL,
  `keterangan` text NOT NULL,
  `status` varchar(15) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='jadwal seminar & kompre';

-- --------------------------------------------------------

--
-- Struktur dari tabel `judul`
--

CREATE TABLE `judul` (
  `id_judul` int(11) NOT NULL,
  `id_mahasiswa` int(11) NOT NULL,
  `judul` text NOT NULL,
  `pembimbing1` int(11) NOT NULL,
  `pembimbing2` int(11) NOT NULL,
  `tgl_acc` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data untuk tabel `judul`
--

INSERT INTO `judul` (`id_judul`, `id_mahasiswa`, `judul`, `pembimbing1`, `pembimbing2`, `tgl_acc`) VALUES
(1, 5, 'asdasd', 1, 4, '2020-09-08 01:12:10');

-- --------------------------------------------------------

--
-- Struktur dari tabel `mahasiswa`
--

CREATE TABLE `mahasiswa` (
  `id_mahasiswa` int(11) NOT NULL,
  `nim_mahasiswa` varchar(8) NOT NULL,
  `password` text NOT NULL,
  `nama_mahasiswa` varchar(50) NOT NULL,
  `jk` varchar(15) NOT NULL,
  `jurusan` varchar(50) NOT NULL,
  `alamat` text NOT NULL,
  `nohp` varchar(15) NOT NULL,
  `status` varchar(15) NOT NULL,
  `tgl_daftar` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data untuk tabel `mahasiswa`
--

INSERT INTO `mahasiswa` (`id_mahasiswa`, `nim_mahasiswa`, `password`, `nama_mahasiswa`, `jk`, `jurusan`, `alamat`, `nohp`, `status`, `tgl_daftar`) VALUES
(1, '16100020', 'c9d2cce909ea37234be8af1a1f958805', 'ANNISA SYAFIRA', 'Perempuan', 'Pendidikan Informatika', 'Padang', '+6282288229856', 'Confirm', '2020-09-03 01:55:49'),
(2, '16100021', '6172de70289f996b192e1b2f5a932ace', 'FAUZY WAHYUDI', 'Laki-laki', 'Pendidikan Informatika', 'Solok', '+6282288229856', 'Confirm', '2020-09-03 12:49:27'),
(3, '16100022', '8c9a8d36c39b26c8e8239a491e39813b', 'ROFIUL CHULUQ', 'Laki-laki', 'Pendidikan Informatika', 'Padang', '+6282288229856', 'Reject', '2020-09-03 12:50:20'),
(4, '16100025', 'e04f28cc33cb20274dd3ff44e600a923', 'RAHMAT DANI', 'Laki-laki', 'Pendidikan Informatika', 'Pekanbaru', '+6292288229856', 'Confirm', '2020-09-03 15:44:50'),
(5, '16100030', '46171b077997b166bb30cf5494eff2f8', 'Ferriy Hafid', 'Laki-laki', 'Pendidikan Informatika', 'Padang', '+6282288229856', 'Confirm', '2020-09-03 17:09:32');

-- --------------------------------------------------------

--
-- Struktur dari tabel `pengumuman`
--

CREATE TABLE `pengumuman` (
  `id_pengumuman` int(11) NOT NULL,
  `tipe_pengumuman` varchar(25) NOT NULL,
  `judul_pengumuman` text NOT NULL,
  `status` varchar(15) NOT NULL DEFAULT 'Akan Datang',
  `keterangan` text NOT NULL,
  `tgl_post` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data untuk tabel `pengumuman`
--

INSERT INTO `pengumuman` (`id_pengumuman`, `tipe_pengumuman`, `judul_pengumuman`, `status`, `keterangan`, `tgl_post`) VALUES
(2, 'Seminar Proposal', 'Informasi Tentang Seminar Proposal', 'Akan Datang', 'bagi yang ikut bla bla bla\r\nbla bla bla\r\n', '2020-09-05 15:38:20'),
(3, 'Seminar Proposal', 'Informasi Tentang Seminar Proposal', 'Akan Datang', 'bagi yang ikut bla bla bla\r\nbla bla bla\r\n', '2020-09-05 15:38:34'),
(4, 'Skripsi', 'Info Pembimbing', 'Akan Datang', 'pembimbing ada 2 ya', '2020-09-07 05:16:32');

-- --------------------------------------------------------

--
-- Struktur dari tabel `pesan`
--

CREATE TABLE `pesan` (
  `id_pesan` int(11) NOT NULL,
  `pesan` int(11) NOT NULL,
  `sender` varchar(15) NOT NULL,
  `receiver` varchar(15) NOT NULL,
  `tgl_kirim` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Struktur dari tabel `progres`
--

CREATE TABLE `progres` (
  `id_progres` int(11) NOT NULL,
  `id_judul` int(11) NOT NULL,
  `bab` varchar(50) NOT NULL,
  `status` varchar(10) NOT NULL,
  `notes` text NOT NULL,
  `tgl_update` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Struktur dari tabel `proposal`
--

CREATE TABLE `proposal` (
  `id_proposal` int(11) NOT NULL,
  `id_mahasiswa` int(11) NOT NULL,
  `judul` text NOT NULL,
  `file` text NOT NULL,
  `tgl_upload` datetime NOT NULL,
  `status` varchar(15) NOT NULL DEFAULT 'Proses'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data untuk tabel `proposal`
--

INSERT INTO `proposal` (`id_proposal`, `id_mahasiswa`, `judul`, `file`, `tgl_upload`, `status`) VALUES
(1, 5, 'bla bla', 'file.doc', '2020-09-04 09:28:06', 'Ditolak'),
(2, 5, 'asdasd', 'asds.doc', '2020-09-04 09:28:06', 'Acc Rekap');

-- --------------------------------------------------------

--
-- Struktur dari tabel `room_chat`
--

CREATE TABLE `room_chat` (
  `id_room` int(11) NOT NULL,
  `nama_room` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Indexes for dumped tables
--

--
-- Indeks untuk tabel `bahan_bimbingan`
--
ALTER TABLE `bahan_bimbingan`
  ADD PRIMARY KEY (`id_bahan`);

--
-- Indeks untuk tabel `dosen`
--
ALTER TABLE `dosen`
  ADD PRIMARY KEY (`id_dosen`);

--
-- Indeks untuk tabel `info_pembimbing`
--
ALTER TABLE `info_pembimbing`
  ADD PRIMARY KEY (`id_info`);

--
-- Indeks untuk tabel `jadwal_bimbingan`
--
ALTER TABLE `jadwal_bimbingan`
  ADD PRIMARY KEY (`id_bimbingan`);

--
-- Indeks untuk tabel `jadwal_skripsi`
--
ALTER TABLE `jadwal_skripsi`
  ADD PRIMARY KEY (`id_jadwal_skripsi`);

--
-- Indeks untuk tabel `judul`
--
ALTER TABLE `judul`
  ADD PRIMARY KEY (`id_judul`);

--
-- Indeks untuk tabel `mahasiswa`
--
ALTER TABLE `mahasiswa`
  ADD PRIMARY KEY (`id_mahasiswa`);

--
-- Indeks untuk tabel `pengumuman`
--
ALTER TABLE `pengumuman`
  ADD PRIMARY KEY (`id_pengumuman`);

--
-- Indeks untuk tabel `pesan`
--
ALTER TABLE `pesan`
  ADD PRIMARY KEY (`id_pesan`);

--
-- Indeks untuk tabel `progres`
--
ALTER TABLE `progres`
  ADD PRIMARY KEY (`id_progres`);

--
-- Indeks untuk tabel `proposal`
--
ALTER TABLE `proposal`
  ADD PRIMARY KEY (`id_proposal`);

--
-- Indeks untuk tabel `room_chat`
--
ALTER TABLE `room_chat`
  ADD PRIMARY KEY (`id_room`);

--
-- AUTO_INCREMENT untuk tabel yang dibuang
--

--
-- AUTO_INCREMENT untuk tabel `bahan_bimbingan`
--
ALTER TABLE `bahan_bimbingan`
  MODIFY `id_bahan` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `dosen`
--
ALTER TABLE `dosen`
  MODIFY `id_dosen` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT untuk tabel `info_pembimbing`
--
ALTER TABLE `info_pembimbing`
  MODIFY `id_info` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `jadwal_bimbingan`
--
ALTER TABLE `jadwal_bimbingan`
  MODIFY `id_bimbingan` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `jadwal_skripsi`
--
ALTER TABLE `jadwal_skripsi`
  MODIFY `id_jadwal_skripsi` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `judul`
--
ALTER TABLE `judul`
  MODIFY `id_judul` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT untuk tabel `mahasiswa`
--
ALTER TABLE `mahasiswa`
  MODIFY `id_mahasiswa` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT untuk tabel `pengumuman`
--
ALTER TABLE `pengumuman`
  MODIFY `id_pengumuman` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT untuk tabel `pesan`
--
ALTER TABLE `pesan`
  MODIFY `id_pesan` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `progres`
--
ALTER TABLE `progres`
  MODIFY `id_progres` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `proposal`
--
ALTER TABLE `proposal`
  MODIFY `id_proposal` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT untuk tabel `room_chat`
--
ALTER TABLE `room_chat`
  MODIFY `id_room` int(11) NOT NULL AUTO_INCREMENT;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
