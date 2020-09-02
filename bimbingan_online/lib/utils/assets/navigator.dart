import 'package:flutter/material.dart';

pushPage(BuildContext context, Widget widget) {
  return Navigator.push(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => widget,
      ));
}

pushNamePage(BuildContext context, String route) {
  return Navigator.pushNamed(context, route);
}

pushReplaceNamePage(BuildContext context, String route) {
  return Navigator.pushReplacementNamed(context, route);
}

pushReplacePage(BuildContext context, Widget widget) {
  return Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => widget,
      ));
}

popPage(BuildContext context) {
  return Navigator.pop(context);
}
