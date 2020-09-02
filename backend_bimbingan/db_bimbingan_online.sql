-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Waktu pembuatan: 02 Sep 2020 pada 20.17
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
(3, '1234567899', '21232f297a57a5a743894a0e4a801fc3', 'Eka Praja Mandala Wiyata', 'S.Kom., M.Kom.', 'Laki-laki', 'Dosen Tetap', 'Padang', '+6282288229856', 'Confirm', '2020-08-31 00:36:04');

-- --------------------------------------------------------

--
-- Struktur dari tabel `info_jadwal`
--

CREATE TABLE `info_jadwal` (
  `id_jadwal` int(11) NOT NULL,
  `tipe_jadwal` varchar(25) NOT NULL,
  `nama_jadwal` text NOT NULL,
  `jadwal_mulai` datetime NOT NULL,
  `jadwal_selesai` datetime NOT NULL,
  `status` varchar(15) NOT NULL,
  `keterangan` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

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
  `no_bimbingan` int(11) NOT NULL,
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Struktur dari tabel `judul`
--

CREATE TABLE `judul` (
  `id_judul` int(11) NOT NULL,
  `id_mahasiswa` int(11) NOT NULL,
  `judul` text NOT NULL,
  `pembimbing` text NOT NULL,
  `tgl_acc` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

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
-- Indeks untuk tabel `dosen`
--
ALTER TABLE `dosen`
  ADD PRIMARY KEY (`id_dosen`);

--
-- Indeks untuk tabel `info_jadwal`
--
ALTER TABLE `info_jadwal`
  ADD PRIMARY KEY (`id_jadwal`);

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
-- AUTO_INCREMENT untuk tabel `dosen`
--
ALTER TABLE `dosen`
  MODIFY `id_dosen` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT untuk tabel `info_jadwal`
--
ALTER TABLE `info_jadwal`
  MODIFY `id_jadwal` int(11) NOT NULL AUTO_INCREMENT;

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
  MODIFY `id_judul` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `mahasiswa`
--
ALTER TABLE `mahasiswa`
  MODIFY `id_mahasiswa` int(11) NOT NULL AUTO_INCREMENT;

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
  MODIFY `id_proposal` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `room_chat`
--
ALTER TABLE `room_chat`
  MODIFY `id_room` int(11) NOT NULL AUTO_INCREMENT;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
