class RiwayatZakat {
  String userid;
  String jumlah;
  String tanggal;
  String namaMetode;

  RiwayatZakat(this.userid, this.jumlah, this.tanggal, this.namaMetode);

  RiwayatZakat.fromJson(Map<String, dynamic> json) {
    userid = json['userid'];
    jumlah = json['jumlah'];
    tanggal = json['tanggal'];
    namaMetode = json['nama_metode'];
  }
}
