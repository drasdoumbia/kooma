import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kooma/auth_widget_builder.dart';
import 'package:kooma/providers/auth_provider.dart';
import 'package:kooma/screens/chat.dart';
import 'package:kooma/services/firebase_database.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:your_splash/your_splash.dart';

import 'models/auth/email_auth_model.dart';
import 'models/user_model.dart';
import 'screens/onBoarding.dart';
import 'screens/signin.dart';

class App extends StatefulWidget {
  final FirebaseDatabase Function(BuildContext context, String uid)
      databaseBuilder;

  const App({@required this.databaseBuilder});

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  User loggedInUser = FirebaseAuth.instance.currentUser;
  bool isSeen;

  void getFirstSeen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    isSeen = prefs.getBool('isSeen');

    if (isSeen == null) {
      isSeen = false;
    }
  }

  @override
  void initState() {
    super.initState();

    getFirstSeen();
  }

  @override
  Widget build(BuildContext context) {
    return AuthWidgetBuilder(
      databaseBuilder: widget.databaseBuilder,
      builder: (BuildContext context, AsyncSnapshot<UserModel> userSnapshot) {
        return Consumer<AuthProvider>(builder: (_, authProviderRef, __) {
          if (userSnapshot.connectionState == ConnectionState.active) {
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
                          image: const AssetImage(
                              "assets/imgs/splash_screen_content.png"),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          }
          return Material(
            child: CircularProgressIndicator(),
          );
        });
      },
    );
  }
}
