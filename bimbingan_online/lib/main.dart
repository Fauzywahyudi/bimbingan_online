import 'package:bimbingan_online/views/dosen/pages/fitur_kaprodi/dosen/dosen_page.dart';
import 'package:bimbingan_online/views/dosen/pages/fitur_kaprodi/mahasiswa/mahasiswa_page.dart';
import 'package:bimbingan_online/views/login.dart';
import 'package:bimbingan_online/views/splashscreen.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';

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
