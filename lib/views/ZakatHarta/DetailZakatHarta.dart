import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:do_zakat/views/ZakatHarta/RiwayatZakatHarta.dart';
import 'package:do_zakat/views/ZakatHarta/TambahZakatHarta.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class DetailZakatHarta extends StatefulWidget {
  @override
  _DetailZakatHartaState createState() => _DetailZakatHartaState();
}

class _DetailZakatHartaState extends State<DetailZakatHarta> {
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
          "Zakat Harta",
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
                        builder: (context) => new RiwayatZakatHarta()));
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
                  physics: NeverScrollableScrollPhysics(),
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Container(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.asset(
                            'assets/icons/banner-zakatharta.png',
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
                      height: size.height * 0.4,
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
                                          text: 'Maal ',
                                          style: new TextStyle(
                                              fontWeight: FontWeight.bold)),
                                      new TextSpan(
                                          text:
                                              'berasal dari kata bahasa Arab artinya harta atau kekayaan (al-amwal, jamak dari kata maal) adalah “segala hal yang diinginkan manusia untuk disimpan dan dimiliki” (Lisan ul-Arab). Menurut Islam sendiri, harta merupakan sesuatu yang boleh atau dapat dimiliki dan digunakan (dimanfaatkan) sesuai kebutuhannya. \n\nOleh karena itu dalam pengertiannya, zakat maal berarti zakat yang dikenakan atas segala jenis harta, yang secara zat maupun substansi perolehannya tidak bertentangan dengan ketentuan agama. \n\nSebagai contoh, zakat maal terdiri atas simpanan kekayaan seperti uang, emas, surat berharga, penghasilan profesi, aset perdagangan, hasil barang tambang atau hasil laut, hasil sewa aset dan lain sebagainya.'),
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
                                builder: (context) => new TambahZakatHarta()));
                      },
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 16.0),
                        child: Text("Bayar Zakat Harta",
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
