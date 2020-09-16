import 'package:bimbingan_online/utils/assets.dart';
import 'package:flutter/material.dart';

class Detail extends StatefulWidget {
  final listData;
  Detail({this.listData});
  @override
  _DetailState createState() => new _DetailState();
}

class _DetailState extends State<Detail> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(title: new Text("Detail Proposal")),
      body: new Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.all(5.0),
        child: new Column(
          children: <Widget>[
            ListTile(
              title: new Text(
                "${widget.listData['judul']}",
                style: new TextStyle(fontSize: 20.0),
              ),
              subtitle: new Text("Judul Proposal"),
              leading: new Icon(Icons.title),
            ),
            ListTile(
              title: new Text(
                "${widget.listData['file']}",
                style: new TextStyle(fontSize: 20.0),
              ),
              subtitle: new Text("File Proposal"),
              leading: new Icon(Icons.file_upload),
            ),
            ListTile(
              title: new Text(
                "${widget.listData['status']}",
                style: new TextStyle(fontSize: 20.0),
              ),
              subtitle: new Text("Status"),
              leading: new Icon(Icons.info),
            ),
            ListTile(
              title: new Text(
                "${formatTanggal(widget.listData['tgl_upload'])}, Pukul : ${formatJam(widget.listData['tgl_upload'])} WIB",
                style: new TextStyle(fontSize: 20.0),
              ),
              subtitle: new Text("Tanggal Upload Proposal"),
              leading: new Icon(Icons.timer),
            ),
          ],
        ),
      ),
    );
  }
}
