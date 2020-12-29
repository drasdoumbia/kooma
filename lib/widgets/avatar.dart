import 'package:flutter/material.dart';
import 'package:kooma/config/colors.dart';

class Avatar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40.0,
      height: 40.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(20.0),
        ),
        border: Border.all(
            color: ConstantColors.primaryColor,
            width: 1.0,
            style: BorderStyle.solid),
      ),
      child: Image.asset(
        "assets/imgs/avatar.png",
        fit: BoxFit.cover,
      ),
    );
  }
}
