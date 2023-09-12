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
        Padding(
          padding: EdgeInsets.symmetric(horizontal: w/25),
          child: SizedBox(
            width: w / 3,
            child: Text(
              firstText,
              textAlign: TextAlign.right,
              style: appTheme.themeData.primaryTextTheme.bodyLarge!.apply(
                color: Colors.blueGrey[900]
              ),
            ),
          ),
        ),
        SizedBox(
          width: w / 3 * 2 - w/12.5,
          child: Text(
            secondText,
            textAlign: TextAlign.center,
            style: appTheme.themeData.primaryTextTheme.bodyLarge!.apply(
                color: Colors.blueGrey[900]
            ),
          ),
        )
      ],
    );
  }
}
