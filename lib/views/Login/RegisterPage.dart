import 'package:do_zakat/models/api.dart';
import 'package:do_zakat/views/Login/LoginPage.dart';
import 'package:do_zakat/views/Login/SuksesRegis.dart';
import 'package:flutter/gestures.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  String username, nama, email, password;
  final _registKey = new GlobalKey<FormState>();

  check() {
    final form = _registKey.currentState;
    if (form.validate()) {
      form.save();
      simpanAkun();
    }
  }

  bool _secureText = true;

  showHide() {
    setState(() {
      _secureText = !_secureText;
    });
  }

  simpanAkun() async {
    try {
      var uri = Uri.parse(BaseURL.apiRegister);
      var request = http.MultipartRequest("POST", uri);
      request.fields['username'] = username;
      request.fields['email'] = email;
      request.fields['password'] = password;
      request.fields['nama'] = nama;
      var response = await request.send();
      if (this.mounted) {
        setState(() {
          Navigator.pop(context);
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => new SuksesRegis()));
        });
      }
    } catch (e) {
      debugPrint(e);
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
                  "Pendaftaran",
                  style: TextStyle(
                      color: Color(0xffebbb7e),
                      fontSize: 45,
                      fontFamily: 'Ramadhan'),
                ),
              ),
              Container(
                child: Form(
                  key: _registKey,
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 10.0,
                        ),
                        TextFormField(
                          style: TextStyle(color: Color(0xffebbb7e)),
                          validator: (e) {
                            if (e.isEmpty) {
                              return "Silahkan isi Username";
                            } else {
                              return null;
                            }
                          },
                          onSaved: (e) => username = e,
                          decoration: InputDecoration(
                            icon: Icon(
                              Icons.person,
                              color: Color(0xffebbb7e),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                              borderSide: BorderSide.none,
                            ),
                            filled: true,
                            fillColor: Colors.grey.withOpacity(0.1),
                            hintText: "Username",
                            hintStyle: TextStyle(color: Colors.black54),
                          ),
                        ),
                        SizedBox(
                          height: 15.0,
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
                          height: 15.0,
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
                          height: 15.0,
                        ),
                        TextFormField(
                          style: TextStyle(color: Color(0xffebbb7e)),
                          validator: (e) {
                            if (e.isEmpty) {
                              return "Silahkan isi Nama";
                            } else {
                              return null;
                            }
                          },
                          onSaved: (e) => nama = e,
                          decoration: InputDecoration(
                            icon: Icon(
                              Icons.badge,
                              color: Color(0xffebbb7e),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                              borderSide: BorderSide.none,
                            ),
                            filled: true,
                            fillColor: Colors.grey.withOpacity(0.1),
                            hintText: "Nama Lengkap",
                            hintStyle: TextStyle(color: Colors.black54),
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
                                check();
                              },
                              color: Color(0xffebbb7e),
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 16.0),
                                child: Text(
                                  "Daftar",
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
                              padding:
                                  const EdgeInsets.symmetric(vertical: 16.0),
                              child: RichText(
                                text: TextSpan(
                                  children: <TextSpan>[
                                    TextSpan(
                                        text: 'Sudah punya akun? ',
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 15)),
                                    TextSpan(
                                      text: ' Login',
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
                                                      new LoginPage()));
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
  }
}
