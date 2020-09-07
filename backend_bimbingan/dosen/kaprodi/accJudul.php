<?php

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    require '../../koneksi.php';

    $response = array();

    $id_mahasiswa = $_POST['id_mahasiswa'];
    $id_proposal = $_POST['id_proposal'];
    $judul = $_POST['judul'];
    $id_dospem1 = $_POST['id_dospem1'];
    $id_dospem2 = $_POST['id_dospem2'];

    $sql = $kon->query("INSERT INTO `judul`(`id_judul`, `id_mahasiswa`, `judul`, `pembimbing1`, `pembimbing2`, `tgl_acc`) VALUES (NULL,'$id_mahasiswa','$judul','$id_dospem1','$id_dospem2',NOW())");

    $update = $kon->query("UPDATE `proposal` SET `status`='Acc Rekap' WHERE id_proposal='$id_proposal'");

    if ($sql && $update) {
        $response['value'] = 1;
        $response['message'] = "Berhasil Acc Judul";
        echo json_encode($response);
    } else {
        $response['value'] = 0;
        $response['message'] = "Gagal Acc Judul";
        echo json_encode($response);
    }
}
