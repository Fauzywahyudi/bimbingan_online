class Komentar {
  int _idKomentar;
  int _idBahan;
  String _isiPesan;
  String _sender;
  String _receiver;
  String _tglPost;

  Komentar(this._idKomentar, this._idBahan, this._isiPesan, this._sender,
      this._receiver, this._tglPost);

  int get idKomentar => this._idKomentar;
  int get idBahan => this._idBahan;
  String get isiPesan => this._isiPesan;
  String get sender => this._sender;
  String get receiver => this._receiver;
  String get tglPost => this._tglPost;

  void setIdKomentar(int value) => this._idKomentar = value;
  void setIdBahan(int value) => this._idBahan = value;
  void setIsiPesan(String value) => this._isiPesan = value;
  void setSender(String value) => this._sender = value;
  void setReceiver(String value) => this._receiver = value;
  void setTglPost(String value) => this._tglPost = value;
}
