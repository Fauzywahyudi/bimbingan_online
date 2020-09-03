// import 'package:flutter/material.dart';

// class ConfirmMahasiswa extends StatefulWidget {
//   final data;

//   const ConfirmMahasiswa({Key key, this.data}) : super(key: key);
//   @override
//   _ConfirmMahasiswaState createState() => _ConfirmMahasiswaState();
// }

// class _ConfirmMahasiswaState extends State<ConfirmMahasiswa> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.data['nama_mahasiswa']),
//       ),
//       body: Container(
//         child: SingleChildScrollView(
//           child: Column(
//             children: [
//               _buildListTile(
//                   widget.data['nim_mahasiswa'], "NIM Mahasiswa", Icons.person),
//               _buildListTile(widget.data['nama_mahasiswa'], "Nama Mahasiswa",
//                   Icons.person),
//               _buildListTile(widget.data['nama_mahasiswa'], "Nama Mahasiswa",
//                   Icons.person),
//               _buildListTile(widget.data['nama_mahasiswa'], "Nama Mahasiswa",
//                   Icons.person),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   ListTile _buildListTile(String title, String subTitle, IconData icon) {
//     return ListTile(
//         leading: Icon(icon), title: Text(title), subtitle: Text(subtitle));
//   }
// }
