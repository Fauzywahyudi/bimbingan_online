<?php

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    require '../koneksi.php';
    $response = array();

    $id = $_POST['id'];
    $bab = $_POST['bab'];
    $judul = $_POST['judul'];
    $file = $_POST['file'];
    $keterangan = $_POST['keterangan'];
    $date = date('Y-m-d h:i:sa');

    // $sql = $kon->query("SELECT * FROM proposal WHERE id_mahasiswa='$id' AND status='Proses'");
    // $jum = $sql->num_rows;
    // if ($jum >= 3) {
    //     $response['value'] = 2;
    //     $response['message'] = "Upload sudah mencapai maksimal";
    //     echo json_encode($response);
    // } else {
    $upload = $kon->query("INSERT INTO bahan_bimbingan (id_mahasiswa, bab, judul, file, keterangan, tgl_upload) VALUES ('" . $id . "','" . $bab . "','" . $judul . "','" . $file . "','" . $keterangan . "','" . $date . "')");
    if ($upload) {
        $response['value'] = 1;
        $response['message'] = "Upload proposal berhasil";
        echo json_encode($response);
    } else {
        $response['value'] = 0;
        $response['message'] = "Upload proposal gagal";
        echo json_encode($response);
    }
    // }
}
