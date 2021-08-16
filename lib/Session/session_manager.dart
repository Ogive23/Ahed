import 'package:ahed/Models/User.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Models/User.dart';

class SessionManager {
  late SharedPreferences? sharedPreferences;
  User? user;
  DateTime? accessTokenExpireDate;

  SessionManager._privateConstructor();
  static final SessionManager _instance = SessionManager._privateConstructor();
  factory SessionManager() {
    return _instance;
  }

  getSessionManager() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  createSession(User user, DateTime accessTokenExpiryDate) {
    this.user = user;
    print(user.toList());
    sharedPreferences!.setStringList('user', user.toList());
    sharedPreferences!.setString(
        'accessTokenExpireDate', accessTokenExpiryDate.toString());
  }

  loadSession() {
    accessTokenExpireDate =
        DateTime.parse(sharedPreferences!.getString('accessTokenExpireDate')!);
    if (accessTokenExpireDate!.isBefore(DateTime.now())) {
      logout();
    }
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
        userData[10],
        userData[11]);
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
    this.accessTokenExpireDate = null;
    sharedPreferences!.remove('accessTokenExpireDate');
    sharedPreferences!.remove('user');
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
