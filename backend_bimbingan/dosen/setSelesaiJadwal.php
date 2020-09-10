<?php

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    require '../koneksi.php';
    $response = array();
    $id_bimbingan = $_POST['id_bimbingan'];

    $sql = $kon->query("UPDATE jadwal_bimbingan SET status='Selesai'    WHERE id_bimbingan='$id_bimbingan'");

    if ($sql) {
        $response['value'] = 1;
        $response['message'] = "Update berhasil";
        echo json_encode($response);
    } else {
        $response['value'] = 0;
        $response['message'] = "Update gagal";
        echo json_encode($response);
    }
}
