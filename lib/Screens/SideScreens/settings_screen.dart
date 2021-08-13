import 'package:ahed/Custom%20Widgets/CustomSpacing.dart';
import 'package:ahed/Shared%20Data/app_language.dart';
import 'package:ahed/Shared%20Data/app_theme.dart';
import 'package:ahed/Shared%20Data/common_data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../GeneralInfo.dart';
import '../../Session/session_manager.dart';

class SettingsScreen extends StatelessWidget {
  static late double w, h;
  final SessionManager sessionManager = new SessionManager();
  static late CommonData commonData;
  static late  AppTheme appTheme;
  static late  AppLanguage appLanguage;
  @override
  Widget build(BuildContext context) {
    commonData = Provider.of<CommonData>(context);
    appTheme = Provider.of<AppTheme>(context);
    appLanguage = Provider.of<AppLanguage>(context);
    w = MediaQuery.of(context).size.width;
    h = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        title: Padding(
          padding: EdgeInsets.only(top: h / 20),
          child: Text(
            'الإعدادات',
            style: appTheme.nonStaticGetTextStyle(
                1.0,
                Colors.black,
                appTheme.getTextTheme(context) * 1.5,
                FontWeight.w600,
                1.0,
                TextDecoration.none,
                'Delius'),
          ),
        ),
      ),
      body: Container(
        height: double.infinity,
        decoration: BoxDecoration(color: Colors.white),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CustomSpacing(value: 33,),
            Directionality(
                textDirection: appLanguage.textDirection,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width / 10,
                      ),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(appLanguage.words['SettingsDarkMode']!,
                                style: appTheme
                                    .themeData.primaryTextTheme.subtitle1),
                            Switch(
                              value: appTheme.isDark,
                              activeColor:
                                  appTheme.themeData.toggleableActiveColor,
                              onChanged: (value) {
                                sessionManager.createPreferredTheme(value);
                                appTheme.changeTheme(value, context);
                              },
                            ),
                          ]),
                    ),
                    Divider(),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width / 10,
                      ),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(appLanguage.words['SettingsLanguage']!,
                                style: appTheme
                                    .themeData.primaryTextTheme.subtitle1),
                            DropdownButton(
                                items: [
                                  DropdownMenuItem(
                                    child: Text(
                                      'العربية',
                                      style: appTheme
                                          .themeData.primaryTextTheme.bodyText2,
                                    ),
                                    value: 'Ar',
                                  ),
                                  DropdownMenuItem(
                                    child: Text(
                                      'En',
                                      style: appTheme
                                          .themeData.primaryTextTheme.bodyText2,
                                    ),
                                    value: 'En',
                                  )
                                ],
                                value: appLanguage.language,
                                dropdownColor: Colors.grey,
                                icon: Icon(Icons.language),
                                // style: appTheme.themeData.textTheme.body1,
                                onChanged: (String? value) {
                                  sessionManager.createPreferredLanguage(value!);
                                  appLanguage.changeLanguage(value);
                                }),
                          ]),
                    ),
                    Divider(),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width / 10,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //ToDo: Add Word to App Language for arabic support
                        children: [
                          Text('Legal Info',
                              style: appTheme
                                  .themeData.primaryTextTheme.subtitle1),
                          IconButton(
                            icon: Icon(
                              Icons.info,
                              color: Colors.grey,
                            ),
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return AboutDialog(
                                    applicationName: 'Ahed',
                                    applicationVersion: '1.0.0',
                                    children: <Widget>[
                                      Text(
                                          'Animations rights reserved to Lottie'),
                                      Text(
                                          'Fonts rights reserved to Google Fonts'),
                                      Text('OGIVE ©${DateTime.now().year}')
                                    ],
                                  );
                                },
                              );
                            },
                            tooltip: 'License',
                          ),
                        ],
                      ),
                    ),
                    Divider(),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width / 10,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //ToDo: Add Word to App Language for arabic support
                        children: [
                          Text('مجتمعنا',
                              style: appTheme
                                  .themeData.primaryTextTheme.subtitle1),
                          IconButton(
                            icon: Icon(
                              Icons.people,
                              color: Colors.grey,
                            ),
                            onPressed: () => commonData
                                .changeStep(Pages.StayInTouchScreen.index),
                            tooltip: 'License',
                          ),
                        ],
                      ),
                    ),
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
