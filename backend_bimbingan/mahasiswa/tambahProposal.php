<?php
include '../koneksi.php';

$id = $_POST['id'];
$judul = $_POST['judul'];
$file = $_POST['file'];
$tgl = $_POST['tgl'];
$date = date('Y-m-d h:i:sa');

$kon->query("INSERT INTO proposal (id_mahasiswa, judul, file, tgl_upload) VALUES ('" . $id . "','" . $judul . "','" . $file . "','" . $date . "')");
