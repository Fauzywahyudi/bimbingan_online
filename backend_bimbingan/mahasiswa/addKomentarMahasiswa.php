<?php

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    require '../koneksi.php';
    $response = array();
    $id_bahan = $_POST['id_bahan'];
    $isi_pesan = $_POST['isi_pesan'];
    $sender = $_POST['sender'];
    $receiver = $_POST['receiver'];

    $sql = $kon->query("INSERT INTO `komentar`(`id_komentar`, `id_bahan`, `isi_komentar`, `sender`, `receiver`) VALUES (NULL,'$id_bahan','$isi_pesan','mah:$sender','dos:$receiver')");

    if ($sql) {
        $response['value'] = 1;
        $response['message'] = "Tambah Komentar berhasil";
        echo json_encode($response);
    } else {
        $response['value'] = 0;
        $response['message'] = "Tambah Komentar gagal";
        echo json_encode($response);
    }
}
