<?php

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    require '../koneksi.php';
    $response = array();
    $id_dosen = $_POST['id_dosen'];
    $mulai = $_POST['mulai'];
    $akhir = $_POST['akhir'];
    $keterangan = $_POST['keterangan'];

    $sql = $kon->query("INSERT INTO `jadwal_bimbingan`(`id_bimbingan`, `id_dosen`, `jadwal_mulai`, `jadwal_selesai`, `keterangan`) VALUES (NULL,'$id_dosen','$mulai','$akhir','$keterangan')");

    if ($sql) {
        $response['value'] = 1;
        $response['message'] = "Tambah jadwal berhasil";
        echo json_encode($response);
    } else {
        $response['value'] = 0;
        $response['message'] = "Tambah jadwal gagal";
        echo json_encode($response);
    }
}
