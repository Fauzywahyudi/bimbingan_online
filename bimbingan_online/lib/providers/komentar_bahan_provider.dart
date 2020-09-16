import 'dart:convert';
import 'package:bimbingan_online/models/komentar.dart';
import 'package:bimbingan_online/utils/assets.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:bimbingan_online/utils/link.dart' as link;

class KomentarBahanProvider {
  Future<List> getKomentarBahan(BuildContext context, int idBahan) async {
    final result =
        await http.post(link.Link.dosen + "getKomentarBahan.php", body: {
      "id_bahan": idBahan.toString(),
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

  Future addKomentar(BuildContext context, Komentar komentar) async {
    final result = await http.post(link.Link.dosen + "addKomentar.php", body: {
      "id_bahan": komentar.idBahan.toString(),
      "isi_pesan": komentar.isiPesan,
      "sender": komentar.sender,
      "receiver": komentar.receiver,
    });
    final response = await json.decode(result.body);
    int value = response['value'];
    String pesan = response['message'];
    if (value == 1) {
      // messageSuccess(context, pesan);
    } else {
      messageDanger(context, pesan);
    }
  }

  Future addKomentarMahasiswa(BuildContext context, Komentar komentar) async {
    final result = await http
        .post(link.Link.mahasiswa + "addKomentarMahasiswa.php", body: {
      "id_bahan": komentar.idBahan.toString(),
      "isi_pesan": komentar.isiPesan,
      "sender": komentar.sender,
      "receiver": komentar.receiver,
    });
    final response = await json.decode(result.body);
    int value = response['value'];
    String pesan = response['message'];
    if (value == 1) {
      // messageSuccess(context, pesan);
    } else {
      messageDanger(context, pesan);
    }
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

  // Future konfirmasi(BuildContext context, int idProposal, int idMahasiswa,
  //     String status) async {
  //   final result =
  //       await http.post(link.Link.kaprodi + "konfirmasiProposal.php", body: {
  //     "id_proposal": idProposal.toString(),
  //     "id_mahasiswa": idMahasiswa.toString(),
  //     "status": status,
  //   });
  //   final response = await json.decode(result.body);
  //   int value = response['value'];
  //   String pesan = response['message'];
  //   if (value == 1) {
  //     messageSuccess(context, pesan);
  //   } else {
  //     messageDanger(context, pesan);
  //   }
  // }
}
