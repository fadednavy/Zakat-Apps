import 'package:do_zakat/views/ZakatPerdagangan/RiwayatZakatPerdagangan.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:do_zakat/views/ZakatPerdagangan/TambahZakatPerdagangan.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class DetailZakatPerdagangan extends StatefulWidget {
  @override
  _DetailZakatPerdaganganState createState() => _DetailZakatPerdaganganState();
}

class _DetailZakatPerdaganganState extends State<DetailZakatPerdagangan> {
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
          "Zakat Perdagangan",
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
                        builder: (context) => new RiwayatZakatPerdagangan()));
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
                            'assets/icons/banner-zakatperdagangan.png',
                            height: double.infinity,
                            width: double.infinity,
                            fit: BoxFit.fill,
                            alignment: Alignment.center,
                          ),
                        ),
                      ),
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
                                          text: 'Zakat Perdagangan ',
                                          style: new TextStyle(
                                              fontWeight: FontWeight.bold)),
                                      new TextSpan(
                                          text:
                                              'adalah zakat yang dikeluarkan dari harta niaga, sedangkan harta niaga adalah harta atau aset yang diperjualbelikan dengan maksud untuk mendapatkan keuntungan. \n\nNisab zakat perdagangan senilai 85 gram emas dengan tarif zakat sebesar 2,5% dan sudah mencapai satu tahun (haul). Berikut cara menghitung zakat perdagangan:'),
                                      new TextSpan(
                                          text:
                                              '\n\n2,5% x (aset lancar – hutang jangka pendek)',
                                          style: new TextStyle(
                                              fontWeight: FontWeight.bold)),
                                      new TextSpan(
                                          text:
                                              '\n\nContoh: \nBapak A memiliki aset usaha senilai Rp200.000.000,- dengan hutang jangka pendek senilai Rp50.000.000,-. Jika harga emas saat ini Rp622.000,-/gram, maka nishab zakat senilai Rp52.870.000,-. Sehingga Bapak A sudah wajib zakat atas dagangnya. Zakat perdagangan yang perlu Bapak A tunaikan sebesar 2,5% x (Rp200.000.000,- - Rp50.000.000,-) = Rp3.750.000,-.'),
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
                                    new TambahZakatPerdagangan()));
                      },
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 16.0),
                        child: Text("Bayar Zakat Perdagangan",
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
