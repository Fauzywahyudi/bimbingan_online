<?php
require '../koneksi.php';
$data = array();
$id_mahasiswa = $_GET['id_mahasiswa'];

$sql = $kon->query("SELECT * FROM jadwal_skripsi WHERE id_mahasiswa='$id_mahasiswa'");
while ($fetchData = $sql->fetch_array()) {
    $data[] = $fetchData;
}

if (isset($data)) {
    echo json_encode($data);
} else {
    echo json_encode($data);
}
