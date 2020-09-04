<?php

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    $response = array();
    require '../../koneksi.php';

    $status = $_POST['status'];
    $id_proposal = $_POST['id_proposal'];
    $id_mahasiswa = $_POST['id_mahasiswa'];
    if ($status == "Acc") {
        $sql = $kon->query("UPDATE `proposal` SET `status`='Acc' WHERE id_proposal='$id_proposal'");
        $sqlSelectAll = $kon->query("SELECT * FROM proposal WHERE id_mahasiswa='$id_mahasiswa' AND status='Proses'");
        while ($fetchData = $sqlSelectAll->fetch_array()) {
            $kon->query("UPDATE `proposal` SET `status`='Ditolak' WHERE id_proposal='$fetchData[id_proposal]'");
        }

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
        $sql = $kon->query("UPDATE `proposal` SET `status`='Ditolak' WHERE id_proposal='$id_proposal'");
        if ($sql) {
            $response['value'] = 1;
            $response['message'] = "Tolak berhasil";
            echo json_encode($response);
        } else {
            $response['value'] = 0;
            $response['message'] = "Tolak gagal";
            echo json_encode($response);
        }
    }
}
