import 'views/dosen/pages/fitur_kaprodi/kompre/kompre_page.dart';
import 'views/dosen/pages/menu_dosen/daftar_bimbingan/tambah_jadwal_bimbingan.dart';
import 'views/dosen/pages/menu_dosen/mahasiswa_bimbingan/mahasiswa_bimbingan.dart';
import 'views/dosen/pages/fitur_kaprodi/pengumuman/tambah_pengumuman.dart';
import 'views/dosen/pages/fitur_kaprodi/dosen/dosen_page.dart';
import 'views/dosen/pages/fitur_kaprodi/mahasiswa/mahasiswa_page.dart';
import 'views/dosen/pages/fitur_kaprodi/pengumuman/pengumuman_page.dart';
import 'views/dosen/pages/fitur_kaprodi/proposal/proposal_page.dart';
import 'package:bimbingan_online/views/splashscreen.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'views/dosen/pages/menu_dosen/daftar_bimbingan/daftar_bimbingan.dart';
import 'views/dosen/pages/menu_dosen/notifikasi_dosen/notifikasi_dosen.dart';
import 'views/dosen/pages/menu_dosen/pesan_dosen/pesan_dosen.dart';
import 'views/mahasiswa/pages/jadwalBimbingan/ProgresBimbingan.dart';
import 'views/mahasiswa/pages/pengajuanProposal/daftarProposal.dart';
import 'views/mahasiswa/pages/skripsi/informasi_skripsi.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bimbingan Online',
      debugShowCheckedModeBanner: false,
      navigatorObservers: [
        BotToastNavigatorObserver()
      ], //Register route observer
      routes: {
        //page fitur kaprodi
        MahasiswaPage.routeName: (context) => MahasiswaPage(),
        DosenPage.routeName: (context) => DosenPage(),
        ProposalPage.routeName: (context) => ProposalPage(),
        PengumumanPage.routeName: (context) => PengumumanPage(),
        KomprePage.routeName: (context) => KomprePage(),
        TambahPengumuman.routeName: (context) => TambahPengumuman(),

        //fitur dosen
        MahasiswaBimbingan.routeName: (context) => MahasiswaBimbingan(),
        PesanDosen.routeName: (context) => PesanDosen(),
        NotifikasiDosen.routeName: (context) => NotifikasiDosen(),
        DaftarBimbingan.routeName: (context) => DaftarBimbingan(),
        TambahJadwalBimbingan.routeName: (context) => TambahJadwalBimbingan(),

        //mahasiswa
        DaftarProposal.routeName: (context) => DaftarProposal(),
        ProgresBimbingan.routeName: (context) => ProgresBimbingan(),
        InformasiSkripsi.routeName: (context) => InformasiSkripsi(),
      },
      builder: BotToastInit(),
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: SplashScreen(),
    );
  }
}
