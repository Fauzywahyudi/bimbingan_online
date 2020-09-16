import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'package:flutter/services.dart';
import 'package:file_picker/file_picker.dart';
import 'package:path/path.dart';
import 'package:bimbingan_online/utils/link.dart' as link;

class FilePickerDemo extends StatefulWidget {
  @override
  _FilePickerDemoState createState() => _FilePickerDemoState();
}

class _FilePickerDemoState extends State<FilePickerDemo> {
  File selectedfile;
  Response response;
  String progress;
  Dio dio = new Dio();

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

  uploadFile() async {
    String uploadurl = link.Link.mahasiswa + "upload_file.php";
    //dont use http://localhost , because emulator don't get that address
    //insted use your local IP address or use live URL
    //hit "ipconfig" in windows or "ip a" in linux to get you local IP

    FormData formdata = FormData.fromMap({
      "file": await MultipartFile.fromFile(selectedfile.path,
          filename: basename(selectedfile.path)
          //show only filename from path
          ),
    });

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
      //print response from server
    } else {
      print("Error during connection to server.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Select File and Upload"),
          backgroundColor: Colors.orangeAccent,
        ), //set appbar
        body: Container(
            alignment: Alignment.center,
            padding: EdgeInsets.all(40),
            child: Column(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.all(10),
                  //show file name here
                  child: progress == null
                      ? Text("Progress: 0%")
                      : Text(
                          basename("Progress: $progress"),
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 18),
                        ),
                  //show progress status here
                ),

                Container(
                  margin: EdgeInsets.all(10),
                  //show file name here
                  child: selectedfile == null
                      ? Text("Choose File")
                      : Text(basename(selectedfile.path)),
                  //basename is from path package, to get filename from path
                  //check if file is selected, if yes then show file name
                ),

                Container(
                    child: RaisedButton.icon(
                  onPressed: () {
                    selectFile();
                  },
                  icon: Icon(Icons.folder_open),
                  label: Text("CHOOSE FILE"),
                  color: Colors.redAccent,
                  colorBrightness: Brightness.dark,
                )),

                //if selectedfile is null then show empty container
                //if file is selected then show upload button
                selectedfile == null
                    ? Container()
                    : Container(
                        child: RaisedButton.icon(
                        onPressed: () {
                          uploadFile();
                        },
                        icon: Icon(Icons.folder_open),
                        label: Text("UPLOAD FILE"),
                        color: Colors.redAccent,
                        colorBrightness: Brightness.dark,
                      ))
              ],
            )));
  }
}
