import 'package:ahed/Custom%20Widgets/CustomSpacing.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import '../../Custom Widgets/custom_card.dart';
import '../../Session/session_manager.dart';
import '../../Shared Data/app_language.dart';
import '../../Shared Data/app_theme.dart';
import '../../Shared Data/common_data.dart';

class StayInTouchScreen extends StatelessWidget {
  static late double w, h;
  final SessionManager sessionManager = new SessionManager();
  static late CommonData commonData;
  static late AppTheme appTheme;
  static late AppLanguage appLanguage;
  @override
  Widget build(BuildContext context) {
    commonData = Provider.of<CommonData>(context);
    appTheme = Provider.of<AppTheme>(context);
    appLanguage = Provider.of<AppLanguage>(context);
    w = MediaQuery.of(context).size.width;
    h = MediaQuery.of(context).size.height;
    return SafeArea(
        child: Container(
            height: double.infinity,
            decoration: BoxDecoration(color: appTheme.themeData.primaryColor),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(
                // crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.only(right: w / 20),
                    child: Text(
                      'مجتمعنا',
                      style: appTheme.themeData.primaryTextTheme.headline2!
                          .apply(
                              color: appTheme.themeData.primaryTextTheme
                                  .headline5!.color!),
                    ),
                  ),
                  Directionality(
                    textDirection: TextDirection.ltr,
                    child: IconButton(
                      icon: Icon(
                        Icons.arrow_back_ios_sharp,
                        color: appTheme
                            .themeData.primaryTextTheme.headline5!.color!,
                      ),
                      onPressed: () => commonData.back(),
                    ),
                  ),
                ],
              ),
              CustomSpacing(
                value: 100,
              ),
              Container(
                padding:
                    EdgeInsets.symmetric(vertical: h / 100, horizontal: w / 50),
                //   height: double.infinity,
                decoration:
                    BoxDecoration(color: appTheme.themeData.primaryColor),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      CustomCard(
                          title: appLanguage.words['StayInTouchFacebookTitle']!,
                          subtitle:
                              appLanguage.words['StayInTouchFacebookSubtitle']!,
                          url: 'https://www.facebook.com/ogive23/',
                          icon: FontAwesomeIcons.facebook,
                          iconColor: Colors.blue,
                          kind: 'fb',
                          textDirection: appLanguage.textDirection),
                      // CustomSpacing(
                      //   value: 100,
                      // ),
                      // CustomCard(
                      //     title: appLanguage
                      //         .words['StayInTouchInstagramTitle']!,
                      //     subtitle: appLanguage
                      //         .words['StayInTouchInstagramSubtitle']!,
                      //     url:
                      //         'https://www.instagram.com/mahmoued.martin/',
                      //     icon: FontAwesomeIcons.instagram,
                      //     iconColor: Colors.black,
                      //     kind: 'insta',
                      //     textDirection: appLanguage.textDirection),
                      // CustomSpacing(
                      //   value: 100,
                      // ),
                      // CustomCard(
                      //     title: appLanguage
                      //         .words['StayInTouchYoutubeTitle']!,
                      //     subtitle: appLanguage
                      //         .words['StayInTouchYoutubeSubtitle']!,
                      //     url:
                      //         'https://www.youtube.com/channel/UCedueKqOIz38zog0alc7_eg',
                      //     icon: FontAwesomeIcons.youtube,
                      //     iconColor: Colors.red,
                      //     kind: 'youtube',
                      //     textDirection: appLanguage.textDirection),
                      // CustomSpacing(
                      //   value: 100,
                      // ),
                      // CustomCard(
                      //     title: appLanguage
                      //         .words['StayInTouchTwitterTitle']!,
                      //     subtitle: appLanguage
                      //         .words['StayInTouchTwitterSubtitle']!,
                      //     url: 'https://twitter.com/MahmouedMartin2',
                      //     icon: FontAwesomeIcons.twitter,
                      //     iconColor: Colors.blue,
                      //     kind: 'twitter',
                      //     textDirection: appLanguage.textDirection),
                    ],
                  ),
                ),
              )
            ])));
  }
}
