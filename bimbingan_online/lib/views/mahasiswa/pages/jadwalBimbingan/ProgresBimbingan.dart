import 'dart:async';

// import 'package:bimbingan_online/models/page_aktor.dart';
import 'package:bimbingan_online/providers/jadwal_provider.dart';
import 'package:bimbingan_online/utils/assets.dart';
// import 'package:bimbingan_online/views/dosen/pages/fitur_kaprodi/dosen/comfirm_dosen.dart';
// import 'package:bimbingan_online/views/dosen/pages/fitur_kaprodi/dosen/detail_dosen.dart';
// import 'package:bimbingan_online/views/dosen/pages/fitur_kaprodi/mahasiswa/confirm_mahasiswa.dart';
// import 'package:bimbingan_online/views/register.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProgresBimbingan extends StatefulWidget {
  static const routeName = '/ProgresBimbingan';
  @override
  ProgresBimbinganState createState() => ProgresBimbinganState();
}

class ProgresBimbinganState extends State<ProgresBimbingan>
    with TickerProviderStateMixin {
  TabController tabController;

  InformasiProvider _informasiProvider = InformasiProvider();

  Future<List> _getJadwal(String status) async {
    final result = await _informasiProvider.getJadwal(context, status);
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
    tabController = new TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          ],
        ),
      ),
      body: TabBarView(
        controller: tabController,
        children: <Widget>[
          _pembimbing1(),
          _pembimbing2(),
        ],
      ),
    );
  }

  Widget _pembimbing1() {
    return Container(
      child: FutureBuilder<List>(
        future: _getJadwal("Confirm"),
        builder: (context, snapshot) {
          if (snapshot.hasError) print(snapshot.error);
          return snapshot.hasData
              ? RefreshIndicator(
                  onRefresh: handleRefresh,
                  child: ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading: Icon(Icons.schedule),
                        title: Text(
                          // snapshot.data[index]['nama_dosen']
                          "Ini adalah Jadwal Bimbingan",
                          style:
                              GoogleFonts.mcLaren(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text("Judul Skripsi"),
                        // onTap: () async {
                        //   await pushPage(
                        //     context,
                        //     DetailDosen(data: snapshot.data[index]),
                        //   );
                        //   handleRefresh();
                        // },
                      );
                    },
                  ),
                )
              : loadingCircular();
        },
      ),
    );
  }

  Widget _pembimbing2() {
    return Container(
      child: FutureBuilder<List>(
        future: _getJadwal("Pending"),
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
                            snapshot.data[index]['nama_dosen'],
                            style: GoogleFonts.mcLaren(
                                fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(
                            "BAB :" + snapshot.data[index]['nidn_dosen'],
                          ),
                          // onTap: () async {
                          //   await pushPage(
                          //     context,
                          //     ConfirmDosen(data: snapshot.data[index]),
                          //   );
                          //   handleRefresh();
                          // }
                          );
                    },
                  ),
                )
              : loadingCircular();
        },
      ),
    );
  }
}
