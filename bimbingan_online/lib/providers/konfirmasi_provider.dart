import 'dart:convert';

import 'package:bimbingan_online/utils/assets.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:bimbingan_online/utils/link.dart' as link;

class KonfirmasiProvider {
  Future konfirmasiAktor(
      BuildContext context, int id, String status, String aktor) async {
    final result =
        await http.post(link.Link.kaprodi + "konfirmasiAkun.php", body: {
      "aktor": aktor,
      "id": id.toString(),
      "status": status,
    });
    final response = await json.decode(result.body);
    int value = response['value'];
    String pesan = response['message'];
    if (value == 1) {
      messageSuccess(context, pesan);
    } else {
      messageDanger(context, pesan);
    }
  }
}
