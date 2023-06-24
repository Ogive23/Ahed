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
    return hour > timeOfDay.hour ||
        hour == timeOfDay.hour && minute > timeOfDay.minute;
  }

  bool operator <(TimeOfDay timeOfDay) {
    return hour < timeOfDay.hour ||
        hour == timeOfDay.hour && minute < timeOfDay.minute;
  }

  bool operator >=(TimeOfDay timeOfDay) {
    return hour > timeOfDay.hour ||
        hour == timeOfDay.hour && minute > timeOfDay.minute ||
        hour == timeOfDay.hour && minute == timeOfDay.minute;
  }

  bool operator <=(TimeOfDay timeOfDay) {
    return hour < timeOfDay.hour ||
        hour == timeOfDay.hour && minute < timeOfDay.minute ||
        hour == timeOfDay.hour && minute == timeOfDay.minute;
  }

  bool equals(TimeOfDay timeOfDay) {
    return hour == timeOfDay.hour && minute == timeOfDay.minute;
  }
}

String getGreetingText() {
  //12 AM -> 11 AM
  //11 AM -> 5 PM
  //5 PM -> 12 AM
  print(const TimeOfDay(hour: 0, minute: 0) > const TimeOfDay(hour: 11, minute: 0) &&
      const TimeOfDay(hour: 1, minute: 0) <= const TimeOfDay(hour: 17, minute: 0));
  if (TimeOfDay.now() > const TimeOfDay(hour: 0, minute: 0) &&
      TimeOfDay.now() <= const TimeOfDay(hour: 11, minute: 0)) {
    return 'صباح الخير🌅';
  }
  if (TimeOfDay.now() > const TimeOfDay(hour: 11, minute: 0) &&
      TimeOfDay.now() <= const TimeOfDay(hour: 17, minute: 0)) {
    return 'نتمنالك يوم سعيد☀';
  }
  if (TimeOfDay.now() > const TimeOfDay(hour: 17, minute: 0) &&
      TimeOfDay.now() <= const TimeOfDay(hour: 24, minute: 0)) {
    return 'مساء الخير🌙';
  }
  return 'Hello';
}

class HomeScreen extends StatelessWidget {
  final SessionManager sessionManager = SessionManager();
  static late double w, h;
  static late CommonData commonData;
  static late AppLanguage appLanguage;
  static late AppTheme appTheme;
  final Helper helper = Helper();

  HomeScreen({super.key});

  Future<Map<String, dynamic>?> getAchievements() async {
    print('xD');
    UserApiCaller userApiCaller = UserApiCaller();
    print('xD');
    Map<String, dynamic> status =
        await userApiCaller.getAchievements(appLanguage.language!);
    if (status['Err_Flag']) return null;
    return status['Values'];
  }

