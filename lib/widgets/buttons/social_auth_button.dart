import 'package:flutter/material.dart';
import 'package:kooma/config/colors.dart';

class SocialAuthButton extends StatelessWidget {
  final Function onPress;
  final String btnText;
  final Image socialIcon;

  const SocialAuthButton({this.btnText, this.onPress, this.socialIcon});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        width: 318.0,
        decoration: BoxDecoration(
          border: Border.all(
              color: ConstantColors.grayColor,
              width: 1.0,
              style: BorderStyle.solid),
          borderRadius: BorderRadius.all(
            Radius.circular(24.0),
          ),
        ),
        child: ListTile(
          leading: socialIcon,
          dense: true,
          title: Center(
            child: Text(
              btnText,
              style: TextStyle(fontSize: 16.0, color: ConstantColors.grayColor),
            ),
          ),
          trailing: Container(width: 30.0),
        ),
      ),
      onTap: onPress,
    );
  }
}
