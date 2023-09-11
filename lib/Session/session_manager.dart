import 'package:ahed/Models/User.dart';
import 'package:ahed/Session/MixPanelManager.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Models/User.dart';

class SessionManager {
  late SharedPreferences? sharedPreferences;
  final MixPanelManager mixPanelManager = new MixPanelManager();
  User? user;
  String? accessToken;
  DateTime? accessTokenExpireDate;

  SessionManager._privateConstructor();
  static final SessionManager _instance = SessionManager._privateConstructor();
  factory SessionManager() {
    return _instance;
  }

  getSessionManager() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  createSession(User user, String accessToken, DateTime expiryDate) {
    this.user = user;
    this.accessToken = accessToken;
    accessTokenExpireDate = expiryDate;
    print(user.toList());
    sharedPreferences!.setStringList('user', user.toList());
    sharedPreferences!.setString('accessToken', accessToken);
    sharedPreferences!.setString('expiryDate', expiryDate.toString());
    mixPanelManager.mixpanel!.identify(user.id);
    mixPanelManager.mixpanel!
        .getPeople()
        .set('Name', user.name);
    mixPanelManager.mixpanel!
        .getPeople()
        .set('Email', user.email);
    mixPanelManager.mixpanel!
        .getPeople()
        .set('Gender', user.gender);
    mixPanelManager.mixpanel!
        .getPeople()
        .set('Phone Number', user.phoneNumber);
    mixPanelManager.mixpanel!
        .getPeople()
        .set('Address', user.address);
    mixPanelManager.mixpanel!
        .getPeople()
        .set('Verified', user.verified);
  }

  loadSession() async {
    accessTokenExpireDate =
        DateTime.parse(sharedPreferences!.getString('expiryDate')!);
    if (accessTokenExpireDate!.isBefore(DateTime.now())) {
      logout();
    }
    accessToken = sharedPreferences!.getString('accessToken')!;
    List<String> userData = sharedPreferences!.getStringList('user')!;
    user = User(
      userData[0],
      userData[1],
      userData[2],
      userData[3],
      userData[4],
      userData[5],
      userData[6] == '' ? null : userData[6],
      //ToDo: Review
      userData[7] == 'true' ? true : false,
      userData[8] == '' ? null : userData[8],
      userData[9] == '' ? null : userData[9],
      userData[10] == '' ? null : userData[10],
    );

    mixPanelManager.mixpanel!.identify(user!.id);
    mixPanelManager.mixpanel!
        .getPeople()
        .set('name', user!.name);
    mixPanelManager.mixpanel!
        .getPeople()
        .set('username', user!.username);
    mixPanelManager.mixpanel!
        .getPeople()
        .set('email', user!.email);
    mixPanelManager.mixpanel!
        .getPeople()
        .set('gender', user!.gender);
    mixPanelManager.mixpanel!
        .getPeople()
        .set('phone', user!.phoneNumber);
    mixPanelManager.mixpanel!
        .getPeople()
        .set('address', user!.address);
    mixPanelManager.mixpanel!
        .getPeople()
        .set('verified', user!.verified);
  }

  bool notFirstTime() {
    return sharedPreferences!.containsKey('notFirstTime'); //true if there
  }

  changeStatus() {
    sharedPreferences!.setString('notFirstTime', true.toString());
  }

  bool isLoggedIn() {
    return sharedPreferences!.containsKey('user');
  }

  createPreferredTheme(bool theme) {
    sharedPreferences!.setString('theme', theme.toString());
  }

  bool loadPreferredTheme() {
    return sharedPreferences!.get('theme') == 'true';
  }

  createPreferredLanguage(String lang) {
    sharedPreferences!.setString('lang', lang);
  }

  String? loadPreferredLanguage() {
    return sharedPreferences!.getString('lang');
  }

  bool accessTokenExpired() {
    return accessTokenExpireDate!= null? accessTokenExpireDate!.isBefore(DateTime.now()) : true;
  }

  logout() {
    user = null;
    accessToken = null;
    accessTokenExpireDate = null;
    sharedPreferences!.remove('accessTokenExpireDate');
    sharedPreferences!.remove('accessToken');
    sharedPreferences!.remove('user');
  }

  void changeUserInfo(String bio, String address, String phoneNumber) {
    user!.profileBio = bio;
    user!.address = address;
    user!.phoneNumber = phoneNumber;
    sharedPreferences!.setStringList('user', user!.toList());
    List<String> userData = sharedPreferences!.getStringList('user')!;
    user = User(
        userData[0],
        userData[1],
        userData[2],
        userData[3],
        userData[4],
        userData[5],
        userData[6],
        //ToDo: Review
        userData[7] == 'true' ? true : false,
        userData[9],
        userData[10],
        userData[11]);
  }

  void refreshSessionToken(String accessToken, String expiryDate) {
    this.accessToken = accessToken;
    accessTokenExpireDate = DateTime.parse(expiryDate);
    sharedPreferences!.setString('accessToken', accessToken);
    sharedPreferences!.setString('expiryDate', expiryDate);
  }

  //ToDo: Future V2
  // bool needyIsBookmarked(String id) {
  //   if (sharedPreferences.containsKey('Bookmarks')) {
  //     List<String> bookmarks = sharedPreferences.getStringList('Bookmarks');
  //     return bookmarks.contains(id);
  //   }
  //   return false;
  // }

  //ToDo: Future V2
  // void addNeedyToBookmarks(String id) {
  //   if (sharedPreferences.containsKey('Bookmarks')) {
  //     List<String> bookmarks = sharedPreferences.getStringList('Bookmarks');
  //     if (bookmarks.contains(id))
  //       bookmarks.remove(id);
  //     else
  //       bookmarks.add(id);
  //     print(bookmarks);
  //     sharedPreferences.setStringList('Bookmarks', bookmarks);
  //     return;
  //   }
  //   sharedPreferences.setStringList('Bookmarks', [id]);
  // }

  //ToDo: Future V2
  // bool hasAnyBookmarked() {
  //   print('bookMarks ${sharedPreferences.getStringList('Bookmarks')}');
  //   if (sharedPreferences.getStringList('Bookmarks') == null) return false;
  //   return sharedPreferences.getStringList('Bookmarks').isNotEmpty;
  // }
  //
  // List<String> getBookmarkedNeedies() {
  //   return sharedPreferences.getStringList('Bookmarks');
  // }
}
