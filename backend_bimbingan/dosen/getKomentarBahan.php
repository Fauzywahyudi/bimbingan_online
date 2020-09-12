<?php

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    $response = array();
    $id_bahan = $_POST['id_bahan'];

    require '../koneksi.php';
    $data = array();

    $sql = $kon->query("SELECT * FROM komentar WHERE id_bahan='$id_bahan' ORDER BY tgl_post DESC");
    while ($fetchData = $sql->fetch_array()) {
        $data[] = $fetchData;
    }

    if (isset($data)) {
        $response['value'] = 1;
        $response['message'] = "Load data berhasil";
        $response['data'] = json_encode($data);
        echo json_encode($response);
    } else {
        $response['value'] = 0;
        $response['message'] = "Load data gagal";
        echo json_encode($response);
    }
}
