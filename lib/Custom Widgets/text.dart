import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final sentence,
      color,
      fontSize,
      letterSpacing,
      fontWeight,
      textDecoration,
      textFamily;
  CustomText(
      {this.sentence,
      this.color,
      this.fontSize,
      this.letterSpacing,
      this.fontWeight,
      this.textDecoration,
      this.textFamily});
  @override
  Widget build(BuildContext context) {
    return Text(
      '$sentence',
      textAlign: TextAlign.center,
      style: TextStyle(
          color: color,
          fontSize: fontSize,
          letterSpacing: letterSpacing,
          fontWeight: fontWeight,
          decoration: textDecoration,
          fontFamily: textFamily),
    );
  }
}
