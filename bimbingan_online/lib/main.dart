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
      builder: BotToastInit(),
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: SplashScreen(),
    );
  }
}
