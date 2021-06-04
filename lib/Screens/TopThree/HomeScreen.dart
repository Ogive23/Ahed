import 'dart:ui';
import 'package:ahed/Custom%20Widgets/CustomHomeOption.dart';
import 'package:ahed/Custom%20Widgets/CustomSpacing.dart';
import 'package:ahed/Session/session_manager.dart';
import 'package:ahed/Shared%20Data/app_language.dart';
import 'package:ahed/Shared%20Data/app_theme.dart';
import 'package:ahed/Shared%20Data/common_data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../GeneralInfo.dart';

extension on TimeOfDay {
  bool operator >(TimeOfDay timeOfDay) {
    return this.hour > timeOfDay.hour ||
        this.hour == timeOfDay.hour && this.minute > timeOfDay.minute;
  }

  bool operator <(TimeOfDay timeOfDay) {
    return this.hour < timeOfDay.hour ||
        this.hour == timeOfDay.hour && this.minute < timeOfDay.minute;
  }

  bool operator >=(TimeOfDay timeOfDay) {
    return this.hour > timeOfDay.hour ||
        this.hour == timeOfDay.hour && this.minute > timeOfDay.minute ||
        this.hour == timeOfDay.hour && this.minute == timeOfDay.minute;
  }

  bool operator <=(TimeOfDay timeOfDay) {
    return this.hour < timeOfDay.hour ||
        this.hour == timeOfDay.hour && this.minute < timeOfDay.minute ||
        this.hour == timeOfDay.hour && this.minute == timeOfDay.minute;
  }

  bool equals(TimeOfDay timeOfDay) {
    return this.hour == timeOfDay.hour && this.minute == timeOfDay.minute;
  }
}

String getGreetingText() {
  //12 AM -> 11 AM
  //11 AM -> 5 PM
  //5 PM -> 12 AM
  print(TimeOfDay(hour: 0, minute: 0) > TimeOfDay(hour: 11, minute: 0) &&
      TimeOfDay(hour: 1, minute: 0) <= TimeOfDay(hour: 17, minute: 0));
  if (TimeOfDay.now() > TimeOfDay(hour: 0, minute: 0) &&
      TimeOfDay.now() <= TimeOfDay(hour: 11, minute: 0)) {
    return 'Good Morning🌅';
  }
  if (TimeOfDay.now() > TimeOfDay(hour: 11, minute: 0) &&
      TimeOfDay.now() <= TimeOfDay(hour: 17, minute: 0)) {
    return 'Good Afternoon☀';
  }
  if (TimeOfDay.now() > TimeOfDay(hour: 17, minute: 0) &&
      TimeOfDay.now() <= TimeOfDay(hour: 24, minute: 0)) {
    return 'Good Evening🌙';
  }
  return 'Hello';
}

class HomeScreen extends StatelessWidget {
  SessionManager sessionManager = new SessionManager();
  double w, h;
  CommonData commonData;
  AppLanguage appLanguage;
  AppTheme appTheme;
  final homeOptions = [
    {
      'title': 'Cases',
      'image': 'assets/images/2018_12_05_4268-Edit.jpg',
      'page': Pages.NeediesScreen.index
    },
    {
      'title': 'My Donations',
      'image': 'assets/images/donations.jpg',
      'page': Pages.MyDonationScreen.index
    },
    {
      'title': 'Settings',
      'image': 'assets/images/101610144-.jpg',
      'page': Pages.SettingsScreen.index
    },
    {
      'title': '',
      'image':
          'assets/images/depositphotos_79100916-stock-photo-stay-in-touch.jpg',
      'page': Pages.StayInTouchScreen.index
    },
  ];

  @override
  Widget build(BuildContext context) {
    commonData = Provider.of<CommonData>(context);
    appTheme = Provider.of<AppTheme>(context);
    w = MediaQuery.of(context).size.width;
    h = MediaQuery.of(context).size.height;
    return Scaffold(
        backgroundColor: Color.fromRGBO(246, 246, 252, 1.0),
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Color.fromRGBO(246, 246, 252, 1.0),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${pageTitles[commonData.step]}',
                style: appTheme.nonStaticGetTextStyle(
                    1.0,
                    Color.fromRGBO(41, 187, 137, 1.0),
                    appTheme.getTextTheme(context),
                    FontWeight.bold,
                    2.0,
                    TextDecoration.none,
                    'OpenSans'),
              ),
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: w / 100),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white, width: 3),
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: Offset(0, 1), // changes position of shadow
                        ),
                      ],
                    ),
                    child: CircleAvatar(
                      radius: 20,
                      backgroundColor: Colors.transparent,
                      child: ClipOval(
                        child: Image.network(
                          sessionManager.user.image,
                          fit: BoxFit.fill,
                          width: 120,
                          height: 120,
                        ),
                      ),
                    ),
                  ))
            ],
          ),
          leading: commonData.step != Pages.HomeScreen.index
              ? IconButton(
                  icon: Icon(Icons.arrow_back_ios_sharp),
                  onPressed: () => commonData.back(),
                  color: Colors.black,
                )
              : SizedBox(),
          leadingWidth: commonData.step == Pages.HomeScreen.index ? 0 : null,
        ),
        body: Container(
            height: h,
            // decoration: BoxDecoration(
            //   gradient: LinearGradient(
            //       colors: [
            //         Color.fromRGBO(41, 187, 137, 1.0),
            //         Color.fromRGBO(40, 150, 114, 1.0),
            //         Color.fromRGBO(30, 111, 92, 1.0),
            //       ]
            //   ),
            //   boxShadow: [
            //     BoxShadow(
            //       color: appTheme.themeData.shadowColor,
            //       spreadRadius: 10,
            //       blurRadius: 70,
            //       offset: Offset(0, 3),
            //     )
            //   ],
            // ),
            child: Container(
              width: w,
              // decoration: BoxDecoration(color: Color.fromRGBO(246, 246, 252, 1.0)),
              child: SingleChildScrollView(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                          CustomSpacing(),
                          Center(
                            child: Text(
                              '${getGreetingText()}, Mahmoued.',
                              style: appTheme.nonStaticGetTextStyle(
                                  1.0,
                                  Color.fromRGBO(41, 187, 137, 1.0),
                                  appTheme.getTextTheme(context),
                                  FontWeight.w200,
                                  1.0,
                                  TextDecoration.none,
                                  'OpenSans'),
                            ),
                          ),
                          CustomSpacing(),
                        ] +
                        [
                          GridView.count(
                              crossAxisCount: 2,
                              shrinkWrap: true,
                              padding: EdgeInsets.zero,
                              children: homeOptions
                                  .map((homeOption) =>
                                      CustomHomeOption(homeOption: homeOption))
                                  .toList()),
                        ]
                    // NeediesScreen()
                    ),
              ),
            )));
  }
}
