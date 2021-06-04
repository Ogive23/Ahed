import 'package:flutter/material.dart';

class CustomSpacing extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(height: MediaQuery.of(context).size.height/100);
  }
}
