import 'package:flutter/material.dart';

import 'screens/home.dart';
import 'screens/signup.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (context) => Home());
      case 'signup':
        return MaterialPageRoute(builder: (context) => SignUp());
    }
  }
}
