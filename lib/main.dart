import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/services.dart';
import 'package:do_zakat/views/Login/LoginPage.dart';
import 'package:page_transition/page_transition.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: Color(0xff003c35),
      statusBarBrightness: Brightness.light,
    ),
  );
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      primaryColor: Colors.blueGrey.shade700,
    ),
    home: AnimatedSplashScreen(
      splash: Image.asset("assets/icons/menglogo.png"),
      backgroundColor: Color(0xff003f37),
      nextScreen: LoginPage(),
      splashTransition: SplashTransition.fadeTransition,
      pageTransitionType: PageTransitionType.fade,
      duration: 3000,
      splashIconSize: 80,
    ),
  ));
}
