import 'package:ahed/Models/User.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Models/User.dart';

class SessionManager {
  late SharedPreferences? sharedPreferences;
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
    this.accessTokenExpireDate = expiryDate;
    print(user.toList());
    sharedPreferences!.setStringList('user', user.toList());
    sharedPreferences!.setString('accessToken', accessToken);
    sharedPreferences!.setString('expiryDate', expiryDate.toString());
  }

  loadSession() {
    accessTokenExpireDate =
        DateTime.parse(sharedPreferences!.getString('expiryDate')!);
    if (accessTokenExpireDate!.isBefore(DateTime.now())) {
      logout();
    }
    accessToken = sharedPreferences!.getString('accessToken')!;
    List<String> userData = sharedPreferences!.getStringList('user')!;
    user = new User(
        userData[0],
        userData[1],
        userData[2],
        userData[3],
        userData[4],
        userData[5],
        userData[6],
        //ToDo: Review
        userData[7] == "true" ? true : false,
        userData[8],
        userData[9],
        userData[10]);
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
    return accessTokenExpireDate!.isBefore(DateTime.now());
  }

  logout() {
    this.user = null;
    this.accessToken = null;
    this.accessTokenExpireDate = null;
    sharedPreferences!.remove('accessTokenExpireDate');
    sharedPreferences!.remove('accessToken');
    sharedPreferences!.remove('user');
  }

  void changeUserInfo(String bio, String address, String phoneNumber) {
    this.user!.profileBio = bio;
    this.user!.address = address;
    this.user!.phoneNumber = phoneNumber;
    sharedPreferences!.setStringList('user', user!.toList());
    List<String> userData = sharedPreferences!.getStringList('user')!;
    user = new User(
        userData[0],
        userData[1],
        userData[2],
        userData[3],
        userData[4],
        userData[5],
        userData[6],
        //ToDo: Review
        userData[7] == "true" ? true : false,
        userData[9],
        userData[10],
        userData[11]);
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
