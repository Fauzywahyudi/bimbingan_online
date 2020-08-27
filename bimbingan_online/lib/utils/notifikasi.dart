import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';

void messageInfo(
  BuildContext context,
  String notif,
) {
  BotToast.showSimpleNotification(
    title: notif,
    closeIcon: Icon(
      Icons.info,
      color: Colors.lightBlue,
    ),
  );
}

void messageDanger(
  BuildContext context,
  String notif,
) {
  BotToast.showSimpleNotification(
    title: notif,
    closeIcon: Icon(
      Icons.info,
      color: Colors.red,
    ),
  );
}

void messageSuccess(
  BuildContext context,
  String notif,
) {
  BotToast.showSimpleNotification(
    title: notif,
    closeIcon: Icon(
      Icons.check,
      color: Colors.lightGreen,
    ),
  );
}
