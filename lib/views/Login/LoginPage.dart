import 'dart:convert';
import 'package:do_zakat/views/Login/RegisterPage.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:do_zakat/Home.dart';
import 'package:do_zakat/models/api.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

enum LoginStatus { notSignIn, signIn }

class _LoginPageState extends State<LoginPage> {
  LoginStatus _loginStatus = LoginStatus.notSignIn;
  var email, password;
  final _key = new GlobalKey<FormState>();
  final _keyLogin = new GlobalKey<FormState>();
  bool _secureText = true;

  showHide() {
    setState(() {
      _secureText = !_secureText;
    });
  }

  var _autoValidate = false;

  check() {
    final form = _key.currentState;

    login();
    if (form.validate()) {
    } else {
      _autoValidate = true;
    }
  }

  dialogLogin(String txt) {
    showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            child: Form(
              key: _keyLogin,
              child: ListView(
                padding: EdgeInsets.all(20),
                shrinkWrap: true,
                children: <Widget>[
                  Text(
                    txt,
                    style:
                        TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 18.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          "OK",
                          style: TextStyle(
                              fontSize: 18.0, fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          );
        });
  }

  login() async {
    try {
      print(email);
      print(password);
      final response = await http.post(Uri.parse(BaseURL.apiLogin),
          body: {"email": email, "password": password});
      final data = jsonDecode(response.body);
      int code = data['code'];
      String pesan = data['message'];

      String usernameApi, namaApi, emailApi;
      int useridApi, userLevel;

      data['data'].forEach((api) {
        usernameApi = api['username'];
        namaApi = api['nama'];
        emailApi = api['email'];
        useridApi = api['userid'];
        userLevel = api['level'];
      });

      if (code == 200 || code == 201) {
        setState(() {
          _loginStatus = LoginStatus.signIn;
          savePref(code, usernameApi, namaApi, emailApi, useridApi, userLevel);
          print(pesan);
        });
      } else {
        print(pesan);
      }
    } catch (e) {
      dialogLogin("Username atau Password Salah!");
      print(e);
    }
  }

  savePref(int code, String usernameApi, String namaApi, String emailApi,
      int useridApi, int userLevel) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      preferences.setInt("code", code);
      preferences.setString("username", usernameApi);
      preferences.setString("nama", namaApi);
      preferences.setString("email", emailApi);
      preferences.setInt("userid", useridApi);
      preferences.setInt("level", userLevel);
      preferences.commit();
    });
  }

  var code, level;

  getPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      code = preferences.getInt("code");
      level = preferences.getInt("level");

      if (code == 200) {
        _loginStatus = LoginStatus.signIn;
      } else {
        _loginStatus = LoginStatus.notSignIn;
      }
    });
  }

  signOut() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      code = preferences.setInt("code", 0);
      level = preferences.setInt("level", 0);
      preferences.commit();
      _loginStatus = LoginStatus.notSignIn;
    });
  }

  @override
  void initState() {
    super.initState();
    getPref();
  }

  @override
  Widget build(BuildContext context) {
    switch (_loginStatus) {
      case LoginStatus.notSignIn:
        return Scaffold(
          body: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: <Color>[
                  Color(0xff003f37),
                  Color(0xff002924),
                ])),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.all(24),
                    child: Text(
                      "Assalamualaikum",
                      style: TextStyle(
                          color: Color(0xffebbb7e),
                          fontSize: 45,
                          fontFamily: 'Ramadhan'),
                    ),
                  ),
                  Container(
                    child: Form(
                      // autovalidate: _autoValidate,
                      key: _key,
                      child: Padding(
                        padding: const EdgeInsets.all(24.0),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 30.0,
                            ),
                            TextFormField(
                              style: TextStyle(color: Color(0xffebbb7e)),
                              validator: (e) {
                                if (e.isEmpty) {
                                  return "Silahkan isi Email";
                                } else {
                                  return null;
                                }
                              },
                              onSaved: (e) => email = e,
                              decoration: InputDecoration(
                                icon: Icon(
                                  Icons.mail,
                                  color: Color(0xffebbb7e),
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                  borderSide: BorderSide.none,
                                ),
                                filled: true,
                                fillColor: Colors.grey.withOpacity(0.1),
                                hintText: "Email",
                                hintStyle: TextStyle(color: Colors.black54),
                              ),
                            ),
                            SizedBox(
                              height: 20.0,
                            ),
                            TextFormField(
                              obscureText: _secureText,
                              style: TextStyle(color: Color(0xffebbb7e)),
                              validator: (e) {
                                if (e.isEmpty) {
                                  return "Silahkan isi password";
                                } else {
                                  return null;
                                }
                              },
                              onSaved: (e) => password = e,
                              decoration: InputDecoration(
                                suffixIcon: IconButton(
                                  icon: Icon(
                                      _secureText
                                          ? Icons.visibility_off
                                          : Icons.visibility,
                                      color: Colors.black54),
                                  onPressed: showHide,
                                ),
                                icon: Icon(
                                  Icons.vpn_key,
                                  color: Color(0xffebbb7e),
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                  borderSide: BorderSide.none,
                                ),
                                filled: true,
                                fillColor: Colors.grey.withOpacity(0.1),
                                hintText: "Password",
                                hintStyle: TextStyle(
                                  color: Colors.black54,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 30.0,
                            ),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Container(
                                width: double.infinity,
                                child: RaisedButton(
                                  onPressed: () {
                                    if (_key.currentState.validate()) {
                                      _key.currentState.save();
                                      check();
                                    } else {
                                      _autoValidate = true;
                                    }
                                  },
                                  color: Color(0xffebbb7e),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 16.0),
                                    child: Text(
                                      "Login",
                                      style: TextStyle(
                                        color: Color(0xff003c35),
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16.0,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 16.0),
                                  child: RichText(
                                    text: TextSpan(
                                      children: <TextSpan>[
                                        TextSpan(
                                            text: 'Belum punya akun? ',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 15)),
                                        TextSpan(
                                          text: ' Daftar',
                                          style: TextStyle(
                                              color: Color(0xffebbb7e),
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold),
                                          recognizer: new TapGestureRecognizer()
                                            ..onTap = () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          new Register()));
                                            },
                                        ),
                                      ],
                                    ),
                                  )),
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
        break;
      case LoginStatus.signIn:
        return Home(signOut);
        break;
    }
  }
}
