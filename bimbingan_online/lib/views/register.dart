import 'dart:convert';
import 'package:bimbingan_online/models/page_aktor.dart';
import 'package:flutter/material.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';
import 'package:http/http.dart' as http;
import 'package:bimbingan_online/utils/link.dart' as link;
import 'package:bimbingan_online/utils/assets.dart';

class Register extends StatefulWidget {
  final PageAktor pageLogin;

  const Register({Key key, this.pageLogin}) : super(key: key);
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  //mahasiswa
  var _tecNim = TextEditingController();
  var _tecPass = TextEditingController();
  var _tecNama = TextEditingController();
  var _tecNohp = TextEditingController();
  var _tecAlamat = TextEditingController();
  //dosen
  var _tecGelar = TextEditingController();
  var _tecNidn = TextEditingController();

  //mahasiswa
  var _focNim = FocusNode();
  var _focPass = FocusNode();
  var _focNama = FocusNode();
  var _focNohp = FocusNode();
  var _focAlamat = FocusNode();
  //dosen
  var _focGelar = FocusNode();
  var _focNidn = FocusNode();

  PageAktor _pageLogin;
  bool get _isMahasiswa => _pageLogin == PageAktor.isMahasiswa ? true : false;
  String _jenisKelamin = "";

  @override
  void initState() {
    _pageLogin = widget.pageLogin ?? PageAktor.isMahasiswa;
    super.initState();
  }

  bool _validasi() {
    if (_isMahasiswa && (_tecNim.text.isEmpty || _tecNim.text.length != 8))
      return false;
    if (_tecPass.text.isEmpty) return false;
    if (_tecNama.text.isEmpty) return false;
    if (_tecNohp.text.isEmpty || _tecNohp.text.length < 10) return false;
    if (_tecAlamat.text.isEmpty) return false;
    if (_jenisKelamin.isEmpty) return false;
    if (!_isMahasiswa && (_tecNidn.text.isEmpty || _tecNidn.text.length != 10))
      return false;
    if (!_isMahasiswa && _tecGelar.text.isEmpty) return false;
    return true;
  }

