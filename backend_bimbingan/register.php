<?php
// require 'koneksi.php';

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
    require 'koneksi.php';
    $nim = $_POST['nim'];
    $pass = md5($_POST['pass']);
    $nama = $_POST['nama'];
    $jk = $_POST['jk'];
    $jurusan = "Pendidikan Informatika";
    $nohp = $_POST['nohp'];
    $alamat = $_POST['alamat'];

    $sql = $kon->query("SELECT * FROM mahasiswa WHERE nim_mahasiswa='$nim'");
    $resultCek = $sql->fetch_array();

    if (isset($resultCek)) {
        $response['value'] = 2;
        $response['message'] = "NIM telah terdaftar";
        echo json_encode($response);
    } else {
        $sql = $kon->query("INSERT INTO `mahasiswa`(`id_mahasiswa`, `nim_mahasiswa`, `password`, `nama_mahasiswa`, `jk`, `jurusan`, `alamat`, `nohp`, `status`, `tgl_daftar`) VALUES (NULL,'$nim','$pass','$nama','$jk','$jurusan','$alamat','$nohp','Pending',NOW())");

        if ($sql) {
            $response['value'] = 1;
            $response['message'] = "Berhasil didaftarkan";
            echo json_encode($response);
        } else {
            $response['value'] = 0;
            $response['message'] = "Gagal didaftarkan";
            echo json_encode($response);
        }
    }
}

function Dosen()
{
}
