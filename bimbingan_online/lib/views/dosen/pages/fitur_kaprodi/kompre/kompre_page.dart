import 'dart:async';

import 'package:bimbingan_online/providers/jadwal_skripsi_provider.dart';
import 'package:bimbingan_online/utils/assets.dart';
import 'package:bimbingan_online/views/dosen/pages/fitur_kaprodi/kompre/add_jadwal_kompre.dart';
import 'package:flutter/material.dart';

class KomprePage extends StatefulWidget {
  static const routeName = '/KomprePage';
  @override
  _KomprePageState createState() => _KomprePageState();
}

class _KomprePageState extends State<KomprePage> with TickerProviderStateMixin {
  TabController tabController;
  JadwalSkripsiProvider _jadwalSkripsiProvider = JadwalSkripsiProvider();

  @override
  void initState() {
    tabController = new TabController(length: 2, vsync: this);
    super.initState();
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
      floatingActionButton: _buildFab(),
      body: TabBarView(
        controller: tabController,
        children: <Widget>[
          _buildSeminar(),
          _buildKompre(),
        ],
      ),
    );
  }

  FloatingActionButton _buildFab() {
    return FloatingActionButton(
      child: Icon(Icons.add),
      onPressed: () async {
        await pushPage(context, AddJadwalKompre());
        handleRefresh();
      },
      tooltip: "Tambah Jadwal",
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: Text("Jadwal"),
      bottom: TabBar(
        controller: tabController,
        labelColor: colLight,
        indicatorColor: colPrimary,
        indicatorWeight: 5,
        onTap: (v) {
          setState(() {});
        },
        tabs: <Widget>[
          Tab(text: "Seminar Proposal"),
          Tab(text: "Kompre"),
        ],
      ),
    );
  }

  Widget _buildSeminar() {
    return Container(
      child: FutureBuilder<List>(
        future: _jadwalSkripsiProvider.getJadwalSkripsi(context, "Sempro"),
        builder: (context, snapshot) {
          if (snapshot.hasError) print(snapshot.error);
          return snapshot.hasData
              ? RefreshIndicator(
                  onRefresh: handleRefresh,
                  child: ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {
                      return _itemListJadwal(snapshot.data[index]);
                    },
                  ),
                )
              : Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  Card _itemListJadwal(var data) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListTile(
          leading: Icon(
            Icons.schedule,
            color: colPrimary,
          ),
          subtitle: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                  "${formatJam(data['jadwal_mulai'])} - ${formatJam(data['jadwal_selesai'])} WIB"),
              Expanded(
                child: Container(),
              ),
              Text("${formatTanggal(data['jadwal_selesai'])}"),
            ],
          ),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(data['nama_mahasiswa']),
              Divider(),
            ],
          ),
          trailing: IconButton(
            color: colSuccess,
            icon: Icon(Icons.play_arrow),
            onPressed: () {},
            tooltip: "Selesai",
          ),
        ),
      ),
    );
  }

  Widget _buildKompre() {
    return Container(
      child: FutureBuilder<List>(
        future: _jadwalSkripsiProvider.getJadwalSkripsi(context, "Kompre"),
        builder: (context, snapshot) {
          if (snapshot.hasError) print(snapshot.error);
          return snapshot.hasData
              ? RefreshIndicator(
                  onRefresh: handleRefresh,
                  child: ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {
                      return _itemListJadwal(snapshot.data[index]);
                    },
                  ),
                )
              : Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
