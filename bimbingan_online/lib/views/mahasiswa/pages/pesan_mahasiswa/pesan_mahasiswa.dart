import 'dart:async';
import 'package:bimbingan_online/models/shared_preferenced.dart';
import 'package:bimbingan_online/providers/jadwal_bimbingan_provider.dart';
import 'package:bimbingan_online/providers/mahasiswa_provider.dart';
import 'package:bimbingan_online/utils/assets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PesanMahasiswa extends StatefulWidget {
  static const routeName = '/PesanMahasiswa';
  @override
  _PesanMahasiswaState createState() => _PesanMahasiswaState();
}

class _PesanMahasiswaState extends State<PesanMahasiswa>
    with TickerProviderStateMixin {
  TabController tabController;
  int idDosen1;
  int idDosen2;

  Future _getDosen() async {
    DataShared dataShared = DataShared();
    MahasiswaProvider mahasiswaProvider = MahasiswaProvider();
    int idMahasiswa = await dataShared.getId();

    final result =
        await mahasiswaProvider.getJudulMahasiswa(context, idMahasiswa);
    setState(() {
      idDosen1 = int.parse(result[0]['pembimbing1']);
      idDosen2 = int.parse(result[0]['pembimbing2']);
    });
  }

  Future<List> _getJadwal(int idDosen) async {
    JadwalBimbinganProvider _provider = JadwalBimbinganProvider();
    final result = await _provider.getJadwalByDosen(context, idDosen);
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
    _getDosen();
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
        title: Text("Pesan"),
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
          idDosen1 == null ? Container() : _buildPemb1(),
          idDosen2 == null ? Container() : _buildPemb2(),
        ],
      ),
    );
  }

  Widget _buildPemb1() {
    return Container(
      child: FutureBuilder<List>(
        future: _getJadwal(idDosen1),
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
                          "Bimbinngan ke-${index + 1}",
                          style:
                              GoogleFonts.mcLaren(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                                "${formatJam(snapshot.data[index]['jadwal_mulai'])} - ${formatJam(snapshot.data[index]['jadwal_selesai'])} WIB"),
                            Expanded(child: Container()),
                            Text(
                                "${formatTanggal(snapshot.data[index]['jadwal_selesai'])}"),
                          ],
                        ),
                        onTap: () async {
                          // await pushPage(
                          //   context,
                          //   DetailDosen(data: snapshot.data[index]),
                          // );
                          // handleRefresh();
                        },
                      );
                    },
                  ),
                )
              : loadingCircular();
        },
      ),
    );
  }

  Widget _buildPemb2() {
    return Container(
      child: FutureBuilder<List>(
        future: _getJadwal(idDosen2),
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
                            snapshot.data[index]['nama_dosen'],
                            style: GoogleFonts.mcLaren(
                                fontWeight: FontWeight.bold),
                          ),
                          subtitle: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                  "${formatJam(snapshot.data[index]['jadwal_mulai'])} - ${formatJam(snapshot.data[index]['jadwal_selesai'])} WIB"),
                              Expanded(child: Container()),
                              Text(
                                  "${formatTanggal(snapshot.data[index]['jadwal_selesai'])}"),
                            ],
                          ),
                          onTap: () async {
                            // await pushPage(
                            //   context,
                            //   ConfirmDosen(data: snapshot.data[index]),
                            // );
                            // handleRefresh();
                          });
                    },
                  ),
                )
              : loadingCircular();
        },
      ),
    );
  }
}
