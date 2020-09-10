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
        TambahPengumuman.routeName: (context) => TambahPengumuman(),

        //fitur dosen
        MahasiswaBimbingan.routeName: (context) => MahasiswaBimbingan(),
        DaftarBimbingan.routeName: (context) => DaftarBimbingan(),
        TambahJadwalBimbingan.routeName: (context) => TambahJadwalBimbingan(),
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
