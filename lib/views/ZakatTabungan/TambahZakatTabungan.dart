import 'dart:convert';

import 'package:do_zakat/views/Login/LoginPage.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:do_zakat/models/MetodeModel.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import 'package:http/http.dart' as http;
import 'package:do_zakat/models/api.dart';

class TambahZakatTabungan extends StatefulWidget {
  @override
  _TambahZakatTabunganState createState() => _TambahZakatTabunganState();
}

class _TambahZakatTabunganState extends State<TambahZakatTabungan> {
  String nominal, metodeID;
  var idUsers;

  final _key = new GlobalKey<FormState>();

  getPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      idUsers = preferences.getInt("userid").toString();
    });
  }

  MetodeModel _currentMetode;
  final String linkMetode = BaseURL.urlListMetode;
  Future<List<MetodeModel>> _fetchMetode() async {
    var response = await http.get(Uri.parse(linkMetode));
    if (response.statusCode == 200) {
      final items = json.decode(response.body).cast<Map<String, dynamic>>();
      List<MetodeModel> listOfMetode = items.map<MetodeModel>((json) {
        return MetodeModel.fromJson(json);
      }).toList();

      return listOfMetode;
    } else {
      throw Exception("Failed to Load Internet");
    }
  }

  check() async {
    final form = _key.currentState;
    if (form.validate()) {
      form.save();
      simpanTransaksi();
    }
  }

  simpanTransaksi() async {
    try {
      final response = await http.post(Uri.parse(BaseURL.addZakatTabungan),
          body: {"userid": idUsers, "id_metode": metodeID, "jumlah": nominal});
      final data = jsonDecode(response.body);
      int code = data['code'];
      String pesan = data['message'];

      if (code == 201 || code == 200) {
        print("reload");
        setState(() {
          var route = new MaterialPageRoute(
            builder: (BuildContext context) => new RingkasanZakatTabungan(
                nominal: nominal, pembayaran: metodeID),
          );
          Navigator.of(context).push(route);
        });
      } else {
        print(pesan);
      }
    } catch (e) {
      print("errmsg");
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    getPref();
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
          )),
        ),
        title: GradientText(
          "Bayar Zakat Tabungan",
          style: TextStyle(fontSize: 18.0),
          colors: [
            Color(0xffebbb7e),
            Color(0xffbf905f),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(
          top: 40,
          left: 20,
          right: 20,
        ),
        child: Container(
          color: Colors.white,
          child: Column(
            children: [
              Expanded(
                flex: 1,
                child: Column(
                  children: [
                    Image.asset(
                      "assets/icons/niatzakat.png",
                      color: Color(0xff1f1f1f),
                      width: 800,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Center(
                        child: Text(
                      "Nawaitu an Ukhrija Zakaata Maali Fardhon Lillaahi Ta'aala",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.black),
                    )),
                    SizedBox(
                      height: 15,
                    ),
                    Center(
                      child: Text(
                        "Artinya : 'Saya berniat sengaja mengeluarkan zakat fardhu karena Allah Ta'ala'",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 2,
                child: Container(
                  child: Form(
                    key: _key,
                    child: ListView(
                      children: [
                        TextFormField(
                          validator: (e) {
                            if (e.isEmpty) {
                              return "Harap isi nominal!";
                            }
                          },
                          onSaved: (e) => nominal = e,
                          style: TextStyle(
                            color: Colors.grey[600],
                          ),
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                  borderSide: BorderSide.none),
                              prefixIcon: Icon(
                                Icons.money,
                                color: Colors.grey[600],
                              ),
                              hoverColor: Colors.grey[600],
                              filled: true,
                              fillColor: Colors.grey[300],
                              hintText: "Isi Nominal Zakat",
                              hintStyle: TextStyle(color: Colors.grey[600])),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        FutureBuilder<List<MetodeModel>>(
                            future: _fetchMetode(),
                            builder: (BuildContext context,
                                AsyncSnapshot<List<MetodeModel>> snapshot) {
                              if (!snapshot.hasData)
                                return ClipRRect(
                                  borderRadius: BorderRadius.circular(8.0),
                                  child: LinearProgressIndicator(
                                    color: Colors.grey[600],
                                    backgroundColor: Colors.grey[300],
                                    minHeight: 58,
                                  ),
                                );
                              return Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 10.0, vertical: 5.0),
                                decoration: BoxDecoration(
                                    color: Colors.grey[300],
                                    borderRadius: BorderRadius.circular(10)),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.how_to_reg,
                                      color: Colors.grey[600],
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    DropdownButton<MetodeModel>(
                                      icon: Icon(Icons.arrow_drop_down),
                                      iconSize: 42,
                                      underline: SizedBox(),
                                      items: snapshot.data
                                          .map((listMetode) =>
                                              DropdownMenuItem<MetodeModel>(
                                                child:
                                                    Text(listMetode.namaMetode),
                                                value: listMetode,
                                              ))
                                          .toList(),
                                      onChanged: (MetodeModel value) {
                                        setState(() {
                                          _currentMetode = value;
                                          metodeID = _currentMetode.idMetode;
                                        });
                                      },
                                      isExpanded: false,
                                      hint: Text(
                                        metodeID == null
                                            ? " Pilih Metode Pembayaran "
                                            : _currentMetode.namaMetode,
                                        style:
                                            TextStyle(color: Colors.grey[600]),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }),
                        SizedBox(
                          height: 5,
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        Container(
                          width: double.infinity,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: MaterialButton(
                              color: Color(0xff003c35),
                              onPressed: () {
                                check();
                              },
                              child: Padding(
                                padding: EdgeInsets.symmetric(vertical: 16.0),
                                child: Text("Lanjut Pembayaran",
                                    style: TextStyle(color: Colors.white)),
                              ),
                            ),
                          ),
                        ),
                      ],
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

class RingkasanZakatTabungan extends StatefulWidget {
  final String nominal, pembayaran;

  RingkasanZakatTabungan({Key, key, this.nominal, this.pembayaran})
      : super(key: key);
  @override
  _RingkasanZakatTabunganState createState() => _RingkasanZakatTabunganState();
}

class _RingkasanZakatTabunganState extends State<RingkasanZakatTabungan> {
  @override
  signOut() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      preferences.setInt("code", null);
      preferences.setInt("level", null);
      preferences.commit();
    });
  }

  getCurrentDate() {
    return DateFormat('yyyy-MM-dd').format(DateTime.now());
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
          child: ListView(
        padding: EdgeInsets.only(top: 300.0, left: 20.0, right: 20.0),
        children: <Widget>[
          // Padding(
          //   padding: const EdgeInsets.all(100.0),
          //   child: Center(
          //     child: Image.asset("assets/img/checklist.png"),
          //   ),
          // ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Ringkasan Zakat Tabungan',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(
                height: 12,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Tanggal',
                    style: TextStyle(
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    getCurrentDate(),
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 12,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Nominal Zakat',
                    style: TextStyle(
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    '${widget.nominal}',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 12,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Metode Pembayaran',
                    style: TextStyle(
                      fontSize: 14,
                    ),
                  ),
                  Text((() {
                    if ('${widget.pembayaran}' == '1') {
                      return "Mandiri VA";
                    }
                    return "BRI VA";
                  })())
                ],
              ),
              SizedBox(
                height: 12,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Nomor Virtual Account',
                    style: TextStyle(
                      fontSize: 14,
                    ),
                  ),
                  Text((() {
                    if ('${widget.pembayaran}' == '1') {
                      return "777524687412";
                    }
                    return "111425046891";
                  })())
                ],
              ),
              SizedBox(
                height: 12,
              ),
              Divider(
                thickness: 1,
                color: Colors.grey[300],
              ),
              SizedBox(
                height: 10,
              ),
            ],
          ),
          SizedBox(
            height: 10.0,
          ),
          Container(
            width: double.infinity,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: MaterialButton(
                color: Color(0xff003c35),
                onPressed: () {
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => LoginPage()));
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 16.0),
                  child: Text("Home", style: TextStyle(color: Colors.white)),
                ),
              ),
            ),
          ),
          // SizedBox(
          //   height: 10.0,
          // ),
        ],
      )),
    );
  }
}
