import 'package:do_zakat/InfoApp.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:do_zakat/views/ZakatHarta/DetailZakatHarta.dart';
import 'package:do_zakat/views/ZakatPerdagangan/DetailZakatPerdagangan.dart';
import 'package:do_zakat/views/ZakatProfesi/DetailZakatProfesi.dart';
import 'package:do_zakat/views/ZakatTabungan/DetailZakatTabungan.dart';

class Home extends StatefulWidget {
  final VoidCallback signOut;
  Home(this.signOut);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  signOut() {
    setState(() {
      widget.signOut();
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Color(0xff003c35),
        statusBarBrightness: Brightness.light,
      ),
    );
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        brightness: Brightness.dark,
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
        title: Image.asset(
          "assets/icons/menglogo.png",
          width: 150,
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15),
            child: GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => new InfoApp()));
              },
              child: Icon(
                Icons.info_outline,
                color: Color(0xffebbb7e),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 15),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  signOut();
                });
              },
              child: Icon(
                Icons.logout,
                color: Color(0xffebbb7e),
              ),
            ),
          ),
        ],
      ),
      body: Container(
        color: Color(0xff003f37),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Stack(
                children: [
                  Image.asset('assets/icons/banner.png'),
                  Center(
                    child: Padding(
                      padding: EdgeInsets.only(top: 210),
                      child: Text(
                        "Selamat Datang",
                        style: TextStyle(
                            color: Color(0xffebbb7e),
                            fontSize: 45,
                            fontFamily: 'Ramadhan'),
                      ),
                    ),
                  ),
                ],
              ),
              Expanded(
                flex: 1,
                child: GridView.count(
                  crossAxisCount: 2,
                  padding: EdgeInsets.all(10),
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  children: [
                    Card(
                      color: Color(0xff01322d),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      new DetailZakatHarta()));
                        },
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                'assets/icons/zakatharta.png',
                                color: Color(0xffebbb7e),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Text(
                                "Zakat Harta",
                                style: TextStyle(
                                    fontSize: 16.0, color: Color(0xffebbb7e)),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Card(
                      color: Color(0xff01322d),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      new DetailZakatPerdagangan()));
                        },
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset('assets/icons/zakatperdagangan.png',
                                  color: Color(0xffebbb7e)),
                              SizedBox(
                                height: 15,
                              ),
                              Text(
                                "Zakat Perdagangan",
                                style: TextStyle(
                                    color: Color(0xffebbb7e), fontSize: 16.0),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Card(
                      color: Color(0xff01322d),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      new DetailZakatProfesi()));
                        },
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                'assets/icons/zakatprofesi.png',
                                color: Color(0xffebbb7e),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Text(
                                "Zakat Profesi",
                                style: TextStyle(
                                  color: Color(0xffebbb7e),
                                  fontSize: 16.0,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Card(
                      color: Color(0xff01322d),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      new DetailZakatTabungan()));
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              'assets/icons/zakatsimpanan.png',
                              color: Color(0xffebbb7e),
                            ),
                            SizedBox(
                              height: 15.0,
                            ),
                            Text(
                              "Zakat Tabungan",
                              style: TextStyle(
                                  color: Color(0xffebbb7e), fontSize: 16.0),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
