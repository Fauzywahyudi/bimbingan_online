import 'dart:async';
import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:bimbingan_online/models/shared_preferenced.dart';
import 'package:bimbingan_online/providers/bahan_bimbingan.dart';
import 'package:bimbingan_online/utils/assets.dart';
import 'package:bimbingan_online/views/dosen/pages/menu_dosen/daftar_bimbingan/komentar_bahan.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:bimbingan_online/utils/link.dart' as link;

class DetailBimbingan extends StatefulWidget {
  final data;

  const DetailBimbingan({Key key, this.data}) : super(key: key);
  @override
  _DetailBimbinganState createState() => _DetailBimbinganState();
}

class _DetailBimbinganState extends State<DetailBimbingan> {
  BahanBimbinganProvider _bahanBimbinganProvider = BahanBimbinganProvider();
  DataShared _dataShared = DataShared();
  var _tecPesan = TextEditingController();
  String _filter = "Belum dibaca";
  Dio dio = Dio();

  Future<List> _getBahan(String status) async {
    final result = await _bahanBimbinganProvider.getBahanBimbinganByDosen(
        context, int.parse(widget.data['id_bimbingan']), status);
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

  void showDownloadProgress(received, total) {
    if (total != -1) {
      print((received / total * 100).toStringAsFixed(0) + "%");
    }
  }

  Future download2(Dio dio, String url, String savePath) async {
    try {
      Response response = await dio.get(
        url,
        onReceiveProgress: showDownloadProgress,
        //Received data with List<int>
        options: Options(
            responseType: ResponseType.bytes,
            followRedirects: false,
            validateStatus: (status) {
              return status < 500;
            }),
      );
      print(response.headers);
      File file = File(savePath);
      var raf = file.openSync(mode: FileMode.write);
      List dataPath = savePath.split("0");
      // response.data is List<int> type
      raf.writeFromSync(response.data);
      await raf.close();

      messageFile(
          context, "Berhasil didownload\nFile tersimpan di \n${dataPath.last}");
    } catch (e) {
      print(e);
    }
  }

  Future _downloadDoc(String fileName) async {
    if (await Permission.storage.request().isGranted) {
      var tempDir = await getExternalStorageDirectory();
      print(tempDir.path);
      List data = tempDir.path.split("0");
      String _downloadDir = data.first + "0/Download/";
      String fullPath = _downloadDir + fileName;
      print('full path ${fullPath}');
      String url = link.Link.bahan + fileName;
      print(url);

      download2(dio, url, fullPath);
    }
  }

  @override
  Widget build(BuildContext context) {
    var mediaSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: colPrimary,
      appBar: AppBar(
        title: Text("Bimbingan"),
        elevation: 0,
        actions: [
          IconButton(
              icon: PopupMenuButton(
                tooltip: "Urut berdasarkan",
                icon: Icon(Icons.filter_list),
                itemBuilder: (_) => <PopupMenuItem<String>>[
                  PopupMenuItem<String>(
                      child: const Text('Belum diperiksa'),
                      value: 'Belum dibaca'),
                  PopupMenuItem<String>(child: const Text('Acc'), value: 'Acc'),
                  PopupMenuItem<String>(
                      child: const Text('Revisi'), value: 'Revisi'),
                ],
                onSelected: (v) {
                  setState(() {
                    _filter = v;
                    handleRefresh();
                  });
                },
              ),
              onPressed: () {}),
        ],
      ),
      body: Container(
        color: colLight,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                color: colPrimary,
                width: mediaSize.width,
                child: Column(
                  children: [
                    ListTile(
                      leading: Icon(Icons.schedule, color: colLight),
                      title: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${formatJam(widget.data['jadwal_mulai'])} - ${formatJam(widget.data['jadwal_selesai'])} WIB",
                            style: GoogleFonts.mcLaren(
                                fontSize: 18, color: colLight),
                          ),
                          Expanded(child: Container()),
                          Text(
                            "${formatTanggal(widget.data['jadwal_selesai'])}",
                            style: GoogleFonts.mcLaren(
                                fontSize: 18, color: colLight),
                          ),
                        ],
                      ),
                      subtitle: Text(
                        widget.data['status'],
                        style: textLight.copyWith(fontSize: 18),
                      ),
                    ),
                    ListTile(
                      leading: Icon(
                        Icons.info,
                        color: colLight,
                      ),
                      title: Text(
                        widget.data['keterangan'],
                        style: textLight.copyWith(fontSize: 18),
                      ),
                    ),
                    ListTile(
                      leading: Icon(
                        Icons.filter_list,
                        color: colLight,
                      ),
                      title: Text(
                        _filter,
                        style: textLight.copyWith(fontSize: 18),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: mediaSize.height,
                child: FutureBuilder<List>(
                  future: _getBahan(_filter),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) print(snapshot.error);
                    return snapshot.hasData
                        ? RefreshIndicator(
                            onRefresh: handleRefresh,
                            child: ListView.builder(
                              itemCount: snapshot.data.length,
                              itemBuilder: (context, index) {
                                return _itemList(snapshot.data[index]);
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

  Widget _itemList(var data) {
    var status = data['status_bahan'];
    return ExpansionTile(
      key: ValueKey(data['id_bahan']),
      leading: status == "Belum dibaca"
          ? Icon(Icons.schedule)
          : status == "Acc" ? Icon(Icons.check) : Icon(Icons.refresh),
      title: Text(data['nama_mahasiswa']),
      subtitle: Text("NIM : " + data['nim_mahasiswa']),
      children: <Widget>[
        ListTile(
          leading: Icon(Icons.description),
          title: Text("Bab " + data['bab']),
          subtitle: Text(data['keterangan']),
          trailing: IconButton(
            color: colSuccess,
            icon: Icon(Icons.file_download),
            onPressed: () => _downloadDoc(data['file']),
          ),
        ),
        status == "Belum dibaca"
            ? Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  OutlineButton(
                    borderSide: BorderSide(color: colSuccess),
                    textColor: colSuccess,
                    color: colSuccess,
                    onPressed: () async {
                      int idDosen = await _dataShared.getId();
                      await _bahanBimbinganProvider.konfirmasiBahan(
                          context, int.parse(data['id_bahan']), idDosen, "Acc");
                      handleRefresh();
                    },
                    child: Text(
                      "Acc",
                    ),
                  ),
                  OutlineButton(
                    borderSide: BorderSide(color: colInfo),
                    color: colInfo,
                    textColor: colInfo,
                    onPressed: () async {
                      int idDosen = await _dataShared.getId();
                      await _bahanBimbinganProvider.konfirmasiBahan(context,
                          int.parse(data['id_bahan']), idDosen, "Revisi");
                      handleRefresh();
                    },
                    child: Text(
                      "Revisi",
                    ),
                  ),
                ],
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  OutlineButton.icon(
                    borderSide: BorderSide(color: colPrimary),
                    color: colPrimary,
                    textColor: colPrimary,
                    onPressed: () async {
                      pushPage(
                          context,
                          KomentarBahan(
                            data: data,
                          ));
                      handleRefresh();
                    },
                    icon: Icon(Icons.comment),
                    label: Text("Pesan"),
                  ),
                ],
              ),
      ],
    );
  }
}
