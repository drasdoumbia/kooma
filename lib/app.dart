import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kooma/models/auth/email_auth_model.dart';
import 'package:kooma/screens/chat.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:your_splash/your_splash.dart';

import 'models/auth/email_auth_model.dart';
import 'screens/onBoarding.dart';
import 'screens/signin.dart';

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  final _auth = FirebaseAuth.instance;
  bool isSeen;
  User loggedInUser;

  void getFirstSeen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    isSeen = prefs.getBool('isSeen');

    if (isSeen == null) {
      isSeen = false;
    }

    print("isSeen $isSeen");
  }

  @override
  void initState() {
    super.initState();

    loggedInUser = _auth.currentUser;

    print("app: $loggedInUser");

    getFirstSeen();
  }

  @override
  Widget build(BuildContext context) {
    return SplashScreen.timed(
      seconds: 4,
      route: MaterialPageRoute(
        builder: (_) => (isSeen && loggedInUser != null)
            ? Chat()
            : (isSeen && loggedInUser == null)
                ? SignIn()
                : OnBoarding(),
      ),
      body: Scaffold(
        body: Container(
          color: Color(0xFFFAD271),
          child: Center(
            child: Container(
              width: 200.0,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  alignment: Alignment.center,
                  image:
                      const AssetImage("assets/imgs/splash_screen_content.png"),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
