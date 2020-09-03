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

    $status = $_POST['status'];
    $id = $_POST['id'];
    if ($status == "Confirm") {
        $sql = $kon->query("UPDATE `dosen` SET `status`='Confirm' WHERE id_dosen='$id'");
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
        $sql = $kon->query("UPDATE `dosen` SET `status`='Reject' WHERE id_dosen='$id'");
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
