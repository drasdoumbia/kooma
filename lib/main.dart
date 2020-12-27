import 'package:flutter/material.dart';
import 'package:kooma/config/colors.dart';
import 'package:your_splash/your_splash.dart';

import 'screens/onBoarding.dart';

void main() {
  runApp(Kooma());
}

class Kooma extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kooma',
      theme: ThemeData(
        fontFamily: "Roboto",
        primaryColor: ConstantColors.primaryColor,
        accentColor: ConstantColors.secondaryColor,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        textTheme: TextTheme(
            headline1: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
                color: ConstantColors.grayDarkColor),
            bodyText1:
                TextStyle(fontSize: 14.0, color: ConstantColors.grayDarkColor)),
      ),
      home: SplashScreen.timed(
        seconds: 4,
        route: MaterialPageRoute(builder: (_) => OnBoarding()),
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
