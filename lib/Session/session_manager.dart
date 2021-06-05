import 'package:ahed/Models/User.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Models/User.dart';

class SessionManager {
  SharedPreferences sharedPreferences;
  User user;
  String oauthToken;
  DateTime accessTokenExpireDate;

  SessionManager._privateConstructor();

  static final SessionManager _instance = SessionManager._privateConstructor();

  factory SessionManager() {
    return _instance;
  }
  getSessionManager() async {
    sharedPreferences = await SharedPreferences.getInstance();
    addDummyData();
  }

  createSession(User user, String oauthToken, DateTime accessTokenExpiryDate) {
    this.user = user;
    this.oauthToken = oauthToken;
    sharedPreferences.setStringList('user', user.toList());
    sharedPreferences.setString(
        'accessTokenExpireDate', accessTokenExpiryDate.toString());
    sharedPreferences.setString('oauthToken', oauthToken);
  }

  loadSession() {
    accessTokenExpireDate =
        DateTime.parse(sharedPreferences.getString('accessTokenExpireDate'));
    if (accessTokenExpireDate.isBefore(DateTime.now())) {
      logout();
    }
    List<String> userData = sharedPreferences.getStringList('user');
    user = new User(
        userData[0],
        userData[1],
        userData[2],
        userData[3],
        userData[4],
        userData[5],
        userData[6],
        userData[7],
        //ToDo: Review
        userData[8] == "true" ? true : false);
    oauthToken = sharedPreferences.getString('oauthToken');
  }

  bool notFirstTime() {
    return sharedPreferences.containsKey('notFirstTime'); //true if there
  }

  changeStatus() {
    sharedPreferences.setString('notFirstTime', true.toString());
  }

  bool isLoggedIn() {
    return sharedPreferences.containsKey('user');
  }

  createPreferredTheme(bool theme) {
    sharedPreferences.setString('theme', theme.toString());
  }

  bool loadPreferredTheme() {
    return sharedPreferences.get('theme') == 'true' ?? false;
  }

  createPreferredLanguage(String lang) {
    sharedPreferences.setString('lang', lang);
  }

  String loadPreferredLanguage() {
    return sharedPreferences.get('lang');
  }
  bool accessTokenExpired(){
    return accessTokenExpireDate.isBefore(DateTime.now());
  }
  logout() {
    sharedPreferences.remove('user');
  }

  void addDummyData() {
    this.user = new User(
        '1234',
        'Mahmoued Mohamed',
        'Mahmoued',
        'mahmouedmartin222@yahoo.com',
        'male',
        '+201146284953',
        '26 El Gesr elbrany St, Dar Elsalam, Cairo - Egypt',
        // 'https://adventure.com/wp-content/uploads/2018/10/Rehahn-and-giving-back-in-travel-photography-Hmong-in-Bac-Ha-Photo-credit-Rehahn.jpg',
        'https://m.economictimes.com/thumb/msid-72360263,width-1200,height-900,resizemode-4,imgsize-436664/joaquin-phoenix-recently-appeared-in-petas-we-are-all-animals-billboards-in-times-square-and-on-sunset-billboard-as-he-promoted-legislation-to-ban-travelling-wild-animal-circuses-.jpg',
        true);
  }
}
