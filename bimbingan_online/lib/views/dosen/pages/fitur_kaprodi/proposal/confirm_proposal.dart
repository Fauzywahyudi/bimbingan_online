import 'dart:io';

import 'package:bimbingan_online/providers/proposal_provider.dart';
import 'package:bimbingan_online/utils/assets.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:bimbingan_online/utils/link.dart' as link;
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class ConfirmProposal extends StatefulWidget {
  final data;

  const ConfirmProposal({Key key, this.data}) : super(key: key);
  @override
  _ConfirmProposalState createState() => _ConfirmProposalState();
}

class _ConfirmProposalState extends State<ConfirmProposal> {
  Dio dio = Dio();
  ProposalProvider _proposalProvider = ProposalProvider();

  void _konfirmasi(String status) async {
    await _proposalProvider.konfirmasi(
        context,
        int.parse(widget.data['id_proposal']),
        int.parse(widget.data['id_mahasiswa']),
        status);
    popPage(context);
  }

  Future initial() async {
    WidgetsFlutterBinding.ensureInitialized();
    await FlutterDownloader.initialize(
        debug: true // optional: set false to disable printing logs to console
        );
  }

  Future<void> downloadFile(String filename) async {
    Dio dio = Dio();
    try {
      var dir = await getTemporaryDirectory();
      await dio.download(
          link.Link.proposal + filename, "${dir.path}/$filename");
    } catch (e) {}

    // try {
    //   var dir = await getDownloadsDirectory();

    //   await dio.download(link.Link.proposal+filename, "${dir.path}/$filename",
    //   onProgress: (rec, total) {
    //     print("Rec: $rec , Total: $total");

    //     setState(() {
    //       downloading = true;
    //       progressString = ((rec / total) * 100).toStringAsFixed(0) + "%";
    //     });
    //   });
    // } catch (e) {
    //   print(e);
    // }

    // setState(() {
    //   // downloading = false;
    //   // progressString = "Completed";
    // });
    // print("Download completed");
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
      String url = link.Link.proposal + fileName;
      print(url);

      download2(dio, url, fullPath);
    }
  }

  @override
  void initState() {
    // initial();
    super.initState();
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
              _buildListTile(
                  widget.data['judul'], "Judul Proposal", Icons.title),
              _buildListTile(
                  widget.data['file'], "File Document", Icons.note_add,
                  trailing: IconButton(
                    icon: Icon(Icons.file_download),
                    onPressed: () => _downloadDoc(widget.data['file']),
                  )),
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
                      onPressed: () => _konfirmasi("Ditolak"),
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
                      onPressed: () => _konfirmasi("Acc"),
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
