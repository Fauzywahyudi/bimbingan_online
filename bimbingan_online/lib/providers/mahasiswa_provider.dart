import 'dart:convert';
import 'package:bimbingan_online/utils/assets.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:bimbingan_online/utils/link.dart' as link;

class MahasiswaProvider {
  Future<List> getMahasiswa(BuildContext context, String status) async {
    final result =
        await http.post(link.Link.kaprodi + "getMahasiswa.php", body: {
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

  Future<List> getMahasiswaById(BuildContext context, int id) async {
    final result =
        await http.post(link.Link.kaprodi + "getMahasiswaById.php", body: {
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

  Future<List> getJudulMahasiswa(BuildContext context, int idMahasiswa) async {
    final result =
        await http.post(link.Link.mahasiswa + "getJudulMahasiswa.php", body: {
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
}
