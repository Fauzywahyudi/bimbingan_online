import 'package:bimbingan_online/providers/konfirmasi_provider.dart';
import 'package:bimbingan_online/utils/assets.dart';
import 'package:flutter/material.dart';

class ConfirmDosen extends StatefulWidget {
  final data;

  const ConfirmDosen({Key key, this.data}) : super(key: key);
  @override
  _ConfirmDosenState createState() => _ConfirmDosenState();
}

class _ConfirmDosenState extends State<ConfirmDosen> {
  KonfirmasiProvider _konfirmasiProvider = KonfirmasiProvider();

  void _konfirmasi(String status) async {
    await _konfirmasiProvider.konfirmasiAktor(
        context, int.parse(widget.data['id_dosen']), status, "Dosen");
    popPage(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.data['nama_dosen']),
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              _buildListTile(
                  widget.data['nidn_dosen'], "NIDN Dosen", Icons.person),
              _buildListTile(
                  widget.data['nama_dosen'] + " " + widget.data['gelar'],
                  "Nama Dosen",
                  Icons.person),
              _buildListTile(widget.data['jk'], "Jenis Kelamin", Icons.wc),
              _buildListTile(widget.data['jabatan'], "Jabatan", Icons.school),
              _buildListTile(widget.data['alamat'], "Alamat", Icons.home),
              _buildListTile(widget.data['nohp'], "No. Handphone", Icons.call),
              _buildListTile(widget.data['tgl_daftar'], "Tanggal Daftar",
                  Icons.date_range),
              SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: colDanger,
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      tooltip: 'Batalkan',
                      icon: Icon(Icons.close),
                      color: colLight,
                      onPressed: () => _konfirmasi("Reject"),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: colSuccess,
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      tooltip: 'Konfirmasi',
                      icon: Icon(Icons.check),
                      color: colLight,
                      onPressed: () => _konfirmasi("Confirm"),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  ListTile _buildListTile(String title, String subTitle, IconData icon) {
    return ListTile(
        leading: Icon(icon), title: Text(title), subtitle: Text(subTitle));
  }
}
