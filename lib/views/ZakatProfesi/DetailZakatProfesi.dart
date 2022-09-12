import 'package:do_zakat/views/ZakatProfesi/KalZakatProfesi.dart';
import 'package:do_zakat/views/ZakatProfesi/RiwayatZakatTabungan.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:do_zakat/views/ZakatProfesi/TambahZakatProfesi.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class DetailZakatProfesi extends StatefulWidget {
  @override
  _DetailZakatProfesiState createState() => _DetailZakatProfesiState();
}

class _DetailZakatProfesiState extends State<DetailZakatProfesi> {
  String idUsers;

  _getUserid() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      idUsers = preferences.getInt("userid").toString();
    });
  }

  @override
  void initState() {
    super.initState();
    _getUserid();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Color(0xff003c35),
        statusBarBrightness: Brightness.light,
      ),
    );
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        brightness: Brightness.dark,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new),
          color: Color(0xffbf905f),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: <Color>[
                Color(0xff003c35),
                Color(0xff002924),
              ],
            ),
          ),
        ),
        title: GradientText(
          "Zakat Profesi",
          style: TextStyle(fontSize: 18.0),
          colors: [
            Color(0xffebbb7e),
            Color(0xffbf905f),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => new KalZakatProfesi()));
              },
              child: Icon(
                Icons.calculate,
                color: Color(0xffebbb7e),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 15),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => new RiwayatZakatProfesi()));
              },
              child: Icon(
                Icons.history,
                color: Color(0xffebbb7e),
              ),
            ),
          ),
        ],
      ),
      body: Container(
        child: SafeArea(
          child: Column(
            children: <Widget>[
              Expanded(
                child: PageView(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Container(
                          child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.asset(
                          'assets/icons/banner-zakatprofesi.png',
                          height: double.infinity,
                          width: double.infinity,
                          fit: BoxFit.fill,
                          alignment: Alignment.center,
                        ),
                      )),
                    ),
                  ],
                ),
              ),
              Container(
                height: size.height * 0.43,
                decoration: BoxDecoration(color: Colors.transparent),
                child: ListView(
                  physics: const NeverScrollableScrollPhysics(),
                  children: <Widget>[
                    Container(
                      height: size.height * 0.5,
                      padding: EdgeInsets.only(left: 25, right: 25),
                      child: Column(
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Expanded(
                                child: RichText(
                                  textAlign: TextAlign.justify,
                                  text: new TextSpan(
                                    style: new TextStyle(
                                      fontSize: 14.0,
                                      color: Colors.black,
                                    ),
                                    children: <TextSpan>[
                                      new TextSpan(
                                          text: 'Zakat Profesi ',
                                          style: new TextStyle(
                                              fontWeight: FontWeight.bold)),
                                      new TextSpan(
                                          text:
                                              'atau yang dikenal juga sebagai zakat penghasilan; zakat pendapatan adalah bagian dari zakat mal yang wajib dikeluarkan atas harta yang berasal dari pendapatan / penghasilan rutin dari pekerjaan yang tidak melanggar syariah. Nishab zakat penghasilan sebesar 85 gram emas per tahun. Kadar zakat penghasilan senilai 2,5%. \n\nCara menghitung Zakat Penghasilan:'),
                                      new TextSpan(
                                          text:
                                              '\n\n2,5% x Jumlah penghasilan dalam 1 bulan',
                                          style: new TextStyle(
                                              fontWeight: FontWeight.bold)),
                                      new TextSpan(
                                          text:
                                              '\n\nContoh: \nJika harga emas pada hari ini sebesar Rp800.000/gram, maka nishab zakat penghasilan dalam satu tahun adalah Rp68.000.000,-. Penghasilan Bapak Fulan sebesar Rp10.000.000/ bulan, atau Rp120.000.000,- dalam satu tahun. Artinya penghasilan Bapak Fulan sudah wajib zakat. Maka zakat Bapak Fulan adalah Rp250.000,-/ bulan.'),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Container(
                  width: double.infinity,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: MaterialButton(
                      color: Color(0xff003c35),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    new TambahZakatProfesi()));
                      },
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 16.0),
                        child: Text("Bayar Zakat Profesi",
                            style: TextStyle(color: Colors.white)),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
