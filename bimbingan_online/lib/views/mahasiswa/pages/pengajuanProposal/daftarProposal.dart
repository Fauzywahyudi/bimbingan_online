import 'dart:async';
import 'dart:convert';

import 'package:bimbingan_online/models/shared_preferenced.dart';
import 'package:bimbingan_online/utils/link.dart' as link;
import 'package:flutter/material.dart';
import 'tambah_proposal.dart';
import 'package:http/http.dart' as http;
import 'detail_proposal.dart';

class DaftarProposal extends StatefulWidget {
  static const routeName = '/DaftarProposal';
  @override
  _DaftarProposalState createState() => new _DaftarProposalState();
}

class _DaftarProposalState extends State<DaftarProposal> {
  Future<List> getProposal() async {
    DataShared _dataShared = DataShared();
    int id = await _dataShared.getId();
    final response = await http.post(link.Link.mahasiswa + "getProposal.php",
        body: {"id": id.toString()});

    return json.decode(response.body);
  }

  Future<Null> handleRefresh() async {
    Completer<Null> completer = new Completer<Null>();
    new Future.delayed(new Duration(milliseconds: 500)).then((_) {
      completer.complete();
      setState(() {});
    });
    return completer.future;
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Daftar Proposal"),
      ),
      floatingActionButton: new FloatingActionButton(
          child: new Icon(Icons.add),
          onPressed: () async {
            await Navigator.of(context).push(new MaterialPageRoute(
              builder: (BuildContext context) => new AddProposal(),
            ));
            handleRefresh();
          }),
      body: new FutureBuilder<List>(
        future: getProposal(),
        builder: (context, snapshoot) {
          if (snapshoot.hasError) print(snapshoot.error);
          return snapshoot.hasData
              ? new ItemList(
                  list: snapshoot.data,
                )
              : new Center(
                  child: new CircularProgressIndicator(),
                );
        },
      ),
    );
  }
}

class ItemList extends StatelessWidget {
  final List list;
  ItemList({this.list});
  @override
  Widget build(BuildContext context) {
    return new ListView.builder(
      itemCount: list == null ? 0 : list.length,
      itemBuilder: (context, i) {
        return new Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: new GestureDetector(
            onTap: () => Navigator.of(context).push(new MaterialPageRoute(
                builder: (BuildContext context) => new Detail(
                      // list: list,
                      // index: i,
                      listData: list[i],
                    ))),
            child: new Card(
              child: new ListTile(
                title: new Text(list[i]['judul']),
                leading: list[i]['status'] == "Proses"
                    ? Icon(Icons.schedule)
                    : list[i]['status'] == "Ditolak"
                        ? Icon(Icons.close)
                        : Icon(Icons.check),
                subtitle: new Text("Status : ${list[i]['status']}"),
              ),
            ),
          ),
        );
      },
    );
  }
}
