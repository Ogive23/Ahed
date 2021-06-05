import 'package:ahed/Models/Needy.dart';
import 'package:ahed/Session/session_manager.dart';
import 'package:ahed/Shared%20Data/app_theme.dart';
import 'package:ahed/Shared%20Data/common_data.dart';
import 'package:ahed/Shared%20Data/NeedyData.dart';
import 'package:animations/animations.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';

import '../GeneralInfo.dart';
import 'CustomSpacing.dart';
import 'ImageCarouselShow.dart';

class CustomNeedyContainer extends StatelessWidget {
  final Needy needy;

  int currentIndex = 0;
  CustomNeedyContainer({@required this.needy});
  AppTheme appTheme;
  CommonData commonData;
  NeedyData needyData;
  double w, h;
  SessionManager sessionManager = new SessionManager();
  @override
  Widget build(BuildContext context) {
    commonData = Provider.of<CommonData>(context);
    needyData = Provider.of<NeedyData>(context);
    appTheme = Provider.of<AppTheme>(context);
    w = MediaQuery.of(context).size.width;
    h = MediaQuery.of(context).size.height;
    print('need =  ${needy.need}');
    print('collected = ${needy.collected}');
    return Container(
        margin: EdgeInsets.only(top: h / 50, bottom: h / 50),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            border:
                Border.all(color: Color.fromRGBO(30, 111, 92, 1.0), width: 1),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 5,
                offset: Offset(0, 2), // changes position of shadow
              ),
            ],
            color: Colors.white),
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
                      items: needy.imagesBefore
                          .map((image) => GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              ImageCarouselShow(
                                                needyMedias: needy.imagesBefore,
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
                  visible: needy.severity >= 7,
                  child: Positioned(
                    top: 0,
                    left: 0,
                    child: Container(
                      margin: EdgeInsets.only(left: 1),
                      padding: EdgeInsets.symmetric(
                          vertical: h / 100, horizontal: w / 20),
                      decoration: BoxDecoration(
                        color: Colors.red[500],
                        borderRadius:
                            BorderRadius.only(topLeft: Radius.circular(40)),
                      ),
                      child: Text(
                        'Urgent',
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
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                      width: w / 2,
                      padding: EdgeInsets.symmetric(
                          vertical: h / 100, horizontal: w / 20),
                      decoration: BoxDecoration(
                          color: Colors.lightBlue,
                          borderRadius:
                              BorderRadius.only(topLeft: Radius.circular(30))),
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
                    left: 10,
                    child: Stack(
                      children: [
                        CircleAvatar(
                          radius: 25,
                          backgroundColor: Colors.transparent,
                          child: ClipOval(
                            child: Image.asset(
                              needy.createdByImage,
                              fit: BoxFit.fill,
                              width: 120,
                              height: 120,
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: Tooltip(
                            message: 'Verified ✔ \'${needy.createdBy}\'',
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
              child: Text(
                'Donate To Help ${needy.name} To ${getNeedySentence(needy.type)}',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: appTheme.nonStaticGetTextStyle(
                    1.0,
                    Colors.black,
                    appTheme.getSemiBodyTextTheme(context),
                    FontWeight.bold,
                    1.0,
                    TextDecoration.none,
                    'OpenSans'),
              ),
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
                          'AGE:${needy.age.toStringAsFixed(0)}',
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
              linearGradient:
                  LinearGradient(colors: [Colors.green, Colors.greenAccent]),
              percent: needy.satisfied ? 1 : needy.collected / needy.need,
              center: Text(
                needy.satisfied
                    ? 'Done!'
                    : (needy.need - needy.collected).toStringAsFixed(0) +
                        ' EGP Left',
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
            needy.satisfied
                ? Center(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ImageCarouselShow(
                                      needyMedias: needy.imagesAfter,
                                      type: 'After',
                                      currentIndex: currentIndex,
                                      appTheme: appTheme,
                                    )));
                      },
                      child: Text('Show the change'),
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Colors.green[500].withOpacity(0.7))),
                    ),
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          needyData.chooseNeedy(needy);
                          commonData.changeStep(
                              Pages.OnlineTransactionCreationScreen.index);
                        },
                        child: Text('Online Donation'),
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                Colors.green[400])),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          needyData.chooseNeedy(needy);
                          commonData.changeStep(
                              Pages.OfflineTransactionCreationScreen.index);
                        },
                        child: Text(
                          'Offline Donation',
                        ),
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                Colors.green[400])),
                      ),
                    ],
                  ),
            Center(
              child: ElevatedButton(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('Share'),
                    Icon(
                      // Icons.share,
                      EvilIcons.share_google,
                      color: Colors.white,
                      size: 25,
                    ),
                  ],
                ),
                onPressed: () {
                  Share.share(
                    //ToDo: Add application url
                    needy.satisfied
                        ? 'Check out what Ahed made to change these people\'s life ${needy.url}, You can start to be part of it by downloading Ahed Application from ${'Application URL'}.'
                        : 'Only ${needy.need - needy.collected} EGP Left, Help ${needy.name} To ${getNeedySentence(needy.type)}!\n ${needy.url}',
                  );
                },
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.blue[400])),
              ),
            ),
          ],
        ));
  }

  getNeedySentence(String type) {
    switch (type) {
      case 'Finding Living':
        return 'Find a better life';
      case 'Upgrade Standard of Living':
        return 'Upgrade Standard of Living';
      case 'Bride Preparation':
        return 'Prepare for an awesome joy';
      case 'Debt':
        return 'finish Debt';
      case 'Cure':
        return 'find a Cure';
    }
  }

  getTime(String createdAtString) {
    DateTime createdAt = DateTime.parse(createdAtString);
    Duration difference = DateTime.now().difference(createdAt);
    print(difference);
    if (difference.inDays > 0) return difference.inDays.toString() + " Day Ago";
    if (difference.inHours > 0)
      return difference.inHours.toString() + " Hour Ago";
    if (difference.inMinutes > 0)
      return difference.inMinutes.toString() + " Minute Ago";
    if (difference.inSeconds > 0)
      return difference.inSeconds.toString() + " Second Ago";
    return "Just Now";
  }
}
