import 'package:flutter/material.dart';

import 'screens/home.dart';
import 'screens/signup.dart';
import 'screens/signin.dart';
import 'screens/chat.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (context) => Home());
      case 'signup':
        return MaterialPageRoute(builder: (context) => SignUp());
      case 'signin':
        return MaterialPageRoute(builder: (context) => SignIn());
      case 'chat':
        return MaterialPageRoute(builder: (context) => Chat());
      default:
        return MaterialPageRoute(builder: (context) => Home());
    }
  }
}
