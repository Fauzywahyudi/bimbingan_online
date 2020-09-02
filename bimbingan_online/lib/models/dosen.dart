class Dosen {
  int _idDosen;
  String _nidn;
  String _nama;
  String _gelar;
  String _jk;
  String _jabatan;
  String _alamat;
  String _nohp;

  Dosen(this._idDosen, this._nidn, this._nama, this._gelar, this._jk,
      this._jabatan, this._alamat, this._nohp);

  int get idDosen => this._idDosen;
  String get nidn => this._nidn;
  String get nama => this._nama;
  String get gelar => this._gelar;
  String get jk => this._jk;
  String get jabatan => this._jabatan;
  String get alamat => this._alamat;
  String get nohp => this._nohp;

  set idDosen(int value) => this._idDosen = value;
  set nidn(String value) => this._nidn = value;
  set nama(String value) => this._nama = value;
  set gelar(String value) => this._gelar = value;
  set jk(String value) => this._jk = value;
  set jabatan(String value) => this._jabatan = value;
  set alamat(String value) => this._alamat = value;
  set nohp(String value) => this._nohp = value;
}
