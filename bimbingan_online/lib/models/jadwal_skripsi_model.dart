class ModelJadwalSkripsi {
  int _idJadwal;
  int _idMahasiswa;
  String _tipeJadwal;
  String _mulai;
  String _selesai;
  String _penguji;
  String _keterangan;
  String _status;

  ModelJadwalSkripsi(this._idMahasiswa, this._tipeJadwal, this._mulai,
      this._selesai, this._penguji, this._keterangan);

  int get idJadwal => this._idJadwal;
  int get idMahasiswa => this._idMahasiswa;
  String get tipeJadwal => this._tipeJadwal;
  String get mulai => this._mulai;
  String get selesai => this._selesai;
  String get penguji => this._penguji;
  String get keterangan => this._keterangan;
  String get status => this._status;

  void setIdJadwal(int value) => this._idJadwal = value;
  void setStatus(String value) => this._status = value;
}
