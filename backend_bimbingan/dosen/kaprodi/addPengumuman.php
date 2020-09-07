<?php

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    require '../../koneksi.php';

    $response = array();
    $tipe = $_POST['tipe'];
    $judul = $_POST['judul'];
    $keterangan = $_POST['keterangan'];

    $sql = $kon->query("INSERT INTO `pengumuman`(`tipe_pengumuman`, `judul_pengumuman`, `keterangan`) VALUES ('$tipe','$judul','$keterangan')");

    if ($sql) {
        $response['value'] = 1;
        $response['message'] = "Berhasil ditambahkan";
        echo json_encode($response);
    } else {
        $response['value'] = 0;
        $response['message'] = "Gagal ditambahkan";
        echo json_encode($response);
    }
}
