import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'app.dart';
import 'config/colors.dart';
import 'models/auth/email_auth_model.dart';
import 'routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(Kooma());
}

class Kooma extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => EmailAuthModel(),
      child: Consumer<EmailAuthModel>(
        builder: (context, provider, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
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
                  bodyText1: TextStyle(
                      fontSize: 14.0, color: ConstantColors.grayDarkColor)),
            ),
            home: App(),
          );
        },
      ),
    );
  }
}
