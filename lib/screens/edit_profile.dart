import 'package:flutter/material.dart';

import '../config/colors.dart';
import '../config/custom_icons.dart';
import '../widgets/buttons/rounded_icon_button.dart';
import '../widgets/form_field.dart';

class EditProfile extends StatelessWidget {
  const EditProfile();

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
          "Edit Profile",
          style: TextStyle(fontSize: 16.0, color: ConstantColors.grayDarkColor),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 100.0),
            Container(
              width: 71,
              height: 64,
              child: Stack(
                children: [
                  Positioned.fill(
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Container(
                        width: 64,
                        height: 64,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Color(0xff40c4ff),
                            width: 1,
                          ),
                        ),
                        child: Image.asset(
                          "assets/imgs/avatar2.png",
                        ),
                      ),
                    ),
                  ),
                  Positioned.fill(
                    child: Align(
                      alignment: Alignment.bottomRight,
                      child: Container(
                        width: 20,
                        height: 20,
                        child: Stack(
                          children: [
                            GestureDetector(
                              child: Container(
                                width: 20,
                                height: 20,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: Color(0xff666666),
                                    width: 1,
                                  ),
                                  color: Colors.white,
                                ),
                                child: Icon(CustomIcons.edit,
                                    color: ConstantColors.grayColor,
                                    size: 12.0),
                              ),
                              onTap: () {
                                print("Do something");
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: double.infinity, height: 70.0),
            CustomFormField(
              inputType: TextInputType.text,
              hint: "Brooklyn Simmons",
              onChange: (value) {},
            ),
            SizedBox(height: 20.0),
            CustomFormField(
              inputType: TextInputType.phone,
              hint: "(702) 555-0122",
              onChange: (value) {},
            ),
            SizedBox(height: 20.0),
            CustomFormField(
              inputType: TextInputType.emailAddress,
              hint: "brooklyn@gmail.com",
              onChange: (value) {},
            ),
            SizedBox(height: 30.0),
            RoundedIconButton(
              icon: CustomIcons.check_big,
              btnText: "Save",
              onPress: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
