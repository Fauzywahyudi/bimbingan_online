import 'dart:async';

import 'package:bimbingan_online/models/shared_preferenced.dart';
import 'package:bimbingan_online/providers/mahasiswa_bimbingan_provider.dart';
import 'package:flutter/material.dart';

class MahasiswaBimbingan extends StatefulWidget {
  static const routeName = '/MahasiswaBimbinganDosen';
  @override
  _MahasiswaBimbinganState createState() => _MahasiswaBimbinganState();
}

class _MahasiswaBimbinganState extends State<MahasiswaBimbingan> {
  MahasiswaBimbinganProvider _mahasiswaBimbinganProvider =
      MahasiswaBimbinganProvider();
  DataShared _dataShared = DataShared();

  Future<List> _getMahasiswa() async {
    final int id = await _dataShared.getId();
    final result = await _mahasiswaBimbinganProvider.getMahasiswaBimbingan(
        context, id, "");
    return result;
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
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Mahasiswa Bimbingan"),
      ),
      body: Container(
        child: FutureBuilder<List>(
          future: _getMahasiswa(),
          builder: (context, snapshot) {
            if (snapshot.hasError) print(snapshot.error);
            return snapshot.hasData
                ? RefreshIndicator(
                    onRefresh: handleRefresh,
                    child: ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          leading: Icon(Icons.person),
                          title: Text(
                            snapshot.data[index]['nama_mahasiswa'],
                          ),
                          subtitle: Text(
                            "NIM : " + snapshot.data[index]['nim_mahasiswa'],
                          ),
                        );
                      },
                    ),
                  )
                : Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}
