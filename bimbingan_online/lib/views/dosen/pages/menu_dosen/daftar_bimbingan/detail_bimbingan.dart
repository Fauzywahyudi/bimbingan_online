import 'package:bimbingan_online/providers/bahan_bimbingan.dart';
import 'package:bimbingan_online/utils/assets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DetailBimbingan extends StatefulWidget {
  final data;

  const DetailBimbingan({Key key, this.data}) : super(key: key);
  @override
  _DetailBimbinganState createState() => _DetailBimbinganState();
}

class _DetailBimbinganState extends State<DetailBimbingan> {
  Future<List> _getBahan(String status) async {
    BahanBimbinganProvider bahanBimbinganProvider = BahanBimbinganProvider();
    final result = await bahanBimbinganProvider.getBahanBimbinganByDosen(
        context, int.parse(widget.data['id_bimbingan']), status);
    return result;
  }

  @override
  Widget build(BuildContext context) {
    var mediaSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: colPrimary,
      appBar: AppBar(
        title: Text("Bimbingan"),
        elevation: 0,
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
                    )
                  ],
                ),
              ),
              Container(
                height: mediaSize.height,
                child: FutureBuilder<List>(
                  future: _getBahan("Belum dibaca"),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) print(snapshot.error);
                    return snapshot.hasData
                        ? ListView.builder(
                            itemCount: snapshot.data.length,
                            itemBuilder: (context, index) {
                              return _itemList(snapshot, index);
                            },
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

  Widget _itemList(AsyncSnapshot<List> snapshot, int index) {
    return ExpansionTile(
      leading: Icon(Icons.person),
      title: Text(snapshot.data[index]['nama_mahasiswa']),
      subtitle: Text("NIM : " + snapshot.data[index]['nim_mahasiswa']),
      children: <Widget>[
        ListTile(
          leading: Icon(Icons.description),
          title: Text("Bab " + snapshot.data[index]['bab']),
          subtitle: Text(snapshot.data[index]['keterangan']),
          trailing: IconButton(
            color: colSuccess,
            icon: Icon(Icons.file_download),
            onPressed: () {},
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            OutlineButton(
              borderSide: BorderSide(color: colSuccess),
              textColor: colSuccess,
              color: colSuccess,
              onPressed: () {},
              child: Text(
                "Acc",
              ),
            ),
            OutlineButton(
              borderSide: BorderSide(color: colInfo),
              color: colInfo,
              textColor: colInfo,
              onPressed: () {},
              child: Text(
                "Revisi",
              ),
            ),
          ],
        ),
      ],
    );
  }
}
