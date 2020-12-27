import 'package:flutter/material.dart';
import 'package:kooma/config/colors.dart';

class PrimaryButton extends StatelessWidget {
  final Function onPress;
  final String btnText;
  final Color color;

  const PrimaryButton(
      {@required this.onPress,
      @required this.btnText,
      this.color = ConstantColors.primaryColor});

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      minWidth: 318.0,
      height: 48.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(24.0)),
      ),
      color: color,
      textColor: Colors.white,
      child: Text(
        btnText,
        style: TextStyle(fontSize: 16.0),
      ),
      onPressed: onPress,
    );
  }
}
