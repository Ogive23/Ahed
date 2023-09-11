import 'package:ahed/Models/User.dart';
import 'package:mixpanel_flutter/mixpanel_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Models/User.dart';

class MixPanelManager {
  late Mixpanel? mixpanel;

  MixPanelManager._privateConstructor();
  static final MixPanelManager _instance = MixPanelManager._privateConstructor();
  factory MixPanelManager() {
    return _instance;
  }

  Future<void> initMixpanel() async {
    mixpanel = await Mixpanel.init("bea05d9f9bc6df748045a3bfce6c0e6b",
        trackAutomaticEvents: true);
  }
}
