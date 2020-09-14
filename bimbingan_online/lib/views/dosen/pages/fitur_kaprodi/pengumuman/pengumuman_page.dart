import 'dart:async';
import 'package:bimbingan_online/providers/pengumuman_provider.dart';
import 'package:bimbingan_online/utils/assets.dart';
import 'package:bimbingan_online/views/dosen/pages/fitur_kaprodi/pengumuman/tambah_pengumuman.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PengumumanPage extends StatefulWidget {
  static const routeName = '/InformasiPage';
  @override
  _PengumumanPageState createState() => _PengumumanPageState();
}

class _PengumumanPageState extends State<PengumumanPage> {
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
        title: Text("Pengumuman"),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        tooltip: "Tambah Pengumuman",
        onPressed: () async {
          await pushNamePage(context, TambahPengumuman.routeName);
          handleRefresh();
        },
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
                        return ExpansionTile(
                          leading: Icon(Icons.info),
                          title: Text(
                            snapshot.data[index]['judul_pengumuman'],
                            style: GoogleFonts.mcLaren(),
                          ),
                          // subtitle: Text(snapshot.data[index]['tgl_post']),
                          children: [
                            ListTile(
                              leading: Icon(Icons.stop),
                              title:
                                  Text(snapshot.data[index]['tipe_pengumuman']),
                              subtitle: Text("Tipe"),
                            ),
                            ListTile(
                              leading: Icon(Icons.stop),
                              title: Text(snapshot.data[index]['status']),
                              subtitle: Text("Status"),
                            ),
                            ListTile(
                              leading: Icon(Icons.stop),
                              title: Text(snapshot.data[index]['keterangan']),
                              subtitle: Text("Keterangan"),
                            ),
                            // ListTile(
                            //   title: Text(formatJam(snapshot.data[index]
                            //           ['tgl_post'] +
                            //       " " +
                            //       formatTanggal(
                            //           snapshot.data[index]['tgl_post']))),
                            // ),
                          ],
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
