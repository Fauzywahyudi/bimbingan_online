import 'dart:async';

import 'package:bimbingan_online/providers/pengumuman_provider.dart';
import 'package:bimbingan_online/utils/assets.dart';
import 'package:bimbingan_online/views/dosen/pages/menu_dosen/notifikasi_dosen/detail_notifikasi.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NotifikasiDosen extends StatefulWidget {
  static const routeName = '/NotifikasiDosen';
  @override
  _NotifikasiDosenState createState() => _NotifikasiDosenState();
}

class _NotifikasiDosenState extends State<NotifikasiDosen> {
  PengumumanProvider _pengumumanProvider = PengumumanProvider();

  Future<List> _getPengumuman(String status) async {
    final result = await _pengumumanProvider.getPengumuman(context, status);
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Notifikasi"),
      ),
      body: Container(
        child: FutureBuilder<List>(
          future: _getPengumuman(""),
          builder: (context, snapshot) {
            if (snapshot.hasError) print(snapshot.error);
            return snapshot.hasData
                ? RefreshIndicator(
                    onRefresh: handleRefresh,
                    child: ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          leading: Icon(Icons.info),
                          title: Text(
                            snapshot.data[index]['judul_pengumuman'],
                            style: GoogleFonts.mcLaren(),
                          ),
                          onTap: () => pushPage(context,
                              DetailNotifikasi(data: snapshot.data[index])),
                        );
                      },
                    ),
                  )
                : loadingCircular();
          },
        ),
      ),
    );
  }
}
