import 'package:ahed/Shared%20Data/app_language.dart';
import 'package:ahed/Shared%20Data/app_theme.dart';
import 'package:ahed/Shared%20Data/common_data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Session/session_manager.dart';

class SettingsScreen extends StatelessWidget {
  final SessionManager sessionManager = new SessionManager();
  static CommonData commonData;
  static AppTheme appTheme;
  static AppLanguage appLanguage;
  @override
  Widget build(BuildContext context) {
    commonData = Provider.of<CommonData>(context);
    appTheme = Provider.of<AppTheme>(context);
    appLanguage = Provider.of<AppLanguage>(context);
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(
            vertical: MediaQuery.of(context).size.height / 50),
        decoration: BoxDecoration(color: appTheme.themeData.primaryColor),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
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
                              Text(appLanguage.words['SettingsDarkMode'],
                                  style: appTheme
                                      .themeData.primaryTextTheme.subtitle1),
                              Switch(
                                value: appTheme.isDark,
                                activeColor:
                                    appTheme.themeData.toggleableActiveColor,
                                onChanged: (value) {
                                  sessionManager.createPreferredTheme(value);
                                  appTheme.changeTheme(value);
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
                              Text(appLanguage.words['SettingsLanguage'],
                                  style: appTheme
                                      .themeData.primaryTextTheme.subtitle1),
                              DropdownButton(
                                  items: [
                                    DropdownMenuItem(
                                      child: Text(
                                        'العربية',
                                        style: appTheme.themeData
                                            .primaryTextTheme.bodyText2,
                                      ),
                                      value: 'Ar',
                                    ),
                                    DropdownMenuItem(
                                      child: Text(
                                        'En',
                                        style: appTheme.themeData
                                            .primaryTextTheme.bodyText2,
                                      ),
                                      value: 'En',
                                    )
                                  ],
                                  value: appLanguage.language,
                                  dropdownColor: Colors.amber,
                                  icon: Icon(Icons.language),
                                  // style: appTheme.themeData.textTheme.body1,
                                  onChanged: (value) {
                                    sessionManager
                                        .createPreferredLanguage(value);
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
                                color: appTheme.themeData.iconTheme.color,
                              ),
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AboutDialog(
                                      applicationName: 'BreedMe',
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
                      )
                    ],
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
