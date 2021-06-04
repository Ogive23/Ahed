import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:provider/provider.dart';
import '../../Custom Widgets/custom_card.dart';
import '../../Session/session_manager.dart';
import '../../Shared Data/app_language.dart';
import '../../Shared Data/app_theme.dart';
import '../../Shared Data/common_data.dart';

class StayInTouchScreen extends StatelessWidget {
  final SessionManager sessionManager = new SessionManager();
  static CommonData commonData;
  static AppTheme appTheme;
  static AppLanguage appLanguage;
  @override
  Widget build(BuildContext context) {
    commonData = Provider.of<CommonData>(context);
    appTheme = Provider.of<AppTheme>(context);
    appLanguage = Provider.of<AppLanguage>(context);
    return
       Container(
        padding: EdgeInsets.only(left: 5, right: 5, top: 10, bottom: 10),
        height: double.infinity,
        decoration: BoxDecoration(color: appTheme.themeData.primaryColor),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // SizedBox(
              //     width: MediaQuery.of(context).size.width,
              //     height: NativeBannerAdSize.HEIGHT_50.height.toDouble(),
              //     child: FacebookNativeAd(
              //       placementId: "666800453940153_669631920323673",
              //       adType: NativeAdType.NATIVE_BANNER_AD,
              //       bannerAdSize: NativeBannerAdSize.HEIGHT_50,
              //       width: double.infinity,
              //       backgroundColor: appTheme.themeData.backgroundColor,
              //       titleColor: appTheme.themeData.accentColor,
              //       descriptionColor: appTheme.themeData.accentColor,
              //       buttonColor: Colors.deepPurple,
              //       buttonTitleColor: appTheme.themeData.accentColor,
              //       buttonBorderColor: appTheme.themeData.accentColor,
              //       keepAlive: true,
              //       labelColor: Colors.transparent,
              //       listener: (result, value) {
              //         print("Native Ad: $result --> $value");
              //       },
              //     )),
              SizedBox(
                height: 10,
              ),
              CustomCard(
                  title: appLanguage.words['StayInTouchFacebookTitle'],
                  subtitle: appLanguage.words['StayInTouchFacebookSubtitle'],
                  url: 'https://www.facebook.com/ogive23/',
                  icon: Entypo.facebook,
                  iconColor: Colors.blue,
                  kind: 'fb',
                  textDirection: appLanguage.textDirection),
              SizedBox(
                height: 20,
              ),
              CustomCard(
                  title: appLanguage.words['StayInTouchInstagramTitle'],
                  subtitle: appLanguage.words['StayInTouchInstagramSubtitle'],
                  url: 'https://www.instagram.com/mahmoued.martin/',
                  icon: MaterialCommunityIcons.instagram,
                  iconColor: Colors.black,
                  kind: 'insta',
                  textDirection: appLanguage.textDirection),
              SizedBox(
                height: 20,
              ),
              CustomCard(
                  title: appLanguage.words['StayInTouchYoutubeTitle'],
                  subtitle: appLanguage.words['StayInTouchYoutubeSubtitle'],
                  url:
                      'https://www.youtube.com/channel/UCedueKqOIz38zog0alc7_eg',
                  icon:Entypo.youtube,
                  iconColor: Colors.red,
                  kind: 'youtube',
                  textDirection: appLanguage.textDirection),

              SizedBox(
                height: 20,
              ),
              CustomCard(
                  title: appLanguage.words['StayInTouchTwitterTitle'],
                  subtitle: appLanguage.words['StayInTouchTwitterSubtitle'],
                  url: 'https://twitter.com/MahmouedMartin2',
                  icon:Entypo.twitter,
                  iconColor: Colors.blue,
                  kind: 'twitter',
                  textDirection: appLanguage.textDirection),
            ],
          ),
        ),
    );
  }
}
