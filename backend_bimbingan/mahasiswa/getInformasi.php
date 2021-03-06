<?php

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    $response = array();
    $response['dataJudul'] = Judul();
    $response['dataProgres'] = Progres();
    $response['dataJadwal'] = Jadwal();
    echo json_encode($response);
}

function Judul()
{
    require '../koneksi.php';
    $data = array();
    $id_mahasiswa = $_POST['id_mahasiswa'];

    $sql = $kon->query("SELECT * FROM `judul` WHERE id_mahasiswa='$id_mahasiswa'");
    while ($fetchData = $sql->fetch_array()) {
        $data[] = $fetchData;
        $dos1 = $kon->query("SELECT id_dosen, nama_dosen, gelar FROM dosen WHERE id_dosen='$fetchData[pembimbing1]'");
        $dospem1 = $dos1->fetch_array();
        $dos2 = $kon->query("SELECT id_dosen, nama_dosen, gelar FROM dosen WHERE id_dosen='$fetchData[pembimbing2]'");
        $dospem2 = $dos2->fetch_array();
        $data[1] = $dospem1;
        $data[2] = $dospem2;
    }

    if (isset($data)) {
        // $response['value'] = 1;
        // $response['message'] = "Load data berhasil";
        return json_encode($data);
    } else {
        // $response['value'] = 0;
        // $response['message'] = "Load data gagal";
        return json_encode($data);
    }
}

function Progres()
{
    require '../koneksi.php';
    $data = array();
    $id_mahasiswa = $_POST['id_mahasiswa'];

    $sql = $kon->query("SELECT * FROM bahan_bimbingan WHERE id_mahasiswa='$id_mahasiswa' ORDER BY bab");
    while ($fetchData = $sql->fetch_array()) {
        $data[] = $fetchData;
    }

    if (isset($data)) {
        return json_encode($data);
    } else {
        return json_encode($data);
    }
}

function Jadwal()
{
    require '../koneksi.php';
    $data = array();
    $id_mahasiswa = $_POST['id_mahasiswa'];

    $sql = $kon->query("SELECT * FROM jadwal_skripsi WHERE id_mahasiswa='$id_mahasiswa'");
    while ($fetchData = $sql->fetch_array()) {
        $data[] = $fetchData;
    }

    if (isset($data)) {
        return json_encode($data);
    } else {
        return json_encode($data);
    }
}
