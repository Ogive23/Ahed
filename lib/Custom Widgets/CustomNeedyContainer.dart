import 'package:ahed/Models/Needy.dart';
import 'package:ahed/Session/session_manager.dart';
import 'package:ahed/Shared%20Data/app_theme.dart';
import 'package:ahed/Shared%20Data/common_data.dart';
import 'package:ahed/Shared%20Data/NeedyData.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:provider/provider.dart';
// import 'package:share_plus/share_plus.dart';
import '../GeneralInfo.dart';
import 'CustomSpacing.dart';
import 'ImageCarouselShow.dart';

class CustomNeedyContainer extends StatelessWidget {
  final Needy needy;

  static int currentIndex = 0;
  CustomNeedyContainer({super.key, required this.needy});
  static late AppTheme appTheme;
  static late CommonData commonData;
  static late NeedyData needyData;
  static late double w, h;
  final SessionManager sessionManager = SessionManager();
  @override
  Widget build(BuildContext context) {
    commonData = Provider.of<CommonData>(context);
    needyData = Provider.of<NeedyData>(context);
    appTheme = Provider.of<AppTheme>(context);
    w = MediaQuery.sizeOf(context).width;
    h = MediaQuery.sizeOf(context).height;
    return Container(
        height: double.infinity,
        margin: EdgeInsets.only(top: h / 50, bottom: h / 50),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            border: Border.all(
                color: const Color.fromRGBO(30, 111, 92, 1.0), width: 1),
            boxShadow: [
              BoxShadow(
                color: appTheme.themeData.shadowColor,
                spreadRadius: 1,
                blurRadius: 10,
                offset: const Offset(0, 2), // changes position of shadow
              ),
            ],
            color: appTheme.themeData.cardColor),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Padding(
                      padding: EdgeInsets.only(top: h / 50),
                      child: CarouselSlider(
                        options: CarouselOptions(
                            // height: h / 3,
                            onPageChanged: (index, reason) =>
                                currentIndex = index,
                            enlargeCenterPage: true,
                            scrollDirection: Axis.horizontal,
                            enableInfiniteScroll: true,
                            viewportFraction: 0.8),
                        items: needy.imagesBefore!
                            .map((image) => GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                ImageCarouselShow(
                                                  needyMedias:
                                                      needy.imagesBefore!,
                                                  currentIndex: currentIndex,
                                                  type: 'Before',
                                                  appTheme: appTheme,
                                                )));
                                  },
                                  child: Image.network(
                                    image.url,
                                    fit: BoxFit.cover,
                                    height: h / 3,
                                    width: w,
                                    errorBuilder: (context, error, stackTrace) {
                                      print(image.url);
                                      print(stackTrace);
                                      print(error);
                                      return Container(
                                        alignment: Alignment.center,
                                        child: Text(
                                          'حدث خطأ أثناء تحميل الصورة',
                                          style: appTheme.themeData
                                              .primaryTextTheme.headlineMedium!
                                              .apply(color: Colors.red),
                                        ),
                                      );
                                    },
                                  ),
                                ))
                            .toList(),
                      )),
                  Visibility(
                    visible: needy.severity! >= 7,
                    child: Positioned(
                      top: 0,
                      left: 0,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            vertical: h / 100, horizontal: w / 20),
                        decoration: BoxDecoration(
                          color: Colors.red[500],
                          borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(30),
                              bottomRight: Radius.circular(30)),
                        ),
                        child: Text(
                          'حالة حرجة',
                          style: appTheme.nonStaticGetTextStyle(
                              1.0,
                              Colors.white,
                              appTheme.smallTextSize(context),
                              FontWeight.w400,
                              1.0,
                              TextDecoration.none,
                              'OpenSans'),
                        ),
                      ),
                    ),
                  ),
                  //ToDo: Future V2
                  // Positioned(
                  //   top: 0,
                  //   right: 0,
                  //   child: Container(
                  //       // padding: EdgeInsets.symmetric(
                  //       //     vertical: h / 100, horizontal: w / 20),
                  //       decoration: BoxDecoration(
                  //         color: Colors.amber[50].withOpacity(0.2),
                  //         borderRadius: BorderRadius.all(
                  //           Radius.circular(30),
                  //         ),
                  //       ),
                  //       child: IconButton(
                  //         padding: EdgeInsets.zero,
                  //         icon: Icon(
                  //           sessionManager.needyIsBookmarked(needy.id)
                  //               ? Icons.bookmark
                  //               : Icons.bookmark_border,
                  //           color: Colors.green,
                  //         ),
                  //         onPressed: () {
                  //           sessionManager.addNeedyToBookmarks(needy.id);
                  //           commonData.refreshPage();
                  //         },
                  //       )),
                  // ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    child: Container(
                        width: w / 2,
                        padding: EdgeInsets.symmetric(
                            vertical: h / 100, horizontal: w / 20),
                        decoration: const BoxDecoration(
                            color: Colors.lightBlue,
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(30))),
                        child: Text(
                          '${needy.type}',
                          textAlign: TextAlign.center,
                          style: appTheme.nonStaticGetTextStyle(
                              1.0,
                              Colors.white,
                              appTheme.smallTextSize(context),
                              FontWeight.bold,
                              1.0,
                              TextDecoration.none,
                              'OpenSans'),
                        )),
                  ),
                ],
              ),
              const CustomSpacing(
                value: 100,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: w / 50, right: w / 50),
                    child: Text(
                      '${getTime(needy.createdOn.toString())}',
                      style: appTheme.nonStaticGetTextStyle(
                          1.0,
                          Colors.grey.withOpacity(0.7),
                          appTheme.smallTextSize(context),
                          FontWeight.w400,
                          1.0,
                          TextDecoration.none,
                          'OpenSans'),
                    ),
                  ),
                  Padding(
                      padding: EdgeInsets.only(left: w / 50, right: w / 50),
                      child: Stack(
                        children: [
                          CircleAvatar(
                            radius: 15,
                            backgroundColor: Colors.transparent,
                            child: Container(
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                      color: Colors.black.withOpacity(0.5),
                                      width: 1)),
                              child: ClipOval(
                                child: Image.network(
                                  needy.createdByImage != null
                                      ? needy.createdByImage!
                                      : 'https://upload.wikimedia.org/wikipedia/commons/9/99/Sample_User_Icon.png',
                                  fit: BoxFit.cover,
                                  width: w / 5,
                                  height: h / 10,
                                  errorBuilder: (context, error, stackTrace) =>
                                      Image.asset('assets/images/user.png'),
                                ),
                              ),
                            ),
                          ),
                          Visibility(
                            visible: needy.createdByVerified!,
                            child: Positioned(
                              bottom: 0,
                              left: 0,
                              child: Tooltip(
                                message: 'موثق \'${needy.createdByName}\'',
                                preferBelow: false,
                                decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.8)),
                                textStyle: appTheme.nonStaticGetTextStyle(
                                    1.0,
                                    const Color.fromRGBO(30, 111, 92, 1.0),
                                    appTheme.smallTextSize(context),
                                    FontWeight.bold,
                                    1.0,
                                    TextDecoration.none,
                                    'OpenSans'),
                                child: Image.asset(
                                  'assets/images/verified.png',
                                  width: 20,
                                ),
                              ),
                            ),
                          ),
                        ],
                      )),
                ],
              ),
              const CustomSpacing(
                value: 100,
              ),
              Padding(
                padding: EdgeInsets.only(left: w / 25, right: w / 50),
                // padding: const EdgeInsets.all(8.0),
                child: Text('${needy.name}',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: appTheme.themeData.primaryTextTheme.headlineMedium!
                        .apply(fontWeightDelta: 4)),
              ),
              const CustomSpacing(
                value: 100,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  needy.age != null
                      ? Container(
                          padding: EdgeInsets.symmetric(
                              vertical: h / 100, horizontal: w / 20),
                          decoration: BoxDecoration(
                            color: Colors.grey.withOpacity(0.3),
                          ),
                          child: Text(
                            'السن: ${needy.age!.toStringAsFixed(0)}',
                            style: appTheme.nonStaticGetTextStyle(
                                1.0,
                                Colors.grey,
                                appTheme.smallTextSize(context),
                                FontWeight.bold,
                                1.0,
                                TextDecoration.none,
                                'OpenSans'),
                          ),
                        )
                      : const SizedBox(),
                ],
              ),
              const CustomSpacing(
                value: 100,
              ),
              LinearPercentIndicator(
                width: 170.0,
                alignment: MainAxisAlignment.center,
                animation: true,
                animationDuration: 1000,
                lineHeight: 20.0,
                linearGradient: const LinearGradient(
                    colors: [Colors.green, Colors.greenAccent]),
                percent: needy.satisfied! ? 1 : needy.collected! / needy.need!,
                center: Text(
                  needy.satisfied!
                      ? 'تمت'
                      : 'تبقي ${(needy.need! - needy.collected!).toStringAsFixed(0)} جنيه',
                  style: appTheme.nonStaticGetTextStyle(
                      1.0,
                      Colors.white,
                      appTheme.smallTextSize(context),
                      FontWeight.bold,
                      1.0,
                      TextDecoration.none,
                      'OpenSans'),
                ),
                linearStrokeCap: LinearStrokeCap.roundAll,
              ),
              const CustomSpacing(
                value: 100,
              ),
              needy.satisfied!
                  ? Center(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ImageCarouselShow(
                                        needyMedias: needy.imagesAfter!,
                                        type: 'After',
                                        currentIndex: currentIndex,
                                        appTheme: appTheme,
                                      )));
                        },
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                Colors.green[500]!.withOpacity(0.7))),
                        child: Text(
                          'أظهر التغيير',
                          style: appTheme.themeData.primaryTextTheme.bodyMedium,
                        ),
                      ),
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          // onPressed: sessionManager.isLoggedIn()
                          //     ? () {
                          //         needyData.chooseNeedy(needy);
                          //         commonData.changeStep(Pages
                          //             .OnlineTransactionCreationScreen.index);
                          //       }
                          //     : null,
                          onPressed: null,
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.resolveWith<Color>(
                                      (Set<MaterialState> states) {
                                if (states.contains(MaterialState.disabled)) {
                                  return Colors.grey[300]!;
                                }
                                return Colors.green[
                                    400]!; // Defer to the widget's default.
                              }),
                              textStyle: MaterialStateProperty.all<TextStyle>(
                                  appTheme
                                      .themeData.primaryTextTheme.titleSmall!)),
                          child: Text('دفع إلكتروني',
                              style: appTheme
                                  .themeData.primaryTextTheme.bodyMedium),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            needyData.chooseNeedy(needy);
                            commonData.changeStep(
                                Pages.OfflineTransactionCreationScreen.index);
                          },
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Colors.green[400]!)),
                          child: Text('دفع كاش',
                              style: appTheme
                                  .themeData.primaryTextTheme.bodyMedium),
                        ),
                      ],
                    ),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    // Share.share(
                    //   //ToDo: Add application url
                    //   needy.satisfied!
                    //       ? 'Check out what Ahed made to change these people\'s life ${needy.url!}, You can start to be part of it by downloading Ahed Application from ${'Application URL'}.'
                    //       : 'Only ${needy.need! - needy.collected!} EGP Left, Help ${needy.name!} To ${needy.type!}!\n ${needy.url!}',
                    // );
                  },
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.blue[400]!)),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('مشاركة',
                          style: appTheme.themeData.primaryTextTheme.bodyMedium),
                      Icon(
                        // Icons.share,
                        FontAwesomeIcons.share,
                        color: Colors.white,
                        size: appTheme.largeTextSize(context),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }

  getTime(String createdAtString) {
    DateTime createdAt = DateTime.parse(createdAtString);
    Duration difference = DateTime.now().difference(createdAt);
    if (difference.inDays > 0) {
      return 'منذ ${difference.inDays} يوم';
    }
    if (difference.inHours > 0) {
      return 'منذ ${difference.inHours} ساعات';
    }
    if (difference.inMinutes > 0) {
      return 'منذ ${difference.inMinutes} دقائق';
    }
    if (difference.inSeconds > 0) {
      return 'منذ ${difference.inSeconds} ثواني';
    }
    return 'الآن';
  }
}