  Widget getAchievementCenterBody(Map<String, dynamic> data, context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('إنجازاتك', style: appTheme.themeData.primaryTextTheme.displaySmall),
        const CustomSpacing(
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
                  countTextStyle: appTheme.themeData.primaryTextTheme.headlineSmall!
                      .apply(fontSizeFactor: 1.5),
                  text: 'حالات قدرت تغير حياتهم للأحسن',
                  achievementTextStyle: appTheme.nonStaticGetTextStyle(
                      1.0,
                      Colors.grey[500],
                      appTheme.mediumTextSize(context),
                      FontWeight.w200,
                      1.0,
                      TextDecoration.none,
                      'Delius'),
                ),
                SizedBox(
                  height: h / 20,
                  child: VerticalDivider(
                    color: Colors.black.withOpacity(0.5),
                  ),
                ),
                HomeScreenAchievementContainer(
                  w: w / 2 - w / 15,
                  count: helper.notNull(data['ValueOfDonation'])
                      ? double.parse(data['ValueOfDonation'].toString())
                      : null,
                  precision: 2,
                  suffix: 'جنيه',
                  countTextStyle: appTheme.themeData.primaryTextTheme.headlineSmall!
                      .apply(fontSizeFactor: 1.5),
                  text: 'هي حجم مساعدتك لينا',
                  achievementTextStyle: appTheme.nonStaticGetTextStyle(
                      1.0,
                      Colors.grey[500],
                      appTheme.mediumTextSize(context),
                      FontWeight.w200,
                      1.0,
                      TextDecoration.none,
                      'Delius'),
                ),
              ],
            ),
          ),
        ),
        const CustomSpacing(
          value: 50,
        ),
        Text('إنجازتنا', style: appTheme.themeData.primaryTextTheme.displaySmall),
        const CustomSpacing(
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
                      appTheme.largeTextSize(context) * 2,
                      FontWeight.w200,
                      1.0,
                      TextDecoration.none,
                      'Delius'),
                  text: 'حالة قدرنا نخلصهم بتبرعاتكم',
                  achievementTextStyle: appTheme.nonStaticGetTextStyle(
                      1.0,
                      Colors.green,
                      appTheme.mediumTextSize(context),
                      FontWeight.w200,
                      1.0,
                      TextDecoration.none,
                      'Delius'),
                ),
                SizedBox(
                  height: h / 20,
                  child: VerticalDivider(
                    color: Colors.black.withOpacity(0.5),
                  ),
                ),
                HomeScreenAchievementContainer(
                  w: w / 3,
                  count:
                      double.parse(data['NeediesHelpedWithFindingBetterPlaceforLiving'].toString()),
                  countTextStyle: appTheme.nonStaticGetTextStyle(
                      1.0,
                      Colors.green,
                      appTheme.largeTextSize(context) * 2,
                      FontWeight.w200,
                      1.0,
                      TextDecoration.none,
                      'Delius'),
                  text: 'حالة لقينا لهم مسكن مناسب',
                  achievementTextStyle: appTheme.nonStaticGetTextStyle(
                      1.0,
                      Colors.green,
                      appTheme.mediumTextSize(context),
                      FontWeight.w200,
                      1.0,
                      TextDecoration.none,
                      'Delius'),
                ),
                SizedBox(
                  height: h / 20,
                  child: VerticalDivider(
                    color: Colors.black.withOpacity(0.5),
                  ),
                ),
                HomeScreenAchievementContainer(
                  w: w / 3,
                  count: double.parse(
                      data['NeediesHelpedWithUpgradingStandardofLiving'].toString()),
                  countTextStyle: appTheme.nonStaticGetTextStyle(
                      1.0,
                      Colors.green,
                      appTheme.largeTextSize(context) * 2,
                      FontWeight.w200,
                      1.0,
                      TextDecoration.none,
                      'Delius'),
                  text: 'حالة تم تحسيين أوضاع معيشتهم',
                  achievementTextStyle: appTheme.nonStaticGetTextStyle(
                      1.0,
                      Colors.green,
                      appTheme.mediumTextSize(context),
                      FontWeight.w200,
                      1.0,
                      TextDecoration.none,
                      'Delius'),
                ),
                SizedBox(
                  height: h / 20,
                  child: VerticalDivider(
                    color: Colors.black.withOpacity(0.5),
                  ),
                ),
                HomeScreenAchievementContainer(
                  w: w / 3,
                  count: double.parse(
                      data['NeediesHelpedWithPreparingForJoy'].toString()),
                  countTextStyle: appTheme.nonStaticGetTextStyle(
                      1.0,
                      Colors.green,
                      appTheme.largeTextSize(context) * 2,
                      FontWeight.w200,
                      1.0,
                      TextDecoration.none,
                      'Delius'),
                  text: 'ساعدناهم يكملوا فرحتهم',
                  achievementTextStyle: appTheme.nonStaticGetTextStyle(
                      1.0,
                      Colors.green,
                      appTheme.mediumTextSize(context),
                      FontWeight.w200,
                      1.0,
                      TextDecoration.none,
                      'Delius'),
                ),
                SizedBox(
                  height: h / 20,
                  child: VerticalDivider(
                    color: Colors.black.withOpacity(0.5),
                  ),
                ),
                HomeScreenAchievementContainer(
                  w: w / 3,
                  count:
                      double.parse(data['NeediesHelpedWithDeptPaying'].toString()),
                  countTextStyle: appTheme.nonStaticGetTextStyle(
                      1.0,
                      Colors.green,
                      appTheme.largeTextSize(context) * 2,
                      FontWeight.w200,
                      1.0,
                      TextDecoration.none,
                      'Delius'),
                  text: 'ساعدناهم يسددوا ديونهم',
                  achievementTextStyle: appTheme.nonStaticGetTextStyle(
                      1.0,
                      Colors.green,
                      appTheme.mediumTextSize(context),
                      FontWeight.w200,
                      1.0,
                      TextDecoration.none,
                      'Delius'),
                ),
                SizedBox(
                  height: h / 20,
                  child: VerticalDivider(
                    color: Colors.black.withOpacity(0.5),
                  ),
                ),
                HomeScreenAchievementContainer(
                  w: w / 3,
                  count: double.parse(data['NeediesHelpedWithFindingaCure'].toString()),
                  countTextStyle: appTheme.nonStaticGetTextStyle(
                      1.0,
                      Colors.green,
                      appTheme.largeTextSize(context) * 2,
                      FontWeight.w200,
                      1.0,
                      TextDecoration.none,
                      'Delius'),
                  text: 'ساعدناهم يلاقوا العلاج المناسب',
                  achievementTextStyle: appTheme.nonStaticGetTextStyle(
                      1.0,
                      Colors.green,
                      appTheme.mediumTextSize(context),
                      FontWeight.w200,
                      1.0,
                      TextDecoration.none,
                      'Delius'),
                ),
              ],
            ),
          ),
        ),
        const CustomSpacing(
          value: 100,
        ),
        HomeScreenAchievementContainer(
          w: w,
          count: double.parse(data['NeediesNotSatisfied'].toString()),
          countTextStyle: appTheme.nonStaticGetTextStyle(
              1.0,
              Colors.red,
              appTheme.mediumTextSize(context),
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
              appTheme.mediumTextSize(context),
              FontWeight.w200,
              1.0,
              TextDecoration.none,
              'Delius'),
        ),
      ],
    );
  }

  Widget getAchievementCenter(context) {
    print('xD');
    return FutureBuilder<Map<String, dynamic>?>(
      future: getAchievements(),
      builder: (BuildContext context,
          AsyncSnapshot<Map<String, dynamic>?> snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            snapshot.data != null) {
          return getAchievementCenterBody(snapshot.data!, context);
        } else if (snapshot.connectionState == ConnectionState.done &&
            snapshot.data == null) {
          print(snapshot.error);
          return Container(
            alignment: Alignment.center,
            child:
                const Text('حدث خطأ أثناء تحميل الإنجازات برجاء المحاولة مرة أخري.'),
          );
        } else if (snapshot.error != null) {
          print(snapshot.error);
          return Container(
            alignment: Alignment.center,
            child:
                const Text('حدث خطأ أثناء تحميل الإنجازات برجاء المحاولة مرة أخري.'),
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
    appLanguage = Provider.of<AppLanguage>(context);
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
              Text('عهد', style: appTheme.themeData.primaryTextTheme.displayLarge),
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
                                  offset: const Offset(
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
                                          null
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
                                if (value == 'Profile') {
                                  commonData
                                      .changeStep(Pages.ProfileScreen.index);
                                  return;
                                } else if (value == 'Logout') {
                                  sessionManager.logout();
                                  Navigator.popUntil(context, (route) => false);
                                  Navigator.pushNamed(context, 'MainScreen');
                                  return;
                                }
                              },
                              itemBuilder: (context) {
                                return [
                                  PopupMenuItem(
                                    value: 'Profile',
                                    child: Text(
                                      'الملف الشخصي',
                                      style: appTheme
                                          .themeData.primaryTextTheme.headlineMedium,
                                    ),
                                  ),
                                  PopupMenuItem(
                                    value: 'Logout',
                                    child: Text(
                                      'تسجيل الخروج',
                                      style: appTheme
                                          .themeData.primaryTextTheme.headlineMedium,
                                    ),
                                  ),
                                ];
                              },
                            ),
                          )),
                    )
                  : GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, 'LoginScreen');
                      },
                      child: Text(
                        'تسجيل الدخول',
                        style: appTheme.nonStaticGetTextStyle(
                            1.0,
                            Colors.blue,
                            appTheme.mediumTextSize(context),
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
            child: const Icon(FontAwesomeIcons.handsHelping),
          ),
        ),
        body: Column(
          children: [
            Center(
              child: Text(getGreetingText(),
                  style: appTheme.themeData.primaryTextTheme.displaySmall),
            ),
            const CustomSpacing(
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
                        type: 'Urgent',
                      ),

                      NeediesScreen(
                        type: 'Not Urgent',
                      ),
                    ]),
              )),
            ),
          ],
        ));
  }
}
