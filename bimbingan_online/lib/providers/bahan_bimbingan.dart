import 'dart:convert';
import 'package:bimbingan_online/utils/assets.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:bimbingan_online/utils/link.dart' as link;

class BahanBimbinganProvider {
  Future<List> getBahanBimbinganByDosen(
      BuildContext context, int idBimbingan, String status) async {
    final result = await http
        .post(link.Link.dosen + "getBahanBimbinganByDosen.php", body: {
      "id_bimbingan": idBimbingan.toString(),
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

  Future konfirmasiBahan(
      BuildContext context, int idBahan, idDosen, String status) async {
    final result =
        await http.post(link.Link.dosen + "konfirmasiBimbingan.php", body: {
      "id_bahan": idBahan.toString(),
      "id_dosen": idDosen.toString(),
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
