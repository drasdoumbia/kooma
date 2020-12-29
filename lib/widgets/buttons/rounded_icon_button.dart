import 'package:flutter/material.dart';
import 'package:kooma/config/colors.dart';
import 'package:kooma/config/custom_icons.dart';

class RoundedIconButton extends StatelessWidget {
  final Function onPress;
  final String btnText;
  final Color color;

  const RoundedIconButton(
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
      child: SizedBox(
        width: 318.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(CustomIcons.edit, color: Colors.white, size: 17.0),
            SizedBox(width: 10.0),
            Text(
              btnText,
              style: TextStyle(fontSize: 16.0),
            ),
          ],
        ),
      ),
      onPressed: onPress,
    );
  }
}
