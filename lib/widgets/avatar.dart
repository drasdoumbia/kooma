import 'package:flutter/material.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

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

class SpinnerAvatar extends StatelessWidget {
  final Color borderColor;

  const SpinnerAvatar({this.borderColor});

  @override
  Widget build(BuildContext context) {
    return Shimmer(
      duration: Duration(seconds: 3), //Default value
      interval: Duration(seconds: 2), //Default value: Duration(seconds: 0)
      color: Colors.white, //Default value
      enabled: true, //Default value
      direction: ShimmerDirection.fromLTRB(),
      child: Container(
        width: 40.0,
        height: 40.0,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(20.0),
          ),
          border: Border.all(
              color: borderColor, width: 1.0, style: BorderStyle.solid),
        ),
      ),
    );
  }
}
