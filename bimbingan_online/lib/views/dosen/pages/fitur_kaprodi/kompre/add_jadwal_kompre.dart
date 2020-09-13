import 'dart:async';

import 'package:bimbingan_online/providers/dosen_provider.dart';
import 'package:bimbingan_online/providers/judul_provider.dart';
import 'package:bimbingan_online/providers/mahasiswa_provider.dart';
import 'package:bimbingan_online/utils/assets.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class AddJadwalKompre extends StatefulWidget {
  @override
  _AddJadwalKompreState createState() => _AddJadwalKompreState();
}

class _AddJadwalKompreState extends State<AddJadwalKompre> {
  final format = DateFormat("yyyy-MM-dd HH:mm:ss");
  var _tecMulai = TextEditingController();
  var _tecAkhir = TextEditingController();
  var _tecKeterangan = TextEditingController();

  String _pembimbing1 = "";
  String _pembimbing2 = "";
  String _mahasiswa = "";
  String _nim = "";
  DosenProvider _dosenProvider = DosenProvider();
  JudulProvider _judulProvider = JudulProvider();
  MahasiswaProvider _mahasiswaProvider = MahasiswaProvider();
  int _idPembimbing1;
  int _idPembimbing2;
  int _idMahasiswa;
  var _boxDecor = BoxDecoration(
      // color: colPrimary,
      borderRadius: BorderRadius.only(
    topLeft: Radius.circular(20),
    topRight: Radius.circular(20),
  ));

  void _setPembimbing1(var list) {
    setState(() {
      if (_idPembimbing2 == int.parse(list['id_dosen'])) {
        messageInfo(context, "Dosen Pembimbing harus berbeda");
      } else {
        _idPembimbing1 = int.parse(list['id_dosen']);
        _pembimbing1 = list['nama_dosen'] + " " + list['gelar'];
      }
    });
  }

  void _setPembimbing2(var list) {
    setState(() {
      if (_idPembimbing1 == int.parse(list['id_dosen'])) {
        messageInfo(context, "Dosen Pembimbing harus berbeda");
      } else {
        _idPembimbing2 = int.parse(list['id_dosen']);
        _pembimbing2 = list['nama_dosen'] + " " + list['gelar'];
      }
    });
  }

  List _jurusan = [
    "Seminar Proposal",
    "Ujian Kompre",
  ];
  List<DropdownMenuItem<String>> _dropDownMenuItems;
  String _currentJurusan;

  List<DropdownMenuItem<String>> getDropDownMenuItems() {
    List<DropdownMenuItem<String>> items = new List();
    for (String jurusan in _jurusan) {
      items.add(new DropdownMenuItem(value: jurusan, child: new Text(jurusan)));
    }
    return items;
  }

  void changedDropDownItem(String selectedJurusan) {
    setState(() {
      _currentJurusan = selectedJurusan;
    });
  }

  Future<List> _getDosen() async {
    final result = await _dosenProvider.getDosen(context, "Confirm");
    return result;
  }

  Future<List> _getMahasiswa() async {
    final result = await _mahasiswaProvider.getMahasiswa(context, "Confirm");
    return result;
  }

  Future<Null> handleRefresh() async {
    Completer<Null> completer = new Completer<Null>();
    new Future.delayed(new Duration(milliseconds: 500)).then((_) {
      completer.complete();
      setState(() {});
    });
    return completer.future;
  }

