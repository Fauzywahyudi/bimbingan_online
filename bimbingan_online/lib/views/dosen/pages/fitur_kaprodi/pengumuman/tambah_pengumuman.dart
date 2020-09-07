import 'package:bimbingan_online/providers/pengumuman_provider.dart';
import 'package:bimbingan_online/utils/assets.dart';
import 'package:flutter/material.dart';

class TambahPengumuman extends StatefulWidget {
  static const routeName = '/TambahPengumuman';
  @override
  _TambahPengumumanState createState() => _TambahPengumumanState();
}

class _TambahPengumumanState extends State<TambahPengumuman> {
  var _tecJudul = TextEditingController();
  var _tecKeterangan = TextEditingController();

  PengumumanProvider _pengumumanProvider = PengumumanProvider();

  List _tipePengumuman = ["Seminar Proposal", "Skripsi", "Ujian Kompre", "Dll"];
  List<DropdownMenuItem<String>> _dropDownMenuItems;
  String _currentTipe;
  @override
  void initState() {
    _dropDownMenuItems = getDropDownMenuItems();
    _currentTipe = _dropDownMenuItems[0].value;
    super.initState();
  }

  List<DropdownMenuItem<String>> getDropDownMenuItems() {
    List<DropdownMenuItem<String>> items = new List();
    for (String tipe in _tipePengumuman) {
      items.add(new DropdownMenuItem(value: tipe, child: new Text(tipe)));
    }
    return items;
  }

  void changedDropDownItem(String selectedTipe) {
    setState(() {
      _currentTipe = selectedTipe;
    });
  }

  void _addPengumuman() async {
    final response = await _pengumumanProvider.addPengumuman(
        context, _currentTipe, _tecJudul.text, _tecKeterangan.text);
    if (response == 1) popPage(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tambah Pengumuman"),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.check),
        onPressed: () => _addPengumuman(),
      ),
      body: Container(
        padding: EdgeInsets.all(15),
        child: SingleChildScrollView(
          child: Column(
            children: [
              _buildDropdownButton(),
              SizedBox(height: 20),
              TextField(
                controller: _tecJudul,
                decoration: InputDecoration(
                  labelText: "Judul Pengumuman",
                  prefixIcon: Icon(Icons.label),
                ),
              ),
              SizedBox(height: 20),
              TextField(
                controller: _tecKeterangan,
                decoration: InputDecoration(
                  labelText: "Keterangan Pengumuman",
                  prefixIcon: Icon(Icons.announcement),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDropdownButton() {
    return Row(
      children: [
        SizedBox(width: 10),
        Icon(
          Icons.info,
          color: Colors.black54,
        ),
        SizedBox(width: 10),
        Text(
          "Tipe Pengumuman",
          style: TextStyle(color: Colors.black54),
        ),
        Expanded(child: Container()),
        DropdownButtonHideUnderline(
          child: DropdownButton(
            value: _currentTipe,
            items: _dropDownMenuItems,
            onChanged: changedDropDownItem,
          ),
        )
      ],
    );
  }
}
