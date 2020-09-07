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
    // require '../../koneksi.php';
    // $data = array();

    // $sql = $kon->query("SELECT * FROM mahasiswa WHERE status='$status' ORDER BY nim_mahasiswa ASC");
    // while ($fetchData = $sql->fetch_array()) {
    //     $data[] = $fetchData;
    // }

    // if (isset($data)) {
    //     $response['value'] = 1;
    //     $response['message'] = "Load data berhasil";
    //     $response['data'] = json_encode($data);
    //     echo json_encode($response);
    // } else {
    //     $response['value'] = 0;
    //     $response['message'] = "Load data gagal";
    //     echo json_encode($response);
    // }
}

function All()
{
    require '../koneksi.php';
    $data = array();
    $id_dosen = $_POST['id_dosen'];

    $sql = $kon->query("SELECT * FROM judul INNER JOIN mahasiswa ON judul.id_mahasiswa=mahasiswa.id_mahasiswa WHERE judul.pembimbing1='$id_dosen' OR pembimbing2='$id_dosen' ORDER BY mahasiswa.nim_mahasiswa ASC");
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
