import 'package:flutter/material.dart';
import 'package:kooma/screens/signin.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:your_splash/your_splash.dart';

import 'screens/onBoarding.dart';

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  bool isSeen;

  void getFirstSeen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    isSeen = prefs.getBool('isSeen');

    if (isSeen == null) {
      isSeen = false;
    }

    print("isSeen $isSeen");
  }

  void initFirebase() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
  }

  @override
  void initState() {
    super.initState();

    initFirebase();
    getFirstSeen();
  }

  @override
  Widget build(BuildContext context) {
    return SplashScreen.timed(
      seconds: 4,
      route:
          MaterialPageRoute(builder: (_) => isSeen ? SignIn() : OnBoarding()),
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
