import 'package:do_zakat/views/ZakatTabungan/RiwayatZakatTabungan.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:do_zakat/views/ZakatTabungan/TambahZakatTabungan.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class DetailZakatTabungan extends StatefulWidget {
  @override
  _DetailZakatTabunganState createState() => _DetailZakatTabunganState();
}

class _DetailZakatTabunganState extends State<DetailZakatTabungan> {
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
          "Zakat Tabungan",
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
                        builder: (context) => new RiwayatZakatTabungan()));
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
                          'assets/icons/banner-zakatsimpanan.png',
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
                                          text: 'Zakat Tabungan ',
                                          style: new TextStyle(
                                              fontWeight: FontWeight.bold)),
                                      new TextSpan(
                                          text:
                                              'adalah kewajiban untuk mengeluarkan zakat atas harta atau uang yang disimpan di dalam tabungan saat sudah memenuhi nisab. \n\nLantas, bagaimana perhitungan zakat tabungan?'),
                                      new TextSpan(
                                          text:
                                              '\n\nPrinsip dasar perhitungan zakat adalah mengeluarkan 2,5% dari jumlah harta yang dimiliki jika telah memenuhi nishab dan haul. Nishab emas adalah 20 dinar yang setara dengan 85 gram emas murni, dan nishab perak sebesar 200 dirham yang setara dengan 672 gram perak. Sedangkan nishab uang mengikuti jumlah nishab emas yang disesuaikan dengan harganya saat itu. Misalnya harga emas saat itu sebesar Rp 500.000 per gram, maka nominal tersebut dikalikan dengan batas nishab 85 gram. Jadi nishab uang yang perlu dikeluarkan zakatnya adalah sebesar Rp 42.500.000.'),
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
                                    new TambahZakatTabungan()));
                      },
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 16.0),
                        child: Text("Bayar Zakat Tabungan",
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
