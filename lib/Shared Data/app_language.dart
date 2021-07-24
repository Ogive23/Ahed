import 'package:flutter/material.dart';

class AppLanguage extends ChangeNotifier {
  String? language;
  late Map<String, String> words;
  late TextDirection textDirection;
  AppLanguage(String? language) {
    this.language = language;
    textDirection = initTextDirection(this.language);
    words = initWords(this.language);
  }
  changeLanguage(String language) {
    this.language = language;
    textDirection = initTextDirection(this.language);
    words = initWords(this.language);
    notifyListeners();
  }

  Map<String, String> initWords(String? language) {
    return language == 'En'
        ? {
            'StayInTouchTitle': 'Our Society',
            'StayInTouchFacebookTitle': 'Facebook',
            'StayInTouchFacebookSubtitle': 'Visit our facebook Page.',
            'StayInTouchInstagramTitle': 'Instagram',
            'StayInTouchInstagramSubtitle': 'Visit our Instagram Account.',
            'StayInTouchYoutubeTitle': 'Youtube',
            'StayInTouchYoutubeSubtitle': 'Visit our youtube channel.',
            'StayInTouchTwitterTitle': 'Twitter',
            'StayInTouchTwitterSubtitle': 'Find us on twitter.',
            'SettingsTitle': 'Settings',
            'SettingsDarkMode': 'DarkMode',
            'SettingsLanguage': 'Language',
          }
        : {
            'StayInTouchTitle': 'مجتمعنا',
            'StayInTouchFacebookTitle': 'فيسبوك',
            'StayInTouchFacebookSubtitle': 'زوروا صفحتنا.',
            'StayInTouchInstagramTitle': 'إنستجرام',
            'StayInTouchInstagramSubtitle': 'زوروا حسابنا علي إنستجرام.',
            'StayInTouchYoutubeTitle': 'يوتيوب',
            'StayInTouchYoutubeSubtitle': 'زوروا قناتنا علي يوتيوب.',
            'StayInTouchTwitterTitle': 'تويتر',
            'StayInTouchTwitterSubtitle': 'زورونا علي تويتر.',
            'SettingsTitle': 'الإعدادات',
            'SettingsDarkMode': 'الوضع المظلم',
            'SettingsLanguage': 'اللغة',
          };
  }

  TextDirection initTextDirection(String? language) {
    return language == 'En' ? TextDirection.ltr : TextDirection.rtl;
  }
}
