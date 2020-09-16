import 'dart:convert';

import 'package:bimbingan_online/models/dosen.dart';
import 'package:bimbingan_online/models/mahasiswa.dart';
import 'package:bimbingan_online/models/page_aktor.dart';
import 'package:bimbingan_online/models/shared_preferenced.dart';
import 'package:bimbingan_online/views/dosen/pages/home_dosen.dart';
import 'package:bimbingan_online/views/mahasiswa/pages/home_mahasiswa.dart';
import 'package:bimbingan_online/views/register.dart';
import 'package:flutter/material.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';
import 'package:http/http.dart' as http;
import 'package:bimbingan_online/utils/link.dart' as link;
import 'package:bimbingan_online/utils/assets.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  var _tecNim = TextEditingController();
  var _tecPass = TextEditingController();
  bool get _isMahasiswa => _pageLogin == PageAktor.isMahasiswa ? true : false;
  PageAktor _pageLogin = PageAktor.isMahasiswa;
  DataShared _dataShared = DataShared();

  Future _saveDataPrefDosen(int value, Dosen dosen) async {
    await _dataShared.saveDataPrefDosen(value, dosen);
  }

  Future _saveDataPrefMahasiswa(int value, Mahasiswa mahasiswa) async {
    await _dataShared.saveDataPrefMahasiswa(value, mahasiswa);
  }

  void _changePage(PageAktor page) {
    if (page == PageAktor.isMahasiswa) {
      if (!_isMahasiswa) {
        setState(() {
          _pageLogin = PageAktor.isMahasiswa;
        });
      }
    } else {
      if (_isMahasiswa) {
        setState(() {
          _pageLogin = PageAktor.isDosen;
        });
      }
    }
  }

  void _login() async {
    if (_validasi()) {
      final result = await http.post(link.Link.server + "login.php", body: {
        "aktor": _isMahasiswa ? "Mahasiswa" : "Dosen",
        "username": _tecNim.text,
        "password": _tecPass.text,
      });
      final response = await json.decode(result.body);
      int value = response['value'];
      String pesan = response['message'];

      if (value == 1) {
        final data = await json.decode(response['data']);
        if (_isMahasiswa) {
          Mahasiswa mahasiswa = Mahasiswa(
              int.parse(data['id_mahasiswa']),
              data['nim_mahasiswa'],
              data['nama_mahasiswa'],
              data['jk'],
              data['jurusan'],
              data['alamat'],
              data['nohp']);
          _saveDataPrefMahasiswa(value, mahasiswa);
          pushReplacePage(
              context,
              HomeMahasiswa(
                mahasiswa: mahasiswa,
              ));
        } else {
          Dosen dosen = Dosen(
              int.parse(data['id_dosen']),
              data['nidn_dosen'],
              data['nama_dosen'],
              data['gelar'],
              data['jk'],
              data['jabatan'],
              data['alamat'],
              data['nohp']);
          _saveDataPrefDosen(value, dosen);
          pushReplacePage(context, HomeDosen(dosen: dosen));
        }
        // setState(() async {
        //   _tecNim.text = "";
        //   _tecPass.text = "";
        // });
      } else if (value == 2) {
        messageInfo(context, pesan);
      } else {
        messageInfo(context, pesan + "\nUsername atau Password Salah!");
      }
    }
  }

  bool _validasi() {
    if (_tecNim.text.isEmpty) return false;
    if (_tecPass.text.isEmpty) return false;
    return true;
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
          ListView(
            children: <Widget>[
              Container(
                height: 420,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text("Login",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white70,
                            fontWeight: FontWeight.bold,
                            fontSize: 28.0)),

                    SizedBox(height: 50),
                    Card(
                      margin: EdgeInsets.only(left: 30, right: 30, top: 30),
                      elevation: 11,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(40))),
                      child: TextField(
                        controller: _tecNim,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.person,
                              color: Colors.black26,
                            ),
                            hintText: "${_isMahasiswa ? "NIM" : "NIDN"}",
                            hintStyle: TextStyle(color: Colors.black26),
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(40.0)),
                            ),
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 20.0, vertical: 16.0)),
                      ),
                    ),
                    Card(
                      margin: EdgeInsets.only(left: 30, right: 30, top: 20),
                      elevation: 11,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(40))),
                      child: TextField(
                        controller: _tecPass,
                        obscureText: true,
                        decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.lock,
                              color: Colors.black26,
                            ),
                            hintText: "Password",
                            hintStyle: TextStyle(
                              color: Colors.black26,
                            ),
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(40.0)),
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
                        onPressed: () => _login(),
                        elevation: 11,
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(40.0))),
                        child: Text("Login",
                            style: TextStyle(color: Colors.white70)),
                      ),
                    ),
                    // Text("Forgot your password?",
                    //     style: TextStyle(color: Colors.white))
                  ],
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Text("Login sebagai..."),
                    SizedBox(
                      height: 20.0,
                    ),
                    Row(
                      children: <Widget>[
                        SizedBox(
                          width: 20.0,
                        ),
                        Expanded(
                          child: RaisedButton(
                            child: Text("Mahasiswa"),
                            textColor: Colors.white,
                            color: _isMahasiswa
                                ? Colors.deepPurple
                                : Colors.deepPurple[100],
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(40)),
                            ),
                            onPressed: () => _changePage(PageAktor.isMahasiswa),
                          ),
                        ),
                        SizedBox(
                          width: 10.0,
                        ),
                        Expanded(
                          child: RaisedButton(
                            child: Text("Dosen"),
                            textColor: Colors.white,
                            color: !_isMahasiswa
                                ? Colors.deepPurple
                                : Colors.deepPurple[100],
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(40)),
                            ),
                            onPressed: () => _changePage(PageAktor.isDosen),
                          ),
                        ),
                        SizedBox(
                          width: 20.0,
                        ),
                      ],
                    ),
                    _isMahasiswa
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text("Belum punya akun?"),
                              FlatButton(
                                child: Text("Sign up"),
                                textColor: Colors.indigo,
                                onPressed: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Register(
                                      pageLogin: PageAktor.isMahasiswa,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          )
                        : Container()
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
