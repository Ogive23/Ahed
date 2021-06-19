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
  Widget getAchievementCenterBody(Map<String, dynamic> data, context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('إنجازاتك', style: appTheme.themeData.primaryTextTheme.headline3),
        CustomSpacing(),
        Container(
          padding: EdgeInsets.symmetric(horizontal: w / 35),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                HomeScreenAchievementContainer(
                  w: w / 2 - w / 15,
                  count: helper.notNull(data['NumberOfNeediesUserHelped'])
                      ? double.parse(
                          data['NumberOfNeediesUserHelped'].toString())
                      : null,
                  countTextStyle: appTheme.nonStaticGetTextStyle(
                      1.0,
                      Colors.black,
                      appTheme.getTextTheme(context) * 1.5,
                      FontWeight.w200,
                      1.0,
                      TextDecoration.none,
                      'Delius'),
                  text: 'حالة قدرت تغير حياتهم للأحسن',
                  achievementTextStyle: appTheme.nonStaticGetTextStyle(
                      1.0,
                      Colors.grey[500],
                      appTheme.getSemiBodyTextTheme(context),
                      FontWeight.w200,
                      1.0,
                      TextDecoration.none,
                      'Delius'),
                ),
                SizedBox(
                  child: VerticalDivider(
                    color: Colors.black.withOpacity(0.5),
                  ),
                  height: h / 20,
                ),
                HomeScreenAchievementContainer(
                  w: w / 2 - w / 15,
                  count: helper.notNull(data['ValueOfDonation'])
                      ? double.parse(data['ValueOfDonation'].toString())
                      : null,
                  precision: 2,
                  suffix: 'جنيه',
                  countTextStyle: appTheme.nonStaticGetTextStyle(
                      1.0,
                      Colors.black,
                      appTheme.getTextTheme(context) * 1.5,
                      FontWeight.w200,
                      1.0,
                      TextDecoration.none,
                      'Delius'),
                  text: 'هي حجم مساعدتك لينا',
                  achievementTextStyle: appTheme.nonStaticGetTextStyle(
                      1.0,
                      Colors.grey[500],
                      appTheme.getSemiBodyTextTheme(context),
                      FontWeight.w200,
                      1.0,
                      TextDecoration.none,
                      'Delius'),
                ),
              ],
            ),
          ),
        ),
        CustomSpacing(),
        CustomSpacing(),
        Text('إنجازتنا', style: appTheme.themeData.primaryTextTheme.headline3),
        CustomSpacing(),
        Container(
          padding: EdgeInsets.only(right: w / 35),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                HomeScreenAchievementContainer(
                  w: w / 3,
                  count: double.parse(data['NeediesSatisfied'].toString()),
                  countTextStyle: appTheme.nonStaticGetTextStyle(
                      1.0,
                      Colors.green,
                      appTheme.getTextTheme(context) * 2,
                      FontWeight.w200,
                      1.0,
                      TextDecoration.none,
                      'Delius'),
                  text: 'حالة قدرنا نخلصهم بتبرعاتكم',
                  achievementTextStyle: appTheme.nonStaticGetTextStyle(
                      1.0,
                      Colors.green,
                      appTheme.getSemiBodyTextTheme(context),
                      FontWeight.w200,
                      1.0,
                      TextDecoration.none,
                      'Delius'),
                ),
                SizedBox(
                  child: VerticalDivider(
                    color: Colors.black.withOpacity(0.5),
                  ),
                  height: h / 20,
                ),
                HomeScreenAchievementContainer(
                  w: w / 3,
                  count:
                      double.parse(data['NeediesFoundTheirNewHome'].toString()),
                  countTextStyle: appTheme.nonStaticGetTextStyle(
                      1.0,
                      Colors.green,
                      appTheme.getTextTheme(context) * 2,
                      FontWeight.w200,
                      1.0,
                      TextDecoration.none,
                      'Delius'),
                  text: 'حالة لقينا لهم مسكن مناسب',
                  achievementTextStyle: appTheme.nonStaticGetTextStyle(
                      1.0,
                      Colors.green,
                      appTheme.getSemiBodyTextTheme(context),
                      FontWeight.w200,
                      1.0,
                      TextDecoration.none,
                      'Delius'),
                ),
                SizedBox(
                  child: VerticalDivider(
                    color: Colors.black.withOpacity(0.5),
                  ),
                  height: h / 20,
                ),
                HomeScreenAchievementContainer(
                  w: w / 3,
                  count: double.parse(
                      data['NeediesUpgradedTheirStandardOfLiving'].toString()),
                  countTextStyle: appTheme.nonStaticGetTextStyle(
                      1.0,
                      Colors.green,
                      appTheme.getTextTheme(context) * 2,
                      FontWeight.w200,
                      1.0,
                      TextDecoration.none,
                      'Delius'),
                  text: 'حالة تم تحسيين أوضاع معيشتهم',
                  achievementTextStyle: appTheme.nonStaticGetTextStyle(
                      1.0,
                      Colors.green,
                      appTheme.getSemiBodyTextTheme(context),
                      FontWeight.w200,
                      1.0,
                      TextDecoration.none,
                      'Delius'),
                ),
                SizedBox(
                  child: VerticalDivider(
                    color: Colors.black.withOpacity(0.5),
                  ),
                  height: h / 20,
                ),
                HomeScreenAchievementContainer(
                  w: w / 3,
                  count: double.parse(
                      data['NeediesHelpedToPrepareForPride'].toString()),
                  countTextStyle: appTheme.nonStaticGetTextStyle(
                      1.0,
                      Colors.green,
                      appTheme.getTextTheme(context) * 2,
                      FontWeight.w200,
                      1.0,
                      TextDecoration.none,
                      'Delius'),
                  text: 'ساعدناهم يكملوا فرحتهم',
                  achievementTextStyle: appTheme.nonStaticGetTextStyle(
                      1.0,
                      Colors.green,
                      appTheme.getSemiBodyTextTheme(context),
                      FontWeight.w200,
                      1.0,
                      TextDecoration.none,
                      'Delius'),
                ),
                SizedBox(
                  child: VerticalDivider(
                    color: Colors.black.withOpacity(0.5),
                  ),
                  height: h / 20,
                ),
                HomeScreenAchievementContainer(
                  w: w / 3,
                  count:
                      double.parse(data['NeediesHelpedToPayDept'].toString()),
                  countTextStyle: appTheme.nonStaticGetTextStyle(
                      1.0,
                      Colors.green,
                      appTheme.getTextTheme(context) * 2,
                      FontWeight.w200,
                      1.0,
                      TextDecoration.none,
                      'Delius'),
                  text: 'ساعدناهم يسددوا ديونهم',
                  achievementTextStyle: appTheme.nonStaticGetTextStyle(
                      1.0,
                      Colors.green,
                      appTheme.getSemiBodyTextTheme(context),
                      FontWeight.w200,
                      1.0,
                      TextDecoration.none,
                      'Delius'),
                ),
                SizedBox(
                  child: VerticalDivider(
                    color: Colors.black.withOpacity(0.5),
                  ),
                  height: h / 20,
                ),
                HomeScreenAchievementContainer(
                  w: w / 3,
                  count: double.parse(data['NeediesHelpedToCure'].toString()),
                  countTextStyle: appTheme.nonStaticGetTextStyle(
                      1.0,
                      Colors.green,
                      appTheme.getTextTheme(context) * 2,
                      FontWeight.w200,
                      1.0,
                      TextDecoration.none,
                      'Delius'),
                  text: 'ساعدناهم يلاقوا العلاج المناسب',
                  achievementTextStyle: appTheme.nonStaticGetTextStyle(
                      1.0,
                      Colors.green,
                      appTheme.getSemiBodyTextTheme(context),
                      FontWeight.w200,
                      1.0,
                      TextDecoration.none,
                      'Delius'),
                ),
              ],
            ),
          ),
        ),
        CustomSpacing(),
        HomeScreenAchievementContainer(
          w: w,
          count: double.parse(data['NeediesNotSatisfied'].toString()),
          countTextStyle: appTheme.nonStaticGetTextStyle(
              1.0,
              Colors.red,
              appTheme.getSemiBodyTextTheme(context),
              FontWeight.w200,
              1.0,
              TextDecoration.none,
              'Delius'),
          prefix: 'و لسه في ',
          suffix: ' حالات مستنين مساعدتك',
          text: '',
          achievementTextStyle: appTheme.nonStaticGetTextStyle(
              1.0,
              Colors.red,
              appTheme.getSemiBodyTextTheme(context),
              FontWeight.w200,
              1.0,
              TextDecoration.none,
              'Delius'),
        ),
      ],
    );
  }

  Widget getAchievementCenter(context) {
    return FutureBuilder<Map<String, dynamic>>(
      future: getAchievements(),
      builder:
          (BuildContext context, AsyncSnapshot<Map<String, dynamic>> snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            snapshot.data != null) {
          print(snapshot.data);
          return getAchievementCenterBody(snapshot.data, context);
        } else if (snapshot.connectionState == ConnectionState.done &&
            snapshot.data == null) {
          return Container(
            alignment: Alignment.center,
            child: Text(
                'حدث خطأ أثناء تحميل الإنجازات برجاء المحاولة مرة أخري.'),
          );
        } else if (snapshot.error != null) {
          return Container(
            alignment: Alignment.center,
            child: Text(
                'حدث خطأ أثناء تحميل الإنجازات برجاء المحاولة مرة أخري.'),
          );
        } else {
          return Container(
              alignment: Alignment.center,
              child: CustomLoadingText(text: 'جاري تحميل الإنجازات'));
        }
      },
    );
  }

  Future<Map<String, dynamic>> getAchievements() async {
    UserApiCaller userApiCaller = new UserApiCaller();
    Map<String, dynamic> status = await userApiCaller.getAchievements(
        sessionManager.user != null ? sessionManager.user.id : null);
    if (status['Err_Flag']) return null;
    print('here');
    return status['Values'];
  }
}
