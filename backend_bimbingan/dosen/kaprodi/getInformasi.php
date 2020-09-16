<?php

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    $response = array();
    $status = $_POST['status'];
    if (empty($status)) {
        All();
    } else {
        ByStatus($status);
    }
}

function ByStatus($status)
{
    require '../../koneksi.php';
    $data = array();

    $sql = $kon->query("SELECT * FROM dosen WHERE status='$status' ORDER BY nidn_dosen ASC");
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

function All()
{
    require '../../koneksi.php';
    $data = array();

    $sql = $kon->query("SELECT * FROM dosen ORDER BY nidn_dosen ASC");
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
