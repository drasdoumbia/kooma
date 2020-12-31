import 'package:flutter/material.dart';
import 'package:kooma/config/colors.dart';

class CustomFormField extends StatelessWidget {
  final String hint;
  final bool obscure;
  final dynamic inputType;
  final TextEditingController fieldController;
  final Function onChange;

  const CustomFormField(
      {this.hint,
      this.obscure = false,
      this.inputType,
      this.fieldController,
      this.onChange});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextField(
        controller: fieldController,
        obscureText: obscure,
        keyboardType: inputType,
        cursorColor: ConstantColors.grayColor,
        style: TextStyle(fontSize: 16.0, color: ConstantColors.grayColor),
        decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(18.0, 7.0, 18.0, 7.0),
          hintText: hint,
          hintStyle: TextStyle(fontSize: 16.0, color: ConstantColors.grayColor),
          fillColor: ConstantColors.grayColor,
          border: OutlineInputBorder(
              borderSide: BorderSide(color: ConstantColors.grayColor),
              borderRadius: BorderRadius.circular(10.0)),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: ConstantColors.grayColor),
            borderRadius: BorderRadius.circular(10.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: ConstantColors.grayColor),
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
        onChanged: onChange,
      ),
    );
  }
}
