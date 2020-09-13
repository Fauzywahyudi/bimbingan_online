import 'package:bimbingan_online/utils/assets.dart';
import 'package:flutter/material.dart';
// import './editdata.dart';
// import 'package:http/http.dart' as http;
// import "daftarProposal.dart";

// ignore: must_be_immutable
class Detail extends StatefulWidget {
  // List list;
  // int index;
  final listData;
  Detail({this.listData});
  @override
  _DetailState createState() => new _DetailState();
}

class _DetailState extends State<Detail> {
  // void deleteData() {
  //   var url = "http://192.168.0.106/my_store/deleteProposal.php";
  //   http.post(url, body: {'id': widget.list[widget.index]['id']});
  // }

  // void confirm() {
  //   AlertDialog alertDialog = new AlertDialog(
  //     content: new Text(
  //         "Are You Sure Want To Delete '${widget.list[widget.index]['judul']}'"),
  //     actions: <Widget>[
  //       new RaisedButton(
  //         child: new Text(
  //           "Ok Delete!",
  //           style: new TextStyle(color: Colors.black),
  //         ),
  //         color: Colors.red,
  //         onPressed: () {
  //           deleteData();
  //           Navigator.of(context).push(new MaterialPageRoute(
  //             builder: (BuildContext context) => new DaftarProposal(),
  //           ));
  //         },
  //       ),
  //       new RaisedButton(
  //         child: new Text(
  //           "Cancel",
  //           style: new TextStyle(color: Colors.black),
  //         ),
  //         color: Colors.green,
  //         onPressed: () => Navigator.pop(context),
  //       ),
  //     ],
  //   );

  //   showDialog(context: context, child: alertDialog);
  // }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(title: new Text("Detail Proposal")),
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
                  "${widget.listData['judul']}",
                  style: new TextStyle(fontSize: 20.0),
                ),
                subtitle: new Text("Judul Proposal"),
                leading: new Icon(Icons.title),
              ),
              // Padding(padding: EdgeInsets.all(20.0)),
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
                  "${formatTanggal(widget.listData['tgl_upload'])} ${formatJam(widget.listData['tgl_upload'])}",
                  style: new TextStyle(fontSize: 20.0),
                ),
                subtitle: new Text("Tanggal Upload Proposal"),
                leading: new Icon(Icons.timer),
              ),
              // new Text(
              //   "Stock : ${widget.list[widget.index]['stock']}",
              //   style: new TextStyle(fontSize: 20.0),
              // ),
              // new Padding(
              //   padding: const EdgeInsets.only(top: 30.0),
              // ),
              // new Row(
              //   mainAxisSize: MainAxisSize.min,
              //   children: <Widget>[
              //     // new RaisedButton(
              //     //     child: new Text("EDIT"),
              //     //     color: Colors.green,
              //     //     onPressed: () =>
              //     //         Navigator.of(context).push(new MaterialPageRoute(
              //     //           builder: (BuildContext context) => new EditData(
              //     //             list: widget.list,
              //     //             index: widget.index,
              //     //           ),
              //     //         ))),
              //     new RaisedButton(
              //       child: new Text("DELETE"),
              //       color: Colors.red,
              //       onPressed: () => confirm(),
              //     ),
              //   ],
              // )
            ],
          ),
        )
        );
  }
}
