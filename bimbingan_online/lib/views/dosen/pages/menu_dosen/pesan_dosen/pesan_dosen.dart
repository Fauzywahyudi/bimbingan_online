import 'package:flutter/material.dart';

class PesanDosen extends StatefulWidget {
  static const routeName = '/PesanDosen';
  @override
  _PesanDosenState createState() => _PesanDosenState();
}

class _PesanDosenState extends State<PesanDosen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pesan"),
      ),
      body: Container(),
    );
  }
}
