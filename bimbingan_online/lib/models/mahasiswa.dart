class Mahasiswa {
  int _idMahasiswa;
  String _nim;
  String _nama;
  String _jk;
  String _jurusan;
  String _alamat;
  String _nohp;

  Mahasiswa(this._idMahasiswa, this._nim, this._nama, this._jk, this._jurusan,
      this._alamat, this._nohp);

  int get idMahasiswa => this._idMahasiswa;
  String get nim => this._nim;
  String get nama => this._nama;
  String get jk => this._jk;
  String get jurusan => this._jurusan;
  String get alamat => this._alamat;
  String get nohp => this._nohp;

  set idMahasiswa(int value) => this._idMahasiswa = value;
  set nim(String value) => this._nim = value;
  set nama(String value) => this._nama = value;
  set jk(String value) => this._jk = value;
  set jurusan(String value) => this._jurusan = value;
  set alamat(String value) => this._alamat = value;
  set nohp(String value) => this._nohp = value;
}
