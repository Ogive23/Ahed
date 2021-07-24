import 'package:ahed/Shared%20Data/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreenAchievementContainer extends StatelessWidget {
  static late AppTheme appTheme;
  final double w;
  final double? count;
  final String text;
  final TextStyle countTextStyle;
  TextStyle achievementTextStyle;
  int? precision;
  String? suffix;
  String? prefix;
  HomeScreenAchievementContainer(
      {required this.w,
      this.count,
      required this.text,
      required this.countTextStyle,
      required this.achievementTextStyle,
      this.precision,
      this.suffix,
      this.prefix});
  @override
  Widget build(BuildContext context) {
    appTheme = Provider.of<AppTheme>(context);
    print(suffix);
    // print(count!.toStringAsFixed(
    //     precision != null ? precision! : 1));
    return SizedBox(
      width: w,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          this.count != null
              ? Row(
                  children: [
                    Text(
                      prefix ?? '',
                      style: countTextStyle,
                    ),
                    Flexible(
                      child: Text(
                        count!.toStringAsFixed(
                            precision != null ? precision! : 0),
                        style: countTextStyle,
                      ),
                    ),
                    Text(
                      suffix ?? '',
                      style: countTextStyle,
                    ),
                  ],
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
