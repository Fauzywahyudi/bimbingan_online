import 'package:bimbingan_online/models/dosen.dart';
import 'package:bimbingan_online/models/mahasiswa.dart';

import '../widgets/profile/profile_categories.dart';
import '../widgets/profile/profile_detail.dart';
import '../widgets/profile/profile_menu.dart';
// import '../widgets/title_large.dart';
import 'package:flutter/material.dart';

class HomeMahasiswa extends StatefulWidget {
  final Mahasiswa mahasiswa;

  const HomeMahasiswa({Key key, this.mahasiswa}) : super(key: key);
  @override
  _HomeMahasiswaState createState() => _HomeMahasiswaState();
}

class _HomeMahasiswaState extends State<HomeMahasiswa> {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: Container(
        padding: const EdgeInsets.only(
          left: 20.0,
          right: 20.0,
          top: 30.0,
        ),
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // TitleLarge(
            //   title: 'Center',
            // ),
            SizedBox(
              height: 20.0,
            ),
            ProfileDetail(
              nama: widget.mahasiswa.nama,
              jurusan: widget.mahasiswa.jurusan,
            ),
            SizedBox(
              height: 30.0,
            ),
            Flexible(child: ProfileMenu()),
          ],
        ),
      ),
    );
  }
}
