import 'package:flutter/material.dart';

import '../config/colors.dart';
import '../config/custom_icons.dart';
import '../widgets/primary_button.dart';

class OnBoarding extends StatelessWidget {
  const OnBoarding();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text("Kooma",
            style: TextStyle(color: ConstantColors.grayDarkColor)),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(CustomIcons.logo,
              color: ConstantColors.secondaryColor, size: 70.0),
          SizedBox(height: 60.0),
          Image.asset("assets/imgs/onBoarding_illustration.png"),
          SizedBox(height: 40.0),
          Center(
            child:
                Text("Welcome!", style: Theme.of(context).textTheme.headline1),
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
              print("Do something");
            },
          ),
        ],
      ),
    );
  }
}
