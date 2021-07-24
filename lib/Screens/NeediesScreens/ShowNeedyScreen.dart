import 'package:ahed/Custom%20Widgets/CustomNeedyContainer.dart';
import 'package:ahed/Custom%20Widgets/CustomSpacing.dart';
import 'package:ahed/Custom%20Widgets/ImageCarouselShow.dart';
import 'package:ahed/Models/Needy.dart';
import 'package:ahed/Shared%20Data/app_theme.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';

class ShowNeedyScreen extends StatelessWidget {
  final Needy needy;
  final AppTheme appTheme;
  static late double w, h;
  static int currentIndex = 0;
  ShowNeedyScreen({required this.needy, required this.appTheme});

  @override
  Widget build(BuildContext context) {
    w = MediaQuery.of(context).size.width;
    h = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(),
        title: Text('${needy.name}'),
        centerTitle: true,
        backgroundColor: appTheme.themeData.appBarTheme.backgroundColor,
      ),
      body: Container(
          height: double.infinity,
          decoration: BoxDecoration(color: appTheme.themeData.cardColor),
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
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(30),
                                bottomRight: Radius.circular(30)),
                          ),
                          child: Text(
                            'حالة حرجة',
                            style: appTheme.nonStaticGetTextStyle(
                                1.0,
                                Colors.white,
                                appTheme.getBodyTextTheme(context),
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
                          decoration: BoxDecoration(
                              color: Colors.lightBlue,
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(30))),
                          child: Text(
                            '${needy.type}',
                            textAlign: TextAlign.center,
                            style: appTheme.nonStaticGetTextStyle(
                                1.0,
                                Colors.white,
                                appTheme.getBodyTextTheme(context),
                                FontWeight.bold,
                                1.0,
                                TextDecoration.none,
                                'OpenSans'),
                          )),
                    ),
                    Positioned(
                        bottom: 0,
                        right: w / 20,
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
                                    needy.createdByImage != 'N/A'
                                        ? needy.createdByImage!
                                        : 'https://upload.wikimedia.org/wikipedia/commons/9/99/Sample_User_Icon.png',
                                    fit: BoxFit.cover,
                                    width: w / 5,
                                    height: h / 10,
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
                                      Color.fromRGBO(30, 111, 92, 1.0),
                                      appTheme.getBodyTextTheme(context),
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
                CustomSpacing(),
                Padding(
                  padding: EdgeInsets.only(left: w / 50, right: w / 50),
                  child: Text(
                    '${getTime(needy.createdOn.toString())}',
                    style: appTheme.nonStaticGetTextStyle(
                        1.0,
                        Colors.grey.withOpacity(0.7),
                        appTheme.getBodyTextTheme(context),
                        FontWeight.w400,
                        1.0,
                        TextDecoration.none,
                        'OpenSans'),
                  ),
                ),
                CustomSpacing(),
                Padding(
                  padding: EdgeInsets.only(left: w / 25, right: w / 50),
                  // padding: const EdgeInsets.all(8.0),
                  child: Text('تبرع لمساعدة ${needy.name} ل${needy.type}',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: appTheme.themeData.primaryTextTheme.headline4!
                          .apply(fontWeightDelta: 4)),
                ),
                CustomSpacing(),
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
                                  appTheme.getBodyTextTheme(context),
                                  FontWeight.bold,
                                  1.0,
                                  TextDecoration.none,
                                  'OpenSans'),
                            ),
                          )
                        : SizedBox(),
                  ],
                ),
                CustomSpacing(),
                LinearPercentIndicator(
                  width: 170.0,
                  alignment: MainAxisAlignment.center,
                  animation: true,
                  animationDuration: 1000,
                  lineHeight: 20.0,
                  linearGradient: LinearGradient(
                      colors: [Colors.green, Colors.greenAccent]),
                  percent:
                      needy.satisfied! ? 1 : needy.collected! / needy.need!,
                  center: Text(
                    needy.satisfied!
                        ? 'تمت'
                        : 'تبقي ' +
                            (needy.need! - needy.collected!)
                                .toStringAsFixed(0) +
                            ' جنيه',
                    style: appTheme.nonStaticGetTextStyle(
                        1.0,
                        Colors.white,
                        appTheme.getBodyTextTheme(context),
                        FontWeight.bold,
                        1.0,
                        TextDecoration.none,
                        'OpenSans'),
                  ),
                  linearStrokeCap: LinearStrokeCap.roundAll,
                ),
                CustomSpacing(),
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
                          child: Text(
                            'أظهر التغيير',
                            style:
                                appTheme.themeData.primaryTextTheme.bodyText2,
                          ),
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Colors.green[500]!.withOpacity(0.7))),
                        ),
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          // ElevatedButton(
                          //   onPressed: sessionManager.isLoggedIn()
                          //       ? () {
                          //     needyData.chooseNeedy(needy);
                          //     commonData.changeStep(Pages
                          //         .OnlineTransactionCreationScreen.index);
                          //   }
                          //       : null,
                          //   child: Text('دفع إلكتروني',
                          //       style: appTheme
                          //           .themeData.primaryTextTheme.bodyText2),
                          //   style: ButtonStyle(
                          //       backgroundColor:
                          //       MaterialStateProperty.resolveWith<Color>(
                          //               (Set<MaterialState> states) {
                          //             if (states.contains(MaterialState.disabled))
                          //               return Colors.grey[300]!;
                          //             return Colors.green[
                          //             400]!; // Defer to the widget's default.
                          //           }),
                          //       textStyle: MaterialStateProperty.all<TextStyle>(
                          //           appTheme
                          //               .themeData.primaryTextTheme.subtitle2!)),
                          // ),
                          // ElevatedButton(
                          //   onPressed: () {
                          //     needyData.chooseNeedy(needy);
                          //     commonData.changeStep(
                          //         Pages.OfflineTransactionCreationScreen.index);
                          //   },
                          //   child: Text('دفع كاش',
                          //       style: appTheme
                          //           .themeData.primaryTextTheme.bodyText2),
                          //   style: ButtonStyle(
                          //       backgroundColor: MaterialStateProperty.all<Color>(
                          //           Colors.green[400]!)),
                          // ),
                        ],
                      ),
                Center(
                  child: ElevatedButton(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text('مشاركة',
                            style:
                                appTheme.themeData.primaryTextTheme.bodyText2),
                        Icon(
                          // Icons.share,
                          FontAwesomeIcons.share,
                          color: Colors.white,
                          size: appTheme.getTextTheme(context),
                        ),
                      ],
                    ),
                    onPressed: () {
                      Share.share(
                        //ToDo: Add application url
                        needy.satisfied!
                            ? 'Check out what Ahed made to change these people\'s life ${needy.url!}, You can start to be part of it by downloading Ahed Application from ${'Application URL'}.'
                            : 'Only ${needy.need! - needy.collected!} EGP Left, Help ${needy.name!} To ${needy.type!}!\n ${needy.url!}',
                      );
                    },
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            Colors.blue[400]!)),
                  ),
                ),
              ],
            ),
          )),
    );
  }

  getTime(String createdAtString) {
    DateTime createdAt = DateTime.parse(createdAtString);
    Duration difference = DateTime.now().difference(createdAt);
    if (difference.inDays > 0)
      return "منذ " + difference.inDays.toString() + " يوم";
    if (difference.inHours > 0)
      return "منذ " + difference.inHours.toString() + " ساعات";
    if (difference.inMinutes > 0)
      return "منذ " + difference.inMinutes.toString() + " دقائق";
    if (difference.inSeconds > 0)
      return "منذ " + difference.inSeconds.toString() + " ثواني";
    return "الآن";
  }
}
