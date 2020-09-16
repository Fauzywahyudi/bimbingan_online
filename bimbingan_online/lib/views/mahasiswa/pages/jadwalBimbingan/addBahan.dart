import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:bimbingan_online/models/mahasiswa.dart';
import 'package:bimbingan_online/models/shared_preferenced.dart';
import 'package:bimbingan_online/utils/assets.dart';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:bimbingan_online/utils/link.dart' as link;
import 'package:http/http.dart' as http;
import 'package:path/path.dart';

class AddBahan extends StatefulWidget {
  final data;

  const AddBahan({Key key, this.data}) : super(key: key);
  @override
  _AddBahanState createState() => _AddBahanState();
}

class _AddBahanState extends State<AddBahan> {
  TextEditingController controllerJudul = new TextEditingController();
  var _tecBab = TextEditingController();
  var _tecJudul = TextEditingController();
  var _tecKet = TextEditingController();

  DataShared _dataShared = DataShared();
  File selectedfile;
  Response response;
  String progress;
  Dio dio = new Dio();

  Future<bool> upload(BuildContext context, String fileName) async {
    var url = link.Link.mahasiswa + "tambahBahan.php";
    int id = await _dataShared.getId();
    final result = await http.post(url, body: {
      "id_mahasiswa": id.toString(),
      "id_dosen": widget.data['id_dosen'],
      "id_bimbingan": widget.data['id_bimbingan'],
      "bab": _tecBab.text,
      "judul": _tecJudul.text,
      "keterangan": _tecKet.text,
      "file": fileName,
    });
    final response = json.decode(result.body);
    int value = response['value'];
    String pesan = response['message'];
    if (value == 1) {
      return true;
    } else if (value == 2) {
      messageInfo(context, pesan);
      return false;
    } else {
      return false;
    }
  }

  uploadFile(BuildContext context) async {
    Mahasiswa mahasiswa = await _dataShared.getDataPrefMahasiswa();
    String uploadurl = link.Link.mahasiswa + "upload_file_bahan.php";
    // List data =
    String extensi = (selectedfile.path.split(".")).last;
    var randomizer = new Random(); // can get a seed as a parameter

    // Integer between 0 and 100 (0 can be 100 not)
    var rand = randomizer.nextInt(8999) + 1000;
    String newFileName = mahasiswa.nim + "_" + rand.toString() + "." + extensi;

    FormData formdata = FormData.fromMap({
      "file": await MultipartFile.fromFile(
        selectedfile.path,
        filename: newFileName,
        //show only filename from path
      ),
    });

    bool cek = await upload(context, newFileName);

    if (cek) {
      response = await dio.post(
        uploadurl,
        data: formdata,
        onSendProgress: (int sent, int total) {
          String percentage = (sent / total * 100).toStringAsFixed(2);
          setState(() {
            progress = "$sent" +
                " Bytes of " "$total Bytes - " +
                percentage +
                " % uploaded";
            //update the progress
          });
        },
      );

      if (response.statusCode == 200) {
        print(response.toString());
        messageInfo(context, "Upload berhasil");
        popPage(context);
      } else {
        print("Error during connection to server.");
      }
    }
  }

  bool _validasi(BuildContext context) {
    if (_tecBab.text.isEmpty || int.parse(_tecBab.text) > 5) return false;
    if (_tecJudul.text.isEmpty) return false;
    if (_tecKet.text.isEmpty) return false;
    if (selectedfile == null) return false;
    return true;
  }

  selectFile() async {
    FilePickerResult result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['rtf', 'pdf', 'doc', 'docx'],
    );

    if (result != null) {
      selectedfile = File(result.files.single.path);
      print(selectedfile.path.toString());
    }
    setState(() {}); //update the UI so that file name is shown
  }

  @override
  void initState() {
    print(widget.data['id_bimbingan']);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text("Upload Bahan Bimbingan"),
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: _tecBab,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    labelText: "Bab Laporan",
                    prefixIcon: Icon(Icons.bookmark_border)),
              ),
              TextField(
                controller: _tecJudul,
                decoration: InputDecoration(
                    labelText: "Title", prefixIcon: Icon(Icons.title)),
              ),
              TextField(
                controller: _tecKet,
                decoration: InputDecoration(
                    labelText: "Keterangan", prefixIcon: Icon(Icons.title)),
              ),
              ListTile(
                leading: Icon(Icons.file_upload),
                title: Text(selectedfile == null
                    ? "Pilih File"
                    : basename(selectedfile.path)),
                trailing: IconButton(
                  icon: Icon(Icons.folder_open),
                  tooltip: "Pilih File",
                  onPressed: () {
                    selectFile();
                  },
                ),
              ),
              Container(
                margin: EdgeInsets.all(10),
                //show file name here
                child: progress == null
                    ? Text("")
                    : Text(
                        basename("Progress: $progress"),
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 18),
                      ),
                //show progress status here
              ),
              new Padding(
                padding: const EdgeInsets.all(10.0),
              ),
              new RaisedButton(
                  child: new Text(
                    "Upload Proposal",
                    style: TextStyle(color: Colors.white),
                  ),
                  color: Colors.blueAccent,
                  onPressed: () {
                    if (_validasi(context)) {
                      uploadFile(context);
                    } else {
                      messageInfo(context, "Harap isi semua data");
                    }
                  })
            ],
          ),
        ),
      ),
    );
  }
}
