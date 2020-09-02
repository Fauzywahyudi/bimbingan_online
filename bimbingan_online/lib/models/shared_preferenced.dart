import 'package:bimbingan_online/models/dosen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DataShared {
  Future<int> getId() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    int idUser = sharedPreferences.getInt("id");
    return idUser;
  }

  Future<int> getValue() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    int value = sharedPreferences.getInt("value");
    return value;
  }

  Future<String> getAktor() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String value = sharedPreferences.getString("aktor");
    return value;
  }

  Future<bool> getValueOnboarding() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    bool value = sharedPreferences.getBool("onboarding");
    return value;
  }

  Future setValueOnboarding(bool value) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setBool("onboarding", value);
  }

  Future<Dosen> getDataPrefDosen() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    Dosen dosen;
    int id = sharedPreferences.getInt("id");
    String username = sharedPreferences.getString("username");
    String nama = sharedPreferences.getString("nama");
    String gelar = sharedPreferences.getString("gelar");
    String jk = sharedPreferences.getString("jk");
    String jabatan = sharedPreferences.getString("jabatan");
    String alamat = sharedPreferences.getString("alamat");
    String nohp = sharedPreferences.getString("nohp");
    dosen = Dosen(id, username, nama, gelar, jk, jabatan, alamat, nohp);

    return dosen;
  }

  Future saveDataPrefDosen(int value, Dosen dosen) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setInt("value", value);
    sharedPreferences.setString("aktor", "Dosen");
    sharedPreferences.setInt("id", dosen.idDosen);
    sharedPreferences.setString("username", dosen.nidn);
    sharedPreferences.setString("nama", dosen.nama);
    sharedPreferences.setString("gelar", dosen.gelar);
    sharedPreferences.setString("jk", dosen.jk);
    sharedPreferences.setString("jabatan", dosen.jabatan);
    sharedPreferences.setString("alamat", dosen.alamat);
    sharedPreferences.setString("nohp", dosen.nohp);
  }

  Future logout() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setInt("value", null);
  }
}
