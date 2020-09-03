import 'package:bimbingan_online/utils/assets/navigator.dart';

import '../../utils/constant.dart';
import 'package:flutter/material.dart';

class Category extends StatelessWidget {
  final Catg catg;
  Category({this.catg});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Stack(
            overflow: Overflow.visible,
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  pushNamePage(context, "/" + catg.name);
                },
                child: Container(
                  padding: EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: profile_info_categories_background,
                  ),
                  child: Icon(
                    catg.icon,
                    // size: 20.0,
                  ),
                ),
              ),
              catg.number > 0
                  ? Positioned(
                      right: -5.0,
                      child: Container(
                        padding: EdgeInsets.all(5.0),
                        decoration: BoxDecoration(
                          color: profile_info_background,
                          shape: BoxShape.circle,
                        ),
                        child: Text(
                          catg.number.toString(),
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 10.0,
                          ),
                        ),
                      ),
                    )
                  : SizedBox(),
            ],
          ),
          SizedBox(
            height: 10.0,
          ),
          Text(
            "${catg.name.replaceAll("Page", "")}",
            // catg.name,
            style: TextStyle(
              fontSize: 13.0,
            ),
          )
        ],
      ),
    );
  }
}
