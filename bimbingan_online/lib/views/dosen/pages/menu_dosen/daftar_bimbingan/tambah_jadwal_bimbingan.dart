import 'dart:convert';

import 'package:bimbingan_online/models/shared_preferenced.dart';
import 'package:bimbingan_online/providers/jadwal_bimbingan_provider.dart';
import 'package:bimbingan_online/utils/assets.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TambahJadwalBimbingan extends StatefulWidget {
  static const routeName = '/TambahJadwalBimbingan';
  @override
  _TambahJadwalBimbinganState createState() => _TambahJadwalBimbinganState();
}

class _TambahJadwalBimbinganState extends State<TambahJadwalBimbingan> {
  final format = DateFormat("yyyy-MM-dd HH:mm:ss");
  var _tecMulai = TextEditingController();
  var _tecAkhir = TextEditingController();
  var _tecKeterangan = TextEditingController();

  bool get _validasi =>
      _tecMulai.text.isNotEmpty &&
      _tecAkhir.text.isNotEmpty &&
      _tecKeterangan.text.isNotEmpty;

  void _addJadwal() async {
    JadwalBimbinganProvider _provider = JadwalBimbinganProvider();
    DataShared _dataShared = DataShared();
    int idDosen = await _dataShared.getId();
    if (_validasi) {
      await _provider.addJadwalBimbingan(context, idDosen, _tecMulai.text,
          _tecAkhir.text, _tecKeterangan.text);
    } else {
      messageInfo(context, "Harap isi semua data!");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Tambah Jadwal Bimbingan")),
      floatingActionButton: _buildFab(),
      body: Container(
        padding: EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              DateTimeField(
                format: format,
                controller: _tecMulai,
                decoration: InputDecoration(
                  labelText: "Jadwal Mulai",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  prefixIcon: Icon(Icons.schedule),
                ),
                onShowPicker: (context, currentValue) async {
                  final date = await showDatePicker(
                      context: context,
                      firstDate: DateTime(1900),
                      initialDate: currentValue ?? DateTime.now(),
                      lastDate: DateTime(2100));
                  if (date != null) {
                    final time = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.fromDateTime(
                          currentValue ?? DateTime.now()),
                    );
                    return DateTimeField.combine(date, time);
                  } else {
                    return currentValue;
                  }
                },
              ),
              SizedBox(height: 20),
              DateTimeField(
                format: format,
                controller: _tecAkhir,
                decoration: InputDecoration(
                  labelText: "Jadwal Selesai",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  prefixIcon: Icon(Icons.schedule),
                ),
                onShowPicker: (context, currentValue) async {
                  final date = await showDatePicker(
                      context: context,
                      firstDate: DateTime(1900),
                      initialDate: currentValue ?? DateTime.now(),
                      lastDate: DateTime(2100));
                  if (date != null) {
                    final time = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.fromDateTime(
                          currentValue ?? DateTime.now()),
                    );
                    return DateTimeField.combine(date, time);
                  } else {
                    return currentValue;
                  }
                },
              ),
              SizedBox(height: 20),
              TextField(
                controller: _tecKeterangan,
                minLines: 1,
                maxLines: 7,
                decoration: InputDecoration(
                  labelText: "Keterangan",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  prefixIcon: Icon(Icons.description),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  FloatingActionButton _buildFab() {
    return FloatingActionButton(
      child: Icon(Icons.check),
      onPressed: () => _addJadwal(),
    );
  }
}