  void _register() async {
    if (_validasi()) {
      final result = await http.post(link.Link.server + "register.php", body: {
        "aktor": _isMahasiswa ? "Mahasiswa" : "Dosen",
        "nim": _tecNim.text,
        "nidn": _tecNidn.text,
        "pass": _tecPass.text,
        "nama": _tecNama.text,
        "jk": _jenisKelamin,
        "nohp": "+62" + _tecNohp.text,
        "alamat": _tecAlamat.text,
        "gelar": _tecGelar.text,
      });
      final response = await json.decode(result.body);
      int value = response['value'];
      String pesan = response['message'];
      print(pesan);
      if (value == 1) {
        messageSuccess(context, pesan + "\nMohon tunggu konfirmasi!");
        Navigator.pop(context);
      } else if (value == 2) {
        messageInfo(context, pesan);
      } else {
        messageDanger(context, pesan);
      }
    } else {
      if (_isMahasiswa &&
          (_tecNim.text.length != 8 && _tecNim.text.isNotEmpty)) {
        messageInfo(context, "NIM tidak valid!");
      } else if (_tecNohp.text.length < 10 && _tecNohp.text.isNotEmpty) {
        messageInfo(context, "No. HP tidak valid!");
      } else {
        messageInfo(context, "Harap Lengkapi Data!");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            height: 650,
            child: RotatedBox(
              quarterTurns: 2,
              child: WaveWidget(
                config: CustomConfig(
                  gradients: [
                    [Colors.deepPurple, Colors.deepPurple.shade200],
                    [Colors.indigo.shade200, Colors.purple.shade200],
                  ],
                  durations: [19440, 10800],
                  heightPercentages: [0.20, 0.25],
                  blur: MaskFilter.blur(BlurStyle.solid, 10),
                  gradientBegin: Alignment.bottomLeft,
                  gradientEnd: Alignment.topRight,
                ),
                waveAmplitude: 0,
                size: Size(
                  double.infinity,
                  double.infinity,
                ),
              ),
            ),
          ),
          _isMahasiswa
              ? _buildRegisterMahasiswa(context)
              : _buildRegisterDosen(context),
        ],
      ),
    );
  }

  ListView _buildRegisterMahasiswa(BuildContext context) {
    return ListView(
      children: <Widget>[
        Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: 30,
              ),
              Text("Register",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white70,
                      fontWeight: FontWeight.bold,
                      fontSize: 28.0)),
              Card(
                margin: EdgeInsets.only(left: 20, right: 20, top: 30),
                elevation: 11,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(40))),
                child: TextField(
                  controller: _tecNim,
                  focusNode: _focNim,
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.next,
                  onSubmitted: (v) {
                    FocusScope.of(context).requestFocus(_focPass);
                  },
                  decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.person,
                        color: colHint,
                      ),
                      hintText: "${_isMahasiswa ? "NIM" : "NIDN"}",
                      hintStyle: textHint,
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.all(Radius.circular(40.0)),
                      ),
                      contentPadding: EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 16.0)),
                ),
              ),
              Card(
                margin: EdgeInsets.only(left: 20, right: 20, top: 10),
                elevation: 11,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(40))),
                child: TextField(
                  controller: _tecPass,
                  focusNode: _focPass,
                  obscureText: true,
                  textInputAction: TextInputAction.next,
                  onSubmitted: (v) {
                    FocusScope.of(context).requestFocus(_focNama);
                  },
                  decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.lock,
                        color: colHint,
                      ),
                      hintText: "Password",
                      hintStyle: textHint,
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.all(Radius.circular(40.0)),
                      ),
                      contentPadding: EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 16.0)),
                ),
              ),
              Card(
                margin: EdgeInsets.only(left: 20, right: 20, top: 10),
                elevation: 11,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(40))),
                child: TextField(
                  controller: _tecNama,
                  focusNode: _focNama,
                  textInputAction: TextInputAction.next,
                  textCapitalization: TextCapitalization.words,
                  onSubmitted: (v) {
                    FocusScope.of(context).requestFocus(_focNohp);
                  },
                  decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.person,
                        color: colHint,
                      ),
                      hintText: "Nama Mahasiswa",
                      hintStyle: textHint,
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.all(Radius.circular(40.0)),
                      ),
                      contentPadding: EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 16.0)),
                ),
              ),
              Card(
                  margin: EdgeInsets.only(left: 20, right: 20, top: 10),
                  elevation: 11,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(40))),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                              top: 12,
                              right: 12,
                              left: 12,
                            ),
                            child: Icon(
                              Icons.wc,
                              color: colHint,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              top: 12,
                              right: 12,
                            ),
                            child: Text(
                              "Jenis Kelamin",
                              style: textHint.copyWith(fontSize: 17),
                            ),
                          ),
                          Expanded(
                            child: Container(),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Container(),
                          ),
                          Radio(
                            groupValue: _jenisKelamin,
                            value: "Laki-laki",
                            onChanged: (String value) {
                              setState(() {
                                _jenisKelamin = value;
                              });
                            },
                          ),
                          Text(
                            "Laki-laki",
                            style: textValue.copyWith(fontSize: 17),
                          ),
                          Expanded(child: Container()),
                          Radio(
                            groupValue: _jenisKelamin,
                            value: "Perempuan",
                            onChanged: (String value) {
                              setState(() {
                                _jenisKelamin = value;
                              });
                            },
                          ),
                          Text(
                            "Perempuan",
                            style: textValue.copyWith(fontSize: 17),
                          ),
                          SizedBox(
                            width: 30,
                          )
                        ],
                      ),
                    ],
                  )),
              Card(
                margin: EdgeInsets.only(left: 20, right: 20, top: 10),
                elevation: 11,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(40))),
                child: TextField(
                  controller: _tecNohp,
                  focusNode: _focNohp,
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.next,
                  onSubmitted: (v) {
                    FocusScope.of(context).requestFocus(_focAlamat);
                  },
                  onChanged: (v) {
                    if (v.length == 1 && v.contains("0")) {
                      print("suai");
                      _tecNohp.text = "";
                    }
                  },
                  decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.call,
                        color: colHint,
                      ),
                      prefixText: '+62 ',
                      prefixStyle: textValue,
                      hintText: "No. HP",
                      hintStyle: textHint,
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.all(Radius.circular(40.0)),
                      ),
                      contentPadding: EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 16.0)),
                ),
              ),
              Card(
                margin: EdgeInsets.only(left: 20, right: 20, top: 10),
                elevation: 11,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(40))),
                child: TextField(
                  controller: _tecAlamat,
                  focusNode: _focAlamat,
                  minLines: 1,
                  maxLines: 3,
                  textCapitalization: TextCapitalization.words,
                  decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.home,
                        color: colHint,
                      ),
                      hintText: "Alamat",
                      hintStyle: textHint,
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.all(Radius.circular(40.0)),
                      ),
                      contentPadding: EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 16.0)),
                ),
              ),
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(30.0),
                child: RaisedButton(
                  padding: EdgeInsets.symmetric(vertical: 16.0),
                  color: Colors.pink,
                  onPressed: () => _register(),
                  elevation: 11,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(40.0))),
                  child:
                      Text("Register", style: TextStyle(color: Colors.white70)),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 30),
      ],
    );
  }

  ListView _buildRegisterDosen(BuildContext context) {
    return ListView(
      children: <Widget>[
        Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: 30,
              ),
              Text("Register",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white70,
                      fontWeight: FontWeight.bold,
                      fontSize: 28.0)),
              Card(
                margin: EdgeInsets.only(left: 20, right: 20, top: 30),
                elevation: 11,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(40))),
                child: TextField(
                  controller: _tecNidn,
                  focusNode: _focNidn,
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.next,
                  onSubmitted: (v) {
                    FocusScope.of(context).requestFocus(_focPass);
                  },
                  decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.person,
                        color: colHint,
                      ),
                      hintText: "${_isMahasiswa ? "NIM" : "NIDN"}",
                      hintStyle: textHint,
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.all(Radius.circular(40.0)),
                      ),
                      contentPadding: EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 16.0)),
                ),
              ),
              Card(
                margin: EdgeInsets.only(left: 20, right: 20, top: 10),
                elevation: 11,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(40))),
                child: TextField(
                  controller: _tecPass,
                  focusNode: _focPass,
                  obscureText: true,
                  textInputAction: TextInputAction.next,
                  onSubmitted: (v) {
                    FocusScope.of(context).requestFocus(_focNama);
                  },
                  decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.lock,
                        color: colHint,
                      ),
                      hintText: "Password",
                      hintStyle: textHint,
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.all(Radius.circular(40.0)),
                      ),
                      contentPadding: EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 16.0)),
                ),
              ),
              Card(
                margin: EdgeInsets.only(left: 20, right: 20, top: 10),
                elevation: 11,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(40))),
                child: TextField(
                  controller: _tecNama,
                  focusNode: _focNama,
                  textInputAction: TextInputAction.next,
                  textCapitalization: TextCapitalization.words,
                  onSubmitted: (v) {
                    FocusScope.of(context).requestFocus(_focGelar);
                  },
                  decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.person,
                        color: colHint,
                      ),
                      hintText: "Nama Dosen",
                      hintStyle: textHint,
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.all(Radius.circular(40.0)),
                      ),
                      contentPadding: EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 16.0)),
                ),
              ),
              Card(
                margin: EdgeInsets.only(left: 20, right: 20, top: 10),
                elevation: 11,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(40))),
                child: TextField(
                  controller: _tecGelar,
                  focusNode: _focGelar,
                  textInputAction: TextInputAction.next,
                  textCapitalization: TextCapitalization.words,
                  onSubmitted: (v) {
                    FocusScope.of(context).requestFocus(_focNohp);
                  },
                  decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.school,
                        color: colHint,
                      ),
                      hintText: "Gelar",
                      hintStyle: textHint,
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.all(Radius.circular(40.0)),
                      ),
                      contentPadding: EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 16.0)),
                ),
              ),
              Card(
                  margin: EdgeInsets.only(left: 20, right: 20, top: 10),
                  elevation: 11,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(40))),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                              top: 12,
                              right: 12,
                              left: 12,
                            ),
                            child: Icon(
                              Icons.wc,
                              color: colHint,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              top: 12,
                              right: 12,
                            ),
                            child: Text(
                              "Jenis Kelamin",
                              style: textHint.copyWith(fontSize: 17),
                            ),
                          ),
                          Expanded(
                            child: Container(),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Container(),
                          ),
                          Radio(
                            groupValue: _jenisKelamin,
                            value: "Laki-laki",
                            onChanged: (String value) {
                              setState(() {
                                _jenisKelamin = value;
                              });
                            },
                          ),
                          Text(
                            "Laki-laki",
                            style: textValue.copyWith(fontSize: 17),
                          ),
                          Expanded(child: Container()),
                          Radio(
                            groupValue: _jenisKelamin,
                            value: "Perempuan",
                            onChanged: (String value) {
                              setState(() {
                                _jenisKelamin = value;
                              });
                            },
                          ),
                          Text(
                            "Perempuan",
                            style: textValue.copyWith(fontSize: 17),
                          ),
                          SizedBox(
                            width: 30,
                          )
                        ],
                      ),
                    ],
                  )),
              Card(
                margin: EdgeInsets.only(left: 20, right: 20, top: 10),
                elevation: 11,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(40))),
                child: TextField(
                  controller: _tecNohp,
                  focusNode: _focNohp,
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.next,
                  onSubmitted: (v) {
                    FocusScope.of(context).requestFocus(_focAlamat);
                  },
                  onChanged: (v) {
                    if (v.length == 1 && v.contains("0")) {
                      print("suai");
                      _tecNohp.text = "";
                    }
                  },
                  decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.call,
                        color: colHint,
                      ),
                      prefixText: '+62 ',
                      prefixStyle: textValue,
                      hintText: "No. HP",
                      hintStyle: textHint,
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.all(Radius.circular(40.0)),
                      ),
                      contentPadding: EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 16.0)),
                ),
              ),
              Card(
                margin: EdgeInsets.only(left: 20, right: 20, top: 10),
                elevation: 11,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(40))),
                child: TextField(
                  controller: _tecAlamat,
                  focusNode: _focAlamat,
                  minLines: 1,
                  maxLines: 3,
                  textCapitalization: TextCapitalization.words,
                  decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.home,
                        color: colHint,
                      ),
                      hintText: "Alamat",
                      hintStyle: textHint,
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.all(Radius.circular(40.0)),
                      ),
                      contentPadding: EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 16.0)),
                ),
              ),
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(30.0),
                child: RaisedButton(
                  padding: EdgeInsets.symmetric(vertical: 16.0),
                  color: Colors.pink,
                  onPressed: () => _register(),
                  elevation: 11,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(40.0))),
                  child:
                      Text("Register", style: TextStyle(color: Colors.white70)),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 30),
      ],
    );
  }
}
