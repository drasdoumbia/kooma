import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../config/colors.dart';
import '../config/custom_icons.dart';
import '../models/auth/email_auth_model.dart';
import '../widgets/buttons/rounded_icon_button.dart';

class Profile extends StatelessWidget {
  const Profile();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon:
                  Icon(CustomIcons.long_left, color: ConstantColors.grayColor),
              onPressed: () {
                Navigator.pop(context);
              },
            );
          },
        ),
        title: Text(
          "Profile",
          style: TextStyle(fontSize: 16.0, color: ConstantColors.grayDarkColor),
        ),
        actions: [
          GestureDetector(
            child: Padding(
              padding:
                  const EdgeInsets.only(top: 8.0, right: 15.0, bottom: 8.0),
              child: Icon(CustomIcons.exit, color: ConstantColors.grayColor),
            ),
            onTap: () {
              Provider.of<EmailAuthModel>(context, listen: false).signOut();
              Navigator.pushNamed(context, "signin");
            },
          ),
        ],
      ),
      body: Column(
        // mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 100.0),
          Container(
            width: 64.0,
            height: 64.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(37.0),
              ),
              border: Border.all(
                  color: ConstantColors.grayColor,
                  width: 1.0,
                  style: BorderStyle.solid),
            ),
            child: Image.asset("assets/imgs/default_avatar.png"),
          ),
          SizedBox(width: double.infinity, height: 20.0),
          Text("Full Name"),
          SizedBox(height: 60.0),
          Container(
            padding: EdgeInsets.all(20.0),
            width: 324,
            height: 120,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Color(0x0a000000),
                  blurRadius: 1,
                  offset: Offset(0, 0),
                ),
                BoxShadow(
                  color: Color(0x0a000000),
                  blurRadius: 6,
                  offset: Offset(0, 2),
                ),
                BoxShadow(
                  color: Color(0x0f000000),
                  blurRadius: 24,
                  offset: Offset(0, 16),
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Icon(CustomIcons.phone, color: ConstantColors.grayColor),
                    SizedBox(width: 15.0),
                    Text(
                      "Add phone number",
                      style: Theme.of(context).textTheme.bodyText1,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
                SizedBox(height: 15.0),
                Row(
                  children: [
                    Icon(CustomIcons.mail, color: ConstantColors.grayColor),
                    SizedBox(width: 15.0),
                    Text("brooklyn@gmail.com"),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 60.0),
          RoundedIconButton(
            icon: CustomIcons.edit,
            btnText: "Edit Profile",
            onPress: () {
              Navigator.pushNamed(context, "editProfile");
            },
          ),
        ],
      ),
    );
  }
}
