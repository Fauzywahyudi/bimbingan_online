import 'package:auto_size_text/auto_size_text.dart';

import '../../utils/constant.dart';
import '../../widgets/profile_image.dart';
import 'package:flutter/material.dart';

class ProfileDetail extends StatelessWidget {
  final nama;
  final gelar;

  const ProfileDetail({Key key, this.nama, this.gelar}) : super(key: key);

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
              children: <Widget>[
                // ProfileImage(
                //   height: 60.0,
                //   width: 60.0,
                // ),
                // SizedBox(
                //   width: 15.0,
                // ),
                Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      child: Row(
                        children: <Widget>[
                          AutoSizeText(
                            "$nama $gelar",
                            maxLines: 1,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      'A trendsetter',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 13.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
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
