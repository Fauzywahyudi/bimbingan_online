import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:bimbingan_online/utils/link.dart' as link;
import 'package:bimbingan_online/utils/assets.dart';

class PesanProvider {
  Future<List> getPesan(
      BuildContext context, int idDosen, int idMahasiswa, String status) async {
    final result = await http.post(link.Link.dosen + "getPesan.php", body: {
      "status": status,
      "id_dosen": idDosen.toString(),
      "id_mahasiswa": idMahasiswa.toString(),
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

  Future<List> getBahanByIdBimbingan(
      BuildContext context, int idBimbingan) async {
    final result =
        await http.post(link.Link.mahasiswa + "getBahanPesan.php", body: {
      "id_bimbingan": idBimbingan.toString(),
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

  // Future<List> getPesanById(BuildContext context, int id) async {
  //   final result =
  //       await http.post(link.Link.kaprodi + "getPesanById.php", body: {
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

  // Future<int> addPesan(BuildContext context, String tipe, String judul,
  //     String keterangan) async {
  //   final result =
  //       await http.post(link.Link.kaprodi + "addPesan.php", body: {
  //     "tipe": tipe,
  //     "judul": judul,
  //     "keterangan": keterangan,
  //   });
  //   final response = await json.decode(result.body);
  //   int value = response['value'];
  //   String pesan = response['message'];
  //   if (value == 1) {
  //     messageSuccess(context, pesan);
  //   } else {
  //     messageDanger(context, pesan);
  //   }
  //   return value;
  // }
}
