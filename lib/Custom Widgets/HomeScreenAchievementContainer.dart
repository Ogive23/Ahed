import 'package:ahed/Shared%20Data/app_theme.dart';
import 'package:countup/countup.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreenAchievementContainer extends StatelessWidget {
  static AppTheme appTheme;
  final double w;
  final double count;
  final String text;
  final TextStyle countTextStyle;
  final TextStyle achievementTextStyle;
  final int precision;
  final String suffix;
  final String prefix;
  HomeScreenAchievementContainer(
      {@required this.w,
      this.count,
      @required this.text,
      @required this.countTextStyle,
      @required this.achievementTextStyle,
      this.precision,
      this.suffix,
      this.prefix});
  @override
  Widget build(BuildContext context) {
    appTheme = Provider.of<AppTheme>(context);
    return SizedBox(
      width: w,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          this.count != null
              ? Countup(
                  begin: 0,
                  end: count,
                  suffix: suffix != null ? suffix : '',
                  prefix: prefix != null ? prefix : '',
                  precision: precision != null ? precision : 0,
                  duration: Duration(seconds: 1),
                  style: countTextStyle,
                )
              : Text(
                  '---',
                  style: appTheme.themeData.primaryTextTheme.subtitle1,
                ),
          Text(
            text,
            style: achievementTextStyle,
          ),
        ],
      ),
    );
  }
}
