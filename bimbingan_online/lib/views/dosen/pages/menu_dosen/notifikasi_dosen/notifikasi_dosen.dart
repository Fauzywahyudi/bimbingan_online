import 'package:flutter/material.dart';

class NotifikasiDosen extends StatefulWidget {
  static const routeName = '/NotifikasiDosen';
  @override
  _NotifikasiDosenState createState() => _NotifikasiDosenState();
}

class _NotifikasiDosenState extends State<NotifikasiDosen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Notifikasi"),
      ),
      body: Container(),
    );
  }
}
