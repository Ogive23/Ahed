import 'package:ahed/Shared%20Data/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomRowText extends StatelessWidget {
  final String firstText;
  final String secondText;
  static late double w;
  static late AppTheme appTheme;
  const CustomRowText({super.key, required this.firstText, required this.secondText});

  @override
  Widget build(BuildContext context) {
    w = MediaQuery.of(context).size.width;
    appTheme = Provider.of<AppTheme>(context);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: w / 3,
          child: Text(
            firstText,
            textAlign: TextAlign.center,
            style: appTheme.themeData.primaryTextTheme.bodyLarge,
          ),
        ),
        SizedBox(
          width: w / 3 * 2,
          child: Text(
            secondText,
            textAlign: TextAlign.center,
            style: appTheme.themeData.primaryTextTheme.bodyLarge,
          ),
        )
      ],
    );
  }
}
