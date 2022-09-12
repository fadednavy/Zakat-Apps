import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class InfoApp extends StatefulWidget {
  @override
  _InfoAppState createState() => _InfoAppState();
}

class _InfoAppState extends State<InfoApp> {
  @override
  void initState() {
    super.initState();
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
        centerTitle: true,
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
          "About App",
          style: TextStyle(fontSize: 18.0),
          colors: [
            Color(0xffebbb7e),
            Color(0xffbf905f),
          ],
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xff003c35),
              Color(0xff002924)
            ]
          )
        ),
        padding: EdgeInsets.all(20),
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: GridView.count(
                crossAxisCount: 1,
                padding: EdgeInsets.all(10),
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                children: [
                  Container(
                    // color: Color(0xff01322d),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 100,
                          backgroundImage: AssetImage(
                            'assets/icons/rizal.png'
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          'Rizal Ramadhan',
                          style: TextStyle(
                            fontSize: 24.0,
                            fontWeight: FontWeight.bold,
                            color: Color(0xffebbb73)
                          ),
                        ),
                        Text(
                          'Power, Intelligence, Love',
                          style: TextStyle(
                            fontSize: 16.0,
                            fontStyle: FontStyle.italic,
                            color: Color(0xffebbb73)
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    // color: Color(0xff01322d),
                    child: Column(
                      children: [
                        CircleAvatar(
                          radius: 100,
                          backgroundImage: AssetImage(
                            'assets/icons/dido.png',
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          'Didho Hajuandi',
                          style: TextStyle(
                            color: Color(0xffebbb73),
                            fontWeight: FontWeight.bold,
                            fontSize: 24.0,
                          ),
                        ),
                        Text(
                          'Keep Spirit',
                          style: TextStyle(
                            color: Color(0xffebbb73),
                            fontStyle: FontStyle.italic,
                            fontSize: 16.0
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
