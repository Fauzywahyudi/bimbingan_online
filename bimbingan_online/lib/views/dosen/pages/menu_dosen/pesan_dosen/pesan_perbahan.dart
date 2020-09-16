// import 'dart:async';

// import 'package:bimbingan_online/models/shared_preferenced.dart';
// import 'package:bimbingan_online/providers/pesan_provider.dart';
// import 'package:bimbingan_online/utils/assets.dart';
// import 'package:flutter/material.dart';

// class PesanPerBahan extends StatefulWidget {
//   @override
//   _PesanPerBahanState createState() => _PesanPerBahanState();
// }

// class _PesanPerBahanState extends State<PesanPerBahan> {
//   DataShared _dataShared = DataShared();
//   PesanProvider _pesanProvider = PesanProvider();
//   Future<List> _getPesan() async {
//     int idDosen = await _dataShared.getId();
//     final result = await _pesanProvider.getPesan(context, idDosen, 0, "group");

//     return result;
//   }

//   @override
//   void initState() {
//     super.initState();
//     _getPesan();
//   }

//   Future<Null> handleRefresh() async {
//     Completer<Null> completer = new Completer<Null>();
//     new Future.delayed(new Duration(milliseconds: 500)).then((_) {
//       completer.complete();
//       setState(() {});
//     });
//     return completer.future;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Pesan"),
//       ),
//       body: Container(
//         child: FutureBuilder<List>(
//           future: _getPesan(),
//           builder: (context, snapshot) {
//             if (snapshot.hasError) print(snapshot.error);
//             return snapshot.hasData ? _buildList(snapshot) : loadingCircular();
//           },
//         ),
//       ),
//     );
//   }

//   Widget _buildList(AsyncSnapshot<List> snapshot) {
//     return RefreshIndicator(
//       onRefresh: handleRefresh,
//       child: ListView.builder(
//         itemCount: snapshot.data.length,
//         itemBuilder: (context, index) {
//           return ListTile(
//             onTap: () {},
//             leading: Icon(Icons.person),
//             title: Text(snapshot.data[index]['nama_mahasiswa']),
//             subtitle: Text("NIM :" + snapshot.data[index]['nim_mahasiswa']),
//           );
//         },
//       ),
//     );
//   }
// }
