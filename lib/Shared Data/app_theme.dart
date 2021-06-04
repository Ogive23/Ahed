import 'package:flutter/material.dart';

class AppTheme extends ChangeNotifier {
  bool isDark;
  ThemeData themeData;

  AppTheme(bool isDark) {
    this.isDark = isDark;
    themeData = isDark ? darkTheme : lightTheme;
  }
  getTextTheme(context) {
    return MediaQuery.of(context).size.height / 40;
  }

  getSemiBodyTextTheme(context) {
    return MediaQuery.of(context).size.height / 50;
  }

  getBodyTextTheme(context) {
    return MediaQuery.of(context).size.height / 60;
  }

  static getTextStyle(
      height, color, fontSize, fontWeight, spacing, decoration, family,
      [shadows]) {
    return TextStyle(
        height: height,
        color: color,
        fontSize: fontSize,
        fontWeight: fontWeight,
        letterSpacing: spacing,
        decoration: decoration,
        fontFamily: family,
        shadows: shadows);
  }

  nonStaticGetTextStyle(
      height, color, fontSize, fontWeight, spacing, decoration, family,
      [shadows]) {
    return getTextStyle(
        height, color, fontSize, fontWeight, spacing, decoration, family,shadows);
  }

  changeTheme(bool value) {
    themeData = value ? darkTheme : lightTheme;
    this.isDark = value;
    notifyListeners();
  }

  ThemeData lightTheme = ThemeData(
      primaryColor: Color.fromRGBO(255,255,255, 1.0),
      accentColor: Color.fromRGBO(240, 227, 202, 1.0),
      shadowColor: Colors.black.withOpacity(0.5),
      primaryTextTheme: TextTheme(
        headline1: getTextStyle(1.0, Color.fromRGBO(247, 178, 29, 1.0), 18.0,
            FontWeight.bold, 1.0, TextDecoration.none, "OpenSans"),
        headline2: getTextStyle(1.0, Colors.grey.withOpacity(0.5), 12.0,
            FontWeight.bold, 1.0, TextDecoration.none, "OpenSans"),
        bodyText1: getTextStyle(1.0, Color.fromRGBO(247, 178, 29, 1.0), 16.0,
            FontWeight.normal, 1.0, TextDecoration.none, "OpenSans"),
        bodyText2: getTextStyle(1.0, Colors.white, 16.0, FontWeight.normal, 1.0,
            TextDecoration.none, "OpenSans"),
        subtitle1: getTextStyle(1.0, Color.fromRGBO(147, 148, 165, 1.0), 16.0,
            FontWeight.w300, 1.0, TextDecoration.none, "OpenSans"),
        subtitle2: getTextStyle(1.0, Colors.grey.withOpacity(0.5), 14.0,
            FontWeight.w300, 1.0, TextDecoration.none, "OpenSans"),
      ),
      appBarTheme: AppBarTheme(
        elevation: 0.0,
        backgroundColor: Color.fromRGBO(247, 148, 29, 1.0),
        titleTextStyle: getTextStyle(1.0, Color.fromRGBO(255,255,255, 1.0),
            20.0, FontWeight.normal, 1.0, TextDecoration.none, "OpenSans"),
      ),
      iconTheme: IconThemeData(
        color: Colors.white,
      ),
      toggleableActiveColor: Colors.green,
      toggleButtonsTheme: ToggleButtonsThemeData(
          disabledColor: Colors.grey[400], selectedColor: Colors.amber),
      buttonColor: Colors.white);

  ThemeData darkTheme = ThemeData(
      primaryColor: Color.fromRGBO(25, 36, 40, 1.0),
      accentColor: Color.fromRGBO(45, 56, 60, 1.0),
      shadowColor: Colors.white.withOpacity(0.5),
      primaryTextTheme: TextTheme(
        headline1: getTextStyle(1.0, Color.fromRGBO(247, 148, 29, 1.0), 18.0,
            FontWeight.bold, 1.0, TextDecoration.none, "OpenSans"),
        headline2: getTextStyle(1.0, Colors.grey.withOpacity(0.5), 12.0,
            FontWeight.bold, 1.0, TextDecoration.none, "OpenSans"),
        bodyText1: getTextStyle(1.0, Color.fromRGBO(247, 148, 29, 1.0), 16.0,
            FontWeight.normal, 1.0, TextDecoration.none, "OpenSans"),
        bodyText2: getTextStyle(1.0, Colors.white, 16.0, FontWeight.normal, 1.0,
            TextDecoration.none, "OpenSans"),
        subtitle1: getTextStyle(1.0, Color.fromRGBO(247, 178, 29, 1.0), 16.0,
            FontWeight.w300, 1.0, TextDecoration.none, "OpenSans"),
        subtitle2: getTextStyle(1.0, Colors.grey.withOpacity(0.5), 14.0,
            FontWeight.w300, 1.0, TextDecoration.none, "OpenSans"),
      ),
      appBarTheme: AppBarTheme(
        elevation: 0.0,
        backgroundColor: Color.fromRGBO(65, 76, 80, 1.0),
        titleTextStyle: getTextStyle(1.0, Color.fromRGBO(247, 178, 29, 1.0),
            20.0, FontWeight.normal, 1.0, TextDecoration.none, "OpenSans"),
      ),
      iconTheme: IconThemeData(
        color: Colors.white,
      ),
      toggleableActiveColor: Colors.green,
      toggleButtonsTheme: ToggleButtonsThemeData(
          disabledColor: Colors.grey, selectedColor: Colors.amber),
      buttonColor: Colors.white);
}
