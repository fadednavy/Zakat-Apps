import 'package:flutter/material.dart';

class SuksesRegis extends StatefulWidget {
  @override
  _SuksesRegisState createState() => _SuksesRegisState();
}

class _SuksesRegisState extends State<SuksesRegis> {
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
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset('assets/icons/regissukses.png'),
              SizedBox(
                height: 5,
              ),
              MaterialButton(
                color: Color(0xff01322d),
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  "Login Disini",
                  style: TextStyle(color: Color(0xffebbb7e)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
