import 'package:ahed/Session/session_manager.dart';
import 'package:ahed/Shared%20Data/app_language.dart';
import 'package:ahed/Shared%20Data/app_theme.dart';
import 'package:ahed/Shared%20Data/common_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mixpanel_flutter/mixpanel_flutter.dart';
import 'package:provider/provider.dart';

import '../../GeneralInfo.dart';

class BackgroundScreen extends StatefulWidget {
  @override
  _BackgroundScreenState createState() => _BackgroundScreenState();
}

class _BackgroundScreenState extends State<BackgroundScreen> {
  static late double w, h;
  static late CommonData commonData;
  static late AppLanguage appLanguage;
  static late AppTheme appTheme;
  static late TabController tabController;
  final Mixpanel mixpanel = Mixpanel('bea05d9f9bc6df748045a3bfce6c0e6b');

  Future<bool> _onWillPop(context) async {
    return commonData.lastStep()
        ? (await showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('هل أت متأكد؟'),
              content: const Text('هل  تريد إغلاق التطبيق'),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: const Text('لا'),
                ),
                TextButton(
                  onPressed: () => Navigator.of(context).pop(true),
                  child: const Text('نعم'),
                ),
              ],
            ),
          ))
        : commonData.back();
  }
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    commonData = Provider.of<CommonData>(context);
    appTheme = Provider.of<AppTheme>(context);
    appLanguage = Provider.of<AppLanguage>(context);
    w = MediaQuery.of(context).size.width;
    h = MediaQuery.of(context).size.height;
    print(commonData.step);
    return WillPopScope(
      onWillPop: () => _onWillPop(context),
      child: Scaffold(
        body: pageOptions[commonData.step],
        bottomNavigationBar: Theme(
          data: Theme.of(context).copyWith(
            canvasColor: Colors.white,
          ),
          child: commonData.step > Pages.SettingsScreen.index
              ? const SizedBox()
              : BottomNavigationBar(
                  backgroundColor: appTheme.themeData.primaryColor,
                  selectedItemColor:
                      appTheme.themeData.toggleButtonsTheme.selectedColor,
                  unselectedItemColor:
                      appTheme.themeData.toggleButtonsTheme.disabledColor,
                  onTap: (value) => commonData.changeStep(value),
                  currentIndex: commonData.step,
                  elevation: 0.0,
                  items: [
                    const BottomNavigationBarItem(
                        icon: Icon(
                          Icons.attach_money,
                        ),
                        label: 'تبرعاتي'),
                    const BottomNavigationBarItem(
                        icon: Icon(Icons.home), label: 'الرئيسية'),
                    const BottomNavigationBarItem(
                      icon: Icon(Icons.settings),
                      label: 'الإعدادات',
                    ),
                  ],
                  unselectedLabelStyle:
                      appTheme.themeData.primaryTextTheme.titleMedium,
                  selectedLabelStyle:
                      appTheme.themeData.primaryTextTheme.headlineMedium,
                ),
        ),
      ),
    );
  }
}
