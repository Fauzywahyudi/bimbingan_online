import 'package:bimbingan_online/utils/assets.dart';
import 'package:flutter/material.dart';

class DetailMahasiswa extends StatefulWidget {
  final data;

  const DetailMahasiswa({Key key, this.data}) : super(key: key);
  @override
  _DetailMahasiswaState createState() => _DetailMahasiswaState();
}

class _DetailMahasiswaState extends State<DetailMahasiswa>
    with TickerProviderStateMixin {
  // TabController tabController;

  @override
  void initState() {
    // tabController = new TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.data['nama_mahasiswa']),
        // bottom: TabBar(
        //   controller: tabController,
        //   labelColor: colLight,
        //   indicatorColor: colPrimary,
        //   indicatorWeight: 5,
        //   onTap: (v) {
        //     setState(() {});
        //   },
        //   tabs: <Widget>[
        //     Tab(text: "Mahasiswa"),
        //     Tab(text: "Skripsi"),
        //     Tab(text: "Jadwal"),
        //   ],
        // ),
      ),
      body: _buildInfoMahasiswa(),
      // body: TabBarView(
      //   controller: tabController,
      //   children: <Widget>[
      //     _buildInfoMahasiswa(),
      //     _buildInfoSkripsi(),
      //     _buildInfoJadwal(),
      //   ],
      // ),
    );
  }

  Container _buildInfoJadwal() {
    return Container();
  }

  Container _buildInfoSkripsi() {
    return Container();
  }

  Widget _buildInfoMahasiswa() {
    return Container(
      child: SingleChildScrollView(
        child: Column(
          children: [
            // Container(
            //   height: 200,
            //   decoration: BoxDecoration(
            //     color: colPrimary,
            //   ),
            // ),
            _buildListTile(
                widget.data['nim_mahasiswa'], "NIM Mahasiswa", Icons.person),
            _buildListTile(
                widget.data['nama_mahasiswa'], "Nama Mahasiswa", Icons.person),
            _buildListTile(widget.data['jk'], "Jenis Kelamin", Icons.wc),
            _buildListTile(widget.data['jurusan'], "Jurusan", Icons.school),
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
