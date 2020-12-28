import 'package:flutter/material.dart';

import 'app.dart';
import 'config/colors.dart';
import 'routes.dart';

void main() async {
  runApp(Kooma());
}

class Kooma extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kooma',
      initialRoute: '/',
      onGenerateRoute: Routes.generateRoute,
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
      home: App(),
    );
  }
}
