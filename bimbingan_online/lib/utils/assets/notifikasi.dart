import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:awesome_dialog/awesome_dialog.dart';

void messageInfo(BuildContext context, String notif) {
  BotToast.showSimpleNotification(
    title: notif,
    closeIcon: Icon(
      Icons.info,
      color: Colors.lightBlue,
    ),
  );
}

void messageDanger(BuildContext context, String notif) {
  BotToast.showSimpleNotification(
    title: notif,
    closeIcon: Icon(
      Icons.info,
      color: Colors.red,
    ),
  );
}

void messageSuccess(BuildContext context, String notif) {
  BotToast.showSimpleNotification(
    title: notif,
    duration: Duration(seconds: 3),
    closeIcon: Icon(
      Icons.check,
      color: Colors.lightGreen,
    ),
  );
}

void dialogInfo(BuildContext context, String desc, Function onPresOK) {
  AwesomeDialog(
    context: context,
    dialogType: DialogType.INFO,
    animType: AnimType.BOTTOMSLIDE,
    title: 'Info',
    desc: desc,
    btnOkOnPress: () => onPresOK,
  )..show();
}

void dialogSuccess(BuildContext context, String desc, void onPresOK) {
  AwesomeDialog(
    context: context,
    dialogType: DialogType.SUCCES,
    animType: AnimType.BOTTOMSLIDE,
    title: 'Sukses',
    desc: desc,
    btnOkOnPress: () => onPresOK,
  )..show();
}
