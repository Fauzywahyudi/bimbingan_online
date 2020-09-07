import 'package:bimbingan_online/models/dosen.dart';

import '../widgets/profile/profile_categories.dart';
import '../widgets/profile/profile_detail.dart';
import '../widgets/profile/profile_menu.dart';
// import '../widgets/title_large.dart';
import 'package:flutter/material.dart';

class HomeDosen extends StatefulWidget {
  final Dosen dosen;

  const HomeDosen({Key key, this.dosen}) : super(key: key);
  @override
  _HomeDosenState createState() => _HomeDosenState();
}

class _HomeDosenState extends State<HomeDosen> {
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
              nama: widget.dosen.nama,
              gelar: widget.dosen.gelar,
              jabatan: widget.dosen.jabatan,
            ),
            widget.dosen.jabatan == "Ketua Prodi"
                ? Column(
                    children: [
                      SizedBox(
                        height: 30.0,
                      ),
                      ProfileCategories(),
                    ],
                  )
                : Container(),
            SizedBox(
              height: 30.0,
            ),
            Flexible(child: ProfileMenu()),
            widget.dosen.jabatan == "Dosen Tetap"
                ? SizedBox(
                    height: 100,
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}
