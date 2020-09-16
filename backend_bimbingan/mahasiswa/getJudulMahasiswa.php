<?php
if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    require '../koneksi.php';
    $respons = array();
    $data = array();
    $id_mahasiswa = $_POST['id_mahasiswa'];

    $sql = $kon->query("SELECT * FROM `judul` WHERE id_mahasiswa='$id_mahasiswa'");
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
