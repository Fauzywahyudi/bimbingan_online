<?php

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    $status = $_POST['status'];
    if ($status == "Acc") {
        accBahan($status);
    } else if ($status == "Revisi") {
        revisiBahan($status);
    }
}

function accBahan($status)
{
    require '../koneksi.php';
    $response = array();
    $id_bahan = $_POST['id_bahan'];
    $id_dosen = $_POST['id_dosen'];

    $sql = $kon->query("UPDATE bahan_bimbingan SET status='$status' WHERE id_bahan='$id_bahan'");
    $sqlBahan = $kon->query("SELECT * FROM bahan_bimbingan WHERE id_bahan='$id_bahan'");
    $dataBahan = $sqlBahan->fetch_array();

    $sqlPesan = $kon->query("INSERT INTO `pesan`(`id_pesan`, `isi_pesan`, `sender`, `receiver`) VALUES (NULL,'Bab $dataBahan[bab] anda sudah Acc','dos:$id_dosen','mah:$dataBahan[id_mahasiswa]')");

    if ($sql && $sqlPesan) {
        $response['value'] = 1;
        $response['message'] = "Acc berhasil";
        echo json_encode($response);
    } else {
        $response['value'] = 0;
        $response['message'] = "Acc gagal";
        echo json_encode($response);
    }
}

function revisiBahan($status)
{
    require '../koneksi.php';
    $response = array();
    $id_bahan = $_POST['id_bahan'];
    $id_dosen = $_POST['id_dosen'];

    $sql = $kon->query("UPDATE bahan_bimbingan SET status='$status' WHERE id_bahan='$id_bahan'");
    $sqlBahan = $kon->query("SELECT * FROM bahan_bimbingan WHERE id_bahan='$id_bahan'");
    $dataBahan = $sqlBahan->fetch_array();

    $sqlPesan = $kon->query("INSERT INTO `pesan`(`id_pesan`, `isi_pesan`, `sender`, `receiver`) VALUES (NULL,'Bab $dataBahan[bab] anda ada Revisi','dos:$id_dosen','mah:$dataBahan[id_mahasiswa]')");

    if ($sql && $sqlPesan) {
        $response['value'] = 1;
        $response['message'] = "Revisi berhasil";
        echo json_encode($response);
    } else {
        $response['value'] = 0;
        $response['message'] = "Revisi gagal";
        echo json_encode($response);
    }
}
