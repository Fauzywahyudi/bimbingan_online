import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:bimbingan_online/utils/link.dart' as link;
import 'package:bimbingan_online/utils/assets.dart';

class PengumumanProvider {
  Future<List> getPengumuman(BuildContext context, String status) async {
    final result =
        await http.post(link.Link.kaprodi + "getPengumuman.php", body: {
      "status": status,
    });
    final response = await json.decode(result.body);
    List data;
    int value = response['value'];
    String pesan = response['message'];
    if (value == 1) {
      data = json.decode(response['data']);
    } else {
      messageDanger(context, pesan);
    }
    return data;
  }

  Future<List> getPengumumanById(BuildContext context, int id) async {
    final result =
        await http.post(link.Link.kaprodi + "getPengumumanById.php", body: {
      "id": id.toString(),
    });
    final response = await json.decode(result.body);
    List data;
    int value = response['value'];
    String pesan = response['message'];
    if (value == 1) {
      data = json.decode(response['data']);
    } else {
      messageDanger(context, pesan);
    }
    return data;
  }

  Future<int> addPengumuman(BuildContext context, String tipe, String judul,
      String keterangan) async {
    final result =
        await http.post(link.Link.kaprodi + "addPengumuman.php", body: {
      "tipe": tipe,
      "judul": judul,
      "keterangan": keterangan,
    });
    final response = await json.decode(result.body);
    int value = response['value'];
    String pesan = response['message'];
    if (value == 1) {
      messageSuccess(context, pesan);
    } else {
      messageDanger(context, pesan);
    }
    return value;
  }
}
