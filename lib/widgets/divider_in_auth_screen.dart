import 'package:flutter/material.dart';

import '../config/colors.dart';

class DividerInAuthScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return IntrinsicWidth(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: width * 0.3,
            child: Divider(thickness: 1.0, color: ConstantColors.grayColor),
          ),
          SizedBox(width: 15.0),
          Text("OR"),
          SizedBox(width: 15.0),
          SizedBox(
            width: width * 0.3,
            child: Divider(thickness: 1.0, color: ConstantColors.grayColor),
          )
        ],
      ),
    );
  }
}
