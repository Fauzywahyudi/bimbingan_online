<?php

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    $response = array();
    $aktor = $_POST['aktor'];
    if ($aktor == "Mahasiswa") {
        Mahasiswa();
    } else if ($aktor == "Dosen") {
        Dosen();
    }
}

function Dosen()
{
    require '../../koneksi.php';
    $data = array();

    $sql = $kon->query("SELECT * FROM mahasiswa WHERE status='$status' ORDER BY nim_mahasiswa ASC");
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

function Mahasiswa()
{
    require '../../koneksi.php';

    $status = $_POST['status'];
    $id = $_POST['id'];
    if ($status == "Confirm") {
        $sql = $kon->query("UPDATE `mahasiswa` SET `status`='Confirm' WHERE id_mahasiswa='$id'");
        if ($sql) {
            $response['value'] = 1;
            $response['message'] = "Konfirmasi berhasil";
            echo json_encode($response);
        } else {
            $response['value'] = 0;
            $response['message'] = "Konfirmasi gagal";
            echo json_encode($response);
        }
    } else {
        $sql = $kon->query("UPDATE `mahasiswa` SET `status`='Reject' WHERE id_mahasiswa='$id'");
        if ($sql) {
            $response['value'] = 1;
            $response['message'] = "Reject berhasil";
            echo json_encode($response);
        } else {
            $response['value'] = 0;
            $response['message'] = "Reject gagal";
            echo json_encode($response);
        }
    }
}
