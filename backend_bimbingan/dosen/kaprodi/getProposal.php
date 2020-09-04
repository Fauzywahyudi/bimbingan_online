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

    $sql = $kon->query("SELECT * FROM proposal INNER JOIN mahasiswa ON proposal.id_mahasiswa=mahasiswa.id_mahasiswa WHERE proposal.status='$status' ORDER BY proposal.tgl_upload ASC");
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

    $sql = $kon->query("SELECT * FROM proposal INNER JOIN mahasiswa ON proposal.id_mahasiswa=mahasiswa.id_mahasiswa ORDER BY proposal.tgl_upload ASC");
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
