import 'package:bimbingan_online/providers/konfirmasi_provider.dart';
import 'package:bimbingan_online/providers/mahasiswa_provider.dart';
import 'package:bimbingan_online/utils/assets.dart';
import 'package:flutter/material.dart';

class ConfirmMahasiswa extends StatefulWidget {
  final data;

  const ConfirmMahasiswa({Key key, this.data}) : super(key: key);
  @override
  _ConfirmMahasiswaState createState() => _ConfirmMahasiswaState();
}

class _ConfirmMahasiswaState extends State<ConfirmMahasiswa> {
  KonfirmasiProvider _konfirmasiProvider = KonfirmasiProvider();

  void _konfirmasi(String status) async {
    await _konfirmasiProvider.konfirmasiAktor(
        context, int.parse(widget.data['id_mahasiswa']), status, "Mahasiswa");
    popPage(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.data['nama_mahasiswa']),
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              _buildListTile(
                  widget.data['nim_mahasiswa'], "NIM Mahasiswa", Icons.person),
              _buildListTile(widget.data['nama_mahasiswa'], "Nama Mahasiswa",
                  Icons.person),
              _buildListTile(widget.data['jk'], "Jenis Kelamin", Icons.wc),
              _buildListTile(widget.data['jurusan'], "Jurusan", Icons.school),
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
