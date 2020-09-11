import 'dart:async';

import 'package:bimbingan_online/models/shared_preferenced.dart';
import 'package:bimbingan_online/providers/jadwal_bimbingan_provider.dart';
import 'package:bimbingan_online/utils/assets.dart';
import 'package:bimbingan_online/views/dosen/pages/menu_dosen/daftar_bimbingan/detail_bimbingan.dart';
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

  void _selesai(int idBimbingan) async {
    JadwalBimbinganProvider _jadwalBimbingan = JadwalBimbinganProvider();
    await _jadwalBimbingan.setSelesaiJadwal(context, idBimbingan);
    handleRefresh();
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
                      return _itemListJadwal(snapshot.data[index], false);
                    },
                  ),
                )
              : Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  Card _itemListJadwal(var data, bool selesai) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListTile(
          leading: selesai
              ? Icon(
                  Icons.check_box,
                  color: colSuccess,
                )
              : Icon(
                  Icons.schedule,
                  color: colPrimary,
                ),
          subtitle: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                  "${formatJam(data['jadwal_mulai'])} - ${formatJam(data['jadwal_selesai'])} WIB"),
              Expanded(child: Container()),
              Text("${formatTanggal(data['jadwal_selesai'])}"),
            ],
          ),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(data['keterangan']),
              Divider(),
            ],
          ),
          trailing: selesai
              ? null
              : IconButton(
                  color: colSuccess,
                  icon: Icon(Icons.check),
                  onPressed: () => _selesai(int.parse(data['id_bimbingan'])),
                  tooltip: "Selesai",
                ),
          onTap: () => pushPage(
              context,
              DetailBimbingan(
                data: data,
              )),
        ),
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
                      return _itemListJadwal(snapshot.data[index], true);
                    },
                  ),
                )
              : Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
