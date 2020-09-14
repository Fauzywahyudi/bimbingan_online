import 'dart:async';
import 'dart:io';

import 'package:bimbingan_online/providers/dosen_provider.dart';
import 'package:bimbingan_online/providers/judul_provider.dart';
import 'package:bimbingan_online/utils/assets.dart';
import 'package:bimbingan_online/utils/assets/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:http/http.dart' as http;
import 'package:bimbingan_online/utils/link.dart' as link;
import 'package:path_provider/path_provider.dart';

class AccJudul extends StatefulWidget {
  final data;

  const AccJudul({Key key, this.data}) : super(key: key);

  @override
  _AccJudulState createState() => _AccJudulState();
}

class _AccJudulState extends State<AccJudul> {
  String _pembimbing1 = "";
  String _pembimbing2 = "";
  DosenProvider _dosenProvider = DosenProvider();
  JudulProvider _judulProvider = JudulProvider();
  int _idPembimbing1;
  int _idPembimbing2;

  void _setPembimbing1(var list) {
    setState(() {
      if (_idPembimbing2 == int.parse(list['id_dosen'])) {
        messageInfo(context, "Dosen Pembimbing harus berbeda");
      } else {
        _idPembimbing1 = int.parse(list['id_dosen']);
        _pembimbing1 = list['nama_dosen'] + " " + list['gelar'];
      }
    });
  }

  void _setPembimbing2(var list) {
    setState(() {
      if (_idPembimbing1 == int.parse(list['id_dosen'])) {
        messageInfo(context, "Dosen Pembimbing harus berbeda");
      } else {
        _idPembimbing2 = int.parse(list['id_dosen']);
        _pembimbing2 = list['nama_dosen'] + " " + list['gelar'];
      }
    });
  }

  // void _download() async {
  //   final taskId = await FlutterDownloader.enqueue(
  //     url: 'your download link',
  //     savedDir: 'the path of directory where you want to save downloaded files',
  //     showNotification:
  //         true, // show download progress in status bar (for Android)
  //     openFileFromNotification:
  //         true, // click on notification to open downloaded file (for Android)
  //   );
  // }

  Future<File> _downloadFile(String filename) async {
    http.Client client = new http.Client();
    var req = await client
        .get(link.Link.proposal + "downloadProposal.php?file=$filename");
    var bytes = req.bodyBytes;
    String dir = (await getApplicationDocumentsDirectory()).path;
    File file = new File('$dir/$filename');
    await file.writeAsBytes(bytes);
    return file;
  }

  var _boxDecor = BoxDecoration(
      // color: colPrimary,
      borderRadius: BorderRadius.only(
    topLeft: Radius.circular(20),
    topRight: Radius.circular(20),
  ));

  Future<Null> handleRefresh() async {
    Completer<Null> completer = new Completer<Null>();
    new Future.delayed(new Duration(milliseconds: 500)).then((_) {
      completer.complete();
      setState(() {});
    });
    return completer.future;
  }

  void _showModal(String dospem) {
    showMaterialModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      builder: (context, scrollController) => Container(
        height: 500,
        decoration: _boxDecor,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 75,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                  color: colLight,
                ),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: "Cari Dosen...",
                    border: InputBorder.none,
                    prefixIcon: Icon(Icons.search),
                  ),
                ),
              ),
              Container(
                color: colLight,
                height: 425,
                child: FutureBuilder<List>(
                  future: _getDosen(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) print(snapshot.error);
                    return snapshot.hasData
                        ? RefreshIndicator(
                            onRefresh: handleRefresh,
                            child: ListView.builder(
                              itemCount: snapshot.data.length,
                              itemBuilder: (context, index) {
                                return Card(
                                  child: ListTile(
                                      key: ValueKey(
                                          snapshot.data[index]['id_dosen']),
                                      title: Text(snapshot.data[index]
                                              ['nama_dosen'] +
                                          " " +
                                          snapshot.data[index]['gelar']),
                                      trailing: OutlineButton(
                                          onPressed: () {
                                            setState(() {
                                              if (dospem == "dospem1") {
                                                _setPembimbing1(
                                                    snapshot.data[index]);
                                              } else {
                                                _setPembimbing2(
                                                    snapshot.data[index]);
                                              }
                                              popPage(context);
                                            });
                                          },
                                          child: Text("Select"))),
                                );
                              },
                            ),
                          )
                        : Center(child: CircularProgressIndicator());
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<List> _getDosen() async {
    final result = await _dosenProvider.getDosen(context, "Confirm");
    return result;
  }

  void _accJudul() async {
    await _judulProvider.accJudul(
      context,
      int.parse(widget.data['id_mahasiswa']),
      widget.data['judul'],
      _idPembimbing1,
      _idPembimbing2,
      int.parse(widget.data['id_proposal']),
    );
    popPage(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Acc Judul")),
      floatingActionButton: _buildFab(),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Card(
                child: Column(
                  children: [
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                      child: Text(
                        "Prosposal",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                    _buildListTile(widget.data['nim_mahasiswa'],
                        "NIM Mahasiswa", Icons.person),
                    _buildListTile(widget.data['nama_mahasiswa'],
                        "Nama Mahasiswa", Icons.person),
                    _buildListTile(
                        widget.data['judul'], "Judul Proposal", Icons.title),
                    _buildListTile(
                      widget.data['file'],
                      "File Document",
                      Icons.note_add,
                      trailing: IconButton(
                        icon: Icon(Icons.file_download),
                        onPressed: () => _downloadFile(widget.data['file']),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
              Card(
                child: Column(
                  children: [
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                      child: Text(
                        "Dosen Pembimbing",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      padding:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Pembimbing 1"),
                          Row(
                            children: [
                              Expanded(child: Container()),
                              _pembimbing1.isEmpty || _pembimbing1 == null
                                  ? OutlineButton(
                                      color: colPrimary,
                                      onPressed: () => _showModal("dospem1"),
                                      child: Text("Pilih Dosen"))
                                  : Text(
                                      _pembimbing1,
                                      style: GoogleFonts.mcLaren(fontSize: 16),
                                    ),
                              _pembimbing1.isEmpty || _pembimbing1 == null
                                  ? Container()
                                  : IconButton(
                                      icon: Icon(Icons.close),
                                      onPressed: () {
                                        setState(() {
                                          _pembimbing1 = "";
                                          _idPembimbing1 = null;
                                        });
                                      }),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      padding:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Pembimbing 2"),
                          Row(
                            children: [
                              Expanded(child: Container()),
                              _pembimbing2.isEmpty || _pembimbing2 == null
                                  ? OutlineButton(
                                      color: colPrimary,
                                      onPressed: () => _showModal("dospem2"),
                                      child: Text("Pilih Dosen"))
                                  : Text(
                                      _pembimbing2,
                                      style: GoogleFonts.mcLaren(fontSize: 16),
                                    ),
                              _pembimbing2.isEmpty || _pembimbing2 == null
                                  ? Container()
                                  : IconButton(
                                      icon: Icon(Icons.close),
                                      onPressed: () {
                                        setState(() {
                                          _pembimbing2 = "";
                                          _idPembimbing2 = null;
                                        });
                                      }),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  FloatingActionButton _buildFab() {
    if (_idPembimbing1 == null || _idPembimbing2 == null) {
      return null;
    } else {
      return FloatingActionButton(
        child: Icon(Icons.check),
        onPressed: () => _accJudul(),
      );
    }
  }

  ListTile _buildListTile(String title, String subTitle, IconData icon,
      {Widget trailing}) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      subtitle: Text(subTitle),
      trailing: trailing,
    );
  }
}
