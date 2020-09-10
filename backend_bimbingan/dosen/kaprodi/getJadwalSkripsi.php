<?php

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    $response = array();
    $tipe = $_POST['tipe'];
    if (empty($tipe)) {
        All();
    } else {
        Bytipe($tipe);
    }
}

function Bytipe($tipe)
{
    require '../../koneksi.php';
    $data = array();

    $sql = $kon->query("SELECT * FROM `jadwal_skripsi` INNER JOIN mahasiswa ON jadwal_skripsi.id_mahasiswa = mahasiswa.id_mahasiswa WHERE jadwal_skripsi.tipe_jadwal='$tipe'");
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
