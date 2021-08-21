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
    return Material(
        child: SafeArea(
            child: Container(
                height: double.infinity,
                decoration: BoxDecoration(color: Colors.white),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Directionality(
                            textDirection: TextDirection.ltr,
                            child: IconButton(
                              icon: Icon(
                                Icons.arrow_back_ios_sharp,
                                color: Colors.black,
                              ),
                              onPressed: () => commonData.back(),
                            ),
                          ),
                        ],
                      ),
                      CustomSpacing(value: 100,),
                      Padding(
                        padding: EdgeInsets.only(right: w / 20),
                        child: Text(
                          'مجتمعنا',
                          style: appTheme.nonStaticGetTextStyle(
                              1.0,
                              Colors.black,
                              appTheme.largeTextSize(context) * 1.5,
                              FontWeight.w600,
                              1.0,
                              TextDecoration.none,
                              'Delius'),
                        ),
                      ),
                      CustomSpacing(value: 100,),
                      Container(
                        padding: EdgeInsets.symmetric(
                            vertical: h / 100, horizontal: w / 50),
                        //   height: double.infinity,
                        decoration: BoxDecoration(
                            color: appTheme.themeData.primaryColor),
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              //         // SizedBox(
                              //         //     width: MediaQuery.of(context).size.width,
                              //         //     height: NativeBannerAdSize.HEIGHT_50.height.toDouble(),
                              //         //     child: FacebookNativeAd(
                              //         //       placementId: "666800453940153_669631920323673",
                              //         //       adType: NativeAdType.NATIVE_BANNER_AD,
                              //         //       bannerAdSize: NativeBannerAdSize.HEIGHT_50,
                              //         //       width: double.infinity,
                              //         //       backgroundColor: appTheme.themeData.backgroundColor,
                              //         //       titleColor: appTheme.themeData.accentColor,
                              //         //       descriptionColor: appTheme.themeData.accentColor,
                              //         //       buttonColor: Colors.deepPurple,
                              //         //       buttonTitleColor: appTheme.themeData.accentColor,
                              //         //       buttonBorderColor: appTheme.themeData.accentColor,
                              //         //       keepAlive: true,
                              //         //       labelColor: Colors.transparent,
                              //         //       listener: (result, value) {
                              //         //         print("Native Ad: $result --> $value");
                              //         //       },
                              //         //     )),
                              CustomCard(
                                  title: appLanguage
                                      .words['StayInTouchFacebookTitle']!,
                                  subtitle: appLanguage
                                      .words['StayInTouchFacebookSubtitle']!,
                                  url: 'https://www.facebook.com/ogive23/',
                                  icon: FontAwesomeIcons.facebook,
                                  iconColor: Colors.blue,
                                  kind: 'fb',
                                  textDirection: appLanguage.textDirection),
                              SizedBox(
                                height: h / 100,
                              ),
                              CustomCard(
                                  title: appLanguage
                                      .words['StayInTouchInstagramTitle']!,
                                  subtitle: appLanguage
                                      .words['StayInTouchInstagramSubtitle']!,
                                  url:
                                      'https://www.instagram.com/mahmoued.martin/',
                                  icon: FontAwesomeIcons.instagram,
                                  iconColor: Colors.black,
                                  kind: 'insta',
                                  textDirection: appLanguage.textDirection),
                              SizedBox(
                                height: h / 100,
                              ),
                              CustomCard(
                                  title: appLanguage
                                      .words['StayInTouchYoutubeTitle']!,
                                  subtitle: appLanguage
                                      .words['StayInTouchYoutubeSubtitle']!,
                                  url:
                                      'https://www.youtube.com/channel/UCedueKqOIz38zog0alc7_eg',
                                  icon: FontAwesomeIcons.youtube,
                                  iconColor: Colors.red,
                                  kind: 'youtube',
                                  textDirection: appLanguage.textDirection),

                              SizedBox(
                                height: h / 100,
                              ),
                              CustomCard(
                                  title: appLanguage
                                      .words['StayInTouchTwitterTitle']!,
                                  subtitle: appLanguage
                                      .words['StayInTouchTwitterSubtitle']!,
                                  url: 'https://twitter.com/MahmouedMartin2',
                                  icon: FontAwesomeIcons.twitter,
                                  iconColor: Colors.blue,
                                  kind: 'twitter',
                                  textDirection: appLanguage.textDirection),
                            ],
                          ),
                        ),
                      )
                    ]))));
  }
}
