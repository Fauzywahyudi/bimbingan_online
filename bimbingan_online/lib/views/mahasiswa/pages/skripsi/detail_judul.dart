import 'package:bimbingan_online/utils/assets.dart';
import 'package:flutter/material.dart';

class DetailJudul extends StatefulWidget {
  final data;

  const DetailJudul({Key key, this.data, listData}) : super(key: key);
  @override
  _DetailJudulState createState() => _DetailJudulState();
}

class _DetailJudulState extends State<DetailJudul>
    with TickerProviderStateMixin {
  TabController tabController;

  @override
  void initState() {
    tabController = new TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.data['nama_dosen']),
        bottom: TabBar(
          controller: tabController,
          labelColor: colLight,
          indicatorColor: colPrimary,
          indicatorWeight: 5,
          onTap: (v) {
            setState(() {});
          },
          tabs: <Widget>[
            Tab(text: "Informasi"),
            Tab(text: "Mahasiswa"),
            Tab(text: "Jadwal"),
          ],
        ),
      ),
      body: TabBarView(
        controller: tabController,
        children: <Widget>[
          _buildInfoDosen(),
          _buildInfoSkripsi(),
          _buildInfoJadwal(),
        ],
      ),
    );
  }

  Container _buildInfoJadwal() {
    return Container();
  }

  Container _buildInfoSkripsi() {
    return Container();
  }

  Widget _buildInfoDosen() {
    return Container(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 200,
              decoration: BoxDecoration(
                color: colPrimary,
              ),
            ),
            _buildListTile(
                widget.data['nidn_dosen'], "NIDN DOsen", Icons.person),
            _buildListTile(
                widget.data['nama_dosen'] + " " + widget.data['gelar'],
                "Nama Dosen",
                Icons.person),
            _buildListTile(widget.data['jk'], "Jenis Kelamin", Icons.wc),
            _buildListTile(widget.data['jabatan'], "Jurusan", Icons.school),
            _buildListTile(widget.data['alamat'], "Alamat", Icons.home),
            _buildListTile(widget.data['nohp'], "No. Handphone", Icons.call),
            _buildListTile(
                widget.data['tgl_daftar'], "Tanggal Daftar", Icons.date_range),
          ],
        ),
      ),
    );
  }

  ListTile _buildListTile(String title, String subTitle, IconData icon) {
    return ListTile(
        leading: Icon(icon), title: Text(title), subtitle: Text(subTitle));
  }
}
