<?php

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    $response = array();
    $aktor = $_POST['aktor'];
    if ($aktor == "Mahasiswa") {
        Mahasiswa();
    } else if ($aktor == "Dosen") {
        Dosen();
    }
}

function Mahasiswa()
{
    require 'koneksi.php';
    $username = $_POST['username'];
    $password = md5($_POST['password']);

    $sql = $kon->query("SELECT * FROM mahasiswa WHERE nim_mahasiswa='$username' AND password='$password'");

    $result = $sql->fetch_array();

    if (isset($result)) {
        if ($result['status'] == "Confirm") {
            $response['value'] = 1;
            $response['message'] = "Login berhasil";
            $response['data'] = json_encode($result);
            echo json_encode($response);
        } else if ($result['status'] == "Reject") {
            $response['value'] = 2;
            $response['message'] = "Akun ditolak!";
            echo json_encode($response);
        } else if ($result['status'] == "Pending") {
            $response['value'] = 2;
            $response['message'] = "Akun belum dikonfirmasi!";
            echo json_encode($response);
        }
    } else {
        $response['value'] = 0;
        $response['message'] = "Login gagal";
        echo json_encode($response);
    }
}

function Dosen()
{
    require 'koneksi.php';
    $username = $_POST['username'];
    $password = md5($_POST['password']);

    $sql = $kon->query("SELECT * FROM dosen WHERE nidn_dosen='$username' AND password='$password'");

    $result = $sql->fetch_array();

    if (isset($result)) {
        if ($result['status'] == "Confirm") {
            $response['value'] = 1;
            $response['message'] = "Login berhasil";
            $response['data'] = json_encode($result);
            echo json_encode($response);
        } else if ($result['status'] == "Reject") {
            $response['value'] = 2;
            $response['message'] = "Akun ditolak!";
            echo json_encode($response);
        } else if ($result['status'] == "Pending") {
            $response['value'] = 2;
            $response['message'] = "Akun belum dikonfirmasi!";
            echo json_encode($response);
        }
    } else {
        $response['value'] = 0;
        $response['message'] = "Login gagal";
        echo json_encode($response);
    }
}
