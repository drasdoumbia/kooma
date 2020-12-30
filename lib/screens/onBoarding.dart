import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../config/colors.dart';
import '../config/custom_icons.dart';
import '../widgets/buttons/primary_button.dart';

class OnBoarding extends StatelessWidget {
  const OnBoarding();

  void firstSeen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isSeen', true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: const Text("Kooma",
            style:
                TextStyle(fontSize: 16.0, color: ConstantColors.grayDarkColor)),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(CustomIcons.logo,
                color: ConstantColors.secondaryColor, size: 70.0),
            SizedBox(height: 60.0),
            Image.asset("assets/imgs/onBoarding_illustration.png"),
            SizedBox(height: 40.0),
            Center(
              child: Text("Welcome!",
                  style: Theme.of(context).textTheme.headline1),
            ),
            SizedBox(height: 10.0),
            Center(
              child: Text(
                  "Join people you love and interact with \n them in a very friendly way.",
                  style: Theme.of(context).textTheme.bodyText1),
            ),
            SizedBox(height: 80.0),
            PrimaryButton(
              color: ConstantColors.secondaryColor,
              btnText: "Sign me up",
              onPress: () {
                firstSeen();
                Navigator.pushNamed(context, 'signup');
              },
            ),
          ],
        ),
      ),
    );
  }
}
