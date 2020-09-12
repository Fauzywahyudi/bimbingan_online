<?php

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    require '../koneksi.php';
    $response = array();
    $data = array();
    $id_bimbingan = $_POST['id_bimbingan'];
    $status = $_POST['status'];

    $sql = $kon->query("SELECT * FROM bahan_bimbingan INNER JOIN mahasiswa ON bahan_bimbingan.id_mahasiswa=mahasiswa.id_mahasiswa WHERE bahan_bimbingan.id_bimbingan='$id_bimbingan' AND bahan_bimbingan.status_bahan='$status'");

    while ($fetchData = $sql->fetch_array()) {
        $data[] = $fetchData;
    }

    if (isset($data)) {
        $response['value'] = 1;
        $response['message'] = "Tambah jadwal berhasil";
        $response['data'] = json_encode($data);
        echo json_encode($response);
    } else {
        $response['value'] = 0;
        $response['message'] = "Tambah jadwal gagal";
        echo json_encode($response);
    }
}
