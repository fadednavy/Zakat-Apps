class BaseURL {
  // Online API
  static String urlBase = "http://172.20.10.6/api/api";

  // Auth
  static String apiLogin = '$urlBase/login.php';
  static String apiRegister = '$urlBase/register.php';

  // Metode
  static String urlListMetode = '$urlBase/metode/listMetode.php';

  // Zakat Harta
  static String addZakatHarta = '$urlBase/zakatHarta/add.php';
  static String apiListZakatHarta =
      '$urlBase/zakatHarta/riwayatZakatHarta.php?userid=';

  // Zakat Perdagangan
  static String addZakatPerdagangan = '$urlBase/zakatPerdagangan/add.php';
  static String apiListZakatPerdagangan =
      '$urlBase/zakatPerdagangan/riwayatZakatPerdagangan.php?userid=';

  // Zakat Profesi
  static String addZakatProfesi = '$urlBase/zakatProfesi/add.php';
  static String apiListZakatProfesi =
      '$urlBase/zakatProfesi/riwayatZakatProfesi.php?userid=';

  // Zakat Tabungan
  static String addZakatTabungan = '$urlBase/zakatTabungan/add.php';
  static String apiListZakatTabungan =
      '$urlBase/zakatTabungan/riwayatZakatTabungan.php?userid=';
}
