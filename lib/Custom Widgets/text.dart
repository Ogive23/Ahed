import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String sentence;
  final Color color;
  final double fontSize;
  final double letterSpacing;
  final FontWeight? fontWeight;
  final TextDecoration? textDecoration;
  final String textFamily;
  const CustomText(
      {super.key,
      required this.sentence,
      required this.color,
      required this.fontSize,
      required this.letterSpacing,
      this.fontWeight,
      this.textDecoration,
      required this.textFamily});
  @override
  Widget build(BuildContext context) {
    return Text(
      sentence,
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
