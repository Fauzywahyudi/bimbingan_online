<?php

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    require '../../koneksi.php';

    $response = array();
    $tipe_jadwal = $_POST['tipe'];
    $mulai = $_POST['mulai'];
    $akhir = $_POST['selesai'];
    $id_mahasiswa = $_POST['id_mahasiswa'];
    $penguji = $_POST['penguji'];
    $keterangan = $_POST['keterangan'];


    $sql = $kon->query("INSERT INTO `jadwal_skripsi`(`id_jadwal_skripsi`, `tipe_jadwal`, `jadwal_mulai`, `jadwal_selesai`, `id_mahasiswa`, `penguji`, `keterangan`) VALUES (NULL,'$tipe_jadwal','$mulai','$akhir','$id_mahasiswa','$penguji','$keterangan')");

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
