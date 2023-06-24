import 'package:ahed/Shared%20Data/app_theme.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:ahed/Models/NeedyMedia.dart';

class ImageCarouselShow extends StatelessWidget {
  late final List<NeedyMedia> needyMedias;
  late final int currentIndex;
  late final String type;
  late final AppTheme appTheme;
  ImageCarouselShow(
      {required this.needyMedias,
      required this.currentIndex,
      required this.type,
      required this.appTheme});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: const BackButton(),
          elevation: 0.0,
          backgroundColor: Colors.transparent,
        ),
        extendBodyBehindAppBar: true,
        body: getView(type, context));
  }

  Widget getView(String type, context) {
    if (type == 'Before') {
      return Container(
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(color: Colors.black),
        child: CarouselSlider(
          options: CarouselOptions(
              enlargeCenterPage: true,
              scrollDirection: Axis.horizontal,
              enableInfiniteScroll: false,
              viewportFraction: 1.0),
          items: needyMedias
              .map(
                (needyMedia) => Image.network(
                  needyMedia.url,
                  errorBuilder:
                      (context, error, stackTrace) =>
                      Container(
                        alignment: Alignment.center,
                        child: Text(
                          'حدث خطأ أثناء تحميل الصورة',
                          style: appTheme.themeData
                              .primaryTextTheme.headlineMedium!
                              .apply(color: Colors.red),
                        ),
                      ),
                ),
              )
              .toList(),
        ),
      );
    }
    return needyMedias.isEmpty
        ? Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(color: Colors.blueGrey),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Lottie.asset('assets/animations/57983-sand-clock.json',
                    height: MediaQuery.of(context).size.height / 3),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(30)),
                  padding: EdgeInsets.symmetric(
                      vertical: MediaQuery.of(context).size.height / 100,
                      horizontal: MediaQuery.of(context).size.width / 25),
                  margin: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width / 50),
                  child: Text(
                    '.نحن الآن في طريقنا للتغيير، أنتظرونا و أدعوا لنا بالتوفيق',
                    textAlign: TextAlign.center,
                    style: appTheme.nonStaticGetTextStyle(
                        1.5,
                        Colors.white,
                        appTheme.smallTextSize(context),
                        FontWeight.bold,
                        1.0,
                        TextDecoration.none,
                        'OpenSans'),
                  ),
                ),
              ],
            ),
          )
        : Container(
            height: MediaQuery.of(context).size.height,
            decoration: const BoxDecoration(color: Colors.black),
            child: CarouselSlider(
              options: CarouselOptions(
                  enlargeCenterPage: true,
                  scrollDirection: Axis.horizontal,
                  enableInfiniteScroll: false,
                  viewportFraction: 1.0),
              items: needyMedias
                  .map(
                    (needyMedia) => Image.network(
                      needyMedia.url,
                      errorBuilder:
                          (context, error, stackTrace) =>
                          Container(
                            alignment: Alignment.center,
                            child: Text(
                              'حدث خطأ أثناء تحميل الصورة',
                              style: appTheme.themeData
                                  .primaryTextTheme.headlineMedium!
                                  .apply(color: Colors.red),
                            ),
                          ),
                    ),
                  )
                  .toList(),
            ),
          );
  }
}
