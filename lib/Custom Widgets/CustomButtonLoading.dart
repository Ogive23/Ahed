import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class CustomButtonLoading extends StatelessWidget {
  static late double h;

  const CustomButtonLoading({super.key});
  @override
  Widget build(BuildContext context) {
    h = MediaQuery.of(context).size.height;
    return Center(
      child: Container(
        child: Lottie.asset('assets/animations/63274-loading-animation.json',height: h/20),
      ),
    );
  }
}
