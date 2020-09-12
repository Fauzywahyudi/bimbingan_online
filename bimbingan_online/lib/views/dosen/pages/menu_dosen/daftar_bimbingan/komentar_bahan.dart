import 'dart:async';

import 'package:bimbingan_online/models/komentar.dart';
import 'package:bimbingan_online/models/shared_preferenced.dart';
import 'package:bimbingan_online/providers/komentar_bahan_provider.dart';
import 'package:bimbingan_online/utils/assets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class KomentarBahan extends StatefulWidget {
  final data;

  const KomentarBahan({Key key, this.data}) : super(key: key);
  @override
  _KomentarBahanState createState() => _KomentarBahanState();
}

class _KomentarBahanState extends State<KomentarBahan> {
  KomentarBahanProvider _komentarBahanProvider = KomentarBahanProvider();
  var _tecKomentar = TextEditingController();
  int _idDosen;

  Future<Null> handleRefresh() async {
    Completer<Null> completer = new Completer<Null>();
    new Future.delayed(new Duration(milliseconds: 500)).then((_) {
      completer.complete();
      setState(() {});
    });
    return completer.future;
  }

  Future getIdDosen() async {
    DataShared dataShared = DataShared();
    int idDosen = await dataShared.getId();
    setState(() {
      _idDosen = idDosen;
    });
  }

  @override
  void initState() {
    super.initState();
    getIdDosen();
  }

  Future<List> _getKomentar() async {
    final result = await _komentarBahanProvider.getKomentarBahan(
        context, int.parse(widget.data['id_bahan']));
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colPrimary.withOpacity(0.4),
      appBar: AppBar(
        title: Text("Komentar Bahan"),
      ),
      // bottomNavigationBar: _fieldComment(),
      body: Stack(
        children: [
          _buildList(),
          Positioned(
            bottom: 0,
            width: MediaQuery.of(context).size.width,
            child: _fieldComment(),
          ),
        ],
      ),
    );
  }

  Container _buildList() {
    return Container(
      child: FutureBuilder<List>(
        future: _getKomentar(),
        builder: (context, snapshot) {
          if (snapshot.hasError) print(snapshot.error);
          return snapshot.hasData
              ? RefreshIndicator(
                  onRefresh: handleRefresh,
                  child: ListView.builder(
                    padding: EdgeInsets.only(bottom: 80),
                    reverse: true,
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {
                      if (snapshot.data[index]['sender'] == "dos:${_idDosen}") {
                        return _itemAkun(snapshot.data[index]);
                      } else {
                        return _itemLawan(snapshot.data[index]);
                      }
                    },
                  ),
                )
              : Center(
                  child: CircularProgressIndicator(),
                );
        },
      ),
    );
  }

  Container _itemLawan(var data) {
    return Container(
      child: Row(
        children: [
          Flexible(
            flex: 5,
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              margin: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20), color: colLight),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    data['isi_komentar'],
                    style: GoogleFonts.mcLaren(color: colPrimary),
                  ),
                  SizedBox(height: 10),
                  Text(
                    formatJam(data['tgl_post']),
                    style: GoogleFonts.mcLaren(color: colPrimary),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Container(),
          ),
        ],
      ),
    );
  }

  Container _itemAkun(var data) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Expanded(
            child: Container(),
          ),
          Flexible(
            flex: 5,
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              margin: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20), color: colPrimary),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    data['isi_komentar'],
                    style: GoogleFonts.mcLaren(color: colLight),
                  ),
                  SizedBox(height: 10),
                  Text(
                    formatJam(data['tgl_post']),
                    style: GoogleFonts.mcLaren(color: colLight),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Container _fieldComment() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      decoration: BoxDecoration(
          color: colLight, borderRadius: BorderRadius.circular(20)),
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      child: TextField(
        controller: _tecKomentar,
        minLines: 1,
        maxLines: 3,
        style: textPrimary,
        decoration: InputDecoration(
            hintText: "Type your comment...",
            hintStyle: TextStyle(color: colPrimary.withOpacity(0.7)),
            border: InputBorder.none,
            suffixIcon: IconButton(
              color: colPrimary,
              icon: Icon(Icons.send),
              onPressed: () async {
                DataShared _dataShared = DataShared();
                final int idDosen = await _dataShared.getId();
                Komentar komentar = Komentar(
                    null,
                    int.parse(widget.data['id_bahan']),
                    _tecKomentar.text,
                    idDosen.toString(),
                    widget.data['id_mahasiswa'],
                    null);
                await _komentarBahanProvider.addKomentar(context, komentar);
                setState(() {
                  _tecKomentar.text = "";
                });
                handleRefresh();
              },
            )),
      ),
    );
  }
}
