import 'package:auto_size_text/auto_size_text.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:bimbingan_online/models/shared_preferenced.dart';
import 'package:bimbingan_online/utils/assets.dart';
import 'package:bimbingan_online/views/login.dart';
import 'package:line_icons/line_icons.dart';

import '../../utils/constant.dart';
import '../../widgets/profile_image.dart';
import 'package:flutter/material.dart';

class ProfileDetail extends StatelessWidget {
  final nama;
  final gelar;
  final jabatan;

  const ProfileDetail({Key key, this.nama, this.gelar, this.jabatan})
      : super(key: key);

  void _logout(BuildContext context) async {
    DataShared dataShared = DataShared();
    await dataShared.logout();
    pushReplacePage(context, Login());
  }

  void _dialogLogout(BuildContext context) async {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.INFO,
      animType: AnimType.BOTTOMSLIDE,
      title: 'Logout',
      desc: 'Yakin untuk Logout',
      btnCancelOnPress: () {},
      btnOkOnPress: () {
        _logout(context);
      },
    )..show();
  }

  @override
  Widget build(BuildContext context) {
    Size deviceSize = MediaQuery.of(context).size;
    return Material(
      borderRadius: BorderRadius.all(
        Radius.circular(20.0),
      ),
      elevation: 10.0,
      child: Container(
        height: deviceSize.height * 0.2,
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        decoration: BoxDecoration(
          color: profile_info_background,
          borderRadius: BorderRadius.all(Radius.circular(20.0)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    AutoSizeText(
                      "$nama $gelar",
                      maxLines: 2,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      jabatan,
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 13.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                ClipOval(
                  child: Container(
                    color: colDanger,
                    child: IconButton(
                      color: colLight,
                      icon: Icon(LineIcons.power_off),
                      onPressed: () => _dialogLogout(context),
                      tooltip: "Logout",
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 15.0,
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                for (var item in profileItems)
                  Column(
                    children: <Widget>[
                      Text(
                        item['count'],
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      Text(
                        item['name'],
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 13.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
