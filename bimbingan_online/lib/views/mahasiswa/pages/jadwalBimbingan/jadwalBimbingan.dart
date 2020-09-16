import 'dart:async';
// import 'dart:convert';
// import 'dart:convert';

// import 'package:bimbingan_online/models/page_aktor.dart';
import 'package:bimbingan_online/models/shared_preferenced.dart';
import 'package:bimbingan_online/providers/jadwalBimbinganMhs_provider.dart';
import 'package:bimbingan_online/utils/assets.dart';
import 'package:bimbingan_online/views/mahasiswa/pages/jadwalBimbingan/detailJadwalBimbingan.dart';
// import 'package:bimbingan_online/views/mahasiswa/pages/skripsi/detail_judul.dart';
// import 'package:bimbingan_online/views/dosen/pages/fitur_kaprodi/dosen/comfirm_dosen.dart';
// import 'package:bimbingan_online/views/dosen/pages/fitur_kaprodi/dosen/detail_dosen.dart';
// import 'package:bimbingan_online/views/dosen/pages/fitur_kaprodi/mahasiswa/confirm_mahasiswa.dart';
// import 'package:bimbingan_online/views/register.dart';
import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';

class JadwalBimbingan extends StatefulWidget {
  static const routeName = '/JadwalBimbingan';
  @override
  JadwalBimbinganState createState() => JadwalBimbinganState();
}

class JadwalBimbinganState extends State<JadwalBimbingan>
    with TickerProviderStateMixin {
  TabController tabController;
  List _dataPembimbing1 = List();
  // List _dataProgres = List();
  List _dataPembimbing2 = List();

  JadwalMhsProvider _jadwalMhsProvider = JadwalMhsProvider();

  // ignore: unused_element
  Future _getJadwal() async {
    DataShared dataShared = DataShared();
    int id = await dataShared.getId();
    _dataPembimbing1 =
        await _jadwalMhsProvider.getJadwal(context, id, "dataPembimbing1");
    // _dataProgres =
    //     await _jadwalMhsProvider.getJadwal(context, id, "dataProgres");
    _dataPembimbing2 =
        await _jadwalMhsProvider.getJadwal(context, id, "dataPembimbing2");
    print(_dataPembimbing1.toString());
    // // print(_dataProgres.toString());
    print(_dataPembimbing2.toString());
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
    tabController = new TabController(length: 2, vsync: this);
    _getJadwal();
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
        title: Text("Jadwal Bimbingan"),
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
              text: "Pembimbing 1",
            ),
            Tab(
              text: "Pembimbing 2",
            ),
            // Tab(
            //   text: "Jadwal",
            // ),
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
            _pembimbing1(_dataPembimbing1),
            _pembimbing2(_dataPembimbing2),
          ],
        ),
      ),
    );
  }

  // Widget _pembimbing1(List list) {
  //   return new ListView.builder(
  //     itemCount: list == null ? 0 : list.length,
  //     itemBuilder: (context, i) {
  //       if (i == 0) {
  //         return new Container(
  //           child: new Card(
  //             child: new ExpansionTile(
  //               title: new Text(list[i]['judul']),
  //               leading: Icon(Icons.title),
  //               subtitle: new Text("Judul Skripsi"),
  //               children: [
  //                 ListTile(
  //                   leading: Icon(Icons.schedule),
  //                   title: Text(
  //                     formatJam(list[i]['tgl_acc']) +
  //                         " WIB " +
  //                         formatTanggal(list[i]['tgl_acc']),
  //                   ),
  //                   subtitle: Text("Tanggal Acc"),
  //                 ),
  //               ],
  //             ),
  //           ),
  //         );
  //       } else {
  //         return new Container(
  //           // padding: const EdgeInsets.all(10.0),
  //           child: new Card(
  //             child: new ListTile(
  //               title: new Text(list[i]['nama_dosen'] + " " + list[i]['gelar']),
  //               leading: Icon(Icons.person),
  //               subtitle: new Text("Pembimbing $i"),
  //             ),
  //           ),
  //         );
  //       }
  //     },
  //   );
  // }

  Widget _pembimbing1(List list) {
    return new ListView.builder(
      itemCount: list == null ? 0 : list.length,
      itemBuilder: (context, i) {
        return new Container(
          child: new Card(
            child: new ExpansionTile(
              title: new Text("Bimbingan ke-${i + 1}"),
              leading: Icon(Icons.schedule),
              children: [
                ListTile(
                  title: Text(list[i]['keterangan']),
                  leading: Icon(Icons.info),
                ),
                RaisedButton(
                  color: colPrimary,
                  child: new Text("Detail"),
                  textColor: Colors.white,
                  onPressed: () =>
                      Navigator.of(context).push(new MaterialPageRoute(
                          builder: (BuildContext context) => new DetailJadwal(
                                // list: list,
                                // index: i,
                                listData: list[i],
                              ))),
                )
              ],
              subtitle: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                      "${formatJam(list[i]['jadwal_mulai'])} - ${formatJam(list[i]['jadwal_selesai'])} WIB"),
                  Expanded(child: Container()),
                  Text("${formatTanggal(list[i]['jadwal_selesai'])}"),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  // Widget _progres(List list) {
  //   return new ListView.builder(
  //     itemCount: list == null ? 0 : list.length,
  //     itemBuilder: (context, i) {
  //       return new Container(
  //         child: new Card(
  //           child: new ListTile(
  //             title: new Text("Bab " + list[i]['bab']),
  //             leading: list[i]['status_bahan'] == "Belum dibaca"
  //                 ? Icon(Icons.schedule)
  //                 : list[i]['status_bahan'] == "Acc"
  //                     ? Icon(Icons.check)
  //                     : Icon(Icons.refresh),
  //             subtitle: new Text(list[i]['status_bahan']),
  //           ),
  //         ),
  //       );
  //     },
  //   );
  // }

  Widget _pembimbing2(List list) {
    return new ListView.builder(
      itemCount: list == null ? 0 : list.length,
      itemBuilder: (context, i) {
        return new Container(
          child: new Card(
            child: new ListTile(
              title: new Text(list[i]['nama_dosen']),
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
            ),
          ),
        );
      },
    );
  }
}
