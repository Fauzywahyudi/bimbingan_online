<?php

include 'conn.php';

$title = $_POST['title'];
$image = $_FILES['image']['name'];
$imagepath = $_FILES['image']['tmp_name'];
$date = date('Y-m-d h:i:sa');

$lokasi = "uploads/".$image;

move_uploaded_file($imagepath, $lokasi);

$conn->query("INSERT INTO proposal (judul, file, tgl_upload) VALUES ('".$title."','".$image."','".$date."')");

?>