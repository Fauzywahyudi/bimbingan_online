<?php

if ($_SERVER['REQUEST_METHOD'] == 'POST') {

    $status = $_POST['status'];
    if ($status == "group") {
        groupByMahasiswa();
    } else {
        perbahan();
    }
}

function groupByMahasiswa()
{
    require '../koneksi.php';
    $response = array();
    $data = array();
    $id_dosen = $_POST['id_dosen'];
    $id_mahasiswa = $_POST['id_mahasiswa'];

    $sql = $kon->query("SELECT * FROM bahan_bimbingan as a INNER JOIN mahasiswa as b ON a.id_mahasiswa=b.id_mahasiswa WHERE a.id_pembimbing='$id_dosen' GROUP BY a.id_mahasiswa");

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
function perbahan()
{
    require '../koneksi.php';
    $response = array();
    $data = array();
    $id_dosen = $_POST['id_dosen'];
    $id_mahasiswa = $_POST['id_mahasiswa'];
    $sql = $kon->query("SELECT * FROM bahan_bimbingan WHERE id_pembimbing='$id_dosen' AND id_mahasiswa='$id_mahasiswa'");

    while ($fetchData = $sql->fetch_array()) {
        $data[] = $fetchData;
    }

    if (isset($data)) {
        $response['value'] = 1;
        $response['message'] = "Tambah jadwal berhasil";
        $response['data'] = json_encode($data);
        echo json_encode($response);
    } else {
        $response['value'] = 0;
        $response['message'] = "Tambah jadwal gagal";
        echo json_encode($response);
    }
}
