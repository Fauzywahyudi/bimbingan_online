import 'package:flutter/material.dart';

class InformasiSkripsi extends StatefulWidget {
  static const routeName = '/InformasiSkripsi';
  @override
  _InformasiSkripsiState createState() => new _InformasiSkripsiState();
}

class _InformasiSkripsiState extends State<InformasiSkripsi> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: new AppBar(title: new Text("Informasi Skripsi")),
        body: new Container(
          // color: Colors.black,
          // height: 300.0,
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.all(5.0),
          child: new Column(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // new Padding(padding: EdgeInsets.only(top: 30.0)),
              ListTile(
                title: new Text(
                  // "${widget.listData['judul']}",
                  "TestProposal",
                  style: new TextStyle(fontSize: 20.0),
                ),
                subtitle: new Text("Judul Skripsi"),
                leading: new Icon(Icons.title),
              ),
              // Padding(padding: EdgeInsets.all(20.0)),
              ListTile(
                title: new Text(
                  "Rini Sovia, S.kom, M.kom",
                  // "${widget.listData['file']}",
                  style: new TextStyle(fontSize: 20.0),
                ),
                subtitle: new Text("Pembimbing 1"),
                leading: new Icon(Icons.person),
              ),
              ListTile(
                title: new Text(
                  "Retno Devita, S.kom, M.kom",
                  // "${formatTanggal(widget.listData['tgl_upload'])} ${formatJam(widget.listData['tgl_upload'])}",
                  style: new TextStyle(fontSize: 20.0),
                ),
                subtitle: new Text("Pembimbing 2"),
                leading: new Icon(Icons.person),
              ),
            ],
          ),
        ));
  }
}
