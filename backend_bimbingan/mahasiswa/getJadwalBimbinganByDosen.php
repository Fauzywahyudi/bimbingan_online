<?php
if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    require '../koneksi.php';
    $respons = array();
    $data = array();
    $id_dosen = $_POST['id_dosen'];

    $sql = $kon->query("SELECT * FROM `jadwal_bimbingan` WHERE id_dosen='$id_dosen'");
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
