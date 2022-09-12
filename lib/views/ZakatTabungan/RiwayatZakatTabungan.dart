import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:do_zakat/LoadingPageOne.dart';
import 'package:do_zakat/models/RiwayatZakat.dart';
import 'package:do_zakat/models/api.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class RiwayatZakatTabungan extends StatefulWidget {
  @override
  _RiwayatZakatTabunganState createState() => _RiwayatZakatTabunganState();
}

class _RiwayatZakatTabunganState extends State<RiwayatZakatTabungan> {
  final money = NumberFormat("#,##0", "en_US");
  var loading = false;
  var nullData = false;
  var formated =
      new DateFormat("d MMMM yyyy").format(DateTime.parse("2021-01-01"));

  String idUsers;

  final list = new List<RiwayatZakat>();
  final GlobalKey<RefreshIndicatorState> _refresh =
      GlobalKey<RefreshIndicatorState>();

  getPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      idUsers = preferences.getInt("userid").toString();
    });
    _lihatData();
  }

  _formattgl(date) {
    return new DateFormat("d MMM yyyy").format(DateTime.parse(date));
  }

  Future<void> _lihatData() async {
    list.clear();
    setState(() {
      loading = true;
    });
    final responseData = await http.post(
        Uri.parse(BaseURL.apiListZakatTabungan + idUsers),
        body: {"userid": idUsers});
    final data = jsonDecode(responseData.body);

    Map<String, dynamic> resDataString = data;
    if (resDataString['code'] == 200) {
      if (resDataString['data'] == null) {
        nullData = true;
      } else {
        resDataString['data'].forEach((api) {
          final ab = new RiwayatZakat(
            api['userid'],
            api['jumlah'],
            api['tanggal'],
            api['nama_metode'],
          );
          list.add(ab);
        });
        nullData = false;
      }
      setState(() {
        loading = false;
      });
    } else {
      final ab = new RiwayatZakat(
        "null",
        "null",
        "null",
        "null",
      );
      list.add(ab);
      setState(() {
        loading = false;
      });
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
            ),
          ),
        ),
        title: GradientText(
          "Riwayat Zakat Tabungan",
          style: TextStyle(fontSize: 18.0),
          colors: [
            Color(0xffebbb7e),
            Color(0xffbf905f),
          ],
        ),
      ),
      body: RefreshIndicator(
        onRefresh: _lihatData,
        key: _refresh,
        child: loading
            ? Center(child: LoadingPageOne())
            : (nullData
                ? ListView(
                    children: <Widget>[
                      Center(
                        child: Text(
                          "\nBelum ada Data Transaksi\n",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 15.0,
                              fontWeight: FontWeight.normal),
                        ),
                      ),
                    ],
                  )
                : ListView.builder(
                    itemCount: list.length,
                    itemBuilder: (context, i) {
                      final resData = list[i];
                      return Container(
                        padding: EdgeInsets.only(
                          top: 12.0,
                          left: 12.0,
                          right: 12.0,
                        ),
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Tanggal',
                                      style: TextStyle(
                                        fontSize: 14,
                                      ),
                                    ),
                                    Text(
                                      _formattgl(resData.tanggal),
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Nominal Zakat',
                                      style: TextStyle(
                                        fontSize: 14,
                                      ),
                                    ),
                                    Text(
                                      (resData.jumlah),
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Metode Pembayaran',
                                      style: TextStyle(
                                        fontSize: 14,
                                      ),
                                    ),
                                    Text(
                                      (resData.namaMetode),
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  )),
      ),
    );
  }
}
