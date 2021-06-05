import 'package:ahed/Shared%20Data/app_theme.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:ahed/Models/NeedyMedia.dart';

class ImageCarouselShow extends StatelessWidget {
  final List<NeedyMedia> needyMedias;
  final int currentIndex;
  final String type;
  final AppTheme appTheme;
  ImageCarouselShow(
      {@required this.needyMedias,
      @required this.currentIndex,
      @required this.type,
      @required this.appTheme});
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(leading: BackButton(),elevation: 0.0,backgroundColor: Colors.transparent,),extendBodyBehindAppBar: true,body: getView(this.type, context));
  }

  Widget getView(String type, context) {
    switch (type) {
      case 'Before':
        return Container(
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(color: Colors.black),
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
                  ),
                )
                .toList(),
          ),
        );
      case 'After':
        return needyMedias.isEmpty
            ? Container(
                height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(color: Colors.blueGrey),
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
                        'We are currently working on the change, Expect us soon and never forget to Pray for us!',
                        textAlign: TextAlign.center,
                        style: appTheme.nonStaticGetTextStyle(
                            1.5,
                            Colors.white,
                            appTheme.getBodyTextTheme(context),
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
          decoration: BoxDecoration(color: Colors.black),
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
                        ),
                      )
                      .toList(),
                ),
              );
    }
  }
}
