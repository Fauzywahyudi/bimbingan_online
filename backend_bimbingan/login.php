<?php

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    $response = array();
    $aktor = $_POST['aktor'];
    if ($aktor == "Mahasiswa") {
        Mahasiswa();
    } else {
        Dosen();
    }
}

function Mahasiswa()
{
}

function Dosen()
{
    require 'koneksi.php';
    $username = $_POST['username'];
    $password = md5($_POST['password']);

    $sql = $kon->query("SELECT * FROM dosen WHERE nidn_dosen='$username' AND password='$password'");

    $result = $sql->fetch_array();

    if (isset($result)) {
        $response['value'] = 1;
        $response['message'] = "Login berhasil";
        $response['data'] = json_encode($result);
        echo json_encode($response);
    } else {
        $response['value'] = 0;
        $response['message'] = "Login gagal";
        echo json_encode($response);
    }
}
