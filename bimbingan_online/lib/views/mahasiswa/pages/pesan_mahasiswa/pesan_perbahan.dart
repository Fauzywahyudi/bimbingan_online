import 'dart:async';

import 'package:bimbingan_online/models/shared_preferenced.dart';
import 'package:bimbingan_online/providers/pesan_provider.dart';
import 'package:bimbingan_online/utils/assets.dart';
import 'package:bimbingan_online/views/mahasiswa/pages/pesan_mahasiswa/view_chat.dart';
import 'package:flutter/material.dart';

class PesanPerBahan extends StatefulWidget {
  final data;

  const PesanPerBahan({Key key, this.data}) : super(key: key);
  @override
  _PesanPerBahanState createState() => _PesanPerBahanState();
}

class _PesanPerBahanState extends State<PesanPerBahan> {
  PesanProvider _pesanProvider = PesanProvider();

  Future<List> _getPesan() async {
    final result = await _pesanProvider.getBahanByIdBimbingan(
        context, int.parse(widget.data['id_bimbingan']));
    return result;
  }

  @override
  void initState() {
    super.initState();
    _getPesan();
  }

  Future<Null> handleRefresh() async {
    Completer<Null> completer = new Completer<Null>();
    new Future.delayed(new Duration(milliseconds: 500)).then((_) {
      completer.complete();
      setState(() {});
    });
    return completer.future;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("mahasiswa"),
      ),
      body: Container(
        child: FutureBuilder<List>(
          future: _getPesan(),
          builder: (context, snapshot) {
            if (snapshot.hasError) print(snapshot.error);
            return snapshot.hasData ? _buildList(snapshot) : loadingCircular();
          },
        ),
      ),
    );
  }

  Widget _buildList(AsyncSnapshot<List> snapshot) {
    return RefreshIndicator(
      onRefresh: handleRefresh,
      child: ListView.builder(
        itemCount: snapshot.data.length,
        itemBuilder: (context, index) {
          return ListTile(
              onTap: () {
                pushPage(
                    context,
                    ViewChatPesan(
                        idDosen: int.parse(widget.data['id_dosen']),
                        data: snapshot.data[index]));
              },
              leading: snapshot.data[index]['status_bahan'] == "Belum dibaca"
                  ? Icon(Icons.schedule)
                  : snapshot.data[index]['status_bahan'] == "Acc"
                      ? Icon(Icons.check_box)
                      : Icon(Icons.refresh),
              title: Text("Bab " + snapshot.data[index]['bab']),
              subtitle:
                  Text("Status :" + snapshot.data[index]['status_bahan']));
        },
      ),
    );
  }
}
