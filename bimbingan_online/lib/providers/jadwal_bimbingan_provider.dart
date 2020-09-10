import 'dart:convert';
import 'package:bimbingan_online/utils/assets.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:bimbingan_online/utils/link.dart' as link;

class JadwalBimbinganProvider {
  Future<List> getJadwalBimbingan(
      BuildContext context, int idDosen, String status) async {
    final result =
        await http.post(link.Link.dosen + "getJadwalBimbingan.php", body: {
      "id_dosen": idDosen.toString(),
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

  // Future<List> getProposalById(BuildContext context, int id) async {
  //   final result =
  //       await http.post(link.Link.kaprodi + "getProposalById.php", body: {
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

  Future addJadwalBimbingan(BuildContext context, int idDosen,
      String jadwalMulai, jadwalSelesai, keterangan) async {
    final result =
        await http.post(link.Link.dosen + "addJadwalPembimbing.php", body: {
      "id_dosen": idDosen.toString(),
      "mulai": jadwalMulai.toString(),
      "akhir": jadwalSelesai.toString(),
      "keterangan": keterangan,
    });
    final response = await json.decode(result.body);
    int value = response['value'];
    String pesan = response['message'];
    if (value == 1) {
      messageSuccess(context, pesan);
      popPage(context);
    } else {
      messageDanger(context, pesan);
    }
  }
}
