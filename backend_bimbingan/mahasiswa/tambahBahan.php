<?php

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    require '../koneksi.php';
    $response = array();

    $id_mahasiswa = $_POST['id_mahasiswa'];
    $id_dosen = $_POST['id_dosen'];
    $id_bimbingan = $_POST['id_bimbingan'];
    $bab = $_POST['bab'];
    $judul = $_POST['judul'];
    $keterangan = $_POST['keterangan'];
    $file = $_POST['file'];

    $upload = $kon->query("INSERT INTO `bahan_bimbingan`( `id_mahasiswa`, `id_pembimbing`, `id_bimbingan`, `bab`, `judul`, `file`, `keterangan`) VALUES ('$id_mahasiswa','$id_dosen','$id_bimbingan','$bab','$judul','$file','$keterangan')");
    if ($upload) {
        $response['value'] = 1;
        $response['message'] = "Upload bahan berhasil";
        echo json_encode($response);
    } else {
        $response['value'] = 0;
        $response['message'] = "Upload bahan gagal";
        echo json_encode($response);
    }
}
