import 'package:bimbingan_online/utils/assets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DetailNotifikasi extends StatefulWidget {
  final data;

  const DetailNotifikasi({Key key, this.data}) : super(key: key);
  @override
  _DetailNotifikasiState createState() => _DetailNotifikasiState();
}

class _DetailNotifikasiState extends State<DetailNotifikasi> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Detail Notifikasi"),
        elevation: 0,
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                color: colPrimary,
                padding: EdgeInsets.all(15),
                child: Text(
                  widget.data['judul_pengumuman'],
                  textAlign: TextAlign.center,
                  style: GoogleFonts.mcLaren(fontSize: 25, color: colLight),
                ),
              ),
              Container(
                padding: EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Tipe"),
                        SizedBox(height: 10),
                        Text(
                          widget.data['tipe_pengumuman'],
                          style: GoogleFonts.mcLaren(fontSize: 17),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text("Status"),
                        SizedBox(height: 10),
                        Text(
                          widget.data['status'],
                          style: GoogleFonts.mcLaren(fontSize: 17),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Divider(),
              Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Informasi"),
                    SizedBox(height: 10),
                    Text(
                      widget.data['keterangan'],
                      textAlign: TextAlign.justify,
                      style: GoogleFonts.mcLaren(fontSize: 17),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
