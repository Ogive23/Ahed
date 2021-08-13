import 'package:flutter/material.dart';

class CustomSpacing extends StatelessWidget {
  final double value;
  CustomSpacing({required this.value});
  @override
  Widget build(BuildContext context) {
    return SizedBox(height: MediaQuery.of(context).size.height/value);
  }
}
