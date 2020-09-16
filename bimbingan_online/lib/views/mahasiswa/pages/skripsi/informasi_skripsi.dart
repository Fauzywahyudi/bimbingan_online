import 'dart:async';
// import 'dart:convert';
// import 'dart:convert';

// import 'package:bimbingan_online/models/page_aktor.dart';
import 'package:bimbingan_online/models/shared_preferenced.dart';
import 'package:bimbingan_online/providers/informasi_provider.dart';
import 'package:bimbingan_online/utils/assets.dart';
// import 'package:bimbingan_online/views/mahasiswa/pages/skripsi/detail_judul.dart';
// import 'package:bimbingan_online/views/dosen/pages/fitur_kaprodi/dosen/comfirm_dosen.dart';
// import 'package:bimbingan_online/views/dosen/pages/fitur_kaprodi/dosen/detail_dosen.dart';
// import 'package:bimbingan_online/views/dosen/pages/fitur_kaprodi/mahasiswa/confirm_mahasiswa.dart';
// import 'package:bimbingan_online/views/register.dart';
import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';

class InformasiSkripsi extends StatefulWidget {
  static const routeName = '/InformasiSkripsi';
  @override
  InformasiSkripsiState createState() => InformasiSkripsiState();
}

class InformasiSkripsiState extends State<InformasiSkripsi>
    with TickerProviderStateMixin {
  TabController tabController;
  List _dataJudul = List();
  List _dataProgres = List();
  List _dataJadwal = List();

  InformasiProvider _informasiProvider = InformasiProvider();

  // ignore: unused_element
  Future _getInformasi() async {
    DataShared dataShared = DataShared();
    int id = await dataShared.getId();
    _dataJudul =
        await _informasiProvider.getInformasi(context, id, "dataJudul");
    _dataProgres =
        await _informasiProvider.getInformasi(context, id, "dataProgres");
    _dataJadwal =
        await _informasiProvider.getInformasi(context, id, "dataJadwal");
    print(_dataJudul.toString());
    print(_dataProgres.toString());
    print(_dataJadwal.toString());
    setState(() {});
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
    tabController = new TabController(length: 3, vsync: this);
    _getInformasi();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () async {
      //     await pushPage(
      //         context,
      //         Register(
      //           pageLogin: PageAktor.isDosen,
      //         ));
      //   },
      //   child: Icon(Icons.add),
      // ),
      appBar: AppBar(
        title: Text("Informasi Skripsi"),
        bottom: TabBar(
          controller: tabController,
          labelColor: colLight,
          indicatorColor: colPrimary,
          indicatorWeight: 5,
          onTap: (v) {
            setState(() {});
          },
          tabs: <Widget>[
            Tab(
              text: "Judul Skripsi",
            ),
            Tab(
              text: "Progres",
            ),
            Tab(
              text: "Jadwal",
            ),
          ],
        ),
      ),

      body: Container(
        child: TabBarView(
          controller: tabController,
          children: <Widget>[
            // Container(),
            // Container(),
            // Container(),
            _judul(_dataJudul),
            _progres(_dataProgres),
            _jadwal(_dataJadwal),
          ],
        ),
      ),
    );
  }

  Widget _judul(List list) {
    return new ListView.builder(
      itemCount: list == null ? 0 : list.length,
      itemBuilder: (context, i) {
        if (i == 0) {
          return new Container(
            child: new Card(
              child: new ExpansionTile(
                title: new Text(list[i]['judul']),
                leading: Icon(Icons.title),
                subtitle: new Text("Judul Skripsi"),
                children: [
                  ListTile(
                    leading: Icon(Icons.schedule),
                    title: Text(
                      formatJam(list[i]['tgl_acc']) +
                          " WIB " +
                          formatTanggal(list[i]['tgl_acc']),
                    ),
                    subtitle: Text("Tanggal Acc"),
                  ),
                ],
              ),
            ),
          );
        } else {
          return new Container(
            // padding: const EdgeInsets.all(10.0),
            child: new Card(
              child: new ListTile(
                title: new Text(list[i]['nama_dosen'] + " " + list[i]['gelar']),
                leading: Icon(Icons.person),
                subtitle: new Text("Pembimbing $i"),
              ),
            ),
          );
        }
      },
    );
  }

  Widget _progres(List list) {
    return new ListView.builder(
      itemCount: list == null ? 0 : list.length,
      itemBuilder: (context, i) {
        return new Container(
          child: new Card(
            child: new ListTile(
              title: new Text("Bab " + list[i]['bab']),
              leading: list[i]['status_bahan'] == "Belum dibaca"
                  ? Icon(Icons.schedule)
                  : list[i]['status_bahan'] == "Acc"
                      ? Icon(Icons.check)
                      : Icon(Icons.refresh),
              subtitle: new Text(list[i]['status_bahan']),
            ),
          ),
        );
      },
    );
  }

  Widget _jadwal(List list) {
    return new ListView.builder(
      itemCount: list == null ? 0 : list.length,
      itemBuilder: (context, i) {
        return new Container(
          child: new Card(
            child: new ExpansionTile(
              title: new Text(list[i]['tipe_jadwal']),
              leading: Icon(Icons.schedule),
              subtitle: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                      "${formatJam(list[i]['jadwal_mulai'])} - ${formatJam(list[i]['jadwal_selesai'])} WIB"),
                  Expanded(child: Container()),
                  Text("${formatTanggal(list[i]['jadwal_selesai'])}"),
                ],
              ),
              children: [
                ListTile(
                  title:
                      Text(list[i]['penguji'].toString().replaceAll("|", "\n")),
                  subtitle: Text("Penguji"),
                  leading: Icon(Icons.person),
                ),
                ListTile(
                  title: Text(list[i]['keterangan'].toString()),
                  subtitle: Text("Keterangan"),
                  leading: Icon(Icons.info),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