  void _showModal(String dospem) {
    showMaterialModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      builder: (context, scrollController) => Container(
        height: 500,
        decoration: _boxDecor,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 75,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                  color: colLight,
                ),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: "Cari Dosen...",
                    border: InputBorder.none,
                    prefixIcon: Icon(Icons.search),
                  ),
                ),
              ),
              Container(
                color: colLight,
                height: 425,
                child: FutureBuilder<List>(
                  future: _getDosen(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) print(snapshot.error);
                    return snapshot.hasData
                        ? RefreshIndicator(
                            onRefresh: handleRefresh,
                            child: ListView.builder(
                              itemCount: snapshot.data.length,
                              itemBuilder: (context, index) {
                                return Card(
                                  child: ListTile(
                                    key: ValueKey(
                                        snapshot.data[index]['id_dosen']),
                                    title: Text(snapshot.data[index]
                                            ['nama_dosen'] +
                                        " " +
                                        snapshot.data[index]['gelar']),
                                    trailing: OutlineButton(
                                      onPressed: () {
                                        setState(
                                          () {
                                            if (dospem == "dospem1") {
                                              _setPembimbing1(
                                                  snapshot.data[index]);
                                            } else {
                                              _setPembimbing2(
                                                  snapshot.data[index]);
                                            }
                                            popPage(context);
                                          },
                                        );
                                      },
                                      child: Text("Select"),
                                    ),
                                  ),
                                );
                              },
                            ),
                          )
                        : Center(
                            child: CircularProgressIndicator(),
                          );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showModalMahasiswa() {
    showMaterialModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      builder: (context, scrollController) => Container(
        height: 500,
        decoration: _boxDecor,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 75,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                  color: colLight,
                ),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: "Cari Mahasiswa...",
                    border: InputBorder.none,
                    prefixIcon: Icon(Icons.search),
                  ),
                ),
              ),
              Container(
                color: colLight,
                height: 425,
                child: FutureBuilder<List>(
                  future: _getMahasiswa(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) print(snapshot.error);
                    return snapshot.hasData
                        ? RefreshIndicator(
                            onRefresh: handleRefresh,
                            child: ListView.builder(
                              itemCount: snapshot.data.length,
                              itemBuilder: (context, index) {
                                return Card(
                                  child: ListTile(
                                    key: ValueKey(
                                        snapshot.data[index]['id_dosen']),
                                    title: Text(
                                        snapshot.data[index]['nama_mahasiswa']),
                                    subtitle: Text(
                                        snapshot.data[index]['nim_mahasiswa']),
                                    trailing: OutlineButton(
                                      onPressed: () {
                                        setState(
                                          () {
                                            setState(() {
                                              _mahasiswa = snapshot.data[index]
                                                  ['nama_mahasiswa'];
                                              _idMahasiswa = int.parse(snapshot
                                                  .data[index]['id_mahasiswa']);
                                              _nim = snapshot.data[index]
                                                  ['nim_mahasiswa'];
                                            });
                                            popPage(context);
                                          },
                                        );
                                      },
                                      child: Text("Select"),
                                    ),
                                  ),
                                );
                              },
                            ),
                          )
                        : Center(
                            child: CircularProgressIndicator(),
                          );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _addJadwal() async {}

  @override
  void initState() {
    _dropDownMenuItems = getDropDownMenuItems();
    _currentJurusan = _dropDownMenuItems[0].value;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Tambah Jadwal")),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _addJadwal(),
        child: Icon(Icons.check),
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(children: [
            Card(
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                    child: Text(
                      "Jadwal",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                  _buildDropDown(),
                  // SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: DateTimeField(
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
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: DateTimeField(
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
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: _tecKeterangan,
                      minLines: 1,
                      maxLines: 4,
                      decoration: InputDecoration(
                        labelText: "Keterangan",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        prefixIcon: Icon(Icons.description),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            _buildMahasiswa(context),
            SizedBox(height: 10),
            _buildPenguji(context),
            SizedBox(height: 80),
          ]),
        ),
      ),
    );
  }

  Card _buildPenguji(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Text(
              "Dosen Penguji",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Text("Penguji 1"),
                ),
                _pembimbing1.isEmpty || _pembimbing1 == null
                    ? Container()
                    : ListTile(
                        leading: Icon(Icons.person),
                        title: Text(_pembimbing1),
                        trailing: IconButton(
                            icon: Icon(Icons.close),
                            onPressed: () {
                              setState(() {
                                _pembimbing1 = "";
                                _idPembimbing1 = null;
                              });
                            }),
                      ),
                Row(
                  children: [
                    Expanded(child: Container()),
                    _pembimbing1.isEmpty || _pembimbing1 == null
                        ? OutlineButton(
                            color: colPrimary,
                            onPressed: () => _showModal("dospem1"),
                            child: Text("Pilih Dosen"))
                        : Container()
                  ],
                ),
              ],
            ),
          ),
          _currentJurusan == "Ujian Kompre"
              ? Container()
              : Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Text("Penguji 2"),
                      ),
                      _pembimbing2.isEmpty || _pembimbing2 == null
                          ? Container()
                          : ListTile(
                              leading: Icon(Icons.person),
                              title: Text(_pembimbing2),
                              trailing: IconButton(
                                  icon: Icon(Icons.close),
                                  onPressed: () {
                                    setState(() {
                                      _pembimbing2 = "";
                                      _idPembimbing2 = null;
                                    });
                                  }),
                            ),
                      Row(
                        children: [
                          Expanded(child: Container()),
                          _pembimbing2.isEmpty || _pembimbing2 == null
                              ? OutlineButton(
                                  color: colPrimary,
                                  onPressed: () => _showModal("dospem2"),
                                  child: Text("Pilih Dosen"))
                              : Container(),
                        ],
                      ),
                    ],
                  ),
                ),
        ],
      ),
    );
  }

  Card _buildMahasiswa(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Text(
              "Mahasiswa",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _mahasiswa.isEmpty || _mahasiswa == null
                    ? Container(
                        padding: EdgeInsets.symmetric(horizontal: 15),
                        child:
                            Text("Silahkan pilih Mahasiswa", style: textDanger))
                    : Column(
                        children: [
                          ListTile(
                            leading: Icon(Icons.person),
                            title: Text(_mahasiswa),
                            subtitle: Text("Nim : " + _nim),
                            trailing: _mahasiswa.isEmpty || _mahasiswa == null
                                ? Container()
                                : IconButton(
                                    icon: Icon(Icons.close),
                                    onPressed: () {
                                      setState(() {
                                        _mahasiswa = "";
                                        _idMahasiswa = null;
                                      });
                                    }),
                          ),
                        ],
                      ),
                Row(
                  children: [
                    Expanded(child: Container()),
                    _mahasiswa.isEmpty || _mahasiswa == null
                        ? Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: OutlineButton(
                                color: colPrimary,
                                onPressed: () => _showModalMahasiswa(),
                                child: Text("Pilih Mahasiswa")),
                          )
                        : Container()
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Container _buildDropDown() {
    return Container(
      margin: EdgeInsets.all(8),
      padding: const EdgeInsets.only(
        left: 10,
        right: 15,
        bottom: 6,
        top: 6,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(width: 1, color: Colors.black38),
      ),
      child: Row(
        children: [
          Icon(
            Icons.info_outline,
            color: Colors.black54,
          ),
          SizedBox(width: 15),
          Text(
            "Tipe Jadwal",
            style: TextStyle(color: Colors.black54, fontSize: 17),
          ),
          Expanded(child: Container()),
          DropdownButtonHideUnderline(
            child: DropdownButton(
              value: _currentJurusan,
              items: _dropDownMenuItems,
              onChanged: changedDropDownItem,
            ),
          )
        ],
      ),
    );
  }
}
