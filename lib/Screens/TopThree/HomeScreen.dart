import 'dart:ui';
import 'package:ahed/ApiCallers/UserApiCaller.dart';
import 'package:ahed/Custom%20Widgets/CustomLoading.dart';
import 'package:ahed/Custom%20Widgets/CustomLoadingText.dart';
import 'package:ahed/Custom%20Widgets/CustomSpacing.dart';
import 'package:ahed/Custom%20Widgets/HomeScreenAchievementContainer.dart';
import 'package:ahed/Helpers/Helper.dart';
import 'package:ahed/Screens/NeediesScreens/NeediesScreen.dart';
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
    return 'صباح الخير🌅';
  }
  if (TimeOfDay.now() > TimeOfDay(hour: 11, minute: 0) &&
      TimeOfDay.now() <= TimeOfDay(hour: 17, minute: 0)) {
    return 'نتمنالك يوم سعيد☀';
  }
  if (TimeOfDay.now() > TimeOfDay(hour: 17, minute: 0) &&
      TimeOfDay.now() <= TimeOfDay(hour: 24, minute: 0)) {
    return 'مساء الخير🌙';
  }
  return 'Hello';
}

class HomeScreen extends StatelessWidget {
  SessionManager sessionManager = new SessionManager();
  double w, h;
  CommonData commonData;
  AppLanguage appLanguage;
  AppTheme appTheme;
  Helper helper = new Helper();

  @override
  Widget build(BuildContext context) {
    // print('profileImage : ${sessionManager.user.profileImage}');
    commonData = Provider.of<CommonData>(context);
    appTheme = Provider.of<AppTheme>(context);
    w = MediaQuery.of(context).size.width;
    h = MediaQuery.of(context).size.height;
    return Scaffold(
        backgroundColor: appTheme.themeData.primaryColor,
        appBar: AppBar(
          elevation: 0.0,
          leadingWidth: 0.0,
          backgroundColor: appTheme.themeData.primaryColor,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('عهد', style: appTheme.themeData.primaryTextTheme.headline1),
              sessionManager.isLoggedIn()
                  ? GestureDetector(
                      onTap: () =>
                          commonData.changeStep(Pages.ProfileScreen.index),
                      child: Padding(
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
                                  offset: Offset(
                                      0, 1), // changes position of shadow
                                ),
                              ],
                            ),
                            child: PopupMenuButton(
                              child: CircleAvatar(
                                radius: h / 40,
                                backgroundColor: Colors.transparent,
                                child: ClipOval(
                                  child:
                                      sessionManager.user.profileImage != 'N/A'
                                          ? Image.network(
                                              sessionManager.user.profileImage,
                                              fit: BoxFit.contain,
                                              width: w / 5,
                                              height: h / 10,
                                            )
                                          : Image.asset(
                                              'assets/images/user.png',
                                              fit: BoxFit.cover,
                                              width: w / 5,
                                              height: h / 10,
                                            ),
                                ),
                              ),
                              onSelected: (value) {
                                if (value == 'Profile')
                                  return commonData
                                      .changeStep(Pages.ProfileScreen.index);
                                else if (value == 'Logout') {
                                  sessionManager.logout();
                                  Navigator.popUntil(context, (route) => false);
                                  Navigator.pushNamed(context, "MainScreen");
                                  return;
                                }
                              },
                              itemBuilder: (context) {
                                return [
                                  PopupMenuItem(
                                    child: Text(
                                      'الملف الشخصي',
                                      style: appTheme
                                          .themeData.primaryTextTheme.headline4,
                                    ),
                                    value: 'Profile',
                                  ),
                                  PopupMenuItem(
                                    child: Text(
                                      'تسجيل الخروج',
                                      style: appTheme
                                          .themeData.primaryTextTheme.headline4,
                                    ),
                                    value: 'Logout',
                                  ),
                                ];
                              },
                            ),
                          )),
                    )
                  : GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, "LoginScreen");
                      },
                      child: Text(
                        'تسجيل الدخول',
                        style: appTheme.nonStaticGetTextStyle(
                            1.0,
                            Colors.blue,
                            appTheme.getSemiBodyTextTheme(context),
                            FontWeight.w400,
                            1.0,
                            TextDecoration.none,
                            'Delius'),
                      ),
                    )
            ],
          ),
        ),
        body: Container(
          child: Column(
            children: [
              Center(
                child: Text('${getGreetingText()}',
                    style: appTheme.themeData.primaryTextTheme.headline3),
              ),
              CustomSpacing(),
              Expanded(
                child: SingleChildScrollView(
                    // controller: scrollController,
                    child: Padding(
                  padding: EdgeInsets.only(right: w / 30),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        getAchievementCenter(context),
                        Visibility(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('الحالات المحفوظة',
                                  style: appTheme
                                      .themeData.primaryTextTheme.headline3),
                              NeediesScreen(
                                type: "Bookmarked",
                              ),
                            ],
                          ),
                          visible: sessionManager.hasAnyBookmarked(),
                        ),
                        Text('الحالات الحرجة',
                            style:
                                appTheme.themeData.primaryTextTheme.headline3),
                        NeediesScreen(
                          type: "Urgent",
                        ),
                        Text('الحالات',
                            style:
                                appTheme.themeData.primaryTextTheme.headline3),
                        NeediesScreen(
                          type: "Not Urgent",
                        ),
                      ]),
                )),
              ),
            ],
          ),
        ));
  }

  String getCaseSupportMessage(int casesNumber) {
    if (casesNumber < 5) {
      return 'We are waiting more from you!';
    } else if (casesNumber < 20) {
      return 'You are really a human with big heart\nWe love you!';
    }
    return 'What kind of angels you are!';
  }

  Color getCaseSupportMessageColor(int casesNumber) {
    if (casesNumber < 5) {
      return Colors.blue[300];
    } else if (casesNumber < 20) {
      return Colors.green;
    }
    return Colors.orange;
  }

  Color getSupportCasesColor(int support) {
    if (support < 5) {
      return Colors.red[300];
    } else if (support < 20) {
      return Colors.amberAccent;
    }
    return Colors.green;
  }

  Color getSupportMoneyColor(double support) {
    if (support < 50) {
      return Colors.red[300];
    } else if (support < 200) {
      return Colors.amberAccent;
    }
    return Colors.green;
  }

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
