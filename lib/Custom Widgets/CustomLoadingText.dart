import 'package:ahed/Shared%20Data/app_theme.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomLoadingText extends StatelessWidget {
  final String text;
  static AppTheme appTheme;
  CustomLoadingText({@required this.text});
  @override
  Widget build(BuildContext context) {
    appTheme = Provider.of<AppTheme>(context);
    return ColorizeAnimatedTextKit(
        text: [
          text,
        ],
        textStyle: appTheme.nonStaticGetTextStyle(
            1.0,
            Colors.blueAccent,
            appTheme.getTextTheme(context),
            FontWeight.normal,
            1.0,
            TextDecoration.underline,
            'Delius'),
        colors: [
          Colors.purple,
          Colors.blue,
          Colors.yellow,
          Colors.red,
        ],
        textAlign: TextAlign.start,
        alignment: AlignmentDirectional.topStart // or Alignment.topLeft
        );
  }
}