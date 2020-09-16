<?php
require '../koneksi.php';
$response = array();
$data = array();
$id_pembimbing = $_GET['id_pembimbing'];
// $status = $_POST['status'];

$id_mahasiswa = $_GET['id_mahasiswa'];
// $status = $_POST['status'];

$sql = $kon->query("SELECT * FROM bahan_bimbingan as a INNER JOIN mahasiswa as b ON a.id_mahasiswa=b.id_mahasiswa WHERE a.id_pembimbing='$id_pembimbing' GROUP BY a.id_mahasiswa");

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
