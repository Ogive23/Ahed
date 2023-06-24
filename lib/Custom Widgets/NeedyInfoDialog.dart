import 'package:ahed/Models/Needy.dart';
import 'package:ahed/Shared%20Data/app_theme.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
// import 'package:share_plus/share_plus.dart';

import 'CustomSpacing.dart';
import 'ImageCarouselShow.dart';

class NeedyInfoDialog extends StatelessWidget {
  final Needy needy;
  final AppTheme appTheme;
  int currentIndex = 0;
  static late double w, h;
  NeedyInfoDialog({super.key, required this.needy, required this.appTheme});

  @override
  Widget build(BuildContext context) {
    w = MediaQuery.of(context).size.width;
    h = MediaQuery.of(context).size.height;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: AlertDialog(
        backgroundColor: appTheme.themeData.cardColor,
        scrollable: true,
        contentPadding:
            EdgeInsets.symmetric(horizontal: w / 50, vertical: h / 50),
        content: Container(
            width: w,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
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
                                    errorBuilder:
                                        (context, error, stackTrace) =>
                                            Container(
                                      alignment: Alignment.center,
                                      child: Text(
                                        'حدث خطأ أثناء تحميل الصورة',
                                        style: appTheme.themeData
                                            .primaryTextTheme.headline4!
                                            .apply(color: Colors.red),
                                      ),
                                    ),
                                  ),
                                ))
                            .toList(),
                      )),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Visibility(
                      visible: needy.severity! >= 7,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            vertical: h / 100, horizontal: w / 20),
                        decoration: BoxDecoration(
                          color: Colors.red[500],
                        ),
                        child: Text(
                          'حالة حرجة',
                          style: appTheme.themeData.primaryTextTheme.headlineSmall!
                              .apply(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: w,
                    child: Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('نوع الحالة: ',
                                style: appTheme
                                    .themeData.primaryTextTheme.headlineSmall),
                            Flexible(
                              child: Text('${needy.type}',
                                  style: appTheme
                                      .themeData.primaryTextTheme.headlineSmall),
                            ),
                          ],
                        ),
                        const CustomSpacing(
                          value: 100,
                        ),
                        ConstrainedBox(
                          constraints: BoxConstraints(
                              maxHeight: h / 8, minHeight: h / 10),
                          child: SingleChildScrollView(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('التفاصيل: ',
                                    style: appTheme
                                        .themeData.primaryTextTheme.headlineSmall),
                                Flexible(
                                  child: Text(
                                    '${needy.details}',
                                    style: appTheme
                                        .themeData.primaryTextTheme.headlineSmall,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const CustomSpacing(
                          value: 100,
                        ),
                        Row(
                          children: [
                            Text('المتبقي: ',
                                style: appTheme
                                    .themeData.primaryTextTheme.headlineSmall),
                            LinearPercentIndicator(
                              width: w / 2,
                              alignment: MainAxisAlignment.center,
                              animation: true,
                              padding: EdgeInsets.symmetric(vertical: h / 100),
                              animationDuration: 1000,
                              lineHeight: h / 25,
                              linearGradient: const LinearGradient(
                                  colors: [Colors.green, Colors.greenAccent]),
                              percent: needy.collected! / needy.need!,
                              center: Text(
                                '${(needy.need! - needy.collected!)
                                        .toStringAsFixed(0)} جنيه',
                                style: appTheme
                                    .themeData.primaryTextTheme.bodyText2,
                              ),
                              linearStrokeCap: LinearStrokeCap.butt,
                            ),
                          ],
                        ),
                      ],
                    ),
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
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.green[500]!.withOpacity(0.7))),
                            child: Text(
                              'أظهر التغيير',
                              style:
                                  appTheme.themeData.primaryTextTheme.bodyMedium,
                            ),
                          ),
                        )
                      : Center(
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
                                    MaterialStateProperty.all<Color>(
                                        Colors.blue[400]!)),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text('مشاركة',
                                    style: appTheme
                                        .themeData.primaryTextTheme.bodyMedium),
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
            )),
      ),
    );
  }
}
