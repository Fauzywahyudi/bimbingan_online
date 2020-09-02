import 'package:bimbingan_online/models/dosen.dart';
import 'package:bimbingan_online/models/shared_preferenced.dart';
import 'package:bimbingan_online/utils/assets.dart';
import 'package:bimbingan_online/views/dosen/pages/home_dosen.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  DataShared _dataShared = DataShared();

  void _checkStatus() async {
    final value = await _dataShared.getValue();
    if (value == 1) {
      final aktor = await _dataShared.getAktor();
      if (aktor == "Mahasiswa") {
      } else {
        Dosen dosen = await _dataShared.getDataPrefDosen();
        pushReplacePage(
            context,
            HomeDosen(
              dosen: dosen,
            ));
      }
    }
  }

  @override
  void initState() {
    _checkStatus();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Text("SpalshScreen"),
        ),
      ),
    );
  }
}
