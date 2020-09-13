<?php
include '../koneksi.php';

$id = $_POST['id'];

$queryResult = $kon->query("SELECT * FROM proposal WHERE id_mahasiswa = '$id'");
$result = array();

while ($fetchData = $queryResult->fetch_assoc()) {
    $result[] = $fetchData;
}

echo json_encode($result);
