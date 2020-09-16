import 'package:bimbingan_online/utils/assets/date.dart';
import 'package:bimbingan_online/views/mahasiswa/pages/jadwalBimbingan/addBahan.dart';
import 'package:flutter/material.dart';

class DetailJadwal extends StatefulWidget {
  final listData;
  DetailJadwal({this.listData});
  @override
  _DetailJadwalState createState() => new _DetailJadwalState();
}

class _DetailJadwalState extends State<DetailJadwal> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text("Detail Jadwal Bimbingan"),
      ),
      floatingActionButton: new FloatingActionButton(
          child: new Icon(Icons.add),
          onPressed: () async {
            await Navigator.of(context).push(new MaterialPageRoute(
              builder: (BuildContext context) => new AddBahan(
                data: widget.listData,
              ),
            ));
            // handleRefresh();
          }),
      body: new Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.all(5.0),
        child: new Column(
          children: <Widget>[
            ListTile(
              title: new Text(
                "${widget.listData["keterangan"]}",
                style: new TextStyle(fontSize: 18.0),
              ),
              subtitle: new Text("Keterangan"),
              leading: new Icon(Icons.info),
            ),
            ListTile(
              title: new Text(
                "${widget.listData['status']}",
                style: new TextStyle(fontSize: 18.0),
              ),
              subtitle: new Text("Status"),
              // leading: new Icon(Icons.schedule),
              leading: widget.listData['status'] == "Selesai"
                  ? Icon(Icons.check_box)
                  : Icon(Icons.schedule),
            ),
            ListTile(
              title: new Text(
                "${formatJam(widget.listData['jadwal_mulai'])}, - ${formatJam(widget.listData['jadwal_selesai'])} WIB ${formatTanggal(widget.listData['jadwal_selesai'])}",
                style: new TextStyle(fontSize: 18.0),
              ),
              subtitle: new Text("Jadwal Bimbingan"),
              leading: new Icon(Icons.timer),
            ),
            // FutureBuilder(builder: null)
          ],
        ),
      ),
    );
  }
}
