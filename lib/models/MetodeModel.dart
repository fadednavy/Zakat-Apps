class MetodeModel {
  String idMetode;
  String namaMetode;
  String nomorVA;

  MetodeModel(this.idMetode, this.namaMetode, this.nomorVA);

  MetodeModel.fromJson(Map<String, dynamic> json) {
    idMetode = json['id_metode'];
    namaMetode = json['nama_metode'];
    nomorVA = json['nomor_va'];
  }
}
