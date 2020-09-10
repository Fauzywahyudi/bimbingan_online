import 'dart:async';

import 'package:bimbingan_online/models/shared_preferenced.dart';
import 'package:bimbingan_online/providers/jadwal_bimbingan_provider.dart';
import 'package:bimbingan_online/utils/assets.dart';
import 'package:flutter/material.dart';

import 'tambah_jadwal_bimbingan.dart';

class DaftarBimbingan extends StatefulWidget {
  static const routeName = '/DaftarBimbinganDosen';
  @override
  _DaftarBimbinganState createState() => _DaftarBimbinganState();
}

class _DaftarBimbinganState extends State<DaftarBimbingan>
    with TickerProviderStateMixin {
  TabController tabController;

  @override
  void initState() {
    tabController = new TabController(length: 2, vsync: this);
    super.initState();
  }

  Future<List> _getData(String status) async {
    DataShared _dataShared = DataShared();
    JadwalBimbinganProvider _jadwalBimbingan = JadwalBimbinganProvider();
    final int idDosen = await _dataShared.getId();
    final result =
        await _jadwalBimbingan.getJadwalBimbingan(context, idDosen, status);
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
      appBar: _buildAppBar(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () async {
          await pushNamePage(context, TambahJadwalBimbingan.routeName);
          handleRefresh();
        },
      ),
      body: TabBarView(
        controller: tabController,
        children: <Widget>[
          _buildDatang(),
          _buildSelesai(),
        ],
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: Text("Daftar Jadwal Bimbingan"),
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
            text: "Akan Datang",
          ),
          Tab(
            text: "Selesai",
          ),
        ],
      ),
    );
  }

  Widget _buildDatang() {
    return Container(
      child: FutureBuilder<List>(
        future: _getData("Akan datang"),
        builder: (context, snapshot) {
          if (snapshot.hasError) print(snapshot.error);
          return snapshot.hasData
              ? RefreshIndicator(
                  onRefresh: handleRefresh,
                  child: ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text("Bimbingan ke-${index + 1}"),
                      );
                    },
                  ),
                )
              : Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  Widget _buildSelesai() {
    return Container(
      child: FutureBuilder<List>(
        future: _getData("Selesai"),
        builder: (context, snapshot) {
          if (snapshot.hasError) print(snapshot.error);
          return snapshot.hasData
              ? RefreshIndicator(
                  onRefresh: handleRefresh,
                  child: ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text("Bimbingan ke-${index + 1}"),
                      );
                    },
                  ),
                )
              : Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
