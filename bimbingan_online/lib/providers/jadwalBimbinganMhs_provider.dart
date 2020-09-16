import 'dart:convert';
// import 'package:bimbingan_online/utils/assets.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:bimbingan_online/utils/link.dart' as link;

class JadwalMhsProvider {
  // ignore: missing_return
  Future<List> getJadwal(BuildContext context, int id, String tipe) async {
    try {
      // print("id mahasiswa:" + id.toString());
      final result =
          await http.post(link.Link.mahasiswa + "getJadwal.php", body: {
        "id_mahasiswa": id.toString(),
      });
      // print(result.body);
      final response = await json.decode(result.body);
      List data = json.decode(response[tipe]);

      return data;
    } catch (e) {}
  }

  // Future<List> getDosenById(BuildContext context, int id) async {
  //   final result =
  //       await http.post(link.Link.kaprodi + "getDosenById.php", body: {
  //     "id": id.toString(),
  //   });
  //   final response = await json.decode(result.body);
  //   List data;
  //   int value = response['value'];
  //   String pesan = response['message'];
  //   if (value == 1) {
  //     data = json.decode(response['data']);
  //   } else {
  //     messageDanger(context, pesan);
  //   }
  //   return data;
  // }
}
