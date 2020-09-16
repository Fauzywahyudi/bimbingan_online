import 'package:flutter/material.dart';

class AddBahan extends StatefulWidget {
  @override
  _AddBahanState createState() => _AddBahanState();
}

class _AddBahanState extends State<AddBahan> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text("Upload Bahan Bimbingan"),
      ),
    );
  }
}
