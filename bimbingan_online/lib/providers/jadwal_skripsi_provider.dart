import 'dart:convert';
import 'package:bimbingan_online/models/jadwal_skripsi_model.dart';
import 'package:bimbingan_online/utils/assets.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:bimbingan_online/utils/link.dart' as link;

class JadwalSkripsiProvider {
  Future<List> getJadwalSkripsi(BuildContext context, String tipe) async {
    final result =
        await http.post(link.Link.kaprodi + "getJadwalSkripsi.php", body: {
      "tipe": tipe,
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

  Future addJadwalSkripsi(BuildContext context, ModelJadwalSkripsi data) async {
    String tipe = "";
    if (data.tipeJadwal == "Ujian Kompre") {
      tipe = "Kompre";
    } else {
      tipe = "Sempro";
    }
    final result =
        await http.post(link.Link.kaprodi + "addJadwalSkripsi.php", body: {
      "tipe": tipe,
      "mulai": data.mulai,
      "selesai": data.selesai,
      "id_mahasiswa": data.idMahasiswa.toString(),
      "penguji": data.penguji,
      "keterangan": data.keterangan,
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
