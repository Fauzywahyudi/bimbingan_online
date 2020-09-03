import 'dart:async';

import 'package:bimbingan_online/providers/mahasiswa_provider.dart';
import 'package:bimbingan_online/utils/assets.dart';
import 'package:bimbingan_online/views/dosen/pages/fitur_kaprodi/mahasiswa/confirm_mahasiswa.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MahasiswaPage extends StatefulWidget {
  static const routeName = '/MahasiswaPage';
  @override
  MahasiswaPageState createState() => MahasiswaPageState();
}

class MahasiswaPageState extends State<MahasiswaPage>
    with TickerProviderStateMixin {
  TabController tabController;

  MahasiswaProvider _mahasiswaProvider = MahasiswaProvider();

  Future<List> _getMahasiswa(String status) async {
    final result = await _mahasiswaProvider.getMahasiswa(context, status);
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
      appBar: AppBar(
        title: Text("Mahasiswa"),
        bottom: TabBar(
          controller: tabController,
          labelColor: colLight,
          indicatorColor: colPrimary,
          indicatorWeight: 5,
          onTap: (v) {
            setState(() {
              // model.scrollController.position.setPixels(0);
              // model.isSearch = false;
              // model.searchTransaksi.text = "";
              // model.wordSearch1 = "";
              // model.wordSearch2 = "";
              // model.foc_search.unfocus();
            });
          },
          tabs: <Widget>[
            Tab(
              text: "Confirm",
            ),
            Tab(
              text: "Pending",
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: tabController,
        children: <Widget>[
          _buildConfirm(),
          _buildPending(),
        ],
      ),
    );
  }

  Widget _buildConfirm() {
    return Container(
      child: FutureBuilder<List>(
        future: _getMahasiswa("Confirm"),
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
                          style:
                              GoogleFonts.mcLaren(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(
                            "NIM :" + snapshot.data[index]['nim_mahasiswa']),
                      );
                    },
                  ),
                )
              : loadingCircular();
        },
      ),
    );
  }

  Widget _buildPending() {
    return Container(
      child: FutureBuilder<List>(
        future: _getMahasiswa("Pending"),
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
                            style: GoogleFonts.mcLaren(
                                fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(
                            "NIM :" + snapshot.data[index]['nim_mahasiswa'],
                          ),
                          onTap: () async {
                            await pushPage(
                              context,
                              ConfirmMahasiswa(data: snapshot.data[index]),
                            );
                            handleRefresh();
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
