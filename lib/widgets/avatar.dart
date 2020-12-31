import 'package:flutter/material.dart';

class Avatar extends StatelessWidget {
  final Color borderColor;
  final String avatarImg;

  const Avatar({this.borderColor, this.avatarImg});

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
            color: borderColor, width: 1.0, style: BorderStyle.solid),
      ),
      child: CircleAvatar(
        backgroundImage: NetworkImage(
          avatarImg,
        ),
      ),
    );
  }
}
