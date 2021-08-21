import 'package:ahed/Shared%20Data/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomRowText extends StatelessWidget {
  final String firstText;
  final String secondText;
  late double w;
  late AppTheme appTheme;
  CustomRowText({required this.firstText, required this.secondText});

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
            style: appTheme.themeData.primaryTextTheme.bodyText1,
          ),
        ),
        SizedBox(
          width: w / 3 * 2,
          child: Text(
            secondText,
            textAlign: TextAlign.center,
            style: appTheme.themeData.primaryTextTheme.bodyText1,
          ),
        )
      ],
    );
  }
}
