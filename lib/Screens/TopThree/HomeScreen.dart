import 'dart:ui';
import 'package:ahed/ApiCallers/UserApiCaller.dart';
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
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
  static late double w, h;
  static late CommonData commonData;
  static late AppLanguage appLanguage;
  static late AppTheme appTheme;
  final Helper helper = new Helper();

  Future<Map<String, dynamic>?> getAchievements() async {
    UserApiCaller userApiCaller = new UserApiCaller();
    Map<String, dynamic> status =
        await userApiCaller.getAchievements(sessionManager.user?.id);
    if (status['Err_Flag']) return null;
    return status['Values'];
  }

  Widget getAchievementCenterBody(Map<String, dynamic> data, context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('إنجازاتك', style: appTheme.themeData.primaryTextTheme.headline3),
        CustomSpacing(
          value: 100,
        ),
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
                  countTextStyle: appTheme.themeData.primaryTextTheme.headline5!
                      .apply(fontSizeFactor: 1.5),
                  text: 'حالات قدرت تغير حياتهم للأحسن',
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
                  countTextStyle: appTheme.themeData.primaryTextTheme.headline5!
                      .apply(fontSizeFactor: 1.5),
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
        CustomSpacing(
          value: 50,
        ),
        Text('إنجازتنا', style: appTheme.themeData.primaryTextTheme.headline3),
        CustomSpacing(
          value: 100,
        ),
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
        CustomSpacing(
          value: 100,
        ),
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
    return FutureBuilder<Map<String, dynamic>?>(
      future: getAchievements(),
      builder: (BuildContext context,
          AsyncSnapshot<Map<String, dynamic>?> snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            snapshot.data != null) {
          return getAchievementCenterBody(snapshot.data!, context);
        } else if (snapshot.connectionState == ConnectionState.done &&
            snapshot.data == null) {
          return Container(
            alignment: Alignment.center,
            child:
                Text('حدث خطأ أثناء تحميل الإنجازات برجاء المحاولة مرة أخري.'),
          );
        } else if (snapshot.error != null) {
          return Container(
            alignment: Alignment.center,
            child:
                Text('حدث خطأ أثناء تحميل الإنجازات برجاء المحاولة مرة أخري.'),
          );
        } else {
          return Container(
              alignment: Alignment.center,
              child: CustomLoadingText(text: 'جاري تحميل الإنجازات'));
        }
      },
    );
  }

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
                                  child: sessionManager.user!.profileImage !=
                                          'N/A'
                                      ? Image.network(
                                          sessionManager.user!.profileImage!,
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
        floatingActionButtonLocation: FloatingActionButtonLocation.startDocked,
        floatingActionButton: Padding(
          padding: EdgeInsets.only(bottom: h / 50),
          child: FloatingActionButton(
            onPressed: sessionManager.isLoggedIn()
                ? () {
                    commonData.changeStep(Pages.NeedyCreationScreen.index);
                  }
                : null,
            backgroundColor:
                sessionManager.isLoggedIn() ? Colors.green : Colors.grey,
            child: Icon(FontAwesomeIcons.handsHelping),
          ),
        ),
        body: Container(
          child: Column(
            children: [
              Center(
                child: Text('${getGreetingText()}',
                    style: appTheme.themeData.primaryTextTheme.headline3),
              ),
              CustomSpacing(
                value: 100,
              ),
              Expanded(
                child: SingleChildScrollView(
                    // controller: scrollController,
                    child: Padding(
                  padding: EdgeInsets.only(right: w / 30),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        getAchievementCenter(context),
                        //ToDo: Future V2
                        // Visibility(
                        //   child: Column(
                        //     crossAxisAlignment: CrossAxisAlignment.start,
                        //     children: [
                        //       Text('الحالات المحفوظة',
                        //           style: appTheme
                        //               .themeData.primaryTextTheme.headline3),
                        //       NeediesScreen(
                        //         type: "Bookmarked",
                        //       ),
                        //     ],
                        //   ),
                        //   visible: sessionManager.hasAnyBookmarked(),
                        // ),

                        NeediesScreen(
                          type: "Urgent",
                        ),

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
}
