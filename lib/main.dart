import 'package:flutter/material.dart';
import 'package:your_splash/your_splash.dart';

void main() {
  runApp(Kooma());
}

class Kooma extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kooma',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: SplashScreen.timed(
        seconds: 4,
        route: MaterialPageRoute(builder: (_) => Home()),
        body: Scaffold(
          body: Container(
            color: Color(0xFFFAD271),
            child: Center(
              child: Container(
                width: 200.0,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    alignment: Alignment.center,
                    image: AssetImage("assets/imgs/splash_screen_content.png"),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class Home extends StatelessWidget {
  const Home({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
            child: Text(
          "Hello in kooma",
          style: TextStyle(
            fontSize: 18.0,
            fontFamily: "Roboto",
          ),
        )),
      ),
    );
  }
}
