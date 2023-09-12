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
  final SessionManager sessionManager = SessionManager();
  static late CommonData commonData;
  static late  AppTheme appTheme;
  static late  AppLanguage appLanguage;

  SettingsScreen({super.key});
  @override
  Widget build(BuildContext context) {
    commonData = Provider.of<CommonData>(context);
    appTheme = Provider.of<AppTheme>(context);
    appLanguage = Provider.of<AppLanguage>(context);
    w = MediaQuery.of(context).size.width;
    h = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: appTheme.themeData.primaryColor,
      appBar: AppBar(
        backgroundColor: appTheme.themeData.primaryColor,
        elevation: 0.0,
        title: Padding(
          padding: EdgeInsets.only(top: h / 20),
          child: Text(
            'الإعدادات',
            style: appTheme.themeData.primaryTextTheme.displayMedium,
          ),
        ),
      ),
      body: SizedBox(
        height: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const CustomSpacing(value: 33,),
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
                                    .themeData.primaryTextTheme.titleMedium),
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
                    const Divider(),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width / 10,
                      ),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(appLanguage.words['SettingsLanguage']!,
                                style: appTheme
                                    .themeData.primaryTextTheme.titleMedium),
                            DropdownButton(
                                items: [
                                  DropdownMenuItem(
                                    value: 'Ar',
                                    child: Text(
                                      'العربية',
                                      style: appTheme
                                          .themeData.primaryTextTheme.bodySmall,
                                    ),
                                  ),
                                  DropdownMenuItem(
                                    value: 'En',
                                    child: Text(
                                      'En',
                                      style: appTheme
                                          .themeData.primaryTextTheme.bodySmall,
                                    ),
                                  )
                                ],
                                value: appLanguage.language,
                                
                                dropdownColor: appTheme.themeData.highlightColor,
                                icon: const Icon(Icons.language),
                                // style: appTheme.themeData.textTheme.body1,
                                onChanged: (String? value) {
                                  sessionManager.createPreferredLanguage(value!);
                                  appLanguage.changeLanguage(value);
                                }),
                          ]),
                    ),
                    const Divider(),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width / 10,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //ToDo: Add Word to App Language for arabic support
                        children: [
                          Text(appLanguage.words['SettingsLegalInfo']!,
                              style: appTheme
                                  .themeData.primaryTextTheme.titleMedium),
                          IconButton(
                            icon: const Icon(
                              Icons.info,
                              color: Colors.grey,
                            ),
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return AboutDialog(
                                    applicationName: appLanguage.words['AppName']!,
                                    applicationVersion: '1.0.0',
                                    children: <Widget>[
                                      const Text(
                                          'Animations rights reserved to Lottie'),
                                      const Text(
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
                    const Divider(),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width / 10,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //ToDo: Add Word to App Language for arabic support
                        children: [
                          Text(appLanguage.words['SettingsSocialMedia']!,
                              style: appTheme
                                  .themeData.primaryTextTheme.titleMedium),
                          IconButton(
                            icon: const Icon(
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
