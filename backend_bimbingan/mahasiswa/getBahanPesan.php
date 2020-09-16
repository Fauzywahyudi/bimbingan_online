<?php
if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    require '../koneksi.php';
    $respons = array();
    $data = array();
    $id_bimbingan = $_POST['id_bimbingan'];

    $sql = $kon->query("SELECT * FROM `bahan_bimbingan` WHERE id_bimbingan='$id_bimbingan'");
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
